Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:51660 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbdGNDst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2017 23:48:49 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 0/6] Reconstruct rockchip's PCIe and PCIe-PHY driver for per-lane PHY model
Date: Fri, 14 Jul 2017 11:48:15 +0800
Message-Id: <1500004101-240296-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


This patchset is trying to reconstruct PCIe and PCIe-PHY driver
for rockchip platform in order to support per-lane PHY mode. And
we could idle the inactive lane(s) finally.

We deprecate the legacy PHY mode but the code could still support
it in order not to break backware compatibility of DTB. And I organize
the patches carefully so that we don't introduce git-bisect issue.

Hi Brian & Jeffy,

I tested it by backporting all things into my kernel 4.4 tree, and it
works fine for both legacy PHY mode and per-lane PHY model. However I
couldn't run 4.12 for my rk3399-evb now, so could you please help test
it on your Chromebook devices which can run 4.12?

Hi Rob,

Does the changes for rockchip-pcie.txt in patch 6 look good to you
from the perspective of DT?



Shawn Lin (6):
  PCI: rockchip: split out rockchip_pcie_get_phys
  PCI: rockchip: introduce per-lanes PHYs support
  phy: rockcip-pcie: reconstruct driver to support per-lane PHYs
  PCI: rockchip: idle the inactive PHY(s)
  arm64: dts: rockchip: convert PCIe to use per-lane PHYs for rk3339-evb
  dt-bindings: PCI: rockchip: convert to use per-lane PHY model

 .../devicetree/bindings/pci/rockchip-pcie.txt      |  25 +++-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |   2 +
 drivers/pci/host/pcie-rockchip.c                   | 162 ++++++++++++++++++---
 drivers/phy/rockchip/phy-rockchip-pcie.c           | 116 +++++++++++++--
 4 files changed, 269 insertions(+), 36 deletions(-)

-- 
1.9.1
