Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F4330305
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755319; cv=none; b=PkiHwll9Od3PoI/WoC4jViOJPp2169m7mFf93EN9qXD5Q3XlBaKeELGkTOw6jkn516yplYjv7r4EIRXXDJe9LrLuKWAM5mKKa8ryKmf5gwE3D+HWyg+B9tAzBYImoxSziVXOHs0ZhFmvwk4AETrsNuaFWNULVkt09Ya5AvWNW2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755319; c=relaxed/simple;
	bh=YEVIMhQFW7NGkAzsnnW+1yL6oU0mCbPehfD2Nn5+qD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0DO+CUJ0Otp7qRZY/PCI+E0oGKuCmkd8ULZUp6s//2jw4cIBTLFSwIR3178dkz+6sn2NdOLizxzp/QSH+A5qOyVRKNg49MTXpUkCnYb/XspoE4Ytlx3Zz2RAWBt4NacAwS32gjuiDuIkqaL3zvERE7DNs7kqn9yxlSSCCm31Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtRvC54S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtRvC54S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC0CC116C6;
	Tue, 10 Feb 2026 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770755319;
	bh=YEVIMhQFW7NGkAzsnnW+1yL6oU0mCbPehfD2Nn5+qD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MtRvC54SpjLTv1xjizCj5q0zkchGHILsnxsFMJ8N0mMGDxw9fqCrN8lpmg/VxPZ+e
	 EMNi/0gCNDuDw0JfJkFll8JCTBdtVDmSzJV4FO6Oy7PicpKG1xT3VydPPbWOl1TPhS
	 H5rL4JNpb3LzZLjpVOrhd9DgFzwY3uHsza3cAsn9SduqM9PXyrgaOvjTPgjt3Tknc7
	 v9KM9f61zjTt++W7yGCdBsDnwomjdJ76+x9V1fmQTe3DcN5JjPdMhCGz/91jcQPVY/
	 97Z/g7Vbxxbfh1tjzgLGgZlUqutfjzQ2jRR5bQghoa9ZdFOzbuaQxaY4MYIHK1mdnq
	 uW73Ay0pAYcMQ==
Date: Tue, 10 Feb 2026 13:28:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: dan.j.williams@intel.com
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	helgaas@kernel.org, alex@shazbot.org, lukas@wunner.de,
	guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv3 2/4] pci: allow all bus devices to use the same slot
Message-ID: <aYuU9eI28ubuC9sD@kbusch-mbp>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-3-kbusch@meta.com>
 <698b8e7894eb4_2e5710078@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698b8e7894eb4_2e5710078@dwillia2-mobl4.notmuch>

On Tue, Feb 10, 2026 at 12:00:56PM -0800, dan.j.williams@intel.com wrote:
> Keith Busch wrote:
> 
> > this new feature is 0xfe. This will not clash with any actual slot
> > number since they are limited to 5 bits.
> 
> Can you say a bit more about why other hotplug controller drivers can
> continue to get away with a single device number as a hotplug slot
> target?  For example, would you expect that the ACPI hotplug driver is
> broken if an ARI device is added?

Right, I don't think acpiphp would work correctly for such a device. I
didn't change that out an abundance of caution to not introduce
regressions to platforms I can't readily test.

I've limited this patch to pciehp since that's the only hotplug driver
that hard-codes the "devnr" value to 0, and ensures there's only one
pciehp "hotplug_slot" per bridge. pciehp is uniquely clear that this
patch is safe.

The remaining hotplug_slot users derive devnr and can make additional
hotplug_slots for each device on the bus, so I can't tell if it is safe
to make the others subscribe to this proposed behavior.

> It looks like the goal of this sentinel is to turn all
> pci_try_reset_slot() into pci_try_reset_bus() only for the native PCIe
> hotplug controller, or did I miss a detail?

Yes, pretty much that. Since every device on the subordinate bus belongs
to the same pciehp slot now, we'll get the same locking, notification,
and state restore as what pci_try_reset_bus() does.
 
> > @@ -41,6 +41,10 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
> >  		return sysfs_emit(buf, "%04x:%02x\n",
> >  				  pci_domain_nr(slot->bus),
> >  				  slot->bus->number);
> > +	if (slot->number == PCI_SLOT_ALL_DEVICES)
> > +		return sysfs_emit(buf, "%04x:%02x:00\n",
> > +				  pci_domain_nr(slot->bus),
> > +				  slot->bus->number);
> 
> Why not treat the PCI_SLOT_ALL_DEVICES case the same as the 0xff case?

Just preserving backward compatibility with what this file would show
for pciehp slots prior to this patch.
