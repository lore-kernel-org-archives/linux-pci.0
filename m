Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA7382F28;
	Tue,  4 Aug 2026 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858189; cv=none; b=dBU+stN60+kIt/OO4jufVuhwZmURF9vO5byhk/aSGVkFpK5/flfo2aoJz2sk/d1Y08qHDFvYaylBaaKWKUycj9Wg3BlUyw+3/wGKeUZTNch8PnDjhFiQ330G9FH/JC1firh9LcDEsCPhNzPt1iUVUavfshL9poOIY/oyE5KtYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858189; c=relaxed/simple;
	bh=OsitEDEFewo9FvrDOmBUm6+vM6vVeU+4fVaXsbikIwY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aaKIWa6gSxjgQ5eA2kv8hJua34ImoTTcqI2WWx6WFma30ACAdl9/Qo0tiSiwpG0Avy3nS0f1hTeLcsZ4TXOXXyfvH+FlywShazqVHQ/vR7lmXlKz9KKjasfOwZ4BDP5vipS+ZCOHdbCceLMWwvGK5TLmlbaTfWyz41PZkl89xdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=uofpU6qW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="uofpU6qW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1785858178;
	bh=CSUh0CjnXihmDwp4dxmB3uYnTg/QYI+2ipEdAUCOaHo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uofpU6qW6cPD6PRpQnWaV4LTFG8Yht5PB/nxIzZQtcaqimpArzG54zEt5FWrTN558
	 obo73u/TyRUdHUvyNq6QCN2sVzw07NCBC3uxm1Ye0Lz7eTAFp/ABcqjDrALZxHHLR6
	 zGyaLqI9W7YBe9XjjAhjcbxTfS61H860RdpY9Zgq/cpPRzZaXxV+LbUwsiOGAAbCDY
	 jtQ8izDud0AuWbLQwuc58IBH/fXLLP7x5eXYEkHzbVzCwT2497xot8vSatNnjN//zG
	 A2fPhaQfRntbutB/CDE9yAGatJy5MwK2nKiZeY7TMAtBnHC/E8N/sA7GPjX5kqlLRp
	 vtR8bKXYKP1tw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hDyVH2lhhz4w1k;
	Wed, 05 Aug 2026 01:42:47 +1000 (AEST)
Message-ID: <e90b0bd0-fb8e-4d4e-b282-609c26692e4a@ozlabs.org>
Date: Tue, 4 Aug 2026 16:42:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-3-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Leon, Jason, Logan,


I want to ask for your input on a small issue, please:

On 15/07/2026 18:47, Matt Evans wrote:
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
> 
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
> 
> Some drivers (such as vfio-pci) depend on (1), without having a hard
> dependency on (2).
> 
> A future vfio-pci commit will rely on pcim_p2pdma_provider() always
> being present.  If that depended on CONFIG_PCI_P2PDMA, it would make
> vfio-pci only available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit
> systems), even when P2P is not needed.

(As a reminder, this exists so that vfio-pci can always export a DMABUF
for mmap() even if !P2PDMA.)

