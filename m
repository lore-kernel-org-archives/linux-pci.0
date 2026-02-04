Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4F1A2389
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244268; cv=none; b=NWTd1KvyAsS68X9Ew6/t2YHUM7Lh78GWelPpEunT5ltnwiaaf1tURQardWMRBtURpHWnCBKn1pbUfhRyyEKFvjcA6xpxfVzq1p1he1+yGEBDxzBOz26tDpBm+Hin9xrCuKrDxOZgmOdLjeMHjDy51BE7S+Cy/a/LVcxrIHF5fb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244268; c=relaxed/simple;
	bh=0bNfNiuvrN6jM37k5xQrBQUiBwhfzDfKI8WXsvZI3UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzQI2u6xAXsfhzrld0aBFbfj92wKk9rbzz7tbokbl8H00ES5cDAw1a/s5sjifgG+JTeS066qCQGftVusMUjXG4lPojxNc37waKsDjvrV29ELrvRc/xhJhIrnz0OFXtEL03x8M/kDXqYcEWugK2QFZDVKO4wxRnapKVtr8DBnI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj+YfyBY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj+YfyBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA8FC4CEF7;
	Wed,  4 Feb 2026 22:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770244268;
	bh=0bNfNiuvrN6jM37k5xQrBQUiBwhfzDfKI8WXsvZI3UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nj+YfyBYTVoY3bIDG1Y1TfNdKSRzNeKUqrh7VdjU6PRL/qnKEuqqNwaPkWQ0GiWqk
	 It3Mbmn+lPUZD2wyZd35gc0q+MV0k7afYAs5WwPHH4duBFTfUhCtff4fStAlN4A/bK
	 KfydBBmOd2F9sXGJUKwCxAKr+UykempIYdTs3fiOG4ZBZuJXSmMbo6fkpO9PHMZrDI
	 gmlm6qEGs8oEOZepQjcWRQfK1z6i+qs2m69scbcf5F5unr8ej8XE3ZRA7BNL6uDaAx
	 +B2Cytv+MDE3j8/f9zHvtQNFEi5rJA3y14/f7VVEh7ZhehBbJL1OBFlH9AouLiYriO
	 7bNHw7PIeIgNQ==
Date: Wed, 4 Feb 2026 15:31:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: dan.j.williams@intel.com
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	helgaas@kernel.org, alex@shazbot.org, lukas@wunner.de,
	guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv2 4/4] pci: make reset_subordinate hotplug safe
Message-ID: <aYPIqfS73JOxL_lu@kbusch-mbp>
References: <20260130165953.751063-1-kbusch@meta.com>
 <20260130165953.751063-5-kbusch@meta.com>
 <697da44e6d895_1d3310085@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697da44e6d895_1d3310085@dwillia2-mobl4.notmuch>

On Fri, Jan 30, 2026 at 10:42:22PM -0800, dan.j.williams@intel.com wrote:
> Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Use the slot reset method when resetting the bridge if the bus contains
> 
> What about some renames to make this easier to read, because it is
> ironic that this says "Use the slot reset method" when the functional
> change is to now start using the __pci_reset_slot() method. If I am
> reading this "slot reset vs reset slot" conversion correctly.

Yep, I thnk you've got the sense of the naming issues here.
 
> Something like:
> 
> s/__pci_reset_slot/pci_try_masked_slot_reset/
> 
> Since it is a conditional reset, and it is masking slot events.
> 
> ...but pulling that string also means:
> 
> s/__pci_reset_bus/pci_try_reset_bus/

Yeah, there are a lot of refactoring opportunities here. My experience
with the pci subsystem, though, is that it is a bit conservative (and
perhaps rightfully so) on accepting refactor churn. 

> > -	mutex_unlock(&pci_slot_mutex);
> > -	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
> > +	return __pci_reset_bridge(bridge, false);
> 
> Similar to how PCI_RESET_{DO_RESET,PROBE} makes the ambiguous
> "true/false" readable, how about adding something like:
> 
> #define PCI_SLOT_RESET_MASKED true
> #define PCI_SLOT_RESET_UNMASKED false

Sure, can do. Not sure I like the existing PROBE vs DO_RESET though. I
think the probe should just open code the checks in its own function
(which already exist) so that the DO_RESET doesn't duplicate literally
every check the preceding PROBE does. But that's a refactoring thing.

> > +	mutex_unlock(&pci_slot_mutex);
> > +
> > +	if (save)
> > +		return __pci_reset_bus(bus);
> > +	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
> 
> Logic looks equivalent in the PCI_SLOT_RESET_UNMASKED case, I think it
> wants a comment that it turns into a "try_reset" when
> PCI_SLOT_RESET_MASKED...
> 
> > +}
> > +
> > +int pci_reset_bridge(struct pci_dev *bridge)
> > +{
> > +	return __pci_reset_bridge(bridge, true);
> > +}
> 
> ...and maybe that comment is helped by naming this helper
> pci_try_reset_bridge()?

Sounds good.
 
> I would want a second opinion on the renames before saying they are
> absolutely required.

Thanks for the reviews. I'll think on this a it and mix in your
suggestions for the next version.

> ...note I did not look at anything beyond the claims in the changelog,
> like potential unwanted knock-on effect from the new masking.

I'm more concerned about the previous patch in this series. I have no
experience with slots that can reset a subset of attached bus devices,
but apparently they exist. Not that it should cause a problem beyond
extra locking and config space access that would't be necessary, which
should just cost a few unnecessary cpu cycles.
