Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:41439 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab3FYDXE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2013 23:23:04 -0400
From: Kukjin Kim <kgene.kim@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Andrew Murray' <andrew.murray@arm.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Tomasz Figa' <t.figa@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>
References: <003a01ce6e50$6d5418b0$47fc4a10$@samsung.com>
 <20130625021102.GA13310@google.com>
In-reply-to: <20130625021102.GA13310@google.com>
Subject: RE: [PATCH V10 1/4] pci: Add PCIe driver for Samsung Exynos
Date: Tue, 25 Jun 2013 12:23:03 +0900
Message-id: <007e01ce7153$4d4b0730$e7e11590$%kim@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas wrote:
> 
> On Fri, Jun 21, 2013 at 04:24:54PM +0900, Jingoo Han wrote:
> > Exynos5440 has a PCIe controller which can be used as Root Complex.
> > This driver supports a PCIe controller as Root Complex mode.
> >
> > Signed-off-by: Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Please merge this through arm-soc as you discussed.
> 
Sounds great.

Arnd, please take this series into arm-soc tree directly by yourself with my
ack on arch/exynos stuff if you want ;)

Thanks,
- Kukjin

