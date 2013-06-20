Return-Path: <linux-kernel-owner@vger.kernel.org>
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
	'Tomasz Figa' <tomasz.figa@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>
References: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
 <20130620094835.3f1f34c2@skate> <00c301ce6d8b$d198b210$74ca1630$@samsung.com>
 <20130620100013.6000458f@skate>
In-reply-to: <20130620100013.6000458f@skate>
Subject: Re: [PATCH V6 3/3] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
Date: Thu, 20 Jun 2013 17:40:13 +0900
Message-id: <00c901ce6d91$c8382010$58a86030$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 20, 2013 5:00 PM, Thomas Petazzoni wrote:
> 
> Dear Jingoo Han,
> 
> On Thu, 20 Jun 2013 16:57:32 +0900, Jingoo Han wrote:
> 
> > > > -	pinctrl {
> > > > +	pin_ctrl: pinctrl {
> > > >  		compatible = "samsung,exynos5440-pinctrl";
> > >
> > > I know I'm nitpicking, but isn't this change completely unrelated to
> > > PCIe support?
> >
> > This change is related to PCIe support.
> > Without this, I cannot use gpio binding.
> >
> > This change was guided by Thomas Abraham (Author of Samsung pinctrl).
> > Also, it was confirmed by Kukjin Kim (Maintainer of Samsung SoC).
> >
> > Thank you for your caring. :)
> 
> I mean, the change is fine for sure, but it should maybe part of a
> separate patch as it is more a fix than really the introduction of the
> PCIe controller node, as the patch title suggests. This would also for
> example allow this fix to be merged right now (for 3.11), regardless of
> what happens for the rest of your PCIe patches.
> 
CC'ed Tomasz Figa


OK, I see.
I will separate this patch to two patches, as Tomasz Figa mentioned.
(http://www.spinics.net/lists/linux-samsung-soc/msg19639.html)
Thank you.


Best regards,
Jingoo Han

