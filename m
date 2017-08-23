Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:49339 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWHCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:02:32 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 0/10] Some cleanup and bug fix for pcie-rockchip
Date: Wed, 23 Aug 2017 15:01:13 +0800
Message-Id: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Bjorn,

Patch 1 -> 4 are for what you suggested in my V4
of bug fixing[1].

Patch 5 -> 7 are sloving what I said for my former
patch of PHY cleanup[2]. It seems you didn't see my
V2 of that[3], and my v2 also have some minor issues
that was fixed by Jeffy's patch[4]. So these patches in
flight for cleaning up the pcie-rockchip error handling
path which would conflict with each other. I merge the
similar PHY cleanup from patch[4].

Also I think we need to split it[4] up into smaller pieces.
So patch 8 -> 10 are for this purpose and avoid Jeffy to
rebase this work again.

Could you kindly drop patch[2] from your host-rockchip branch
and apply this patchset if it looks good to you? :)

[1]: https://patchwork.kernel.org/patch/9895141/
[2]: https://patchwork.kernel.org/patch/9890367/
[3]: https://patchwork.kernel.org/patch/9892461/
[4]: http://patchwork.ozlabs.org/patch/804239/


Changes in v5:
- rebase on former reconstrtion patches suggested by Bjorn
- fix all the missing error handling cases that need to cleanup
  PHY

Changes in v4:
- split out rockchip_pcie_enable_clocks and reuse
  rockchip_pcie_enable_clocks and rockchip_pcie_disable_clocks
  for elsewhere suggested by Jeffy

Changes in v3:
- check the return value of devm_add_action_or_reset and spilt out
  rockchip_pcie_setup_irq in order to move requesting irq after
  enabling clks.

Changes in v2:
- use devm_add_action_or_reset to fix this ordering suggested by
  Heiko and Jeffy. Thanks!

Jeffy Chen (3):
  PCI: rockchip: disable vpcie0v9 for resume_noirq error handling path
  PCI: rockchip: remove irq domain if failing to probe
  PCI: rockchip: umap io space if failing to probe

Shawn Lin (7):
  PCI: rockchip: spilt out rockchip_pcie_setup_irq
  PCI: rockchip: spilt out rockchip_pcie_enable_clocks
  PCI: rockchip: spilt out rockchip_pcie_disable_clocks
  PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
  PCI: rockchip: spilt out rockchip_pcie_deinit_phys
  PCI: rockchip: fix missing phy manipulation for legacy phy
  PCI: rockchip: Clean up PHY if driver probe or resume fails

 drivers/pci/host/pcie-rockchip.c | 297 ++++++++++++++++++++++-----------------
 1 file changed, 166 insertions(+), 131 deletions(-)

-- 
1.9.1
