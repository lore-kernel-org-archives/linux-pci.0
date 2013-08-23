Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26253 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab3HWE6J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2013 00:58:09 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000401ce9739$e0a65410$a1f2fc30$@samsung.com>
 <20130812105638.GA12042@ulmo>
In-reply-to: <20130812105638.GA12042@ulmo>
Subject: Re: [PATCH] PCI: exynos: add support for MSI
Date: Fri, 23 Aug 2013 13:58:07 +0900
Message-id: <002e01ce9fbd$5b728430$12578c90$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, August 12, 2013 7:57 PM, Thierry Reding wrote:
> On Mon, Aug 12, 2013 at 05:56:47PM +0900, Jingoo Han wrote:
> [...]
> > diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> > index 855d4a7..9ef1c95 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -93,6 +93,7 @@ config SOC_EXYNOS5440
> >  	default y
> >  	depends on ARCH_EXYNOS5
> >  	select ARCH_HAS_OPP
> > +	select ARCH_SUPPORTS_MSI
> 
> This symbol goes away in Thomas Petazzoni's MSI patch series which is
> targetted at 3.12, so I don't think you should add that here.

OK, I see.
I will remove ARCH_SUPPORTS_MSI.

[.....]

> > +#endif
> > +
> >  static void exynos_pcie_enable_interrupts(struct pcie_port *pp)
> >  {
> >  	exynos_pcie_enable_irq_pulse(pp);
> > +#ifdef CONFIG_PCI_MSI
> > +	exynos_pcie_msi_init(pp);
> > +#endif
> >  	return;
> >  }
> 
> Instead of the whole #ifdef business above, can't you just use something
> like this in exynos_pcie_enable_interrupts():
> 
> 	if (IS_ENABLED(CONFIG_PCI_MSI))
> 		exynos_pcie_msi_init(pp);
> 
> Now you can drop the #ifdef guards and the compiler will throw away all
> the related code automatically if PCI_MSI is not selected because the
> functions are all static and unused. This has the advantage of compiling
> all the code whether or not PCI_MSI is selected or not, therefore
> increasing compile coverage of the driver.

OK, I see.
I will use 'if IS_ENABLED(CONFIG_PCI_MSI))', and remove #ifdef guards.

[.....]

> > +
> > +void arch_teardown_msi_irq(unsigned int irq)
> > +{
> > +	clear_irq(irq);
> > +}
> 
> And we've reworked this largely so that drivers no longer provide arch_*
> functions because that prevents multi-platform support. So I think you
> need to port this to the new msi_chip infrastructure that's being
> introduced in 3.12.

OK, I have looked at the new msi_chip infrastructure made by Thomas Petazzoni.
I will use this msi_chip.

I really appreciate your comment. :)
Thank you.

Best regards,
Jingoo Han


