Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm22.bullet.mail.bf1.yahoo.com ([98.139.212.181]:20178 "HELO
	nm22.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753062Ab2EPC5y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 May 2012 22:57:54 -0400
Message-ID: <1337136686.80168.YahooMailNeo@web160302.mail.bf1.yahoo.com>
Date: Tue, 15 May 2012 19:51:26 -0700 (PDT)
From: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Reply-To: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Subject: Hotplug Debugging
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have a Gigabyte Motherboard and I am trying to hot remove and hot add a Marvell's PCI SATA controller card, but it doesn't work. I am using 3.2.17 kernel with hotplug configured. Also, I turned the debug messages by using pciehp_debug=1 and am forcibly loading the module by using pciehp_force=1. However I don't see any debug messages from the pciehp driver, besides the following - 

pciehp: PCI Express Hot Plug Controller Driver version: 0.4
I don't see any other message suggesting that the absence of hotplug controller. 

I have basic questions -
1. How do I find out, for sure, if the board has hot plug controller? Also, is there a way to find out if a particular slot is hotpluggable?
2. The lspci -vv output of the root port and the device shows that "ASPM  disabled". Is this the indication that it doesn't support hotplug?
3. Also in some of the posts it talks about /sys/bus/pci/slots/<device>/power, however, on my system the slots directory is empty!? Does it mean I don't have the hotpluggable system?

regards,
Ushma. 
