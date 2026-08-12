Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364EB34C134
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519628; cv=none; b=G4QXq7EFzGjZ2T4w2mSWSDWDyzwUAriiBHQWSJNAT3rMm1y4hL6n95bRNzY2vwypFYhOZMosqL4bAYFiVxTDgqcbrEVInwsszjU59l1mlAC4uAgbmkgr3ZGCu3xzl9Us+EgwqPmsMDHHG2k0wnv3rRghc4ljJHOZEycqTAcl9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519628; c=relaxed/simple;
	bh=9+H/1bC9AngwY48oSSf37D0mjWXZXMcBbkIDQidIu/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI3pfhNYcgHfj3kHvV/+ruRdnb01Im3ZZeIAmuylxdPuwNB9fEPMimBopiGFc3QzwZWPixUtaMX3DkMHUMpgC1KjETdwX7tCfRadXT+cYOwuNrdGjy9c/1NF0iPoCASPmy5DqFhMskAvz01nHoS8a2HWr85CnXWdkD8GfBKIBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwvgCTXW; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwvgCTXW"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so565099a12.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786519626; x=1787124426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3H2XRYBLrEGNhf/P+5Th74cqCMRbv9XKacb8u8bUl28=;
        b=BwvgCTXWipJfuECtyiYCDBxDvDlUrPx98tO5SQOyml9oqh7v0u9LFjahfOzNxAeQmv
         GoXznTxZ4RFVZUJO2vi3R3nym2jXSiWNyR+Symfug3PeeObhUMrHYLnaBVH7TCN8Y85w
         x4i9lbUNPs/6qfEkp+jFDuMGBUpgSrx5XStXh+XLGfcqcQ5EUuvxkgMANFYOOCvC8cf1
         JFvYKSqnh2Z91mDJE4swyZFz5MGsrkah9XUjs6BqNtGNc+7jnWP5kyuprN74miZyAj1B
         lATg5KqHNVUJZ6LduRXNkP34UFQLrMfdFreQqMLWrcGFSjK9hwt0wI1QC4+O8+Mm4p3X
         KOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786519626; x=1787124426;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3H2XRYBLrEGNhf/P+5Th74cqCMRbv9XKacb8u8bUl28=;
        b=cEfyeD5gR5NK4DpgNd24UXN/bAasGiuMJ6JaeX6VualHrIXlNstSJCplknKhgQzXXl
         gUrRlaeUqonHFR0IjSp6Ceo13vzWWK/Jnb5fvJ5xd1TT1xIyLFVarvHtLe2qgdUMje/T
         0SQWS01x7KBr0h/1i/VGj24iLvzInN0j5V5eRmcjSdz1ajk7m42I+batUg3ig1x9EizW
         3rXapD8RS0nA8/zVEhBegLltNm1sQVLbE9jQn+H6aRwO0YsqGoRJb8CaAG+Nx/orJeIN
         51JDEesVnWzZD1yurvgWEYDJqOnlBYBuVlAMijuuJEmHt8xhY5xqozYJQLPusJMwhPII
         BKwg==
X-Forwarded-Encrypted: i=1; AHgh+RqbSrvIv4a7Bwbe/jD+1NrU4P/t08PCauUU4c+0hiCJI4Oi1AfcHqRyOwp4IOaonbTTEBhGOuzVubs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+ORIipbtTBGm9fZxsEe0UvHmx9O9wMIf+J5l/30UQ6Els2kT
	gLhwoMia/p8gC/DzuwXZ/24NwpGp2TBKb+v/dQdZdyxqvZs6DoZ9+6xG
X-Gm-Gg: AR+sD13uw0iiMuZmP+/xFWnUYj/1aj8olCFmxqhPstdUN9kZ1UjrTLvqXzoQi3ZioYM
	wHPG7Nv5BWGJrtHuJnBlB8HB5ROd/FPLPRGKydjHoJtQcbfT1qMCAXo/fakPZMKz7p0hRCe+W5e
	KSEsTCw50blPsPlrLDB78ah2WjkyxwYgXqwi9iyIbuzry1oANBrzCKJCNixzPjgIyCqjKggvJDS
	2hvELNyDeBp5N4WQ/NL9w5O27RnK+P+K/lxegD1DDTS7SpS7TQsD3t9ukHbhY2J2eGq+Dponyve
	CHR3iL8fZCLHDG2EM/icV6NMiyjLaXTKfCtAgU8/T40xt+BzlnFZcwPvk50ZSlzLKQaRZ8/eq+Z
	8dgpOhC3FrLUVHko1Ss6qNM0n/ho0d/EQ/bjeuGSQluHLpkvNQ54YbIs89E6qNqaLKG0fM7BGHL
	3rAZ8NVRreEAGwibLGBU/xkJftp6JPh4mx4sJL1Ag7BJDT/XQnt971GzoaxdWmsqFO8behByZqc
	yeMqg==
