Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60536 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760599AbcBYPYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 10:24:22 -0500
Date: Thu, 25 Feb 2016 09:24:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/3] arm/arm64: pci: remove arch specific
 pcibios_enable_device()
Message-ID: <20160225152417.GB8120@localhost>
References: <1447779838-15585-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1447779838-15585-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20151123134921.GB4236@arm.com>
 <20160120162215.GE13437@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160120162215.GE13437@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Wed, Jan 20, 2016 at 04:22:15PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Nov 23, 2015 at 01:49:21PM +0000, Will Deacon wrote:
> > On Tue, Nov 17, 2015 at 05:03:58PM +0000, Lorenzo Pieralisi wrote:
> > > The arm/arm64 pcibios_enable_device() implementations exist solely
> > > to prevent enabling PCI resources on PROBE_ONLY systems, since
> > > on those systems the PCI resources are currently not claimed (ie
> > > validated and inserted in the PCI resource tree) therefore they can
> > > not be enabled since this would trigger PCI set-ups failures.
> > > 
> > > By introducing resources claiming in the PCI host controllers set-ups
> > > that have PROBE_ONLY as a probe option, there is no need for arch specific
> > > pcibios_enable_device() implementations anymore in that the kernel can
> > > rely on the generic pcibios_enable_device() implementation without
> > > resorting to arch specific code to work around the missing resources
> > > claiming enumeration step.
> > > 
> > > This patch removes the pcibios_enable_device() implementations from
> > > the arm/arm64 arch back-ends.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > ---
> > >  arch/arm/kernel/bios32.c | 12 ------------
> > >  arch/arm64/kernel/pci.c  | 13 -------------
> > >  2 files changed, 25 deletions(-)
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks, unfortunately I spotted that ARM platforms can set
> PCI_PROBE_ONLY also via command line (pcibios_setup()), which means
> that I have to add resource claiming to all ARM PCI controllers that
> check PCI_PROBE_ONLY (inclusive of ARM bios32) to really make sure we
> can apply this patch or alternatevely we add the resource claiming
> to the pcibios_fixup_bus() callback (but we can claim resources only if
> PCI_PROBE_ONLY is set lest we trigger regressions) which would be the
> simpler solution.

So where are we?  The above response sounds like this series still
needs a little tweaking?

Bjorn
