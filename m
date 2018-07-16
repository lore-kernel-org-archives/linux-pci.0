Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1531712134.31406.1.camel@mhfsdcap03>
Subject: Re: [PATCH v3 0/4] PCI: mediatek: fixup find_port, enable_msi and
 add pm, module support
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>
Date: Mon, 16 Jul 2018 11:35:34 +0800
In-Reply-To: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, marc.zyngier@arm.com,
 linux-pci@vger.kernel.org, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Bjorn, Lorenzo,

could you kindly take a look at this serial?

thanks.

On Mon, 2018-07-02 at 15:57 +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> This patchset includes misc patchs:
> 
> The first patch fixup the mtk_pcie_find_port logical which will cause system
> could not touch the EP's configuration space which was connected to PCIe slot 1.
> 
> The second patch fixup the enable msi logical, the operation to enable msi
> should be after system clock is enabled. The function of mtk_pcie_startup_port_v2's
> define location is re-arranged to avoid mtk_pcie_enable_msi's forward declaration.
> And call mtk_pcie_enable_msi in mtk_pcie_startup_port_v2 since the clock was all
> enabled at that time.
> 
> The third patch was rebased and refactor of the v4 patch[1], changes are:
>  -Add PM support for MT7622.
>  -Using mtk_pcie_enable_port to re-establish the link when resumed.
>  -Rebase on the previous two patches.
> 
> The fourth patch add loadable kernel module support.
> 
> Some of those patches was already reviewed-by Ryder Lee <ryder.lee@mediatek.com>,
> so I just add the Reviewed-by tags in those patches.
> 
> [1] https://patchwork.kernel.org/patch/10479079
> 
> Change since v2:
>  - Fix the list_for_each_entry_safe parameter error.
>  - Add Ryder's Acked-by flag.
> 
> Change since v1:
>  - A bit of code refact of the first patch suggested by Andy Shevchenko, and
>    commit message updated.
>  - Using __maybe_unused.
>  - Remove the redundant list_empty check of the fourth patch.
> 
> Honghui Zhang (4):
>   PCI: mediatek: fixup mtk_pcie_find_port logical
>   PCI: mediatek: enable msi after clock enabled
>   PCI: mediatek: Add system pm support for MT2712 and MT7622
>   PCI: mediatek: Add loadable kernel module support
> 
>  drivers/pci/controller/Kconfig         |   2 +-
>  drivers/pci/controller/pcie-mediatek.c | 289 ++++++++++++++++++++++++---------
>  2 files changed, 213 insertions(+), 78 deletions(-)
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
