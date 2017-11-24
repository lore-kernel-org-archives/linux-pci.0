Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3845 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753646AbdKXPyJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 10:54:09 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 01/10] genirq: Export irq_set_msi_desc()
Date: Fri, 24 Nov 2017 21:23:11 +0530
Message-ID: <1511538800-8275-2-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI bus support MSI interrupts, allow PCI host driver to set MSI descriptor
data for an irq.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 kernel/irq/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 5a2ef92c2782..bfbd17386bc4 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -136,6 +136,7 @@ int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
 {
 	return irq_set_msi_desc_off(irq, 0, entry);
 }
+EXPORT_SYMBOL(irq_set_msi_desc);
 
 /**
  *	irq_set_chip_data - set irq chip data for an irq
-- 
2.1.4
