Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49947 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752080AbaEBSW1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 May 2014 14:22:27 -0400
Date: Fri, 2 May 2014 19:21:50 +0100
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [RESEND PATCH 1/3] ARM: mach-virt: allow PCI support to be
 selected
Message-ID: <20140502182149.GE14645@arm.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
 <1399048876-11862-2-git-send-email-will.deacon@arm.com>
 <4646975.AnXvL4OPrE@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4646975.AnXvL4OPrE@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Fri, May 02, 2014 at 07:11:04PM +0100, Arnd Bergmann wrote:
> On Friday 02 May 2014 17:41:14 Will Deacon wrote:
> > mach-virt can make use of virtio-pci devices, which requires the guest
> > kernel to have PCI support selected.
> > 
> > This patch selects CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_VIRT=y.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index db3c5414223e..f24356c4d630 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -941,6 +941,7 @@ config ARCH_VIRT
> >         select ARM_GIC
> >         select ARM_PSCI
> >         select HAVE_ARM_ARCH_TIMER
> > +       select MIGHT_HAVE_PCI
> 
> I would actually just put it under ARCH_MULTIPLATFORM. Anything can
> have PCI really, and it doesn't cause any harm.

Sure, I can change that easily enough.

Will
