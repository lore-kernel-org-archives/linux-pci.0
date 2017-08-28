Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdH1Sdk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 14:33:40 -0400
Date: Mon, 28 Aug 2017 13:33:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v5 0/10] Some cleanup and bug fix for pcie-rockchip
Message-ID: <20170828183339.GI8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
 <20170825213838.GB8154@bhelgaas-glaptop.roam.corp.google.com>
 <c6e1a387-ee7b-1694-31d6-1b2f553e3d0f@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c6e1a387-ee7b-1694-31d6-1b2f553e3d0f@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 28, 2017 at 10:22:24AM +0800, Shawn Lin wrote:
> Hi Bjorn,
> 
> On 2017/8/26 5:38, Bjorn Helgaas wrote:
> >On Wed, Aug 23, 2017 at 03:01:13PM +0800, Shawn Lin wrote:
> >>
> 
> ...
> 
> >
> >I applied these to pci/host-rockchip except for these:
> >
> >   PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
> >   PCI: rockchip: fix missing phy manipulation for legacy phy
> >
> >I'm not really happy with the devm/clk_prepare_enable situation, so
> >I'm waiting to see if a better solution emerges.
> >
> >I went ahead and applied the tweaks I proposed to the earlier "PCI:
> >rockchip: Add per-lane PHY support" and "PCI: rockchip: Idle inactive
> >PHY(s)" patches.  I *think* those make the "fix missing phy
> >manipulation for legacy phy" patch unnecessary.
> >
> >But please take a look and make sure.  If I went the wrong direction,
> >I'll gladly back it out.
> 
> I tested both of legacy and per-lane PHY mode, and it works fine.
> 
> But just a nit:
> 
> with legacy PHY, we could avoid to print the following message
> which is confusing as for legacy PHY mode, we couldn't idle
> any inactive lanes.
> 
> [    0.655192] rockchip-pcie f8000000.pcie: idling lane 1
> [    0.655696] rockchip-pcie f8000000.pcie: idling lane 2
> [    0.656194] rockchip-pcie f8000000.pcie: idling lane 3
> 
> So I think we could return 0xf for legacy PHY mode like this:
> 
> static u8 rockchip_pcie_lane_map(struct rockchip_pcie *rockchip)
>         u8 map;
> 
>         if (rockchip->legacy_phy)
> -               return BIT(0);
> +               return GENMASK(MAX_LANE_NUM - 1, 0);

When we're using legacy PHY mode, this changes lanes_map from 0x1 to
0xf.  That means we won't print the "idling lane 1" message.  It
*also* means we won't call phy_power_off() for lanes 1-3.  Is that the
correct behavior?  Does the legacy PHY mode actually use all 4 PHYs?
