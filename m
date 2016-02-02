Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42501 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbcBBXO4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Feb 2016 18:14:56 -0500
Date: Tue, 2 Feb 2016 17:14:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Vineet.Gupta1@synopsys.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v7 2/2] add new platform driver for PCI RC
Message-ID: <20160202231449.GA18009@localhost>
References: <cover.1454349430.git.jpinto@synopsys.com>
 <10b29adcdb0a31eb8f8071b271da267e44ad8a04.1454349430.git.jpinto@synopsys.com>
 <8223655.W63T0XOVm1@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8223655.W63T0XOVm1@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 02, 2016 at 09:25:25PM +0100, Arnd Bergmann wrote:
> On Monday 01 February 2016 18:07:45 Joao Pinto wrote:
> > +static void synopsys_pcie_establish_link(struct pcie_port *pp)
> > +{
> > +	int retries = 0;
> > +
> > +	/* check if the link is up or not */
> > +	for (retries = 0; retries < 10; retries++) {
> > +		if (dw_pcie_link_up(pp)) {
> > +			dev_info(pp->dev, "Link up\n");
> > +			return;
> > +		}
> > +		mdelay(100);
> > +	}
> > +}
> 
> That mdelay() needs to be an msleep(). You should never waste
> a whole second worth of CPU time in a driver.

There are six other copies of this code, and two of them (exynos and
spear) have the same problem.

Bjorn
