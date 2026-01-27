Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DB361676
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530157; cv=none; b=aOHxidrHaviV60dg+0WuiQRC9+mclzpdjkY/+FWt/t80J+TbnJa/vZu/exhPph/C8KZDpuz9beIBZVSxNffILfLB4XN++PH+xDbsB3kr8jJprLwMLJh5GiCBsGWECovhXuHqAbLM1hMQiscN7yzU1hSTXVgYqyB3DP8D7+OKSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530157; c=relaxed/simple;
	bh=cJBU2w4Bg1+PrY0py/OyZXMk24IV/za0UkmiXtJko7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt4qU42OsngjCv/s4cmxP70G1u8gK44t9GZd1c+6rNP+Md+xQGm9zD7FhwQJtr9C08VlHa5ejHuj3ZLVvvOspjyTpFLF5csaI4idl1zddWGgP4mPrn931w5Kt3aC6rsk96+MDLRh8oh6tJKAbGaSr3E8AXWMnNQwkE/rp2IqC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI1y+8Fp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI1y+8Fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C851C116D0;
	Tue, 27 Jan 2026 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530156;
	bh=cJBU2w4Bg1+PrY0py/OyZXMk24IV/za0UkmiXtJko7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AI1y+8FpRfEntjqoBciFH9mwFWKVhKSF/dGsEsUZtM/Yeq/97hgjwKo8H90zX6UN1
	 XkzNR5lIYj+VcRoSsfzA0d+kjlSkIHLeAbtwrenJymGaQtHd8i5llKjVE1ViS1BpLP
	 75XSXo3NGN5K+RHF8ymTsMVFeLQ4rklPLf4Dn/ZPCGksPEvdnnL3qQ7OGznKfg65Er
	 tXGog7W8W6W+2gmjjtCwM2a1LtrMOeP08hsnESk42jHKnvEHrT1v6oQXJhkbXB4e05
	 NFMhEjbXvmKvKfJGwdUDoEDgBKbzXcdCD2SBC6rtGebD3IEULRm1l3ZRec2EkPFiw9
	 uZ8H1+knsVYQA==
Date: Tue, 27 Jan 2026 09:09:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, alex@shazbot.org,
	lukas@wunner.de, helgaas@kernel.org
Subject: Re: [PATCH 1/2] pci: fix slot trylock error handling
Message-ID: <aXji6yYImTyT26Wm@kbusch-mbp>
References: <20260116184150.3013258-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116184150.3013258-1-kbusch@meta.com>

On Fri, Jan 16, 2026 at 10:41:49AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The device lock isn't held if pci_bus_trylock() fails, so the code had
> been attempting to improperly unlock it.
> 
> Fixes: a4e772898f8bf2 ("PCI: Add missing bridge lock to pci_bus_lock()")
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Ping?

> ---
>  drivers/pci/pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 72d88ea95f3cc..3378221c5723a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5494,10 +5494,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
>  		if (dev->subordinate) {
> -			if (!pci_bus_trylock(dev->subordinate)) {
> -				pci_dev_unlock(dev);
> +			if (!pci_bus_trylock(dev->subordinate))
>  				goto unlock;
> -			}
>  		} else if (!pci_dev_trylock(dev))
>  			goto unlock;
>  	}
> -- 
> 2.47.3
> 
