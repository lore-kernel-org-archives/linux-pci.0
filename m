Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:53419 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaIWFDQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 01:03:16 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 6/9] PCI/MSI: Rename __get_cached_msi_msg() to get_cached_msi_msg()
Date: Tue, 23 Sep 2014 13:27:27 +0800
Message-ID: <1411450050-1510-7-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
References: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename __get_cached_msi_msg() to get_cached_msi_msg().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/ia64/kernel/msi_ia64.c    |    2 +-
 arch/ia64/sn/kernel/msi_sn.c   |    2 +-
 arch/x86/kernel/apic/io_apic.c |    2 +-
 drivers/pci/msi.c              |    2 +-
 include/linux/msi.h            |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
index 8c3730c..4efe748 100644
--- a/arch/ia64/kernel/msi_ia64.c
+++ b/arch/ia64/kernel/msi_ia64.c
@@ -23,7 +23,7 @@ static int ia64_set_msi_irq_affinity(struct irq_data *idata,
 	if (irq_prepare_move(irq, cpu))
 		return -1;
 
-	__get_cached_msi_msg(idata->msi_desc, &msg);
+	get_cached_msi_msg(idata->msi_desc, &msg);
 
 	addr = msg.address_lo;
 	addr &= MSI_ADDR_DEST_ID_MASK;
diff --git a/arch/ia64/sn/kernel/msi_sn.c b/arch/ia64/sn/kernel/msi_sn.c
index 446e779..8bec242 100644
--- a/arch/ia64/sn/kernel/msi_sn.c
+++ b/arch/ia64/sn/kernel/msi_sn.c
@@ -175,7 +175,7 @@ static int sn_set_msi_irq_affinity(struct irq_data *data,
 	 * Release XIO resources for the old MSI PCI address
 	 */
 
-	__get_cached_msi_msg(data->msi_desc, &msg);
+	get_cached_msi_msg(data->msi_desc, &msg);
 	sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
 	pdev = sn_pdev->pdi_linux_pcidev;
 	provider = SN_PCIDEV_BUSPROVIDER(pdev);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 29290f5..e877cfb 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3145,7 +3145,7 @@ msi_set_affinity(struct irq_data *data, const struct cpumask *mask, bool force)
 	if (ret)
 		return ret;
 
-	__get_cached_msi_msg(data->msi_desc, &msg);
+	get_cached_msi_msg(data->msi_desc, &msg);
 
 	msg.data &= ~MSI_DATA_VECTOR_MASK;
 	msg.data |= MSI_DATA_VECTOR(cfg->vector);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index fa66e2f..8746ecd 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -296,7 +296,7 @@ void read_msi_msg(unsigned int irq, struct msi_msg *msg)
 	__read_msi_msg(entry, msg);
 }
 
-void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
+void get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	/* Assert that the cache is valid, assuming that
 	 * valid messages are not all-zeroes. */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 3fae781..329ec73 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -16,7 +16,7 @@ struct msi_desc;
 void mask_msi_irq(struct irq_data *data);
 void unmask_msi_irq(struct irq_data *data);
 void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void read_msi_msg(unsigned int irq, struct msi_msg *msg);
 void write_msi_msg(unsigned int irq, struct msi_msg *msg);
-- 
1.7.1

