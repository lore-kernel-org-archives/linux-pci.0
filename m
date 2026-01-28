Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2592505AA
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623420; cv=none; b=aCXHY+9LclVNongmoGAU0PSYFQGZkqh5yq0CW2HuS+dqSm+mwTePNrc9KedOFd02g+qyQjlthXfL0RsB1Ca0NqQPbrb97a138hJFKeSDHW46rQo300//he1wMLcQ9c/9NzGBU4ApxuvxW5Tg4UbN3XmMbDT4N/s1WjvwhXZY7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623420; c=relaxed/simple;
	bh=m2nmfDw3EdAECA/BePhJXtpiiJfyNWZXaPHlVlzPpyY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T8VDx61S7vnrmBiBhsOt44BJ6llSF+T49wdC6je/oaOZSkvSOqgnTcffnpMe5skucX8h1q1sTdxt9lR9Gu6nIqnKL9eWH/HbJ2mCK/3u0ytneFCX0pADBOLwqphkFgzywJMwy2l+akAwePWvUzWmNtQxVzae6viLDoGvdgKDLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCzqFsqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCzqFsqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39A9C4CEF1;
	Wed, 28 Jan 2026 18:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769623419;
	bh=m2nmfDw3EdAECA/BePhJXtpiiJfyNWZXaPHlVlzPpyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hCzqFsqrUqYRS7IA7ygGCwLKzhYTjVQV0nKdZ+gB0e1cTEM//59iVGpjJLuYkErzB
	 qioXzJv3mAHUggSOlNlvtGXUdQmG53WRwWdXFwf5YHmokXvfAD9kH2yyxvXq3p26HZ
	 tN9UrlMs95pxocNLjMEP6OKuRHwu68K5grMo9WLMXTyKZHDpDOqYzXBkfszjhzJZeW
	 HsbCeSU34WiAmtNyHRus/WY4sAO/jxLCzKEZrmmikpJMjMcV2PwqyLP3c93uRPbxjS
	 a7u7gpKsPqP0ihqGtEXxoM8gfRw+xvP6C+s6ECueN0JE9km8gTqXijjZExWnEYUP60
	 n5bTcDcK4MvUg==
Date: Wed, 28 Jan 2026 12:03:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, alex@shazbot.org,
	lukas@wunner.de, Keith Busch <kbusch@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH 2/2] pci: fix slot reset device locking
Message-ID: <20260128180338.GA423654@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116184150.3013258-2-kbusch@meta.com>

[+cc Dan, Jinhui]

On Fri, Jan 16, 2026 at 10:41:50AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
> prevent the warning:

I *think* this actually refers to pci_bus_trylock() and
pci_slot_trylock() (not pci_bus_lock() and pci_slot_lock()), since
that's what this patch changes?

It's unfortunate that pci_bus_trylock() and pci_slot_trylock() are so
similar but separate.  If there were combined, this kind of issue
where one is fixed but the other isn't wouldn't happen.

But what about pci_bus_lock() and pci_slot_lock()?  They are also
almost identical, but pci_bus_lock() locks bus->self while
pci_slot_lock() does not.  Should it?

All these almost-but-not-quite identical paths make my head hurt ;)

>   pcieport 0000:e2:05.0: unlocked secondary bus reset via: pciehp_reset_slot+0x55/0xa0
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3378221c5723a..5f8b0d06a1459 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5460,6 +5460,8 @@ static void pci_slot_lock(struct pci_slot *slot)
>  {
>  	struct pci_dev *dev;
>  
> +	if (slot->bus->self)
> +		pci_dev_lock(slot->bus->self);
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
> @@ -5483,12 +5485,17 @@ static void pci_slot_unlock(struct pci_slot *slot)
>  		else
>  			pci_dev_unlock(dev);
>  	}
> +	if (slot->bus->self)
> +		pci_dev_unlock(slot->bus->self);
>  }
>  
>  /* Return 1 on successful lock, 0 on contention */
>  static int pci_slot_trylock(struct pci_slot *slot)
>  {
> -	struct pci_dev *dev;
> +	struct pci_dev *dev, *bridge = slot->bus->self;
> +
> +	if (bridge && !pci_dev_trylock(bridge))
> +		return 0;
>  
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot != slot)
> @@ -5511,6 +5518,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  		else
>  			pci_dev_unlock(dev);
>  	}
> +
> +	if (bridge)
> +		pci_dev_unlock(bridge);
>  	return 0;
>  }
>  
> -- 
> 2.47.3
> 
