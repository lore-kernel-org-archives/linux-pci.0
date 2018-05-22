Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1] MIPS: PCI: Use dev_printk() when possible
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 08:11:42 -0500
Message-ID: <152699470263.162686.16975145205315900817.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use the pci_info() and pci_err() wrappers for dev_printk() when possible.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci-legacy.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 0c65c38e05d6..73643e80f02d 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -263,9 +263,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
 			continue;
 		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available "
-			       "because of resource collisions\n",
-			       pci_name(dev));
+			pci_err(dev, "can't enable device: resource collisions\n");
 			return -EINVAL;
 		}
 		if (r->flags & IORESOURCE_IO)
@@ -274,8 +272,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
+		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
