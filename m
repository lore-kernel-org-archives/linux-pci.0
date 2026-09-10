Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB9378D94;
	Thu, 10 Sep 2026 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084267; cv=none; b=YpXgztAI50PTdRqYBNzBpJaSlLl8uil8PghVG2vKddO9h/1BiP9E0rG23fJ6hJoA21ofMLXWYGRoIqk38DvEgpOFn+IXMEwa3ZErQX0zAeASj6Plp53cHUSMS1m5joKM5AKvI6vWY26chfPed8dVIWD8150Y4Mi8SIMxV/v5oKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084267; c=relaxed/simple;
	bh=1Lw97WvmI+g93nI6AGTq0IMx6oXg/wTQS7hsOe5G+XU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bmXgomyCVsSCXVxJDv0uMG1e7fbc7nHsZ5SFrWaAbFZhq1a6evghivU1Xc5yHlol1e28yW9O+5av+hiPRY+sXdySHxdp6Nb8Rp4ClMtMYaDWIOGZHreXwmyVH1PELvPOKfvNoC5c/lb592AwFc3DgzK4AbhDrMU3nR5mKr+uHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IznEg/t4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IznEg/t4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60C01F000FF;
	Thu, 10 Sep 2026 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084265;
	bh=pjUssxhMj5FiuQOqeJ/n4B79y63VUeUxlyscD8iV9MM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=IznEg/t4Jbqs1UnWZoYfs2SNW3eYxJii+gRGtJP4RK3+MXWvNQ7U+9BvnzqbMzdzT
	 ktVLA2JBWKXNKxeDF0IO7dl2nkvPyPHVCzNZM65lubpANrZVz8x3X8eVFjMA2FNHuH
	 qfcGcn33q7udgEPWa7IiDEcY6rFx6R1pq/XJFN+iJQN9kbOzvKIAdtN0ScjUiT5Df1
	 XWw3ZH6CVphruyylZpeUfVYU1Jy++RYDvqFhgZaA3oz8NNVWUbqCIcETZ9z9dBjZKI
	 APtOSYggBul3/7g6jkwJH0gWfVJFyaZ4ETvhBc7Ofpzoq8oNY2NrkmnC8HokuoY4B7
	 QxY+gInKhlK2A==
Date: Thu, 10 Sep 2026 18:51:04 -0500
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
Message-ID: <20260910235104.GA367522@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-6-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:09:59PM +0000, David Matlack wrote:
> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling and
> flushing any memory transactions first.
> 
> To keep bus numbers constant, always preserve the secondary and
> subordinate bus numbers assigned to bridges during scanning, instead of
> assigning new ones, if any PCI devices were preserved. Note that the
> kernel preserves bus numbers even on bridges without any downstream
> endpoints that were preserved. This avoids accidentally assigning a
> bridge a new window that overlaps with a preserved device that is
> downstream of a different bridge.

> +bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
> +{
> +	struct pci_dev *parent = bus->self;
> +
> +	if (dev->liveupdate.preserve_bus_numbers)
> +		return true;
> +
> +	if (parent && parent->liveupdate.preserve_bus_numbers) {
> +		/*
> +		 * Preserve bus numbers if the parent bridge is required to
> +		 * preserve bus numbers. Otherwise the PCI core could expand
> +		 * this bridge's reservation beyond its parent (which cannot
> +		 * expand).
> +		 */
> +		dev->liveupdate.preserve_bus_numbers = true;
> +	} else {
> +		/*
> +		 * Otherwise preserve bus numbers if there are any incoming
> +		 * preserved devices. This ensures that the PCI core does not
> +		 * allocate a bus number to a non-preserved device that
> +		 * conflicts with the bus number already assigned to a preserved
> +		 * device.
> +		 *
> +		 * This is slightly more restrictive than it needs to be. For
> +		 * example, each host bridges have their own range of bus
> +		 * numbers that won't conflict with other host bridges. But the
> +		 * previous kernel should have assigned a sane bus topology and
> +		 * it is simpler to just adopt that entire topology.

s/each ... bridges have their/each ... bridge has its/

It's true there should be no bus number conflicts between host
bridges, but it does require the domain as well.

> +		 */
> +		dev->liveupdate.preserve_bus_numbers =
> +			pci_has_incoming_preserved_devices();
> +	}
> +
> +	return dev->liveupdate.preserve_bus_numbers;

I'm not sure why you don't just return
pci_has_incoming_preserved_devices() in all cases, which is what the
commit log suggests this patch does.  What's gained by all the logic
here?  It's not like devices will be hot-added during the kexec.
