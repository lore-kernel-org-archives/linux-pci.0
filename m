Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18532 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab3FKGA1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2013 02:00:27 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	linux-arm-kernel@lists.infradead.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-samsung-soc@vger.kernel.org,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Andrew Murray' <andrew.murray@arm.com>,
	Jingoo Han <jg1.han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <201306071943.18407.arnd@arndb.de>
 <000001ce65b5$e45477f0$acfd67d0$@samsung.com>
 <201306101722.10146.arnd@arndb.de>
In-reply-to: <201306101722.10146.arnd@arndb.de>
Subject: Re: [PATCH 6/6] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
Date: Tue, 11 Jun 2013 15:00:25 +0900
Message-id: <002e01ce6668$f785dc20$e6919460$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, June 11, 2013 12:22 AM, Arnd Bergmann wrote:
> On Monday 10 June 2013, Jingoo Han wrote:
> > On Saturday, June 08, 2013 2:43 AM, Arnd Bergmann wrote:
> > For multiple domains, how can I fix the DT properties?
> 
> Domains are a Linux concept, you have to pick a new domain number for each
> struct hw_pci you register.

Hi Arnd,

Thank you for your reply.
It is very helpful. :)

I will set domain numbers for each struct hw_pci.

> 
> > Current DT properties are as below:
> >
> > +	pcie0@40000000 {
> > +		compatible = "samsung,exynos5440-pcie";
> > +		reg = <0x40000000 0x4000
> > +			0x290000 0x1000
> > +			0x270000 0x1000
> > +			0x271000 0x40>;
> > +		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> > +		#address-cells = <3>;
> > +		#size-cells = <2>;
> > +		device_type = "pci";
> > +		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
> > +			  0x81000000 0 0	  0x40200000 0 0x00004000   /* downstream I/O */
> > +			  0x82000000 0 0	  0x40204000 0 0x10000000>; /* non-prefetchable memory */
> > +	};
> 
> An unrelated comment: your first "reg" field seems to overlap with part
> of your configuration space. Is that intentional?

Yes, intentional.
But, I will try to remove it.

> 
> Also, shouldn't your memory space end on a 256MB boundary, rather than
> extend up to 0x50203fff?

According to the manual of Exynos PCIe, each memory space for Exynos PCIe
can support 512MB, including I/O, CFG regions.

Is there any problem when over 256MB boundary is used?
Please let me know. :)


Best regards,
Jingoo Han

> 
> 	Arnd

