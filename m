Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 30h-3fh) Processors v2
Date: Tue, 25 Apr 2017 15:19:53 +0200
Message-Id: <1493126394-1239-4-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

Most BIOS don't enable this because of compatibility reasons.

Manually enable a 64bit BAR of 64GB size so that we have
enough room for PCI devices.

v2: style cleanups, increase size, add resource name, set correct flags,
    print message that windows was added

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 6d52b94..8d949c4 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -571,3 +571,56 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
+
+static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
+{
+	uint32_t base, limit, high;
+	struct resource *res, *conflict;
+	unsigned i;
+
+	for (i = 0; i < 8; ++i) {
+		pci_read_config_dword(dev, 0x80 + i * 0x8, &base);
+		pci_read_config_dword(dev, 0x180 + i * 0x4, &high);
+
+		/* Is this slot free? */
+		if ((base & 0x3) == 0x0)
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
+	res->start = 0x100000000;
+	res->end = 0xfd00000000 - 1;
+
+	/* Just grab the free area behind system memory for this */
+	while ((conflict = request_resource_conflict(&iomem_resource, res)))
+		res->start = conflict->end + 1;
+
+	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
+
+	base = ((res->start >> 8) & 0xffffff00) | 0x3;
+	limit = ((res->end + 1) >> 8) & 0xffffff00;
+	high = ((res->start >> 40) & 0xff) |
+		((((res->end + 1) >> 40) & 0xff) << 16);
+
+	pci_write_config_dword(dev, 0x180 + i * 0x4, high);
+	pci_write_config_dword(dev, 0x84 + i * 0x8, limit);
+	pci_write_config_dword(dev, 0x80 + i * 0x8, base);
+
+	pci_bus_add_resource(dev->bus, res, 0);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
-- 
2.7.4
