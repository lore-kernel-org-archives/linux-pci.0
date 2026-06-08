Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A723A872D
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952272; cv=none; b=XBpLFT3FjuXqK12Fag+gKCg9YAehl1Fv4NuXxJNAnM6+y1q08BSRbLk1zp2BxHf6ozx/yCHiNC3veoKLNVswtl4npsGUN10mMxEJ+rBJ6OvacaOrmroozp6HWXwRvgS9l2JESoT+rXIV/fHrtO5IvxPJY8aHxV3+Jq0s7JLPEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952272; c=relaxed/simple;
	bh=aW1vlaAzlGeVp8NwgxYNRRi9jC/+aJgXk5gzUko5PHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKrobjisLI/A4FE2iv1YBHbfv+GOqNitdoPsD7nqt6hQf6l7PN1ATxiewaLUm6HDfMENlDhYzhwsW/vOU4R8gJ1VdkrHCW4O1hdGuuMkc++8hsKrAKSzJruELAhpUrZy2HX+tuAW9flYY21F+U1TmwNkL/IDt9zo/of9SeK9q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e23YwxKM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e23YwxKM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so34069875ad.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780952270; x=1781557070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwWXYyLBedswXBpDr6XhVLr7hKW6gX2W2Wf9GCvWRA8=;
        b=e23YwxKMeJOorOZBDJcPNtmazHkUc893LdFEpvDlmmy5xS6A59owzsTcG1q8cPij0+
         ALXxy3aOaBuUcAJbCNSwwRiQHrdRPmU4NzRf05tPTacvnDbFp6fqivOp4kyAe34am4wY
         duPaPZY6WaQ/hSMXuS1Wv3QnVQe9hF7/jCr73WDwq9Ks6J3D3znQphGSmkimfyFsDkT8
         NAigvTYNrti8IlGOEZrUqsCJUhPUSBFKyHog2LJLOv+Cmev5kHLY+rLMLLz6W9UAF+a2
         bUXGIAUrq667Q1uteMixT+YLAeRWW957PTj1os73Re4wI9uZoEQyVUuVbDhw/EWk/EyK
         niuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952270; x=1781557070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwWXYyLBedswXBpDr6XhVLr7hKW6gX2W2Wf9GCvWRA8=;
        b=OQ0EYBotUd8KsoZirBF9wXjtVQ2X/sc8mxbu2ne7iV+qI0uyhidR+A/molqYTH2lxN
         5k5EyLTIyHJCHg2GXgx2IrHs33Pg2BWBLJe0Aq4SMbRoSwtcmfyQWZTUvT4N8K644yS0
         j0MVD5thSp5dAMpWRK024tNiHC+DyzumijVkfeoUXAcMm7baGeHyhuT9YoboroHdKknD
         LsUnx6XnfCcjicaPeqL4Yje3/6QfsnBI4MvPZl/NsiQ0523A/bOQr/Dc6Pb5g/kz8h1U
         UK9FH3b9/yEzU+ntrCwe0ET5gnQZmplT1cgaHxn0glFndkszwCV9Dv3E+zhJL/Q8yLGw
         DyIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9s0/OqWkLJYV8QQ1LW2xRTS0vWWgvv1/vSr1eHB8rXBT6dSh92s3emr95pnnijrmdVmEOGDzofaoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9FeqmrQcMZesztvhMfomARdrA30HWj5mPNgMSnVfr5BpvsXX
	npvlOi4CAPUPHkByeBFa7lOSDPzJrEDKW5T7iw5abNKqVNgf0AuZexB9a0XpRD0gtQ==
X-Gm-Gg: Acq92OH7tUkOmQC1c+DkYaJPehbiPc/KZwjNe21Q0V4JiWwl9t6xPg5Uycux9yi4XBV
	sx0+3sfYrKhLjPi7xrbTzaSIpiZDULT4PcZE3x22p1HR5++0c3jCIMNp+g2oJN2/41/V5GheclU
	ltbDfFAFf2UbL1XBMqF5nzExRKgJCBe3o5fDavhA7kRyb8TxcLWWbkz3u8kqJX+rAuToDfOxCFD
	1/MnTBWJ9dOR5Tem2Yao9fqbNa6CBExpJQJBzABiO+sWGE/43ogNWJjcRM57C/W32t2Lw16NrD5
	qierdSkknmDLthzfpG3dHqiAfM84peBLF0M8s6Bg0FmzWpNI8r5EnuhoV0zXRn7Ueyd/wgywqOj
	282uD7+a5+2EqBIXoVHq5L1QXoplF+Hax7yn6mHrq/eHPIIZzAXOA5l7NZl/4X0KXaF+onUNBHl
	PGXiAKtegX7Ou8pceBm934xHnZudLlHYrrnhQYeApIByusDlb0IeqsRju9NYUep76j1nSlRiuj
X-Received: by 2002:a17:902:6ac7:b0:2bf:bd17:90d4 with SMTP id d9443c01a7336-2c1e820b41fmr143853655ad.28.1780952269772;
        Mon, 08 Jun 2026 13:57:49 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm191929635ad.26.2026.06.08.13.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:57:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 20:57:45 +0000
From: David Matlack <dmatlack@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
Message-ID: <aicsyesGrqcWj7vu@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
 <aiPxVxu2sUVQfG9D@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiPxVxu2sUVQfG9D@google.com>

