Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34663 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755249AbbIWPPU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 11:15:20 -0400
Date: Wed, 23 Sep 2015 16:15:19 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"Kumar Gala" <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 3/6] pci:host: Add Altera PCIe host controller driver
Message-ID: <20150923161519.15e0dd87@arm.com>
In-Reply-To: <CAFiDJ5-JTmU39wZ7A+h3X37zj8M09+6mmUxK=J2DOaD9VzPC5w@mail.gmail.com>
References: <1442801587-3812-1-git-send-email-lftan@altera.com>
	<1442801587-3812-4-git-send-email-lftan@altera.com>
	<20150922193320.37997c15@arm.com>
	<CAFiDJ5-JTmU39wZ7A+h3X37zj8M09+6mmUxK=J2DOaD9VzPC5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 23 Sep 2015 17:33:09 +0800
Ley Foon Tan <lftan@altera.com> wrote:

> On Wed, Sep 23, 2015 at 2:33 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On Mon, 21 Sep 2015 10:13:04 +0800
> > Ley Foon Tan <lftan@altera.com> wrote:
> >
> >> This patch adds the Altera PCIe host controller driver.
> >>
> >> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> >> ---
> >>  drivers/pci/host/Kconfig       |   8 +
> >>  drivers/pci/host/Makefile      |   1 +
> >>  drivers/pci/host/pcie-altera.c | 591 +++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 600 insertions(+)
> >>  create mode 100644 drivers/pci/host/pcie-altera.c
> >>
> >> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> >> index d5e58ba..df9ed4f 100644
> >> --- a/drivers/pci/host/Kconfig
> >> +++ b/drivers/pci/host/Kconfig
> >> @@ -145,4 +145,12 @@ config PCIE_IPROC_BCMA
> >>         Say Y here if you want to use the Broadcom iProc PCIe controller
> >>         through the BCMA bus interface
> >>
> >> +config PCIE_ALTERA
> >> +     tristate "Altera PCIe controller"
> >> +     depends on ARCH_SOCFPGA || NIOS2
> >> +     select PCI_DOMAINS
> >> +     help
> >> +       Say Y here if you want to enable PCIe controller support for Altera
> >> +       SoCFPGA family of SoCs.
> >> +
> >
> > Is there anything in this driver that is actually specific to any of
> > these two platforms/architectures? I'd don't think we should restrict
> > if we can avoid it (hint: the companion MSI driver is not restricted to
> > any architecture).
> No specific dependency on these 2 architectures. Then I will remove this.

OK. If you fix this, you can put my

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

on this patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
