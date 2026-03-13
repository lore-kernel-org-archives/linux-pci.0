Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAA34A3D8;
	Fri, 13 Mar 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413532; cv=none; b=Gg13MHeUvzMnUmI83VB622rATY6gCI9bOtCCtv/xX560933LNtam774YrnWwt6SlAroXhmJ0CMYNaDuY5WGAmwY7azH7schzt6ePYXzrVaL2ZmFZJ5oJAabTIWYp/n7qVVspQcQw0oUSG9b2+5pyoJhX7D30gMQArQhVLqFtgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413532; c=relaxed/simple;
	bh=GDxI1FCJENM6a4be7XphjPZMbxVO1wffIfxGwVnFkug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VE+naqxTY8bNE3J2l8u0WbpPI1ok3oCcAO3kj805kwroWqrzzOjty0j6ev2CeaU0sOehkDRxNq4GJxneuL+RAvqj8kpqpE7ojyVcMN9Y1AyniiC21KLHp3bAc3TXDmQjJOXFw+iI4sVye6gYcR5v1CUWgeKVs7wsAtbigwFJIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ7D25Cm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ7D25Cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE56C19421;
	Fri, 13 Mar 2026 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773413531;
	bh=GDxI1FCJENM6a4be7XphjPZMbxVO1wffIfxGwVnFkug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nJ7D25CmCdDkM2SXiiv7SGWCINMj7gRuztP/5hkReitE8ZynM2Pa0OKTR5/Idl3IO
	 waEJ+XBHin8ze8NkuJU5Te1e1H9aa0XAMwqpt3Ya3tkKIlQ6gYcDgafj96vwQkfkat
	 Ngac95gUZh47BTt8bIO4+wI9kBbu2XpPhwZXX6LMvS4wjvOB81m1bt9YPQEEyBnpC7
	 eO5h4wy2lR2BqjjEFES+cquLPxCASLgCTrh8rSfX3elOpI3hoYLEVJVxU0mrvLzhyF
	 zWfOa+XNWGF5yF2vUzb15BxNbPxbS1hN7K9kLKQPPvdcYkJq5VWt+pNpKUOGBHFiGO
	 YXJ6Ubll7ujew==
Date: Fri, 13 Mar 2026 09:52:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Nisbet <peter.nisbet@intel.com>
Subject: Re: [PATCH 1/1] PCI: Fix premature removal from realloc_head list
Message-ID: <20260313145210.GA1341790@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313084551.1934-1-ilpo.jarvinen@linux.intel.com>

On Fri, Mar 13, 2026 at 10:45:50AM +0200, Ilpo Järvinen wrote:
> reassign_resources_sorted() checks for two things:
> 
> a) Resource assignment failures for mandatory resources by checking if
>    the resource remains unassigned, which are known to always repeat,
>    and does not attempt to assign them again.
> 
> b) That resource is not among the ones being processed/assigned at this
>    stage, leading to skip processing such resources in
>    reassign_resources_sorted() as well (resource assignment progresses
>    one PCI hierarchy level at a time).
> 
> The problem here is that a) is checked before b) but b) also implies
> the resources is not being assigned yet, making also a) true. As a)
> only skips resource assignment but still removes the resource from
> realloc_head, the later stages that would need to process the
> information in realloc_head cannot obtain the optional size information
> anymore. This leads to considering only non-optional part for bridge
> windows deeper in the PCI hierarchy.
> 
> This problem has been observed during rescan (add_size is not
> considered while attempting assignment for 0000:e2:00.0 indicating the
> corresponding entry was removed from realloc_head while processing
> resource assignments for 0000:e1):
> 
> pci_bus 0000:e1: scanning bus
> ...
> pci 0000:e3:01.0: bridge window [mem 0x800000000-0x1000ffffff 64bit pref] to [bus e4] add_size 60c000000 add_align 800000000
> pci 0000:e3:01.0: bridge window [mem 0x00100000-0x000fffff] to [bus e4] add_size 200000 add_align 200000
> pci 0000:e3:02.0: disabling bridge window [mem 0x00000000-0x000fffff 64bit pref] to [bus e5] (unused)
> pci 0000:e2:00.0: bridge window [mem 0x800000000-0x1000ffffff 64bit pref] to [bus e3-e5] add_size 60c000000 add_align 800000000
> pci 0000:e2:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus e3-e5] add_size 200000 add_align 200000
> pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: can't assign; no space
> pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: failed to assign
> pcieport 0000:e1:02.0: bridge window [io  0x1000-0x2fff]: resource restored
> pcieport 0000:e1:02.0: bridge window [io  0x1000-0x2fff]: resource restored
> pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: can't assign; no space
> pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: failed to assign
> pci 0000:e2:00.0: bridge window [mem 0x28f000000000-0x28f800ffffff 64bit pref]: assigned
> 
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> Reported-by: Peter Nisbet <peter.nisbet@intel.com>
> Tested-by: Peter Nisbet <peter.nisbet@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/resource for v7.1, thanks, Ilpo!

> ---
> 
> There's no publically available report on this, thus no Link/Closes tags.
> 
>  drivers/pci/setup-bus.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 61f769aaa2f6..b0b00f10e31c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -434,6 +434,10 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
>  		dev = add_res->dev;
>  		idx = pci_resource_num(dev, res);
>  
> +		/* Skip this resource if not found in head list */
> +		if (!res_to_dev_res(head, res))
> +			continue;
> +
>  		/*
>  		 * Skip resource that failed the earlier assignment and is
>  		 * not optional as it would just fail again.
> @@ -442,10 +446,6 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
>  		    !pci_resource_is_optional(dev, idx))
>  			goto out;
>  
> -		/* Skip this resource if not found in head list */
> -		if (!res_to_dev_res(head, res))
> -			continue;
> -
>  		res_name = pci_resource_name(dev, idx);
>  		add_size = add_res->add_size;
>  		align = add_res->min_align;
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> -- 
> 2.39.5
> 
