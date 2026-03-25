Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F0315D35;
	Wed, 25 Mar 2026 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774418217; cv=none; b=ZwZ0cb7EGNrasUnKyL8whzILfWcscoh0PN7xUC1X1EF5ITb+ut8QVqnQ0zRiywJJDjqrbTs2x3HTpGFnM6n1xpcuD0zZVJlPm9X4/MOXrAF6jOp2GMaNkIBfxJlTQbYkf8S776H/byTnZz9GiLjNx41nTNoKb6ki5IYw8fBI4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774418217; c=relaxed/simple;
	bh=LQOPI3uBo88AEteITLh5ULd4gydt6nfkT8OkHGMAbY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4qedbKeerbiZJHBNg3aXoRZdkn525VcaHKQuQM79jh57EZD3RQOMLPQiwif1FcofN4+TiPmvtmnPbap+/3WNxK4pKbLJ53u9pbeQQ0t9Fz6OAKclSncYC54c1DwL8sTkHKObx9M4MIfDOSSupAG/TPusub5Wjvl84c/s6XUyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 21E4710632;
	Wed, 25 Mar 2026 06:56:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1BF1C6029B60; Wed, 25 Mar 2026 06:56:46 +0100 (CET)
Date: Wed, 25 Mar 2026 06:56:46 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <acN5HorrB31LLjiJ@wunner.de>
References: <20260323232437.GA1085990@bhelgaas>
 <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>

On Tue, Mar 24, 2026 at 02:45:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 3/23/2026 4:24 PM, Bjorn Helgaas wrote:
> > eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
> > cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
> > wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
> > 
> > I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
> > that wakeup.  I would think pciehp should field that, and it should be
> > able to figure out whether to bring the port out of D3hot.
> > 
> > Anyway, with this patch it looks like we'll leave PCI_EXP_SLTCTL_HPIE
> > set, and potentially get that PCI_EXP_SLTSTA_DLLSC interrupt again?
> 
> I have tested this patch on Catlow Lake. Enabling HPIE does not result in
> spurious wakeups as mentioned in Mika's patch.

I believe Mika saw the wakeup issue on a Thunderbolt controller when
going into system sleep.  (In 2018, only discrete controllers existed.
SoC-integrated controllers were introduced a few years later.)

And Catlow Lake is a server PCH or at least derived from server silicon,
right?  Did you test system sleep or just runtime suspend?

> > If we know we got a PME interrupt, and we can wake up (maybe more
> > slowly without a Requester ID), why can't we just do the wakeup
> > independent of PCI_EXP_RTSTA_PME and PCI_EXP_RTSTA_PME_RQ_ID?  Are
> > spurious PME interrupts a problem?
> 
> Yes, I think we can call pcie_pme_walk_bus() even when PCI_EXP_RTSTA_PME
> is clear for ports with the quirk. This would work but be slower without
> the Requester_ID hint.

The problem is, PME not only shares the interrupt with hotplug
(PCIe r7.0 sec 6.7.3.4), but if INTx is used it also shares the
interrupt with link bandwidth management, AER and DPC.  So there's
lots of potential for spurious PME interrupts and I fear waking up
the entire hierarchy below the Root Port on every interrupt may
result in much worse power consumption.

At least Switch Upstream and Downstream Ports below the Root Port
need to be woken to access config space of Endpoints.  With Thunderbolt,
these may be in D3cold and waking them up consumes a non-trivial amount
of time and energy.

As an aside, I note that the code in drivers/pci/pcie/pme.c doesn't
take into account that there may be Switch Upstream and Downstream
Ports between the Root Port and the wakeup-signaling device and
those switch ports may be in D3hot or D3cold.  Which means config space
of the wakeup-signaling device is inaccessible.  pci_check_pme_status()
happens to be written in such a way that if it reads fabricated
"all ones" responses from the device, it assumes that the device
is signaling wakeup.  The final pci_write_config_word() in
pci_check_pme_status() will be lost but there's a call to
pci_enable_wake(pci_dev, PCI_D0, false) upon runtime resume
which makes up for the lost write, so the code happens to work.
Just be aware of pitfalls there...

Thanks,

Lukas