X-Received: by 2002:a05:6a21:329a:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3cc3f701ebbmr2837875637.17.1786519626456;
        Wed, 12 Aug 2026 00:27:06 -0700 (PDT)
Received: from kernel ([45.251.35.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d79bd6sm8297129eec.28.2026.08.12.00.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:27:05 -0700 (PDT)
Date: Wed, 12 Aug 2026 12:56:59 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix use-after-free race in pci_find_bus()
Message-ID: <anwgQ4MtqfEOWQCu@kernel>
References: <20260812024713.4958-1-raizudeen.kerneldev@gmail.com>
 <2026081227-sandy-imaginary-fa49@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026081227-sandy-imaginary-fa49@gregkh>

On Wed, Aug 12, 2026 at 12:00:33PM +0900, Greg KH wrote:
> On Wed, Aug 12, 2026 at 08:17:13AM +0530, Mohamad Raizudeen wrote:
> > pci_find_bus() iterates over the list of PCI root buses using
> > pci_find_next_bus(). This helper acquires pci_bus_sem, retrieves the
> > next bus and drops the lock before returning the pointer to the caller.
> > 
> > pci_find_bus() then uses this pointer to check the domain and traverses
> > the child buses via pci_do_find_bus() without holding the pci_bus_sem
> > lock.
> > 
> > If a PCI bus is concurrently removed for example via hotplug between
> > loop iterations, the from pointer passed back into pci_find_next_bus()
> > becomes stale, leading to a user-after-free when dereferencing
> > from->node.next. Additionally, traversing the bus tree without holding
> > the lock is a race condition.
> 
> Did you find this actually happens?  How did you find this at all?

I found this purely through by reading and reviewing the code, while
analyzing the locking patterns in the PCI subsystem. I have not seen it
crash in production, but the race condition is statically clear from
reading the code.
>
> > 
> > Fix this by iterating pci_root_buses list directly using
> > list_for_each_entry() inside pci_find_bus() while holding the
> > pci_bus_sem read lock for the entire duration of the search. This
> > ensures the list and tree structures cannot change while being
> > traversed, eliminating the use-after-free.
> 
> Why do two changes here, and not just make a patch series?
I did both in one patch because they are connected. Since
pci_find_next_bus() drops the lock early, I couldn't use it to hold the
lock for the whole search. I had to change the loop to fix the locking.
> 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > ---
> >  drivers/pci/search.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index e3d3177fce54..f50e83061b76 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -142,17 +142,19 @@ static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
> >   */
> >  struct pci_bus *pci_find_bus(int domain, int busnr)
> >  {
> > -	struct pci_bus *bus = NULL;
> > -	struct pci_bus *tmp_bus;
> > +	struct pci_bus *bus;
> > +	struct pci_bus *tmp_bus = NULL;
> >  
> > -	while ((bus = pci_find_next_bus(bus)) != NULL)  {
> > -		if (pci_domain_nr(bus) != domain)
> > -			continue;
> > -		tmp_bus = pci_do_find_bus(bus, busnr);
> > -		if (tmp_bus)
> > -			return tmp_bus;
> > +	down_read(&pci_bus_sem);
> > +	list_for_each_entry(bus, &pci_root_buses, node) {
> > +		if (pci_domain_nr(bus) == domain) {
> > +			tmp_bus = pci_do_find_bus(bus, busnr);
> > +			if (tmp_bus)
> > +				break;
> > +		}
> 
> Are you sure this logic is the same as the original?
Yes, I used list_for_each_entry() that does the exact same thing as the
old while loop, but it let me keep the lock saefely for the whole
search.

> pci_find_next_bus() does grab the needed lock here, so why do you think
> this is racy?
You are right, it grabs the lock. But it drops the lock before returning
the bus pointer. So the caller then uses that pointer without a lock and
passes it back for the next loop. If a bus is removed in that moment,
the next call reads freed memory.
> 
> And pci_bus_sem is just for root busses, not the individual busses,
> right?
It protects the root bus list, but it also protects the child buses.
Since pci_do_find_bus() walks through the child buses, needed to hold
the lock to make that safe too.
> 
> How was this tested?
I compiled ir and booted it in x86_64 qemu vm. It booted fine without
any PCI crashes. I will run the same test on v2 patch before sending it.
> 
> >  	}
> > -	return NULL;
> > +	up_read(&pci_bus_sem);
> 
> Why not use guard() instead?
Honestly, I was so focused on getting the locking logic right that I
completely missed I meant forgot to use guard(). I will make sure to use
guard() in the v2 patch.
> 
> thanks,
> 
> greg k-h

Thanks & regards,
Mohamad Raizudeen 
