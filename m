Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34840 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbcEFGei (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2016 02:34:38 -0400
Received: by mail-pa0-f45.google.com with SMTP id iv1so44224243pac.2
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2016 23:34:37 -0700 (PDT)
Subject: Re: [PATCH 4/5] pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host
 bridge
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-5-git-send-email-xyjxie@linux.vnet.ibm.com>
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
	alistair@popple.id.au, ruscur@russell.cc
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8bafc3ec-8ee1-db91-2835-6a77a5dd2539@ozlabs.ru>
Date: Fri, 6 May 2016 16:34:21 +1000
MIME-Version: 1.0
In-Reply-To: <1461761010-5452-5-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/27/2016 10:43 PM, Yongji Xie wrote:
> Any IODA host bridge have the capability of IRQ remapping.
> So we set PCI_BUS_FLAGS_MSI_REMAP when this kind of host birdge
> is detected.
>
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index f90dc04..9557638 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3080,6 +3080,12 @@ static void pnv_pci_ioda_fixup(void)
>  	pnv_npu_ioda_fixup();
>  }
>
> +int pnv_pci_ioda_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	bridge->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
> +	return 0;
> +}
> +
>  /*
>   * Returns the alignment for I/O or memory windows for P2P
>   * bridges. That actually depends on how PEs are segmented.
> @@ -3364,6 +3370,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	 */
>  	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
>
> +	ppc_md.pcibios_root_bridge_prepare = pnv_pci_ioda_root_bridge_prepare;
> +
>  	if (phb->type == PNV_PHB_NPU)
>  		hose->controller_ops = pnv_npu_ioda_controller_ops;
>  	else
>


-- 
Alexey
