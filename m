Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B23F8EB2
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002104; cv=none; b=W/bxQkokGUI2ISksjpvSxr1N3avUzeimOlIy5JlpQ/PmJfLaInmuLqJ3sWJ51f8jOgvnWf7VizqyWHtTJgU4Hbil6ua+LMrR4zM7GElYnsV7EnFVjLlk2NxTDVHgfYuM/OAH/U+COGSEopDUUXCaOgymvmOn66vONt95BX1P2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002104; c=relaxed/simple;
	bh=OGOC2R1GDZE4uWvP2XbvH/EF4G4OiU91xYDTrfOLKv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJramxGojbfF6/U22S3kSnmMa9EuXQhKTmf4Z75409q2adMovagiBOm9K/f6OSDo9mQg4a0uIBMwp37Do83P7O0vY1NbOsXHAzOd2KrgJM1Rl3ljhO2d0xZEIJ7mH6XCsjsanAFQ8U2HRRW2/ULE7DfOiEv0JtsLhsUgvtJ97GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOJncBdC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOJncBdC"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0b1a48855so495765ad.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781002102; x=1781606902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLGghC6UIfVrvCdIhumzQTyhB1QR5R7Bsqly45dLP7M=;
        b=KOJncBdC0QAgsdymbrFr0yTWW0siqTowoYIUQ+6Iwo3FPndduGjKmty4Swx/PCPWn9
         swxaluughOus666040wP4VuGHPmEGctIw3+tB+0f/67SOvGxrcDIIsYuUW98riiV7eY7
         KS8RKWjfQ53lx3J0SZnVkzjLQdwI4FzO1LolccqPB/N/r8o39FdAILftWXyxKkCTbUvR
         w4qRASYwqHowSL2p07G5Ze0Bf5cxPpNf6gUlN3/0gxIimILjpVszujYngBS1JmJcjm9a
         39eMxQwIYk8MY1Qjq37cU5mODkKkWS9gN11/dMlZfFqQICB8ullpgr6k/35/VzFTaf86
         4v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002102; x=1781606902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLGghC6UIfVrvCdIhumzQTyhB1QR5R7Bsqly45dLP7M=;
        b=hWX6B2HNVqPddo6x7AWBdi9RY/+jkJQSPgI9He5lxg/RNJgQithXGUgLqXOVJEToxV
         9uu8bFBwxRRKEt+Yw8lU2pHG+5nQvIhfK3+MZDdV4DLq742zfJglTED8ekFEJGjh625a
         IlAHk23wRlbFY/8vDhbCZemT+MgHoO9s5Zr1oAe1CsJjtJPf2XEvq/5FqDdTzJBtvHQt
         66PoUBwNaG8Tx0/Ayybo9l18bJvKCuh/8hp6fUKBHD1Yq/F/Mdg0xzk49+FAC4SNECpp
         x7C4zdzGatZgxayMkIbgw/lYIXa7iIoOzgVOlu/iLWsnB8fSZDoYfQv1mQoEqWhaN7+l
         ajfg==
X-Forwarded-Encrypted: i=1; AFNElJ+050bWyJ6N1f1UFuhDULiY+cgRuJLQZVjstT/kJ7Ec99AoJxfRUPE/0d7qU2hM49adFB/EhG36gfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfwL8nvDsWnmlWAfPnzDR7oHzAorEKXFGoQ6EUTgkVsEPtHBE6
	0VcVQm65StqMJPbhJCWTNtdEyV6dzxA3dkeiIfp5pXnp4bdhRSnoDryxKzlwbf+UKcqApHdGohr
	EdqnbM90e
X-Gm-Gg: Acq92OHn8ckM9ov7cL0OWvNqdyHfyVXgCmjy64UNoplxZ3GwI4tDZ14v7KHUczKykF+
	wlKMY+TY2l1YlDQBD1UUmzFiV1uUje3utpicL13kBmZnY1y0EZMF4oaHsy1Rb5SVVPo3EAslk+k
	lzf5ZSYR3GbPCebosv9GyR/c8RRdwFwKz3URbiZFKkYZtu0miz0y197n4ElJv1mCgIFbA73rD7W
	11OZkW2pDipB5rtrd2P7wGbTcLKOT2vkKjLIe4j8C3e7zPVa1H81k9W6VFt4XE53HKzaE982hiO
	wRQNRs2kwNkjiskQlbiZWC2A3aLX8se037/S2onkLm18cdFcN7qnC5A2YbLYnzAIrS6lVDYXPlH
	1ICuuUKCVc4M8aJNrP5Flm+p3BveqekFmPjABPOsP6+MEwcQODZ2qeJig/4VbsT5tec9AIRftNW
	xeTTosawHA/IZ7VDXNFOW3bOUejxKCixbI/2sCw+v5kLF/+1lLkUjLAFRZSN6qLqYoeUBOesY=
X-Received: by 2002:a17:903:1a6f:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2c1ec0deac6mr7312765ad.21.1781002102069;
        Tue, 09 Jun 2026 03:48:22 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372502sm22347071b3a.16.2026.06.09.03.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:48:21 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:48:12 +0000
