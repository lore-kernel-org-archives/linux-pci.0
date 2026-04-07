Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB838945C;
	Tue,  7 Apr 2026 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545685; cv=none; b=apxRdCrevlBv4ltd4Nka1SiDtqqwXx1HQSAvBvBknEwxLTNNKRC/UWinhjvWWAZYXgKuVBFwi8u3/yKFgXkM234UV5zd6Ae9HWST+K/OBdsHnchk8CALtfvu9ha2riX9X0GYKNuzjqQWAFoXQCKSpvYXluBaLBkH29P0OsSQso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545685; c=relaxed/simple;
	bh=YR3EkiIV1wp1OSxtFJEazA7eHFQYSy2cCtHxbX6WW3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uawM5Fgt6hjCzGfHOrKgpgvHb9MHp96GHGNiZwyaeTeMtEhuo1qJmtyGnkQcrSEKR/S+QAkrhtgLX+w44TB8Ji7hBhZOHCevw0pP3EJpgYfJYwbOwYA8E0OpKwauOGh1zsoXrvaTxrx3xyQvH/DkpttmYoju3poZySk4sqaqDCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GePPrqDP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GePPrqDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775545683; x=1807081683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YR3EkiIV1wp1OSxtFJEazA7eHFQYSy2cCtHxbX6WW3E=;
  b=GePPrqDPMkgHqJR66mHN1xBt75AX3XvZLjopRE4RBOWsHIuluq237Tq+
   SPKPHZ9/9kuV912DMPZMdY6oukCvNaaTG1+vhCpSkhWHAuZaa1Urx2CSy
   sqP8hIwUkXqevKt4EY+6I66NVnFDAc29KnDRZqhDJAP4AT/g1atbW+ICE
   Uapq3OxKrkjZqIacDboH0dis8/A4lOKkYSMG5PWqlvVwoOxxexx4W6YP6
   BDPu2+1sFtTBpDdQx5RXol+b71IC1S4Xhmo0JzsCVu0o0hyi73cSYcx/U
   lfBOJnZFbwOc+69mgzA1AcnOF2NShxA10RA6UXMqzq4cof6mP5qWVdwbi
   g==;
X-CSE-ConnectionGUID: fw9lsHxvRLikDPLE3j569Q==
X-CSE-MsgGUID: k1Fm1RLtRTqyWy3s1oE8lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="94081568"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="94081568"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 00:08:03 -0700
X-CSE-ConnectionGUID: 3rJUuB45RMacw3fh4cGwvQ==
X-CSE-MsgGUID: 9b8UN5fNTsmZW6InxEWpEg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2026 00:08:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0FB7E95; Tue, 07 Apr 2026 09:08:00 +0200 (CEST)
Date: Tue, 7 Apr 2026 09:08:00 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <20260407070800.GF3552@black.igk.intel.com>
References: <20260323232437.GA1085990@bhelgaas>
 <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>
 <20260325061131.GY2275908@black.igk.intel.com>
 <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>
 <20260326061200.GA3552@black.igk.intel.com>
 <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>
 <20260327111616.GC3552@black.igk.intel.com>
 <633cef07-2991-4ce8-b8c6-6b091deaeb0b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <633cef07-2991-4ce8-b8c6-6b091deaeb0b@linux.intel.com>

Hi,

