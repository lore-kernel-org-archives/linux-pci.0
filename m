Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08441F346;
	Wed, 23 Sep 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186746; cv=none; b=KYBfrM/nKZNEiSFCXYlXruUw9k9uKUIHiYck/LFy0LXQnLbI1BP5pR3kF802m1kWneVXN21IHSZbARTZELGeE5PBD1kM4V4SypHfGbjomtfwJhp47C1qWB0i93MftuKuNfWUMgTl4n32HUP/wlille5WFBYzQ2M1Y7pfMLx3HuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186746; c=relaxed/simple;
	bh=8WXsQJSj+q5ed5fpNXNcq7r7vWPOOud5m2cwjZhsFG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KdkO3+4Ffr6PoPxDSeHKHTrrOOYWyU4Q5pWdiq4oVQwVoZ9kQNREr5Ic9nIUGfYK7bpka0uzhzHsqNeH2w1CL99zvRPWeR78PnYpswpPJDFSwlTDR3sB5HVHbacuYncVj8fc9JmzL3vGmuCCKnDpO1KO3qTyvlNO0HzrLKYieBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmtLM1Xu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmtLM1Xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88CB1F000FF;
	Wed, 23 Sep 2026 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790186745;
	bh=MrsQprWvZDwjFr3y2ZcgkvbrEea4jAcmzV26nF6XxKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DmtLM1Xu4dsHuCSbO7Krc7Lzu9BiBsFGudKMRXtLe9CFENFaZDV9Mc7uS88RJQyRK
	 n1PwQBHi7rT6ACQtwQPjgYRRV7t5ULwDLGCkiWkMP9sgTEZdO/ZZaqUjHUwXdL9TC5
	 GDa8BMg3zqe3VgL5GiTyNZEX+/OM12PbZ/o+jakg38IVnU4+98NarxCW7cqun0n9bq
	 e2UKslRXjuzTB+VBSNgOMeeVswhUGoJwNA2jbhREdH9Q5htG1WKpCAb5LIwVnaHV04
	 1nLTOlfJz83c28eAtCx+xjFt9PvClQJCLbOPeMCDQCy/tmiE23d9mjG7f1c0s/Nr8N
	 ythvuLckLp9OQ==
Date: Wed, 23 Sep 2026 13:05:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	david.laight.linux@gmail.com,
	John Smith <imjohnsmith4000@gmail.com>,
	Lennert Buytenhek <kernel@wantstofly.org>,
	Roland Waltersson <roland.waltersson@netinsight.net>,
	Mikael Etienne <mikael1022bzh@gmail.com>,
	Arthur Husband <artmoty@gmail.com>,
	Alvin Lim <alvinwylim@gmail.com>
Subject: Re: [PATCH v2 1/2] x86/PCI: Disable enhanced atomics on some AMD
 PCIe ports
Message-ID: <20260923180543.GA1874684@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04147d52-58d3-49c6-9d93-ce9e63beed35@amd.com>

On Wed, Sep 23, 2026 at 12:30:59PM -0500, Mario Limonciello wrote:
> On 9/23/26 12:12, Bjorn Helgaas wrote:
> > On Tue, Sep 08, 2026 at 02:05:59PM -0500, Mario Limonciello wrote:
> > > There have been multiple reports of data corruption that can occur
> > > with 64-bit DMA when the IOMMU is enabled. This occurs due to some
> > > BIOSes enabling enhanced atomic operations on PCIe ports.
> > > 
> > > When enhanced atomic operations are enabled on PCIe ports for some
> > > models, data corruption occurs when the 32-bit IOVA space is exhausted.
> > > The problem is reported on storage devices, but can affect any device
> > > that uses 64 bit DMA.
> > > 
> > > Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.
> > 
> > Can this issue happen without IOMMU?  Devices can do 64-bit DMA even
> > without an IOMMU being enabled.
> 
> Yes; it can technically happen without IOMMU enabled as well.
> 
> The issue happens in NBIO /before/ IOMMU decodes it.
> 
> > When I asked Gemini to explain this, it suggested that "enhanced
> > atomics" is an AMD NBIO feature that translates PCIe AtomicOps into
> > native Infinity Fabric atomic transactions.  But I guess the issue
> > affects any DMA above 4GB, not just AtomicOps, right?
> 
> That explanation isn't 100% correct.  Yes; it is an NBIO feature, but the
> issue is related with how some devices interact with the upper bits of MWr64
> TLPs.
> 
> This feature should not be enabled on any ports on these SoCs being quirked.

What do you think of the log below?  Since it can happen without
IOMMU, I think it's better to omit it so people don't think disabling
the IOMMU is a workaround.

  x86/PCI: Disable enhanced atomics on AMD NBIO 7.7 and 7.11

  Multiple users report data corruption during 64-bit DMA transfers on
  systems with AMD NBIO 7.7 and 7.11 controllers.

  This occurs when BIOS enables AMD "enhanced atomic operations" on PCIe Root
  Ports. When enhanced atomics are enabled, any 64-bit DMA access may be
  corrupted.

  Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.


