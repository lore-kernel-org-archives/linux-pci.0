Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730220AbeHFXHH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 19:07:07 -0400
Date: Mon, 6 Aug 2018 15:56:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
 controller irq with AER
Message-ID: <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
 <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2018 at 11:05:09AM -0700, Sinan Kaya wrote:
> On 8/1/2018 9:44 AM, Bharat Kumar Gogada wrote:
> > Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> > Error Interrupt Message Number. The controller has dedicated interrupt line
> > for reporting PCIe errors along with AER.
> > 
> > Using dedicated controller irq number for AER which is shared with misc
> > interrupt handler in pcie-xilinx-nwl. This irq number is set
> > using PCI quirk.
> > 
> > Signed-off-by: Bharat Kumar Gogada<bharat.kumar.gogada@xilinx.com>
> > ---
> >   drivers/pci/pcie/portdrv_core.c |    4 ++++
> >   1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index e0261ad..fa9150e 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -264,6 +264,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
> >   	int retval;
> >   	struct pcie_device *pcie;
> >   	struct device *device;
> > +#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL)
> > +	if (service == PCIE_PORT_SERVICE_AER && pdev->sysdata)
> > +		irq = *(int *)pdev->sysdata;
> > +#endif
> 
> I remember seeing a similar patch before. 

Are you thinking of [1]?

> The patch above looks ugly to be honest. Need to find a way to
> generalize this. Can you search the mailing list archive to find out
> what the history is?

I agree, the patch above is too ugly as-is because (a) it puts very
arch-specific code in a generic code path and (b) it uses a
compile-time test, which means it probably breaks generic arm64
kernels that contain support for several platforms.

We also need to know whether this is a hardware defect or just
something that is allowed by the spec but Linux doesn't support yet.
The diagram in PCIe r4.0, sec 6.2.6, does leave room for MSI, MSI-X,
INTx, and platform-specific interrupt schemes.

[1] https://lkml.kernel.org/r/1464242406-20203-1-git-send-email-po.liu@nxp.com
