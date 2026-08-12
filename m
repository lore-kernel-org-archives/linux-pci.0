Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA742FFF8B;
	Wed, 12 Aug 2026 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503728; cv=none; b=ChtdCYrZfGwl8/wGFZKiSWhmW9g4230g7BjVDyP7ta76KzlVI2i4ptSBNrJKsKJt2r1j+MwgcTmrzdEb/OnSu3vnJZxh+rBNe844ONCI5NyE0A30cuM0DIvi/q8Sahn3DXX4o+ntc+ggvjOkL/UvZ58+TzU+W2cHG/+/rDAjuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503728; c=relaxed/simple;
	bh=HTYIDB8v1TPlRTgK8FP28sAs1BeHvoH/kIy9JsSLoPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPks7ZrZaqnNGOWhCXU8udaLi1HuCgCalakK3YhYtP2/nlP4ZlfLHewCIEBahaz0CqI8CGJJD2pjhFzz86hNasSBH8u3S7yGSlEvopssu10Sv3SWPigDp743HX1cTr6MD6d2eJYmGS9IujkkTxVWxyBzDZ4UD340HVTVysToAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ObBjUcjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ObBjUcjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204911F000E9;
	Wed, 12 Aug 2026 03:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786503726;
	bh=jV0xfKMWPxStVT+exWMzo6uyN7LrAoYMhdU24F/J7O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ObBjUcjxXCdLWunxIfNqupEGhiphXtIEsShI6l/keD3860+1e+m++yeZOhdyF1nsY
	 2YCFsoQJRqu0D9nsJbizvFJVgQ72qquUQTww089Q0EFWcDmf9peyONKz4PiuaTKfuO
	 BSxSLGiFBZ3AM4vrnweYXKEbg9gK5cA9mR5FwUYk=
Date: Wed, 12 Aug 2026 12:00:33 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix use-after-free race in pci_find_bus()
Message-ID: <2026081227-sandy-imaginary-fa49@gregkh>
References: <20260812024713.4958-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812024713.4958-1-raizudeen.kerneldev@gmail.com>

On Wed, Aug 12, 2026 at 08:17:13AM +0530, Mohamad Raizudeen wrote:
> pci_find_bus() iterates over the list of PCI root buses using
> pci_find_next_bus(). This helper acquires pci_bus_sem, retrieves the
> next bus and drops the lock before returning the pointer to the caller.
> 
> pci_find_bus() then uses this pointer to check the domain and traverses
> the child buses via pci_do_find_bus() without holding the pci_bus_sem
> lock.
> 
> If a PCI bus is concurrently removed for example via hotplug between
> loop iterations, the from pointer passed back into pci_find_next_bus()
> becomes stale, leading to a user-after-free when dereferencing
> from->node.next. Additionally, traversing the bus tree without holding
> the lock is a race condition.

Did you find this actually happens?  How did you find this at all?

> 
> Fix this by iterating pci_root_buses list directly using
> list_for_each_entry() inside pci_find_bus() while holding the
> pci_bus_sem read lock for the entire duration of the search. This
> ensures the list and tree structures cannot change while being
> traversed, eliminating the use-after-free.

Why do two changes here, and not just make a patch series?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
>  drivers/pci/search.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index e3d3177fce54..f50e83061b76 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -142,17 +142,19 @@ static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
>   */
>  struct pci_bus *pci_find_bus(int domain, int busnr)
>  {
> -	struct pci_bus *bus = NULL;
> -	struct pci_bus *tmp_bus;
> +	struct pci_bus *bus;
> +	struct pci_bus *tmp_bus = NULL;
>  
> -	while ((bus = pci_find_next_bus(bus)) != NULL)  {
> -		if (pci_domain_nr(bus) != domain)
> -			continue;
> -		tmp_bus = pci_do_find_bus(bus, busnr);
> -		if (tmp_bus)
> -			return tmp_bus;
> +	down_read(&pci_bus_sem);
> +	list_for_each_entry(bus, &pci_root_buses, node) {
> +		if (pci_domain_nr(bus) == domain) {
> +			tmp_bus = pci_do_find_bus(bus, busnr);
> +			if (tmp_bus)
> +				break;
> +		}

Are you sure this logic is the same as the original?
pci_find_next_bus() does grab the needed lock here, so why do you think
this is racy?

And pci_bus_sem is just for root busses, not the individual busses,
right?

How was this tested?

>  	}
> -	return NULL;
> +	up_read(&pci_bus_sem);

Why not use guard() instead?

thanks,

greg k-h
