Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932526AbcJZSBl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 14:01:41 -0400
Subject: [PATCH 5/5] PCI: Balance ports to avoid ACS errata on Pericom
 switches
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Oct 2016 12:01:40 -0600
Message-ID: <20161026180140.23495.27388.stgit@gimli.home>
In-Reply-To: <20161026175156.23495.12980.stgit@gimli.home>
References: <20161026175156.23495.12980.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As described in the included code comment, this quirk is intended to
work around an errata in a variety of Pericom 4-lane, 3 and 4 port
PCIe 2.0 switches.  The switches advertise ACS capabilities, but the
P2P Request Redirection support includes an errata that PCI_ACS_RR
effectively doesn't work and results in transactions being queued and
not delivered within the PCIe switch.  The errata has no planned
hardware fix.

To workaround this, we can either not enable PCI_ACS_RR, which has
device isolation and thus IOMMU grouping implications, or we can
"balance" the links to put the device into a mode where the errata is
not exposed.  As noted in the comments, we choose the balance route.

For the device where this issue has been observed, the PI7C9X2G404SL
exposes a x1, 5GT/s capable upstream port and three x1, 5GT/s capable
downstream ports.  Two of these downstream ports terminate in 2.5GT/s
capable endpoints, the remaining one is empty.  When installed into
a slot with a maximum capability of 2.5GT/s, enabling ACS works well.
The problem arises when the card is installed into a 5.0GT/s capable
slot, in which case the upstream link negotiates to 5.0GT/s, creating
an unbalanced configuration which exposes the errata.  We can set a
target link speed of 2.5GT/s to the upstream port and retrain the
link to resolve this.

In the above case, the downstream ports are fixed at 2.5GT/s, the
switch and endpoints are hardwired to a single PCB.  Presumably a
configuration could also exist where the hardwired endpoint devices
run at 5.0GT/s and installing the card into a slot that is only
2.5GT/s could result in exposing the same errata.  The changes here
are designed to handle this by retraining the switch downstream ports
to a reduced speed, but it has not been tested.

This balancing proceedure is only performed when ACS capabilities are
requested for the device.  Furthermore, since we are degrading the
performance of a link, we only enable this when the downstream port
connecting the switch is itself ACS capable.  This presumes that ACS
enabling is primarily intended for ioslation and if isolation has
already been compromised above, there's no reason to degrade the link
below.  In this case we'll see output like this to indicate the
reason ACS controls are not being enabled for the downstream switch
ports (here 02: devices are the downstream switch ports and 00:01.0 is
the PCIe root port lacking ACS support):

pci 0000:02:01.0: Ignoring PCI ACS capabilties due to lack of isolation at 0000:00:01.0
pci 0000:02:02.0: Ignoring PCI ACS capabilties due to lack of isolation at 0000:00:01.0
pci 0000:02:03.0: Ignoring PCI ACS capabilties due to lack of isolation at 0000:00:01.0

When balancing occurs, we log the balancing operations as:

pci 0000:00:1c.0: Link retrained to 2.5GT/s for PCI ACS support on 0000:03:01.0

00:1c.0 is the root port, 03:01.0 is the first downstream port.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=177471
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/quirks.c |  147 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44e0ff3..b6de69d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <linux/mm.h>
+#include <linux/iommu.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -4318,6 +4319,151 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	return 0;
 }
 
