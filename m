Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35526 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbcDRRcG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Apr 2016 13:32:06 -0400
Date: Mon, 18 Apr 2016 18:31:49 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/3] drivers: pci: host-generic: claim bus resources
 on PCI_PROBE_ONLY set-ups
Message-ID: <20160418173149.GA8846@red-moon>
References: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160415130803.GA2105@localhost>
 <20160418100154.GB2427@red-moon>
 <5357164.ryYLtkY3PQ@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5357164.ryYLtkY3PQ@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 18, 2016 at 04:49:43PM +0200, Arnd Bergmann wrote:
> On Monday 18 April 2016 11:01:54 Lorenzo Pieralisi wrote:
> > On Fri, Apr 15, 2016 at 08:08:03AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 12, 2016 at 04:48:10PM +0100, Lorenzo Pieralisi wrote:
> 
> > > This last case 3) is the problem.  I'm guessing this case doesn't
> > > currently occur on arm/arm64, but it's the normal case on x86, and it
> > > seems perverse that things work if firmware does nothing, but they
> > > don't work if firmware does more setup.
> > 
> > IIUC X86 claim resources as programmed by FW so it is not really the
> > same situation as arm64, that claims nothing. Claimed resources are not
> > reassigned, they are skipped by resource allocation/sizing code
> > (because their parent pointer is set).
> > 
> > And as I said above even if FW does some set-up that will still work
> > on ARM/ARM64, otherwise this means that on ALL ARM/ARM64 systems out there
> > PCI set-up at kernel handover is non-existent, otherwise we would
> > have resource enablement failures NOW, right ?
> 
> The embedded systems (in which I would count all arm32 machines) tend
> to not do proper bus probing in their bootloaders, so we have to do it
> ourselves in the kernel.
> 
> For server systems (all UEFI based ones), I'd argue that we should
> rely on the firmware to do it just like we do on x86, possibly with
> a blacklist of known-broken machines on which we have to do it
> manually as well. Once ACPI spreads, we will likely see an increasing
> number of machines on which we must not reassign the resources or
> bad things happen to stuff that is owned by the BIOS.

The only way I can pull that off, is by writing an ARM64 PCI resource
allocation function that does the following:

- Try to claim the FW set-up
- Realloc on claiming failures, inclusive of bridges resources
  releasing/resizing

When to call it it has to be seen, either I do it on all ARM64 machines
(but this requires significant testing because regressions are more
than likely given that there are platforms on which we reassign everything
already) or on !acpi_disabled (but I think that's wrong because I do not
see why it is *only* dependent on ACPI), the sooner we implement it the
better (and actually that's the reason why I wanted this function to
be in the ACPI host controller code for ARM64 from the beginning - but
if we do it at arch level it can be even more generic - again, when
to call it it must be decided).

Lorenzo
