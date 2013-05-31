Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:42423 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3EaGDw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 02:03:52 -0400
Date: Fri, 31 May 2013 08:03:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Shane Huang <shane.huang@amd.com>
Cc: Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-ide@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 3/3] i2c-piix4: add AMD CZ SMBus device ID
Message-ID: <20130531080336.04481330@endymion.delvare>
In-Reply-To: <1369999333-2073-1-git-send-email-shane.huang@amd.com>
References: <1369999333-2073-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shane,

On Fri, 31 May 2013 19:22:13 +0800, Shane Huang wrote:
> To add AMD CZ SMBus controller device ID.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> ---
>  Documentation/i2c/busses/i2c-piix4 | 2 +-
>  drivers/i2c/busses/Kconfig         | 3 ++-
>  drivers/i2c/busses/i2c-piix4.c     | 3 ++-
>  include/linux/pci_ids.h            | 1 +
>  4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
> index 1e6634f..c136148 100644
> --- a/Documentation/i2c/busses/i2c-piix4
> +++ b/Documentation/i2c/busses/i2c-piix4
> @@ -13,7 +13,7 @@ Supported adapters:
>    * AMD SP5100 (SB700 derivative found on some server mainboards)
>      Datasheet: Publicly available at the AMD website
>      http://support.amd.com/us/Embedded_TechDocs/44413.pdf
> -  * AMD Hudson-2
> +  * AMD HUDSON-2, CZ
>      Datasheet: Not publicly available
>    * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
>      Datasheet: Publicly available at the SMSC website http://www.smsc.com
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 631736e..a43086d 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -149,7 +149,8 @@ config I2C_PIIX4
>  	    ATI SB600
>  	    ATI SB700/SP5100
>  	    ATI SB800
> -	    AMD Hudson-2
> +	    AMD HUDSON-2

Please don't change the case. This makes your patch larger and
increases the risk of conflict with other patches, for no good reason.

Other than that, the patch looks OK.

> +	    AMD CZ
>  	    Serverworks OSB4
>  	    Serverworks CSB5
>  	    Serverworks CSB6
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 39ab78c..16a4d89 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -22,7 +22,7 @@
>  	Intel PIIX4, 440MX
>  	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
>  	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
> -	AMD Hudson-2
> +	AMD HUDSON-2, CZ
>  	SMSC Victory66
>  
>     Note: we assume there can only be one device, with one or more
> @@ -522,6 +522,7 @@ static DEFINE_PCI_DEVICE_TABLE(piix4_ids) = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CZ_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
>  		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 22449c1..b10a5b4 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -571,6 +571,7 @@
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>  #define PCI_DEVICE_ID_AMD_CZ_SATA_IDE	0x7900
> +#define PCI_DEVICE_ID_AMD_CZ_SMBUS	0x790b
>  
>  #define PCI_VENDOR_ID_TRIDENT		0x1023
>  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000


-- 
Jean Delvare
