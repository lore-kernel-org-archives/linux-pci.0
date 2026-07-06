Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799922C08CF
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345758; cv=none; b=nSip+aT5Ckyezkr6FdrnBh3cYOzQ2ledgABWqfjUJK4ZUBDpgERYgwNuGIfM8+JaA/qUtc7ypCzqn9Kk7F+5ig9UQY1WkJKEQBK8s3nPWoCha3MovKkwauo++ENvMPBBKotWYdWeYMCaIJ4q9if4oyf3W8fvxo9zs8LytM+IjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345758; c=relaxed/simple;
	bh=RJdYQi0PoM//5hK9gN4bBQ9zTfKlUTPFi/vPWsYCK8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFV6whmB9TW6yAsbzRl+l3D475rY3UGAY7S4ZhrFSotK9obrnX/wdvwPZOOYPJIXjFC7XP3xPYTnEBJmUQoM3LJ/E6tKXISuhQbgj2SXaaZwK727sZiecr1NX/h5B8DIgcBkkvtTvcaHjDW4jaG+4Gqci1KsgAlyQeSGiVBhk7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ewyydEdH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ewyydEdH"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f0d6853360so21195366d6.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783345756; x=1783950556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XwHo/0YkkJmp15u3gq5DlM2DOcKv24yUlUoqLvzeWGE=;
        b=ewyydEdHlB5bHaoCf5xI9Iuivu8X7ed1wIiEsHreqbZon60xbM+qwqLHNmxZRUmlqG
         qy1Qf7TvUBk5gjSEWzX0vdnaavEhswESDWskn5z+p95W0pxYNr+nCNGgYhkKHizP8GiY
         y12eTtVtI4N2y4Ry7bwTpocpZHi89+IZ7qpWJJfk4MtlrGZc/RxW37vgza+uW//zlRn0
         btnKmK3Qie3+G24lqn8WHEqhVYPGMXOktoJGzPqRXypA8X0Z5WHf/LB5NQr7Stid6oOg
         C60BwGCs+GVjuWj0QcO3MYgzZ1P7Gr+vNM+IsDEz47FIAqpUiKM7wMKJ/NZs8N7Wpkk8
         DiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345756; x=1783950556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwHo/0YkkJmp15u3gq5DlM2DOcKv24yUlUoqLvzeWGE=;
        b=pmBsyFLV40sX/0jz702t5RfkzWfYDRQi/Ux5LJYEWmUmFfEHqVs9i1TMqQJYKwP/4y
         VqMCVdP63VBgttd4qGfeZ+PYuhjHXKxF714lyLQfwTQUd6BXt2X7ldm9y+35eqvUVD8V
         LsZ3358SNa2TqnbmpotLafpghxb4Drf2MfIPgJZ3f0x1pJMOWeKF5w7tGEMT/NxkJy6P
         v18FDl5fPGpUK0Bo0L6eWP/0LEuMQ9qyXh6LpG8aAZfPZ8jnyersvIdsaqVx6EhvTtX/
         k4MsSz/t1Dt6Oc9WLWPiC1srt0D5er2OT75RdXydHDA1JoPFW+417Vtic2RZDqrDBrHy
         1SPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGGpNPsPGfybsGyC1u9BIL4KFS4BQahPIhmuqi4uL/zEhFIfd2i/Iki1J9eBBqU5F9lqCwnAoIMEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Sl0OOlM5FtZXT8h/1LiTMkm1oHwnPOuHYJDgwFo8zbA4P0hX
	8Uz/m5+nx6jTW+7PSm/MIMp9f2y/Ajj0M7rsUC/q5EfClOCZNSX1jr1ti4lqOYA71P8=
X-Gm-Gg: AfdE7ck99PTOuuJXCyr1CppTzWAOLbZZ8moYIrzOsGMdC8JeL+NvIfyLQ4jzg0gVvrK
	PtX7wlQHoe4juob8zqtH6zsvajyAA5S4+gJnnOOWQXQJY3XrJqwkVZYTkLP9GQjQ4TSUXVDEn7l
	6YrAgryeK3vnHtXkPYNKXjBkzbpUfYXnBWnMPJ97xth1RxOsh7C+cbza9xrjcPxwW1ulJ0ZoTn/
	ajL9R2YiyFzZALPSJkstS5sQTSg1TK6VvCstAAaicLLGQBiwS2wYYg3K0fiUHDPkX59A6a7hI5b
	MHwcAQl5d3caSGDlmRZmXn2wzFi64gxmEoqqBJl+Sm3EcbZW08kUMFDRcp7RbTZWYpxS8w09mZe
	Iif2MByobDSORB7bLy94uiloZ4ahnpuVP4079Zv80Ht9MUSRN6/7ZKAPq8xPo
X-Received: by 2002:ad4:5aa2:0:b0:8f2:fbb1:cec4 with SMTP id 6a1803df08f44-8fcb2893eb8mr6044896d6.19.1783345755411;
        Mon, 06 Jul 2026 06:49:15 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4718141e6sm136628496d6.24.2026.07.06.06.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:49:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgjhC-00000000T1F-0z1i;
	Mon, 06 Jul 2026 10:49:14 -0300
Date: Mon, 6 Jul 2026 10:49:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev, ankita@nvidia.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 09/15] PCI, device core: Move "untrusted" concept to
 DEVICE_TRUST_ADVERSARY
Message-ID: <20260706134914.GD107792@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-10-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705220819.2472765-10-djbw@kernel.org>

On Sun, Jul 05, 2026 at 03:08:13PM -0700, Dan Williams wrote:

> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index a08523d348d8..a4233bdf9804 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -291,6 +291,14 @@ config DEVICE_TRUST_NONE
>  	  possible, the device is blocked by an IOMMU from accessing
>  	  assets.
>  
> +config DEVICE_TRUST_ADVERSARY
> +	bool "Adversary"
> +	help
> +	  Device is allowed to bind. Bus, IOMMU, and driver layers may
> +	  react to this trust level by disabling access validation
> +	  bypass mechanisms like PCI ATS. When device is unbound from a
> +	  driver the device is blocked by an IOMMU where possible.
> +
>  config DEVICE_TRUST_AUTO
>  	bool "Auto"
>  	help
> @@ -317,6 +325,11 @@ config BUILTIN_DEVICE_TRUST_AUTO
>  	  a driver and deploy all available mechanisms to allow performant
>  	  direct memory access This trust level does not grant TCB privileges.
>  
> +config BUILTIN_DEVICE_TRUST_ADVERSARY
> +	bool "Adversary"
> +	help
> +	  Deploy mitigations in the IOMMU layer and driver to limit access.

I'm not sure it makes sense to have these options as compile time
defaults. Arguably the non-built in path should only be auto or none
and everything else should be handled by the initrd at runtime. If
necessary a sysfs for the initrd to set a kernel default might make
sense, IDK.

Ideally built in devices should not be any kind that is hooked up to
the iommu.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..957ef77911a9 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -588,16 +588,11 @@ static int iova_reserve_iommu_regions(struct device *dev,
>  	return ret;
>  }
>  
> -static bool dev_is_untrusted(struct device *dev)
> -{
> -	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> -}
> -
>  static bool dev_use_swiotlb(struct device *dev, size_t size,
>  			    enum dma_data_direction dir)
>  {
>  	return IS_ENABLED(CONFIG_SWIOTLB) &&
> -		(dev_is_untrusted(dev) ||
> +		(device_untrusted(dev) ||
>  		 dma_kmalloc_needs_bounce(dev, size, dir));
>  }

I think it would be nice to use the new 'adversarial' word here and in
other places instead of untrusted.

Jason
