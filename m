Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:37938 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab3C0B3y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 21:29:54 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Rob Herring' <robherring2@gmail.com>
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	linux-samsung-soc@vger.kernel.org,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Andrew Murray' <andrew.murray@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <00c301ce277b$f2790080$d76b0180$%han@samsung.com> <51521421.9020906@gmail.com>
In-reply-to: <51521421.9020906@gmail.com>
Subject: Re: [PATCH 4/6] pci: Add PCIe driver for Samsung Exynos
Date: Wed, 27 Mar 2013 10:29:51 +0900
Message-id: <005401ce2a8a$943cf780$bcb6e680$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 27, 2013 6:33 AM, Rob Herring wrote:
> 
> On 03/22/2013 11:07 PM, Jingoo Han wrote:
> > Exynos5440 has a PCIe controller which can be used as Root Complex.
> > This driver supports a PCIe controller as Root Complex mode.
> >
> > Signed-off-by: Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  .../devicetree/bindings/pci/exynos-pcie.txt        |   56 +
> >  drivers/pci/host/Kconfig                           |    5 +
> >  drivers/pci/host/Makefile                          |    1 +
> >  drivers/pci/host/pci-exynos.c                      | 1139 ++++++++++++++++++++
> >  4 files changed, 1201 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/exynos-pcie.txt
> >  create mode 100644 drivers/pci/host/Makefile
> >  create mode 100644 drivers/pci/host/pci-exynos.c
> 
> [...]
> 
> > +
> > +/* synopsis specific PCIE configuration registers*/
> 
> If this is a standard IP block, then the driver naming should reflect
> that. I suspect there are several others with the same IP block.

Sorry, I don't think so.
Only core block is a standard IP block, other parts are Exynos-specific.
So, it is hard to share with other PCIe IPs using synopsis core.

Best regards,
Jingoo Han

> 
> Rob

