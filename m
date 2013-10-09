Return-Path: <linux-kernel-owner@vger.kernel.org>
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
 <52551C6E.1040404@ti.com> <003901cec4d0$5d83e650$188bb2f0$%han@samsung.com>
 <5255266B.6040809@ti.com>
In-reply-to: <5255266B.6040809@ti.com>
Subject: Re: [PATCH] PCI: designware: Add irq_create_mapping()
Date: Wed, 09 Oct 2013 19:05:24 +0900
Message-id: <000501cec4d7$1233a3f0$369aebd0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 09, 2013 6:48 PM, Kishon Vijay Abraham I wrote:
> On Wednesday 09 October 2013 02:47 PM, Jingoo Han wrote:
> > On Wednesday, October 09, 2013 6:06 PM, Kishon Vijay Abraham I wrote:
> >> On Wednesday 09 October 2013 01:39 PM, Jingoo Han wrote:
> >>> Without irq_create_mapping(), the correct irq number cannot be
> >>> provided. In this case, it makes problem such as NULL deference.
> >>> Thus, irq_create_mapping() should be added for MSI.
> >>>
> >>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> >>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> >>> ---
> >>> Tested on Exynos5440.
> >>>
> >>>  drivers/pci/host/pcie-designware.c |   10 ++++------
> >>>  drivers/pci/host/pcie-designware.h |    1 +
> >>>  2 files changed, 5 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> >>> index 8963017..e536bb6 100644
> >>> --- a/drivers/pci/host/pcie-designware.c
> >>> +++ b/drivers/pci/host/pcie-designware.c
> >>> @@ -237,6 +237,8 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> >>>  		}
> >>>  	}
> >>>
> >>> +	pp->msi_irq_start = irq_create_mapping(pp->irq_domain, 0);
> >>> +
> >>
> >> I think irq_create_mapping should be done for all the MSI irq lines instead of
> >> only the first line. So you might have to do for MAX_MSI_IRQS lines.
> 
> Maybe it should be only till MAX_MSI_IRQS-1?

I am not sure; however, it doesn't look correct.

irq_create_mapping() is defined as below.
According to the comment, irq_create_mapping() maps 'a' hardware interrupt,
not max value of MSI IRQ lines.

./kernel/irq/irqdomain.c
/**
 * irq_create_mapping() - Map a hardware interrupt into linux irq space
 * @domain: domain owning this hardware interrupt or NULL for default domain
 * @hwirq: hardware irq number in that domain space
[.....]
unsigned int irq_create_mapping(struct irq_domain *domain,
                                irq_hw_number_t hwirq)

Also, another value of 'irq' can be selected, because 'pos0' is added.

	pp->msi_irq_start = irq_create_mapping(pp->irq_domain, 0);
	irq = (pp->msi_irq_start + pos0);


Pratyush Anand,
If I am wrong, please let me know. :-)

Best regards,
Jingoo Han

