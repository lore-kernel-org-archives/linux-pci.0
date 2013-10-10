Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:34858
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755926Ab3JJTTf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Oct 2013 15:19:35 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>
Subject: pre-configuring PCIe switch
Date: Thu, 10 Oct 2013 19:19:29 +0000
Message-ID: <3036fa5270dc4ede90e60abdbe6f0b57@BLUPR05MB118.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

For the purposes of hot-plug, I want to configure my PCI Express's switch's downstream port capabilities before enumeration. (I am currently interested in setting "Slot Implemented", "hot-plug capable" and "physical slot number". But in future, this may also come in handy to configure some downstream ports as non-transparent). These registers seem to be only writable via an external EEPROM (which is not populated), or an I2C bus. Thus PCI quirks cannot be used. What is the best way to achieve this? 

I'm thinking of configuring over I2C before the PCI enumeration begins. My question is how do I ensure that the I2C subsystem is ready to be used, before the PCI subsystem is scanned by the kernel? (This is a Powerpc system, no ACPI or BIOS) Is it OK to use I2C bus at such an early stage in boot up, for purposes like this?

Thanks,

Rajat

