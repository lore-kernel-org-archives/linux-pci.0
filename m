Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 2/2] PCI/ACPI: Request LTR control from platform before
 using it
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@codeaurora.org>,
        Rajat Jain <rajatja@google.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-acpi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 19 Apr 2018 16:05:36 -0500
Message-ID: <152417193680.76853.4784033544317115756.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152417080402.76853.4258398181136860884.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152417080402.76853.4258398181136860884.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Per the PCI Firmware spec r3.2, sec 4.5, an ACPI-based OS should use _OSC
to request control of Latency Tolerance Reporting (LTR) before using it.

Request control of LTR, and if the platform does not grant control, don't
use it.

N.B. If the hardware supports LTR and the ASPM L1.2 substate but the BIOS
doesn't support LTR in _OSC, we previously would enable ASPM L1.2.  This
patch will prevent us from enabling ASPM L1.2 in that case.  It does not
prevent us from enabling PCI-PM L1.2, since that doesn't depend on LTR.
See PCIe r40, sec 5.5.1, for the L1 PM substate entry conditions.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |    7 +++++++
 drivers/pci/probe.c     |    5 +++++
 include/linux/acpi.h    |    3 ++-
 include/linux/pci.h     |    1 +
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 0da18bde6a16..f32d767e8e3b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -153,6 +153,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_PME_CONTROL, "PME" },
 	{ OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
 	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
+	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
 };
 
 static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
@@ -475,6 +476,10 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 		| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
 		| OSC_PCI_EXPRESS_PME_CONTROL;
 
+#ifdef CONFIG_PCIEASPM
+	control |= OSC_PCI_EXPRESS_LTR_CONTROL;
+#endif
+
 	if (pci_aer_available()) {
 		if (aer_acpi_firmware_first())
 			dev_info(&device->dev,
@@ -905,6 +910,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		host_bridge->native_aer = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
 		host_bridge->native_pme = 0;
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
+		host_bridge->native_ltr = 0;
 
 	pci_scan_child_bus(bus);
 	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6fd0bcd..cc1688d75664 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -554,6 +554,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 	bridge->native_aer = 1;
 	bridge->native_hotplug = 1;
 	bridge->native_pme = 1;
+	bridge->native_ltr = 1;
 
 	return bridge;
 }
@@ -1954,9 +1955,13 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 static void pci_configure_ltr(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCIEASPM
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	u32 cap;
 	struct pci_dev *bridge;
 
+	if (!host->native_ltr)
+		return;
+
 	if (!pci_is_pcie(dev))
 		return;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 15bfb15c2fa5..49f63c67a9d1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -506,7 +506,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_EXPRESS_PME_CONTROL		0x00000004
 #define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
 #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
-#define OSC_PCI_CONTROL_MASKS			0x0000001f
+#define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
+#define OSC_PCI_CONTROL_MASKS			0x0000003f
 
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73178a2fcee0..d0149c01996d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -473,6 +473,7 @@ struct pci_host_bridge {
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_hotplug:1;	/* OS may use PCIe hotplug */
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
+	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
