Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0066.outbound.protection.outlook.com ([104.47.38.66]:14131
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750853AbcGLG5Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 02:57:16 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>
Subject: Purpose of pci_remap_iospace
Date: Tue, 12 Jul 2016 06:57:10 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B85DC@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have a query.

Can any once explain the purpose of pci_remap_iospace function in root port driver.

What is its dependency with architecture ?

Here is my understanding, the above API takes PCIe IO resource and its to be mapped CPU address from
ranges property and remaps into virtual address space.

So my question is who uses this virtual addresses ?

When End Point requests for IO BARs doesn't it get from the above resource range (first parameter of API) and
do ioremap to access this region ?

But why root complex driver is mapping this address region ?

Please correct me if my understanding is wrong.

Regards,
Bharat




This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

