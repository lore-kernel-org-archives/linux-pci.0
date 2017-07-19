Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:59108 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbdGSJ4A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 05:56:00 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 0/7] Reconstruct rockchip's PCIe and PCIe-PHY driver for per-lane PHY model
Date: Wed, 19 Jul 2017 17:55:11 +0800
Message-Id: <1500458118-139042-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


This patchset is trying to reconstruct PCIe and PCIe-PHY driver
for rockchip platform in order to support per-lane PHY mode. And
we could idle the inactive lane(s) finally.

We deprecate the legacy PHY mode but the code could still
support it in order not to break backware compatibility of DTB. And I
organize the patches carefully so that we don't introduce git-bisect
issue.

Patchset was reviewed by Brian and fully tested by Jeffy. Rob acked
patch 6 & 7. Kishon acked patch 1, 2 and 4, and will ack patch 3 once
this patch 3 of v5 looks good.

Patch 5 for DTS changes for Rockchip part still need ack from Heiko, and
it would be fine for Heiko to pick it up after pcie and pcie-phy changes
got merged.

It would be fine for Bjorn to pick all these patches up to narrow down
the timing gap for testing linux-next. :)


Changes in v5:
- don't create more number of phys if it's legacy PHY model

Changes in v4:
- use err variable to check return value of
  rockchip_pcie_get_phys
- add Brian's tag
- move rockchip_pcie_get_phys to where it stands in
  patch 1.
- print PHY index in err output log
- return u8 for rockchip_pcie_lane_map

Changes in v3:
- kill rockchip_pcie_manipulate_phys and related stuff
- use phys array
- improve the commit msg
- remove unnecessary forward declaration
- keep mutex inside struct rockchip_pcie_phy
- fix wrong check of args number
- move de-idle lanes after deasserting the reset
- use cached lanes_map to avoid powering off inactive
  lanes twice
- rename the commit tile

Changes in v2:
- deprecate legacy PHY model
- improve rockchip_pcie_phy_of_xlate
- fix wrong calculation of pwr_cnt and add new init_cnt
- add internal locking
- introduce per-lane data to simply the code

Shawn Lin (7):
  PCI: rockchip: split out rockchip_pcie_get_phys
  PCI: rockchip: introduce per-lanes PHYs support
  phy: rockcip-pcie: reconstruct driver to support per-lane PHYs
  PCI: rockchip: idle the inactive PHY(s)
  arm64: dts: rockchip: convert PCIe to use per-lane PHYs for rk3339
  dt-bindings: PCI: rockchip: convert to use per-lane PHY model
  dt-bindings: phy: convert to use per-lane Rockchip PCIe PHY

 .../devicetree/bindings/pci/rockchip-pcie.txt      |  25 +++-
 .../devicetree/bindings/phy/rockchip-pcie-phy.txt  |   7 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   8 +-
 drivers/pci/host/pcie-rockchip.c                   | 122 +++++++++++++++----
 drivers/phy/rockchip/phy-rockchip-pcie.c           | 132 ++++++++++++++++++---
 5 files changed, 253 insertions(+), 41 deletions(-)

-- 
1.9.1
