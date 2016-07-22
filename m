Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:44546 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbcGVHQs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jul 2016 03:16:48 -0400
Date: Fri, 22 Jul 2016 00:16:44 -0700
From: Tony Lindgren <tony@atomide.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, bcousson@baylibre.com,
	robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 2/2] ARM: DRA7: select PCI_DOMAINS config
Message-ID: <20160722071644.GZ28140@atomide.com>
References: <1469102276-14777-1-git-send-email-kishon@ti.com>
 <1469102276-14777-3-git-send-email-kishon@ti.com>
 <8047226.VhgpLo8JQu@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8047226.VhgpLo8JQu@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Arnd Bergmann <arnd@arndb.de> [160721 05:08]:
> On Thursday, July 21, 2016 5:27:56 PM CEST Kishon Vijay Abraham I wrote:
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 1a648e9..8e6e2c0 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -86,6 +86,7 @@ config SOC_DRA7XX
> >         select OMAP_INTERCONNECT_BARRIER
> >         select PM_OPP if PM
> >         select ZONE_DMA if ARM_LPAE
> > +       select PCI_DOMAINS if PCI
> >  
> >  config ARCH_OMAP2PLUS
> >         bool
> > 
> 
> Should we just set this unconditionally for ARCH_MULTIPLATFORM maybe?

Makes sense to me if many SoCs need this.

Regards,

Tony
