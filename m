Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36690 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243AbbJOQAg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 12:00:36 -0400
Date: Thu, 15 Oct 2015 11:00:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ray Jui <rjui@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org,
	Kevin Hilman <khilman@kernel.org>,
	Tyler Baker <tyler.baker@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Mark Brown <broonie@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: iproc: fix 32-bit build error
Message-ID: <20151015160028.GA17702@localhost>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
 <561D6458.40504@hauke-m.de>
 <561D6576.2020107@broadcom.com>
 <5204456.Kxa6kNhPYW@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5204456.Kxa6kNhPYW@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 13, 2015 at 11:00:31PM +0200, Arnd Bergmann wrote:
> On Tuesday 13 October 2015 13:11:34 Ray Jui wrote:
> > >> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> > >> index f3481ddff344..abcb4be2ee19 100644
> > >> --- a/drivers/pci/host/pcie-iproc.c
> > >> +++ b/drivers/pci/host/pcie-iproc.c
> > >> @@ -235,12 +235,13 @@ static void iproc_pcie_enable(struct iproc_pcie *pcie)
> > >>   *
> > >>   * axi_addr -> iproc_pcie_address -> OARR -> OMAP -> pci_address
> > >>   */
> > >> -static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> > >> +int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> > > 
> > > Why are you removing the static here?
> > > 
> > 
> > Yeah we should keep this function as static. The rest of this change
> > looks good!
> > 
> 
> Sorry, this accidentally ended up in the patch when I marked the
> function as global to track down how the division got called.
> 
> I'll send a new version.

Ping; I can easily fix up the static, but it'd be nice to have real acks
from Ray and Hauke.

Bjorn
