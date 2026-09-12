Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CF224234
	for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789234326; cv=none; b=uxtqy+NhyX+zrusBfflsSrV/sGbsUxBCieWeCa9YwQy432l1sA7EZSHKJWfT2jqXb6aw0DezAaTuzrGRr+GcqzOhBZlOwUabf2L0jrao3Bu01jtlE1PnHFka00xG5P1xejm//ctyTFrNVKf5o7pfoPXu03uMxY5TLquKjl2ziYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789234326; c=relaxed/simple;
	bh=Jkf0YZSlcFgLfLyrbr0OSFkYg9rN+0VYiQJO3omdIxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWZvCGcLmnmKlaypLkW2EWGUTm80xPbTipjlxIfOYIMdsq4k+Fh35MuVpKRXpF2gEz/lkIp2W2JStZcRB7JfgvX0HfyT+GfWeK4b6jaPZNen1CIQINoChksYaXx1jHVP/UwMAXegd3/H4NzEa25feBFeBajiTuf0DN9Z4jWeLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9RO2c1M; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9RO2c1M"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f38so9756165ad.2
        for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789234325; x=1789839125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBslPyab51IM3cN1q+WywRAJYOzHWq5eKWBrdVKUM1w=;
        b=O9RO2c1MyVoyN+roDjyRKZktvn3cO4hWzs1y5cUL9Tj/EPMQhmnRLpKDA+fOySHYBQ
         HffLRJpq7cQC0+a5m0fHp7jx5qeEIQ/4KpxwFzdC/mPiaGMZznC80KZ4eAv9389vH5XI
         +iZcys2TuxOCRa1JeKWLOt/2zYa9M7HmNEAbhgY1CH4oRnc1OFoIT1UhZZAkzutbeJMi
         zTIiTVMpNWk06hdxoU7YT1wzrqwOavEnSZ+Hpg+NApE1j7EiegOF+sJd+TmWKfbtxZ1A
         bRPtswuMw9GK9FYLYGs4Dm6RwDEmNPGZm6hcMl0p/y67EbpsDfI+r3NxwaLJYSF1c2SJ
         /33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789234325; x=1789839125;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBslPyab51IM3cN1q+WywRAJYOzHWq5eKWBrdVKUM1w=;
        b=D4r08AdodRNK71BkOwPBOn9ibaJtRCq6crWEtYeBL7OU9mhDCWWkpD/+wtw0YGu1C4
         CVkSg9tOUp6Fk8+iOWdNRWEAujXxT8p40Ki06xhFGbDxZ4MjFQ9QmV2VWIv56DI5hKwO
         jOWOAUJ6OjdsXFf7mJo6W3mvtYtLIg/BBukR57yG0sSuXRD3CJ9yEB4dvRsnJOydnkl5
         Xbbg+zPJrcZWOULvPPTmSwZsEBmcyfBemVZ5rs4hHcj00eowKa8nOZiTofyjbxVjcDq2
         JbwksP+UCfCQ/JEY1aL9BhGRC+A5mtyNdsjIGpQi3v+e7R7JPZTcq1WIWK+dd+9Q36xr
         BLaw==
X-Forwarded-Encrypted: i=1; AKwUvBzZ2jdVhUklbhjlNWTyRU0Yo1MiPHpkq62pLOLLQt9s9jMPerxWUuiQYo5BnzZk3ne3lDLMGVK68EU=@vger.kernel.org
X-Gm-Message-State: AFuF++lR8QGM6xRjMS+59nTgpadno4bzk+OwxPfZ/NCFSm6YqsNxT6Su
	J1xm4kAMQvPufPte1h46PV6WXhN200KZpk5mTAwEK08ohfSdqnxyRIEJiA9dp9q6C6dqf8h97Tt
	TR96zreJC
X-Gm-Gg: AYBFou1mIG0tODXVPfewDtOW1qRlKkfVt5040E0CXzsfNDSI8feBYq0VZl5BXwDJdL9
	n+jSxcN+9yrY8p0oFxGkugA+IyVzHeI02EAv/zkhFR+wv++8qG9l6Cj/P/wpQMFLjAEBDLpWytO
	B54q0owPndrYXiufZpvHwHfZDWQtCxhdm4+2oVGoWeRGtp0RfaHByIKlczo9vqC+loN71/t4I57
	JEfM+1DkUaO6GdZcs3p1JdgAxlp7SrdY7HUIAgsaOmtgLgLQmLRfcDGjI/vCqvk4F+kyfrS4RkR
	3LQJoRHY8SH84fkHkzAi8qOQNoyBsfBSkGvqWIPI0BtSD4MVL2T8ry6Cb/eJtVjr5pHjM+C3Q5T
	EWheDh6RT1jxNt3FyUoIueFyuvaS+vpbB4u6n5eaD8rpuxkIU53pGIWZP+Zlt59bXj6GAa3MJOo
	gDu4r4ULifJJFH4HIy4d4Y1rT68skJnD0fm5uKxpjgUxHtYoI16iJfrwu4Z9XFBcvjB7vK0Pz4k
	RZPFZzoLK82JbXr27ndgI6JjqfiStowjw5nghGc
X-Received: by 2002:a17:902:e881:b0:2d8:d4cc:be64 with SMTP id d9443c01a7336-2dd2a35a58cmr165076475ad.17.1789234324159;
        Sat, 12 Sep 2026 10:32:04 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc5c7bsm25731245ad.51.2026.09.12.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 10:32:02 -0700 (PDT)
