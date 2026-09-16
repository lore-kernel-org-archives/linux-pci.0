Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7658FD29;
	Wed, 16 Sep 2026 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602878; cv=none; b=RDNCnye6JCj1alkCMcrNsUZC/Tv4bu8w88lzfgOkHTF7TCyPUdU9bh8lnWutI5m8kf9oKSvL0cDZpVICKw7/iJJmG2vOgCwfLFHwAGb5kQIgudM10bEQOeq7BHjIFZbDak/dBIiUiyDE7RyBmETrooPTCyxZGVGpQWJ97kLkPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602878; c=relaxed/simple;
	bh=jBYj/ikwk92P695e21QyiKCOHBe+EbH8ccn0oLPTNUc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HClEGrST1XxRsZjVpVOlNboUT7ZXTBgQsA9U33NzstiRE38FnOSsIZqlU+qAO7+TKnw/U3WZI6aqrbHOH41HHY0JoKMJe9hiIXZNFnqNRNaSmv6ysFOVSD333evWXwPHhXpS3+IfFYgCbR8ncpIEyLbcfbHitu0sT/qWZeVGh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYc8Cui1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYc8Cui1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1981F00893;
	Wed, 16 Sep 2026 23:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602873;
	bh=wgoX0NFNrnLOccx1kwVwT9i8vW+4UjtWT+bTNhxa1JQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=RYc8Cui14PqHJGYd2OA4w//4W/q+vKpT9752cZehXytimpFfD8DdnJqfm6nox2RHc
	 iQQsK4TBBleeaWmaW1texNzMvSu1FYdqDEj3dGhP+6tNJUu+aFuB6cNmkwEqmyXyNe
	 ThdDm0PA87ErxznKkitA2GRnCrjKO038Y/efClSt40jtmT0AjIALjPknHaQHTdYTJ8
	 PuNo4hVCuIOwkiLYuw1lx+h10AMaIohr8rHPa5PBQdkWIZdvO3krGkjQxT9zYtmBx6
	 awTw+7Q3iewdwm8pVHMKqfNiyGmFEGT/mJRu8cYyeh2pRZjCunC1/ZsBMUNN+QlMsK
	 Ccfl8goJC1ExA==
Date: Wed, 16 Sep 2026 18:54:32 -0500
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
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 05/12] PCI: liveupdate: Preserve bus numbers during
 Live Update
Message-ID: <20260916235432.GA991837@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqWMjrea2MMMZHxr@google.com>

