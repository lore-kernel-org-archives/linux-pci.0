Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51550 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030555AbaLLRDa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Dec 2014 12:03:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <rjui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	Christian Daudt <bcm@fixthebug.org>,
	Matt Porter <mporter@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ARM: mach-bcm: Enable PCIe support for iProc
Date: Fri, 12 Dec 2014 18:02:28 +0100
Message-ID: <2928443.nLu7V1bDNK@wuerfel>
In-Reply-To: <548B1E33.4090806@broadcom.com>
References: <1418351817-14898-4-git-send-email-rjui@broadcom.com> <3173848.p74DGitYxH@wuerfel> <548B1E33.4090806@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 12 December 2014 08:56:19 Ray Jui wrote:
> >>
> >> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> >> index aaeec78..a13a0b2 100644
> >> --- a/arch/arm/mach-bcm/Kconfig
> >> +++ b/arch/arm/mach-bcm/Kconfig
> >> @@ -19,6 +19,7 @@ config ARCH_BCM_IPROC
> >>      select ARCH_REQUIRE_GPIOLIB
> >>      select ARM_AMBA
> >>      select PINCTRL
> >> +    select PCIE_IPROC
> >>      help
> >>        This enables support for systems based on Broadcom IPROC architected SoCs.
> >>        The IPROC complex contains one or more ARM CPUs along with common
> >>
> >
> > No, just enable it in multi_v7_defconfig and bcm_defconfig.
> >
> >       Arnd
> >
> Or can I simply have the PCIE_IPROC default to y in 
> drivers/pci/host/Kconfig? Note PCIE_IPROC depends on ARCH_BCM_IPROC. By 
> defaulting it to y, it will be automatically enabled for all iProc 
> family of SoCs.

I still think it's best not to turn it on automatically. The convention
for device drivers is to make them all optional.

What you can do however is to add

	depends on ARCH_BCM_IPROC || COMPILE_TEST

to the driver to do the reverse and not let the driver be turned on
unless IPROC is selected or you are just testing the build.
A lot of distros just turn on all drivers, so this way you wouldn't
accidentally enable it for a kernel that doesn't support IPROC.

	Arnd
