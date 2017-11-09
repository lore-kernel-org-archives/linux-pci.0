Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:49083 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbdKIMDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 07:03:00 -0500
Received: by mail-pf0-f193.google.com with SMTP id b79so4113540pfk.5
        for <linux-pci@vger.kernel.org>; Thu, 09 Nov 2017 04:03:00 -0800 (PST)
Subject: [PATCH 1/2 v2] PCI: Mobiveil: export irq_set_msi_desc symbol
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Peter W Newton <peter.newton@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>, tglx@linutronix.de
References: <CAFZiPx1x9irvXCm7W9t_VjGnw2VLPhptO8WfuRXPd1jpcBU2Sw@mail.gmail.com>
From: subrahmanya_lingappa <l.subrahmanya@mobiveil.co.in>
Message-ID: <697da40c-7cdd-3d05-5846-37eae31bb729@mobiveil.co.in>
Date: Thu, 9 Nov 2017 17:33:12 +0530
MIME-Version: 1.0
In-Reply-To: <CAFZiPx1x9irvXCm7W9t_VjGnw2VLPhptO8WfuRXPd1jpcBU2Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 From e38b741006856f3a3623109dd5ddf5f99326ce61 Mon Sep 17 00:00:00 2001
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Thu, 9 Nov 2017 04:25:21 -0500
Subject: [PATCH 1/2 v2] PCI: Mobiveil: export irq_set_msi_desc symbol

This patch exports irq_set_msi_desc symbol which is used by
few PCIe root port drivers.

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
   *	irq_set_chip_data - set irq chip data for an irq
   *	@irq:	Interrupt number
-- 
1.8.3.1
