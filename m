Return-Path: <SRS0=Gf57=4P=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=Gf57=4P=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	helgaas@kernel.org
Subject: [PATCH v6 4/5] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 30h-3fh) Processors v3
Date: Tue,  9 May 2017 18:49:06 +0200
Message-Id: <1494348547-1465-5-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
References: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/x86/pci/fixup.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 6d52b94..1c36ed6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -571,3 +571,72 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
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
-- 
2.7.4
