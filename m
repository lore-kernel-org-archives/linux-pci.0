Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62993 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab3JIJR1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2013 05:17:27 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000401cec4c6$dc415180$94c3f480$%han@samsung.com>
 <52551C6E.1040404@ti.com>
In-reply-to: <52551C6E.1040404@ti.com>
Subject: Re: [PATCH] PCI: designware: Add irq_create_mapping()
Date: Wed, 09 Oct 2013 18:17:24 +0900
Message-id: <003901cec4d0$5d83e650$188bb2f0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 09, 2013 6:06 PM, Kishon Vijay Abraham I wrote:
> On Wednesday 09 October 2013 01:39 PM, Jingoo Han wrote:
> > Without irq_create_mapping(), the correct irq number cannot be
> > provided. In this case, it makes problem such as NULL deference.
> > Thus, irq_create_mapping() should be added for MSI.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> > Tested on Exynos5440.
> >
> >  drivers/pci/host/pcie-designware.c |   10 ++++------
> >  drivers/pci/host/pcie-designware.h |    1 +
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index 8963017..e536bb6 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -237,6 +237,8 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> >  		}
> >  	}
> >
> > +	pp->msi_irq_start = irq_create_mapping(pp->irq_domain, 0);
> > +
> 
> I think irq_create_mapping should be done for all the MSI irq lines instead of
> only the first line. So you might have to do for MAX_MSI_IRQS lines.

I tested PCIe LAN card after I replaced 0 with MAX_MSI_IRQS.
However, it makes an error message as below:
But, PCIe LAN card works properly.

WARNING: CPU: 1 PID: 1 at kernel/irq/irqdomain.c:276 irq_domain_associate+0x150/0x1a8()
error: hwirq 0x20 is too large for (null)

Best regards,
Jingoo Han

