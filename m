Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 27 Dec 2017 12:45:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v5 2/2] PCI: mediatek: Set up class type and vendor ID
 for MT7622
Message-ID: <20171227184542.GA79892@bhelgaas-glaptop.roam.corp.google.com>
References: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
 <1514336394-17747-3-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1514336394-17747-3-git-send-email-honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 lorenzo.pieralisi@arm.com, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, bhelgaas@google.com, yingjoe.chen@mediatek.com,
 eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 27, 2017 at 08:59:54AM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The hardware default value of IDs and class type is not correct,
> fix that by setup the correct values before start up.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 12 ++++++++++++
>  include/linux/pci_ids.h          |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index fc29a9a..62aac0ea 100644
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
> +		val = PCI_VENDOR_ID_MEDIATEK;
> +		writel(val, port->base + PCIE_CONF_ID);
> +
> +		/* Set up class code for MT7622 */
> +		val = PCI_CLASS_BRIDGE_PCI << 16;
> +		writel(val, port->base + PCIE_CONF_CLASS);

1) Your comments mention MT7622 specifically, but this code is run for
both mt2712-pcie and mt7622-pcie.  If this code is safe and necessary
for both mt2712-pcie and mt7622-pcie, please remove the mention of
MT7622.

2) The first comment mentions both "vendor ID and device ID" but you
don't write the device ID.  Since this code applies to both
mt2712-pcie and mt7622-pcie, my guess is that you don't *want* to
write the device ID.  If that's the case, please fix the comment.

3) If you only need to set the vendor ID, you're performing a 32-bit
write (writel()) to update a 16-bit value.  Please use writew()
instead.

4) If you only need to set the vendor ID, please use a definition like
"PCIE_CONF_VENDOR_ID" instead of the ambiguous "PCIE_CONF_ID".

5) If you only need to set the vendor ID, please update the changelog
to mention "vendor ID" specifically instead of the ambiguous "IDs".

6) Please add a space before the closing "*/" of the first comment.

7) PCI_CLASS_BRIDGE_PCI is for a PCI-to-PCI bridge, i.e., one that has
PCI on both the primary (upstream) side and the secondary (downstream)
side.  That kind of bridge has a type 1 config header (see
PCI_HEADER_TYPE) and the PCI_PRIMARY_BUS and PCI_SECONDARY_BUS
registers tell us the bus number of the primary and secondary sides.

I don't believe this device is a PCI-to-PCI bridge.  I think it's a
*host* bridge that has some non-PCI interface on the upstream side and
should have a type 0 config header.  If that's the case you should use
PCI_CLASS_BRIDGE_HOST instead.

>  	}
>  
>  	/* Assert all reset signals */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index ab20dc5..2480b0e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2113,6 +2113,8 @@
>  
>  #define PCI_VENDOR_ID_MYRICOM		0x14c1
>  
> +#define PCI_VENDOR_ID_MEDIATEK		0x14c3
> +
>  #define PCI_VENDOR_ID_TITAN		0x14D2
>  #define PCI_DEVICE_ID_TITAN_010L	0x8001
>  #define PCI_DEVICE_ID_TITAN_100L	0x8010
> -- 
> 2.6.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
