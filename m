Return-Path: <SRS0=+FHt=72=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=+FHt=72=broadcom.com=oza.oza@kernel.org>
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	<helgaas@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Oza Pawandeep <oza.oza@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v4 3/3] dt-bindings: PCI iproc: add optional property prsnt-gpios
Date: Thu, 24 Aug 2017 14:19:08 +0530
Message-Id: <1503564548-1834-4-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1503564548-1834-1-git-send-email-oza.oza@broadcom.com>
References: <1503564548-1834-1-git-send-email-oza.oza@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

Add description for optional device tree property
'prsnt-gpios' for PCI hotplug feature.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index b8e48b4..0c5f631 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -72,6 +72,20 @@ Optional properties:
 - brcm,pcie-msi-inten: Needs to be present for some older iProc platforms that
 require the interrupt enable registers to be set explicitly to enable MSI
 
+Optional properties:
+- slot-pluggable: PCI hotplug feature is supported.
+- prsnt-gpios: Array of gpios, needs to be present if Hotplug is supported.
+
+Refer to the following binding documents for more detailed description on
+the use of 'slot-pluggable' and 'prsnt-gpios'.
+  Documentation/devicetree/bindings/pci/pci.txt
+
+Example:
+prsnt-gpios: <&pca9505 32 1>, <&pca9505 33 1>;
+This is x4 connector: monitoring max 2 present lines.
+prsnt-gpios: <&pca9505 32 1>, <&pca9505 33 1>, <&pca9505 34 1>;
+This is x8 connector: monitoring max 3 present lines.
+
 Example:
 	pcie0: pcie@18012000 {
 		compatible = "brcm,iproc-pcie";
-- 
1.9.1
