Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44630 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbeGQRf7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jul 2018 13:35:59 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 17 Jul 2018 11:02:03 -0600
Message-Id: <20180717170204.30470-4-logang@deltatee.com>
In-Reply-To: <20180717170204.30470-1-logang@deltatee.com>
References: <20180717170204.30470-1-logang@deltatee.com>
Subject: [PATCH v7 3/4] PCI: Introduce disable_acs_redir quirk
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel SPT PCH hardware has an implementation of the ACS bits that
does not comply with the PCI express standard. To deal with this
the existing code has an enable_acs() quirk for the hardware.

In order to be able to correctly disable the ACS redirect bits for
all hardware we need an analagous quirk to disable those bits.

This adds the function pci_dev_specific_disable_acs_redir() which
behaves similarly to pci_dev_specific_enable_acs() but uses a new
function pointer for quirks which disables the ACS redirect bits.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/quirks.c | 78 ++++++++++++++++++++++++++++++++++++++++++++--------
 include/linux/pci.h  |  5 ++++
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de848658..414b22dc06b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4553,27 +4553,81 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	return 0;
 }
 
-static const struct pci_dev_enable_acs {
+static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
+{
+	int pos;
+	u32 cap, ctrl;
+
+	if (!pci_quirk_intel_spt_pch_acs_match(dev))
+		return -ENOTTY;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return -ENOTTY;
+
+	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
+	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
+
+	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+
+	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
+
+	pci_info(dev, "Intel SPT PCH root port workaround: disabled ACS redirect\n");
+
+	return 0;
+}
+
+static const struct pci_dev_acs_ops {
 	u16 vendor;
 	u16 device;
 	int (*enable_acs)(struct pci_dev *dev);
-} pci_dev_enable_acs[] = {
-	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_enable_intel_pch_acs },
-	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_enable_intel_spt_pch_acs },
-	{ 0 }
+	int (*disable_acs_redir)(struct pci_dev *dev);
+} pci_dev_acs_ops[] = {
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	  .enable_acs = pci_quirk_enable_intel_pch_acs,
+	},
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	  .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
+	  .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir
+	},
 };
 
 int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
-	const struct pci_dev_enable_acs *i;
+	const struct pci_dev_acs_ops *p;
+	int i;
 	int ret;
 
-	for (i = pci_dev_enable_acs; i->enable_acs; i++) {
-		if ((i->vendor == dev->vendor ||
-		     i->vendor == (u16)PCI_ANY_ID) &&
-		    (i->device == dev->device ||
-		     i->device == (u16)PCI_ANY_ID)) {
-			ret = i->enable_acs(dev);
+	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
+		p = &pci_dev_acs_ops[i];
+		if ((p->vendor == dev->vendor ||
+		     p->vendor == (u16)PCI_ANY_ID) &&
+		    (p->device == dev->device ||
+		     p->device == (u16)PCI_ANY_ID) &&
+		    p->enable_acs) {
+			ret = p->enable_acs(dev);
+			if (ret >= 0)
+				return ret;
+		}
+	}
+
+	return -ENOTTY;
+}
+
+int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *p;
+	int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
+		p = &pci_dev_acs_ops[i];
+		if ((p->vendor == dev->vendor ||
+		     p->vendor == (u16)PCI_ANY_ID) &&
+		    (p->device == dev->device ||
+		     p->device == (u16)PCI_ANY_ID) &&
+		    p->disable_acs_redir) {
+			ret = p->disable_acs_redir(dev);
 			if (ret >= 0)
 				return ret;
 		}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..3b61068dc7d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1878,6 +1878,7 @@ enum pci_fixup_pass {
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
+int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 #else
 static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
@@ -1890,6 +1891,10 @@ static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	return -ENOTTY;
 }
+static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
+{
+	return -ENOTTY;
+}
 #endif
 
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
-- 
2.11.0
