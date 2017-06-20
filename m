Return-Path: <SRS0=nDxn=5Z=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=nDxn=5Z=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: [PATCH v9 1/3] PCI: Add DT binding for tango PCIe controller
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
CC: linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	DT <devicetree@vger.kernel.org>, Mason <slash.tmp@free.fr>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
Message-ID: <0e6ef385-7634-cde5-198f-ea16267bf5c2@sigmadesigns.com>
Date: Tue, 20 Jun 2017 10:14:33 +0200
MIME-Version: 1.0
In-Reply-To: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

Binding for the Sigma Designs SMP8759 SoC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 .../devicetree/bindings/pci/tango-pcie.txt         | 29 ++++++++++++++++++=
++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documen=
tation/devicetree/bindings/pci/tango-pcie.txt
new file mode 100644
index 000000000000..244683836a79
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
@@ -0,0 +1,29 @@
+Sigma Designs Tango PCIe controller
+
+Required properties:
+
+- compatible: "sigma,smp8759-pcie"
+- reg: address/size of PCI configuration space, address/size of register a=
rea
+- bus-range: defined by size of PCI configuration space
+- device_type: "pci"
+- #size-cells: <2>
+- #address-cells: <3>
+- msi-controller
+- ranges: translation from system to bus addresses
+- interrupts: spec for misc interrupts, spec for MSI
+
+Example:
+
+=09pcie@2e000 {
+=09=09compatible =3D "sigma,smp8759-pcie";
+=09=09reg =3D <0x50000000 0x400000>, <0x2e000 0x100>;
+=09=09bus-range =3D <0 3>;
+=09=09device_type =3D "pci";
+=09=09#size-cells =3D <2>;
+=09=09#address-cells =3D <3>;
+=09=09msi-controller;
+=09=09ranges =3D <0x02000000 0x0 0x00400000  0x50400000  0x0 0x3c00000>;
+=09=09interrupts =3D
+=09=09=09<54 IRQ_TYPE_LEVEL_HIGH>, /* misc interrupts */
+=09=09=09<55 IRQ_TYPE_LEVEL_HIGH>; /* MSI */
+=09};
--=20
2.11.0
