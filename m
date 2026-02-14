Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8486337;
	Sat, 14 Feb 2026 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771082427; cv=none; b=MmtxO/liB6EryncoQeHMxtVEC3k2zYLCdhgUFr+76OVOtXmNRjojtkzD1JSZedUCb+xQXcoFq9w17z23QZe2YFiCtcoEkUdVSn/vVApRNsU/bX7cG+cL/Ko+8+gQLtOf0RYz9Hlk9rhNnKhPB/FEppBYhmvF42UPY/WF+FUHPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771082427; c=relaxed/simple;
	bh=vy00+TBp5wiHhmpTQfHFaG3HgHDUjc2AyqtvglDYlbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddzzapuey4BBBtB2hNVLz6aYFw+VKXQBLYYCnG5cY+WQizvSOL/t/ZX/580WsOxcjtnMED4ElbTH1n/kExPt4k+AGLjN9bQoRRiKaVByfc/hBgz6XrJRZQyz0fQ/YeP5+ZCOSe+SRR3AscDEKNfEgrwZLdRibSk+QMNmSEuyE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5AC932008011;
	Sat, 14 Feb 2026 16:11:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 470F13D042; Sat, 14 Feb 2026 16:11:47 +0100 (CET)
Date: Sat, 14 Feb 2026 16:11:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <aZCQsyL9RRessjMI@wunner.de>
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aZAPqQTiGQiDvX52@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZAPqQTiGQiDvX52@wunner.de>

On Sat, Feb 14, 2026 at 07:01:13AM +0100, Lukas Wunner wrote:
> On Fri, Feb 13, 2026 at 03:14:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
> > update PME status registers (PME Status and PME Requester_ID in the
> > Root Status register) during D3hot to D0 transitions, even though PME
> > interrupts are delivered correctly.
> 
> Hm, so in theory we could amend the PME driver to walk the bus below the
> Root Port and see if anything has PME_Status set in the PMCSR register.
> 
> But the PME interrupt is shared with hotplug, bandwidth control etc,
> so we'd end up gratuitouly (and frequently) runtime resuming switches
> below the Root Port to see if there's anything below which is requesting
> wakeup.
> 
> So just keeping the Root Port runtime resumed all the time, as this
> patch does, is still a better approach IMO.
> 
> I'm wondering though if this causes a power regression.  Does keeping
> the Root Port in D0 prevent the Package from entering a lower power
> state?  Or is this irrelevant because the PCH is a different chip
> or tile?

I've just realized that pcie_disable_interrupt() isn't called from
pciehp_suspend() if pme_is_native() is true.  Should disabling
runtime PM cause a power regression, an alternative solution may be
to make pcie_disable_interrupt() conditional on a new pme_is_broken()
which checks for affected Catlow Lake PCH Root Ports.

The pm_runtime_disable() approach is slightly preferred because
it keeps pciehp code clean.

Thanks,

Lukas
