Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:46955 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeBGCyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Feb 2018 21:54:23 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/6] PCI: rockchip: Add rockchip,rk3399-pcie-host compatible
Date: Wed,  7 Feb 2018 10:47:28 +0800
Message-Id: <1517971650-61555-5-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1517971650-61555-1-git-send-email-shawn.lin@rock-chips.com>
References: <1517971650-61555-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To avoid confusion when folks use this controller as endponint
mode, we add rockchip,rk3399-pcie-host to clearly state that
it's driver for host here. And rename/update the document to
reflect this fact.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 .../bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt}         | 3 ++-
 drivers/pci/rockchip/pcie-rockchip-host.c                              | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (98%)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
similarity index 98%
rename from Documentation/devicetree/bindings/pci/rockchip-pcie.txt
rename to Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
index af34c65..f2f3091 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
@@ -5,7 +5,8 @@ Required properties:
 - #size-cells: Size representation for root ports, set to <2>
 - #interrupt-cells: specifies the number of cells needed to encode an
 		interrupt source. The value must be 1.
-- compatible: Should contain "rockchip,rk3399-pcie"
+- compatible: Should contain "rockchip,rk3399-pcie" or
+	"rockchip,rk3399-pcie-host"
 - reg: Two register ranges as listed in the reg-names property
 - reg-names: Must include the following names
 	- "axi-base"
diff --git a/drivers/pci/rockchip/pcie-rockchip-host.c b/drivers/pci/rockchip/pcie-rockchip-host.c
index f5b0492..efb740d 100644
--- a/drivers/pci/rockchip/pcie-rockchip-host.c
+++ b/drivers/pci/rockchip/pcie-rockchip-host.c
@@ -1120,6 +1120,7 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 
 static const struct of_device_id rockchip_pcie_of_match[] = {
 	{ .compatible = "rockchip,rk3399-pcie", },
+	{ .compatible = "rockchip,rk3399-pcie-host", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rockchip_pcie_of_match);
-- 
1.9.1