Date: Sat, 12 Sep 2026 17:31:58 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <aqWMjrea2MMMZHxr@google.com>
References: <20260728221007.2098560-6-dmatlack@google.com>
 <20260910235104.GA367522@bhelgaas>
 <aqRIJs1SdJwoV_cf@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqRIJs1SdJwoV_cf@google.com>

On 2026-09-11 06:30 PM, David Matlack wrote:
> On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> > On Tue, Jul 28, 2026 at 10:09:59PM +0000, David Matlack wrote:

> > > +bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
> > > +{
> > > +	struct pci_dev *parent = bus->self;
> > > +
> > > +	if (dev->liveupdate.preserve_bus_numbers)
> > > +		return true;
> > > +
> > > +	if (parent && parent->liveupdate.preserve_bus_numbers) {
> > > +		/*
> > > +		 * Preserve bus numbers if the parent bridge is required to
> > > +		 * preserve bus numbers. Otherwise the PCI core could expand
> > > +		 * this bridge's reservation beyond its parent (which cannot
> > > +		 * expand).
> > > +		 */
> > > +		dev->liveupdate.preserve_bus_numbers = true;
> > > +	} else {
> > > +		/*
> > > +		 * Otherwise preserve bus numbers if there are any incoming
> > > +		 * preserved devices. This ensures that the PCI core does not
> > > +		 * allocate a bus number to a non-preserved device that
> > > +		 * conflicts with the bus number already assigned to a preserved
> > > +		 * device.
> > > +		 *
> > > +		 * This is slightly more restrictive than it needs to be. For
> > > +		 * example, each host bridges have their own range of bus
> > > +		 * numbers that won't conflict with other host bridges. But the
> > > +		 * previous kernel should have assigned a sane bus topology and
> > > +		 * it is simpler to just adopt that entire topology.
> > > +		 */
> > > +		dev->liveupdate.preserve_bus_numbers =
> > > +			pci_has_incoming_preserved_devices();
> > > +	}
> > > +
> > > +	return dev->liveupdate.preserve_bus_numbers;
> > 
> > I'm not sure why you don't just return
> > pci_has_incoming_preserved_devices() in all cases, which is what the
> > commit log suggests this patch does.  What's gained by all the logic
> > here?  It's not like devices will be hot-added during the kexec.
> 
> To protect against pci_has_incoming_preserved_devices() flipping from
> true to false while the PCI core is in the middle of a scan. It is not
> likely to ever happen given most host bridge scanning should happen
> during early boot, but theoretically possible with the way the PCI core
> code is structured. I did not see way to structurally ensure these 2
> things cannot race. A lot of the host bridge scanning happens without
> taking the rescan lock, for example.

After working on this more, I do see a way to simplify the logic in
pci_liveupdate_preserve_bus_numbers().

pci_liveupdate_preserve_bus_numbers() is used in 2 places during
scanning. First to decide if the PCI core should preserve bus numbers or
is free to allocate new ones, and second to decide if the PCI core is
allowed to assign bus numbers to bridges that are missing bus numbers.

The latter case should never happen during initial scanning unless a
bridge was somehow reset during the kexec, but could legitimately happen
if a bridge is later hot-plugged and I did not want Live Update to
unnecessarily break that scenario. But then that creates this problem
where pci_has_incoming_preserved_devices() can suddenly flip from true
to false at any time and I needed all the complex logic to keep it
consistent for a given scan.

Instead we can split the handling of these cases:

 1. When the PCI core needs to decide if it should preserve bus numbers
    due to Live Update, pci_liveupdate_preserve_bus_numbers() can return
    true forever if any device was preserved by the previous kernel,
    which simplifies the logic.

 2. Then to handle the case of a bridge is enumerated that does not have
    bus numbers assigned, we can handle that separately. If we reorder this
    with the next commit so the PCI core knows exactly which bridges have
    preserved downstream endpoints, then it is possible to determine if it
    is safe for the PCI core to allow bus numbers to be assigned to an
    unconfigured bridge.

After re-ordering, we can end up with something like this:

  bool pci_liveupdate_preserve_bus_numbers(void)
  {
  	return pci_liveupdate.had_incoming;
  }

  bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
  {
  	struct pci_dev *bridge;

  	for_each_pci_bridge(bridge, bus) {
  		if (!bridge->liveupdate.was_incoming || bridge->subordinate)
  			continue;

  		pci_err(dev, "Not assigning bus numbers, preserved bridge %s lost its bus number configuration\n",
  			pci_name(bridge));
  		return true;
  	}

  	return false;
  }

The net effect on pci_scan_bridge_extend() is:

  bool preserve_bus_numbers = !pcibios_assign_all_busses() ||
  			    pci_liveupdate_preserve_bus_numbers();
  ...
  	if (pci_liveupdate_refuse_bus_numbers(bus, dev))
  		goto out;

We could further scope pci_liveupdate_preserve_bus_numbers() to only
return true for host bridges with preserved endpoints downstream, but
that doesn't seem worth the extra complexity. It also seems nice to keep
the pci_liveupdate_preserve_bus_numbers() policy global to match how the
existing pcibios_assign_all_busses() policy is global.

Does that look reasonable?
