Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59520 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbbJLQFp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 12:05:45 -0400
Message-ID: <1444665942.3364.20.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/3] PCI: designware: Move LTSSM state definitions to
 pcie-designware.h
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, pratyush.anand@gmail.com, m-karicheri2@ti.com,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 12 Oct 2015 18:05:42 +0200
In-Reply-To: <1444664808-16445-1-git-send-email-festevam@gmail.com>
References: <1444664808-16445-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 12.10.2015, 12:46 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Move LTSSM state definitions to common pcie-designware.h so that other
> drivers can make use of them.
> 
> Also, LTSSM states only use 5 bits so use 0x1f as its mask, so that we
> have a common LTSSM mask accross all PCIe designware drivers.
> 
> Keystone uses 5 bits for the LTSSM in its reference manual, others like
> i.MX6 uses 6 bits. However, the LTSSM states really have 5 bits, so we
> can safely use 5 bits (which corresponds to the 0x1f mask) for all the
> PCIe Designware cores.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes since v2:
> - Use LTSSM_STATE_MASK with value 0x1f for all the drivers (Lucas)
> - Use lowercase in pcie-designware.h (Lucas)
> 
>  drivers/pci/host/pci-keystone-dw.c |  1 -
>  drivers/pci/host/pci-layerscape.c  |  1 -
>  drivers/pci/host/pcie-designware.h | 34 ++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-spear13xx.c  | 33 ---------------------------------
>  4 files changed, 34 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> index 0146b41..76edf92 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -25,7 +25,6 @@
>  
>  /* Application register defines */
>  #define LTSSM_EN_VAL		        1
> -#define LTSSM_STATE_MASK		0x1f
>  #define LTSSM_STATE_L0			0x11
>  #define DBI_CS2_EN_VAL			0x20
>  #define OB_XLAT_EN_VAL		        2
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 495a7c3..f68b551 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -28,7 +28,6 @@
>  /* PEX1/2 Misc Ports Status Register */
>  #define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
>  #define LTSSM_STATE_SHIFT	20
> -#define LTSSM_STATE_MASK	0x3f
>  #define LTSSM_PCIE_L0		0x11 /* L0 state */
>  
>  /* PEX Internal Configuration Registers */
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index e7b3279..95846dd 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -22,6 +22,40 @@
>  #define MAX_MSI_IRQS			32
>  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
>  
> +#define LTSSM_STATE_DETECT_QUIET	0x00
> +#define LTSSM_STATE_DETECT_ACT		0x01
> +#define LTSSM_STATE_POLL_ACTIVE		0x02
> +#define LTSSM_STATE_POLL_COMPLIANCE	0x03
> +#define LTSSM_STATE_POLL_CONFIG		0x04
> +#define LTSSM_STATE_PRE_DETECT_QUIET	0x05
> +#define LTSSM_STATE_DETECT_WAIT		0x06
> +#define LTSSM_STATE_CFG_LINKWD_START	0x07
> +#define LTSSM_STATE_CFG_LINKWD_ACEPT	0x08
> +#define LTSSM_STATE_CFG_LANENUM_WAIT	0x09
> +#define LTSSM_STATE_CFG_LANENUM_ACEPT	0x0a
> +#define LTSSM_STATE_CFG_COMPLETE	0x0b
> +#define LTSSM_STATE_CFG_IDLE		0x0c
> +#define LTSSM_STATE_RCVRY_LOCK		0x0d
> +#define LTSSM_STATE_RCVRY_SPEED		0x0e
> +#define LTSSM_STATE_RCVRY_RCVRCFG	0x0f
> +#define LTSSM_STATE_RCVRY_IDLE		0x10
> +#define LTSSM_STATE_L0			0x11
> +#define LTSSM_STATE_L0S			0x12
> +#define LTSSM_STATE_L123_SEND_EIDLE	0x13
> +#define LTSSM_STATE_L1_IDLE		0x14
> +#define LTSSM_STATE_L2_IDLE		0x15
> +#define LTSSM_STATE_L2_WAKE		0x16
> +#define LTSSM_STATE_DISABLED_ENTRY	0x17
> +#define LTSSM_STATE_DISABLED_IDLE	0x18
> +#define LTSSM_STATE_DISABLED		0x19
> +#define LTSSM_STATE_LPBK_ENTRY		0x1a
> +#define LTSSM_STATE_LPBK_ACTIVE		0x1b
> +#define LTSSM_STATE_LPBK_EXIT		0x1c
> +#define LTSSM_STATE_LPBK_EXIT_TIMEOUT	0x1d
> +#define LTSSM_STATE_HOT_RESET_ENTRY	0x1e
> +#define LTSSM_STATE_HOT_RESET		0x1f
> +#define LTSSM_STATE_MASK		0x1f
> +
>  struct pcie_port {
>  	struct device		*dev;
>  	u8			root_bus_nr;
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index b95b756..8f0a1a2 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -84,39 +84,6 @@ struct pcie_app_reg {
>  #define APPS_PM_XMT_PME_ID			5
>  
>  /* CR3 ID */
> -#define XMLH_LTSSM_STATE_DETECT_QUIET		0x00
> -#define XMLH_LTSSM_STATE_DETECT_ACT		0x01
> -#define XMLH_LTSSM_STATE_POLL_ACTIVE		0x02
> -#define XMLH_LTSSM_STATE_POLL_COMPLIANCE	0x03
> -#define XMLH_LTSSM_STATE_POLL_CONFIG		0x04
> -#define XMLH_LTSSM_STATE_PRE_DETECT_QUIET	0x05
> -#define XMLH_LTSSM_STATE_DETECT_WAIT		0x06
> -#define XMLH_LTSSM_STATE_CFG_LINKWD_START	0x07
> -#define XMLH_LTSSM_STATE_CFG_LINKWD_ACEPT	0x08
> -#define XMLH_LTSSM_STATE_CFG_LANENUM_WAIT	0x09
> -#define XMLH_LTSSM_STATE_CFG_LANENUM_ACEPT	0x0A
> -#define XMLH_LTSSM_STATE_CFG_COMPLETE		0x0B
> -#define XMLH_LTSSM_STATE_CFG_IDLE		0x0C
> -#define XMLH_LTSSM_STATE_RCVRY_LOCK		0x0D
> -#define XMLH_LTSSM_STATE_RCVRY_SPEED		0x0E
> -#define XMLH_LTSSM_STATE_RCVRY_RCVRCFG		0x0F
> -#define XMLH_LTSSM_STATE_RCVRY_IDLE		0x10
> -#define XMLH_LTSSM_STATE_L0			0x11
> -#define XMLH_LTSSM_STATE_L0S			0x12
> -#define XMLH_LTSSM_STATE_L123_SEND_EIDLE	0x13
> -#define XMLH_LTSSM_STATE_L1_IDLE		0x14
> -#define XMLH_LTSSM_STATE_L2_IDLE		0x15
> -#define XMLH_LTSSM_STATE_L2_WAKE		0x16
> -#define XMLH_LTSSM_STATE_DISABLED_ENTRY		0x17
> -#define XMLH_LTSSM_STATE_DISABLED_IDLE		0x18
> -#define XMLH_LTSSM_STATE_DISABLED		0x19
> -#define XMLH_LTSSM_STATE_LPBK_ENTRY		0x1A
> -#define XMLH_LTSSM_STATE_LPBK_ACTIVE		0x1B
> -#define XMLH_LTSSM_STATE_LPBK_EXIT		0x1C
> -#define XMLH_LTSSM_STATE_LPBK_EXIT_TIMEOUT	0x1D
> -#define XMLH_LTSSM_STATE_HOT_RESET_ENTRY	0x1E
> -#define XMLH_LTSSM_STATE_HOT_RESET		0x1F
> -#define XMLH_LTSSM_STATE_MASK			0x3F
>  #define XMLH_LINK_UP				(1 << 6)
>  
>  /* CR4 ID */

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

