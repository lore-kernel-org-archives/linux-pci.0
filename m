Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0078.outbound.protection.outlook.com ([104.47.38.78]:41520
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757302AbcGKCho convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2016 22:37:44 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>
Subject: PCIe MSI address is not written at pci_enable_msi_range call
Date: Mon, 11 Jul 2016 02:37:37 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B8102@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have a query.
I see that when we use PCI_MSI_IRQ_DOMAIN to handle MSI's, MSI address is not being
written in to end point's PCI_MSI_ADDRESS_LO/HI at the call pci_enable_msi_range.

Instead it is being written at the time end point requests irq.

Can any one tell the reason why is it handled in this manner ?

Correct me If my observation is wrong.

Thanks & Regards,
Bharat


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

