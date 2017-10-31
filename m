Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/17] bindings: PCI: artpec: Add support for endpoint mode
Date: Tue, 31 Oct 2017 23:39:31 +0100
Message-Id: <20171031223936.27549-14-niklas.cassel@axis.com>
In-Reply-To: <20171031223936.27549-1-niklas.cassel@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V3:
* No change.

 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index 4e4aee4439ea..33eef7ae5a23 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsys DesignWare PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
-- compatible: "axis,artpec6-pcie", "snps,dw-pcie"
+- compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
+	      "axis,artpec6-pcie-ep", "snps,dw-pcie" for ARTPEC-6 in EP mode;
 - reg: base addresses and lengths of the PCIe controller (DBI),
 	the PHY controller, and configuration address space.
 - reg-names: Must include the following entries:
-- 
2.14.2