From: Pranjal Shrivastava <praan@google.com>
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
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <aifvbD9ZoVOsgCrD@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
 <aiPxVxu2sUVQfG9D@google.com>
 <aicsyesGrqcWj7vu@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aicsyesGrqcWj7vu@google.com>

On Mon, Jun 08, 2026 at 08:57:45PM +0000, David Matlack wrote:
> On 2026-06-06 10:08 AM, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
> > > During PCI enumeration, the previous kernel might have passed state about
> > > devices that were preserved across kexec. The PCI core needs to fetch
> > > this state to identify which devices are "incoming" and require special
> > > handling.
> > > 
> > > Add pci_liveupdate_setup_device() which is called during device setup
> > > to fetch the serialized state (struct pci_ser) from the Live Update
> > > Orchestrator. The first time this happens, pci_flb_retrieve() will run
> > > and convert the array of pci_dev_ser structs into an xarray so that it
> > > can be looked up efficiently.
> > > 
> > > If a device is found in the xarray, the PCI core stores a pointer to its
> > > state in dev->liveupdate_incoming and holds a reference to the incoming
> > > FLB until pci_liveupdate_finish() is called by the driver.
> > > 
> > > This ensures proper lifecycle management for incoming preserved devices
> > > and allows the PCI core and drivers to apply specific Live Update
> > > logic to them in subsequent commits.
> > > 
> > > Drivers can check if a device is an incoming preserved device (e.g.
> > > during probe) by calling pci_liveupdate_is_incoming().
> > > 
> > > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
> > > domain and bdf can be guaranteed to fit in an unsigned long and be used
> > > as the xarray key.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  MAINTAINERS                    |   1 +
> > >  drivers/pci/Kconfig            |   2 +-
> > >  drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
> > >  drivers/pci/liveupdate.h       |   5 +
> > >  drivers/pci/probe.c            |   3 +
> > >  include/linux/pci_liveupdate.h |  13 ++
> > >  6 files changed, 251 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6c618830cf61..0e262c0ceb43 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20537,6 +20537,7 @@ L:	linux-pci@vger.kernel.org
> > >  S:	Maintained
> > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> > >  F:	drivers/pci/liveupdate.c
> > > +F:	drivers/pci/liveupdate.h
> > >  F:	include/linux/kho/abi/pci.h
> > >  F:	include/linux/pci_liveupdate.h
> > >  
> > > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > > index 10c9b65aa242..e68ae5c172d4 100644
> > > --- a/drivers/pci/Kconfig
> > > +++ b/drivers/pci/Kconfig
> > > @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
> > >  
> > >  config PCI_LIVEUPDATE
> > >  	bool "PCI Live Update Support"
> > > -	depends on PCI && LIVEUPDATE
> > > +	depends on PCI && LIVEUPDATE && 64BIT
> > 
> > I see that the static assertions in Patch 1 work because of the 64BIT
> > enforcement here. In that case, should we have the assertions check u64?
> 
> The static asserts have nothing to do with the 64BIT enforcement here.
> The static asserts just verify that the array elements in struct pci_ser
> are naturally aligned (unsigned long) so they can be accessed
> efficiently. The requirement here for CONFIG_64BIT is for the xarray
> key.
> 
> Theoretically if we got the xarray to work with 32-bit architectures
> then we could drop the CONFIG_64BIT requirement here.
> 

Ack. I see.

[...]
> > > +	kho_restore_free(ser);
> > 
> > I tend to partly agree with Sashiko[1] here.. it raises a policy-hole.
> > We may need a policy here, the options I have in mind are:
> > 
> > 1. Retrieve shall ONLY be tried once, if it fails (like -ENOMEM in the
> >    xArray alloc), it's a liveupdate failure. We can't retry liveupdate.
> > 
> > 2. Retrying retrieve is allowed.
> > 
> > The only downside with option 1 is, the user may want flexibility due to
> > certain subsystems OR may choose NOT to use the proposed LUOd and instead
> > have its own user-space component which might try funny things or have a
> > different use-case.
> > 
> > In such a situation, the system may have transiently run out of memory
> > during the kexec transition (for e.g. a subsystem uses GFP_ATOMIC to
> > allocate memory and temporarily runs out of the atomic pool). [Note we
> > removed it in IOMMU v1 [2] but subsystems may have a use-case for it]
> > 
> > If the kernel frees the KHO page on the first failure, it removes any
> > chance of recovery. :/
> > 
> > Thus, it might make sense to let the user decide if it wants to fail the
> > liveupdate or retry again based on the failure type / source?
> 
> The plan is to have LUO enforce that retrieve() is only called once:
> 
>   https://lore.kernel.org/kexec/20260528174140.1921129-3-dmatlack@google.com/
> 
> Supporting retry gets complicated since there's many different places
> where retrieve() could have failed.

Ack. Thanks for pointing me to the thread.
In that case, no problem.

Thanks,
Praan
