Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35624 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbbHaQtl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Aug 2015 12:49:41 -0400
Received: by wibq14 with SMTP id q14so6304717wib.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2015 09:49:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150831163314.GA19309@red-moon>
References: <1438262039-32085-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150828211444.GA27890@google.com> <20150829124457.GA18125@red-moon>
 <20150831132803.GB647@google.com> <20150831163314.GA19309@red-moon>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 31 Aug 2015 11:49:20 -0500
Message-ID: <CAErSpo5188hGiySG+JweWOvfj6aZtAfVta4=0wwwRmMTp+9tFg@mail.gmail.com>
Subject: Re: [PATCH] ARM64: PCI: do not enable resources on PROBE_ONLY systems
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Jayachandran C <jchandra@broadcom.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 31, 2015 at 11:33 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Mon, Aug 31, 2015 at 02:28:03PM +0100, Bjorn Helgaas wrote:
>> On Sat, Aug 29, 2015 at 01:44:57PM +0100, Lorenzo Pieralisi wrote:
>> > On Fri, Aug 28, 2015 at 10:14:44PM +0100, Bjorn Helgaas wrote:
>> > > On Thu, Jul 30, 2015 at 02:13:59PM +0100, Lorenzo Pieralisi wrote:
>> > > > On ARM64 PROBE_ONLY PCI systems resources are not currently claimed,
>> > > > therefore they can't be enabled since they do not have a valid
>> > > > parent pointer; this in turn prevents enabling PCI devices on
>> > > > ARM64 PROBE_ONLY systems, causing PCI devices initialization to
>> > > > fail.
>> > >
>> > > Where does arm64 claim PCI BAR resources for the non-PROBE_ONLY case?
>> >
>> > arm64 (and arm) does not claim resources in arch code, they are always
>> > assigned in the respective host controllers (or the pcibios on arm),
>> > except for the PCI generic host when in PROBE_ONLY mode, where resources
>> > are neither claimed nor assigned (the reason for this patch to exist).
>> > ...
>> >
>> > > I know it must be there somewhere, but I don't see it.
>> >
>> > It is not there, it is done in the host controllers by assigning the
>> > resources (which also "claim" them by assigning the parent pointer).
>>
>> The host controller drivers should claim the apertures forwarded to
>> the PCI bus.  For pci-host-generic, this happens when
>> gen_pci_parse_request_of_pci_ranges() calls devm_request_resource().
>
> Yes, the generic host claims the apertures at DT probing time.
>
>> But that doesn't do anything for the BARs of the PCI devices
>> themselves, of course.
>>
>> If this patch fixes a problem that will occur in the future, when we
>> add arm/arm64 code to claim BARs, let's make this patch part of that
>> series.  If it fixes a problem in the current tree, I'll merge it now,
>> but so far I haven't been able to make the connection between this
>> patch and a problem in the current code.
>
> It fixes a problem in the current tree (I mean when the PCI pull is
> merged - it contains code that enables PCI host generic on arm64),
> since without it PROBE_ONLY systems (ie PCI host generic on kvmtool) would
> try to enable resources and fail, since the resources were not claimed.
>
> It works the same way as arm, I will rework both arches when I am done
> refactoring the resource claiming implementation.
>
> Will picked it up already I do not know what's the best way to
> merge it I guess it can go via the arm64 tree if you do not have any
> objections.

OK, if it fixes a problem in my v4.3 pull request, we need to merge
it.  I missed the connection, probably because I was browsing the
v4.2-rc1 tree, which wouldn't have those changes.

It's OK with me to merge it via the arm64 tree.

>> > > > To solve this issue, resources must be claimed when devices are
>> > > > added on PROBE_ONLY systems, which ensures that the resource hierarchy
>> > > > is validated and the resource tree is sane, but this requires changes
>> > > > in the ARM64 resource management that can affect adversely existing
>> > > > PCI set-ups (claiming resources on !PROBE_ONLY systems might break
>> > > > existing ARM64 PCI platform implementations).
>> > > >
>> > > > As a temporary solution in preparation for a proper resources claiming
>> > > > implementation in ARM64 core, to enable PCI PROBE_ONLY systems on ARM64,
>> > > > this patch adds a pcibios_enable_device() arch implementation that
>> > > > simply prevents enabling resources on PROBE_ONLY systems (mirroring ARM
>> > > > behaviour).
>> > > >
>> > > > This is always a safe thing to do because on PROBE_ONLY systems the
>> > > > configuration space set-up can be considered immutable, and it is in
>> > > > preparation of proper resource claiming that would finally validate
>> > > > the PCI resources tree in the ARM64 arch implementation on PROBE_ONLY
>> > > > systems.
>> > > >
>> > > > For !PROBE_ONLY systems resources enablement in pcibios_enable_device()
>> > > > on ARM64 is implemented as in current PCI core, leaving the behaviour
>> > > > unchanged.
>> > > >
>> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> > > > Cc: Will Deacon <will.deacon@arm.com>
>> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > > > ---
>> > > > Bjorn, all,
>> > > >
>> > > > as I mention in the commit log, this patch is a temporary solution
>> > > > in preparation for proper resources claiming in ARM64, so that
>> > > > we can safely enable the PCI generic host controller on ARM64 systems.
>> > > >
>> > > > It mirrors ARM implementation and I will work on changing both
>> > > > ARM and ARM64 to convert them to proper resources claiming in
>> > > > the respective implementations.
>> > > >
>> > > > Lorenzo
>> > > >
>> > > >  arch/arm64/kernel/pci.c | 13 +++++++++++++
>> > > >  1 file changed, 13 insertions(+)
>> > > >
>> > > > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> > > > index 4095379..b3d098b 100644
>> > > > --- a/arch/arm64/kernel/pci.c
>> > > > +++ b/arch/arm64/kernel/pci.c
>> > > > @@ -38,6 +38,19 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>> > > >         return res->start;
>> > > >  }
>> > > >
>> > > > +/**
>> > > > + * pcibios_enable_device - Enable I/O and memory.
>> > > > + * @dev: PCI device to be enabled
>> > > > + * @mask: bitmask of BARs to enable
>> > > > + */
>> > > > +int pcibios_enable_device(struct pci_dev *dev, int mask)
>> > > > +{
>> > > > +       if (pci_has_flag(PCI_PROBE_ONLY))
>> > > > +               return 0;
>> > > > +
>> > > > +       return pci_enable_resources(dev, mask);
>> > > > +}
>> > > > +
>> > > >  /*
>> > > >   * Try to assign the IRQ number from DT when adding a new device
>> > > >   */
>> > > > --
>> > > > 2.2.1
>> > > >
>> > >
>>
