Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 10/12] MIPS: Loongson 3: Keep CPU physical (not virtual)
 addresses in shadow ROM resource
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Tony Luck <tony.luck@intel.com>,
	DRI <dri-devel@lists.freedesktop.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Daniel Stone <daniel@fooishbar.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Date: Thu, 03 Mar 2016 10:55:11 -0600
Message-ID: <20160303165511.3025.17928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Loongson 3 used the IORESOURCE_ROM_COPY flag for its ROM resource.  There
are two problems with this:

  - When IORESOURCE_ROM_COPY is set, pci_map_rom() assumes the resource
    contains virtual addresses, so it doesn't ioremap the resource.  This
    implies loongson_sysconf.vgabios_addr is a virtual address.  That's a
    problem because resources should contain CPU *physical* addresses not
    virtual addresses.

  - When IORESOURCE_ROM_COPY is set, pci_cleanup_rom() calls kfree() on the
    resource.  We did not kmalloc() the loongson_sysconf.vgabios_addr area,
    so it is incorrect to kfree() it.

If we're using a shadow copy in RAM for the Loongson 3 VGA BIOS area,
disable the ROM BAR and release the address space it was consuming.

Use IORESOURCE_ROM_SHADOW instead of IORESOURCE_ROM_COPY.  This means the
struct resource contains CPU physical addresses, and pci_map_rom() will
ioremap() it as needed.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/fixup-loongson3.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson3.c
index b66b1eb..c015ca1 100644
--- a/arch/mips/pci/fixup-loongson3.c
+++ b/arch/mips/pci/fixup-loongson3.c
@@ -48,9 +48,14 @@ static void pci_fixup_radeon(struct pci_dev *pdev)
 	if (!loongson_sysconf.vgabios_addr)
 		return;
 
-	res->start = loongson_sysconf.vgabios_addr;
+	pci_disable_rom(pdev);
+	if (res->parent)
+		release_resource(res);
+
+	res->start = virt_to_phys(loongson_sysconf.vgabios_addr);
 	res->end   = res->start + 256*1024 - 1;
-	res->flags |= IORESOURCE_ROM_COPY;
+	res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
+		     IORESOURCE_PCI_FIXED;
 
 	dev_info(&pdev->dev, "BAR %d: assigned %pR for Radeon ROM\n",
 		 PCI_ROM_RESOURCE, res);
