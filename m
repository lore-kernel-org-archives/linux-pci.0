Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60855 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbcDRKCB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Apr 2016 06:02:01 -0400
Date: Mon, 18 Apr 2016 11:01:54 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/3] drivers: pci: host-generic: claim bus resources
 on PCI_PROBE_ONLY set-ups
Message-ID: <20160418100154.GB2427@red-moon>
References: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1456843449-19393-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20160412044311.GB11361@localhost>
 <20160412154810.GA32109@red-moon>
 <20160415130803.GA2105@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160415130803.GA2105@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 15, 2016 at 08:08:03AM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 12, 2016 at 04:48:10PM +0100, Lorenzo Pieralisi wrote:

[...]

> > > The next patch removes the arm and arm64 pcibios_enable_device()
> > > implementations, which implies that arm and arm64 only need the generic
> > > version, which simply calls pci_enable_resources().  That assumes r->parent
> > > is set.
> > > 
> > > After this patch, we'll call pci_bus_claim_resources() for the
> > > PCI_PROBE_ONLY case, and that sets r->parent for all the resources.
> > > 
> > > Where does r->parent get set in the non-PCI_PROBE_ONLY case?  Obviously
> > > that path *works*, because you're not changing anything there.  I'd just
> > > like to have a hint that makes this change more obvious.
> > 
> > On all ARM/ARM64 PCI controllers drivers I am aware of (apart from the
> > kvmtool PCI host controller which does require PCI_PROBE_ONLY, so we need
> > this patch), resources are always reassigned and the core code reassigning
> > them takes care of assigning their parent pointers too, to answer your
> > question.
> 
> Here's what I find confusing.  Consider these three cases:
> 
>   1) Firmware programs no BARs and we reassign everything.  We call
>   pci_bus_assign_resources(), and the pci_assign_resource() ...
>   allocate_resource() path makes sure everything is claimed.  This is
>   apparently the normal arm/arm64 path, and it already works.
> 
>   2) Firmware programs all BARs and we set PCI_PROBE_ONLY.  After this
>   series, we'll claim the resources and remove the PCI_PROBE_ONLY
>   special case in pcibios_enable_device().  This is great!
> 
>   3) Firmware programs all BARs but we don't set PCI_PROBE_ONLY.  We
>   call pci_bus_assign_resources(), but I think it does nothing because
>   everything is already assigned.  The resources are not claimed and
>   pci_enable_resources() will fail.

I do not expect (1) and (3) to be different from a kernel resource
allocation perspective.

If the core resource layer is asked to assign resources it will,
regardless of what FW programmed in the BARs (the BAR regions size
matters, that's it), I went through pci_bus_assign_resources() a couple
of times and I have to add a bit of debugging so give me the benefit of
the doubt please, but there is nothing that let me think it won't assign
resources (and therefore assign a parent pointer) if the resources are
already programmed correctly (actually I even think the kernel may
change what FW programmed according to its resource alloc policy).

> This last case 3) is the problem.  I'm guessing this case doesn't
> currently occur on arm/arm64, but it's the normal case on x86, and it
> seems perverse that things work if firmware does nothing, but they
> don't work if firmware does more setup.

IIUC X86 claim resources as programmed by FW so it is not really the
same situation as arm64, that claims nothing. Claimed resources are not
reassigned, they are skipped by resource allocation/sizing code
(because their parent pointer is set).

And as I said above even if FW does some set-up that will still work
on ARM/ARM64, otherwise this means that on ALL ARM/ARM64 systems out there
PCI set-up at kernel handover is non-existent, otherwise we would
have resource enablement failures NOW, right ?

> So I think we should add some sort of arm/arm64-specific
> pci_claim_resource() path similar to the pcibios_allocate_resources()
> stuff on x86.

I agree but it has to be done with care in particular in relation to
bridges apertures, claiming resources on systems that currently reassign
everything may trigger regressions.

In particular, having an API that claims resources is NOT sufficient
for that purpose for two reasons:

- If resource claiming fails for some resources, currently the kernel
  spits too much noise in the logs, claiming should be a best-effort
  approach, if it fails there is no error to report in the logs, if FW
  left resources unset that's *not* an error AFAIK
- Bridge apertures: care must be taken so that resources downstream
  should be sized so that bridges can accomodate them, this may require
  releasing previously claimed bridge apertures and realloc them

The approach should be:

(1) Claim resources
(2) Realloc whatever fails (which may imply releasing bridges resources
    previously claimed)

> > As for this patch series, given that:
> > 
> > commit (in -next) 903589ca7165 ("ARM: 8554/1: kernel: pci: remove
> > pci=firmware command line parameter handling") removes the PCI_PROBE_ONLY
> > handling from the (ARM) command line, the PCI host generic becomes the
> > last ARM/ARM64 host controller that requires PCI_PROBE_ONLY to function
> > (depending on DT settings).
> > 
> > The idea behind adding pci_bus_claim_resources (patch 1) to core code
> > was that it could be reused by other arches too, I do not have evidence
> > though, I have to prove it, so I'd rather squash patch 1 into this one
> > and make the code claiming resources local to the PCI host generic,
> > I can't add a generic PCI core API just for one host controller
> > (IMHO we should add an API that allows us to claim bus resources and
> > realloc the ones for which claiming fail - which may mean releasing
> > bridges resources and realloc/resize them - code is in the kernel already
> > I have to write that API).
> > 
> > The code claiming resources on x86, IA64 and PowerPC looks extremely
> > similar but it has to be proven that a generic function has a chance
> > to work, so patch 1 is not really justified at present.
> 
> I don't really object to patch 1, but you're right that it's possible
> we could do a better job later.  I would certainly like to get that
> sort of code (including the pcibios_allocate_resources() stuff I just
> mentioned) out of the arches and into the core somehow.

Problem with patch 1, is that, if resource claiming fails, it spits
loads of noise in kernel logs (actually it is pci_claim_resource(), that
patch 1 uses, that spits errors on claiming failure), that's a detail but
it will make people unhappy.

I do not think that if claiming for a particular resource fails we can
consider it an error that's why I see patch 1 more PCI host generic
PCI_PROBE_ONLY specific rather than anything else, we can't use
it for !PCI_PROBE_ONLY systems unless I rework it to remove the
kernel error logs on resource claiming failures.

Probably on X86/IA64 resource claiming is spotless because on most
if not all systems FW programmes the PCI bus and the kernel can take
the set-up as-is, it is a question since I have no visibility into that.

> > If you have no objections I will squash patch 1 into this one (moving
> > the respective code in PCI host generic driver), and I would not merge
> > this series till the commit above in -next gets in the kernel (which
> > makes sure that PCI_PROBE_ONLY can't be set on the command line, that's
> > fundamental to this series, at least on ARM, on ARM64 DT is the only way
> > PCI_PROBE_ONLY can be set and only on host controllers that check the
> > chosen node property - ie PCI host generic, that we are patching).
> 
> If there's a stable branch containing 903589ca7165 ("ARM: 8554/1:
> kernel: pci: remove pci=firmware command line parameter handling"), I
> can pull that and merge your series on top of it.

I think I should at least split patch 3 in two (one for ARM and one for
ARM64), if Russell is forced to revert the commit above (because
we discover pci=firmware command line users) I do not want ARM64 to
be affected.

Thanks !
Lorenzo
