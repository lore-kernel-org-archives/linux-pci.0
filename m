Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38059 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbbGUAPW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:15:22 -0400
Received: by iggf3 with SMTP id f3so94284711igg.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:15:22 -0700 (PDT)
Subject: [PATCH v2 11/11] PCI: Remove pci_ats_enabled()
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:15:19 -0500
Message-ID: <20150721001519.28145.73458.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove pci_ats_enabled().  There are no callers outside the ATS code
itself.  We don't need to check ats_cap, because if we don't find an ATS
capability, we'll never set ats_enabled.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c   |    6 +++---
 include/linux/pci.h |    2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index bdb1383..7a1c88f 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -43,7 +43,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	if (!dev->ats_cap)
 		return -EINVAL;
 
-	if (pci_ats_enabled(dev))
+	if (dev->ats_enabled)
 		return -EINVAL;
 
 	if (ps < PCI_ATS_MIN_STU)
@@ -80,7 +80,7 @@ void pci_disable_ats(struct pci_dev *dev)
 	struct pci_dev *pdev;
 	u16 ctrl;
 
-	if (!pci_ats_enabled(dev))
+	if (!dev->ats_enabled)
 		return;
 
 	if (atomic_read(&dev->ats_ref_cnt))
@@ -103,7 +103,7 @@ void pci_restore_ats_state(struct pci_dev *dev)
 {
 	u16 ctrl;
 
-	if (!pci_ats_enabled(dev))
+	if (!dev->ats_enabled)
 		return;
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4b484fd..806da76 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1303,13 +1303,11 @@ void pci_ats_init(struct pci_dev *dev);
 int pci_enable_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
-static inline int pci_ats_enabled(struct pci_dev *dev) { return dev->ats_cap && dev->ats_enabled; }
 #else
 static inline void pci_ats_init(struct pci_dev *d) { }
 static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
 static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
-static inline int pci_ats_enabled(struct pci_dev *d) { return 0; }
 #endif
 
 void pci_cfg_access_lock(struct pci_dev *dev);

