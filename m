Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54827 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdLNCWT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Dec 2017 21:22:19 -0500
From: <cao.zou@windriver.com>
To: <jingoohan1@gmail.com>
CC: <Joao.Pinto@synopsys.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: designware: add a check of msi_desc in irqchip
Date: Thu, 14 Dec 2017 10:21:22 +0800
Message-ID: <1513218083-5461-1-git-send-email-cao.zou@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

----------------------------------------------------
Summary:  PCI: designware: add a check of msi_desc in irqchip
Reviewers: paul
----------------------------------------------------

Upstream Project Name: linux-kernel
Upstream Project URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
Applies to: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
Brief Description: Incorrect mask bits leave device stalled after flood ping.
Will Submit to: shan lai <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Origin of patch: Discovered by me while working on common_pc
IP content: None, trivial obvious fix.

Comments:
---------

this issue is reproduced in imx7d-sdb when running the kdump with pluging Intel 1030 PCI,
the root caused is machine_kexec_mask_interrupts will force to mask every exist irq_desc
include msi irq.

background:
msi irq mask is based on msi_desc, it is bound only in msi irq setup by pci driver.
for others not request msi irqs by pci driver, its msi_desc is null, so crash in
machine_kexec_mask_interrupts. 
