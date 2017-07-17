Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:33193 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdGQJad (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 05:30:33 -0400
Message-ID: <596C83AD.7070003@rock-chips.com>
Date: Mon, 17 Jul 2017 17:30:21 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/7] Reconstruct rockchip's PCIe and PCIe-PHY driver
 for per-lane PHY model
References: <1500276982-208439-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1500276982-208439-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

On 07/17/2017 03:36 PM, Shawn Lin wrote:
> This patchset is trying to reconstruct PCIe and PCIe-PHY driver
> for rockchip platform in order to support per-lane PHY mode. And
> we could idle the inactive lane(s) finally.
>
> We deprecate the legacy PHY mode but the code could still support
> it in order not to break backware compatibility of DTB. And I organize
> the patches carefully so that we don't introduce git-bisect issue.
>
> Hi Brian & Jeffy,
>
> I tested it by backporting all things into my kernel 4.4 tree, and it
> works fine for both legacy PHY mode and per-lane PHY model. However I
> couldn't run 4.12 for my rk3399-evb now, so it would be nice if you
> can test it with your chrome devices running v4.12.
I tested these patches on my chromebook bob(based on next-20170714), 
pcie/pcie wifi(mrvl 8997) work well, and bind/unbind suspend/resume 
shows unused lanes powered off as expected.

Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>

>
> Hi Rob,
>
> Does the changes for rockchip-pcie.txt in patch 6 & 7 look good to you
> from the perspective of DT?
>
>
> Changes in v2:
> - deprecate legacy PHY model
> - improve rockchip_pcie_phy_of_xlate
> - fix wrong calculation of pwr_cnt and add new init_cnt
> - add internal locking
> - introduce per-lane data to simply the code
> - convert that for all rk3399 platforms
> - make listing all 4 lanes as mandatory
>
> Shawn Lin (7):
>    PCI: rockchip: split out rockchip_pcie_get_phys
>    PCI: rockchip: introduce per-lanes PHYs support
>    phy: rockcip-pcie: reconstruct driver to support per-lane PHYs
>    PCI: rockchip: idle the inactive PHY(s)
>    arm64: dts: rockchip: convert PCIe to use per-lane PHYs for rk3339
>    dt-bindings: PCI: rockchip: convert to use per-lane PHY model
>    Documentation: bindings: convert to use per-lane Rockchip PCIe PHY
>
>   .../devicetree/bindings/pci/rockchip-pcie.txt      |  25 ++-
>   .../devicetree/bindings/phy/rockchip-pcie-phy.txt  |   7 +-
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   8 +-
>   drivers/pci/host/pcie-rockchip.c                   | 168 ++++++++++++++++++---
>   drivers/phy/rockchip/phy-rockchip-pcie.c           | 128 ++++++++++++++--
>   5 files changed, 297 insertions(+), 39 deletions(-)
>
