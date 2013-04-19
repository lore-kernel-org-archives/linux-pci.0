Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from snt0-omc4-s31.snt0.hotmail.com ([65.55.90.234]:34046 "EHLO
	snt0-omc4-s31.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967698Ab3DSDFU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Apr 2013 23:05:20 -0400
Message-ID: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl>
From: Frank Rizzo <thefrankrizzo@hotmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Rescan PCIE bus to find recently powered on device.
Date: Thu, 18 Apr 2013 19:59:11 -0700
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey list.

I'm working on a driver for a device that's external from the PC.  It's connected to the PC via a weird cable that connects to a PCIE card inside the case that appears to be nothing other than glue logic to allow the signals from the cable to be tossed onto the bus.

When the external device is powered off during boot, nothing is found.  hwinfo doesn't find it, lspci doesn't find it, etc.  If you power on the device BEFORE booting, everything is found, and it works fine.  And lastly, if you power it on AFTER Linux has booted, you still can't find it.  I've tried echoing "1" to rescan, and everything else that I could find via Google search.

So, what are my options here?  I'm not allergic to adding code to the driver to scan for the device periodically, if I knew HOW to find it.  And, once found, how do I get it registered?


Thanks! 		 	   		  