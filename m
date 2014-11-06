Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14201 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaKFF1X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Nov 2014 00:27:23 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEL008RQR5M6950@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 06 Nov 2014 14:27:22 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <001301cff95e$a124f6b0$e36ee410$%han@samsung.com>
 <545B01F1.7070009@ti.com>
In-reply-to: <545B01F1.7070009@ti.com>
Subject: Re: [PATCH] PCI: dra7xx: Add dra7xx prefix before add_pcie_port
Date: Thu, 06 Nov 2014 14:27:56 +0900
Message-id: <001b01cff982$6ba565a0$42f030e0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, November 06, 2014 2:07 PM, Kishon Vijay Abraham I wrote:
> 
> On Thursday 06 November 2014 06:41 AM, Jingoo Han wrote:
> > The add_pcie_port function is dra7xx-specific. Add exynos prefix
> > to avoid collision in global name space.
> 
> %s/exynos/dra7xx

Sorry, it is my bad. I will send patch v2 soon.

> 
> After fixing this you can add
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

I appreciated you Acked-by.

Best regards,
Jingoo Han

> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/pci/host/pci-dra7xx.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)

