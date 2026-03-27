Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0F348895;
	Fri, 27 Mar 2026 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610185; cv=none; b=E9flIi/giAYbZYTAY1vMdN8CnoN2bmF+acpxJSuvJj4cnvUIY2YyN0LIidtY1ade4d1jO6m1B+QdPv7ngCtMR3Joouhl1OROoG1wXx5I31jCA17YrivFgScmtmLdBbwMhcS6hugr7OhoZLmq5va8CkmizWI3eYBOuVa/BoWm8YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610185; c=relaxed/simple;
	bh=dITTYn31D61hi72T+XQ1efHkmXEWvLF2AXvLqvThnMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcUrcOPBU6M6WoHxYtfu7BcLGFi4czQ2aJ/+kjrdGzBSysj7sd3MXZlfwo9+JtcMPJn1oJX68wtzCjVunyAcywHR0jMc90uFfqfwXc9/Ex5soK5UJd5yR7MNj7WFNe10Zvb45bamzCIiWwv5bCXeDEq8HizCxXF/CNiF+txoH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAdqVlcJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAdqVlcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774610180; x=1806146180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dITTYn31D61hi72T+XQ1efHkmXEWvLF2AXvLqvThnMg=;
  b=fAdqVlcJyNKw73bocszenSkiyDVpmw+dZJ9XUA+09IwwjefyisQ7yDk0
   LFDapvnf1uXxQVZ//hlFqB5wdo65F10gtKubPyxEQWQ5BpixrGpbsJK54
   I3odvq+qXCTCYE55AUT2IK3mEBQfFjgnG0cY3ZhCXY1n8FrKRDual87Xe
   kqQiMk02xJoMcw9djwls1BzCb8bcx044Fun7QHyePh3XjG6emteBIfeM9
   Vxur8c591o+CoYRVmsGZeUWkCUtQVrYTpPz69voOarhDe05dlv8O2ian4
   8lzUCDjIMofvj1qvPrwxWsyqCsGYT2jKyezsVH1Ay8SNcoSfw61UWd8ud
   g==;
X-CSE-ConnectionGUID: KBlGRYltRPuHmbT5N0DJqg==
X-CSE-MsgGUID: AUhebAi8SI6mL8WwK9tnIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79541234"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79541234"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:16:19 -0700
X-CSE-ConnectionGUID: wXBkLUkrQyGrnsWl0Xp5ZA==
X-CSE-MsgGUID: kviLYhDxRqyPe85BXO7KUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="263226033"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 27 Mar 2026 04:16:18 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7B14698; Fri, 27 Mar 2026 12:16:16 +0100 (CET)
Date: Fri, 27 Mar 2026 12:16:16 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <20260327111616.GC3552@black.igk.intel.com>
References: <20260323232437.GA1085990@bhelgaas>
 <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>
 <20260325061131.GY2275908@black.igk.intel.com>
 <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>
 <20260326061200.GA3552@black.igk.intel.com>
 <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>

Hey,

On Thu, Mar 26, 2026 at 02:23:50PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Mika,
> 
> On 3/25/2026 11:12 PM, Mika Westerberg wrote:
> > On Wed, Mar 25, 2026 at 02:12:48PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>
> >>
> >> On 3/24/2026 11:11 PM, Mika Westerberg wrote:
> >>> On Tue, Mar 24, 2026 at 02:45:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>>>> eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
> >>>>> cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
> >>>>> wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
> >>>>>
> >>>>> I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
> >>>>> that wakeup.  I would think pciehp should field that, and it should be
> >>>>> able to figure out whether to bring the port out of D3hot.
> >>>>>
> >>>>> Anyway, with this patch it looks like we'll leave PCI_EXP_SLTCTL_HPIE
> >>>>> set, and potentially get that PCI_EXP_SLTSTA_DLLSC interrupt again?
> >>>>
> >>>> I have tested this patch on Catlow Lake. Enabling HPIE does not result in
> >>>> spurious wakeups as mentioned in Mika's patch.
> >>>>
> >>>> Mika, any comments?
> >>>
> >>> What do you have connected to the slot?
> >>
> >> A network card.
> > 
> > Okay.
> > 
> > Out of interest how do you hotplug it? :)
> 
> We physically remove and insert the card.

Got it.

> >>> IIRC the interrupt triggers when presence change toggles (due to the link
> >>> going down).
> >>>
> >>
> >> I have tested the s3 mode. I was able to see message related to system entering
> >> suspend and then coming back again after (after user intervention). I also noted
> >> pcie_disable_interrupt() called before suspend and pcie_enable_interrupt() called
> >> after resume.
> > 
> > In case of S3 the BIOS also configures the hardware before entering
> > suspend. On client at least it's suspend-to-idle and any interrupt will
> > bring the CPU and the system out of it. It could be that that's the reason
> > you don't see any issue if this is server system and it goes into full S3?
> > 
> 
> Looking at the kernel logs, the system is actually using suspend-to-idle 
> (s2idle), not full S3:
> 
>   PM: suspend entry (s2idle)
> 
> So this is the same suspend mode where you observed the spurious wakeup issue.
> Interestingly, we're not seeing the problem on Catlow Lake with HPIE enabled.
> 
> I am trying to understand the wakeup sequence in your case. IIUC, before the
> system enters suspend, it will put the device and port in D3hot, right? So link
> down should happen before the system goes to sleep or idle. At what point does
> the spurious DLLSC interrupt occur that causes the unwanted wakeup?

I think in case of tunneled PCIe it is presence detect that toggles and
triggers the interrupt if left enabled.

The flow is something like this (from my memory):

1. User enters s2idle.
2. PM core suspends devices.
3. PCI core suspends the devices behind the root port and then the root
   port itself. This makes the root port be in D3hot and the link below it
   is still in L1.
4. PCI/ACPI turns of the power resource attached to the root port. This
   puts the link into L2/3 ready and then PERST# is asserted in which case
   the tunnels are gone and presence detect changes and the link enters L2
   and the root port enters D3cold.

In your case does the root port enter D3cold? Does it have power resource?
Or it stays in D3hot? We should not put any hotplug ports into low power
states if they don't have HotPlugSupportInD3 property as described here:

https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3

There is some BIOS support needed for the D3cold. We have that in client
but I have not been dealing with the server so not familiar how things are
done there. I would think power savings are not that important in big iron.
