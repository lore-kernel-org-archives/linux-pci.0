Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34350 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933377AbbLGVci (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Dec 2015 16:32:38 -0500
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv6 4/7] x86-pci: allow pci domain specific dma ops
Date: Mon,  7 Dec 2015 14:32:26 -0700
Message-Id: <1449523949-21898-5-git-send-email-keith.busch@intel.com>
In-Reply-To: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

New x86 pci h/w will require dma operations specific to that domain. This
patch allows those domains to register their operations, and sets devices
as they are discovere3d in that domain to use them.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/include/asm/device.h | 10 ++++++++++
 arch/x86/pci/common.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index 03dd729..3b23897 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -10,6 +10,16 @@ struct dev_archdata {
 #endif
 };
 
+#if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
+struct dma_domain {
+	struct list_head node;
+	struct dma_map_ops *dma_ops;
+	int domain_nr;
+};
+extern void add_dma_domain(struct dma_domain *domain);
+extern void del_dma_domain(struct dma_domain *domain);
+#endif
+
 struct pdev_archdata {
 };
 
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index eccd4d9..106fd13 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -641,6 +641,43 @@ unsigned int pcibios_assign_all_busses(void)
 	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
 }
 
+#if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
+LIST_HEAD(dma_domain_list);
+DEFINE_SPINLOCK(dma_domain_list_lock);
+
+void add_dma_domain(struct dma_domain *domain)
+{
+	spin_lock(&dma_domain_list_lock);
+	list_add(&domain->node, &dma_domain_list);
+	spin_unlock(&dma_domain_list_lock);
+}
+EXPORT_SYMBOL_GPL(add_dma_domain);
+
+void del_dma_domain(struct dma_domain *domain)
+{
+	spin_lock(&dma_domain_list_lock);
+	list_del(&domain->node);
+	spin_unlock(&dma_domain_list_lock);
+}
+EXPORT_SYMBOL_GPL(del_dma_domain);
+
+static void set_dma_domain_ops(struct pci_dev *pdev)
+{
+	struct dma_domain *domain;
+
+	spin_lock(&dma_domain_list_lock);
+	list_for_each_entry(domain, &dma_domain_list, node) {
+		if (pci_domain_nr(pdev->bus) == domain->domain_nr) {
+			pdev->dev.archdata.dma_ops = domain->dma_ops;
+			break;
+		}
+	}
+	spin_unlock(&dma_domain_list_lock);
+}
+#else
+static void set_dma_domain_ops(struct pci_dev *pdev) {}
+#endif
+
 int pcibios_add_device(struct pci_dev *dev)
 {
 	struct setup_data *data;
@@ -670,6 +707,7 @@ int pcibios_add_device(struct pci_dev *dev)
 		pa_data = data->next;
 		iounmap(data);
 	}
+	set_dma_domain_ops(dev);
 	return 0;
 }
 
-- 
2.6.2.307.g37023ba

