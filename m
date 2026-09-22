Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6B136351;
	Tue, 22 Sep 2026 01:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040999; cv=none; b=R0/jzY+SLd8qTPX/ht2xGksTTWNc2RQG74mij0l/3YDiCVlFxY54fL2j8d8F0ySYdvmcrPH4M5gzRZ8gZ9r3KQMUZSGi1EV4Ds6NJzYIDfYBy3P2p3j0o2JhfD7og8987EepIZuyF+4VHfwco1vAxgYW/8V3TXbQK36TAz7+nAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040999; c=relaxed/simple;
	bh=peB1PKIwgDOQJ1ZTI6QvOBKIVSQZOSjTPbdg4Wq0dPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kR9ajxBFgYDW+FEzyoNSZ+6Xincwp/H1PIJNBhITkXRzk+zJdU+YACJD/gybZCpAJgsHIAUrBQAHFuuZijQpJW0k/EGvka6SwKEj4MsU6lQFGXnR6sNgstQJTL57Zb5fMKlqjqrAH9bh+7/Lfd/7rsAuu2FzEz5QT5d1tAH1EhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxwedAsz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxwedAsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF4B1F000FF;
	Tue, 22 Sep 2026 01:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040997;
	bh=Eq+528iIQdR57/ErG74c19hvFTaMjtdjtoM8GgrLF3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VxwedAszmwIfqKUq+pwONh6WQY1Iza9Pvw2vyrDt7ZTkLHO5PgASOVaevijeg1l6f
	 6wmfV0us1YErKmsstZsiH4vIWKyTyPdLZUjLmWFW0+ByDgC+tyTL1W9ylxxCKXkFYD
	 AJvZE7bJehPXXA1T84vUVKnZqgnfguhukNIUvMZ44MbE0tceOS6OvXD3+YnCClZeNQ
	 5z2U6NOKwWEbZf95h2c5olZwqRf6qEkDft3S1ALwcw2qFXvA5TVtd9OWkeqTTTWjqn
	 3JS9W4t8PgK8CMCpz73Ddp02kl+PZAs+MOExbwMK7RDsEG9yNurcAw/ns+vCLD6H+J
	 SV7eZ0yffUjdQ==
Date: Tue, 22 Sep 2026 02:36:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v5 02/27] cxl/regs: Let a BAR-owning driver own the
 component register block
Message-ID: <20260922023629.68336bd1@jic23-hlaptop>
In-Reply-To: <20260916183540.3813685-3-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-3-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:15 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> cxl_map_component_regs() claims each mapped sub-block with
> devm_request_mem_region(). A driver that already requested the whole
> component register BAR, such as vfio-cxl, would then collide with that
> claim and fail to map the HDM decoder and RAS blocks.
> 
> Add cxl_reg_map_add_owned_resource() so such a driver records the
> resource it already owns on the register map, and skip the sub-block
> request when the block falls within an owned resource.

This seems a slightly odd intermediate point.

The assumption is that if owned the whole bar is owned - hence only
handle one owned region (no check if there is already one set?)
yet the code will try to map it if we get a request for something
outside of the region mapped (which can't exist).

This all makes me a little nervous.

> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/core/regs.c | 17 +++++++++++++++--
>  include/cxl/cxl.h       |  2 ++
>  include/cxl/pci.h       |  3 +++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index d79550dbb484..58a7c5cafb45 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -216,6 +216,13 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>  
> +void cxl_reg_map_add_owned_resource(struct cxl_register_map *map,
> +				    struct resource *res)
> +{
> +	map->owned = res;

As above, I think this needs a sanity check that a future driver
author doesn't think they can just add lots of these.
Absolute minimum is add some Docs.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_reg_map_add_owned_resource, "CXL");
> +
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask)
> @@ -234,6 +241,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  		struct mapinfo *mi = &mapinfo[i];
>  		resource_size_t addr;
>  		resource_size_t length;
> +		struct resource res;
>  
>  		if (!mi->rmap->valid)
>  			continue;
> @@ -241,8 +249,13 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  			continue;
>  		addr = map->resource + mi->rmap->offset;
>  		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
> -		if (!*(mi->addr))
> +		res = DEFINE_RES_MEM(addr, length);
> +
> +		if (map->owned && resource_contains(map->owned, &res))

If assumption is whole bar or none, should we just fail if map->owned is true
but the resource contains fails? 

> +			*mi->addr = devm_cxl_ioremap_block(host, addr, length);
> +		else
> +			*mi->addr = devm_cxl_iomap_block(host, addr, length);
> +		if (!*mi->addr)
>  			return -ENOMEM;
>  	}
>  
