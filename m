Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213083CEBBD;
	Tue, 16 Jun 2026 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636268; cv=none; b=MylnXYpkZpALAuPIjQ+dCHQB4gexuOdtKfxCMXQBbv0JP+Vm7dzkfEEi4u6UYsKHrD/zYRO2vAlKp5DHxtWr9extCn24b5x4jcgdUBY6z5elC+g1yDwqhOOaHOYTU+yvQsKTASUMUR7YQWEsv7dtWw3bmFXwa1n9aKlnPnSLkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636268; c=relaxed/simple;
	bh=VSLNvE4kRbOqrt1OJ/KhontEzREN1pu1ATQom+s29Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blHxZ05JUEFhEgeEIT2xtwv/oZl6K43qirtuleaP3fQOBX5Q70FERrbnhQCXro7zthwxUtRTuxjbUZAClh+7ZQp3d6I1IpeRgYfOor8AIoIMGwEVJHDtov7F6UgBxpyxO5CoGStZJyxQLKlnqJIxVfBXQ3dfOaK7vYv1aDEf0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ8K9jw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ8K9jw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1C81F000E9;
	Tue, 16 Jun 2026 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781636266;
	bh=+u2CQ3JCxLqq4KVytfesXpoMNP5xMMmxB4qs1tyq7Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oJ8K9jw+0G6GbVqrtV7Wp5uDPVNDzJyVznwciNyfi7CJpVfe6u78q+d31LT4+SW9F
	 /GFNBDB/P7xFdXRPOcCodSIl4c/GEigaP4d1/vld6U2mLaIKbUqgbPU7zqxYBpXWZQ
	 JrEl0Jo1jceZ38frwuF9Ra8CtL1mF4BnF7zyOzXB1ZaeudpnD8Pzr0rlaNXVi4/Kus
	 Pc865ZpbGikFzeXhhErp/7h+RNegrOn2hmk1oS+6+Sd8dVZewJvs6KhZD/PKaVB4EM
	 g4BpiEgPKiJpexTI7DbNM88gHiDtuN60yDCtXt7IUN0Vy1Rlji22z1v8rmQ9dBrTOz
	 vtWECPIntbizg==
Date: Tue, 16 Jun 2026 21:57:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Use RCU_INIT_POINTER() to clear pdev->p2pdma
Message-ID: <20260616185742.GS327369@unreal>
References: <20260612083452.1639-1-lirongqing@baidu.com>
 <20260612084824.A3DE91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612084824.A3DE91F00A3A@smtp.kernel.org>

On Fri, Jun 12, 2026 at 08:48:24AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] pci_p2pdma_release() skips synchronize_rcu() when p2pdma->pool is NULL, causing a use-after-free of the devm-allocated p2pdma structure and corruption of its map_types xarray for concurrent RCU readers.
> - [High] Missing devres action removal in pci_p2pdma_add_resource() error paths causes Use-After-Free of p2p_pgmap during devres teardown.
> --
> 
> commit eb4ec2c32d602512abbeccbe720637cf83f85cb6
> Author: Li RongQing <lirongqing@baidu.com>
> 
> PCI/P2PDMA: Use RCU_INIT_POINTER() to clear pdev->p2pdma
> 
> Since pdev->p2pdma is an RCU-protected pointer, directly assigning
> NULL to it violates RCU semantics and triggers sparse static analysis
> warnings.
> 
> Fix this by using RCU_INIT_POINTER() instead of a raw assignment,
> ensuring proper RCU annotations and consistency with the subsequent
> synchronize_rcu() call.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 7c898542af8d5..fd98624208c50 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -236,7 +236,7 @@ static void pci_p2pdma_release(void *data)
> >  		return;
> >  
> >  	/* Flush and disable pci_alloc_p2p_mem() */
> > -	pdev->p2pdma = NULL;
> > +	RCU_INIT_POINTER(pdev->p2pdma, NULL);
> >  	if (p2pdma->pool)
> >  		synchronize_rcu();
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could skipping
> synchronize_rcu() here result in a use-after-free for concurrent RCU readers?
> 
> If p2pdma->pool is NULL, synchronize_rcu() is bypassed before destroying the
> map_types xarray and returning. Since the p2pdma structure is managed by
> devres, it will be freed shortly after this callback returns.
> 
> If concurrent RCU readers (like those executing pci_p2pdma_map_type()) obtain
> the pointer just before it is cleared, will they continue to access the freed
> map_types xarray and p2pdma structure?
> 
> >  	xa_destroy(&p2pdma->map_types);

I do not believe this is a bug. The p2pdma->pool field is NULL only for
in-kernel users that fully control the lifecycle of their drivers.
In that mode, there should not be any concurrent RCU readers when the
device is released.

Thanks
