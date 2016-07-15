Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0063.outbound.protection.outlook.com ([104.47.36.63]:60032
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751048AbcGOI34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2016 04:29:56 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Memory and IO space Enabling different in x86 and ARM64
Date: Fri, 15 Jul 2016 08:29:49 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B9376@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I observe that memory and IO space are enabled by BIOS in x86.

In ARM64 we need to call pci_enable_device form End Point to enable these resources.

Why the resource enablement is different in x86 and ARM64 ?

Please correct me if my observation is wrong.

Thanks & Regards,
Bharat


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

