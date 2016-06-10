Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0051.outbound.protection.outlook.com ([104.47.38.51]:1120
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752101AbcFJPjW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2016 11:39:22 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: PCIe EndPoint DMA driver with DMA Framework
Date: Fri, 10 Jun 2016 15:39:15 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B267B@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

We are planning to write a PCIe EndPoint DMA driver with DMA Framework targeting x86 machine.  ( "https://www.kernel.org/doc/Documentation/dmaengine/provider.txt")
Our DMA controller is part of PCIe End Point.
We are targeting to measure PCIe performance with this Framework driver.

But when I see DMA Framework drivers is kernel source "drivers/dma" most of the drivers are platform drivers.

So DMA Framework is mainly targeted for platform drivers?

With current design model we need to have one DMA controller driver and PCIe EP client driver?

In which part of kernel source PCIe EP client driver will go?

Can we use DMA Framework on x86 ?

Thanks & Regards,
Bharat



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

