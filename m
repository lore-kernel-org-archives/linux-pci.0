Return-Path: <SRS0=Lhk4=5F=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=Lhk4=5F=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: [PATCH v5 1/3] PCI: Add DT binding for tango PCIe controller
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
CC: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David Laight
	<david.laight@aculab.com>, linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Phuong Nguyen
	<phuong_nguyen@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>, DT
	<devicetree@vger.kernel.org>, Mason <slash.tmp@free.fr>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
Message-ID: <69f3ffe7-3c39-fa94-71f8-91744a869cc9@sigmadesigns.com>
Date: Wed, 31 May 2017 15:30:26 +0200
MIME-Version: 1.0
In-Reply-To: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

Binding for the Sigma Designs SMP8759 SoC.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 Documentation/devicetree/bindings/pci/tango-pcie.txt | 30 ++++++++++++++++=
++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documen=
tation/devicetree/bindings/pci/tango-pcie.txt
new file mode 100644
index 000000000000..35ef2c811a27
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
@@ -0,0 +1,30 @@
+Sigma Designs Tango PCIe controller
+
+Required properties:
+
+- compatible: "sigma,smp8759-pcie"
+- reg: address/size of PCI configuration space, address/size of register a=
rea
+- device_type: "pci"
+- #size-cells: <2>
+- #address-cells: <3>
+- msi-controller
+- ranges: translation from system to bus addresses
+- interrupts: spec for misc interrupts, spec for MSI
+
+http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
+http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
+
+Example:
+
+=09pcie@2e000 {
+=09=09compatible =3D "sigma,smp8759-pcie";
+=09=09reg =3D <0x50000000 SZ_4M>, <0x2e000 0x100>;
+=09=09device_type =3D "pci";
+=09=09#size-cells =3D <2>;
+=09=09#address-cells =3D <3>;
+=09=09msi-controller;
+=09=09ranges =3D <0x02000000 0x0 0x00400000  0x50400000  0x0 SZ_60M>;
+=09=09interrupts =3D
+=09=09=09<54 IRQ_TYPE_LEVEL_HIGH>, /* misc interrupts */
+=09=09=09<55 IRQ_TYPE_LEVEL_HIGH>; /* MSI */
+=09};
--=20
2.11.0
