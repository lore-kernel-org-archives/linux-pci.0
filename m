Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"hjk@hansjkoch.de" <hjk@hansjkoch.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [PATCH] Introducing kernel option to force all PCI memory resources
 to be page aligned. Fixes issues with uio based drivers.
Date: Mon, 6 Jun 2016 06:53:28 +0000
Message-ID: <a3411d517fbd4626b2c78e420b387f76@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned 
PCI memory resources are not page aligned.
By using the kernel option "pci=resource_alignment" it is possible to force
single PCI boards to use page alignment for their memory resources.
However, this is fairly cumbersome if multiple of these cards are in use.
This patch adds another kernel option "pci=resources_page_aligned"
that allows to set the default alignment of PCI memory resources to
be page aligned.
Overwriting of this default alignment via "pci=resource_alignment" is
still possible.

Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>

---
 Documentation/kernel-parameters.txt |    1 +
 drivers/pci/pci.c                   |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-4.7-rc1/Documentation/kernel-parameters.txt
===================================================================
--- linux-4.7-rc1.orig/Documentation/kernel-parameters.txt
+++ linux-4.7-rc1/Documentation/kernel-parameters.txt
@@ -3004,6 +3004,7 @@ bytes respectively. Such letter suffixes
 				PAGE_SIZE is used as alignment.
 				PCI-PCI bridge can be specified, if resource
 				windows need to be expanded.
+		resources_page_aligned 	Force all memory resources to be page aligned.
 		ecrc=		Enable/disable PCIe ECRC (transaction layer
 				end-to-end CRC checking).
 				bios: Use BIOS/firmware settings. This is the
Index: linux-4.7-rc1/drivers/pci/pci.c
===================================================================
--- linux-4.7-rc1.orig/drivers/pci/pci.c
+++ linux-4.7-rc1/drivers/pci/pci.c
@@ -4744,7 +4744,7 @@ EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
 #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
 static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
 static DEFINE_SPINLOCK(resource_alignment_lock);
-
+static resource_size_t pci_default_resource_alignment = 0;
 /**
  * pci_specified_resource_alignment - get resource alignment specified by user.
  * @dev: the PCI device to get
@@ -4755,7 +4755,7 @@ static DEFINE_SPINLOCK(resource_alignmen
 static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 {
 	int seg, bus, slot, func, align_order, count;
-	resource_size_t align = 0;
+	resource_size_t align = pci_default_resource_alignment;
 	char *p;
 
 	spin_lock(&resource_alignment_lock);
@@ -5015,6 +5015,8 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "resource_alignment=", 19)) {
 				pci_set_resource_alignment_param(str + 19,
 							strlen(str + 19));
+			} else if (!strncmp(str, "resources_page_aligned", 22)) {
+				pci_default_resource_alignment = PAGE_SIZE;
 			} else if (!strncmp(str, "ecrc=", 5)) {
 				pcie_ecrc_get_policy(str + 5);
 			} else if (!strncmp(str, "hpiosize=", 9)) {
