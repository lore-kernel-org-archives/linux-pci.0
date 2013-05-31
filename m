Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:47358 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3EaGFZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 02:05:25 -0400
Date: Fri, 31 May 2013 08:05:15 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Shane Huang <shane.huang@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-ide@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 1/3] pci_ids: put Hudson-2 device IDs together
Message-ID: <20130531080515.1d7730b6@endymion.delvare>
In-Reply-To: <1369999039-1983-1-git-send-email-shane.huang@amd.com>
References: <1369999039-1983-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 31 May 2013 19:17:19 +0800, Shane Huang wrote:
> To put all AMD Hudson-2 device IDs together for better maintenance.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> ---
>  include/linux/pci_ids.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index c129162..e0b5623 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -556,7 +556,6 @@
>  #define PCI_DEVICE_ID_AMD_8131_BRIDGE	0x7450
>  #define PCI_DEVICE_ID_AMD_8131_APIC	0x7451
>  #define PCI_DEVICE_ID_AMD_8132_BRIDGE	0x7458
> -#define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS	0x780b
>  #define PCI_DEVICE_ID_AMD_CS5535_IDE    0x208F
>  #define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
>  #define PCI_DEVICE_ID_AMD_CS5536_FLASH  0x2091
> @@ -570,6 +569,7 @@
>  #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
> +#define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>  
>  #define PCI_VENDOR_ID_TRIDENT		0x1023
>  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
