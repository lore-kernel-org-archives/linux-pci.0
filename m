Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 15/19] pci: pci_config_window move to linux/pci.h
Date: Tue, 28 Jun 2016 15:36:31 +0900
Message-Id: <1467095795-5082-16-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
References: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/pci/ecam.h  | 17 +----------------
 include/linux/pci.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
index 9878beb..f110091 100644
--- a/drivers/pci/ecam.h
+++ b/drivers/pci/ecam.h
@@ -18,6 +18,7 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/pci.h>
 
 /*
  * struct to hold pci ops and bus shift of the config window
@@ -31,22 +32,6 @@ struct pci_ecam_ops {
 						struct pci_config_window *);
 };
 
-/*
- * struct to hold the mappings of a config space window. This
- * is expected to be used as sysdata for PCI controllers that
- * use ECAM.
- */
-struct pci_config_window {
-	struct resource			res;
-	struct resource			busr;
-	void				*priv;
-	struct pci_ecam_ops		*ops;
-	union {
-		void __iomem		*win;	/* 64-bit single mapping */
-		void __iomem		**winp; /* 32-bit per-bus mapping */
-	};
-};
-
 /* create and free pci_config_window */
 struct pci_config_window *pci_ecam_create(struct device *dev,
 		struct resource *cfgres, struct resource *busr,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..398896f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2026,6 +2026,24 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 	return bus->self && bus->self->ari_enabled;
 }
 
+/*
+ * struct to hold the mappings of a config space window. This
+ * is expected to be used as sysdata for PCI controllers that
+ * use ECAM.
+ */
+struct pci_ecam_ops;
+
+struct pci_config_window {
+	struct resource			res;
+	struct resource			busr;
+	void				*priv;
+	struct pci_ecam_ops		*ops;
+	union {
+		void __iomem		*win;	/* 64-bit single mapping */
+		void __iomem		**winp; /* 32-bit per-bus mapping */
+	};
+};
+
 /* provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
-- 
2.7.0
