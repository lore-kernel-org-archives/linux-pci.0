Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990434;
	b=y6ltOxRrRcaxKjY22iMXxamjFH3U9s2Uydzs4wc2XkKDfa/geDb9egx88taVQRGo3Xwf
	 VOvIKgGmrg5Rp4DpFj5vO69XOpuS4GXEGw06Jzse82AGQWDqJSsYhBhf7xMWJaR1pEGx7
	 Aw1LKGj/GYlLIVZILJPgKWq3KRsfTps/os6HKj+7wwp5YMC5OhQrezFzZJrQ/GnglkhDq
	 fn3L8NfA9KY1Kf5BxPxe+d6Xj8GQT+w9I/2ZABtcAwq+EZvT7fw4BbQVh/S7ohHvAw36Y
	 DDoxi3P7fesB4VXk94ZvFgl2nBLaJVjsjqKrq5xrJefkOJmJFoDOHGRgCsCSU1697Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=d9rgt/0ZjW9cJWRqIx3PEfjuDN/5drVoS4iqtSrIJtI=;
	b=xlWSyfifxWAFUYSGr7EX8EQRrcRq/4SYNMFZeH08FCNfvpvHGJfnPj5lLjZutUc1z0Dg
	 xzjlOd6CsYU8nJT6UBcucmnuE8WKUlQELL4GUZljLHFjTMkg8u2kQM8vvNBhfkzwMOOLe
	 ErdHzovNYG1UREibX/8BLyUSjT585wSRtu3AQoam7JWr1ByAoXeDFD5QoJ9JfbyxhoPD1
	 /p4hxE8V+WRr5NiLAPFF5+C9gYxD/rj2y7Kk7Gggb3eEPPSsRDY5ZgWqIdfAAN4zzshIO
	 gcvIRt7m75Xt2MtBy/LBbmjwhmGkQAYNcj8I3pNmOMpUimMdNHQiE9IddhfJ9T83e9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY+DYiQh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AF606A33C;
	Fri,  6 Nov 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY+DYiQh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60B31F0089F;
	Fri,  6 Nov 2026 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990433;
	bh=d9rgt/0ZjW9cJWRqIx3PEfjuDN/5drVoS4iqtSrIJtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=oY+DYiQhz2qhURLJX4BDC/kmudYeEjDpY0mTplMC7by/77+JSrwJ3cPy0pAcpZY97
	 fZehsr6eSagi1hfvJzy6tX6lqz29+bGYK3xSKa0OTnst9MaQ5j8E/D30O63P4HUDk2
	 1xT7ZDqhrzrXp+rAMioUXloF0PcDNOLqEyE1lY6PX0Jf63xyCqAwU8+rJ1zfx8gvnK
	 Ab3RFED9RMqASj9LT1swYH4CwBPe0jo1CtmL2IXstISB9dUcaO1BVKpTO/pd9kGcwQ
	 ttaapWVgo9M3UfMpozYSTbixGW+reEsNu8DqEFOQLmf10nJD4nZksup2s2GpGl5JYp
	 hlebewHwXEDBg==
Date: Fri, 6 Nov 2026 12:40:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 05/13] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
Message-ID: <20261106184032.GA1640926@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMOC3XV68W0K.3FGK4UZ87838R@google.com>

