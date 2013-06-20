Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:58319 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965016Ab3FTLmy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2013 07:42:54 -0400
From: Tomasz Figa <t.figa@samsung.com>
To: Jingoo Han <jg1.han@samsung.com>, 'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Tomasz Figa' <tomasz.figa@gmail.com>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Andrew Murray' <andrew.murray@arm.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>
Subject: Re: [PATCH V6 3/3] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
Date: Thu, 20 Jun 2013 13:42:43 +0200
Message-id: <1490597.TZb2cDc7ca@amdc1227>
In-reply-to: <00d801ce6da5$fa792d80$ef6b8880$@samsung.com>
References: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
 <201306201216.37248.arnd@arndb.de>
 <00d801ce6da5$fa792d80$ef6b8880$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 20 of June 2013 20:04:47 Jingoo Han wrote:
> On Thursday, June 20, 2013 7:17 PM, Arnd Bergmann wrote:
> > On Thursday 20 June 2013, Jingoo Han wrote:
> > > 2. patch adding label to the pinctrl node (which is a prerequisite)
> > > and
> > > 
> > >     board-specific properties of PCIe nodes.
> > >    
> > >    [PATCH] ARM: dts: Add pcie controller node for exynos5440-ssdk5440
> > > 
> > > arch/arm/boot/dts/exynos5440-ssdk5440.dts
> > > +
> > > +       pcie0@290000 {
> > > +               reset-gpio = <&pin_ctrl 5 0>;
> > > +       };
> > > +
> > > +       pcie1@2a0000 {
> > > +               reset-gpio = <&pin_ctrl 22 0>;
> > > +       };
> > > 
> > > arch/arm/boot/dts/exynos5440.dtsi
> > > -       pinctrl {
> > > +       pin_ctrl: pinctrl {
> > 
> > Note that you don't really have to use a label, you can also refer
> > to the pinctrl node by its full path, which is just "/pinctrl"
> > or "/pinctrl@e0000".

Sure, you can, but this is ugly.

> 
> I see.
> 
> But, I have a question.
> Using phandle has been the usual way to referring to a node.
> Why do you want to do it differently?

Path is translated to a phandle as well.

--
Best regards,
Tomasz

