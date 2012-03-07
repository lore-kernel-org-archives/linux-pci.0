Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 32/34] PCI: allow P2P bridge windows starting at PCI bus
	address zero
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Date: Wed, 07 Mar 2012 15:34:47 -0700
Message-ID: <20120307223447.25669.75889.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

cd81e1ea1a4c added checks that prevent us from using P2P bridge windows
that start at PCI bus address zero.  The reason was to "prevent us from
overwriting resources that are unassigned."

But generic code should allow address zero in both BARs and bridge
windows, so I think that commit was a mistake.

Windows at bus address zero are legal and likely to exist on machines with
an offset between bus addresses and CPU addresses.  For example, in the
following hypothetical scenario, the bridge at 00:01.0 has a window at bus
address zero and the device at 01:00.0 has a BAR at bus address zero, and
I think both are perfectly valid:

    PCI host bridge to bus 0000:00
    pci_bus 0000:00: root bus resource [mem 0x100000000-0x1ffffffff] (bus address [0x00000000-0xffffffff])
    pci 0000:00:01.0: PCI bridge to [bus 01]
    pci 0000:00:01.0:   bridge window [mem 0x100000000-0x100ffffff]
    pci 0000:01:00.0: reg 10: [mem 0x100000000-0x100ffffff]

CC: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d181e48..b81ec1c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -365,7 +365,7 @@ static void __devinit pci_read_bridge_io(struct pci_bus *child)
 		limit |= (io_limit_hi << 16);
 	}
 
-	if (base && base <= limit) {
+	if (base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		res2.flags = res->flags;
 		region.start = base;
@@ -392,7 +392,7 @@ static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
 	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
 	base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
 	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
-	if (base && base <= limit) {
+	if (base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		region.start = base;
 		region.end = limit + 0xfffff;
@@ -438,7 +438,7 @@ static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
 #endif
 		}
 	}
-	if (base && base <= limit) {
+	if (base <= limit) {
 		res->flags = (mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) |
 					 IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		if (res->flags & PCI_PREF_RANGE_TYPE_64)

