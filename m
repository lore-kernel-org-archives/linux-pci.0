Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] PCI: add resizeable BAR infrastructure v4
Date: Tue, 25 Apr 2017 15:19:51 +0200
Message-Id: <1493126394-1239-2-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

Just the defines and helper functions to read the possible sizes of a BAR and
update it's size.

See https://pcisig.com/sites/default/files/specification_documents/ECN_Resizable-BAR_24Apr2008.pdf
and PCIe r3.1, sec 7.22.

This is useful for hardware with large local storage (mostly GFX) which only
expose 256MB BARs initially to be compatible with 32bit systems.

v2: provide read helper as well
v3: improve function names, use unsigned values, add better comments.
v4: move definition, improve commit message, s/bar/BAR/

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/pci.c             | 115 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   4 ++
 include/uapi/linux/pci_regs.h |  11 +++-
 3 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ba34907..c2d9f78 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2944,6 +2944,121 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 }
 
 /**
+ * pci_rbar_get_possible_sizes - get possible sizes for BAR
+ * @dev: PCI device
+ * @bar: BAR to query
+ *
+ * Get the possible sizes of a resizeable BAR as bitmask defined in the spec
+ * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizeable.
+ */
+u32 pci_rbar_get_possible_sizes(struct pci_dev *pdev, int bar)
+{
+	unsigned pos, nbars;
+	u32 ctrl, cap;
+	unsigned i;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos)
+		return 0;
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
+	return 0;
+}
+
+/**
+ * pci_rbar_get_current_size - get the current size of a BAR
+ * @dev: PCI device
+ * @bar: BAR to set size to
+ *
+ * Read the size of a BAR from the resizeable BAR config.
+ * Returns size if found or negativ error code.
+ */
+int pci_rbar_get_current_size(struct pci_dev *pdev, int bar)
+{
+	unsigned pos, nbars;
+	u32 ctrl;
+	unsigned i;
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
+ * @size: new size as defined in the spec (log2(size in bytes) - 20)
+ *
+ * Set the new size of a BAR as defined in the spec (0=1MB, 19=512GB).
+ * Returns true if resizing was successful, false otherwise.
+ */
+int pci_rbar_set_size(struct pci_dev *pdev, int bar, int size)
+{
+	unsigned pos, nbars;
+	u32 ctrl;
+	unsigned i;
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
+		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE_MASK;
+		ctrl |= size << PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
+		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/**
  * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
  * @dev: the PCI device
  * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4518562..1d27c22 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -356,4 +356,8 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
+u32 pci_rbar_get_possible_sizes(struct pci_dev *pdev, int bar);
+int pci_rbar_get_current_size(struct pci_dev *pdev, int bar);
+int pci_rbar_set_size(struct pci_dev *pdev, int bar, int size);
+
 #endif /* DRIVERS_PCI_H */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5a2e68..a75429e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -932,9 +932,16 @@
 #define PCI_SATA_SIZEOF_LONG	16
 
 /* Resizable BARs */
+#define PCI_REBAR_CAP		4	/* capability register */
+#define  PCI_REBAR_CTRL_SIZES_MASK	(0xFFFFF << 4)	/* mask for sizes */
+#define  PCI_REBAR_CTRL_SIZES_SHIFT	4	/* shift for sizes */
 #define PCI_REBAR_CTRL		8	/* control register */
-#define  PCI_REBAR_CTRL_NBAR_MASK	(7 << 5)	/* mask for # bars */
-#define  PCI_REBAR_CTRL_NBAR_SHIFT	5	/* shift for # bars */
+#define  PCI_REBAR_CTRL_BAR_IDX_MASK	(7 << 0)	/* mask for BAR index */
+#define  PCI_REBAR_CTRL_BAR_IDX_SHIFT	0	/* shift for BAR index */
+#define  PCI_REBAR_CTRL_NBAR_MASK	(7 << 5)	/* mask for # BARs */
+#define  PCI_REBAR_CTRL_NBAR_SHIFT	5	/* shift for # BARs */
+#define  PCI_REBAR_CTRL_BAR_SIZE_MASK	(0x1F << 8)	/* mask for BAR size */
+#define  PCI_REBAR_CTRL_BAR_SIZE_SHIFT	8	/* shift for BAR size */
 
 /* Dynamic Power Allocation */
 #define PCI_DPA_CAP		4	/* capability register */
-- 
2.7.4