On Sat, Sep 12, 2026 at 05:31:58PM +0000, David Matlack wrote:
> On 2026-09-11 06:30 PM, David Matlack wrote:
> > On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> > > On Tue, Jul 28, 2026 at 10:09:59PM +0000, David Matlack wrote:
> 
> > > > +bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
> > > > +{
> > > > +	struct pci_dev *parent = bus->self;
> > > > +
> > > > +	if (dev->liveupdate.preserve_bus_numbers)
> > > > +		return true;
> > > > +
> > > > +	if (parent && parent->liveupdate.preserve_bus_numbers) {
> > > > +		/*
> > > > +		 * Preserve bus numbers if the parent bridge is required to
> > > > +		 * preserve bus numbers. Otherwise the PCI core could expand
> > > > +		 * this bridge's reservation beyond its parent (which cannot
> > > > +		 * expand).
> > > > +		 */
> > > > +		dev->liveupdate.preserve_bus_numbers = true;
> > > > +	} else {
> > > > +		/*
> > > > +		 * Otherwise preserve bus numbers if there are any incoming
> > > > +		 * preserved devices. This ensures that the PCI core does not
> > > > +		 * allocate a bus number to a non-preserved device that
> > > > +		 * conflicts with the bus number already assigned to a preserved
> > > > +		 * device.
> > > > +		 *
> > > > +		 * This is slightly more restrictive than it needs to be. For
> > > > +		 * example, each host bridges have their own range of bus
> > > > +		 * numbers that won't conflict with other host bridges. But the
> > > > +		 * previous kernel should have assigned a sane bus topology and
> > > > +		 * it is simpler to just adopt that entire topology.
> > > > +		 */
> > > > +		dev->liveupdate.preserve_bus_numbers =
> > > > +			pci_has_incoming_preserved_devices();
> > > > +	}
> > > > +
> > > > +	return dev->liveupdate.preserve_bus_numbers;
> > > 
> > > I'm not sure why you don't just return
> > > pci_has_incoming_preserved_devices() in all cases, which is what the
> > > commit log suggests this patch does.  What's gained by all the logic
> > > here?  It's not like devices will be hot-added during the kexec.
> > 
> > To protect against pci_has_incoming_preserved_devices() flipping from
> > true to false while the PCI core is in the middle of a scan. It is not
> > likely to ever happen given most host bridge scanning should happen
> > during early boot, but theoretically possible with the way the PCI core
> > code is structured. I did not see way to structurally ensure these 2
> > things cannot race. A lot of the host bridge scanning happens without
> > taking the rescan lock, for example.
> 
> After working on this more, I do see a way to simplify the logic in
> pci_liveupdate_preserve_bus_numbers().
> 
> pci_liveupdate_preserve_bus_numbers() is used in 2 places during
> scanning. First to decide if the PCI core should preserve bus numbers or
> is free to allocate new ones, and second to decide if the PCI core is
> allowed to assign bus numbers to bridges that are missing bus numbers.
> 
> The latter case should never happen during initial scanning unless a
> bridge was somehow reset during the kexec, but could legitimately happen
> if a bridge is later hot-plugged and I did not want Live Update to
> unnecessarily break that scenario. But then that creates this problem
> where pci_has_incoming_preserved_devices() can suddenly flip from true
> to false at any time and I needed all the complex logic to keep it
> consistent for a given scan.
> 
> Instead we can split the handling of these cases:
> 
>  1. When the PCI core needs to decide if it should preserve bus numbers
>     due to Live Update, pci_liveupdate_preserve_bus_numbers() can return
>     true forever if any device was preserved by the previous kernel,
>     which simplifies the logic.
> 
>  2. Then to handle the case of a bridge is enumerated that does not have
>     bus numbers assigned, we can handle that separately. If we reorder this
>     with the next commit so the PCI core knows exactly which bridges have
>     preserved downstream endpoints, then it is possible to determine if it
>     is safe for the PCI core to allow bus numbers to be assigned to an
>     unconfigured bridge.
> 
> After re-ordering, we can end up with something like this:
> 
>   bool pci_liveupdate_preserve_bus_numbers(void)
>   {
>   	return pci_liveupdate.had_incoming;
>   }
> 
>   bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
>   {
>   	struct pci_dev *bridge;
> 
>   	for_each_pci_bridge(bridge, bus) {
>   		if (!bridge->liveupdate.was_incoming || bridge->subordinate)
>   			continue;
> 
>   		pci_err(dev, "Not assigning bus numbers, preserved bridge %s lost its bus number configuration\n",
>   			pci_name(bridge));
>   		return true;
>   	}
> 
>   	return false;
>   }
> 
> The net effect on pci_scan_bridge_extend() is:
> 
>   bool preserve_bus_numbers = !pcibios_assign_all_busses() ||
>   			    pci_liveupdate_preserve_bus_numbers();
>   ...
>   	if (pci_liveupdate_refuse_bus_numbers(bus, dev))
>   		goto out;
> 
> We could further scope pci_liveupdate_preserve_bus_numbers() to only
> return true for host bridges with preserved endpoints downstream, but
> that doesn't seem worth the extra complexity. It also seems nice to keep
> the pci_liveupdate_preserve_bus_numbers() policy global to match how the
> existing pcibios_assign_all_busses() policy is global.
> 
> Does that look reasonable?

Yep, sounds good to me.
