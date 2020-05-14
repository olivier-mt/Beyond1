//
//  AppDelegate.swift
//  FIRSTTRY
//
//  Created by Olivier Mountou on 21/09/2019.
//  Copyright © 2019 Olivier Mountou MT. All rights reserved.
//

import UIKit
import Firebase
import InstantSearchClient
import UserNotificationsUI


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"


    let userDefault = UserDefaults.standard
    let launchedBefore = UserDefaults.standard.bool(forKey: "usersignedin")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        UNUserNotificationCenter.current().delegate = self
        
        
        if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })}
    else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
        
    
        Messaging.messaging().delegate = self
    
        
        application.registerForRemoteNotifications()
        

        
        
        if let option = launchOptions {
            let info = option[UIApplication.LaunchOptionsKey.remoteNotification]
            if (info != nil) {
        }}
        
        
      
        
        
        
        FirebaseApp.configure()
        
        let myDatabase = Database.database().reference()
        return true
   
        
        
    }
    
    
   
   func goAnotherVC() {
      
       let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let conversationVC = storyboard.instantiateViewController(withIdentifier: "conversationVC") as! ConversationViewController
                 let navigationController = UINavigationController.init(rootViewController: conversationVC)
                 self.window?.rootViewController = navigationController
                 self.window?.makeKeyAndVisible()
    
   }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)
   goAnotherVC()
      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
     //  Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
        
        
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
        
        
        //  goAnotherVC()
        
    }
    
    
    
}





@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    
    let groupIdNumber =  userInfo["groupIdNumber"]
    let groupName = userInfo["name"]
    let fromNotif = userInfo["fromNotif"]
    
    print("Notifdico: \(userInfo)")
    
    let gid = groupIdNumber as! String
    let gname = groupName as! String
    let checkNotif = fromNotif as! String
    
    

    // Print full message.
    print(userInfo)
    
    // GO TO CONVERSATION VIEW CONTROLER
    
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
   // let navigationVC = storyboard.instantiateViewController(withIdentifier: "ROOTVC") as? UINavigationController
    
     let conversationVC = storyboard.instantiateViewController(withIdentifier: "conversationVC") as! ConversationViewController
        
  //  let secondNavController = storyboard.instantiateViewController(withIdentifier: "secondNavController") as! UINavigationController

  //  let firstNavController = storyboard.instantiateViewController(withIdentifier: "ROOTVC") as! UINavigationController
    
     let secondNavController = storyboard.instantiateViewController(withIdentifier: "secondNavController") as! UINavigationController
    
    let tabBarVC = storyboard.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
        
          //  conversationVC.finalGroup = gid
        //    conversationVC.groupName = gname
    
    window?.rootViewController = tabBarVC
    
    
    tabBarVC.selectedViewController = tabBarVC.viewControllers![1]


    //secondNavController.pushViewController(conversationVC, animated: false)
    
    let navController = tabBarVC.selectedViewController as? UINavigationController
        
    conversationVC.finalGroup = gid
    conversationVC.groupName = gname
    conversationVC.fromNotif = checkNotif

    navController?.pushViewController(conversationVC, animated: false)
        
    

       completionHandler()
    
 //   for child in (firstNavController.children) {
 //       child.restorationIdentifier = "secondNavController"/*{
 //       let FollowedViewController = (child.children[0]) as! FollowedViewController
 //       let conversationVC = storyboard.instantiateViewController(withIdentifier: "conversationVC") as! ConversationViewController
        

  //     conversationVC.finalGroup = gid

       // FollowedViewController.navigationController!.pushViewController(conversationVC, animated: false)
        
   //     print("done")*/
        
       }
        

    
    
  // secondNavController.pushViewController(conversationVC, animated: false)

    
    
    
    
    }
    

        
        //navController.pushViewController(conversationVC, animated: true)
    


    
    
    
                 //  let navigationController = UINavigationController.init(rootViewController: conversationVC)
                 //  self.window?.rootViewController = navigationController
                 //  self.window?.makeKeyAndVisible()
    
    // SPECIFIED VC FROM PUSH NOTIFICATION
    

 
   
//}
  


extension AppDelegate : MessagingDelegate {
    
    
    // GO TO CONV VC
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Message data", remoteMessage.appData)
        goAnotherVC()
    }
    
}

/* extension AppDelegate : MessagingDelegate {
      
      func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")

        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
      }*/



    



