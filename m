Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727493128B2;
	Wed, 22 Apr 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871151; cv=none; b=HubI+Pd8r45U40lba4xCDOcxxAGBQco0+BjqEou+69GL6oa7hpM0uIvHvm5YMstHoWUtQBQuOiVJgNvqPZ/T+k/hslz5PWuyIwTQNpuJXe5jiTgdedb4BLxUE/m84yfasppD8TouxJ8shs9IgGfFyItkuiHeLetlUSiG3pJrBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871151; c=relaxed/simple;
	bh=iEk6as1kJcG0B0J/R9pwwoLMqKKpP+WeDhV8CmuB47I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INpMLmqqtzszWyWjGfJ5erCubavVORP+ad46TnynharFBdCE24JQRk6RvS8YbafL4T+2cxXwg+spauHbI0xdYQ1sFiJW3/LSxGm95/McYDeMB6ii1lUO81oEwHiwQCHwbCQpfiG+nHhWwzSVmZF8fZ7PFte+dp9dv6sSaSN/K+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk2yVjzd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk2yVjzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CB4C2BCAF;
	Wed, 22 Apr 2026 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871151;
	bh=iEk6as1kJcG0B0J/R9pwwoLMqKKpP+WeDhV8CmuB47I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jk2yVjzdkhEsYnN+CeiqMbMnlTQ+BzsQmybscOuSGaxni3Ib1TlDBc+diQnGZKWY4
	 yq8rhIZxfYMXip+TciTwhfo3iPalda827NCOFun0kKp2MZTi80uVL9L2N+XMDswfJu
	 OqmaX/QwqZ/ugWIDIN9MrQBqmmTbhnlYk/1V+jwfMMG6rVWr9XjA3zW0XVVdRxv8EV
	 bw5FdE6xsSefoiRv8csapkOHY2e/hASJ+9mB9tMLYsCLnv/P5v4j7P/oFauAsF4n7X
	 ES65VPVxDxfg2nYvFdvXcqHvRz1s5vRR+PKBGg+qjSBMfFtpno1C1SMNCI7bZ4V12u
	 v9Vqg3tDkq6SQ==
Date: Wed, 22 Apr 2026 18:19:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
Message-ID: <20260422151906.GB28413@unreal>
References: <20260421174351.3897842-1-mattev@meta.com>
 <20260421194954.GA28413@unreal>
 <a42eff69-e31e-4f99-a63a-5db2402154eb@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a42eff69-e31e-4f99-a63a-5db2402154eb@meta.com>

On Wed, Apr 22, 2026 at 03:22:53PM +0100, Matt Evans wrote:
> Hi Leon,
> 
> On 21/04/2026 20:49, Leon Romanovsky wrote:
> > 
> > On Tue, Apr 21, 2026 at 10:43:51AM -0700, Matt Evans wrote:
> > > Extend pcim_p2pdma_provider()'s checks to exclude functions that have
> > > pdev->non_mappable_bars set.
> > > 
> > > Consumers such as VFIO were previously able to map these for access by
> > > the CPU or P2P.  Update the comment on non_mappable_bars to show it
> > > refers to any access, not just userspace CPU access.
> > > 
> > > Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
> > 
> > I don't object to the patch, but this Fixes line doesn't look correct.
> > non_mappable_bars applies only to s390, which doesn't support p2p. That
> > wasn't prevented before 372d6d1b8ae3c refactoring too.
> 
> Thanks; I'd chosen that commit as it adds the function that the additional
> test is being added to.

Can I suggest slightly different solution?
If CONFIG_..._S390 is set, we will unset CONFIG_PCI_P2PDMA and pcim_p2pdma_provider()
will be compiled to return NULL, without changing non_mappable_bars
description.

Thanks
