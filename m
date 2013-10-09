Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:27826 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3JIFHq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2013 01:07:46 -0400
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
References: <001a01ceaace$013ec980$03bc5c80$%han@samsung.com>
 <5253A4DA.7090306@ti.com>
In-reply-to: <5253A4DA.7090306@ti.com>
Subject: Re: [PATCH V3] PCI: exynos: add support for MSI
Date: Wed, 09 Oct 2013 14:07:36 +0900
Message-id: <000001cec4ad$78640450$692c0cf0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 08, 2013 3:23 PM, Kishon Vijay Abraham I wrote:
> On Friday 06 September 2013 12:24 PM, Jingoo Han wrote:
> > This patch adds support for Message Signaled Interrupt in the
> > Exynos PCIe diver using Synopsys designware PCIe core IP.
> >
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> > Signed-off-by: Srikanth T Shivanand <ts.srikanth@samsung.com>
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Cc: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> > ---

[.....]

> >  int __init dw_pcie_host_init(struct pcie_port *pp)
> >  {
> >  	struct device_node *np = pp->dev->of_node;
> > @@ -157,6 +372,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >  	struct of_pci_range_parser parser;
> >  	u32 val;
> >
> > +	struct irq_domain *irq_domain;
> > +
> >  	if (of_pci_range_parser_init(&parser, np)) {
> >  		dev_err(pp->dev, "missing ranges property\n");
> >  		return -EINVAL;
> > @@ -223,6 +440,18 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >  		return -EINVAL;
> >  	}
> >
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		irq_domain = irq_domain_add_linear(pp->dev->of_node,
> > +					MAX_MSI_IRQS, &msi_domain_ops,
> > +					&dw_pcie_msi_chip);
> > +		if (!irq_domain) {
> > +			dev_err(pp->dev, "irq domain init failed\n");
> > +			return -ENXIO;
> > +		}
> > +
> > +		pp->msi_irq_start = irq_find_mapping(irq_domain, 0);
> 
> Where is the irq_create_mapping done for this irq domain? Is that not needed?
> Without that I'm not getting the correct irq number.

Oh, you're right.
irq_create_mapping() is necessary!

Without irq_create_mapping(), it makes the ugly NULL deference
when two PCIe controllers are used on Exynos5440.
It is my mistake.

I will add irq_create_mapping() to dw_msi_setup_irq(), as tegra PCIe driver
did. I will send the patch, soon.

I really appreciate your comment. :-)
Thank you.

Best regards,
Jingoo Han

