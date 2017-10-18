Return-Path: <SRS0=alSj=BR=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=alSj=BR=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 30h-3fh) Processors v5
Date: Wed, 18 Oct 2017 15:58:20 +0200
Message-Id: <20171018135821.3248-5-deathsimple@vodafone.de>
In-Reply-To: <20171018135821.3248-1-deathsimple@vodafone.de>
References: <20171018135821.3248-1-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

Most BIOS don't enable this because of compatibility reasons.

Manually enable a 64bit BAR of 64GB size so that we have
enough room for PCI devices.

v2: style cleanups, increase size, add resource name, set correct flags,
    print message that windows was added
v3: add defines for all the magic numbers, style cleanups
v4: add some comment that the BIOS should actually allow this using
    _PRS and _SRS.
v5: only enable this if CONFIG_PHYS_ADDR_T_64BIT is set

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/x86/pci/fixup.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 11e407489db0..7b6bd76713c5 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -618,3 +618,83 @@ static void quirk_apple_mbp_poweroff(struct pci_dev *pdev)
 		dev_info(dev, "can't work around MacBook Pro poweroff issue\n");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
+
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+
+#define AMD_141b_MMIO_BASE(x)	(0x80 + (x) * 0x8)
+#define AMD_141b_MMIO_BASE_RE_MASK		BIT(0)
+#define AMD_141b_MMIO_BASE_WE_MASK		BIT(1)
+#define AMD_141b_MMIO_BASE_MMIOBASE_MASK	GENMASK(31,8)
+
+#define AMD_141b_MMIO_LIMIT(x)	(0x84 + (x) * 0x8)
+#define AMD_141b_MMIO_LIMIT_MMIOLIMIT_MASK	GENMASK(31,8)
+
+#define AMD_141b_MMIO_HIGH(x)	(0x180 + (x) * 0x4)
+#define AMD_141b_MMIO_HIGH_MMIOBASE_MASK	GENMASK(7,0)
+#define AMD_141b_MMIO_HIGH_MMIOLIMIT_SHIFT	16
+#define AMD_141b_MMIO_HIGH_MMIOLIMIT_MASK	GENMASK(23,16)
+
+/*
+ * The PCI Firmware Spec, rev 3.2 notes that ACPI should optionally allow
+ * configuring host bridge windows using the _PRS and _SRS methods.
+ *
+ * But this is rarely implemented, so we manually enable a large 64bit BAR for
+ * PCIe device on AMD Family 15h (Models 30h-3fh) Processors here.
+ */
+static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
+{
+	struct resource *res, *conflict;
+	u32 base, limit, high;
+	unsigned i;
+
+	for (i = 0; i < 8; ++i) {
+		pci_read_config_dword(dev, AMD_141b_MMIO_BASE(i), &base);
+		pci_read_config_dword(dev, AMD_141b_MMIO_HIGH(i), &high);
+
+		/* Is this slot free? */
+		if (!(base & (AMD_141b_MMIO_BASE_RE_MASK |
+			      AMD_141b_MMIO_BASE_WE_MASK)))
+			break;
+
+		base >>= 8;
+		base |= high << 24;
+
+		/* Abort if a slot already configures a 64bit BAR. */
+		if (base > 0x10000)
+			return;
+	}
+	if (i == 8)
+		return;
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return;
+
+	res->name = "PCI Bus 0000:00";
+	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
+		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
+	res->start = 0x100000000ull;
+	res->end = 0xfd00000000ull - 1;
+
+	/* Just grab the free area behind system memory for this */
+	while ((conflict = request_resource_conflict(&iomem_resource, res)))
+		res->start = conflict->end + 1;
+
+	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
+
+	base = ((res->start >> 8) & AMD_141b_MMIO_BASE_MMIOBASE_MASK) |
+		AMD_141b_MMIO_BASE_RE_MASK | AMD_141b_MMIO_BASE_WE_MASK;
+	limit = ((res->end + 1) >> 8) & AMD_141b_MMIO_LIMIT_MMIOLIMIT_MASK;
+	high = ((res->start >> 40) & AMD_141b_MMIO_HIGH_MMIOBASE_MASK) |
+		((((res->end + 1) >> 40) << AMD_141b_MMIO_HIGH_MMIOLIMIT_SHIFT)
+		 & AMD_141b_MMIO_HIGH_MMIOLIMIT_MASK);
+
+	pci_write_config_dword(dev, AMD_141b_MMIO_HIGH(i), high);
+	pci_write_config_dword(dev, AMD_141b_MMIO_LIMIT(i), limit);
+	pci_write_config_dword(dev, AMD_141b_MMIO_BASE(i), base);
+
+	pci_bus_add_resource(dev->bus, res, 0);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
+
+#endif
-- 
2.11.0