On 2026-06-06 10:08 AM, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:01PM +0000, David Matlack wrote:
> > During PCI enumeration, the previous kernel might have passed state about
> > devices that were preserved across kexec. The PCI core needs to fetch
> > this state to identify which devices are "incoming" and require special
> > handling.
> > 
> > Add pci_liveupdate_setup_device() which is called during device setup
> > to fetch the serialized state (struct pci_ser) from the Live Update
> > Orchestrator. The first time this happens, pci_flb_retrieve() will run
> > and convert the array of pci_dev_ser structs into an xarray so that it
> > can be looked up efficiently.
> > 
> > If a device is found in the xarray, the PCI core stores a pointer to its
> > state in dev->liveupdate_incoming and holds a reference to the incoming
> > FLB until pci_liveupdate_finish() is called by the driver.
> > 
> > This ensures proper lifecycle management for incoming preserved devices
> > and allows the PCI core and drivers to apply specific Live Update
> > logic to them in subsequent commits.
> > 
> > Drivers can check if a device is an incoming preserved device (e.g.
> > during probe) by calling pci_liveupdate_is_incoming().
> > 
> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
> > domain and bdf can be guaranteed to fit in an unsigned long and be used
> > as the xarray key.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  MAINTAINERS                    |   1 +
> >  drivers/pci/Kconfig            |   2 +-
> >  drivers/pci/liveupdate.c       | 230 ++++++++++++++++++++++++++++++++-
> >  drivers/pci/liveupdate.h       |   5 +
> >  drivers/pci/probe.c            |   3 +
> >  include/linux/pci_liveupdate.h |  13 ++
> >  6 files changed, 251 insertions(+), 3 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6c618830cf61..0e262c0ceb43 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20537,6 +20537,7 @@ L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> >  F:	drivers/pci/liveupdate.c
> > +F:	drivers/pci/liveupdate.h
> >  F:	include/linux/kho/abi/pci.h
> >  F:	include/linux/pci_liveupdate.h
> >  
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 10c9b65aa242..e68ae5c172d4 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
> >  
> >  config PCI_LIVEUPDATE
> >  	bool "PCI Live Update Support"
> > -	depends on PCI && LIVEUPDATE
> > +	depends on PCI && LIVEUPDATE && 64BIT
> 
> I see that the static assertions in Patch 1 work because of the 64BIT
> enforcement here. In that case, should we have the assertions check u64?

The static asserts have nothing to do with the 64BIT enforcement here.
The static asserts just verify that the array elements in struct pci_ser
are naturally aligned (unsigned long) so they can be accessed
efficiently. The requirement here for CONFIG_64BIT is for the xarray
key.

Theoretically if we got the xarray to work with 32-bit architectures
then we could drop the CONFIG_64BIT requirement here.

> 
> >  	help
> >  	  Enable PCI core support for preserving PCI devices across Live
> >  	  Update. This, in combination with support in a device's driver,
> >
> 
> [...]
> 
> >  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> >  {
> > -	args->obj = phys_to_virt(args->data);
> > +	struct pci_ser *ser = phys_to_virt(args->data);
> > +	struct pci_flb_incoming *incoming;
> > +	int ret = -ENOMEM;
> > +	u32 i;
> > +
> > +	incoming = kmalloc_obj(*incoming);
> > +	if (!incoming)
> > +		goto err_restore_free;
> > +
> > +	incoming->ser = ser;
> > +	xa_init(&incoming->xa);
> > +
> > +	for (i = 0; i < incoming->ser->max_nr_devices; i++) {
> > +		struct pci_dev_ser *dev_ser = &incoming->ser->devices[i];
> > +		unsigned long key;
> > +
> > +		if (!dev_ser->refcount)
> > +			continue;
> > +
> > +		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
> > +		ret = xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL);
> > +		if (ret)
> > +			goto err_xa_destroy;
> > +	}
> > +
> > +	args->obj = incoming;
> >  	return 0;
> > +
> > +err_xa_destroy:
> > +	xa_destroy(&incoming->xa);
> > +	kfree(incoming);
> > +err_restore_free:
> > +	kho_restore_free(ser);
> 
> I tend to partly agree with Sashiko[1] here.. it raises a policy-hole.
> We may need a policy here, the options I have in mind are:
> 
> 1. Retrieve shall ONLY be tried once, if it fails (like -ENOMEM in the
>    xArray alloc), it's a liveupdate failure. We can't retry liveupdate.
> 
> 2. Retrying retrieve is allowed.
> 
> The only downside with option 1 is, the user may want flexibility due to
> certain subsystems OR may choose NOT to use the proposed LUOd and instead
> have its own user-space component which might try funny things or have a
> different use-case.
> 
> In such a situation, the system may have transiently run out of memory
> during the kexec transition (for e.g. a subsystem uses GFP_ATOMIC to
> allocate memory and temporarily runs out of the atomic pool). [Note we
> removed it in IOMMU v1 [2] but subsystems may have a use-case for it]
> 
> If the kernel frees the KHO page on the first failure, it removes any
> chance of recovery. :/
> 
> Thus, it might make sense to let the user decide if it wants to fail the
> liveupdate or retry again based on the failure type / source?

The plan is to have LUO enforce that retrieve() is only called once:

  https://lore.kernel.org/kexec/20260528174140.1921129-3-dmatlack@google.com/

Supporting retry gets complicated since there's many different places
where retrieve() could have failed.

> 
> [...]
> 
> The changes LGTM, except for policy-based, kho_restore_free discussion.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks,
> Praan
> 
> [1] https://lore.kernel.org/all/20260522211333.D56A21F000E9@smtp.kernel.org/
> [2] https://lore.kernel.org/all/20260203220948.2176157-2-skhawaja@google.com/
