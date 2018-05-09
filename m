Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:40980 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeEIBU6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2018 21:20:58 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 4/7] dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to rockchip-pcie-host.txt
Date: Wed,  9 May 2018 09:12:45 +0800
Message-Id: <1525828365-70040-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1525828278-69800-1-git-send-email-shawn.lin@rock-chips.com>
References: <1525828278-69800-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just make it more obvious that this documentation is referenced for
adding Rockchip PCIe controller as RC mode.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None

 .../devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
similarity index 100%
rename from Documentation/devicetree/bindings/pci/rockchip-pcie.txt
rename to Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
-- 
1.9.1
