Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32804 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab3LME5J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 23:57:09 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXQ00HSBB37TWC0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 13 Dec 2013 13:57:07 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org
Cc: linux-pci@vger.kernel.org,
	'Pratyush ANAND' <pratyush.anand@st.com>,
	'Viresh Kumar' <viresh.linux@gmail.com>,
	'spear-devel' <spear-devel@list.st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <f5c9cbbd116d462c428afc2e8afefd95aad8c6ec.1386752447.git.mohit.kumar@st.com>
 <201312120000.54545.arnd@arndb.de>
 <2CC2A0A4A178534D93D5159BF3BCB66189F95F66A2@EAPEX1MAIL1.st.com>
In-reply-to: <2CC2A0A4A178534D93D5159BF3BCB66189F95F66A2@EAPEX1MAIL1.st.com>
Subject: Re: [PATCH 09/12] pcie: SPEAr13xx: Add designware pcie support
Date: Fri, 13 Dec 2013 13:57:06 +0900
Message-id: <002c01cef7bf$c5a7b640$50f722c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 13, 2013 1:30 PM, Mohit KUMAR DCG wrote:
> On Thursday, December 12, 2013 4:31 AM, Arnd Bergmann wrote:
> > On Wednesday 11 December 2013, Mohit Kumar wrote:

[.....]

> > > +struct spear13xx_pcie {
> > > +	void __iomem		*phy_base;
> > > +	void __iomem		*app_base;
> > > +	struct clk		*clk;
> > > +	struct pcie_port	pp;
> > > +	int			id;
> > > +	int			is_gen1;
> > > +};
> >
> > The pcie driver shouldn't have direct access to the phy registers, use a phy
> > driver for that.
> 
> - OK. In few workarounds we have to access controller as well as phy registers,
> How we should handle such cases if we separate out phy driver from here? Should it be
> through phy global functions called from pcie driver?

Arnd, do you mean the following?

1. Implement Spear PCIe PHY driver using General PHY framework.
  ./drivers/phy/phy-spear13xx-pcie.c

2. Call General PHY APIs
  ./drivers/pci/host/pcie-spear13xx.c
  #include <linux/phy/phy.h>

  pp->phy = devm_phy_get(pp->dev, ...);

  phy_power_on(pp->phy);

  phy_power_off(pp->phy);


Best regards,
Jingoo Han

