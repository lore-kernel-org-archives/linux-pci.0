Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13824 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbdKYTcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Nov 2017 14:32:45 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 1/9] genirq: Export irq_set_msi_desc()
Date: Sun, 26 Nov 2017 01:02:05 +0530
Message-ID: <1511638333-22951-2-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI MSI driver allocates MSI entry for each pci dev which creates msi_desc,
host driver maps each msi domain with hwirq and then sets msi_desc for
that irq number. Need to export irq_set_msi_desc() to allow Tegra PCIe
driver to be compiled as a loadable kernel module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* commit message update

 kernel/irq/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 043bfc35b353..0e74b1051267 100644
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
