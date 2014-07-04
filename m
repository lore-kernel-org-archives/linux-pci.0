Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	Prabhakar Kushwaha <prabhakar@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: PCI(e) arch support
Date: Fri, 04 Jul 2014 12:21 +0200
Message-ID: <4342569.JSAyWBcJn2@wuerfel>
In-Reply-To: <20140704094440.GC6501@e106497-lin.cambridge.arm.com>
References: <1404422876-1160-1-git-send-email-tinamdar@apm.com> <53B5F81B.8010801@freescale.com> <20140704094440.GC6501@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 04 July 2014 10:44:40 Liviu Dudau wrote:
> On Fri, Jul 04, 2014 at 01:40:59AM +0100, Prabhakar Kushwaha wrote:
> > Hi Tanmay, Liviu,
> > On 7/4/2014 2:57 AM, Tanmay Inamdar wrote:
> > > Reposting on request of several people since previously posted one was
> > > corrupted.
> > >
> > > This patch adds the arch support for PCI(e) for arm64. The files
> > > added or modified in this patch are based on PCI(e) support in
> > > 32bit arm.
> > >
> > > Please note that this patch is just for the reference. Liviu Dudau from ARM
> > > has posted his v8 series of patch to support PCIe in arm64.
> > >
> > > The patch will apply against 3.13 Linux Kernel
> > >
> > > Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> > >
> > 
> > do we foresee similar type of changes in u-boot  to support PCI(e) for 
> > ARM64.
> 
> I'm afraid I'm not familiar with u-boot's support for PCI(e), so I cannot
> answer that. As a general matter, ARM has decided to officially support
> UEFI as a bootloader for ARMv8 and that already has support for PCI(e),
> one only needs a driver for the specific host bridge.

Supporting just one boot loader is of course a bit silly, especially when
you know that people will be using all sorts of boot loaders.

A more interesting aspect of this question is what the kernel can expect
the boot loader to have done with the PCI host bridge when the kernel
is entered.

Traditionally, embedded ARM boot loaders have left the PCI host bridge
alone unless they were booting from it, and Linux did all the setup.
With the SBSA class of ARM servers, this is not really practical, and
whatever runs before Linux (typically UEFI) should already set up the
PCI bus and do resource allocation like every other server architecture
does. I would assume that UEFI does this right, and if not we can consider
that a bug.

However, what do we do about PCI hosts that can be used with different
kinds of systems? Do we assume that they all do PCI resource allocation?
Can we decide this on a per host driver basis, or do we need to introduce
an extension to the PCI DT binding to make that decision?

	Arnd
