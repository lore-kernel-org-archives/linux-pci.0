Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40943 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186AbcCaWed (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Mar 2016 18:34:33 -0400
Subject: [PATCH 1/2] PCI: Reverse standard ACS vs device specific ACS
 enabling
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org
Date: Thu, 31 Mar 2016 16:34:32 -0600
Message-ID: <20160331223431.20486.74459.stgit@gimli.home>
In-Reply-To: <20160331222828.20486.30979.stgit@gimli.home>
References: <20160331222828.20486.30979.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The original thought was that if a device implemented ACS, then surely
we want to use that... well, it turns out that devices can make an ACS
capability so broken that we still need to fall back to quirks.
Reverse the order of ACS enabling to give quirks first shot at it.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c    |   10 ++++------
 drivers/pci/quirks.c |    6 ++++--
 include/linux/pci.h  |    7 +++++--
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 25e0327..c98c4e2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2547,7 +2547,7 @@ void pci_request_acs(void)
  * pci_std_enable_acs - enable ACS on devices using standard ACS capabilites
  * @dev: the PCI device
  */
-static int pci_std_enable_acs(struct pci_dev *dev)
+static void pci_std_enable_acs(struct pci_dev *dev)
 {
 	int pos;
 	u16 cap;
@@ -2555,7 +2555,7 @@ static int pci_std_enable_acs(struct pci_dev *dev)
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
 	if (!pos)
-		return -ENODEV;
+		return;
 
 	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
@@ -2573,8 +2573,6 @@ static int pci_std_enable_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_UF);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
-
-	return 0;
 }
 
 /**
@@ -2586,10 +2584,10 @@ void pci_enable_acs(struct pci_dev *dev)
 	if (!pci_acs_enable)
 		return;
 
-	if (!pci_std_enable_acs(dev))
+	if (!pci_dev_specific_enable_acs(dev))
 		return;
 
-	pci_dev_specific_enable_acs(dev);
+	pci_std_enable_acs(dev);
 }
 
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8e67802..701fad6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4168,7 +4168,7 @@ static const struct pci_dev_enable_acs {
 	{ 0 }
 };
 
-void pci_dev_specific_enable_acs(struct pci_dev *dev)
+int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	const struct pci_dev_enable_acs *i;
 	int ret;
@@ -4180,9 +4180,11 @@ void pci_dev_specific_enable_acs(struct pci_dev *dev)
 		     i->device == (u16)PCI_ANY_ID)) {
 			ret = i->enable_acs(dev);
 			if (ret >= 0)
-				return;
+				return ret;
 		}
 	}
+
+	return -ENOTTY;
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 004b813..aaec79a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1663,7 +1663,7 @@ enum pci_fixup_pass {
 #ifdef CONFIG_PCI_QUIRKS
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
-void pci_dev_specific_enable_acs(struct pci_dev *dev);
+int pci_dev_specific_enable_acs(struct pci_dev *dev);
 #else
 static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
@@ -1672,7 +1672,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 {
 	return -ENOTTY;
 }
-static inline void pci_dev_specific_enable_acs(struct pci_dev *dev) { }
+static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	return -ENOTTY;
+}
 #endif
 
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);

