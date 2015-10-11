Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55971 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbbJKTKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 11 Oct 2015 15:10:34 -0400
Date: Sun, 11 Oct 2015 14:10:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH v2] PCI: layerscape: Add PCIe support for LS1043a and
 LS2080a
Message-ID: <20151011191027.GA29221@localhost>
References: <1442481219-28299-1-git-send-email-Minghuan.Lian@freescale.com>
 <20151007175725.GC27633@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151007175725.GC27633@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Thomas, Jason, Tanmay]

Hi Minghuan,

You responded to this message, but your response was rejected by the
mailing list, I think because it was not plain text.  See
http://vger.kernel.org/majordomo-info.html

I went ahead and reconstructed what your response would have looked
like so I could continue the conversation.  But please fix your email
setup before responding again :)

Minghuan wrote:
> On Wed, Oct 07, 2015 at 12:57:25PM -0500, Bjorn Helgaas wrote:
> > Hi Minghuan,
> > 
> > On Thu, Sep 17, 2015 at 05:13:39PM +0800, Minghuan Lian wrote:
> > > The patch adds PCIe support for LS1043a and LS2080a.
> > > 
> > > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > ---
> > > This patch is based on v4.3-rc1 and [PATCH v9 0/6]
> > > PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
> > > patchset from Zhou Wang.
> > > 
> > > change log
> > > v2:
> > > 1. rename ls2085a to ls2080a
> > > 2. Add ls_pcie_msi_host_init()
> > > 
> > >  drivers/pci/host/Kconfig          |   2 +-
> > >  drivers/pci/host/pci-layerscape.c | 227 ++++++++++++++++++++++++++------------
> > >  2 files changed, 157 insertions(+), 72 deletions(-)
> > > 
> > > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > > index ae873be..38fe8a8 100644
> > > --- a/drivers/pci/host/Kconfig
> > > +++ b/drivers/pci/host/Kconfig
> > > @@ -105,7 +105,7 @@ config PCI_XGENE_MSI
> > >  
> > >  config PCI_LAYERSCAPE
> > >  	bool "Freescale Layerscape PCIe controller"
> > > -	depends on OF && ARM
> > > +	depends on OF && (ARM || ARM64)
> > 
> > It seems like there are a couple things going on here, and I wonder if
> > you can split them out into separate patches.
> > 
> > 1) Making this work on ARM64 as well as on ARM.  This may be of
> > interest for other DesignWare-based drivers, so if you split this out,
> > maybe it would be a useful template for converting the other drivers,
> > too.
> > 
> > 2) Adding LS1043a and LS2080a.  Obviously, this is only of interest to
> > this driver, but maybe it could be separated out into a separate
> > patch?

> The patch is based on v4.3-rc1 and [PATCH v9 0/6] PCI: hisi: Add PCIe host
> support for HiSilicon SoC Hip05 patchset from Zhou Wang which adds arm and
> arm64 support.
>
> The original code with the Zhou Wang's patches can support arm64 as well.
> Because both LS1043a and LS2085 are armv8 (arm64) architecture, the patch
> updates Kconfig to add 'arm64'.
>
> If splitting two patches, the first patch for arm64 support only includes one
> line changes of Kconfig. So, I think it is unnecessary.

It's OK if the first patch is very small.  The point is that the patch
does two orthogonal things, and those two things should be in separate
commits.  This makes bisection work better, and it reduces the amount
of functionality removed if we have to revert something.

> > > +static int ls_pcie_msi_host_init(struct pcie_port *pp,
> > > +				 struct msi_controller *chip)
> > > +{
> > > +	struct device_node *msi_node;
> > > +	struct device_node *np = pp->dev->of_node;
> > > +
> > > +	msi_node = of_parse_phandle(np, "msi-parent", 0);
> > > +	if (!msi_node) {
> > > +		dev_err(pp->dev, "failed to find msi-parent\n");
> > > +		return -EINVAL;
> > > +	}
> > 
> > This doesn't actually *do* anything except complain if "msi-parent" is
> > missing.  I'm not sure that's worth doing: if we need "msi-parent"
> > somewhere, we should complain there if we don't find it.  If we don't
> > need it, why complain if it's missing?

> driver/of/irq.c  void of_msi_configure(struct device *dev, struct
> device_node *np) will bind "msi-parent" to each device if there is
> "msi-parent" handler. The PCIe driver do not need to do anything. If
> we do not check "msi-parent" here, we will have no chance to check it.
> The common code of 'of' and 'pci' bus driver will not complain,
> because the msi controller may be found by other way.

Hmm.   In mvebu_pcie_msi_enable() and xgene_pcie_msi_enable(), we
also look for "msi-parent".  If that fails, mvebu continues silently
and xgene complains (but only if CONFIG_PCI_MSI=y).

This seems like three unnecessarily different ways of doing the same
thing.

I cc'd the maintainers of those drivers; maybe we can agree on a single
strategy.

> > >  static int __init ls_pcie_probe(struct platform_device *pdev)
> > >  {
> > > ...
> > > -	ret = ls_add_pcie_port(pcie);
> > > -	if (ret < 0)
> > > +	ret = dw_pcie_host_init(pp);
> > 
> > We have several DesignWare-based drivers (dra7xx, exynos, imx6, ks,
> > ls, spear13xx), and I'd like to keep their structure as similar as
> > possible.  For example, they all have basically this structure:
> > 
> >   X_pcie_probe
> >     X_add_pcie_port
> >       dw_pcie_host_init             # pp->ops->host_init callback
> >         X_pcie_host_init
> >           X_pcie_establish_link
> > 
> > This patch removes ls_add_pcie_port() and ls_pcie_establish_link(), so
> > we're diverging a bit.  That makes it harder to see the similarities
> > across these drivers, which I think is a loss.

> I will add X_add_pcie_port. But we do not need X_pcie_establish_link
> because we do not need change/reset phy to establish link, besides,
> the PCIe controller slot may be not inserted any PCIe device at all.
> If each controller waits some time for link, the start time will
> increase a lot. In some scenes, long start-up time is not acceptable.

If we wait for a timeout trying to establish a link when the slot is
empty, it sounds like something's wrong.  Can't we tell from presence
detect whether a card is present, even without trying to bring up the
link?

If we truly do not need a piece like X_pcie_establish_link(), I'm OK
with entirely omitting it.  What I really object to is when we have
the same functionality two places with different names or structured
two different ways.

Bjorn