On Fri, Nov 06, 2026 at 06:20:36PM +0000, David Matlack wrote:
> On Fri Nov 6, 2026 at 5:34 PM UTC, Bjorn Helgaas wrote:
> > On Tue, Oct 13, 2026 at 04:25:21PM +0000, David Matlack wrote:
> >>  static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
> >>  					  struct pci_dev *dev)
> >>  {
> >> -	struct pci_dev_ser *dev_ser;
> >> -
> >>  	if (dev->is_virtfn) {
> >>  		pci_warn(dev, "Cannot preserve Virtual Functions\n");
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> -	if (dev->liveupdate.outgoing) {
> >> +	/*
> >> +	 * Endpoint devices should not be preserved more than once.
> >> +	 * Bridges are preserved once for every downstream device that
> >> +	 * is preserved.
> >> +	 */
> >> +	if (dev->liveupdate.outgoing && !dev->subordinate) {
> >>  		pci_warn(dev, "Device is already preserved\n");
> >>  		return -EBUSY;
> >>  	}
> >>  
> >> -	if (!pci_is_root_bus(dev->bus)) {
> >> -		pci_warn(dev, "Cannot preserve devices behind bridges\n");
> >> +	if (dev->liveupdate.outgoing && !dev->liveupdate.outgoing->refcount) {
> >> +		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> -	dev_ser = pci_flb_alloc_dev_ser(outgoing);
> >> -	if (IS_ERR(dev_ser))
> >> -		return PTR_ERR(dev_ser);
> >> +	if (!dev->liveupdate.outgoing) {
> >> +		struct pci_dev_ser *dev_ser;
> >>  
> >> -	pci_info(dev, "Device will be preserved across next Live Update\n");
> >> -	outgoing->ser->nr_devices++;
> >> -	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
> >> +		dev_ser = pci_flb_alloc_dev_ser(outgoing);
> >> +		if (IS_ERR(dev_ser))
> >> +			return PTR_ERR(dev_ser);
> >>  
> >> -	dev_ser->domain = pci_domain_nr(dev->bus);
> >> -	dev_ser->bdf = pci_dev_id(dev);
> >> -	dev_ser->refcount++;
> >> +		pci_info(dev, "Device will be preserved across next Live Update\n");
> >> +		outgoing->ser->nr_devices++;
> >
> > This looks a little funny because prior to this patch, nr_devices was
> > always incremented in pci_liveupdate_preserve_device() and always
> > decremented in pci_liveupdate_unpreserve_device().  Now it's only
> > incremented once (per device) in pci_liveupdate_preserve_device(), so
> > it looks unbalanced.
> >
> > My guess is this is because previously we didn't expect to preserve
> > bridges at all, and now pci_liveupdate_preserve_device() might be
> > called several times for a bridge, and it's all just fine, but it's a
> > little subtle.
> 
> Right. nr_devices counts struct pci_dev_ser entries that are in use, so
> it goes up when a device's refcount goes from 0 to 1 (the entry is
> allocated) and down when it goes from 1 to 0 (the entry is released).
> For endpoints that is every preserve/unpreserve call, but a bridge is
> preserved once per preserved device below it, so most calls for a
> bridge only change its refcount.
> 
> > I suppose the "(dev->liveupdate.outgoing && !dev->subordinate)" test
> > above is what allows us to just increment refcount each time a bridge
> > is preserved.  And the test around pci_flb_alloc_dev_ser() is doing
> > basically the same thing.  I wonder if there's a way to connect them
> > more explicitly.
> 
> Agreed, both points come from the same thing being spread out. I think
> both can be fixed by splitting pci_liveupdate_preserve_device() into
> "already preserved" and "first preservation" cases, and moving the
> nr_devices accounting into helpers that allocate and release the
> struct pci_dev_ser, so it is visibly paired:
> 
> 	if (dev_ser) {
> 		/*
> 		 * Endpoints can only be preserved once. Bridges are
> 		 * preserved once for every preserved device below them.
> 		 */
> 		if (!dev->subordinate) {
> 			pci_warn(dev, "Device is already preserved\n");
> 			return -EBUSY;
> 		}
> 		...
> 	} else {
> 		dev_ser = pci_liveupdate_alloc_dev_ser(outgoing, dev);
> 		if (IS_ERR(dev_ser))
> 			return PTR_ERR(dev_ser);
> 	}
> 
> 	dev_ser->refcount++;
> 
> with pci_liveupdate_unpreserve_device() calling a matching
> pci_liveupdate_free_dev_ser() when the refcount drops to 0.

I think that would be good.
