Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55699 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaBKMi3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2014 07:38:29 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
Cc: Pratyush ANAND <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V5 7/8] pcie: SPEAr13xx: Add designware pcie support
Date: Tue, 11 Feb 2014 13:38:08 +0100
Message-ID: <1923851.AhH781i5Mk@wuerfel>
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189FD2CAAA9@EAPEX1MAIL1.st.com>
References: <cover.1391871170.git.pratyush.anand@st.com> <201402101643.23186.arnd@arndb.de> <2CC2A0A4A178534D93D5159BF3BCB66189FD2CAAA9@EAPEX1MAIL1.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 11 February 2014 12:23:58 Mohit KUMAR DCG wrote:

> > > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > > index 13fb333..42a491d 100644
> > > --- a/drivers/pci/host/Makefile
> > > +++ b/drivers/pci/host/Makefile
> > > @@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> > >  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> > >  obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
> > >  obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
> > > +obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> > 
> > I'd use the "pci" naming instead of "pcie" here for consistency.
> > 
> 
> - No, let it be pcie as SPEAr13xx soc has pci controller as well , though  PCI is
> not used on current eval boards.

Hmm, it's still inconsistent, but I can see your argument.
Let's see if someone has a better idea, otherwise keep the
pcie name.

I'd prefer to avoid having to rename drivers in the long run,
but if we start naming some pcie drivers pci and others pcie,
it gets rather confusing.

	Arnd
