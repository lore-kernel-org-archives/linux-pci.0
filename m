Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B040DFD5;
	Sun, 26 Apr 2026 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202563; cv=none; b=fd/4iT0qv3MGNp8bZO7bStO9zR2tDVOOhFhQ64yn/H0qW7JwiAXMyu5OWtZkpVI5y7gZoUqXA3xUPH3XByFnq+Z4vp+nfOnTtC35vYA4X0bMJx0sAHHD3DCLe2Dg6FKiUrqLQBZ+q6JT+lWJDsZxDtC98EPPhVyWBzI0E8VrZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202563; c=relaxed/simple;
	bh=yGR8e4lJC8//FCmcG8g0c1k6zHrnfLVmh0HC6lrnDb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfeNumhIz6v1BJCzVbZlWNLxsLO6kZymFlySl6btYHhrVxJnLOv3CUis1wsCHYuVZg4Bw9+WF9LygeRI4gfhBz7CipTxDGV9JQUneXI9F6KWY1MJM0EOiqWo87A2UQwonFAO1TdzXuXEhFMQ943i3KAdaf0wBKGTtcadfvHpNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKuVZPTm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKuVZPTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E331C2BCAF;
	Sun, 26 Apr 2026 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777202562;
	bh=yGR8e4lJC8//FCmcG8g0c1k6zHrnfLVmh0HC6lrnDb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKuVZPTmzXwnwCobCHegfokaPxO/gtTWtVT8T4nHYBKxaYLiVH+CVO+lYdMffKS0g
	 HZO5orv13gC6SGj76C1CTaaztMmBEW1gJMNbc7D3XK9t+9UFOPI8+TyTmRa1ttdmHT
	 +F9bNWISgUnBVmeOkcil3Xb3ySwDjvhG9GdmDQURWS24qIzhPCI5731q3gsE6jRpAc
	 JZ3ltacnutptuNqYoszbVPrZ5bLau9TN3YjtnUaQoItlZezY4hJuuHr3k6/KMKfrcS
	 F+n7F5ky9jx/Spv6tKLVXhl5oqp4bwHYYJ4hwCTysHtS63I3uGEB3VRaxCpNQvWNEd
	 G0YgogavRsjkg==
Date: Sun, 26 Apr 2026 14:22:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>, Matt Evans <mattev@meta.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
Message-ID: <20260426112239.GD440345@unreal>
References: <20260421174351.3897842-1-mattev@meta.com>
 <20260421194954.GA28413@unreal>
 <a42eff69-e31e-4f99-a63a-5db2402154eb@meta.com>
 <20260422151906.GB28413@unreal>
 <9803c500aead703be8ebbae9d8514d1359784e20.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9803c500aead703be8ebbae9d8514d1359784e20.camel@linux.ibm.com>

On Thu, Apr 23, 2026 at 04:55:29PM +0200, Niklas Schnelle wrote:
> On Wed, 2026-04-22 at 18:19 +0300, Leon Romanovsky wrote:
> > On Wed, Apr 22, 2026 at 03:22:53PM +0100, Matt Evans wrote:
> > > Hi Leon,
> > > 
> > > On 21/04/2026 20:49, Leon Romanovsky wrote:
> > > > 
> > > > On Tue, Apr 21, 2026 at 10:43:51AM -0700, Matt Evans wrote:
> > > > > Extend pcim_p2pdma_provider()'s checks to exclude functions that have
> > > > > pdev->non_mappable_bars set.
> > > > > 
> > > > > Consumers such as VFIO were previously able to map these for access by
> > > > > the CPU or P2P.  Update the comment on non_mappable_bars to show it
> > > > > refers to any access, not just userspace CPU access.
> > > > > 
> > > > > Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
> > > > 
> > > > I don't object to the patch, but this Fixes line doesn't look correct.
> > > > non_mappable_bars applies only to s390, which doesn't support p2p. That
> > > > wasn't prevented before 372d6d1b8ae3c refactoring too.
> > > 
> > > Thanks; I'd chosen that commit as it adds the function that the additional
> > > test is being added to.
> > 
> > Can I suggest slightly different solution?
> > If CONFIG_..._S390 is set, we will unset CONFIG_PCI_P2PDMA and pcim_p2pdma_provider()
> > will be compiled to return NULL, without changing non_mappable_bars
> > description.
> > 
> > Thanks
> 
> Hi Leon,
> 
> I'm not sure this is an ideal solution for the longer term. While ISM
> definitely can't do P2P and is more akin to an emulated PCI device in
> its actual implementation, other PCI devices on the platform such as
> ConnectX family NICs, NVMes and the IBM Spyre Accelerator are much more
> run off the mill. 

Thanks, Niklas and Matt,

I hadn’t realized that the non_mappable_bars apply only to a specific
portion of the system. You’re right — the change should be made as you
suggested.

Thanks
