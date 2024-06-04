//
//  SettingsViewController.swift
//  StickerMaker
//
//  Created by Fatih on 4.06.2024.
//

import Foundation
import UIKit
import MessageUI

class SettingsViewController: UIViewController {
    
    //MARK: - Properties
    var settingsView = SettingsView()
    let emailSubject = "STCKR"
    let emailBody = "Please provide information that will helpus to serve you better.\nVersion 1.0"
    let toEmails = ["af.alkanfatih@gmail.com"]
    let fromEmail = "af.alkanfatih@gmail.com"
    let images: [UIImage] = [
    UIImage(named: "1")!,
    UIImage(named: "2")!
    ]
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        settingsView.delegate = self
        
    }
    
    private func showMailCompser(_ subject: String,_ body: String,_ toEmails: [String],_ fromEmail: String,_ images: [UIImage]) {
        guard MFMailComposeViewController.canSendMail() else {
            print("canSendMail Failure")
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setSubject(subject)
        composer.setMessageBody(body, isHTML: false)
        composer.setToRecipients(toEmails)
        composer.setPreferredSendingEmailAddress(fromEmail)
        
        for image in images {
            let fileName = Int.random(in: 0...5000).description + ".jpeg"
            let imageData = image.jpegData(compressionQuality: 1)!
            composer.addAttachmentData(imageData, mimeType: "image/jpg", fileName: fileName)
        }
        present(composer, animated: true,completion: nil)
    }
}

//MARK: - MFMailComposeViewControllerDelegate
extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print("DEBUG PRINT:", "didFinishWithError", error)
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
    func clickedSendFeedBack() {
        self.showMailCompser(emailSubject, emailBody, toEmails, fromEmail, images)
    }
    
    func clickedShareApp() {
        let text = "Uygulamayı denemelisiniz!"
        guard let image = UIImage(named: "stckr") else { return }
        guard let url = URL(string: "https://github.com/fatihalkn") else { return }
        let activityViewController = UIActivityViewController(activityItems: [text, image, url], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
