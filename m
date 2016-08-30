Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55585 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758411AbcH3M5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2016 08:57:22 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Joao Pinto <jpinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <galak@codeaurora.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Yehuda Yitschak <yehuday@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/3] dt-bindings: designware-pcie: document optional msi-parent property
Date: Tue, 30 Aug 2016 14:57:08 +0200
Message-Id: <1472561830-20932-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit updates the Designware PCIe Device Tree binding
documentation to document the optional msi-parent property. This
property allows to point to an external MSI controller, which can
optionally be provided. If provided, this external MSI controller is
used in preference over the internal MSI controller of the Designware
PCIe IP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 6c5322c..7a729bb 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -28,6 +28,8 @@ Optional properties:
 - clock-names: Must include the following entries:
 	- "pcie"
 	- "pcie_bus"
+- msi-parent: Pointer to an external MSI controller. If not provided,
+  the built-in MSI controller is used.
 
 Example configuration:
 
-- 
2.7.4

