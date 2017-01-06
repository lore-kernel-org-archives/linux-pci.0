Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33639 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbdAFVk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2017 16:40:28 -0500
Received: by mail-pg0-f50.google.com with SMTP id 204so1997475pge.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Jan 2017 13:40:28 -0800 (PST)
Subject: Re: [PATCH next v2] PCI: iproc: Allow more than slot 0 on PAXC
To: Andy Gospodarek <gospo@broadcom.com>, linux-pci@vger.kernel.org
References: <1483738533-18300-1-git-send-email-gospo@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <27e87522-50bc-56ba-c0ac-474ab5c2c1b9@broadcom.com>
Date: Fri, 6 Jan 2017 13:40:26 -0800
MIME-Version: 1.0
In-Reply-To: <1483738533-18300-1-git-send-email-gospo@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 1/6/2017 1:35 PM, Andy Gospodarek wrote:
> The iproc host driver limits the number of slots that are available on
> PAXC devices.  Enforcing this limit prevents VFs from being created
> beyond the first port.  After this change it is possible to create VFs
> associated with all four devices.
> 
> The first four devices below are the PFs and the next four are the newly
> created VFs:
> 
> 0008:01:00.0 Ethernet controller: Broadcom Limited Device 16cd
> 0008:01:00.1 Ethernet controller: Broadcom Limited Device 16cd
> 0008:01:00.2 Ethernet controller: Broadcom Limited Device 16cd
> 0008:01:00.3 Ethernet controller: Broadcom Limited Device 16cd
> 0008:01:00.4 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
> 0008:01:01.0 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
> 0008:01:01.4 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
> 0008:01:02.0 Ethernet controller: Broadcom Limited BCM57304 NetXtreme-C Ethernet Virtual Function
> 
> v2: Added check to only allow this on PAXCv1 hardware at the suggestion of Ray
> Jui.
> 
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 3ebc025..ae101d6 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -478,11 +478,11 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>  	}
>  
>  	/*
> -	 * PAXC is connected to an internally emulated EP within the SoC.  It
> -	 * allows only one device.
> +	 * PAXC is connected to an internally emulated EP within the SoC.
> +	 * Allow multiple slots only on PAXCv1 hardware.
>  	 */
>  	if (pcie->ep_is_internal)
> -		if (slot > 0)
> +		if (slot > 0 && pcie->type != IPROC_PCIE_PAXC)
>  			return NULL;
>  
>  	/* EP device access */
> 

This change looks good to me. Thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>




