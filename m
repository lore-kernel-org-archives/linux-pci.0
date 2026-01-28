Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C013093BC
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769630106; cv=none; b=sy5fHryX8uq1j8nig2BigzMA3se72jgthYKJDiugKKw3gI/aEWQWU7olx6zXgUSNhCBk3ZXPcBdhSBBK3hpXypvH8HDEl4/G6UEkIPbdjKHjsTvGD07Y2UEBa6BFgQlOh9kvIQDSPuSnI0CXYkOA9Kon/k4bfW/sn3HUCk2u1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769630106; c=relaxed/simple;
	bh=F6X3cLwcjUOEy1eq/WDWg+g952rHcUctN0/duhVg8pk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VEca+/zZY/4A2SM/D1KA7vIxtAKFdDEyOIwnmd1BgUGLDbNMTOFR6E876YBAs9DXKZXo4l3mv0qG1ZlHYmMmuTNIZLRwp2FZA3l4O02uef9ZbQgU8Ljyfy+sMffH5R9mKbMaNkULAAd7iH2kZmHWKEn/oV0KS/xSAt3LoA/iVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCJRHZiw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCJRHZiw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769630105; x=1801166105;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F6X3cLwcjUOEy1eq/WDWg+g952rHcUctN0/duhVg8pk=;
  b=QCJRHZiwAE17aj5pYVxehILzmKdRvfnlwIYHKrz4O5CUGci51VRBTO8d
   VVTuDTPFUk0PSvPgu7CKMG6d9o6FQcK8nJKCf8U4txaMAJumaBCGERJ1c
   M1/aYdna64t06gk4BiDm0/wn2FWisV8O3mlJBsHuILy/rsMdvkwg8U+1Q
   luqk7m4kge5aazM8fs6gKXEUUwWBmJi5egc5IBXyyOFIe/2lOE9Seug3j
   cfZ74YlDk6GmlAuU2SDBpN0tGq8NDmUzuOb5b8PmWeqNAqFCCAAIxM00v
   1Gibqi3KJmUt2JxELEm30qyjaqzbXikqMYbKlztODsv7d729Q1zAQZJbU
   Q==;
X-CSE-ConnectionGUID: +ScQWX4LSzCxLrGYcSmFlw==
X-CSE-MsgGUID: Vidl5mMwToOapV8OoBU3FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81583754"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81583754"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 11:55:04 -0800
X-CSE-ConnectionGUID: nmDNim3CTa2/HeCzDSh0Mg==
X-CSE-MsgGUID: sT69reg9Qv++umoNlZpvNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207958279"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 11:55:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 Jan 2026 21:54:58 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org, 
    bhelgaas@google.com, alex@shazbot.org, Lukas Wunner <lukas@wunner.de>, 
    Keith Busch <kbusch@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
    Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH 2/2] pci: fix slot reset device locking
In-Reply-To: <20260128180338.GA423654@bhelgaas>
Message-ID: <aa3866ec-79d6-8eea-ca2c-8890a4c2b3bd@linux.intel.com>
References: <20260128180338.GA423654@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Jan 2026, Bjorn Helgaas wrote:

> [+cc Dan, Jinhui]
> 
> On Fri, Jan 16, 2026 at 10:41:50AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
> > prevent the warning:
> 
> I *think* this actually refers to pci_bus_trylock() and
> pci_slot_trylock() (not pci_bus_lock() and pci_slot_lock()), since
> that's what this patch changes?
> 
> It's unfortunate that pci_bus_trylock() and pci_slot_trylock() are so
> similar but separate.  If there were combined, this kind of issue
> where one is fixed but the other isn't wouldn't happen.
> 
> But what about pci_bus_lock() and pci_slot_lock()?  They are also
> almost identical, but pci_bus_lock() locks bus->self while
> pci_slot_lock() does not.  Should it?
>
> All these almost-but-not-quite identical paths make my head hurt ;)

My series does attempt to consolidation them (check the pending patches 
from me).

(It doesn't consider this fix patch though but the other one is taken 
into account, the series was build on top of it).

-- 
 i.

> >   pcieport 0000:e2:05.0: unlocked secondary bus reset via: pciehp_reset_slot+0x55/0xa0
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/pci/pci.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 3378221c5723a..5f8b0d06a1459 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5460,6 +5460,8 @@ static void pci_slot_lock(struct pci_slot *slot)
> >  {
> >  	struct pci_dev *dev;
> >  
> > +	if (slot->bus->self)
> > +		pci_dev_lock(slot->bus->self);
> >  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> >  		if (!dev->slot || dev->slot != slot)
> >  			continue;
> > @@ -5483,12 +5485,17 @@ static void pci_slot_unlock(struct pci_slot *slot)
> >  		else
> >  			pci_dev_unlock(dev);
> >  	}
> > +	if (slot->bus->self)
> > +		pci_dev_unlock(slot->bus->self);
> >  }
> >  
> >  /* Return 1 on successful lock, 0 on contention */
> >  static int pci_slot_trylock(struct pci_slot *slot)
> >  {
> > -	struct pci_dev *dev;
> > +	struct pci_dev *dev, *bridge = slot->bus->self;
> > +
> > +	if (bridge && !pci_dev_trylock(bridge))
> > +		return 0;
> >  
> >  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> >  		if (!dev->slot || dev->slot != slot)
> > @@ -5511,6 +5518,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
> >  		else
> >  			pci_dev_unlock(dev);
> >  	}
> > +
> > +	if (bridge)
> > +		pci_dev_unlock(bridge);
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.47.3
> > 
> 

