Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33720 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756804AbbICQfJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2015 12:35:09 -0400
Received: by iofh134 with SMTP id h134so64887611iof.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2015 09:35:08 -0700 (PDT)
Date: Thu, 3 Sep 2015 11:35:04 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
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
Subject: Re: [PATCH] ARM64: PCI: do not enable resources on PROBE_ONLY systems
Message-ID: <20150903163504.GH829@google.com>
References: <1438262039-32085-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150828211444.GA27890@google.com>
 <20150829124457.GA18125@red-moon>
 <20150831132803.GB647@google.com>
 <20150831163314.GA19309@red-moon>
 <CAErSpo5188hGiySG+JweWOvfj6aZtAfVta4=0wwwRmMTp+9tFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5188hGiySG+JweWOvfj6aZtAfVta4=0wwwRmMTp+9tFg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 31, 2015 at 11:49:20AM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 31, 2015 at 11:33 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Mon, Aug 31, 2015 at 02:28:03PM +0100, Bjorn Helgaas wrote:
> >> On Sat, Aug 29, 2015 at 01:44:57PM +0100, Lorenzo Pieralisi wrote:
> >> > On Fri, Aug 28, 2015 at 10:14:44PM +0100, Bjorn Helgaas wrote:
> >> > > On Thu, Jul 30, 2015 at 02:13:59PM +0100, Lorenzo Pieralisi wrote:
> >> > > > On ARM64 PROBE_ONLY PCI systems resources are not currently claimed,
> >> > > > therefore they can't be enabled since they do not have a valid
> >> > > > parent pointer; this in turn prevents enabling PCI devices on
> >> > > > ARM64 PROBE_ONLY systems, causing PCI devices initialization to
> >> > > > fail.
> >> > >
> >> > > Where does arm64 claim PCI BAR resources for the non-PROBE_ONLY case?
> >> >
> >> > arm64 (and arm) does not claim resources in arch code, they are always
> >> > assigned in the respective host controllers (or the pcibios on arm),
> >> > except for the PCI generic host when in PROBE_ONLY mode, where resources
> >> > are neither claimed nor assigned (the reason for this patch to exist).
> >> > ...
> >> >
> >> > > I know it must be there somewhere, but I don't see it.
> >> >
> >> > It is not there, it is done in the host controllers by assigning the
> >> > resources (which also "claim" them by assigning the parent pointer).
> >>
> >> The host controller drivers should claim the apertures forwarded to
> >> the PCI bus.  For pci-host-generic, this happens when
> >> gen_pci_parse_request_of_pci_ranges() calls devm_request_resource().
> >
> > Yes, the generic host claims the apertures at DT probing time.
> >
> >> But that doesn't do anything for the BARs of the PCI devices
> >> themselves, of course.
> >>
> >> If this patch fixes a problem that will occur in the future, when we
> >> add arm/arm64 code to claim BARs, let's make this patch part of that
> >> series.  If it fixes a problem in the current tree, I'll merge it now,
> >> but so far I haven't been able to make the connection between this
> >> patch and a problem in the current code.
> >
> > It fixes a problem in the current tree (I mean when the PCI pull is
> > merged - it contains code that enables PCI host generic on arm64),
> > since without it PROBE_ONLY systems (ie PCI host generic on kvmtool) would
> > try to enable resources and fail, since the resources were not claimed.
> >
> > It works the same way as arm, I will rework both arches when I am done
> > refactoring the resource claiming implementation.
> >
> > Will picked it up already I do not know what's the best way to
> > merge it I guess it can go via the arm64 tree if you do not have any
> > objections.
> 
> OK, if it fixes a problem in my v4.3 pull request, we need to merge
> it.  I missed the connection, probably because I was browsing the
> v4.2-rc1 tree, which wouldn't have those changes.
> 
> It's OK with me to merge it via the arm64 tree.

Do you need me to do anything with this?  It'd be nice to get it in
before -rc1.  The PCI changes have already been merged, and it'd be
nice to mention the commit that this fixes.

Bjorn
