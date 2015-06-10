Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36719 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbbFJEoG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2015 00:44:06 -0400
Received: by pabqy3 with SMTP id qy3so26650500pab.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2015 21:44:05 -0700 (PDT)
Message-ID: <5577C08D.1050900@ozlabs.ru>
Date: Wed, 10 Jun 2015 14:43:57 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
CC: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v5 12/42] powerpc/pci: Cleanup on pci_controller_ops
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com> <1433400131-18429-13-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-13-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/04/2015 04:41 PM, Gavin Shan wrote:
> Each PHB maintains one instance of "struct pci_controller_ops",
> which includes various callbacks called by PCI subsystem. In the
> definition of this struct, some callbacks have explicit names for
> its arguments, but the left don't have.
>
> The patch removes all explicit names of the arguments to the
> callbacks in "struct pci_controller_ops" to keep the code look
> consistent.

imho it is a bad idea. Self-documeted code gets less self-documented - how 
do I know what "unsigned long" parameters are for without grepping?


>
> Cc: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> v5:
>    * Newly introduced
> ---
>   arch/powerpc/include/asm/pci-bridge.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 744884b..1252cd5 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -18,8 +18,8 @@ struct device_node;
>    * PCI controller operations
>    */
>   struct pci_controller_ops {
> -	void		(*dma_dev_setup)(struct pci_dev *dev);
> -	void		(*dma_bus_setup)(struct pci_bus *bus);
> +	void		(*dma_dev_setup)(struct pci_dev *);
> +	void		(*dma_bus_setup)(struct pci_bus *);
>
>   	int		(*probe_mode)(struct pci_bus *);
>
> @@ -28,8 +28,8 @@ struct pci_controller_ops {
>   	bool		(*enable_device_hook)(struct pci_dev *);
>
>   	/* Called during PCI resource reassignment */
> -	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
> -	void		(*reset_secondary_bus)(struct pci_dev *dev);
> +	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long);
> +	void		(*reset_secondary_bus)(struct pci_dev *);
>   };
>
>   /*
>


-- 
Alexey
