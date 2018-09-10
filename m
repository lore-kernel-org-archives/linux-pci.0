Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <ulf.hansson@linaro.org>, <honghui.zhang@mediatek.com>,
        <hongkun.cao@mediatek.com>, <youlin.pei@mediatek.com>,
        <yong.wu@mediatek.com>, <yt.shen@mediatek.com>,
        <sean.wang@mediatek.com>, <xinping.qian@mediatek.com>
Subject: [PATCH v4 0/4] PCI: mediatek: fixup find_port, enable_msi and add pm, module support
Date: Mon, 10 Sep 2018 17:50:19 +0800
Message-ID: <1536573023-6720-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

This patchset includes misc patchs:

The first patch fixup the mtk_pcie_find_port logical which will cause system
could not touch the EP's configuration space which was connected to PCIe slot 1.

The second patch fixup the enable msi logical, the operation to enable msi
should be after system clock is enabled. The function of mtk_pcie_startup_port_v2's
define location is re-arranged to avoid mtk_pcie_enable_msi's forward declaration.
And call mtk_pcie_enable_msi in mtk_pcie_startup_port_v2 since the clock was all
enabled at that time.

The third patch was rebased and refactor of the v4 patch[1], changes are:
 -Add PM support for MT7622.
 -Using mtk_pcie_enable_port to re-establish the link when resumed.
 -Rebase on the previous two patches.

The fourth patch add loadable kernel module support.

Some of those patches was already reviewed-by Ryder Lee <ryder.lee@mediatek.com>,
so I just add the Reviewed-by tags in those patches.

[1] https://patchwork.kernel.org/patch/10479079

Change since v3:
 - Remove pm_runtime_XXX ops in suspend and resume callbacks in the third patch.
 - Rebase to 4.19-rc1.

Change since v2:
 - Fix the list_for_each_entry_safe parameter error.
 - Add Ryder's Acked-by flag.

Change since v1:
 - A bit of code refact of the first patch suggested by Andy Shevchenko, and
   commit message updated.
 - Using __maybe_unused.
 - Remove the redundant list_empty check of the fourth patch.

Honghui Zhang (4):
  PCI: mediatek: fixup mtk_pcie_find_port logical
  PCI: mediatek: enable msi after clock enabled
  PCI: mediatek: Add system pm support for MT2712 and MT7622
  PCI: mediatek: Add loadable kernel module support

 drivers/pci/controller/Kconfig         |   2 +-
 drivers/pci/controller/pcie-mediatek.c | 284 ++++++++++++++++++++++++---------
 2 files changed, 208 insertions(+), 78 deletions(-)

-- 
2.6.4
