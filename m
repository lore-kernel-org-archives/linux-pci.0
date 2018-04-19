Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:58944 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753475AbeDSVza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Apr 2018 17:55:30 -0400
Subject: [PATCH 2/2] PCI: Implement workaround for the ACS bug in the IDT,
 switch
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
To: Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <b6439e86-2284-5b3c-3656-a0c3c2568317@oracle.com>
Message-ID: <a4f8dbde-9fcf-3644-e08c-88654637d157@oracle.com>
Date: Thu, 19 Apr 2018 13:39:26 -0400
MIME-Version: 1.0
In-Reply-To: <b6439e86-2284-5b3c-3656-a0c3c2568317@oracle.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The IDT switch incorrectly flags an ACS source violation on a read config
request to an end point device on the completion (IDT 89H32H8G3-YC,
errata #36) even though the PCI Express spec states that completions are
never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1).
Here's
the specific copy of the errata text

"Item #36 - Downstream port applies ACS Source Validation to Completions
Section 6.12.1.1 of the PCI Express Base Specification 3.1 states
that completions are never affected
by ACS Source Validation. However, completions received by a
downstream port of the PCIe switch from a device that has not yet
captured a PCIe bus number are incorrectly dropped by ACS source
validation by the switch downstream port.

Workaround: Issue a CfgWr1 to the downstream device before issuing
the first CfgRd1 to the device.
This allows the downstream device to capture its bus number; ACS
source validation no longer stops
completions from being forwarded by the downstream port. It has been
observed that Microsoft Windows implements this workaround already;
however, some versions of Linux and other operating systems may not. "

The suggested workaround by IDT is to issue a configuration write to the
downstream device before issuing the first config read. This allows the
downstream device to capture its bus number, thus avoiding the ACS
violation on the completion. In order to make sure that the device is ready
for config accesses, we do what is currently done in making config reads
till it succeeds and then do the config write as specified by the errata.
However, to avoid hitting the errata issue when doing config reads, we
disable ACS SV around this process.

The patch does the following -

1. Disable ACS source violation if enabled.
2. Wait for config space access to become available by reading vendor id
3. Do a config write to the end point (errata workaround)
4. Enable ACS source validation (if it was enabled to begin with)

Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
---
 drivers/pci/pci.h    |  2 ++
 drivers/pci/quirks.c | 95
++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2d06689..e801d8b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -227,6 +227,8 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus,
int devfn, u32 *pl,
 				int crs_timeout);
 int pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn,
 				u32 *pl, int crs_timeout);
+bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn,
+				u32 *pl, int crs_timeout);
 int pci_setup_device(struct pci_dev *dev);
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		    struct resource *res, unsigned int reg);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c637162..0faad6f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4743,22 +4743,111 @@ static void quirk_gpu_hda(struct pci_dev *hda)
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);


+/*
+ * The IDT switch incorrectly flags an ACS source violation on a read
config
+ * request to an end point device on the completion (IDT 89H32H8G3-YC,
+ * errata #36) even though the PCI Express spec states that completions are
+ * never affected by ACS source violation (PCI Spec 3.1, Section
6.12.1.1).
+ * Here's * the specific copy of the errata text --
+ *
+ * "Item #36 - Downstream port applies ACS Source Validation to Completions
+ * Section 6.12.1.1 of the PCI Express Base Specification 3.1 states
+ * that completions are never affected
+ * by ACS Source Validation. However, completions received by a
+ * downstream port of the PCIe switch from a device that has not yet
+ * captured a PCIe bus number are incorrectly dropped by ACS source
+ * validation by the switch downstream port."
+ *
+ * The suggested workaround by IDT is to issue a configuration write to the
+ * downstream device before issuing the first config read. This allows the
+ * downstream device to capture its bus number, thus avoiding the ACS
+ * violation on the completion. In order to make sure that the device
is ready
+ * for config accesses, we do what is currently done in making config reads
+ * till it succeeds and then do the config write as specified by the
errata.
+ * However, to avoid hitting the errata issue when doing config reads, we
+ * disable ACS SV around this process.
+ */
+static int pci_idt_acs_quirk(struct pci_bus *bus, int devfn, int enable,
+				bool found)
+{
+	int pos;
+	u16 cap;
+	u16 ctrl;
+	int retval;
+	struct pci_dev *dev = bus->self;
+
+
+	/* Write 0 to the devfn device under the PCIE switch (bus->self)
+	 * as part of forcing the devfn number to latch with the device
+	 * below */
+	if (found)
+		pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
+
+
+	/* Enable/disable ACS SV feature (based on enable flag) */
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
+
+	if (!(cap & PCI_ACS_SV))
+		return -ENODEV;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+
+	retval = !!(ctrl & cap & PCI_ACS_SV);
+	if (enable)
+		ctrl |= (cap & PCI_ACS_SV);
+	else
+		ctrl &= ~(cap & PCI_ACS_SV);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+
+	/* return the previous state of the ACS SV state i.e was SV enabled
+	 * or disabled? */
+	return retval;
+}
+
+static int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l,
+				int timeout)
+{
+	int enable;
+	bool found;
+
+	/* Disable acs for the IDT switch before attempting the intial
+	 * config accesses to the endpoint device. */
+	enable = pci_idt_acs_quirk(bus, devfn, 0, false);
+
+	/* found indicates whether the endpoint device was identified
+	 * as present or not */
+
+	found = pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
+
+	/* re-enable acs feature for the switch again if it was enabled to
+ 	 * start with */	
+	if (enable > 0)
+		pci_idt_acs_quirk(bus, devfn, enable, found);
+
+	return (found ? 1 : 0);
+}
+
 static const struct pci_bus_specific_quirk{
 	u16 vendor;
 	u16 device;
 	int (*bus_quirk)(struct pci_bus *bus, int devfn, u32 *l, int timeout);
 } pci_bus_specific_quirks[] = {
+	{ PCI_VENDOR_ID_IDT, 0x80b5, pci_idt_bus_quirk},
 	{0}
 };

 /*
  * This routine provides the ability to implement a bus specific quirk
- * prior to doing config accesses to the endpoint device itself. For
ex, there
+ * prior to doing config accesses to the endpoint device itself. For
ex, there
  * could be HW problems with the switch above the endpoint that causes
issues
  * when accessing the endpoint device. Such workarounds "specific" to the
  * parent could be implemented prior or subsequent to accesses to the
  * endpoint itself
- *
  */
 int pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn,
u32 *l,
 					int timeout)
@@ -4767,7 +4856,7 @@ int pci_bus_specific_read_dev_vendor_id(struct
pci_bus *bus, int devfn, u32 *l,
 	struct pci_dev *dev;

 	if (!bus || !bus->self)
-	        return -ENOTTY;
+		return -ENOTTY;

 	dev = bus->self;
