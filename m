Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52058 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab3CGBRW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 20:17:22 -0500
From: Kukjin Kim <kgene.kim@samsung.com>
To: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>
Cc: 'Jingoo Han' <jg1.han@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>
References: <016b01ce18c2$2c366f10$84a34d30$%han@samsung.com>
 <CAJuYYwTKe6cC+eMmyAAskCJrDrbS3SmYRYhzL9iui5m1zvgbzw@mail.gmail.com>
 <20130306140752.7e5d68c8@skate>
In-reply-to: <20130306140752.7e5d68c8@skate>
Subject: RE: [PATCH 1/2] ARM: EXYNOS: Add PCIe driver support
Date: Thu, 07 Mar 2013 10:17:15 +0900
Message-id: <015101ce1ad1$80e4fa20$82aeee60$%kim@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas Petazzoni wrote:
> 
> Dear Thomas Abraham,
> 
> On Mon, 4 Mar 2013 16:01:59 +0530, Thomas Abraham wrote:
> > On 4 March 2013 15:52, Jingoo Han <jg1.han@samsung.com> wrote:
> > > Exynos5440 has two PCIe controllers which can be used as Root Complex.
> > > This driver supports the PCIe controllers as Root Complex mode.
> > >
> > > Signed-off-by: Surendranath Gurivireddy Balla
> <suren.reddy@samsung.com>
> > > Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> > > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > > ---
> > >  .../devicetree/bindings/pci/exynos-pcie.txt        |   58 ++
> > >  arch/arm/Kconfig                                   |    2 +
> > >  arch/arm/mach-exynos/Kconfig                       |    8 +
> > >  arch/arm/mach-exynos/Makefile                      |    2 +
> > >  arch/arm/mach-exynos/include/mach/pcie.h           |  146 +++
> > >  arch/arm/mach-exynos/pcie.c                        | 1009
> ++++++++++++++++++++
> >
> > Is there any reason to place this code in arch/arm/...? As you know,
> > there is a constant effort to relocate as much code as possible from
> > arch/arm/mach-exynos. So there must be a strong justification for
> > keeping this code in arch/arm/mach-exynos.
> 
> Indeed. Thierry Reding (doing the Tegra PCIe driver) and myself (doing
> the Marvell PCIe driver) are putting our drivers in drivers/pci/host/,
> in agreement with the PCI maintainers.
> 
I agree.

Jingoo, please move this stuff into drivers/pci when you address comments.

Thanks.

- Kukjin

