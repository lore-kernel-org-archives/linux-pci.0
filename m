Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 07/12] ia64/PCI: Use ioremap() instead of open-coded
 equivalent
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
Date: Thu, 03 Mar 2016 10:54:45 -0600
Message-ID: <20160303165445.3025.12861.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Depositing __IA64_UNCACHED_OFFSET in the upper address bits is essentially
equivalent to ioremap(): it converts a CPU physical address to a virtual
address using the ia64 uncacheable identity map.

Call ioremap() instead of doing the phys-to-virt conversion manually with
__IA64_UNCACHED_OFFSET.

Note that this makes it obvious that (a) we're putting a virtual address in
a struct resource, and (b) we're passing a virtual address to ioremap()
below in the PCI_ROM_RESOURCE case.  These are both pre-existing problems
that I'll resolve next.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/sn/kernel/io_init.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index 40c0263..0227e20 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -185,9 +185,8 @@ sn_io_slot_fixup(struct pci_dev *dev)
 		if (size == 0)
 			continue;
 
-		addr = pcidev_info->pdi_pio_mapped_addr[idx];
-		addr = ((addr << 4) >> 4) | __IA64_UNCACHED_OFFSET;
-		res->start = addr;
+		res->start = ioremap(pcidev_info->pdi_pio_mapped_addr[idx],
+				     size + 1);
 		res->end = addr + size;
 
 		/*
