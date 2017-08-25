Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755512AbdHYVil (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Aug 2017 17:38:41 -0400
Date: Fri, 25 Aug 2017 16:38:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v5 0/10] Some cleanup and bug fix for pcie-rockchip
Message-ID: <20170825213838.GB8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 03:01:13PM +0800, Shawn Lin wrote:
> 
> Hi Bjorn,
> 
> Patch 1 -> 4 are for what you suggested in my V4
> of bug fixing[1].
> 
> Patch 5 -> 7 are sloving what I said for my former
> patch of PHY cleanup[2]. It seems you didn't see my
> V2 of that[3], and my v2 also have some minor issues
> that was fixed by Jeffy's patch[4]. So these patches in
> flight for cleaning up the pcie-rockchip error handling
> path which would conflict with each other. I merge the
> similar PHY cleanup from patch[4].
> 
> Also I think we need to split it[4] up into smaller pieces.
> So patch 8 -> 10 are for this purpose and avoid Jeffy to
> rebase this work again.
> 
> Could you kindly drop patch[2] from your host-rockchip branch
> and apply this patchset if it looks good to you? :)
> 
> [1]: https://patchwork.kernel.org/patch/9895141/
> [2]: https://patchwork.kernel.org/patch/9890367/
> [3]: https://patchwork.kernel.org/patch/9892461/
> [4]: http://patchwork.ozlabs.org/patch/804239/
> 
> 
> Changes in v5:
> - rebase on former reconstrtion patches suggested by Bjorn
> - fix all the missing error handling cases that need to cleanup
>   PHY
> 
> Changes in v4:
> - split out rockchip_pcie_enable_clocks and reuse
>   rockchip_pcie_enable_clocks and rockchip_pcie_disable_clocks
>   for elsewhere suggested by Jeffy
> 
> Changes in v3:
> - check the return value of devm_add_action_or_reset and spilt out
>   rockchip_pcie_setup_irq in order to move requesting irq after
>   enabling clks.
> 
> Changes in v2:
> - use devm_add_action_or_reset to fix this ordering suggested by
>   Heiko and Jeffy. Thanks!
> 
> Jeffy Chen (3):
>   PCI: rockchip: disable vpcie0v9 for resume_noirq error handling path
>   PCI: rockchip: remove irq domain if failing to probe
>   PCI: rockchip: umap io space if failing to probe
> 
> Shawn Lin (7):
>   PCI: rockchip: spilt out rockchip_pcie_setup_irq
>   PCI: rockchip: spilt out rockchip_pcie_enable_clocks
>   PCI: rockchip: spilt out rockchip_pcie_disable_clocks
>   PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
>   PCI: rockchip: spilt out rockchip_pcie_deinit_phys
>   PCI: rockchip: fix missing phy manipulation for legacy phy
>   PCI: rockchip: Clean up PHY if driver probe or resume fails
> 
>  drivers/pci/host/pcie-rockchip.c | 297 ++++++++++++++++++++++-----------------
>  1 file changed, 166 insertions(+), 131 deletions(-)

I applied these to pci/host-rockchip except for these:

  PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
  PCI: rockchip: fix missing phy manipulation for legacy phy

I'm not really happy with the devm/clk_prepare_enable situation, so
I'm waiting to see if a better solution emerges.

I went ahead and applied the tweaks I proposed to the earlier "PCI:
rockchip: Add per-lane PHY support" and "PCI: rockchip: Idle inactive
PHY(s)" patches.  I *think* those make the "fix missing phy
manipulation for legacy phy" patch unnecessary.

But please take a look and make sure.  If I went the wrong direction,
I'll gladly back it out.

Bjorn
