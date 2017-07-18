Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34634 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbdGRU3z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 16:29:55 -0400
Received: by mail-pg0-f45.google.com with SMTP id 123so18619892pgj.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 13:29:55 -0700 (PDT)
Date: Tue, 18 Jul 2017 13:29:52 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/7] Reconstruct rockchip's PCIe and PCIe-PHY
 driver for per-lane PHY model
Message-ID: <20170718202951.GA116895@google.com>
References: <1500364623-97041-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500364623-97041-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 18, 2017 at 03:56:56PM +0800, Shawn Lin wrote:
> 
> This patchset is trying to reconstruct PCIe and PCIe-PHY driver
> for rockchip platform in order to support per-lane PHY mode. And
> we could idle the inactive lane(s) finally.
> 
> We deprecate the legacy PHY mode but the code could still
> support it in order not to break backware compatibility of DTB. And I
> organize the patches carefully so that we don't introduce git-bisect
> issue.
> 
> Note that I carry on Jeffy's test tag from v2 as he has locally tested
> my v3 patchset.

I have a few nits for the patchset (will reply shortly), but otherwise
(if we're *really* going to go with this approach; I still would
appreciate a reply from Kishon on the original patchset, where I
suggested alternatives) at least the code is much better this time
around. So for the whole thing:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> Changes in v3:
> - kill rockchip_pcie_manipulate_phys and related stuff
> - use phys array
> - improve the commit msg
> - remove unnecessary forward declaration
> - keep mutex inside struct rockchip_pcie_phy
> - fix wrong check of args number
> - move de-idle lanes after deasserting the reset
> - use cached lanes_map to avoid powering off inactive
>   lanes twice
> - rename the commit tile
> 
> Changes in v2:
> - deprecate legacy PHY model
> - improve rockchip_pcie_phy_of_xlate
> - fix wrong calculation of pwr_cnt and add new init_cnt
> - add internal locking
> - introduce per-lane data to simply the code
> 
> Shawn Lin (7):
>   PCI: rockchip: split out rockchip_pcie_get_phys
>   PCI: rockchip: introduce per-lanes PHYs support
>   phy: rockcip-pcie: reconstruct driver to support per-lane PHYs
>   PCI: rockchip: idle the inactive PHY(s)
>   arm64: dts: rockchip: convert PCIe to use per-lane PHYs for rk3339
>   dt-bindings: PCI: rockchip: convert to use per-lane PHY model
>   dt-bindings: phy: convert to use per-lane Rockchip PCIe PHY
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt      |  25 ++++-
>  .../devicetree/bindings/phy/rockchip-pcie-phy.txt  |   7 +-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   8 +-
>  drivers/pci/host/pcie-rockchip.c                   | 123 ++++++++++++++++----
>  drivers/phy/rockchip/phy-rockchip-pcie.c           | 124 ++++++++++++++++++---
>  5 files changed, 245 insertions(+), 42 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