> > > Cc: david.laight.linux@gmail.com
> > > Cc: John Smith <imjohnsmith4000@gmail.com>
> > > Cc: Lennert Buytenhek <kernel@wantstofly.org>
> > > Cc: Niklas Cassel <cassel@kernel.org>
> > > Cc: Roland Waltersson <roland.waltersson@netinsight.net>
> > > Reported-by: Mikael Etienne <mikael1022bzh@gmail.com>
> > > Closes: https://lore.kernel.org/all/178789300872.392066.15963676631650361573@gmail.com/
> > > Reported-by: Arthur Husband <artmoty@gmail.com>
> > > Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@gmail.com/
> > > Reported-by: Alvin Lim <alvinwylim@gmail.com>
> > > Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v2:
> > >   * Apply to suspend/resume as well.
> > > ---
> > >   arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 99 insertions(+)
> > > 
> > > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > > index b301c6c8df753..79e4338e4b876 100644
> > > --- a/arch/x86/pci/fixup.c
> > > +++ b/arch/x86/pci/fixup.c
> > > @@ -886,6 +886,105 @@ static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
> > >   	}
> > >   }
> > >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
> > > +
> > > +/*
> > > + * Enhanced atomic operations can cause corruption with 64-bit IOVA
> > > + * on these devices.
> > > + */
> > > +#define RX_ENH_ATOMIC_EN		BIT(8)
> > > +
> > > +static const u32 nbio_7_7_pcie_smn_addrs[] = {
> > > +	0x111401d0,
> > > +	0x111411d0,
> > > +	0x111421d0,
> > > +	0x111431d0,
> > > +	0x111441d0,
> > > +	0x112401d0,
> > > +	0x112411d0,
> > > +	0x112421d0,
> > > +	0x112431d0,
> > > +	0x112441d0,
> > > +	0x112451d0,
> > > +	0x113401d0,
> > > +	0x114401d0,
> > > +};
> > > +
> > > +static const u32 nbio_7_11_pcie_smn_addrs[] = {
> > > +	0x112401d0,
> > > +	0x112411d0,
> > > +	0x112421d0,
> > > +	0x112431d0,
> > > +	0x112441d0,
> > > +	0x112451d0,
> > > +	0x113401d0,
> > > +	0x113411d0,
> > > +	0x113421d0,
> > > +	0x113431d0,
> > > +	0x113441d0,
> > > +	0x113451d0,
> > > +};
> > > +
> > > +static void quirk_amd_nbio_enhanced_atomic(struct pci_dev *host_bridge,
> > > +					   const u32 *smn_addrs,
> > > +					   size_t nr_smn_addrs)
> > > +{
> > > +	bool changed = false;
> > > +	size_t i;
> > > +	u32 data;
> > > +	int ret;
> > > +
> > > +	for (i = 0; i < nr_smn_addrs; i++) {
> > > +		ret = amd_smn_read(0, smn_addrs[i], &data);
> > > +		if (ret)
> > > +			continue;
> > > +		if (!(data & RX_ENH_ATOMIC_EN))
> > > +			continue;
> > > +		data = data & ~RX_ENH_ATOMIC_EN;
> > > +		ret = amd_smn_write(0, smn_addrs[i], data);
> > > +		if (ret)
> > > +			continue;
> > > +		if (changed)
> > > +			continue;
> > > +		ret = amd_smn_read(0, smn_addrs[i], &data);
> > > +		if (ret)
> > > +			continue;
> > > +		if (data & RX_ENH_ATOMIC_EN)
> > > +			continue;
> > > +		changed = true;
> > > +	}
> > > +
> > > +	if (changed)
> > > +		pci_info(host_bridge, "enhanced atomics disabled\n");
> > > +}
> > > +
> > > +static void quirk_amd_nbio_7_7_disable_enhanced_atomic(struct pci_dev *dev)
> > > +{
> > > +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_7_pcie_smn_addrs,
> > > +				       ARRAY_SIZE(nbio_7_7_pcie_smn_addrs));
> > > +}
> > > +
> > > +static void quirk_amd_nbio_7_11_disable_enhanced_atomic(struct pci_dev *dev)
> > > +{
> > > +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_11_pcie_smn_addrs,
> > > +				       ARRAY_SIZE(nbio_7_11_pcie_smn_addrs));
> > > +}
> > > +
> > > +/* Phoenix, Hawk Point (NBIO 7.7) */
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
> > > +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
> > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14E8,
> > > +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
> > > +
> > > +/* Strix, Krackan, Strix Halo (NBIO 7.11) */
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
> > > +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1507,
> > > +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
> > > +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1122,
> > > +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> > > +
> > >   #endif
> > >   /*
> > > -- 
> > > 2.43.0
> > > 
> 
