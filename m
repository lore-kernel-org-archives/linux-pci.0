Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32689 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbaDXEx4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 00:53:56 -0400
From: Kukjin Kim <kgene.kim@samsung.com>
To: 'Arnd Bergmann' <arnd@arndb.de>,
	'Liviu Dudau' <Liviu.Dudau@arm.com>
Cc: linaro-kernel@lists.linaro.org, 'Jingoo Han' <jg1.han@samsung.com>,
	'Byungho An' <bh74.an@samsung.com>,
	'linux-pci' <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, ilho215.lee@samsung.com,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
References: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com>
 <4565008.ZECF3eWqge@wuerfel>
 <20140423142315.GO865@e106497-lin.cambridge.arm.com>
 <14215032.8jhN17iHj5@wuerfel>
In-reply-to: <14215032.8jhN17iHj5@wuerfel>
Subject: RE: [RFC PATCH 2/2] PCI: exynos: Add PCIe support for Samsung GH7 SoC
Date: Thu, 24 Apr 2014 13:53:47 +0900
Message-id: <01ff01cf5f79$30f926b0$92eb7410$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Arnd Bergmann wrote:
> 
> On Wednesday 23 April 2014 15:23:16 Liviu Dudau wrote:
> > > Unfortunately we are in a tricky situation on arm64 because we have
> > > to support both server-type SoCs and embedded-type SoCs. In an
> > > embedded system, you can't trust the boot loader to do a proper
> > > setup of all the hardware, so the kernel needs full control over
> > > all the initialization. In a server, the initialization is the
> > > responsibility of the firmware, and we don't want the kernel to
> > > even know about those registers.

BTW, actually we can trust boot-loader to do required things in mobile also ;-)

> > >
> > > My hope is that all server chips use an SBSA compliant PCIe
> > > implementation, but we already have X-Gene, which is doing server
> > > workloads with a nonstandard PCIe, and it's possible that there
> > > will also be server-like systems with a DesignWare PCIe block
> > > instead of an SBSA compliant one. We can still support those, but
> > > I don't want to see more than one implementation of dw-pcie
> > > on servers. Just like we have the generic PCIe support that Will
> > > is doing for virtual machines and SBSA compliant systems, we
> > > would do one dw-pcie variant for all systems that come with a
> > > host firmware and rely on it being set up already.

OK and I think, just one device driver would be nice for whatever embedded or
server.

> >
> > There is nothing in the SBSA that mandates firmware setup. All it requires

Yeah, I couldn't look at that in the SBSA...

> > is that hardware is setup in a way that is not specific to a board
> > or a particular OEM. Surely if the setup being done for GH7 is always
> > the same it should fit the bill?
> 
But Arnd's comments are about firmware based on each SoC not board?...

> GH7 is already not SBSA compliant because it uses a nonstandard config
> space access method, and it uses its own MSI controller rather than GIC.
> This means it violates at least two out of the four clauses in SBSA
> describing PCIe.
> 
OK, I see. Honestly, we just focused on how to support PCI on both exynos5440
and GH7 SoCs.

> Regardless of this, the level of detail describing config space and
> MSI handling in SBSA can only make sense if the purpose is to handle
> all compliant implementations without platform specific code. If you
> require platform specific setup code in the OS, this underlying assumption
> no longer holds true and there is no point in having a spec in the
> first place.
> 
OK, your assumption makes sense to us.

> I think we should treat DW-PCIe in the same way if anyone attempts
> to use that in a server, e.g. in SBSA level 0. As you can see here,

Agreed. BTW, how about GICv2m for level 1? It can be supported with the same
way in one DW-PCIe driver?

> even when reusing hardware between Exynos and GH7, you can't just
> use the same init code, so it has to be in firmware to be any good.
> On a real server platform, you can't require a kernel upgrade every
> time a new SoC comes out, any basic functionality like PCI just has to
> work with existing OS images.
> 
OK, when Will's driver is ready, we will test it on GH7 with the setup for PCIe
included in firmware. Anyway I hope we can use the driver in 3.16 :-)

Thanks,
Kukjin

