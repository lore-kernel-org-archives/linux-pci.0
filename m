Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 1/3] PCI: Disable IO/MEM decoding for devices with
 non-compliant BARs
To: Andi Kleen <ak@linux.intel.com>,
	Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org
Date: Fri, 26 Feb 2016 09:58:50 -0600
Message-ID: <20160226155850.9113.90817.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI config header (first 64 bytes of each device's config space) is
defined by the PCI spec so generic software can identify the device and
manage its usage of I/O, memory, and IRQ resources.

Some non-spec-compliant devices put registers other than BARs where the
BARs should be.  When the PCI core sizes these "BARs", the reads and writes
it does may have unwanted side effects, and the "BAR" may appear to
describe non-sensical address space.

Add a flag bit to mark non-compliant devices so we don't touch their BARs.
Turn off IO/MEM decoding to prevent the devices from consuming address
space, since we can't read the BARs to find out what that address space
would be.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   14 ++++++++++++++
 include/linux/pci.h |    1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..6b0056e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -179,6 +179,9 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	u16 orig_cmd;
 	struct pci_bus_region region, inverted_region;
 
+	if (dev->non_compliant_bars)
+		return 0;
+
 	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
 
 	/* No printks while decoding is disabled! */
@@ -1171,6 +1174,7 @@ static void pci_msi_setup_pci_dev(struct pci_dev *dev)
 int pci_setup_device(struct pci_dev *dev)
 {
 	u32 class;
+	u16 cmd;
 	u8 hdr_type;
 	int pos = 0;
 	struct pci_bus_region region;
@@ -1214,6 +1218,16 @@ int pci_setup_device(struct pci_dev *dev)
 	/* device class may be changed after fixup */
 	class = dev->class >> 8;
 
+	if (dev->non_compliant_bars) {
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
+		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+			dev_info(&dev->dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
+			cmd &= ~PCI_COMMAND_IO;
+			cmd &= ~PCI_COMMAND_MEMORY;
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
+		}
+	}
+
 	switch (dev->hdr_type) {		    /* header type */
 	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
 		if (class == PCI_CLASS_BRIDGE_PCI)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..5f80661 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -359,6 +359,7 @@ struct pci_dev {
 	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
+	unsigned int	non_compliant_bars:1;	/* broken BARs; ignore them */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
