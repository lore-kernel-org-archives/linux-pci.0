Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:42979 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBWBWq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Feb 2018 20:22:46 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 4/6] dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to rockchip-pcie-host.txt
Date: Fri, 23 Feb 2018 09:17:03 +0800
Message-Id: <1519348623-243549-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1519348503-243259-1-git-send-email-shawn.lin@rock-chips.com>
References: <1519348503-243259-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just make it more obvious that this documentation is referenced for
adding Rockchip PCIe controller as root complex mode.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- remove rockchip,rk3399-pcie-host compatible(Suggested by Rob)

 .../devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
similarity index 100%
rename from Documentation/devicetree/bindings/pci/rockchip-pcie.txt
rename to Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
-- 
1.9.1
