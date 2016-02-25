Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52770 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932407AbcBYQDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 11:03:25 -0500
Date: Thu, 25 Feb 2016 16:05:33 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/3] arm/arm64: pci: remove arch specific
 pcibios_enable_device()
Message-ID: <20160225160533.GA3596@red-moon>
References: <1447779838-15585-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1447779838-15585-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20151123134921.GB4236@arm.com>
 <20160120162215.GE13437@red-moon>
 <20160225152417.GB8120@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160225152417.GB8120@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thu, Feb 25, 2016 at 09:24:17AM -0600, Bjorn Helgaas wrote:
> Hi Lorenzo,
> 
> On Wed, Jan 20, 2016 at 04:22:15PM +0000, Lorenzo Pieralisi wrote:
> > On Mon, Nov 23, 2015 at 01:49:21PM +0000, Will Deacon wrote:
> > > On Tue, Nov 17, 2015 at 05:03:58PM +0000, Lorenzo Pieralisi wrote:
> > > > The arm/arm64 pcibios_enable_device() implementations exist solely
> > > > to prevent enabling PCI resources on PROBE_ONLY systems, since
> > > > on those systems the PCI resources are currently not claimed (ie
> > > > validated and inserted in the PCI resource tree) therefore they can
> > > > not be enabled since this would trigger PCI set-ups failures.
> > > > 
> > > > By introducing resources claiming in the PCI host controllers set-ups
> > > > that have PROBE_ONLY as a probe option, there is no need for arch specific
> > > > pcibios_enable_device() implementations anymore in that the kernel can
> > > > rely on the generic pcibios_enable_device() implementation without
> > > > resorting to arch specific code to work around the missing resources
> > > > claiming enumeration step.
> > > > 
> > > > This patch removes the pcibios_enable_device() implementations from
> > > > the arm/arm64 arch back-ends.
> > > > 
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > ---
> > > >  arch/arm/kernel/bios32.c | 12 ------------
> > > >  arch/arm64/kernel/pci.c  | 13 -------------
> > > >  2 files changed, 25 deletions(-)
> > > 
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Thanks, unfortunately I spotted that ARM platforms can set
> > PCI_PROBE_ONLY also via command line (pcibios_setup()), which means
> > that I have to add resource claiming to all ARM PCI controllers that
> > check PCI_PROBE_ONLY (inclusive of ARM bios32) to really make sure we
> > can apply this patch or alternatevely we add the resource claiming
> > to the pcibios_fixup_bus() callback (but we can claim resources only if
> > PCI_PROBE_ONLY is set lest we trigger regressions) which would be the
> > simpler solution.
> 
> So where are we?  The above response sounds like this series still
> needs a little tweaking?

Yes, I rewrote the generic PCI layer for claiming resources (Tomasz's
posted it in its ACPI PCI ARM64 series):

https://lkml.org/lkml/2016/2/16/412

My only concern is removing PCI_PROBE_ONLY handling from arm 32 bit code,
since I noticed it can be set on the command line there, claiming
resources in pcibios arm 32 should do the trick, I will move the ARM
32-bit handling in a separate patch (hopefully someone can help me test
it on affected platforms (?), I will ask Russell the best way to do it).

Thanks,
Lorenzo
