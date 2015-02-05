Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0141.outbound.protection.outlook.com ([157.56.110.141]:59629
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751134AbbBEU3b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Feb 2015 15:29:31 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Hotplug of root PCI buses
Date: Thu, 5 Feb 2015 18:57:13 +0000
Message-ID: <DM2PR0301MB1232D810A8C459B890B4AAA8AB3B0@DM2PR0301MB1232.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As mentioned in a message a couple of months ago, I'm building a front-end driver which makes a root PCI bus appear in a Hyper-V VM, whenever a user decides to pass through a device.  This can happen while the VM runs, as when SR-IOV networking becomes available (maybe the VM migrated to a host which had free Virtual Functions) or when the user decides to pass through a discrete physical device.

In Hyper-V, this is modeled as mapping a single function (unless the device itself is made up of multiple inseparable functions) into the VM, without any surrounding emulation of a root PCI bus or any bridges.  In software, this looks like a new root PCI bus had been added to the system, with its own region of memory space, and a single device sits on it, the one that has been passed through.

My question is about how resources are assigned to PCI devices in Linux.  What I'm seeing is a failure to bring the device's driver into the working state because the BARs of the device are zeroed.  An example error message looks like this:

[  190.960703] megaraid_sas 8e1b:00:00.0: can't enable device: BAR 1 [mem 0x00000000-0x00003fff 64bit] not claimed

What is supposed to trigger the resource assignment code?  I see it in the code base, called when a hot-plug bridge brings a new device on line.  But I'm not sure how or when I should attempt to trigger it when I'm essentially hot-plugging a root bus.

If anybody has any suggestion about how I should approach this problem architecturally, I would appreciate that.

Thanks,
Jake Oshins
Microsoft

