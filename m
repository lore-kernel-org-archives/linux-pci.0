Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44572 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab1K0RZI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 27 Nov 2011 12:25:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1RUiTR-0007wn-QJ
	for linux-pci@vger.kernel.org; Sun, 27 Nov 2011 18:25:05 +0100
Received: from 209.243.128.157 ([209.243.128.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 27 Nov 2011 18:25:05 +0100
Received: from bhavin.patel by 209.243.128.157 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 27 Nov 2011 18:25:05 +0100
To: linux-pci@vger.kernel.org
From: Bhavin Patel <bhavin.patel@einfochips.com>
Subject: How to map multiple ISRs with a PCI device generating multiple MSIs?
Date: Sun, 27 Nov 2011 17:21:51 +0000 (UTC)
Message-ID: <loom.20111127T181943-184@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

Please help if you have any idea.

Brief description of my system and software:
We have intel x86 processor connected with our system via PCIe bus. Our system
is visible as bus XX, device YY and function Z from x86. We are using RHEL 6.1
as OS on x86. Our system (basically a PCIe device for x86), supports 32
interrupt sources. Whenever there is any interrupt, an MSI will be passed to x86
local IOAPIC as a unique MSI. So there can be 32 MSIs from my single PCI device.
I made a Linux PCI device driver for this device. I have enabled MSI using
pci_enable_msi and registered an IRQ accordingly with an ISR.

Question:
When MSI is received at x86 PCI device driver (and ISR is called), how do I
verify that the IRQ is for which MSI? I thought of using pci_enable_msi_block()
but the question remains the same. How do the ISR in PCI device driver knows
that it is being called for which MSI?How can I register separate 32 ISRs for my
PCI device? Moreover in existing Linux kernel, I don't see any driver using
pci_enable_msi_block(). If you have any open source code to understand it's
usage, that will be a great help.

Thanks for any response from any of you.

- Bhavin

