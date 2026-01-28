Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C52F7ADE
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769627603; cv=none; b=QrHI80oi0woINYFfRZBc3WUEjiHu8e2kuwwAiv832y49vO+AAvPCcYj0NFYp6ob082rXF4b2NEvelKeAgjYBdizUoSVM3cQYwFD+pcDhtsaL6ltYsyy+njERjp+cARBN0w+f5OLXneV2seMfNcLWu/GFB5ynlczp3EC6CTcPRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769627603; c=relaxed/simple;
	bh=k+RSilmLGwIa83ArPwfFfQSGypZX15F428SUTYk8kow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be2VV5gICOcUOXfZiapDEQ3RTaDJ7PvbusazFjNPWtyuSxKdm4G9jjIysh/dy6hqosFEL3Zm30SfJYF06zQWAi+peBzzB9b0lpaQ9uLvgTh7c2TrQphSHLccaqyo78xqwtMy/9hcfDfklF3PtFFX4dMaHC0Rvv3AsdN87/yXExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djrEqAWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djrEqAWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EACC4CEF1;
	Wed, 28 Jan 2026 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769627602;
	bh=k+RSilmLGwIa83ArPwfFfQSGypZX15F428SUTYk8kow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djrEqAWuEWvfomQ72EHQwVN+FLBhQ9jM3VWlhM5IH7AACzk/MrCSAtW+E1E9cHwIW
	 +94OSiw28q5JyO0o5IIZMT3bhkPS4PQ6b2OwpL0A8x2wUZ1POY9KIjQwxe+URnsLdI
	 vYDmk3NzKeEovcTh4+1dEUYrL81tyUmAWJVE8ZzODHxAGtrqruwxku/lbVJTjAi5eP
	 Bkn3JU+pCYSSePPeauRFSWMaF6z9TYXEN0sYfmC5r2Cq9CfwtO9mJ10mZHSVK+aSUT
	 4gtM0Fyh4SsG4ffqtBathLRJvE2jh1r5CVzxcgta/ViPv7kcnsKiHKZ3iZ/uYEltNH
	 dl6yVjZUD/e8Q==
Date: Wed, 28 Jan 2026 12:13:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex@shazbot.org, lukas@wunner.de,
	Dan Williams <dan.j.williams@intel.com>,
	Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH 2/2] pci: fix slot reset device locking
Message-ID: <aXpf0OkCsiw6kePd@kbusch-mbp>
References: <20260116184150.3013258-2-kbusch@meta.com>
 <20260128180338.GA423654@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128180338.GA423654@bhelgaas>

On Wed, Jan 28, 2026 at 12:03:38PM -0600, Bjorn Helgaas wrote:
> [+cc Dan, Jinhui]
> 
> On Fri, Jan 16, 2026 at 10:41:50AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
> > prevent the warning:
> 
> I *think* this actually refers to pci_bus_trylock() and
> pci_slot_trylock() (not pci_bus_lock() and pci_slot_lock()), since
> that's what this patch changes?

Oh, this patch is changing both pci_slot_trylock and pci_slot_lock since
they were both missing the equivalent locks that the "bus" version of
those functions were doing.

> It's unfortunate that pci_bus_trylock() and pci_slot_trylock() are so
> similar but separate.  If there were combined, this kind of issue
> where one is fixed but the other isn't wouldn't happen.

Honestly I think the _slot versions should go away. Those don't handle
resetting a bus with multiple device's on it: only some functions get
saved and restored even though the bus reset hits all the devices. I'm
working on a fix for that, but it's more difficult than these patches.

> But what about pci_bus_lock() and pci_slot_lock()?  They are also
> almost identical, but pci_bus_lock() locks bus->self while
> pci_slot_lock() does not.  Should it?

It should, and this patch is changing pci_slot_lock() to do that.

> All these almost-but-not-quite identical paths make my head hurt ;)

I agree! And the functions that sound almost the same but work quite
different? Looking at "pci_bus_reset" vs "pci_reset_bus" :)
 
> >   pcieport 0000:e2:05.0: unlocked secondary bus reset via: pciehp_reset_slot+0x55/0xa0
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/pci/pci.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 3378221c5723a..5f8b0d06a1459 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5460,6 +5460,8 @@ static void pci_slot_lock(struct pci_slot *slot)
> >  {
> >  	struct pci_dev *dev;
> >  
> > +	if (slot->bus->self)
> > +		pci_dev_lock(slot->bus->self);
> >  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> >  		if (!dev->slot || dev->slot != slot)
> >  			continue;
> > @@ -5483,12 +5485,17 @@ static void pci_slot_unlock(struct pci_slot *slot)
> >  		else
> >  			pci_dev_unlock(dev);
> >  	}
> > +	if (slot->bus->self)
> > +		pci_dev_unlock(slot->bus->self);
> >  }
> >  
> >  /* Return 1 on successful lock, 0 on contention */
> >  static int pci_slot_trylock(struct pci_slot *slot)
> >  {
> > -	struct pci_dev *dev;
> > +	struct pci_dev *dev, *bridge = slot->bus->self;
> > +
> > +	if (bridge && !pci_dev_trylock(bridge))
> > +		return 0;
> >  
> >  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> >  		if (!dev->slot || dev->slot != slot)
> > @@ -5511,6 +5518,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
> >  		else
> >  			pci_dev_unlock(dev);
> >  	}
> > +
> > +	if (bridge)
> > +		pci_dev_unlock(bridge);
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.47.3
> > 
