Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v3 1/7] PCI/AER: Clear only ERR_FATAL status bits during
 fatal recovery
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 18 Jul 2018 14:44:25 -0500
Message-ID: <153194306515.191586.15135574361122079715.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

During recovery from fatal errors, we previously called
pci_cleanup_aer_uncorrect_error_status(), which cleared *all* uncorrectable
error status bits (both ERR_FATAL and ERR_NONFATAL).

Instead, call a new pci_aer_clear_fatal_status() that clears only the
ERR_FATAL bits (as indicated by the PCI_ERR_UNCOR_SEVER register).

Based-on-patch-by: Oza Pawandeep <poza@codeaurora.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      |    4 ++++
 drivers/pci/pcie/aer.c |   17 +++++++++++++++++
 drivers/pci/pcie/err.c |    2 +-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a07f3f..12fd2ac95843 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -452,4 +452,8 @@ static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_PCIEAER
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..5b4a84e3d360 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -374,6 +374,23 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
 
+void pci_aer_clear_fatal_status(struct pci_dev *dev)
+{
+	int pos;
+	u32 status, sev;
+
+	pos = dev->aer_cap;
+	if (!pos)
+		return;
+
+	/* Clear status bits for ERR_FATAL errors only */
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
+	status &= sev;
+	if (status)
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+}
+
 int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 {
 	int pos;
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb0b0b7..0539518f9861 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -316,7 +316,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		 * do error recovery on all subordinates of the bridge instead
 		 * of the bridge and clear the error status of the bridge.
 		 */
-		pci_cleanup_aer_uncorrect_error_status(dev);
+		pci_aer_clear_fatal_status(dev);
 	}
 
 	if (result == PCI_ERS_RESULT_RECOVERED) {
