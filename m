Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4B22B594;
	Fri,  7 Aug 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107764; cv=none; b=UwrpGPC3pg83OWbOV9duZ3ETA/aNWAd1jFIexUqAkOFAQbbSpX8O3F3+5vulifSSVfCQATuul512VTQqaQIAY5qiriLgBNOAQE3qU+gYD1Ci7qEviAZbGlIn9iumTqLir7eiXHFM6xH25wziIfyEHEchblAsZDvHFaymwg5YA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107764; c=relaxed/simple;
	bh=wOJ2tSpvQo55CkV7ANBuIXWxwK8nr6n7X4QMVY4FZ/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5ZnvvJjfvugHDxSDmCpMvoAEJ4mO2Ta1VjaiqbRyWb0Iz7SnRMO5ujZ/1lPjsSifhwvEVz69G5wyx/Uca5Pu7QgyLG9fAeTWJ2D8lCl31QwztwvKbcaZAzP2JXOsZvwY+sBbAZLqtGfrOwD6m5p2oIyUhLDcKvAnqz4u1nslRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA97iKkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA97iKkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584601F00A3A;
	Fri,  7 Aug 2026 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107756;
	bh=CT91bWbT89hzh8GLDq+kFpqHsCca67iKK4YYFF9czfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fA97iKkGr5Tp5nXOgZUvuj4AjFGmisxCkr0YOiWphS3qfBNcY2vfdktm/Y74Oaz2D
	 l+gtrPBFTtgnE+kuCZGUyRZSeiTYkgXzdksapFo6kXo2cTffL7O/bpbS5qLh7MYuPP
	 DsgsCn1biFR6kY/GJxdNNHTPR2tSJkbj9EHLzIMEcqyXWgjJFS4EWHrfC07XFc+zGG
	 Ds3lrylVLQR9OyNNl5DwxIVcd2e8JsQaURTgGJfm3U4/pO+zNZbeIohhMwiHqxjZHq
	 C3LOuthuIzcLQKHzWputkNdIPxxAHnbagoyXj52FLS+2WRRIpTaF7ukB2Ow0dJD8Ec
	 pdrQSeI3oCe+g==
Date: Fri, 7 Aug 2026 16:02:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 12/13] PCI/P2PDMA: Add KUnit coverage for the ACS P2P
 routing walk
Message-ID: <20260807130230.GA387018@unreal>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-12-0cec14812965@nvidia.com>
 <20260806114433.D9FA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806114433.D9FA81F000E9@smtp.kernel.org>

On Thu, Aug 06, 2026 at 11:44:32AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] pci_p2pdma_release() skips synchronize_rcu() when p2pdma->pool is NULL, leading to a Use-After-Free of the pci_p2pdma struct and its XArray inside RCU read-side critical sections.
> --
> 
> --- Patch [12]: [PATCH v2 12/13] PCI/P2PDMA: Add KUnit coverage for the ACS P2P routing walk ---
> commit c4a68b62f4ec894cc35240eda46bf42dc5f562d9
> Author: Leon Romanovsky <leon@kernel.org>
> 
> PCI/P2PDMA: Add KUnit coverage for the ACS P2P routing walk
> 
> Extend the ACS KUnit suite with end-to-end coverage of
> calc_map_type_and_dist(), the provider-to-client hierarchy walk.
> 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index c7680964d8a64..18e5339bc49e9 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> [ ... ]
> > @@ -859,6 +859,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> >  	rcu_read_unlock();
> >  	return map_type;
> >  }
> > +EXPORT_SYMBOL_IF_KUNIT(calc_map_type_and_dist);
> 
> [Severity: High]
> This is a pre-existing issue, but does this code have a race condition
> leading to a use-after-free when interacting with pci_p2pdma_release()?
> 
> If a device acts as a P2PDMA provider without setting up an allocator pool
> (for example, via vfio-pci or mlx5), pci_p2pdma_release() skips
> synchronize_rcu() because p2pdma->pool is NULL:
> 
> drivers/pci/p2pdma.c:pci_p2pdma_release() {
>         ...
>         if (p2pdma->pool)
>                 synchronize_rcu();
>         ...
> }
> 
> When the provider driver is unbound, devres frees the pci_p2pdma structure
> and destroys the XArray. Concurrently, calc_map_type_and_dist() executing
> here inside its RCU read-side critical section can dereference the freed
> p2pdma pointer and call xa_store() on the destroyed XArray.
> 
> Should synchronize_rcu() be called during release regardless of whether
> the allocator pool is set up?

No, we already discussed that here.
https://lore.kernel.org/kvm/20260729100840.GM12003@unreal/
https://lore.kernel.org/kvm/20260805003127.GJ27883@nvidia.com/

But let's see if I can write a documentation patch that helps AI
tools stop complaining.

Thanks

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com?part=12
> 
