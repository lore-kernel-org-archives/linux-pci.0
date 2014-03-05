Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:10835 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbaCEI6Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 03:58:25 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Liviu Dudau' <liviu@dudau.co.uk>
Cc: 'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'linux-pci' <linux-pci@vger.kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Catalin Marinas' <Catalin.Marinas@arm.com>,
	'Will Deacon' <Will.Deacon@arm.com>,
	'linaro-kernel' <linaro-kernel@lists.linaro.org>,
	'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
	'LKML' <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org,
	'LAKML' <linux-arm-kernel@lists.infradead.org>,
	'Tanmay Inamdar' <tinamdar@apm.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com>
 <1393948204-11555-8-git-send-email-Liviu.Dudau@arm.com>
 <001f01cf3811$18463ed0$48d2bc70$%han@samsung.com>
 <20140305083311.GD13582@bart.dudau.co.uk>
In-reply-to: <20140305083311.GD13582@bart.dudau.co.uk>
Subject: Re: [PATCH v5 7/7] pci: Add support for creating a generic host_bridge
 from device tree
Date: Wed, 05 Mar 2014 17:58:22 +0900
Message-id: <000b01cf3851$0fe55d30$2fb01790$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 05, 2014 5:33 PM, Liviu Dudau wrote:
> On Wed, Mar 05, 2014 at 10:20:28AM +0900, Jingoo Han wrote:
> > On Wednesday, March 05, 2014 12:50 AM, Liviu Dudau wrote:
> > >
> > > Several platforms use a rather generic version of parsing
> > > the device tree to find the host bridge ranges. Move the common code
> > > into the generic PCI code and use it to create a pci_host_bridge
> > > structure that can be used by arch code.
> > >
> > > Based on early attempts by Andrew Murray to unify the code.
> > > Used powerpc and microblaze PCI code as starting point.
> > >
> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > >
> > > diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> > > index 8708b652..800678a 100644
> > > --- a/drivers/pci/host-bridge.c
> > > +++ b/drivers/pci/host-bridge.c

[.....]

> > > +
> > > +	/* Apply architecture specific fixups for the ranges */
> > > +	pcibios_fixup_bridge_ranges(resources);
> >
> > It also makes compile problem with exynos_defconfig as below:
> >
> > drivers/built-in.o: In function `pci_host_bridge_of_get_ranges':
> > drivers/pci/host-bridge.c:157: undefined reference to `pcibios_fixup_bridge_ranges'
> 
> Does that mean that exynos_defconfig doesn't define CONFIG_OF? How do you
> compile all the .dts files then? Should CONFIG_OF not be added to the default config
> file?

Now, I am testing your patches with ARM32 platform such as
Exynos SoCs. And the default 'exynos_defconfig' already defines
CONFIG_OF=y. (./arch/arm/configs/exynos_defconfig)

> 
> Other than that, your comment is correct. drivers/pci/host-bridge.c gets compiled
> in regardless of CONFIG_OF and I need to provide an empty implementation for
> pcibios_fixup_bridge_ranges().

There is no pcibios_fixup_bridge_ranges() in ./arch/arm/ directory.
So, it makes the compile problem.

I think that the empty implementation for pcibios_fixup_bridge_ranges()
may be necessary, in order to the compile problem.
Or, __weak pcibios_fixup_bridge_ranges() would be used.

Best regards,
Jingoo Han

