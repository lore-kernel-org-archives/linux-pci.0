Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5732ED21;
	Wed, 12 Aug 2026 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520809; cv=none; b=r2d8S4z16unQGkbGMD4zzf5gkzmtQtxZkHLug7+MBcDIGbi/luDP9livSI6xP7MQCttnsatyi2w3d3320IMrBChx9YYhSo+0+5wCSnxHBPecSt/6t+l9e4ySA7AekgBlM8L7FM2kUT54NLZ3iHkLTnYCdulWGvJIA1diah2jqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520809; c=relaxed/simple;
	bh=kSUCchD4d6o3wRb9pDWHzg+hilWQ9EanqXJWiEPhrSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA7iOYG9Mlz+UjOStz8XdpRLrHU/ZFNABuiIlRAUpOZf/+a3K6u0hwA5VDeQr6CA1rs9m1vOXRwS63Qy9AmXzl0t/hST+Z6MgWjYKfkXSwXyJKY4nmK9BqMXZ+US7YjSGk63cxZaRqmCjQIufNVQoaFFlhyU0oLJ0iJJq+zxV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q0ZsvQx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q0ZsvQx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49191F000E9;
	Wed, 12 Aug 2026 07:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786520807;
	bh=ZQUW4KDX/Ay8+y0Kx92fIpEyHoW0NNhFGvcqvk+ebFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=q0ZsvQx5AMmxMmsC0D50f4WrXb1/xn2OIZ6ps3p5YUzARM5AYEtveOisNjV9aDZDE
	 4G54bvtWRe8nMnswEEwXSACoxinZNjCACK5Ixphl5cPHnCvvn6RJINmI4BMvYRXgX+
	 rlWD60I5uXIsiAR8xjezzwiTQYogMhDhk6diZrpw=
Date: Wed, 12 Aug 2026 16:45:14 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix use-after-free race in pci_find_bus()
Message-ID: <2026081203-tradition-coeditor-2048@gregkh>
References: <20260812024713.4958-1-raizudeen.kerneldev@gmail.com>
 <2026081227-sandy-imaginary-fa49@gregkh>
 <anwgQ4MtqfEOWQCu@kernel>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anwgQ4MtqfEOWQCu@kernel>

On Wed, Aug 12, 2026 at 12:56:59PM +0530, Mohamad Raizudeen wrote:
> On Wed, Aug 12, 2026 at 12:00:33PM +0900, Greg KH wrote:
> > On Wed, Aug 12, 2026 at 08:17:13AM +0530, Mohamad Raizudeen wrote:
> > > pci_find_bus() iterates over the list of PCI root buses using
> > > pci_find_next_bus(). This helper acquires pci_bus_sem, retrieves the
> > > next bus and drops the lock before returning the pointer to the caller.
> > > 
> > > pci_find_bus() then uses this pointer to check the domain and traverses
> > > the child buses via pci_do_find_bus() without holding the pci_bus_sem
> > > lock.
> > > 
> > > If a PCI bus is concurrently removed for example via hotplug between
> > > loop iterations, the from pointer passed back into pci_find_next_bus()
> > > becomes stale, leading to a user-after-free when dereferencing
> > > from->node.next. Additionally, traversing the bus tree without holding
> > > the lock is a race condition.
> > 
> > Did you find this actually happens?  How did you find this at all?
> 
> I found this purely through by reading and reviewing the code, while
> analyzing the locking patterns in the PCI subsystem. I have not seen it
> crash in production, but the race condition is statically clear from
> reading the code.
> >
> > > 
> > > Fix this by iterating pci_root_buses list directly using
> > > list_for_each_entry() inside pci_find_bus() while holding the
> > > pci_bus_sem read lock for the entire duration of the search. This
> > > ensures the list and tree structures cannot change while being
> > > traversed, eliminating the use-after-free.
> > 
> > Why do two changes here, and not just make a patch series?
> I did both in one patch because they are connected. Since
> pci_find_next_bus() drops the lock early, I couldn't use it to hold the
> lock for the whole search. I had to change the loop to fix the locking.
> > 
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > > ---
> > >  drivers/pci/search.c | 20 +++++++++++---------
> > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > > index e3d3177fce54..f50e83061b76 100644
> > > --- a/drivers/pci/search.c
> > > +++ b/drivers/pci/search.c
> > > @@ -142,17 +142,19 @@ static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
> > >   */
> > >  struct pci_bus *pci_find_bus(int domain, int busnr)
> > >  {
> > > -	struct pci_bus *bus = NULL;
> > > -	struct pci_bus *tmp_bus;
> > > +	struct pci_bus *bus;
> > > +	struct pci_bus *tmp_bus = NULL;
> > >  
> > > -	while ((bus = pci_find_next_bus(bus)) != NULL)  {
> > > -		if (pci_domain_nr(bus) != domain)
> > > -			continue;
> > > -		tmp_bus = pci_do_find_bus(bus, busnr);
> > > -		if (tmp_bus)
> > > -			return tmp_bus;
> > > +	down_read(&pci_bus_sem);
> > > +	list_for_each_entry(bus, &pci_root_buses, node) {
> > > +		if (pci_domain_nr(bus) == domain) {
> > > +			tmp_bus = pci_do_find_bus(bus, busnr);
> > > +			if (tmp_bus)
> > > +				break;
> > > +		}
> > 
> > Are you sure this logic is the same as the original?
> Yes, I used list_for_each_entry() that does the exact same thing as the
> old while loop, but it let me keep the lock saefely for the whole
> search.
> 
> > pci_find_next_bus() does grab the needed lock here, so why do you think
> > this is racy?
> You are right, it grabs the lock. But it drops the lock before returning
> the bus pointer. So the caller then uses that pointer without a lock and
> passes it back for the next loop. If a bus is removed in that moment,
> the next call reads freed memory.
> > 
> > And pci_bus_sem is just for root busses, not the individual busses,
> > right?
> It protects the root bus list, but it also protects the child buses.
> Since pci_do_find_bus() walks through the child buses, needed to hold
> the lock to make that safe too.
> > 
> > How was this tested?
> I compiled ir and booted it in x86_64 qemu vm. It booted fine without
> any PCI crashes. I will run the same test on v2 patch before sending it.

Booting in a vm is very simple as a vm does not have many PCI devices.
Try it on a real system with a big topology as well as a pci hotplug
system please.

Also note that this function should only be called when pci devices are
being added to the system, so odds are it can't race with a device being
removed due to the pci bus lock in the first place, right?

thanks,

greg k-h
