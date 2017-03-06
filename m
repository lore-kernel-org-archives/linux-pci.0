Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] PCI: add resizeable BAR infrastructure v2
Date: Mon,  6 Mar 2017 12:40:24 +0100
Message-Id: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

Just the defines and helper functions to read the possible sizes of a BAR and
update it's size.

See https://pcisig.com/sites/default/files/specification_documents/ECN_Resizable-BAR_24Apr2008.pdf.

v2: provide read helper as well

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/pci.c             | 115 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |   3 ++
 include/uapi/linux/pci_regs.h |   7 +++
 3 files changed, 125 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ba34907..9658aa7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2944,6 +2944,121 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 }
 
 /**
+ * pci_rbar_get_sizes - get possible sizes for BAR
+ * @dev: PCI device
+ * @bar: BAR to query
+ *
+ * Get the possible sizes of a resizeable BAR as bitmask defined in the spec
+ * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizeable.
+ */
+u32 pci_rbar_get_sizes(struct pci_dev *pdev, int bar)
+{
+	int pos, nbars;
+	u32 ctrl, cap;
+	int i;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos)
+		return 0x0;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
+
+	for (i = 0; i < nbars; ++i, pos += 8) {
+		int bar_idx;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
+				PCI_REBAR_CTRL_BAR_IDX_SHIFT;
+		if (bar_idx != bar)
+			continue;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
+		return (cap & PCI_REBAR_CTRL_SIZES_MASK) >>
+			PCI_REBAR_CTRL_SIZES_SHIFT;
+	}
+
+	return 0x0;
+}
+
+/**
+ * pci_rbar_get_size - get the current size of a BAR
+ * @dev: PCI device
+ * @bar: BAR to set size to
+ *
+ * Read the size of a BAR from the resizeable BAR config.
+ * Returns size if found or negativ error code.
+ */
+int pci_rbar_get_size(struct pci_dev *pdev, int bar)
+{
+	int pos, nbars;
+	u32 ctrl;
+	int i;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos)
+		return -ENOTSUPP;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
+
+	for (i = 0; i < nbars; ++i, pos += 8) {
+		int bar_idx;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
+				PCI_REBAR_CTRL_BAR_IDX_SHIFT;
+		if (bar_idx != bar)
+			continue;
+
+		return (ctrl & PCI_REBAR_CTRL_BAR_SIZE_MASK) >>
+			PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * pci_rbar_set_size - set a new size for a BAR
+ * @dev: PCI device
+ * @bar: BAR to set size to
+ * @size: new size as defined in the spec.
+ *
+ * Set the new size of a BAR as defined in the spec (0=1MB, 19=512GB).
+ * Returns true if resizing was successful, false otherwise.
+ */
+bool pci_rbar_set_size(struct pci_dev *pdev, int bar, int size)
+{
+	int pos, nbars;
+	u32 ctrl;
+	int i;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos)
+		return false;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
+
+	for (i = 0; i < nbars; ++i, pos += 8) {
+		int bar_idx;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
+				PCI_REBAR_CTRL_BAR_IDX_SHIFT;
+		if (bar_idx != bar)
+			continue;
+
+		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE_MASK;
+		ctrl |= size << PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
+		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+		return true;
+	}
+
+	return false;
+}
+
+/**
  * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
  * @dev: the PCI device
  * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a38772a..9f26ca4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1946,6 +1946,9 @@ void pci_request_acs(void);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
 			  struct pci_dev *end, u16 acs_flags);
+u32 pci_rbar_get_sizes(struct pci_dev *pdev, int bar);
+int pci_rbar_get_size(struct pci_dev *pdev, int bar);
+bool pci_rbar_set_size(struct pci_dev *pdev, int bar, int size);
 
 #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
 #define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5a2e68..6de29d6 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -932,9 +932,16 @@
 #define PCI_SATA_SIZEOF_LONG	16
 
 /* Resizable BARs */
+#define PCI_REBAR_CAP		4	/* capability register */
+#define  PCI_REBAR_CTRL_SIZES_MASK	(0xFFFFF << 4)	/* mask for sizes */
+#define  PCI_REBAR_CTRL_SIZES_SHIFT	4	/* shift for sizes */
 #define PCI_REBAR_CTRL		8	/* control register */
+#define  PCI_REBAR_CTRL_BAR_IDX_MASK	(7 << 0)	/* mask for bar index */
+#define  PCI_REBAR_CTRL_BAR_IDX_SHIFT	0	/* shift for bar index */
 #define  PCI_REBAR_CTRL_NBAR_MASK	(7 << 5)	/* mask for # bars */
 #define  PCI_REBAR_CTRL_NBAR_SHIFT	5	/* shift for # bars */
+#define  PCI_REBAR_CTRL_BAR_SIZE_MASK	(0x1F << 8)	/* mask for bar size */
+#define  PCI_REBAR_CTRL_BAR_SIZE_SHIFT	8	/* shift for bar size */
 
 /* Dynamic Power Allocation */
 #define PCI_DPA_CAP		4	/* capability register */
-- 
2.7.4
