Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1514197661.25015.9.camel@mtkswgap22>
Subject: Re: [PATCH v4 2/2] PCI: mediatek: Set up class type and vendor ID
 for MT7622
From: Ryder Lee <ryder.lee@mediatek.com>
To: <honghui.zhang@mediatek.com>
Date: Mon, 25 Dec 2017 18:27:41 +0800
In-Reply-To: <1513921178-16148-3-git-send-email-honghui.zhang@mediatek.com>
References: <1513921178-16148-1-git-send-email-honghui.zhang@mediatek.com>
 <1513921178-16148-3-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2017-12-22 at 13:39 +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The hardware default value of IDs and class type is not correct,
> fix that by setup the correct values before start up.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 12 ++++++++++++
>  include/linux/pci_ids.h          |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index fc29a9a..0ef33e4 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -74,6 +74,10 @@
>  
>  /* PCIe V2 per-port registers */
>  #define PCIE_MSI_VECTOR		0x0c0
> +
> +#define PCIE_CONF_ID		0x100
> +#define PCIE_CONF_CLASS		0x104
> +
>  #define PCIE_INT_MASK		0x420
>  #define INTX_MASK		GENMASK(19, 16)
>  #define INTX_SHIFT		16
> @@ -393,6 +397,14 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		val |= PCIE_CSR_LTSSM_EN(port->slot) |
>  		       PCIE_CSR_ASPM_L1_EN(port->slot);
>  		writel(val, pcie->base + PCIE_SYS_CFG_V2);
> +
> +		/* Set up vendor ID and device ID for MT7622*/
> +		val = PCI_VENDOR_ID_MEDIATEK | (PCI_DEVICE_ID_MT7622 << 16);
> +		writel(val, port->base + PCIE_CONF_ID);

IMHO, this is a general function so you can ignore "device ID for
MT7622" here, but just make sure class code/vendor ID correct.

> +		/* Set up class code for MT7622 */
> +		val = PCI_CLASS_BRIDGE_PCI << 16;
> +		writel(val, port->base + PCIE_CONF_CLASS);
>  	}
>  
>  	/* Assert all reset signals */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index ab20dc5..000c5df 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2113,6 +2113,9 @@
>  
>  #define PCI_VENDOR_ID_MYRICOM		0x14c1
>  
> +#define PCI_VENDOR_ID_MEDIATEK		0x14c3
> +#define PCI_DEVICE_ID_MT7622		0x5396
> +
>  #define PCI_VENDOR_ID_TITAN		0x14D2
>  #define PCI_DEVICE_ID_TITAN_010L	0x8001
>  #define PCI_DEVICE_ID_TITAN_100L	0x8010



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