The (in-kernel) users of pcim_p2pdma_provider() are vfio-pci, its
nvgrace-gpu driver, and (since d6c58f4eb3d0 "RDMA/mlx5: Implement DMABUF
export ops") the mlx5 driver.

The vfio-pci drivers gate an actual export on CONFIG_VFIO_PCI_DMABUF
(.'. CONFIG_PCI_P2PDMA), but a comment (in a Claude review!) just
flagged that mlx5 uses the success of pcim_p2pdma_provider() as a sign
that P2PDMA is also supported:

  drivers/infiniband/hw/mlx5/main.c:mlx5_ib_mmap_get_pfns():

        *provider = pcim_p2pdma_provider(pdev, bar);
        /* If the kernel was not compiled with CONFIG_PCI_P2PDMA the
         * functionality is not supported.
         */
        if (!*provider)
                return -EOPNOTSUPP;

This will return success even without CONFIG_PCI_P2PDMA, then
UVERBS_METHOD_DMABUF_ALLOC won't fail early anymore.  Even though the
export's attach ultimately fails, moving the point of failure is ugly.

Just shoving an #ifdef in mlx5 isn't right, so would be grateful for
your advice on the most tasteful resolution:

 1. Imagining future drivers might use pcim_p2pdma_provider(), maybe
    p2pdma could export a `pcim_p2pdma_supported()` or similar which
    returns whether CONFIG_PCI_P2PDMA is present and P2P can ever work.
    A user of pcim_p2pdma_provider() is required to also check if P2P is
    overall supported.

    Ugliness aside, a driver could use #ifdef CONFIG_PCI_P2PDMA to test
    whether P2P is expected to work, except that doesn't stop modules
    falling into the same trap.  I think a function export is better.

 2. And/or a test (such the function from #1, or an #ifdef) in the IB
    core DMABUF path, to avoid individual drivers from doing the test in
    their .mmap_get_pfns().  Other future drivers would be expected to
    do similar.

Any better ideas?  Sorry I didn't catch this earlier in the review
cycles, I know we've looked at this patch a few times now.


Many thanks,


Matt


> 
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE and refactor the
> basic provider functionality into a new p2pdma_core.c file.  This is
> available even if the CONFIG_PCI_P2PDMA feature is disabled (or
> unavailable due to !CONFIG_ZONE_DEVICE), satisfying (1).
> 
> Then, when the original CONFIG_PCI_P2PDMA is set, drivers have access
> to the additional P2P features of (2).  This still depends on
> CONFIG_ZONE_DEVICE.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  MAINTAINERS                |   2 +-
>  drivers/pci/Kconfig        |   5 ++
>  drivers/pci/Makefile       |   1 +
>  drivers/pci/p2pdma.c       | 111 +--------------------------------
>  drivers/pci/p2pdma.h       |  29 +++++++++
>  drivers/pci/p2pdma_core.c  | 122 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h |  24 +++++---
>  include/linux/pci.h        |   2 +-
>  8 files changed, 175 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/pci/p2pdma.h
>  create mode 100644 drivers/pci/p2pdma_core.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 806bd2d80d15..192029942145 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20867,7 +20867,7 @@ B:	https://bugzilla.kernel.org
>  C:	irc://irc.oftc.net/linux-pci
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
>  F:	Documentation/driver-api/pci/p2pdma.rst
> -F:	drivers/pci/p2pdma.c
> +F:	drivers/pci/p2pdma*
>  F:	include/linux/pci-p2pdma.h
>  
>  PCI POWER CONTROL
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0c7408509ba2..c991e92bcb85 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -211,6 +211,7 @@ config PCI_P2PDMA
>  	# requires 64bit
>  	#
>  	depends on 64BIT
> +	select PCI_P2PDMA_CORE
>  	select GENERIC_ALLOCATOR
>  	select NEED_SG_DMA_FLAGS
>  	help
> @@ -226,6 +227,10 @@ config PCI_P2PDMA
>  
>  	  If unsure, say N.
>  
> +config PCI_P2PDMA_CORE
> +	default n
> +	bool
> +
>  config PCI_LABEL
>  	def_bool y if (DMI || ACPI)
>  	select NLS
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 41ebc3b9a518..0b32572d57a1 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_PCI_SYSCALL)	+= syscall.o
>  obj-$(CONFIG_PCI_STUB)		+= pci-stub.o
>  obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
>  obj-$(CONFIG_PCI_ECAM)		+= ecam.o
> +obj-$(CONFIG_PCI_P2PDMA_CORE)	+= p2pdma_core.o
>  obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 498bca257419..607580f58c26 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -21,12 +21,7 @@
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
>  
> -struct pci_p2pdma {
> -	struct gen_pool *pool;
> -	bool p2pmem_published;
> -	struct xarray map_types;
> -	struct p2pdma_provider mem[PCI_STD_NUM_BARS];
> -};
> +#include "p2pdma.h"
>  
>  struct pci_p2pdma_pagemap {
>  	struct dev_pagemap pgmap;
> @@ -226,8 +221,7 @@ static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
>  	.folio_free = p2pdma_folio_free,
>  };
>  
> -static void pci_p2pdma_release_pool(struct pci_dev *pdev,
> -				    struct pci_p2pdma *p2pdma)
> +void pci_p2pdma_release_pool(struct pci_dev *pdev, struct pci_p2pdma *p2pdma)
>  {
>  	if (!p2pdma->pool)
>  		return;
> @@ -237,107 +231,6 @@ static void pci_p2pdma_release_pool(struct pci_dev *pdev,
>  	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
>  }
>  
> -static void pci_p2pdma_release(void *data)
> -{
> -	struct pci_dev *pdev = data;
> -	struct pci_p2pdma *p2pdma;
> -
> -	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> -	if (!p2pdma)
> -		return;
> -
> -	/* Flush and disable pci_alloc_p2p_mem() */
> -	pdev->p2pdma = NULL;
> -	pci_p2pdma_release_pool(pdev, p2pdma);
> -	xa_destroy(&p2pdma->map_types);
> -}
> -
> -/**
> - * pcim_p2pdma_init - Initialise peer-to-peer DMA providers
> - * @pdev: The PCI device to enable P2PDMA for
> - *
> - * This function initializes the peer-to-peer DMA infrastructure
> - * for a PCI device. It allocates and sets up the necessary data
> - * structures to support P2PDMA operations, including mapping type
> - * tracking.
> - */
> -int pcim_p2pdma_init(struct pci_dev *pdev)
> -{
> -	struct pci_p2pdma *p2p;
> -	int i, ret;
> -
> -	if (pdev->non_mappable_bars)
> -		return -EOPNOTSUPP;
> -
> -	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> -	if (p2p)
> -		return 0;
> -
> -	p2p = devm_kzalloc(&pdev->dev, sizeof(*p2p), GFP_KERNEL);
> -	if (!p2p)
> -		return -ENOMEM;
> -
> -	xa_init(&p2p->map_types);
> -	/*
> -	 * Iterate over all standard PCI BARs and record only those that
> -	 * correspond to MMIO regions. Skip non-memory resources (e.g. I/O
> -	 * port BARs) since they cannot be used for peer-to-peer (P2P)
> -	 * transactions.
> -	 */
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
> -			continue;
> -
> -		p2p->mem[i].owner = &pdev->dev;
> -		p2p->mem[i].bus_offset =
> -			pci_bus_address(pdev, i) - pci_resource_start(pdev, i);
> -	}
> -
> -	ret = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_release, pdev);
> -	if (ret)
> -		goto out_p2p;
> -
> -	rcu_assign_pointer(pdev->p2pdma, p2p);
> -	return 0;
> -
> -out_p2p:
> -	devm_kfree(&pdev->dev, p2p);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(pcim_p2pdma_init);
> -
> -/**
> - * pcim_p2pdma_provider - Get peer-to-peer DMA provider
> - * @pdev: The PCI device to enable P2PDMA for
> - * @bar: BAR index to get provider
> - *
> - * This function gets peer-to-peer DMA provider for a PCI device. The lifetime
> - * of the provider (and of course the MMIO) is bound to the lifetime of the
> - * driver. A driver calling this function must ensure that all references to the
> - * provider, and any DMA mappings created for any MMIO, are all cleaned up
> - * before the driver remove() completes.
> - *
> - * Since P2P is almost always shared with a second driver this means some system
> - * to notify, invalidate and revoke the MMIO's DMA must be in place to use this
> - * function. For example a revoke can be built using DMABUF.
> - */
> -struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar)
> -{
> -	struct pci_p2pdma *p2p;
> -
> -	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
> -	    pdev->non_mappable_bars)
> -		return NULL;
> -
> -	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> -	if (WARN_ON(!p2p))
> -		/* Someone forgot to call to pcim_p2pdma_init() before */
> -		return NULL;
> -
> -	return &p2p->mem[bar];
> -}
> -EXPORT_SYMBOL_GPL(pcim_p2pdma_provider);
> -
>  static int pci_p2pdma_setup_pool(struct pci_dev *pdev)
>  {
>  	struct pci_p2pdma *p2pdma;
> diff --git a/drivers/pci/p2pdma.h b/drivers/pci/p2pdma.h
> new file mode 100644
> index 000000000000..946383809981
> --- /dev/null
> +++ b/drivers/pci/p2pdma.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCI peer-to-peer DMA support.
> + */
> +
> +#ifndef _PCI_P2PDMA_H
> +#define _PCI_P2PDMA_H
> +
> +#include <linux/genalloc.h>
> +#include <linux/pci-p2pdma.h>
> +#include <linux/xarray.h>
> +
> +struct pci_p2pdma {
> +	struct gen_pool *pool;
> +	bool p2pmem_published;
> +	struct xarray map_types;
> +	struct p2pdma_provider mem[PCI_STD_NUM_BARS];
> +};
> +
> +#ifdef CONFIG_PCI_P2PDMA
> +void pci_p2pdma_release_pool(struct pci_dev *pdev, struct pci_p2pdma *p2pdma);
> +#else
> +static inline void pci_p2pdma_release_pool(struct pci_dev *pdev,
> +					   struct pci_p2pdma *p2pdma)
> +{
> +}
> +#endif
> +
> +#endif
> diff --git a/drivers/pci/p2pdma_core.c b/drivers/pci/p2pdma_core.c
> new file mode 100644
> index 000000000000..9e997f373b1e
> --- /dev/null
> +++ b/drivers/pci/p2pdma_core.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI peer-to-peer DMA support core, providing a bare-bones
> + * pcim_p2pdma_provider() interface to drivers even if full P2PDMA
> + * isn't present.  The full P2PDMA feature is in p2pdma.c (see
> + * CONFIG_PCI_P2PDMA).
> + *
> + * Copyright (c) 2016-2018, Logan Gunthorpe
> + * Copyright (c) 2016-2017, Microsemi Corporation
> + * Copyright (c) 2017, Christoph Hellwig
> + * Copyright (c) 2018, Eideticom Inc.
> + */
> +
> +#define pr_fmt(fmt) "pci-p2pdma: " fmt
> +#include <linux/ctype.h>
> +#include <linux/genalloc.h>
> +#include <linux/memremap.h>
> +#include <linux/pci-p2pdma.h>
> +#include <linux/xarray.h>
> +
> +#include "p2pdma.h"
> +
> +static void pci_p2pdma_release(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_p2pdma *p2pdma;
> +
> +	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> +	if (!p2pdma)
> +		return;
> +
> +	/* Flush and disable pci_alloc_p2p_mem() */
> +	pdev->p2pdma = NULL;
> +	pci_p2pdma_release_pool(pdev, p2pdma);
> +	xa_destroy(&p2pdma->map_types);
> +}
> +
> +/**
> + * pcim_p2pdma_init - Initialise peer-to-peer DMA providers
> + * @pdev: The PCI device to enable P2PDMA for
> + *
> + * This function initializes the peer-to-peer DMA infrastructure
> + * for a PCI device. It allocates and sets up the necessary data
> + * structures to support P2PDMA operations, including mapping type
> + * tracking.
> + */
> +int pcim_p2pdma_init(struct pci_dev *pdev)
> +{
> +	struct pci_p2pdma *p2p;
> +	int i, ret;
> +
> +	if (pdev->non_mappable_bars)
> +		return -EOPNOTSUPP;
> +
> +	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> +	if (p2p)
> +		return 0;
> +
> +	p2p = devm_kzalloc(&pdev->dev, sizeof(*p2p), GFP_KERNEL);
> +	if (!p2p)
> +		return -ENOMEM;
> +
> +	xa_init(&p2p->map_types);
> +	/*
> +	 * Iterate over all standard PCI BARs and record only those that
> +	 * correspond to MMIO regions. Skip non-memory resources (e.g. I/O
> +	 * port BARs) since they cannot be used for peer-to-peer (P2P)
> +	 * transactions.
> +	 */
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
> +			continue;
> +
> +		p2p->mem[i].owner = &pdev->dev;
> +		p2p->mem[i].bus_offset =
> +			pci_bus_address(pdev, i) - pci_resource_start(pdev, i);
> +	}
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_release, pdev);
> +	if (ret)
> +		goto out_p2p;
> +
> +	rcu_assign_pointer(pdev->p2pdma, p2p);
> +	return 0;
> +
> +out_p2p:
> +	devm_kfree(&pdev->dev, p2p);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pcim_p2pdma_init);
> +
> +/**
> + * pcim_p2pdma_provider - Get peer-to-peer DMA provider
> + * @pdev: The PCI device to enable P2PDMA for
> + * @bar: BAR index to get provider
> + *
> + * This function gets peer-to-peer DMA provider for a PCI device. The lifetime
> + * of the provider (and of course the MMIO) is bound to the lifetime of the
> + * driver. A driver calling this function must ensure that all references to the
> + * provider, and any DMA mappings created for any MMIO, are all cleaned up
> + * before the driver remove() completes.
> + *
> + * Since P2P is almost always shared with a second driver this means some system
> + * to notify, invalidate and revoke the MMIO's DMA must be in place to use this
> + * function. For example a revoke can be built using DMABUF.
> + */
> +struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar)
> +{
> +	struct pci_p2pdma *p2p;
> +
> +	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
> +	    pdev->non_mappable_bars)
> +		return NULL;
> +
> +	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> +	if (WARN_ON(!p2p))
> +		/* Someone forgot to call to pcim_p2pdma_init() before */
> +		return NULL;
> +
> +	return &p2p->mem[bar];
> +}
> +EXPORT_SYMBOL_GPL(pcim_p2pdma_provider);
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 873de20a2247..4c42a7b2ee85 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -67,9 +67,22 @@ enum pci_p2pdma_map_type {
>  	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
>  };
>  
> -#ifdef CONFIG_PCI_P2PDMA
> +#ifdef CONFIG_PCI_P2PDMA_CORE
>  int pcim_p2pdma_init(struct pci_dev *pdev);
>  struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar);
> +#else
> +static inline int pcim_p2pdma_init(struct pci_dev *pdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev,
> +							   int bar)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +#ifdef CONFIG_PCI_P2PDMA
>  int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  		u64 offset);
>  int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
> @@ -89,15 +102,6 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
>  enum pci_p2pdma_map_type pci_p2pdma_map_type(struct p2pdma_provider *provider,
>  					     struct device *dev);
>  #else /* CONFIG_PCI_P2PDMA */
> -static inline int pcim_p2pdma_init(struct pci_dev *pdev)
> -{
> -	return -EOPNOTSUPP;
> -}
> -static inline struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev,
> -							   int bar)
> -{
> -	return NULL;
> -}
>  static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
>  		size_t size, u64 offset)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c..8adbabbec5bf 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -556,7 +556,7 @@ struct pci_dev {
>  	u16		pasid_cap;	/* PASID Capability offset */
>  	u16		pasid_features;
>  #endif
> -#ifdef CONFIG_PCI_P2PDMA
> +#ifdef CONFIG_PCI_P2PDMA_CORE
>  	struct pci_p2pdma __rcu *p2pdma;
>  #endif
>  #ifdef CONFIG_PCI_DOE

