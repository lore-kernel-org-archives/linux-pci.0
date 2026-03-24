Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5643147;
	Tue, 24 Mar 2026 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774395994; cv=none; b=nBWs+AKmWqlUNv7ux09z2jSWOkID/JFvUHl+52+PyXGvVyeMYDOxzt1knwAAV7TRApIwOEo7Gmu3aLIhKMOJU1eEAzS0EH4fuWZKVrIL6srCa+pXNcssRhNMSrV9qARLlaDsyzTEUbW78GSUDr2N58uy6mEz4n9E28552wtyqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774395994; c=relaxed/simple;
	bh=rHKn8cGTgDOUNqf7Jwz1D4ap7UnfSGX0411eXRcgkVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dfVY9kG8nd3GzDHhDR2rJnO2AwCV1QfFA1shJa7U4fvNM8xLlGFQ816h6884hNriRo/mf6Oh407+PWcVidGDnXwwgcbQrgYlY+ySMIz1ToDn1FgGDwwMihnmNaae4cRXk1HEpBTGTYFUUIpFhYuUaSGMBuy4Xd0uaG69VcQG64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mc2KPmw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc2KPmw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275B3C19424;
	Tue, 24 Mar 2026 23:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774395994;
	bh=rHKn8cGTgDOUNqf7Jwz1D4ap7UnfSGX0411eXRcgkVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mc2KPmw5o6+KffewdJb0bX6DyDSnqRrxB6n9DxL5S+eO7Ob8VBObn2GNHs13FeEb/
	 dTndCW/HE1Afu3cAUMuhQYRiM8FBZW2Jm7s5CX2Eb/bwAZbiVQKXgjlB5tpdgr9VWQ
	 DDlxnQoi25lC1IfGkHKSxbAoXtQX+v+MGUdnaSIyEWfhDDsOQqbI3pn06mdlqIUK2e
	 iE9URDYa4feJAr0A78xHl3861dRiKhKIejA1q4pMmvLepQz4ykJXVLc4Bob4ZzSbX3
	 HdWNc3uShWlhAYM8cahGQEiQyoOV1NTF1jWzQ3K1ZhQWFGb5IvP67HF6MXM+AcR7ON
	 vrrhOJ+SY/+bQ==
Date: Tue, 24 Mar 2026 18:46:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <20260324234632.GA1164233@bhelgaas>
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
> > On Mon, Mar 16, 2026 at 03:08:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
> >> update PME status registers (PME Status and PME Requester_ID in the
> >> Root Status register) during D3hot to D0 transitions, even though PME
> >> interrupts are delivered correctly.
> > 
> > IIUC, the Root Status update should happen on receipt of a PME Message
> > and is not directly related to a D3hot to D0 transition (PCIe r7.0,
> > sec 6.1.6).
> 
> You're correct. PME status register updates occur on PME Message
> reception, not during power state transitions.
> 
> I used "D3hot to D0 transitions" as shorthand for the full sequence: port
> in D3hot detects hotplug event -> generates PME Message -> should update
> Root Status -> PME interrupt -> port wakes to D0.
> 
> On Catlow Lake, the PME interrupt is delivered but the Root Status
> registers (PME_Status and PME_Requester_ID) are not updated when the port
> generates these PME Messages. This causes pcie_pme_irq() to return
> IRQ_NONE, leaving the port in D3hot.
> 
> I'll clarify the commit message to avoid this misleading shorthand.
> Something like below:
> 
> On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
> update PME status registers (PME Status and PME Requester_ID in the
> Root Status register) when receiving PME Messages while in D3hot state,
> even though PME interrupts are delivered correctly

Seems OK if Catlow updates PME Status and PME Requester_ID when it's
*not* in D3hot.  If Catlow *never* updates those registers, I'd drop
the reference to D3hot.

> >> This issue manifests during PCIe hotplug operations as follows:
> >>
> >> 1. After a hot-remove event, the PCIe port runtime suspends to D3hot.
> >>    pciehp_suspend() disables hotplug interrupts (HPIE) to rely on
> >>    PME-based wakeup.
> > 
> > Didn't we rely on PME interrupts anyway, independent of HPIE?
> 
> I don't think they are independent. If HPIE is enabled, hotplug interrupt
> will be triggered as direct interrupt and we don't have to reply on PME
> for wakeup.

I'm trying to figure out the difference between hotplug interrupts and
PME interrupts.  It seems like they should be separable, but this
patch and eb34da60edee seem to conflate them somehow.

AFAICT, pme.c always relies on PME interrupts, not on HPIE.  And
pciehp depends on HPIE interrupts, not on PME interrupts.

Oooh, I think I see -- I forgot that PME and HPIE share the same
interrupt (sec 6.7.3.4).  So I suppose PCI_EXP_SLTSTA_DLLSC looks like
a spurious PME interrupt to pme.c.  Please mention this in the commit
log somehow to remind me when I forget this again.

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

This apparent behavior difference (some machines have spurious
wakeups, maybe because some trigger PCI_EXP_SLTSTA_DLLSC and others
don't?) is what makes me a little queasy because we don't rely on
anything solid to tell the difference.

> Mika, any comments?
> 
> >> 2. When a hot-add occurs while the port is in D3hot, a PME interrupt
> >>    fires as expected to wake the port.
> > 
> > Why is a PME interrupt expected here?  I would expect a hot-add to
> > cause a PCI_EXP_SLTSTA_PDC or PCI_EXP_SLTSTA_DLLSC interrupt.  Sec
> > 6.1.6 suggests PME interrupts are only from Root Ports.
> > 
> >> 3. However, the PME interrupt handler finds the PME_Status and
> >>    PME_Requester_ID registers unpopulated, preventing identification
> >>    of which device triggered the PME. The handler returns IRQ_NONE,
> >>    leaving the port in D3hot.
> > 
> > I guess this is pcie_pme_irq(), and it finds PCI_EXP_RTSTA_PME clear
> > because of this Catlow defect?  It looks like it returns without even
> > looking at PME_Requester_ID.
> 
> Yes, it returns after checking for PCI_EXP_RTSTA_PME. I tried modifying
> it to proceed without the status check, but it still failed when reading
> PME_Requester_ID (also not updated). So I mentioned both registers.

Not a big deal; it's a little harder to correlate the commit log that
mentions PME_Requester_ID with the current code that doesn't look at
it.

> > Sec 5.3.3.1 suggests that the purpose of PME_Requester_ID is to
> > facilitate quicker PME service and shorter resume time.  So maybe the
> > lack of PME_Requester_ID should only be a performance issue, not a
> > functional problem?
> > 
> > If we know we got a PME interrupt, and we can wake up (maybe more
> > slowly without a Requester ID), why can't we just do the wakeup
> > independent of PCI_EXP_RTSTA_PME and PCI_EXP_RTSTA_PME_RQ_ID?  Are
> > spurious PME interrupts a problem?
> 
> Yes, I think we can call pcie_pme_walk_bus() even when PCI_EXP_RTSTA_PME
> is clear for ports with the quirk. This would work but be slower without
> the Requester_ID hint.

I don't care at all about the performance for a non-compliant device.
IMO simplicity of the code is way more important, and pme_is_broken()
is in a pretty visible place.
