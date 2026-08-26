Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780F42E418;
	Wed, 26 Aug 2026 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753316; cv=none; b=RDhVpFk+UTfKDIQTS/ea9SCA3KLebZ5A3aqvn/6Yhi5TOGgc9VpD55lJcGIs4FWnV4rJWy9iGJJyzLWMXsAWeSBBEGnoXwqgSlnQ7so48XraoeKCq40wTzQW+BKng6zcygiabrs8DyxF7rs3DclY1lUAm2nHByw7MtIuykX2ZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753316; c=relaxed/simple;
	bh=CFG87ZaWpvxar+LmzhhuZpRsOTZ64BqB1+w3gYa98yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEez06kcpbeBBHPJevrTQLDMOZsdJIXLLwxyTUvgMe8Y/R8+yRNV9/B27YN5p5ZoEUYmBNtv/l0NCVaDYPT7NQObLtA8kyT/DdfvTat3vqbnitGhcSey7H6mcbBbYcagSXMWIt95kBseU0L+kRLkoc82C446IqpZXGuS0EPuGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZiGcDnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZiGcDnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD271F000E9;
	Wed, 26 Aug 2026 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787753314;
	bh=58CqlTkVH+yeGKqVx3x8yllINuupuUvSuHy1ToSmt8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dZiGcDnlz6tDjWuQcAuRDVN9X4hvLFz0grc8asWYHCXwDkmEDtD1eQHI4owQslV/P
	 yAaCW+FUfOddDcMs/zBZLDSCSsiD58j+7hEzQq9N5QgR7UZaMIXrMACPfPQvo+KSh0
	 vyXP/eHeK8girFF8S3HcvBQr+HSkPUwgDlm32kwCdF2+VvK9A7LnhNOKrz/MCMUxMp
	 NHwdwHV48AZsjvxm2wtYBzBHan8CLH3hZyCPURljSi6QqAtVL6xm7B5gle5a3s5mQk
	 xgyEdcZMZf1X1CfJnFSIN3EXL/dLtc2Z1nfxGuBeB1+eJhXwweci6L8dADVW2B/2xS
	 ZhmUoi1HsZ6jg==
Date: Wed, 26 Aug 2026 17:08:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: [PATCH RFC 0/7] PCI/HMAT: Describe P2PDMA reachability and
 performance
Message-ID: <20260826140831.GF42790@unreal>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
 <aoymZhOaSCG_Tsmj@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoymZhOaSCG_Tsmj@aschofie-mobl2.lan>

On Mon, Aug 24, 2026 at 01:15:34PM -0700, Alison Schofield wrote:
> On Wed, Aug 12, 2026 at 10:47:37PM +0300, Leon Romanovsky wrote:
> > Linux derives P2PDMA reachability from visible PCI topology, ACS
> > configuration, and a host-bridge whitelist. It cannot describe conditional
> > or slower cross-host-bridge paths; passthrough can hide the physical peer
> > relationships.
> > 
> > This RFC series implements the proposed ACPI HMAT Type 3 extension below.
> 
> Hi Leon,
> 
> Is there an ECN document for review alongside this?
> I get that the table below is a snapshot of the expected change, but
> would appreciate the long version to read.

Sure, Mahesh sent me the document, which I promised to convert to the
mailing list format. I will send the official RFC to the linux-acpi ML
slightly later.

Thanks

> 
> Please add linux-cxl to CC list on future postings.
> 
> -- Alison
> 
> 
> > Directional Generic Port matrices describe reachability, ordering, latency,
> > and bandwidth. Linux uses ordered paths to authorize P2PDMA and their
> > latency/bandwidth to rank providers. A VMM could translate these matrices
> > into guest domains; that is outside this series.
> > 
> >   HMAT Type 3 structure
> > 
> >   Field               Offset       Bytes  Meaning
> >   ---------------------------------------------------------------
> >   Type:                    0           2  value 3
> >   Length:                  4           4  entire structure
> >   Flags:                   8           1  traffic classes
> >   Data-type:               9           1  metric selector
> >   Initiators:             12           4  Generic Port count (s)
> >   Targets:                16           4  Generic Port count (t)
> >   Base-unit:              24           8  ps or MB/s; non-zero
> >   Initiator-PDs:          32         4*s  proximity-domain list
> >   Target-PDs:         32+4*s         4*t  proximity-domain list
> >   Matrix:         32+4*(s+t)       2*s*t  directional Entry[i][j]
> >   Reserved: bytes 2-3, 10-11, and 20-23
> > 
> >   Flags: encoding
> >     bit 0  non-UIO
> >     bit 1  UIO
> > 
> >   Metrics: selector
> >     0/1/2  access/read/write latency
> >     3/4/5  access/read/write bandwidth
> > 
> >   Direction: Initiator PD[i] -- Entry[i][j] metric --> Target PD[j]
> > 
> > ----------------------------------------------------------------------
> > Based on [PATCH v3 00/17] PCI/P2PDMA: Fix ACS egress control handling
> > https://lore.kernel.org/all/20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com/
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Leon Romanovsky (7):
> >       ACPICA: Define PCIe P2P latency and bandwidth information
> >       ACPI: HMAT: Make PCIe P2P paths available to consumers
> >       PCI/P2PDMA: Authorize HMAT-described cross-host-bridge P2P
> >       PCI/P2PDMA: Prefer providers with better HMAT performance
> >       ACPI: HMAT: Add KUnit tests for PCIe P2P matrix semantics
> >       PCI/P2PDMA: Add KUnit tests for HMAT policy boundaries
> >       PCI/P2PDMA: Add KUnit tests for HMAT provider ranking
> > 
> >  drivers/acpi/numa/Kconfig     |  13 ++
> >  drivers/acpi/numa/Makefile    |   1 +
> >  drivers/acpi/numa/hmat.c      | 245 +++++++++++++++++++++-
> >  drivers/acpi/numa/hmat_test.c | 223 ++++++++++++++++++++
> >  drivers/acpi/numa/hmat_test.h |  17 ++
> >  drivers/pci/Kconfig           |  14 ++
> >  drivers/pci/Makefile          |   1 +
> >  drivers/pci/p2pdma.c          | 300 ++++++++++++++++++++------
> >  drivers/pci/p2pdma_test.c     | 477 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h             |  23 ++
> >  include/acpi/actbl1.h         |  27 ++-
> >  include/linux/acpi.h          |  26 +++
> >  12 files changed, 1298 insertions(+), 69 deletions(-)
> > ---
> > base-commit: bc5261fca94dd94ab557cc0852ce465d9c3ab8b0
> > change-id: 20260715-hmat-p2p-eb4971a9d731
> > 
> > Best regards,
> > --  
> > Leon Romanovsky <leonro@nvidia.com>
> > 
> 
