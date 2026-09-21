Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5250128C;
	Mon, 21 Sep 2026 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017288; cv=none; b=iTugHbbn2pnNjoONelOOZNDJpLJwvJS5C2P5/bWPBMRdI7Qt3n9/4yIITmIQXR2BrtB915ADG1mMNZqxXzAQbxA+TXp3qqlul+2ZnQC9gPOaZoGx5ahyZBDwJ/6GnjX8aVU474dkxi28p1l6MCSQaAENC8bd1wCdmpKgsFwrLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017288; c=relaxed/simple;
	bh=VCMLWQO0W8kjwkMhOlsCljASItuZMr0q4GiiBX6hyvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oA06KYwqhQVx8OcedSt3FptpATmTDr2dwd6yrtE8zk6lCS4g1L+ACifJh94ApVlNzdFh8yQHg/gTqgoeCJxy1kbH5y4A3ibhItP/HJFSItfS9zXMa2Ba1EBQceNU+Vom9qQskV3jDIQpC7jLfbkuq9jdYfD+qGZwUeNOlQnMqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDMqtVsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDMqtVsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825291F000FF;
	Mon, 21 Sep 2026 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790017286;
	bh=zbCqjiiAtFF9V3eMWwicZ2q8jqLFWGYJLPnsBEOmlr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QDMqtVsanp/gWdTRnTIyDSUTuAlUceEO3J4TClP36ydWAy7WkaWYeWEk+C1sZ3bE5
	 ffg7zLUXVIml2Y5xHNKFcUqYR5s6sJeXdANdFmck3V5ev4/6CfbUCKaG/6XQyeLg5r
	 8dnVI2/sNtP1bbFVlOUdJxWe41Z6vI1bD6bU+xmlx6N9xLDJ6PDl/GxbTATb8sPrKu
	 6wZAc+6GXNBqCfZODcY3oNko/HvSLEUnGIG9ax7zHtXd4iVernmvW6IlekPxTkPs/M
	 VPOuUhqVKD2b9jETzQ3kRE5Dx+Fnxx+No5Y0L52TazAga0INUspR0eB/T4+vTZRHHw
	 8Di40D5OmB4pw==
Date: Mon, 21 Sep 2026 14:01:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rafael J Wysocki <rafael@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Olof Johansson <olof@lixom.net>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v13 2/5] PCI: Assume control of portdrv-related features
 only when portdrv enabled
Message-ID: <20260921190125.GA1333298@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq96cULSmdeBzd3D@wunner.de>

[+cc Terry, in case you have thoughts about native_cxl_error;
beginning of thread:
https://lore.kernel.org/all/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com]

On Sun, Sep 20, 2026 at 08:17:21AM +0200, Lukas Wunner wrote:
> On Sat, Sep 19, 2026 at 09:26:52AM -0700, Kuppuswamy Sathyanarayanan wrote:
> > +++ b/drivers/pci/probe.c
> > @@ -668,12 +668,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
> >  	 * may implement its own AER handling and use _OSC to prevent the
> >  	 * OS from interfering.
> >  	 */
> > +#ifdef CONFIG_PCIEPORTBUS
> >  	bridge->native_aer = 1;
> >  	bridge->native_pcie_hotplug = 1;
> > -	bridge->native_shpc_hotplug = 1;
> >  	bridge->native_pme = 1;
> > -	bridge->native_ltr = 1;
> >  	bridge->native_dpc = 1;
> > +#endif
> > +	bridge->native_ltr = 1;
> > +	bridge->native_shpc_hotplug = 1;
> >  	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
> 
> How about (e.g.)
> 
>  	bridge->native_pcie_hotplug = IS_ENABLED(CONFIG_PCIEPORTBUS);
> 
> instead of using #ifdef?  That's the preferred style according to
> section 21 of Documentation/process/coding-style.rst
> 
> >  	bridge->native_cxl_error = 1;
> 
> Hm, this one depends on CONFIG_PCIEAER I believe.
> (But Terry Bowman is the expert.)
