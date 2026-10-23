Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777668;
	b=sLgNw0i4J0c0hHIO4moz2pRYYcbsQVatnpPnSD162hC7S3/4y/4PstXC8sgQXQrIH8cz
	 7l2W5rjDASC7zex+89bjc2Fe2Wtg5KFqFlSNr/1/os5za5bvc+yoIbMG/v4VFJknZW8Kk
	 qAtK3EJc2ufkVz20aFBbZUlCRJJPjCLevgbQTrP+ltgxYmq3FnnSkvOm95yRxwUPAcQHs
	 rXe1aQ8I3nPbYRFcBVpDLl6ivAnW6oVwGagoSz9s8HUNg67Bc/9th/34TuGCYdEW8X5go
	 g3Eg4OqLJuG3RwruOXiSstXeB4CTIWOVGrOM13hrrvX0HmvzdNvqD7xwpCQeUIpi/dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777668;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EgRflrA0uulNksUz1cPaQajGrmLlAAPPSnG8n3RQbPE=;
	b=FJINGqElnKNyf+pq+iDcmLZIgOyfmTj8rVfiJ3mTdnfrCpnL/hGvWjz4D1tFNihH4T2F
	 qfY5E89huAJRltvDJqWeEaF/ilJLNQsv5tYtwDV5Rzs9O428Z2sLJ6FH1gk2UKh/OWuoF
	 d4EEuKQV9wzADr33y3xqud4IKNgnGo5LjY+i7EMVE9FZVAcJMk+8ZPdA1qIZSVihJRXLY
	 Ms0QaL7xjwP7ejA9Ld/6Dfp616oqcm/22qxxfHM7VatlG0EzmskaI1wk8lNwm4TC8IUfj
	 /GGKzRc3D5TbCtLN8CEncQ7FpLJ7WVulCG3CKZSkVu2N1PuJ++OHLpie1QHMV2t5JVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTBqXNHp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54B606A31B;
	Fri, 23 Oct 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTBqXNHp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6891F031E2;
	Fri, 23 Oct 2026 17:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792777667;
	bh=EgRflrA0uulNksUz1cPaQajGrmLlAAPPSnG8n3RQbPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UTBqXNHpl62gWrKfxC4rbwumWyTjDOXUu5DAbQNgeXX2iFRjuMSygMGZzBhTJFOoN
	 TEzGMtV5t15xJKkp+vzda2GURHxE2+mmkwmK2GlxTRk4wGsRxbvwhpYBbiDBokw6tF
	 1nlcAxY9GpN8cPSq+wShNzb2BuBt2PKvFILbU1iSt/3dVUCIoeCFoX5OVgMnAxGgNx
	 LtZf5tHexjWT5sELxcKzclUsNficTrgVgT4oMuc7CflDNESrFoFWC1eySFM41WpceT
	 enBQoEVpULFb6vcsEGzDqAnAZCkoZusrTX39ZGgUmw5647iCp4BQVDGhU3t6VmEVE6
	 9f++YbV3WWF/A==
Date: Fri, 23 Oct 2026 12:47:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/3] PCI: Preserve the initial bus number in pci_dev
Message-ID: <20261023174746.GA2791886@bhelgaas>
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
In-Reply-To: <20261020-vfct-regression-v2-1-d2394d11450a@amd.com>

On Tue, Oct 20, 2026 at 09:04:40AM -0500, Mario Limonciello wrote:
> Bridges that need bus reassignment are scanned in two passes. Save
> the firmware secondary bus number during the first pass, before the
> bridge is disabled, and carry it to the bus created in the second
> pass. Initialize pci_dev from this preserved bus number so drivers
> can match firmware records after PCI bus renumbering.
> 
> Handle pci_alloc_dev(NULL) as well; some in-tree callers use it to
> allocate a standalone pci_dev.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c | 9 +++++++++
>  include/linux/pci.h | 3 +++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..4ece4b70cdc15 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1012,6 +1012,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	bus->sysdata = bridge->sysdata;
>  	bus->ops = bridge->ops;
>  	bus->number = bus->busn_res.start = bridge->busnr;
> +	bus->initial_bus_number = bus->number;
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
>  		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> @@ -1232,6 +1233,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  
>  	/* Set up the primary, secondary and subordinate bus numbers */
>  	child->number = child->busn_res.start = busnr;
> +	child->initial_bus_number = busnr;
>  	child->primary = parent->busn_res.start;
>  	child->busn_res.end = 0xff;
>  
> @@ -1470,6 +1472,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			child = pci_add_new_bus(bus, dev, secondary);
>  			if (!child)
>  				goto out;
> +			child->initial_bus_number = secondary;
>  			child->primary = primary;
>  			pci_bus_insert_busn_res(child, secondary, subordinate);
>  			child->bridge_ctl = bctl;
> @@ -1491,6 +1494,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		 * do in the second pass.
>  		 */
>  		if (!pass) {
> +			if (!dev->initial_secondary_bus_number)
> +				dev->initial_secondary_bus_number = secondary;
>  			if (pcibios_assign_all_busses() || broken)
>  
>  				/*
> @@ -1526,6 +1531,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			child = pci_add_new_bus(bus, dev, next_busnr);
>  			if (!child)
>  				goto out;
> +			if (dev->initial_secondary_bus_number)
> +				child->initial_bus_number =
> +					dev->initial_secondary_bus_number;
>  			pci_bus_insert_busn_res(child, next_busnr,
>  						bus->busn_res.end);
>  		}
> @@ -2508,6 +2516,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  	INIT_LIST_HEAD(&dev->bus_list);
>  	dev->dev.type = &pci_dev_type;
>  	dev->bus = pci_bus_get(bus);
> +	dev->initial_bus_number = bus ? bus->initial_bus_number : 0;
>  	dev->driver_exclusive_resource = (struct resource) {
>  		.name = "PCI Exclusive",
>  		.start = 0,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5ffcf5ce8c966..f6b377dcf7a14 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>  	struct pci_slot	*slot;		/* Physical slot this device is in */
>  
>  	unsigned int	devfn;		/* Encoded device & function index */
> +	u8		initial_bus_number;	/* Bus number when device was discovered */
> +	u8		initial_secondary_bus_number;	/* Bus number behind this bridge */

Why do we need this in the pci_dev?  Is there something about
pci_scan_bridge_extend() that means it has to be in pci_dev as well as
pci_bus?  Multiple copies means possible inconsistencies.

>  	unsigned short	vendor;
>  	unsigned short	device;
>  	unsigned short	subsystem_vendor;
> @@ -724,6 +726,7 @@ struct pci_bus {
>  	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
>  
>  	unsigned char	number;		/* Bus number */
> +	unsigned char	initial_bus_number;	/* Bus number before reassignment */

I think it should be stylistically similar to the existing
"pci_bus.number"; adding "initial" before or after is ok, but adding
both "initial" and "bus" makes them less connected.

Users would check "vhdr->PCIBus == rdev->pdev->bus->number_initial" or
similar.

>  	unsigned char	primary;	/* Number of primary bridge */
>  	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
>  	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
> 
> -- 
> 2.43.0
> 
