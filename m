Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8989 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161292Ab3FUEic (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 00:38:32 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Pratyush Anand' <pratyush.anand@st.com>
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
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
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>
References: <002001ce6e2e$623d7970$26b86c50$@samsung.com>
 <51C3D517.1080301@st.com>
In-reply-to: <51C3D517.1080301@st.com>
Subject: Re: [PATCH V9 1/4] pci: Add PCIe driver for Samsung Exynos
Date: Fri, 21 Jun 2013 13:38:29 +0900
Message-id: <003601ce6e39$2dd30b40$897921c0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, June 21, 2013 1:23 PM, Pratyush Anand wrote:
> On 6/21/2013 8:51 AM, Jingoo Han wrote:
> > diff --git a/drivers/pci/host/pci-designware.c b/drivers/pci/host/pci-designware.c
> > new file mode 100644
> > index 0000000..f8558ff
> > --- /dev/null
> > +++ b/drivers/pci/host/pci-designware.c
> 
> If you plan to send next version, then I would suggest to rename it as
> pcie-designware.c, because synopsis pcie and pci controllers are different.

OK, I see.
I rename it as 'pcie-designware.c'.
Thank you for your suggestion. :)

Best regards,
Jingoo Han

> 
> Regards
> Pratyush
> 
> 


