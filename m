Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0147.outbound.protection.outlook.com ([157.56.111.147]:57207
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754432AbaJMSrb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Oct 2014 14:47:31 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>
CC: Guenter Roeck <groeck@juniper.net>
Subject: Reducing dependence on BIOS for allocating memory at PCI root port?
Date: Mon, 13 Oct 2014 18:32:04 +0000
Message-ID: <e192566903fe4b5eb9903e3b6c49a2e8@DM2PR05MB671.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I have huge hot-plug systems that can have hundreds of hot plug PCI slots that may not be populated at the boot time. Since BIOS doesn't see all devices could be plugged in, so we ask it to hard code and allocate a fixed chunk of memory space (say 4 GB) for PCI at the root port.

Now as we keep on developing new add-on cards with more PCI memory requirements - we have a problem because we need to increase that root port allocation. While asking the BIOS vendor to increase the memory for new releases is an option, I am in general thinking if there is a way to do this without depending on the BIOS allocation at all. We don't want to upgrade BIOS for just this. I'm hopeful this is a common problem - so I wanted to ask if there are there existing mechanisms that allow / instruct the kernel to ignore the BIOS allocations, and reprogram the PCI host controllers, (by maybe a kernel configuration or command line parameters etc for example).

My question is whether some thing exists (or if it makes sense)?

Thanks,

Rajat

PS: The immediate thought of device tree comes to mind - but what about architectures that don't support it yet. (FWIW - I'm using x86 - and I do not know if its host controller driver supports / will support any device tree options to specify PCI windows)