+/*
+ * This quirk is intended to apply to Pericom PCI Express 2.0, 4-lane switches
+ * with 3 or 4 ports, ex. PI7C9X2G404SL.
+ *
+ * These PCIe switches support ACS, but have an errata indicating that when
+ * P2P Request Redirection is enabled and bandwidth between the upstream and
+ * downstream port is unbalanced, packets are queued in the internal buffers
+ * until a "CLPD" packet arrives.  The effect is that the downstream devices
+ * do not work.  In the example in the below bz, a NIC can RX packets, but not
+ * TX.  The queuing issue remains even after clearing RR, a device reset is
+ * required to return to normal operation.  Workarounds for this issue are:
+ *
+ *  a) avoid enabling ACS RR on the downstream ports
+ *  b) balance the ports ourselves
+ *
+ * We attempt to do b), which involves checking whether the link at the
+ * downstream switch port matches the link connecting the upstream switch
+ * port.  If the two differ, pick the faster link and retraing it to match
+ * the slower link.  Once balanced, standard ACS capabilities may be enabled.
+ * If no balancing is required, directly enable ACS.
+ *
+ * NB, some systems will not reset the target link speed on system reboot,
+ * therefore retraining may not be necessary on warm reboots.
+ *
+ * NB, it's unclear whether link width factors into the definition of
+ * "unbalanced", but we have no mechanism to set the width via software, so
+ * we assume we're doing no worse than standard ACS enabling by balancing
+ * only the speed.
+ *
+ * https://bugzilla.kernel.org/show_bug.cgi?id=177471
+ */
+static int pci_quirk_match_links_and_enable_acs(struct pci_dev *dev)
+{
+	int acs_pos, ret;
+	u16 acs_cap;
+	enum pci_bus_speed dev_speed, parent_speed;
+	struct pci_dev *parent;
+
+	/* Initiate from downstream switch port */
+	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return -ENOTTY;
+
+	acs_pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!acs_pos)
+		return -ENOTTY;
+
+	pci_read_config_word(dev, acs_pos + PCI_ACS_CAP, &acs_cap);
+
+	/* If the caps we want to enable are not all supported, not our dev */
+	if ((acs_cap & IOMMU_REQ_PCI_ACS_FLAGS) != IOMMU_REQ_PCI_ACS_FLAGS)
+		return -ENOTTY;
+
+	/* Topology sanity check */
+	if (pci_is_root_bus(dev->bus) || pci_is_root_bus(dev->bus->self->bus))
+		return -ENOTTY;
+
+	ret = pcie_get_link(dev, &dev_speed, NULL);
+	if (ret)
+		return ret;
+
+	/*
+	 * From the downstream switch port, traverse two levels up to the
+	 * downsteam port above the upstream port.
+	 */
+	parent = dev->bus->self->bus->self;
+
+	ret = pcie_get_link(parent, &parent_speed, NULL);
+	if (ret)
+		return ret;
+
+	if (dev_speed == PCI_SPEED_UNKNOWN || parent_speed == PCI_SPEED_UNKNOWN)
+		return -EINVAL;
+
+	if (dev_speed != parent_speed) {
+		enum pci_bus_speed tgt_speed, new_speed;
+		struct pci_dev *tgt_dev;
+		u32 lnkcap2;
+		u16 lnkctl2;
+
+		/*
+		 * In order to balance links, we need to degrade one to make
+		 * it match the slower link.  Only do this if there's a chance
+		 * that enabling ACS on this device will actually be useful.
+		 * We won't presume to know where the IOMMU is in the system,
+		 * but we do know that it's not part of this switch.  If the
+		 * downstream port connecting us does not support a useful
+		 * set of ACS features, then degrading the link to enable ACS
+		 * serves no purpose, assuming IOMMU isolation is the primary
+		 * reason for enabling ACS.
+		 */
+		if (!pci_acs_enabled(parent, IOMMU_REQ_PCI_ACS_FLAGS)) {
+			dev_info(&dev->dev,
+				 "Ignoring PCI ACS capabilities due to lack of isolation at %s\n",
+				 pci_name(parent));
+			return 0;
+		}
+
+		/* We can only reduce the faster link to match slower */
+		tgt_dev = (dev_speed > parent_speed) ? dev : parent;
+		tgt_speed = min(dev_speed, parent_speed);
+
+		/* Test if Gen3 devices implement the target link speed */
+		ret = pcie_capability_read_dword(tgt_dev,
+						 PCI_EXP_LNKCAP2, &lnkcap2);
+		if (!ret && lnkcap2) {
+			if (!(lnkcap2 &
+			      (1 << (tgt_speed - PCIE_SPEED_2_5GT + 1))))
+				goto noacs;
+		}
+
+		/* Set target link speed, retrain, & verify result */
+		if (pcie_capability_read_word(tgt_dev,
+					      PCI_EXP_LNKCTL2, &lnkctl2))
+			goto noacs;
+
+		lnkctl2 &= ~PCI_EXP_LNKCAP_SLS;
+		lnkctl2 |= (tgt_speed - PCIE_SPEED_2_5GT + 1);
+
+		pcie_capability_write_word(tgt_dev, PCI_EXP_LNKCTL2, lnkctl2);
+
+		if (pcie_retrain_link(tgt_dev))
+			goto noacs;
+
+		if (pcie_get_link(tgt_dev, &new_speed, NULL))
+			goto noacs;
+
+		if (new_speed != tgt_speed)
+			goto noacs;
+
+		dev_info(&tgt_dev->dev, "Link retrained to %s"
+			 "GT/s for PCI ACS support on %s\n",
+			 tgt_speed == PCIE_SPEED_2_5GT ? "2.5" :
+			 tgt_speed == PCIE_SPEED_5_0GT ? "5.0" :
+			 tgt_speed == PCIE_SPEED_8_0GT ? "8.0" :
+			 "<unknown>", pci_name(dev));
+	}
+
+	pci_std_enable_acs(dev);
+	return 0;
+noacs:
+	dev_warn(&dev->dev,
+		 "Unable to balance links for PCI ACS, ACS not enabled\n");
+	return 0; /* Don't fall through to standard enabling */
+}
+
 static const struct pci_dev_enable_acs {
 	u16 vendor;
 	u16 device;
@@ -4325,6 +4471,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 } pci_dev_enable_acs[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_enable_intel_pch_acs },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_enable_intel_spt_pch_acs },
+	{ 0x12d8, 0x2404, pci_quirk_match_links_and_enable_acs },
 	{ 0 }
 };
 

