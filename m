Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17925322527
	for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786768174; cv=none; b=nP+tlm0JdQTT733p0gBlQmf1p/zc1747AzehpXjx4k6gggnsMQRG0x6+DMtuQyPbkW/GkQ5KOCv0KKJiHK6AS9whOjPMTn70vv59vu3jhJYomUo1ehKXDwq744vVR3QbdD5PQOmFgXXvufo0H36tbz1qF8RGyjZGeeCcrG3IYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786768174; c=relaxed/simple;
	bh=V4AJhMoMhWvOT9LBtcQQMQG8i2/J3918ZF9DPhCISxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8Rpc1vBiBawNAZ6Tia3ACOO9ayx+cKUTTd00d64BidibUOdknMzSN3FxApWups0q6yWtRzJFt62VLYOAPya+WU7fqmuzzbfr1Qii/0MhH8W5ZAd078jzObOLEoPbLVFOwGen3NZMUJGtgZYRPKSEpPB2HzNrkYpoQ6kmGElU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBoAU1a3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBoAU1a3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacb8416a1so17322355ad.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 21:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786768171; x=1787372971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KWskeq1Vu3rwzRClq+VvFf+8uZ52LyayeK0d9ieq1BM=;
        b=KBoAU1a3+zM7Zw32A1hnVyyy12qsXeGQuM5Wu3SGWmDSTIi9FG3N2mh5fMEPyZqHoS
         erCLUvdhSdmS6cciWRd2jyvGZ6+HFW53VSVI9JALzB7f4Y8c0AFyEYuEg+mkOUjoB63j
         eydoN9x8p4uIx6tB7sLxaAhVlIDg8xLtw4k3qp6N3OJ1QJy1u7OwnPUA3eWm+v8s7RBv
         jTIUO7kx7T1QjbzT+Rz8NzwrG3n4W4DYA7JrovpsNt/5EBZUT7fQulMij0xbKc7x3Hzc
         PVRRPHm4pAaL41HIcykeVpCEW5OZlzX1kFtXHbGMRVGRJxxWv1mbIUQERhPAHA1BeTUx
         H7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786768171; x=1787372971;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KWskeq1Vu3rwzRClq+VvFf+8uZ52LyayeK0d9ieq1BM=;
        b=h4fWdM/pq+wrFso/jS8Pxd0zmkKI1S0hJyBASfvTaSZdgsn4gww4Y9nU8aYNO/w2pn
         cBRgtJF5tBnrAF4MNnrStLch1unzHTC5COXUBgRfHPvzMA76E5fkompJEmU+1tbv1GzZ
         gtrWjiRoTht42a2h02USKPE/frLXeUk1bT+p9bFFvYbPqHHVrA8b1d6XQzQT82NdA3UH
         g4PattrM74Glavu8gXDR04kAE0YzQwzQ6VbR+REVybtbtFRM8NSH16s4q0SYhE1TU1GG
         G1U3k48By5DSdMb9p9qSYYfb7uYJ43otVviFOwMdpx1eCHlJE3rk/iGq8j0QvOIpEoLb
         p/sA==
X-Forwarded-Encrypted: i=1; AHgh+RqaQspfpB7GqMMCNWIwHQZtzfDrrQ39yb9C0nn9MdYjpmbp/+RKFsEHnYFQL1MeZ+8avImc/X6dShA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8nZkr6RndWmSa/5yPcMDlvtpUmjzFyq0ou00SVH4hShm16CUK
	Y36Ld+WhtX0dJM2LF8TZneTECKsvF+ZUiQ6L1LQ60xw/sTdAvpo7M17K
X-Gm-Gg: AR+sD12UJZBpyzIz6e05T8g3UtGhuyYVOurc3K6igoTP9eUFsGeF+7R/7yJAd9gv2bL
	5zaU2FK4FE0kDXXLN/bICosv13IELVVFWdg5PwosTqNE4xixcFSGUPagoIFXImmhl013mV2P56j
	c0tEocVHWWwj/5k4p64L4zSUZoSHX/QoCV87VmExIguN/Byc9WTkmcY9ybxELge0hrwjYuDxjSB
	oK505p9QL644DNiK166EpmH84zVA4w4Tij2457RVdK+cHQ+e9MMGREzPKDMnNqgmV+gSLfxG4B5
	lssnOaaOn5U6EQ4gITarAItEqCKPdV5FVhbSUgWpItmSDEouUM0+L3gF6lVkDor7VI5MrxvNV6y
	qzfbcDQGjMXlT1IotCr7mMkTsgkPFyuLeRuCev2/kucoGXlUwQH9TGQ8Svc3Ryl/eglj06BEdc8
	q93TKOz4k2MvluL7bKzQBLomjh/MvKwfKa3NcBgPnsEIUXOgMpzQinIjkHI++Ap4b66+cD6uL+o
	Q/RlIEIqw==
X-Received: by 2002:a17:903:238a:b0:2cc:d69a:354a with SMTP id d9443c01a7336-2d3b0d94cedmr115942755ad.22.1786768171221;
        Fri, 14 Aug 2026 21:29:31 -0700 (PDT)