On Fri, Apr 03, 2026 at 12:37:39PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Mika,
> 
> On 3/27/2026 4:16 AM, Mika Westerberg wrote:
> > Hey,
> > 
> > On Thu, Mar 26, 2026 at 02:23:50PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> Hi Mika,
> >>
> >> On 3/25/2026 11:12 PM, Mika Westerberg wrote:
> >>> On Wed, Mar 25, 2026 at 02:12:48PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>>>
> >>>>
> >>>> On 3/24/2026 11:11 PM, Mika Westerberg wrote:
> >>>>> On Tue, Mar 24, 2026 at 02:45:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>>>>>> eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
> >>>>>>> cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
> >>>>>>> wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
> >>>>>>>
> >>>>>>> I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
> >>>>>>> that wakeup.  I would think pciehp should field that, and it should be
> >>>>>>> able to figure out whether to bring the port out of D3hot.
> >>>>>>>
> >>>>>>> Anyway, with this patch it looks like we'll leave PCI_EXP_SLTCTL_HPIE
> >>>>>>> set, and potentially get that PCI_EXP_SLTSTA_DLLSC interrupt again?
> >>>>>>
> >>>>>> I have tested this patch on Catlow Lake. Enabling HPIE does not result in
> >>>>>> spurious wakeups as mentioned in Mika's patch.
> >>>>>>
> >>>>>> Mika, any comments?
> >>>>>
> >>>>> What do you have connected to the slot?
> >>>>
> >>>> A network card.
> >>>
> >>> Okay.
> >>>
> >>> Out of interest how do you hotplug it? :)
> >>
> >> We physically remove and insert the card.
> > 
> > Got it.
> > 
> >>>>> IIRC the interrupt triggers when presence change toggles (due to the link
> >>>>> going down).
> >>>>>
> >>>>
> >>>> I have tested the s3 mode. I was able to see message related to system entering
> >>>> suspend and then coming back again after (after user intervention). I also noted
> >>>> pcie_disable_interrupt() called before suspend and pcie_enable_interrupt() called
> >>>> after resume.
> >>>
> >>> In case of S3 the BIOS also configures the hardware before entering
> >>> suspend. On client at least it's suspend-to-idle and any interrupt will
> >>> bring the CPU and the system out of it. It could be that that's the reason
> >>> you don't see any issue if this is server system and it goes into full S3?
> >>>
> >>
> >> Looking at the kernel logs, the system is actually using suspend-to-idle 
> >> (s2idle), not full S3:
> >>
> >>   PM: suspend entry (s2idle)
> >>
> >> So this is the same suspend mode where you observed the spurious wakeup issue.
> >> Interestingly, we're not seeing the problem on Catlow Lake with HPIE enabled.
> >>
> >> I am trying to understand the wakeup sequence in your case. IIUC, before the
> >> system enters suspend, it will put the device and port in D3hot, right? So link
> >> down should happen before the system goes to sleep or idle. At what point does
> >> the spurious DLLSC interrupt occur that causes the unwanted wakeup?
> > 
> > I think in case of tunneled PCIe it is presence detect that toggles and
> > triggers the interrupt if left enabled.
> > 
> > The flow is something like this (from my memory):
> > 
> > 1. User enters s2idle.
> > 2. PM core suspends devices.
> > 3. PCI core suspends the devices behind the root port and then the root
> >    port itself. This makes the root port be in D3hot and the link below it
> >    is still in L1.
> > 4. PCI/ACPI turns of the power resource attached to the root port. This
> >    puts the link into L2/3 ready and then PERST# is asserted in which case
> >    the tunnels are gone and presence detect changes and the link enters L2
> >    and the root port enters D3cold.
> 
> Thanks for the detailed explanation. So the spurious wakeup happens when the
> power resource is turned off during suspend, which triggers the presence detect
> change. Is there a way to detect if a port has this power resource configuration
> via ACPI methods? I'm wondering if we could make HPIE disabling conditional on
> the presence of this power management setup.

Yes the Root Port has _PR3() method but see below.

> > In your case does the root port enter D3cold? Does it have power resource?
> > Or it stays in D3hot? We should not put any hotplug ports into low power
> > states if they don't have HotPlugSupportInD3 property as described here:
> 
> I think it stays in D3hot. I am not very clear about the power resource. is
> there a way to check for it? Should I look for power_resources_* in sysfs or
> check the ACPI tables directly?
> 
> Regarding your suggestion about HotPlugSupportInD3: would it make sense to modify
> the HPIE disable logic to be conditional on the presence of this _DSD property? 

We already have the check in acpi_pci_bridge_d3(). In your case that should
return false and the port should never enter D3.
