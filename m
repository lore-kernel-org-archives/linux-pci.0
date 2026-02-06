Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE46F2F2
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418151; cv=none; b=obcR6kavxUbV8/ob1cvLLSf/Fh8J2GxXM9nEYy8l+iwbg+aEVudMb2G/Be2I2iyHGVhp1xVZnxVwwV8rVKzUSptg3Z8ArV1jROmK0ksEM5wjuBZ7asWhoIKxuhDC2HrVcF4q4yOD1V9R5DUq6N/yxgYuKRqa1UF2gxXbTs0co+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418151; c=relaxed/simple;
	bh=VEr+Ea6i+JVjbP6cXpe7i/eP3D7YBNBWLoDPrTGR0xU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BNtpcbfMzoIwJ34+ctr2g9R25eVFGOdLSeFO25PLEI62J7hEVik6tV9KschEgtDdcVJnbyr+wJXcCln1rLX53QMl/ph3M01N5j9lqYx9flxhX3JwTbn+3Hk4GVMiaqAg9XiPFUpensNU3l12QiuSfbyGfVFMF1vUaFZM9PtkWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+P0JYAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+P0JYAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D5CC116C6;
	Fri,  6 Feb 2026 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770418150;
	bh=VEr+Ea6i+JVjbP6cXpe7i/eP3D7YBNBWLoDPrTGR0xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L+P0JYAJsKV80C3peQwnV34y6EvW5k1ISNp+3st2AHp1V8KBMCkYGI3t4VaJKNb3G
	 qRsyVFRYGCa9gliGGOr5/X/3JofLXkhpWeH3yn9z22gFYTUgYselNy77XGpgYBR8B+
	 o0eKAJoKgdnBLUHdKhGKlXK0Z/sSb+xsdgHqW4sr0ybd2YzMNnjXascZOOQWjmjVLi
	 s/QKv9yHFd+NQFMhjs5NAj6LkLPfjGeo1SGH43JVtxFgm2q3Pjj1vkeAjMEXq8lBVN
	 KUps5BJc+1ggc7qLdxJKriGeY2OBQViPtL/nNHneEmSH25HyYs3aTSzRlaVZpmVWo9
	 xSptKRyctwRoA==
Date: Fri, 6 Feb 2026 16:49:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jess <jess@jessie.cafe>
Cc: will@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2] PCI: host-generic: Avoid reporting incorrect "missing
 "reg" property" error
Message-ID: <20260206224907.GA100198@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120004444.191093-1-jess@jessie.cafe>

On Tue, Jan 20, 2026 at 01:44:44PM +1300, Jess wrote:
> When the function pci_host_common_ecam_create() calls
> of_address_to_resource() it assumes all errors from that callsite are due
> to a missing "reg" property in the device tree node.
> 
> This can manifest when running the qemu "virt" board, with a 32-bit kernel
> and `highmem=on`.
> 
> After the following calls:
> of_address_to_resource()
>   -> __of_address_to_resource()
>   -> __of_address_resource_bounds()
> 
> this overflow check can fail due to PCI being out of range:
> if (overflows_type(start, r->start))
> 	return -EOVERFLOW;
> 
> This leads to the very confusing error message:
> pci-host-generic 4010000000.pcie: host bridge /pcie@10000000 ranges:
> pci-host-generic 4010000000.pcie:       IO 0x003eff0000..0x003effffff -> 0x0000000000
> pci-host-generic 4010000000.pcie:      MEM 0x0010000000..0x003efeffff -> 0x0010000000
> pci-host-generic 4010000000.pcie:      MEM 0x8000000000..0xffffffffff -> 0x8000000000
> pci-host-generic 4010000000.pcie: missing "reg" property
> pci-host-generic 4010000000.pcie: probe with driver pci-host-generic failed with error -75
> 
> Make the error message more generic.
> 
> Link: https://www.qemu.org/docs/master/system/arm/virt.html
> Signed-off-by: Jess <jess@jessie.cafe>

Applied to pci/controller/generic for v6.20, thanks!

> ---
>  drivers/pci/controller/pci-host-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index c473e7c03bac..d6258c1cffe5 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -32,7 +32,7 @@ struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
>  
>  	err = of_address_to_resource(dev->of_node, 0, &cfgres);
>  	if (err) {
> -		dev_err(dev, "missing \"reg\" property\n");
> +		dev_err(dev, "missing or malformed \"reg\" property\n");
>  		return ERR_PTR(err);
>  	}
>  
> -- 
> 2.51.2
> 
