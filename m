Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:51609 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754106AbdLSXbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 18:31:41 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: lorenzo.pieralisi@arm.com, linux-arm-kernel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/18] bindings: PCI: artpec: Add support for the ARTPEC-7 SoC
Date: Wed, 20 Dec 2017 00:29:38 +0100
Message-Id: <20171219232940.659-18-niklas.cassel@axis.com>
In-Reply-To: <20171219232940.659-1-niklas.cassel@axis.com>
References: <20171219232940.659-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for the ARTPEC-7 SoC in the artpec6 driver.
The ARTPEC-6 SoC and the ARTPEC-7 SoC are very similar.
Unfortunately, some fields in the PCIECFG and PCIESTAT
register have changed.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index 33eef7ae5a23..979dc7b6cfe8 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -6,6 +6,8 @@ and thus inherits all the common properties defined in designware-pcie.txt.
 Required properties:
 - compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
 	      "axis,artpec6-pcie-ep", "snps,dw-pcie" for ARTPEC-6 in EP mode;
+	      "axis,artpec7-pcie", "snps,dw-pcie" for ARTPEC-7 in RC mode;
+	      "axis,artpec7-pcie-ep", "snps,dw-pcie" for ARTPEC-7 in EP mode;
 - reg: base addresses and lengths of the PCIe controller (DBI),
 	the PHY controller, and configuration address space.
 - reg-names: Must include the following entries:
-- 
2.14.2
