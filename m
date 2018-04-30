Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:50612 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeD3R1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Apr 2018 13:27:35 -0400
Subject: [PATCH v2 1/2] PCI: Add pci_bus_specific_read_dev_vendor_id() to
 workaround PCI switch specific issues prior to accessing newly added endpoint
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
To: Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <4bd28931-8e8d-6bfe-a98c-49f8e2778c6e@oracle.com>
Message-ID: <15d4492d-f6ec-5a2d-d18a-4f1c08545842@oracle.com>
Date: Mon, 30 Apr 2018 13:27:31 -0400
MIME-Version: 1.0
In-Reply-To: <4bd28931-8e8d-6bfe-a98c-49f8e2778c6e@oracle.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch provides a framework in which it would be possible to implement
bus specific quirks prior to accessing an endpoint device beneath that bus.
The routine, pci_bus_specific_read_dev_vendor_id, can be called prior to
accessing the end point device itself in order to workaround potential issues
with the parent device (switch). If there is nothing specific to be done for
a particular switch device, it falls through to check for the endpoint device
i.e pci_bus_generic_read_dev_vendor_id().

Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.h    | 11 +++++++++++
 drivers/pci/probe.c  | 20 +++++++++++++++++++-
 drivers/pci/quirks.c | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 023f7cf..2132a60 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -225,6 +225,17 @@ enum pci_bar_type {
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
+#ifdef CONFIG_PCI_QUIRKS
+int pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn,
+				u32 *pl, int crs_timeout);
+#else
+static int pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn,
+				u32 *pl, int crs_timeout)
+{
+	return -ENOTTY;
+}
+#endif
+
 int pci_setup_device(struct pci_dev *dev);
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		    struct resource *res, unsigned int reg);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6f..31eba02 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2097,7 +2097,7 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
 	return true;
 }
 
-bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {
 	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
@@ -2113,6 +2113,24 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 
 	return true;
 }
+
+
+bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+					int timeout)
+{
+	int ret;
+
+	/*
+ 	 * An opportunity to implement something specific for this device.
+	 * For ex, implement a quirk prior to even accessing the device
+	 */
+	ret = pci_bus_specific_read_dev_vendor_id(bus, devfn, l, timeout);
+	if (ret >= 0)
+		return (ret >= 0);
+
+	return pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
+}
+
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
 /*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2990ad1..2b28584 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4741,3 +4741,44 @@ static void quirk_gpu_hda(struct pci_dev *hda)
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
+
+static const struct pci_bus_specific_quirk{
+	u16 vendor;
+	u16 device;
+	int (*bus_quirk)(struct pci_bus *bus, int devfn, u32 *l, int timeout);
+} pci_bus_specific_quirks[] = {
+	{0}
+};
+
+/*
+ * This routine provides the ability to implement a bus specific quirk
+ * prior to doing config accesses to the endpoint device itself. For ex, there
+ * could be HW problems with the switch above the endpoint that causes issues
+ * when accessing the endpoint device. Such workarounds "specific" to the
+ * parent could be implemented prior or subsequent to accesses to the
+ * endpoint itself
+ *
+ */
+int pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
+					int timeout)
+{
+	const struct pci_bus_specific_quirk *i;
+	struct pci_dev *dev;
+
+	if (!bus || !bus->self)
+		return -ENOTTY;
+
+	dev = bus->self;
+
+	/*
+ 	 * Implement any quirks in the "bus" (switch, for ex) that causes
+	 * issues in accessing the endpoint
+	 */
+	for (i = pci_bus_specific_quirks; i->bus_quirk; i++) {
+		if ((i->vendor == dev->vendor ||
+		     i->vendor == (u16)PCI_ANY_ID) &&
+		    (i->device == dev->device || i->device == (u16)PCI_ANY_ID))
+			return(i->bus_quirk(bus, devfn, l, timeout));
+	}
+	return -ENOTTY;
+}
-- 
1.8.3.1
