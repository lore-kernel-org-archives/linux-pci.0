Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Alex Barba <alex.barba@broadcom.com>,
	Oza Oza <oza.oza@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 05/12] PCI: iproc: Added PAXCv2 related binding
Date: Mon, 31 Oct 2016 17:38:34 -0700
Message-Id: <1477960721-17649-6-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
References: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

Add new compatible string "brcm,iproc-pcie-paxc-v2" to the iProc
PCIe device tree binding document. "brcm,iproc-pcie-paxc-v2" is for the
second generation of the Broadcom iProc PCIe PAXC host controller

Also updated the binding document with more detailed description of
each compatible string and compatible SoCs

Finally, added description of optional property "msi-map", for use with
MSI controllers with sideband data

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 ++++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index 01b88f4..071bbc2 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -1,10 +1,15 @@
 * Broadcom iProc PCIe controller with the platform bus interface
 
 Required properties:
-- compatible: Must be "brcm,iproc-pcie" for PAXB, or "brcm,iproc-pcie-paxc"
-  for PAXC.  PAXB-based root complex is used for external endpoint devices.
-  PAXC-based root complex is connected to emulated endpoint devices
-  internal to the ASIC
+- compatible:
+      "brcm,iproc-pcie" for the first generation of PAXB based controller,
+used in SoCs including NSP, Cygnus, NS2, and Pegasus
+      "brcm,iproc-pcie-paxc" for the first generation of PAXC based
+controller, used in NS2
+      "brcm,iproc-pcie-paxc-v2" for the second generation of PAXC based
+controller, used in Stingray
+  PAXB-based root complex is used for external endpoint devices. PAXC-based
+root complex is connected to emulated endpoint devices internal to the ASIC
 - reg: base address and length of the PCIe controller I/O register space
 - #interrupt-cells: set to <1>
 - interrupt-map-mask and interrupt-map, standard PCI properties to define the
@@ -19,6 +24,7 @@ Required properties:
 Optional properties:
 - phys: phandle of the PCIe PHY device
 - phy-names: must be "pcie-phy"
+- dma-coherent: present if DMA operations are coherent
 
 - brcm,pcie-ob: Some iProc SoCs do not have the outbound address mapping done
 by the ASIC after power on reset. In this case, SW needs to configure it
@@ -41,10 +47,19 @@ For older platforms without MSI integrated in the GIC, iProc PCIe core provides
 an event queue based MSI support.  The iProc MSI uses host memories to store
 MSI posted writes in the event queues
 
-- msi-parent: Link to the device node of the MSI controller.  On newer iProc
-platforms, the MSI controller may be gicv2m or gicv3-its.  On older iProc
-platforms without MSI support in its interrupt controller, one may use the
-event queue based MSI support integrated within the iProc PCIe core.
+On newer iProc platforms, gicv2m or gicv3-its based MSI support should be used
+
+- msi-map: Maps a Requester ID to an MSI controller and associated MSI
+sideband data
+
+- msi-parent: Link to the device node of the MSI controller, used when no MSI
+sideband data is passed between the iProc PCIe controller and the MSI
+controller
+
+Refer to the following binding documents for more detailed description on
+the use of 'msi-map' and 'msi-parent':
+  Documentation/devicetree/bindings/pci/pci-msi.txt
+  Documentation/devicetree/bindings/interrupt-controller/msi.txt
 
 When the iProc event queue based MSI is used, one needs to define the
 following properties in the MSI device node:
-- 
2.1.4
