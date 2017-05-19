Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 2/2] MIPS: PCI: Remove unused busn_offset
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: linux-mips@linux-mips.org, Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 19 May 2017 14:56:06 -0500
Message-ID: <20170519195606.25338.73798.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170519195559.25338.30891.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170519195559.25338.30891.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_add_resource_offset() is for host bridge windows where the bridge
translates CPU addresses to PCI bus addresses by adding an offset.  To my
knowledge, no host bridge translates bus numbers, so this is only useful
for MEM and IO windows.  In any event, host->busn_offset is never set to
anything other than zero, so pci_add_resource() is sufficient.

a2e50f53d535 ("MIPS: PCI: Add a hook for IORESOURCE_BUS in
pci_controller/bridge_controller") also added busn_resource itself.  This
is currently unused but may be used by future SGI IP27 fixes, so I left it
there.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/pci.h |    1 -
 arch/mips/pci/pci-legacy.c  |    3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 1000c1b4c875..52f551ee492d 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -39,7 +39,6 @@ struct pci_controller {
 	unsigned long io_offset;
 	unsigned long io_map_base;
 	struct resource *busn_resource;
-	unsigned long busn_offset;
 
 #ifndef CONFIG_PCI_DOMAINS_GENERIC
 	unsigned int index;
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 3a84f6c0c840..174575a9a112 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -86,8 +86,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
 				hose->mem_resource, hose->mem_offset);
 	pci_add_resource_offset(&resources,
 				hose->io_resource, hose->io_offset);
-	pci_add_resource_offset(&resources,
-				hose->busn_resource, hose->busn_offset);
+	pci_add_resource(&resources, hose->busn_resource);
 	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
 				&resources);
 	hose->bus = bus;
