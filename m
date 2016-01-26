Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0102.outbound.protection.outlook.com ([157.55.234.102]:5527
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751167AbcAZGNY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2016 01:13:24 -0500
From: Ramon Fried <ramon.fried@tandemg.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Acquiring MSI vector physical address from kernel driver 
Date: Tue, 26 Jan 2016 05:58:38 +0000
Message-ID: <AM2PR02MB0689EA90BFB7B2C5878CDDC0E8D80@AM2PR02MB0689.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi.
I'm currently developing a driver for a new PCIe device.
The specific PCIe device includes an embedded DMA engine that can be accessed by the host through the PCI configuration space on specific offset.
The DMA engine can trigger a MSI on DMA complete if the physical address of the actual vector is written to it.

I did some reading, and if I'm not mistaken, it appears that the kernel writes the physical address to the PCI device configuration space when enabling MSI.
I didn't find any API or an easy way of getting that address from the kernel given only the MSI number (ID).
I can read it (the PA) back from the PCI configuration space, but it seems wrong, as:
1. The kernel has written this value before, it should know this already. 
2. Nobody else has done it (grepped the kernel for that)

Am I right in my observations ? Is there a better way to achieve that ?

Thanks,
Ramon
