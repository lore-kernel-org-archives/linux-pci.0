Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 4 May 2018 14:16:28 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v7 0/2] PCI: mediatek: Fixups for the IRQ handle routine
 and MT7622's class code
Message-ID: <20180504131628.GA8759@e107981-ln.cambridge.arm.com>
References: <1525412853-24367-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1525412853-24367-1-git-send-email-honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, marc.zyngier@arm.com,
 linux-pci@vger.kernel.org, sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 04, 2018 at 01:47:31PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Two fixups for mediatek's host bridge:
> The first patch fixup class type and vendor ID for MT7622.
> The second patch fixup the IRQ handle routine by using irq_chip solution
> to avoid IRQ reentry which may exist for both MT2712 and MT7622.
> 
> Change since v6:
>  - Remove the irq_mask, irq_unmask callback in lower layer irq_chip since we
>    have set the MSI_FLAG_USE_DEF_CHIP_OPS flags.
>  - Add irq_ack callback in irq_chip to handle edge IRQ.
>  - Uing handle_edge_irq to handle the MSI IRQs.
> 
> Change since v5:
>  - Make the comments consistend with the code modification in the first patch.
>  - Using writew to performing a 16-bit write.
>  - Using irq_chip solution to fix the IRQ issue.
> 
> The v5 patchset could be found in:
>  https://patchwork.kernel.org/patch/10133303
>  https://patchwork.kernel.org/patch/10133305
> 
> Change since v4:
>  - Only setup vendor ID for MT7622, igorning the device ID since mediatek's
>    host bridge driver does not cares about the device ID.
> 
> Change since v3:
>  - Setup the class type and vendor ID at the beginning of startup instead
>    of in a quirk.
>  - Add mediatek's vendor ID, it could be found in:
>    https://pcisig.com/membership/member-companies?combine=&page=4
> 
> Change since v2:
>  - Move the initialize of the iterate before the loop to fix an
>    INTx IRQ issue in the first patch
> 
> Change since v1:
>  - Add the second patch.
>  - Make the first patch's commit message more standard.
> 
> Honghui Zhang (2):
>   PCI: mediatek: Set up vendor ID and class type for MT7622
>   PCI: mediatek: Using chained IRQ to setup IRQ handle
> 
>  drivers/pci/host/pcie-mediatek.c | 234 +++++++++++++++++++++++----------------
>  include/linux/pci_ids.h          |   2 +
>  2 files changed, 143 insertions(+), 93 deletions(-)

Applied to pci/mediatek for v4.18, thanks.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
