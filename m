Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: lorenzo.pieralisi@arm.com, linux-arm-kernel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/18] bindings: PCI: artpec: Add support for endpoint mode
Date: Wed, 20 Dec 2017 00:29:34 +0100
Message-Id: <20171219232940.659-14-niklas.cassel@axis.com>
In-Reply-To: <20171219232940.659-1-niklas.cassel@axis.com>
References: <20171219232940.659-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe controller integrated in ARTPEC-6 SoCs is capable of operating in
endpoint mode. Add endpoint mode support to the artpec6 driver.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Acked-by: Rob Herring <robh@kernel.org>
---
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
