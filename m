Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140892;
	b=zDzDJdcJ/mF0yk0z/Df5qrKYwMnC/axrtiBAlRN9zBaZotrhZ/VFYR2mv4Rj5/gLNlnQ
	 P6OLmsWhzvASi2IuHsNrHc3bOenr4AQQhqgcUso3/fS488lJGNsEuy+xGlAGa47+npayC
	 6NPOjz6iStq8ic0o4bMA+lYyEz43SlrDrUHqF2OIm41xX2fp851ROD8dFEvRco5bD9pJF
	 SX8M1TdEsLYrsMpHCWE/3z5omLJ2YrDWtxmL+U3YxjHi8/To00gkNvQwUysmFoxKqqSmH
	 ls5e24QtVbAM87JfJzbZtcFSgYtdoT/uzoPGZcKu9jYveaNxYPaxv8uVMFP12lZQyRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140892;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=36BYKCF164tXZn3FsLSkOB63KBQCKvHjKoR2T7jC1As=;
	b=fU1bcoaiMy3VodHFOpQqsv4O8/IMKk8SNjc1dsvaODG0oWNckAZaxh8aCt6bgcC5htu4
	 QINxQaw5vOZHMuV4iWjwiG6gCZZF+du3TyYoDqXSjdVnx0S1daFJkoD3pPcoEOLs6YRPm
	 p5wv15efrIBCzn4xg4snMUAqIFN/2n5V99QaRK1VDrXxAgjMyaJmerzoe7jE7vCo47iKH
	 S1r2luCYIKM56Gr4tzLjoc5Bmhf03kszcf5SuGkFtS1HXi2K7tydFsi6hUQWh0b+53Gz2
	 Kc8fNIIkNMAK8E+vQoiggmrZylGYcEDECzXVnrCdvg8iywoautU/Y5pXHxYtAM7hPIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=By9twM0k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBA606A31E;
	Tue, 27 Oct 2026 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=By9twM0k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F4B1F01825;
	Tue, 27 Oct 2026 22:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140891;
	bh=36BYKCF164tXZn3FsLSkOB63KBQCKvHjKoR2T7jC1As=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=By9twM0khKiyjXxV0Yx0gmrjtdC4XEQPzMwUDl+Una0jfLlAUEm4jYcbm08BVHjQY
	 PMAyhJ6MSrn6qWfGAs7OSIniRe1vJyzSMUnCSK4+sS5ogCsGxex4xW2wCncWk1TDyg
	 m8erVmAzhMyDwbkh79AxfmDf5nW9diszeWU8Y4rFPEYVAWXRmn+b+1GTscQ6BDSEJR
	 Gzpcv6o3EfAnCPBJuhgsgdwENi2BnGngjQBdQgaHjZJhtdY1fiQjW9aW60lQO+G8TN
	 XVp3gfycemxjRqdGKuh6aNkpOLLXvGqAdyxszYvU7NO4z5Qv6nzzzD8iqeLTTu6HPG
	 gTBIGzJ+M/neQ==
Date: Tue, 27 Oct 2026 17:41:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
Subject: Re: [PATCH v4 1/3] PCI: Preserve the initial bus number in pci_bus
Message-ID: <20261027224130.GA511803@bhelgaas>
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
In-Reply-To: <20261027-vfct-regression-v4-1-0e7190e39c2c@amd.com>

[+cc Lijo]

On Tue, Oct 27, 2026 at 11:22:25AM -0500, Mario Limonciello wrote:
> Bridge scans are split into two passes when bus numbers need reassigning.
> Save the firmware secondary bus number on the bridge in pass 0, before it
> is disabled. Use it to initialize number_initial when the child bus is
> created in pass 1, before bus registration callbacks run.
> 
> Keep the saved secondary number on the bridge so a later rescan does not
> replace the child's initial number with its reassigned runtime number.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c | 6 ++++++
>  include/linux/pci.h | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..3c03ac22223d9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1012,6 +1012,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	bus->sysdata = bridge->sysdata;
>  	bus->ops = bridge->ops;
>  	bus->number = bus->busn_res.start = bridge->busnr;
> +	bus->number_initial = bus->number;
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
>  		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> @@ -1232,6 +1233,8 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  
>  	/* Set up the primary, secondary and subordinate bus numbers */
>  	child->number = child->busn_res.start = busnr;
> +	child->number_initial = bridge && bridge->bridge_secondary_busnr ?
> +		bridge->bridge_secondary_busnr : busnr;
>  	child->primary = parent->busn_res.start;
>  	child->busn_res.end = 0xff;
>  
> @@ -1418,6 +1421,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  
>  	pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
>  		secondary, subordinate, pass);
> +	if (!pass && !dev->bridge_secondary_busnr)
> +		dev->bridge_secondary_busnr = secondary;

I think I was mistaken to suggest that pci_bus was the right place to
store this.

It seems like we definitely need something in the pci_dev because we
may clear the initial bus numbers in the first pass, so we need to
stash the secondary bus number somewhere until the second pass
allocates the pci_bus and we can save it here.

Since we have to have it in the pci_dev, I suspect maybe it would be
enough to have it *only* there.  Maybe it could be set in
pci_read_bridge_windows(), and drivers could find it via
pdev->bus->self?

>  	if (!primary && (primary != bus->number) && secondary && subordinate) {
>  		pci_warn(dev, "Primary bus is hard wired to 0\n");
> @@ -1470,6 +1475,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			child = pci_add_new_bus(bus, dev, secondary);
>  			if (!child)
>  				goto out;
> +			child->number_initial = secondary;
>  			child->primary = primary;
>  			pci_bus_insert_busn_res(child, secondary, subordinate);
>  			child->bridge_ctl = bctl;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5ffcf5ce8c966..c607818a98a87 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>  	struct pci_slot	*slot;		/* Physical slot this device is in */
>  
>  	unsigned int	devfn;		/* Encoded device & function index */
> +	/* Firmware secondary bus number saved across bridge scan passes */
> +	u8		bridge_secondary_busnr;

I think you're right to use "secondary" here so we don't perpetuate
the "subordinate" misuse.  Maybe also include "initial" and make it
"unsigned char" so it's the same as pci_bus.number?

>  	unsigned short	vendor;
>  	unsigned short	device;
>  	unsigned short	subsystem_vendor;
> @@ -724,6 +726,7 @@ struct pci_bus {
>  	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
>  
>  	unsigned char	number;		/* Bus number */
> +	unsigned char	number_initial;	/* Bus number before reassignment */
>  	unsigned char	primary;	/* Number of primary bridge */
>  	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
>  	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
> 
> -- 
> 2.43.0
> 
