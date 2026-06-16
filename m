Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2D4502F;
	Tue, 16 Jun 2026 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630529; cv=none; b=CLAqw5RvXB09UOKTpVXaLlpdyJ86HO0k06kjIzCieKOBQV5jWefvkQY67pQuFhdSTvzmsf57dJrD5MCXOZwe/+UWWNjnF+73JjLnU9idfHqnJTnIGuOBzogNdNwmZZoYnLrud4JV672TSA9BlbFoK97JRaoqBlt8DeTdaT5sr84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630529; c=relaxed/simple;
	bh=T3Q2rZptmBht2ce9WBcvy6iR2GKdgYbFKRTj/Nz+lmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbwaLy68OMap2r/YhcTI2gAwo7XkTwu+UbUiX7a2XTmwc0VhkAQZMnj9b54BpFwUIlqbVSYbOYkF0onhu7NGZ6Zva7yRInTNG5zocVPgEzoJGMRNoaboY2lw5e4Rk6e0581x88dwWz5K8xcIClJ9WRkK4YlTIoDne0z4NbivVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px2IsKNZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px2IsKNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E281F000E9;
	Tue, 16 Jun 2026 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781630528;
	bh=yAQBjErfWgKwY+rmANd6szMivaukHje+DeQu981RCrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Px2IsKNZKDILQyYuYAEI04Zuhq2MnyRcOtsSTFX+w95yDaUX74SpOFSFpnQcmaE6M
	 OfDkbi3VxwIBcoM8QZv8cTSFCpK0wQahVCDeZKYUiUBWD9Bq4ond8ZQkTXzPpUNxas
	 81bR/5bv2junus46Pw2oecNulzaRor9OTN1qjinLZUL5AXcQk9esnGM2cC/i/6J71k
	 aPsGRJ9ZyuNF6RZlVf1jcz2PN2/G1VV7XK9PR9+MTZelZpn6FF1YaT713/IaZOmYM+
	 +AgcwONSHi4O8UnAiT3Fkk3vP5uP5mzg1uarku8AL25P8moCoalzEarL8Z9i/ahTkT
	 YjYCtDXmtSXHw==
Date: Tue, 16 Jun 2026 18:21:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 4/8] hw/cxl: Add Streamlined Virtual Channel (SVC)
 property to CXL ports
Message-ID: <20260616182159.6c618a75@jic23-huawei>
In-Reply-To: <20260609105836.3702787-5-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7@epcas5p1.samsung.com>
	<20260609105836.3702787-5-shrihari.s@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jun 2026 16:28:32 +0530
Shrihari E S <shrihari.s@samsung.com> wrote:

> Add Unordered IO (UIO) dependent property SVC to CXL ports
> (Root, Upstream and Downstream).
> 
> The following properties are added to CXL ports:
>     - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
>     - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)
> 
> Note: 256B flit mode property was already added in CXL ports, so reused it.
> 
> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> ---
>  hw/pci-bridge/cxl_downstream.c            | 2 ++
>  hw/pci-bridge/cxl_root_port.c             | 1 +
>  hw/pci-bridge/cxl_upstream.c              | 2 ++
>  include/hw/pci-bridge/cxl_upstream_port.h | 1 +
>  4 files changed, 6 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 7c7a1d1221..6f6f332c07 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -260,6 +260,8 @@ static const Property cxl_dsp_props[] = {
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_16),
>      DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
> +    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
> +    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
>  };
>  
>  static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index e82685d1ab..83fb5968b8 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -53,6 +53,7 @@ typedef struct CXLRootPort {
>      CPMUState cpmu;
>      MemoryRegion cpmu_registers;
>      PCIResReserve res_reserve;
> +    bool uio_capable;
I'd bring these in with a patch that uses them.

This whole thing is simple enough maybe just have it as part of a commit
that uses the properties.

>  } CXLRootPort;
>  
>  #define TYPE_CXL_ROOT_PORT "cxl-rp"
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index ef5480b116..dadad3e15c 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -437,6 +437,8 @@ static const Property cxl_upstream_props[] = {
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
>                                  width, PCIE_LINK_WIDTH_16),
>      DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
> +    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
> +    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
>  };
>  
>  static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
> diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
> index d4186234c8..d23541e23a 100644
> --- a/include/hw/pci-bridge/cxl_upstream_port.h
> +++ b/include/hw/pci-bridge/cxl_upstream_port.h
> @@ -22,6 +22,7 @@ typedef struct CXLUpstreamPort {
>      PCIExpLinkSpeed speed;
>      PCIExpLinkWidth width;
>      bool flitmode;
> +    bool uio_capable;
>  
>      DOECap doe_cdat;
>      uint64_t sn;

