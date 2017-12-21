Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1513838476.23174.3.camel@mhfsdcap03>
Subject: Re: [PATCH v2 2/2] PCI: mediatek: Fixup class type for MT7622
From: Yong Wu <yong.wu@mediatek.com>
To: <honghui.zhang@mediatek.com>
Date: Thu, 21 Dec 2017 14:41:16 +0800
In-Reply-To: <1513822277-18329-3-git-send-email-honghui.zhang@mediatek.com>
References: <1513822277-18329-1-git-send-email-honghui.zhang@mediatek.com>
 <1513822277-18329-3-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, yu.yu@mediatek.com,
 linux-pci@vger.kernel.org, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 lorenzo.pieralisi@arm.com, linux-mediatek@lists.infradead.org,
 xinping.qian@mediatek.com, bhelgaas@google.com, yingjoe.chen@mediatek.com,
 eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2017-12-21 at 10:11 +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The host bridge of MT7622 has hardware code the class code to an
> arbitrary, meaningless value, fix that.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index 3248771..ae8d367 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -1174,3 +1174,15 @@ static struct platform_driver mtk_pcie_driver = {
>  	},
>  };
>  builtin_platform_driver(mtk_pcie_driver);
> +
> +/* The host bridge of MT7622 advertises the wrong device class. */
> +static void mtk_fixup_class(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +
> +/*
> + * The HW default value of vendor id and device id for mt7622 are 0x0e8d,
> + * 0x3258, which are arbitrary, meaningless values.
> + */

What's the right vendor id and device id? is it possible to fix them
too?

> +DECLARE_PCI_FIXUP_EARLY(0x0e8d, 0x3258, mtk_fixup_class);



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
