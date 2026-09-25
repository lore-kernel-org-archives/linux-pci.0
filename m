Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAEC4DAFA3;
	Fri, 25 Sep 2026 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361884; cv=none; b=r8hZPra8bYyhs5aHyBH5w7yuJqt0040XJgS0JbISd+WBB5QLhmzNFSh5ELTQPAQjNiAakgIWE4sTeC1Mw9nliwyA21vrXFE8BN4v1dC+bEzeviUMjKv2jFQLLmJk16yHwhFF38e2TrSpKwOc3OZBRuwdcAFOXs+CMPAN6c2SHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361884; c=relaxed/simple;
	bh=7VCw1wAAfJ7n0XNZwjDmDjF4gVL8vslvCUZd6i30PrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbwuDOzT+jbNUlRYJZmAXXSTkXeAvnofJZ9vuhHfgHEmkvpxLagDThLIjhVdAb18DsZcj0VzQWYzaT/mIsWi1Rqio1qkoKBu5+Q4GAFv8h7XKLVtrHHn1Upfkcx6hSeZ4zNq0MR3wtNb4n0JTZPF5kNCdtATM0wee+ByEXd4zTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 0DED210E4C;
	Fri, 25 Sep 2026 20:35:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E65EA6078B58; Fri, 25 Sep 2026 20:35:40 +0200 (CEST)
Date: Fri, 25 Sep 2026 20:35:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <ara-_IPXV_i90if1@wunner.de>
References: <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>
 <20260326061200.GA3552@black.igk.intel.com>
 <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>
 <20260327111616.GC3552@black.igk.intel.com>
 <633cef07-2991-4ce8-b8c6-6b091deaeb0b@linux.intel.com>
 <20260407070800.GF3552@black.igk.intel.com>
 <bd8e9c59-afd8-48ac-ad54-64abad8bfbd1@linux.intel.com>
 <161e11c7-af4c-4cc7-8ad5-a5901f231d54@linux.intel.com>
 <20260925051922.GU106095@black.igk.intel.com>
 <c5754240-1768-44a2-869c-6b159fd54907@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5754240-1768-44a2-869c-6b159fd54907@linux.intel.com>

On Fri, Sep 25, 2026 at 10:38:08AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Once the port is in D3hot, pciehp has cleared HPIE and depends on PME.
> That is where Catlow breaks. The PME interrupt arrives, but PME Status in
> Root Status is never set. pcie_pme_irq() returns IRQ_NONE, the port stays
> in D3hot and the hot-add event is lost.

If a device below the Root Port (instead of the Root Port itself)
signals PME, does the Root Port misbehave in the same way?
I.e. is the PME Status bit clear in that case as well?

If so, the proper solution might be to add a quirk to the PME driver,
not the PCIe hotplug driver.

pcie_pme_irq() checks PME Status and bails out if it's not set.
That would need an amendment such that Root Ports with broken PME
would always assume it's set if they receive a PME.  I think that
would be safe because even though PME is shared with other interrupts
such as hotplug, I think it's the only interrupt source once the port
is in D3hot.

There's another check for PME Status in pcie_pme_work_fn().
This one is tricky because it uses the PME Status bit to jump
out of the for-loop.  Does the Root Port at least set the
Requester ID to an appropriate value?  If so maybe that can be
used as an indicator whether the loop should be terminated.

Or maybe the PME Pending bit can be used in lieu of PME Status?

Thanks,

Lukas
