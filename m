Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Alexander Gordeev <agordeev@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC Patch V1 11/12] genirq, PCI: Reorginize struct msi_desc to prepare for support of generic MSI
Date: Thu,  9 Jul 2015 16:00:46 +0800
Message-Id: <1436428847-8886-12-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorganize struct msi_desc so it could be reused by other MSI drivers.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/msi.h |   41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 5f77e231f515..f6845bc83774 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -19,29 +19,30 @@ void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 
 struct msi_desc {
-	struct {
-		__u8	is_msix	: 1;
-		__u8	multiple: 3;	/* log2 num of messages allocated */
-		__u8	multi_cap : 3;	/* log2 num of messages supported */
-		__u8	maskbit	: 1;	/* mask-pending bit supported ? */
-		__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit */
-		__u16	entry_nr;	/* specific enabled entry */
-		unsigned default_irq;	/* default pre-assigned irq */
-	} msi_attrib;
-
-	u32 masked;			/* mask bits */
-	unsigned int irq;
-	unsigned int nvec_used;		/* number of messages */
-	struct list_head list;
+	struct list_head		list;
+	unsigned int			irq;
+	unsigned int			nvec_used;	/* number of messages */
+	struct device *			dev;
+	struct msi_msg			msg;		/* Last set MSI message */
 
 	union {
-		void __iomem *mask_base;
-		u8 mask_pos;
+		struct {				/* For PCI MSI/MSI-X */
+			u32 masked;			/* mask bits */
+			struct {
+				__u8	is_msix	: 1;
+				__u8	multiple: 3;	/* log2 num of messages allocated */
+				__u8	multi_cap : 3;	/* log2 num of messages supported */
+				__u8	maskbit	: 1;	/* mask-pending bit supported ? */
+				__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit */
+				__u16	entry_nr;	/* specific enabled entry */
+				unsigned default_irq;	/* default pre-assigned irq */
+			} msi_attrib;
+			union {
+				u8	mask_pos;
+				void __iomem *mask_base;
+			};
+		};
 	};
-	struct device *dev;
-
-	/* Last set MSI message */
-	struct msi_msg msg;
 };
 
 /* Helpers to hide struct msi_desc implementation details */
-- 
1.7.10.4

