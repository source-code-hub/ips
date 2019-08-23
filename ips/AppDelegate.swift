//
//  AppDelegate.swift
//  ips
//
//  Created by Amit Singh on 22/08/19.
//  Copyright © 2019 Amit Singh. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var ipMenu: NSMenu!
	let ipMenuItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
	
	@IBOutlet weak var localIPMenuItem: NSMenuItem!
	@IBOutlet weak var publicIpMenuItem: NSMenuItem!
	
	@IBAction func onQuit(_ sender: NSMenuItem) {
		NSApplication.shared.terminate(self)
	}
	
	@IBAction func onCopy(_ sender: NSMenuItem) {
		copyToCB(data:String(sender.title.split(separator:":")[1]))
	}
	
	func copyToCB(data: String) {
		// Set string
		NSPasteboard.general.clearContents()
		NSPasteboard.general.setString(data, forType: .string)
		// Read copied string
		NSPasteboard.general.string(forType: .string)
	}
	
	func getLANIP() -> String? {
		let host = Host.current()
		for address in host.addresses {
			if address.starts(with: "192."){
				return address
			}
		}
		return nil
	}
	
	func getPublicIP() -> String? {
		
		if let url = URL(string: "https://api.ipify.org/") {
			do {
				return try String(contentsOf: url)
			} catch {
				// contents could not be loaded
			}
		}
		return nil
	}
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		ipMenuItem.button?.title = getLANIP() ?? "Ip"
		ipMenuItem.menu = ipMenu
		
		localIPMenuItem.title.append(getLANIP() ?? "")
		publicIpMenuItem.title.append(getPublicIP() ?? "")
		
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

