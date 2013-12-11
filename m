Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52101 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab3LKWsg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 17:48:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/12] SPEAr13xx: Move SPEAr1340 definitions to header file
Date: Wed, 11 Dec 2013 23:48:06 +0100
Cc: Mohit Kumar <mohit.kumar@st.com>, linux-pci@vger.kernel.org,
	Pratyush Anand <pratyush.anand@st.com>,
	spear-devel@list.st.com, Viresh Kumar <viresh.linux@gmail.com>
References: <cover.1386752447.git.mohit.kumar@st.com> <9ae7b152da13c094b024c54d27187aab96e439b3.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <9ae7b152da13c094b024c54d27187aab96e439b3.1386752447.git.mohit.kumar@st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201312112348.06755.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 11 December 2013, Mohit Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> Move SPEAr1340 definitions to header files so that theese can be used by
> other code too.

This looks like a regression, we intentionally made them private and they
should be moved into a proper driver instead of being globally visible.

> diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
> index 5cdc53d..4526f75 100644
> --- a/arch/arm/mach-spear/include/mach/spear.h
> +++ b/arch/arm/mach-spear/include/mach/spear.h
> @@ -86,6 +86,61 @@
>  /* Debug uart for linux, will be used for debug and uncompress messages */
>  #define SPEAR_DBG_UART_BASE			UART_BASE
>  
> +/* PCIe/SATA Base addresses */
> +#define SPEAR1340_SATA_BASE			UL(0xB1000000)
> +#define SPEAR1340_PCIE_BASE			UL(0xB1000000)

These should be in DT only.

> +/* Power Management Registers */
> +#define SPEAR1340_PCM_CFG			(VA_MISC_BASE + 0x100)
> +#define SPEAR1340_PCM_WKUP_CFG			(VA_MISC_BASE + 0x104)
> +#define SPEAR1340_SWITCH_CTR			(VA_MISC_BASE + 0x108)
> +
> +#define SPEAR1340_PERIP1_SW_RST			(VA_MISC_BASE + 0x318)
> +#define SPEAR1340_PERIP2_SW_RST			(VA_MISC_BASE + 0x31C)
> +#define SPEAR1340_PERIP3_SW_RST			(VA_MISC_BASE + 0x320)

The RST bits should probably go into a drivers/reset driver. Not sure what the
other registers do, but I'm sure we can find a driver for these too, possibly
they should be part of the PHY driver?

> @@ -22,60 +22,6 @@
>  #include <mach/spear.h>
>  
>  /* FIXME: Move SATA PHY code into a standalone driver */
> -
> -
> -/* PCIE - SATA configuration registers */
> -#define SPEAR1340_PCIE_SATA_CFG			(VA_MISC_BASE + 0x424)
> -	/* PCIE CFG MASks */
> -	#define SPEAR1340_PCIE_CFG_DEVICE_PRESENT	(1 << 11)
> -	#define SPEAR1340_PCIE_CFG_POWERUP_RESET	(1 << 10)
> -	#define SPEAR1340_PCIE_CFG_CORE_CLK_EN		(1 << 9)
> -	#define SPEAR1340_PCIE_CFG_AUX_CLK_EN		(1 << 8)
> -	#define SPEAR1340_SATA_CFG_TX_CLK_EN		(1 << 4)
> -	#define SPEAR1340_SATA_CFG_RX_CLK_EN		(1 << 3)
> -	#define SPEAR1340_SATA_CFG_POWERUP_RESET	(1 << 2)

You leave the FIXME in place but move away the definitions it talks about.
Please fix the problem instead.

	Arnd