Received: from kernel ([103.219.206.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd9fe0sm16544805eec.1.2026.08.14.21.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 21:29:30 -0700 (PDT)
Date: Sat, 15 Aug 2026 09:59:25 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix use-after-free race in pci_find_bus()
Message-ID: <an_rJSLgI-ml_bDX@kernel>
References: <20260812024713.4958-1-raizudeen.kerneldev@gmail.com>
 <2026081227-sandy-imaginary-fa49@gregkh>
 <anwgQ4MtqfEOWQCu@kernel>
 <2026081203-tradition-coeditor-2048@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026081203-tradition-coeditor-2048@gregkh>

On Wed, Aug 12, 2026 at 04:45:14PM +0900, Greg KH wrote:
> On Wed, Aug 12, 2026 at 12:56:59PM +0530, Mohamad Raizudeen wrote:
> > On Wed, Aug 12, 2026 at 12:00:33PM +0900, Greg KH wrote:
> > > On Wed, Aug 12, 2026 at 08:17:13AM +0530, Mohamad Raizudeen wrote:
> > > > pci_find_bus() iterates over the list of PCI root buses using
> > > > pci_find_next_bus(). This helper acquires pci_bus_sem, retrieves the
> > > > next bus and drops the lock before returning the pointer to the caller.
> > > > 
> > > > pci_find_bus() then uses this pointer to check the domain and traverses
> > > > the child buses via pci_do_find_bus() without holding the pci_bus_sem
> > > > lock.
> > > > 
> > > > If a PCI bus is concurrently removed for example via hotplug between
> > > > loop iterations, the from pointer passed back into pci_find_next_bus()
> > > > becomes stale, leading to a user-after-free when dereferencing
> > > > from->node.next. Additionally, traversing the bus tree without holding
> > > > the lock is a race condition.
> > > 
> > > Did you find this actually happens?  How did you find this at all?
> > 
> > I found this purely through by reading and reviewing the code, while
> > analyzing the locking patterns in the PCI subsystem. I have not seen it
> > crash in production, but the race condition is statically clear from
> > reading the code.
> > >
> > > > 
> > > > Fix this by iterating pci_root_buses list directly using
> > > > list_for_each_entry() inside pci_find_bus() while holding the
> > > > pci_bus_sem read lock for the entire duration of the search. This
> > > > ensures the list and tree structures cannot change while being
> > > > traversed, eliminating the use-after-free.
> > > 
> > > Why do two changes here, and not just make a patch series?
> > I did both in one patch because they are connected. Since
> > pci_find_next_bus() drops the lock early, I couldn't use it to hold the
> > lock for the whole search. I had to change the loop to fix the locking.
> > > 
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > > > ---
> > > >  drivers/pci/search.c | 20 +++++++++++---------
> > > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > > > index e3d3177fce54..f50e83061b76 100644
> > > > --- a/drivers/pci/search.c
> > > > +++ b/drivers/pci/search.c
> > > > @@ -142,17 +142,19 @@ static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
> > > >   */
> > > >  struct pci_bus *pci_find_bus(int domain, int busnr)
> > > >  {
> > > > -	struct pci_bus *bus = NULL;
> > > > -	struct pci_bus *tmp_bus;
> > > > +	struct pci_bus *bus;
> > > > +	struct pci_bus *tmp_bus = NULL;
> > > >  
> > > > -	while ((bus = pci_find_next_bus(bus)) != NULL)  {
> > > > -		if (pci_domain_nr(bus) != domain)
> > > > -			continue;
> > > > -		tmp_bus = pci_do_find_bus(bus, busnr);
> > > > -		if (tmp_bus)
> > > > -			return tmp_bus;
> > > > +	down_read(&pci_bus_sem);
> > > > +	list_for_each_entry(bus, &pci_root_buses, node) {
> > > > +		if (pci_domain_nr(bus) == domain) {
> > > > +			tmp_bus = pci_do_find_bus(bus, busnr);
> > > > +			if (tmp_bus)
> > > > +				break;
> > > > +		}
> > > 
> > > Are you sure this logic is the same as the original?
> > Yes, I used list_for_each_entry() that does the exact same thing as the
> > old while loop, but it let me keep the lock saefely for the whole
> > search.
> > 
> > > pci_find_next_bus() does grab the needed lock here, so why do you think
> > > this is racy?
> > You are right, it grabs the lock. But it drops the lock before returning
> > the bus pointer. So the caller then uses that pointer without a lock and
> > passes it back for the next loop. If a bus is removed in that moment,
> > the next call reads freed memory.
> > > 
> > > And pci_bus_sem is just for root busses, not the individual busses,
> > > right?
> > It protects the root bus list, but it also protects the child buses.
> > Since pci_do_find_bus() walks through the child buses, needed to hold
> > the lock to make that safe too.
> > > 
> > > How was this tested?
> > I compiled ir and booted it in x86_64 qemu vm. It booted fine without
> > any PCI crashes. I will run the same test on v2 patch before sending it.
> 
> Booting in a vm is very simple as a vm does not have many PCI devices.
> Try it on a real system with a big topology as well as a pci hotplug
> system please.
>
Yes, I agree and to be honest my hardware is quite limited. I do not
have access to physical machine with a large PCI topology or hotplug
capabilities to test this properly.

> Also note that this function should only be called when pci devices are
> being added to the system, so odds are it can't race with a device being
> removed due to the pci bus lock in the first place, right?
> 
> thanks,
> 
> greg k-h

Well... I understand now. If the callers that add devices to the system
like pci_host_probe() or pci_scan_child_bus(). they are already holding
the pci_lock_rescan_remove() lock, then pci_find_bus() can't race with a
removal. Actually, I was worried because pci_find_bus() is exported
symbol so I thought an external driver might call it without holding
that lock. Now I understood clearly.

Thanks & regards,
Mohamad Raizudeen
