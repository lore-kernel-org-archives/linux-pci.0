Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2701FC8
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770768735; cv=none; b=kVO+JgfPFGsB6Gd7rWKYDtpXMpzy5XF9VVeoub+eYs5woX67hvWN3EZRJ43CPbGf+4sqIxN/Xh7RA8sOplRkEcJ9T12pL37uvS0nHbXiAdSweVmnVA0BLD2AfNMY00sLqo3qDXk5aD9A8hrc+tENziGyhzoL/nDkfiZCeeXe3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770768735; c=relaxed/simple;
	bh=gsN/WvXb8Dtdw3j6xadx7TPga6Q91DEmcpcB6wzBinA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5gT1cjpumaPsWoqQ1MeF1uVoAs/ubyr4Y+fTU0C+i2NlSvsRn2eMjnyAAe7FOM2T7TOTjQAQyKjTCLzl+5TGHChJSx4Z3zFZKql4RFn8lo8PrvEPNNY1gQ960Mk8dj0qlBudswWeSkCuJmfXgc/u4pPjjWqZPGZN3ok2XGWqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI0bxdgg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI0bxdgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138E3C116C6;
	Wed, 11 Feb 2026 00:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770768735;
	bh=gsN/WvXb8Dtdw3j6xadx7TPga6Q91DEmcpcB6wzBinA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eI0bxdggr83grMtl5t8P6lcXq8U3ff7jE91RpdLuhWWqB5W7vfgx6O00Q3eIvHGBf
	 YB34Ng3H90R1KpobAkNPH9mic4Dm3Md9xaRP4TwgEd8GSTpD8S2LNA5pnOGrbZXysM
	 VeKrqa5K7owaiAHx+57ek4I1PyKaoAYcZ0cL15ynM5zi7n+SEOigh5xI9QuW9J016L
	 Ux0ap1CziB8ZCJSRlzd2UgMEGpDYczbuGWO/m5RoeK1DkW9S06AhqJ9JMdY8W4CoJD
	 DlPPQO36CXE9RxfB+65QP/ywYZ6ffLMOenD27lTI/vKUJUXm49jPHrZ5MZLmtqe9FD
	 3O/wQB1bp896A==
Date: Tue, 10 Feb 2026 17:12:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	helgaas@kernel.org, lukas@wunner.de, dan.j.williams@intel.com,
	guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv3 3/4] pci: remove slot specific lock/unlock and
 save/restore
Message-ID: <aYvJXRGnsIYVdVUm@kbusch-mbp>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-4-kbusch@meta.com>
 <20260210164623.74d38699@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210164623.74d38699@shazbot.org>

On Tue, Feb 10, 2026 at 04:46:23PM -0700, Alex Williamson wrote:
> On Thu, 5 Feb 2026 13:25:32 -0800
> Keith Busch <kbusch@meta.com> wrote:
> 
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
> > PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects
> > every function on every "D", not just the ones with a matching "slot".
> > The slot lock/unlock and save/restore functions, however, are only
> > handling a subset of the functions, breaking the rest.
> 
> So are we deprecating conventional PCI hotplug slots?  

No, this still calls the slot's specific reset callback via
pci_reset_hotplug_slot. The only thing this does is add locking, config
state save/restore, and driver reset prepare/complete calls for the
entire bus rather than matching "slots" on that bus. In the worst case
scenario, this patch has the kernel do a little more work than it needed
to.

> I've always
> understood these to be a subset of the bus, where we find the devices
> sharing the same physical PCI slot by comparing the pci_dev.slot across
> the bus, as done in all the code removed here.  pci_create_slot()
> certainly is not simply a reflection of PCI_SLOT().  

pci_create_slot assigns devices that match PCI_SLOT() of the bus's
devices, so it certainly is a reflection of that, no? The problem is
that PCI_SLOT() macro doesn't actually reflect the true nature of what
devices belong in the slot: the devices in a particular "slot" does not
define the actual blast radius of resetting that "slot".

> Is the error below
> really a reflection that pci_dev.slot isn't carried over to the full
> set of functions?

Correct, the pci slot today in a pciehp hotplug slot is not getting
assigned to all the functions in that slot, so slot resets completely
miss handling those functions, which inevitably break them.
