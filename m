Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:64849
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752060AbcKTLlZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 20 Nov 2016 06:41:25 -0500
Subject: Re: [PATCH v3 2/5] net/mlx4_core: Use device ID defines
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20161117232458.2003.88193.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161117233009.2003.52026.stgit@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <majd@mellanox.com>,
        <gwshan@linux.vnet.ibm.com>
From: Noa Osherovich <noaos@mellanox.com>
Message-ID: <3bc11996-c05b-675d-1962-648b8411c5c4@mellanox.com>
Date: Sun, 20 Nov 2016 09:08:57 +0200
MIME-Version: 1.0
In-Reply-To: <20161117233009.2003.52026.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding relevant Mellanox people to take a look.

On 11/18/2016 1:30 AM, Bjorn Helgaas wrote:

> We added a bunch of new Mellanox device ID definitions because they'll be
> used by INTx quirks.  Use them in the mlx4 ID table also so grep can find
> both places.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/main.c |   78 ++++++++++++++---------------
>  1 file changed, 37 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
> index 7183ac4..672e0a2e 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
> @@ -4012,49 +4012,45 @@ int mlx4_restart_one(struct pci_dev *pdev)
>  	return err;
>  }
>  
> +#define MLX_SP(id) { PCI_VDEVICE(MELLANOX, id), MLX4_PCI_DEV_FORCE_SENSE_PORT }
> +#define MLX_VF(id) { PCI_VDEVICE(MELLANOX, id), MLX4_PCI_DEV_IS_VF }
> +#define MLX_GN(id) { PCI_VDEVICE(MELLANOX, id), 0 }
> +
>  static const struct pci_device_id mlx4_pci_table[] = {
> -	/* MT25408 "Hermon" SDR */
> -	{ PCI_VDEVICE(MELLANOX, 0x6340), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT25408 "Hermon" DDR */
> -	{ PCI_VDEVICE(MELLANOX, 0x634a), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT25408 "Hermon" QDR */
> -	{ PCI_VDEVICE(MELLANOX, 0x6354), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT25408 "Hermon" DDR PCIe gen2 */
> -	{ PCI_VDEVICE(MELLANOX, 0x6732), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT25408 "Hermon" QDR PCIe gen2 */
> -	{ PCI_VDEVICE(MELLANOX, 0x673c), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT25408 "Hermon" EN 10GigE */
> -	{ PCI_VDEVICE(MELLANOX, 0x6368), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT25408 "Hermon" EN 10GigE PCIe gen2 */
> -	{ PCI_VDEVICE(MELLANOX, 0x6750), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT25458 ConnectX EN 10GBASE-T 10GigE */
> -	{ PCI_VDEVICE(MELLANOX, 0x6372), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT25458 ConnectX EN 10GBASE-T+Gen2 10GigE */
> -	{ PCI_VDEVICE(MELLANOX, 0x675a), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT26468 ConnectX EN 10GigE PCIe gen2*/
> -	{ PCI_VDEVICE(MELLANOX, 0x6764), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT26438 ConnectX EN 40GigE PCIe gen2 5GT/s */
> -	{ PCI_VDEVICE(MELLANOX, 0x6746), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT26478 ConnectX2 40GigE PCIe gen2 */
> -	{ PCI_VDEVICE(MELLANOX, 0x676e), MLX4_PCI_DEV_FORCE_SENSE_PORT },
> -	/* MT25400 Family [ConnectX-2 Virtual Function] */
> -	{ PCI_VDEVICE(MELLANOX, 0x1002), MLX4_PCI_DEV_IS_VF },
> +	/* MT25408 "Hermon" */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_HERMON_SDR),	/* SDR */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_HERMON_DDR),	/* DDR */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_HERMON_QDR),	/* QDR */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2), /* DDR Gen2 */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2),	/* QDR Gen2 */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_HERMON_EN),	/* EN 10GigE */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2),  /* EN 10GigE Gen2 */
> +	/* MT25458 ConnectX EN 10GBASE-T */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_CONNECTX_EN),
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2),	/* Gen2 */
> +	/* MT26468 ConnectX EN 10GigE PCIe Gen2*/
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2),
> +	/* MT26438 ConnectX EN 40GigE PCIe Gen2 5GT/s */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2),
> +	/* MT26478 ConnectX2 40GigE PCIe Gen2 */
> +	MLX_SP(PCI_DEVICE_ID_MELLANOX_CONNECTX2),
> +	/* MT25400 Family [ConnectX-2] */
> +	MLX_VF(0x1002),					/* Virtual Function */
>  	/* MT27500 Family [ConnectX-3] */
> -	{ PCI_VDEVICE(MELLANOX, 0x1003), 0 },
> -	/* MT27500 Family [ConnectX-3 Virtual Function] */
> -	{ PCI_VDEVICE(MELLANOX, 0x1004), MLX4_PCI_DEV_IS_VF },
> -	{ PCI_VDEVICE(MELLANOX, 0x1005), 0 }, /* MT27510 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x1006), 0 }, /* MT27511 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x1007), 0 }, /* MT27520 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x1008), 0 }, /* MT27521 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x1009), 0 }, /* MT27530 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x100a), 0 }, /* MT27531 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x100b), 0 }, /* MT27540 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x100c), 0 }, /* MT27541 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x100d), 0 }, /* MT27550 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x100e), 0 }, /* MT27551 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x100f), 0 }, /* MT27560 Family */
> -	{ PCI_VDEVICE(MELLANOX, 0x1010), 0 }, /* MT27561 Family */
> +	MLX_GN(PCI_DEVICE_ID_MELLANOX_CONNECTX3),
> +	MLX_VF(0x1004),					/* Virtual Function */
> +	MLX_GN(0x1005),					/* MT27510 Family */
> +	MLX_GN(0x1006),					/* MT27511 Family */
> +	MLX_GN(PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO),	/* MT27520 Family */
> +	MLX_GN(0x1008),					/* MT27521 Family */
> +	MLX_GN(0x1009),					/* MT27530 Family */
> +	MLX_GN(0x100a),					/* MT27531 Family */
> +	MLX_GN(0x100b),					/* MT27540 Family */
> +	MLX_GN(0x100c),					/* MT27541 Family */
> +	MLX_GN(0x100d),					/* MT27550 Family */
> +	MLX_GN(0x100e),					/* MT27551 Family */
> +	MLX_GN(0x100f),					/* MT27560 Family */
> +	MLX_GN(0x1010),					/* MT27561 Family */
>  	{ 0, }
>  };
>  
>

