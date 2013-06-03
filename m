Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:49792 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838Ab3FCKEK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2013 06:04:10 -0400
Received: by mail-lb0-f180.google.com with SMTP id r10so3606453lbi.11
        for <linux-pci@vger.kernel.org>; Mon, 03 Jun 2013 03:04:08 -0700 (PDT)
Message-ID: <51AC6A14.2040908@cogentembedded.com>
Date: Mon, 03 Jun 2013 14:04:04 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Shane Huang <shane.huang@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>,
	Jean Delvare <khali@linux-fr.org>, linux-pci@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2/3] ahci: add AMD CZ SATA device ID
References: <1370255050-2358-1-git-send-email-shane.huang@amd.com>
In-Reply-To: <1370255050-2358-1-git-send-email-shane.huang@amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 03-06-2013 14:24, Shane Huang wrote:

> To add AMD CZ SATA controller device ID of IDE mode.

> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Reviewed-by: Tejun Heo <tj@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>   drivers/ata/ahci.c      | 1 +
>   drivers/pci/quirks.c    | 2 ++
>   include/linux/pci_ids.h | 1 +
>   3 files changed, 4 insertions(+)

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 751f1ea..548f1c3 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -310,6 +310,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>
>   	/* AMD */
>   	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
> +	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>   	/* AMD is using RAID class only for ahci controllers */
>   	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>   	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
[...]
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e0b5623..22449c1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -570,6 +570,7 @@
>   #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
>   #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
>   #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
> +#define PCI_DEVICE_ID_AMD_CZ_SATA_IDE	0x7900

    We don't add the device IDs to this file anymore. And if you added 
it, why didn't you use it in ahci.c?

MBR, Sergei

