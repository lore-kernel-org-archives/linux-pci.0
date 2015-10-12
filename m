Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58074 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbbJLP1D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 12 Oct 2015 11:27:03 -0400
Date: Mon, 12 Oct 2015 10:26:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v2] PCI: layerscape: Add PCIe support for LS1043a and
 LS2080a
Message-ID: <20151012152656.GB29221@localhost>
References: <1442481219-28299-1-git-send-email-Minghuan.Lian@freescale.com>
 <20151007175725.GC27633@localhost>
 <5274293.94FcFfK0fd@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5274293.94FcFfK0fd@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 12, 2015 at 02:36:29PM +0200, Arnd Bergmann wrote:
> On Wednesday 07 October 2015 12:57:25 Bjorn Helgaas wrote:
> > > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > > index ae873be..38fe8a8 100644
> > > --- a/drivers/pci/host/Kconfig
> > > +++ b/drivers/pci/host/Kconfig
> > > @@ -105,7 +105,7 @@ config PCI_XGENE_MSI
> > >  
> > >  config PCI_LAYERSCAPE
> > >       bool "Freescale Layerscape PCIe controller"
> > > -     depends on OF && ARM
> > > +     depends on OF && (ARM || ARM64)
> > 
> > It seems like there are a couple things going on here, and I wonder if
> > you can split them out into separate patches.
> > 
> > 1) Making this work on ARM64 as well as on ARM.  This may be of
> > interest for other DesignWare-based drivers, so if you split this out,
> > maybe it would be a useful template for converting the other drivers,
> > too.
> 
> The Kconfig change apparently made it into linux-next now, but it
> doesn't actually build on arm64, because the dependency that was
> mentioned in the cover letter [0] is not there.
> ...
> [0] This patch is based on v4.3-rc1 and [PATCH v9 0/6]
> PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
> patchset from Zhou Wang.

Oops, my fault.  I read that as "this patch is derived from, e.g., it
a newer version of, the HiSilicon patchset."  But that's obviously
a silly way to read it.  I re-did the merge without the Layerscape
patch and repushed it to my "next" branch.

I'll work on Zhou's series, then revisit Minghuan's patch(es).  I'm
hoping the Layerscape patch can be split up a bit, both to split out
the ARM64 config change and to make a cleaner "LS1043a and LS2080a"
support patch.  The current patch changes several things that are not
obviously directly related to LS1043a and LS2080a.  It would be ideal
to have a series of things like:

  - add ARM64 build support (maybe just the Kconfig change)
  - make the ls_pcie_probe() changes that are apparently generic
    across all the LS devices
  - add driver data to lc_pcie_of_match[] (this wouldn't change any
    behavior at all; it would just add the ls1021_drvdata that works
    for the already-supported devices)
  - add ls1032_drvdata and ls2080_drvdata for the new devices
  - add the "msi-parent" diagnostic (this seems to be basically new
    functionality that applies to all devices, not just the new ones)

That way, each individual change would be easier to review.

Bjorn
