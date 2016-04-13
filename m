Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36039 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758664AbcDMF4v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 01:56:51 -0400
Received: by mail-pa0-f43.google.com with SMTP id bx7so27343856pad.3
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2016 22:56:51 -0700 (PDT)
Subject: Re: [PATCH v8 06/45] powerpc/powernv: Reorder fields in struct
 pnv_phb
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-7-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
	bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DDF9C.2040500@ozlabs.ru>
Date: Wed, 13 Apr 2016 15:56:44 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-7-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/17/2016 02:43 PM, Gavin Shan wrote:
> This moves those fields in struct pnv_phb that are related to PE
> allocation around. No logical change.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>   arch/powerpc/platforms/powernv/pci.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 78f035e..f2a1452 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -140,15 +140,14 @@ struct pnv_phb {
>   		unsigned int		io_segsize;
>   		unsigned int		io_pci_base;
>
> -		/* PE allocation bitmap */
> -		unsigned long		*pe_alloc;
> -		/* PE allocation mutex */
> +		/* PE allocation */
>   		struct mutex		pe_alloc_mutex;
> +		unsigned long		*pe_alloc;
> +		struct pnv_ioda_pe	*pe_array;
>
>   		/* M32 & IO segment maps */
>   		unsigned int		*m32_segmap;
>   		unsigned int		*io_segmap;
> -		struct pnv_ioda_pe	*pe_array;
>
>   		/* IRQ chip */
>   		int			irq_chip_init;
>


-- 
Alexey
