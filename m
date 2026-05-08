Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E53E5EE5;
	Fri,  8 May 2026 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249748; cv=none; b=OaC1zCpmNRjmqWl6OmHOaTRlj4A+EhvIl24asNXbXnf63lmIuy6V9kBly+b23wL7qndfUhG1dZPthwBOihxHRi6mEzBHzRlOizDmmZAKj4eJdfH3XjWOuHPRnjEnhbUDDBO210X+AiWQqvvsPB4OLGhK7gCBxKrYiKmxCbiYL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249748; c=relaxed/simple;
	bh=c6TBEkeuBntYktsk6EylxIRVEo10YiNVBuKQeHwLHpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5bLafni1uMD7fqq1mdYw4wqD97mJxnatkOCX/Onz4gGz5DE+bG3XHzgAbA6pOYBnbEAIjznzOY5BDJ/EJG6KrxQvM5XIs6/Un82WNwme1dTvlY7iRQ/BEmoyXqMongiYoisP08/cxRZ3JW6/7pPQZj+HEHPP3qyF2kjerBclEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLxIehbi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLxIehbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A709BC2BCB0;
	Fri,  8 May 2026 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778249747;
	bh=c6TBEkeuBntYktsk6EylxIRVEo10YiNVBuKQeHwLHpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLxIehbibcW5W3ci0xSFoAT6gEblMZeyAmnD7qokKvZdfCNlpoxXE8gEcFhY925qH
	 3mvR8lEX1b7RKKjKM7Jgb6afV1XRKkFEiT2/bmylWnZO3GbY6alhieUgUAGIPcBMej
	 IAOcr9cc5AYDFTn6KGjtaT3PaAYGtt4g0+vP7wOHsGBWWP3NiBaezk0ylNEnr8hWqG
	 f/aHU7Y3ux8aCYoGbF8ul0fJE9gy5hcdMOM8l9yF6uMiWZBcrvdcu1FksyfVNHdg7j
	 jHZx8BD+DNxu0qB4wTXF45ktv6FoywlpWI/GxU61wfU6vkF/CaHbqm1vW6rmVoct/m
	 dO0Gi4Vv32A7Q==
Date: Fri, 8 May 2026 09:15:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, hans.zhang@cixtech.com, vigneshr@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH] MAINTAINERS: Add Aksh Garg as PCI CADENCE reviewer
Message-ID: <20260508141545.GB85390@bhelgaas>
References: <20260508060951.840233-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508060951.840233-1-a-garg7@ti.com>

On Fri, May 08, 2026 at 11:39:51AM +0530, Aksh Garg wrote:
> I wish to contribute to the review process for Cadence PCIe IP drivers,
> hence add myself as a reviewer.
> 
> Signed-off-by: Aksh Garg <a-garg7@ti.com>

Applied to pci/for-linus for v7.1, thanks!

> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..e2c188a358ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20315,10 +20315,11 @@ F:	Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml
>  F:	drivers/pci/controller/dwc/pcie-armada8k.c
>  
>  PCI DRIVER FOR CADENCE PCIE IP
> +R:	Aksh Garg <a-garg7@ti.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Orphan
>  F:	Documentation/devicetree/bindings/pci/cdns,*
> -F:	drivers/pci/controller/cadence/*cadence*
> +F:	drivers/pci/controller/cadence/
>  
>  PCI DRIVER FOR CIX Sky1
>  M:	Hans Zhang <hans.zhang@cixtech.com>
> -- 
> 2.34.1
> 
