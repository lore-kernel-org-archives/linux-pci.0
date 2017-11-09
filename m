Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33591 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdKIKZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 05:25:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so1635981wmr.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Nov 2017 02:25:10 -0800 (PST)
MIME-Version: 1.0
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Thu, 9 Nov 2017 15:55:09 +0530
Message-ID: <CAFZiPx1x9irvXCm7W9t_VjGnw2VLPhptO8WfuRXPd1jpcBU2Sw@mail.gmail.com>
Subject: [PATCH 1/2] PCI: Mobiveil: export irq_set_msi_desc symbol
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Peter W Newton <peter.newton@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From e38b741006856f3a3623109dd5ddf5f99326ce61 Mon Sep 17 00:00:00 2001
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Thu, 9 Nov 2017 04:25:21 -0500
Subject: [PATCH 1/2] PCI: Mobiveil: export irq_set_msi_desc symbol

This patch exports irq_set_msi_desc symbol which is used by
few PCIe root port drivers.
Tested against kernel : 4.9.0-xilinx-v2017.2.

Cc: bhelgaas@google.com
Cc: tglx@linutronix.de

Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
 kernel/irq/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index be3c34e..c4222c4 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -137,6 +137,7 @@ int irq_set_msi_desc(unsigned int irq, struct
msi_desc *entry)
  return irq_set_msi_desc_off(irq, 0, entry);
 }

+EXPORT_SYMBOL(irq_set_msi_desc);
 /**
  * irq_set_chip_data - set irq chip data for an irq
  * @irq: Interrupt number
-- 
1.8.3.1
