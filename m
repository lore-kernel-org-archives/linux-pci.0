Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12991 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab3FTH5e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2013 03:57:34 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Andrew Murray' <andrew.murray@arm.com>,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	Jingoo Han <jg1.han@samsung.com>
References: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
 <20130620094835.3f1f34c2@skate>
In-reply-to: <20130620094835.3f1f34c2@skate>
Subject: Re: [PATCH V6 3/3] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
Date: Thu, 20 Jun 2013 16:57:32 +0900
Message-id: <00c301ce6d8b$d198b210$74ca1630$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 20, 2013 4:49 PM, Thomas Petazzoni wrote:
> 
> Dear Jingoo Han,
> 
> On Thu, 20 Jun 2013 16:12:24 +0900, Jingoo Han wrote:
> 
> > -	pinctrl {
> > +	pin_ctrl: pinctrl {
> >  		compatible = "samsung,exynos5440-pinctrl";
> 
> I know I'm nitpicking, but isn't this change completely unrelated to
> PCIe support?

This change is related to PCIe support.
Without this, I cannot use gpio binding.

This change was guided by Thomas Abraham (Author of Samsung pinctrl).
Also, it was confirmed by Kukjin Kim (Maintainer of Samsung SoC).

Thank you for your caring. :)

Best regards,
Jingoo Han

> 
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

