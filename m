Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:17182 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab3H1IR1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 04:17:27 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Pratyush Anand' <pratyush.anand@st.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <003d01ce9fc6$9c0f1c20$d42d5460$%han@samsung.com>
 <20130823083539.GB3937@pratyush-vbox>
In-reply-to: <20130823083539.GB3937@pratyush-vbox>
Subject: Re: [PATCH V2] PCI: exynos: add support for MSI
Date: Wed, 28 Aug 2013 17:17:24 +0900
Message-id: <001801cea3c7$06bca9d0$1435fd70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, August 23, 2013 5:36 PM, Pratyush Anand wrote:
> On Fri, Aug 23, 2013 at 02:04:20PM +0800, Jingoo Han wrote:

[.....]

> > +#define MAX_MSI_IRQS                   32
> 
> DW MSI controller can support upto 256. However, 32 seems a practical
> choice, as there might not be any system which may use more
> than 32. But a comment like as follows can be put here:
> 
> /*
> * Maximum number of MSI IRQs can be 256 per controller. But keep
> * it 32 as of now. Probably we will never need more than 32. If needed,
> * then increment it in multiple of 32.
> */

OK.
I will add this comment.

> 
> > +#define MAX_MSI_CTRLS                  8
> 
> Why to waste cpu cycles when MAX_MSI_IRQS is 32 only.
> #define MAX_MSI_CTRLS   (MAX_MSI_IRQS / 32)

OK.
I will fix it as you guide.

> 
> > +
> > +static unsigned int msi_data;
> > +static DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> 
> What if one has more than one RC.
> There are SOCs which support 3 RCs.
> So something like this:
> 
> #define MAX_PCIE_PORT_SUPPORTED 3
> static DECLARE_BITMAP(msi_irq_in_use[MAX_PCIE_PORT_SUPPORTED],
>                   NUM_MSI_IRQS);
> static unsigned int *msi_data[MAX_PCIE_PORT_SUPPORTED];

No, there is no need to do it.
Without this, we can use 3 RCs by adding a node of 3rd RC to dt file.

> 
> Allocate msi_data using __get_free_pages(GFP_KERNEL, 0)) as Thierry
> suggested.

OK.
I will use '__get_free_pages(GFP_KERNEL, 0))' as Thierry guide.

> >  int dw_pcie_link_up(struct pcie_port *pp)
> >  {
> >         if (pp->ops->link_up)
> > @@ -225,6 +432,13 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >                 return -EINVAL;
> >         }
> >
> > +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +               if (of_property_read_u32(np, "msi-base", &pp->msi_irq_start)) {
> > +                       dev_err(pp->dev, "Failed to parse the number of lanes\n");
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> 
> What if an implementor want to use irq_domain method for msi_irq_start
> allocation? Is it fine to return error if msi-base is not passed from
> dt?

Sure, I will consider using irq_domain method.

>
> Also, with the limited knowledge of dt I do not understand one thing, how
> would dt understand that you have used 32 msi irqs (MAX_MSI_IRQS)?

Sorry, I cannot understand exactly. :-(
I will look into it.

I really appreciate your comments. :-)

Best regards,
Jingoo Han

