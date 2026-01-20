Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA842BEC30
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908176; cv=none; b=n/6wvID56dXf89sRpv+w7xjCwByEpiasz6WwizWkV59nW/BQbqop7t12DklrXOKe10VlVO6VCbronQC8eOOeB5/hQwwARVCep0eh6qGYOPpYk0Y/lfXs9LB7PQGaiCTI+ElCHAid3iYyvJVFvc7IVXKeRiZQBaBDkNAKJ1Hzc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908176; c=relaxed/simple;
	bh=vByuyCrWDkOAVkNehY4knsUVjW5PoPATbJZ1aATTwSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwOwIQIpofSMcPd8L6qOWk4MFGifJywlg2FzyeOzU6yt+dfQ+eBLgEcGU1Wjcn57/tsKlxiBB6Uo3ssYEOBWMz/D02qo5NckRo+/KSkoG20HoYtH8NZLzGtipY3DPLJsZld8xyOgu7DBfSi7i0Hg18yovoJZbUJu7lGebuzVvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls06Ncy6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls06Ncy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3123FC16AAE;
	Tue, 20 Jan 2026 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768908175;
	bh=vByuyCrWDkOAVkNehY4knsUVjW5PoPATbJZ1aATTwSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ls06Ncy6OdYhIKi0NUOxUH9ixPGekcYjv+cO0aUM4KIbRJBawIRlB+ocNaxY0g854
	 tfl7rKqNaUnk1wLBl5gKQ2sxwrjR0rfq/Oe4muPgq9vsTIBanpeMZ+KjqX995t6PeY
	 n/C5vCiHbKBGtfXVhHc2EteV80Qzhz/M5JC5JENiuRxtD+zHWpv9VaatB+OkwJM4s8
	 rTimzvxGrqQEGKm24655iaUG/nI5CBKT/1cg1nbi1GGc8uqVvfkJ6qBtUsMceGO0em
	 oj7KfNBlsWVXF/7jbRR5onoVD2PQvHV6M4biOt0EmMn4xRz5bM33nyKb9pfjF1cXpg
	 g5OHhoNsn3FMg==
Date: Tue, 20 Jan 2026 11:22:50 +0000
From: Will Deacon <will@kernel.org>
To: Jess <jess@jessie.cafe>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2] PCI: host-generic: Avoid reporting incorrect "missing
 "reg" property" error
Message-ID: <aW9liuQx26sZ3TYG@willie-the-truck>
References: <aW5gmRDAlqR0Ii5S@willie-the-truck>
 <20260120004444.191093-1-jess@jessie.cafe>
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

Couldn't have put it better myself :p

Acked-by: Will Deacon <will@kernel.org>

Will
