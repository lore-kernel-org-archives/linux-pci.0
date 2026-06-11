Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49F3FFAD1;
	Thu, 11 Jun 2026 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194072; cv=none; b=UScqE6+Gn3ZK6RJUPL+/lLpnx6ceFsWJsARfDXDuM6M1P173F2UuiieFMopLgFKr0tIrMaMxKcd0lzW+/RgCj60i6sPzttnLlGjTE6JJ9GyEHFeuCw+eHKSFmDqpgaqQFjGpbkOBcdT/ANuDPg5KLzXBRBi7zAMj1ckK+3OF8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194072; c=relaxed/simple;
	bh=U3xZxLpD8RZWX+DyVx8SGieHG8U7O26uoqmoOK0GYgY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ck1QM/PQiLBB9pLfEHJe06URq7T7TLFfoFCaa9vJQlEm7JUOTj+Ns9HmN4mYnGhcB1FVwNY/xUMLThJrD9/GgO1vmLb7OvgfvxHo+Yn7iIFGYsQjCcSqEXNWcUghfjSGyyMIp+Hxr3lqZCb01I/xhUAWxnCJ3WWJgiy/P6+j5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1Zrk0QZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1Zrk0QZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF171F00893;
	Thu, 11 Jun 2026 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781194070;
	bh=FODH1d2l25lpiGGcZpHtnCfAB0Q222ShRwNYwgMpF+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=L1Zrk0QZ1qX3eyuxtjnJdk+dWBBpC6QlshmDTeGDOZMyFLXoqJUbE2RSKRBDRYkbY
	 /qUnN60oDtV/Ce52c7YIEPF30crxHl42JGpvfyBXXuHT4s73n4ZWNWH9mE/Z8TRjLr
	 jqGXi5/G14a1yz6EkkXphC9k27eSfDUWt8DbpMsoLil03Pi93j6u6+nXmVO3ENLfnW
	 DrpMfPn2Yb/ONriLS4mG3Tt3vy8eYx6l6NzfDudag11h5zPdYcx7L894Fj3nUH1C+f
	 6B8TX9W/Z7KCsSsF0K7Vfu72e73b3UL7odrbFuf9CUZ5nOU4uy7w3splGfECMWL7ha
	 UVtWB4nj5j2wQ==
Date: Thu, 11 Jun 2026 11:07:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <20260611160749.GA469670@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-2-matt@ozlabs.org>

On Wed, Jun 10, 2026 at 04:43:15PM +0100, Matt Evans wrote:
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
> 
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
> 
> Some drivers (such as vfio-pci) depend on 1, without having a hard
> dependency on 2.
> 
> A future commit expands the use of DMABUF in vfio-pci for non-P2P
> scenarios, relying on pcim_p2pdma_provider() always being present.  If
> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
> when P2P is not needed.
> 
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE and refactor the
> basic provider functionality into a new p2pdma_core.c file.  This is
> available even if the CONFIG_PCI_P2PDMA feature is disabled (or
> unavailable due to !CONFIG_ZONE_DEVICE).  Then, drivers can enable any
> additional P2P features with the original CONFIG_PCI_P2PDMA (available
> when CONFIG_ZONE_DEVICE is set).
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

I thought this was going to be just a code move and new Kconfig
option, but it involves a little more than that, e.g., adding
pci_p2pdma_release_pool() and tweaking the RCU synchronization.

If possible, it would be nice to do that refactoring in a smaller
preliminary patch so it's easier to review/bisect/etc and make this
one a pure code move.

I guess CONFIG_PCI_P2PDMA_CORE selects just part 1 ("Locate providers
via pcim_p2pdma_provider()"), right?

> +++ b/drivers/pci/p2pdma.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCI Peer 2 Peer DMA support.
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
> +static inline void pci_p2pdma_release_pool(struct pci_dev *pdev, struct pci_p2pdma *p2pdma)

Wrap to fit in 80 columns like the rest of drivers/pci/

> +{
> +}
> +#endif
> +
> +#endif
> +

Spurious blank line at end.

> +++ b/drivers/pci/p2pdma_core.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Peer 2 Peer DMA support core, providing a bare-bones

In this English text, I think I would spell out "Peer to Peer" instead
of relying on the "2" homophone.  Same in p2pdma.h.
