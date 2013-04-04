Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:49188 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762904Ab3DDA5g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2013 20:57:36 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Andrew Murray' <Andrew.Murray@arm.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Russell King - ARM Linux' <linux@arm.linux.org.uk>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	linux-samsung-soc@vger.kernel.org,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <20130326162022.GA25625@arm.com>
 <20130327130418.GA10480@avionic-0098.mockup.avionic-design.de>
In-reply-to: <20130327130418.GA10480@avionic-0098.mockup.avionic-design.de>
Subject: Re: [PATCH v3] of/pci: Provide support for parsing PCI DT ranges
 property
Date: Thu, 04 Apr 2013 09:57:34 +0900
Message-id: <002b01ce30cf$64da6180$2e8f2480$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 27, 2013 10:04 PM, Thierry Reding wrote:
> 
> On Tue, Mar 26, 2013 at 04:20:23PM +0000, Andrew Murray wrote:
> > This patch factors out common implementation patterns to reduce overall kernel
> > code and provide a means for host bridge drivers to directly obtain struct
> > resources from the DT's ranges property without relying on architecture specific
> > DT handling. This will make it easier to write archiecture independent host bridge
> > drivers and mitigate against further duplication of DT parsing code.
> >
> > This patch can be used in the following way:
> >
> > 	struct of_pci_range_parser parser;
> > 	struct of_pci_range range;
> >
> > 	if (of_pci_range_parser(&parser, np))
> > 		; //no ranges property
> >
> > 	for_each_of_pci_range(&parser, &range) {
> >
> > 		/*
> > 			directly access properties of the address range, e.g.:
> > 			range.pci_space, range.pci_addr, range.cpu_addr,
> > 			range.size, range.flags
> >
> > 			alternatively obtain a struct resource, e.g.:
> > 			struct resource res;
> > 			of_pci_range_to_resource(&range, np, &res);
> > 		*/
> > 	}
> >
> > Additionally the implementation takes care of adjacent ranges and merges them
> > into a single range (as was the case with powerpc and microblaze).
> >
> > The modifications to microblaze, mips and powerpc have not been tested.
> >
> > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Tested-by: Thierry Reding <thierry.reding@avionic-design.de>

It works properly with Exynos5440.

Tested-by: Jingoo Han <jg1.han@samsung.com>



