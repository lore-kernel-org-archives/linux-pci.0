Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50355 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422679Ab3FUOQM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 10:16:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH V10 0/4] PCIe support for Samsung Exynos5440 SoC
Date: Fri, 21 Jun 2013 16:14:49 +0200
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"'Kukjin Kim'" <kgene.kim@samsung.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"'Grant Likely'" <grant.likely@secretlab.ca>,
	"'Andrew Murray'" <andrew.murray@arm.com>,
	"'Thierry Reding'" <thierry.reding@avionic-design.de>,
	"'Jason Gunthorpe'" <jgunthorpe@obsidianresearch.com>,
	"'Surendranath Gurivireddy Balla'" <suren.reddy@samsung.com>,
	"'Siva Reddy Kallam'" <siva.kallam@samsung.com>,
	"'Thomas Abraham'" <thomas.abraham@linaro.org>,
	"'Tomasz Figa'" <t.figa@samsung.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	"'Mohit KUMAR'" <Mohit.KUMAR@st.com>
References: <003901ce6e50$03d039a0$0b70ace0$@samsung.com> <201306211030.47440.arnd@arndb.de> <20130621141144.GP31667@titan.lakedaemon.net>
In-Reply-To: <20130621141144.GP31667@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201306211614.49434.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 21 June 2013, Jason Cooper wrote:
> On Fri, Jun 21, 2013 at 10:30:47AM +0200, Arnd Bergmann wrote:
> > On Friday 21 June 2013, Thomas Petazzoni wrote:
> > > I am by far not an expert on how to solve merge strategies and so on,
> > > but to avoid conflicts at Linus's level while merging the arm-soc and
> > > pci trees, it would be better if this Samsung PCIe driver could go
> > > through arm-soc (with Bjorn ACK, of course), so that Arnd/Olof can
> > > make sure the ordering is correct with regard to the of/pci changes and
> > > the mvebu/pci driver.
> > 
> > Yes, good point.
> > 
> > The alternative would be that Bjorn also takes the PCI branch dependencies
> > that are already in arm-soc into his tree. Either way works, but I agree
> > that what you suggest would be simpler.
> 
> Yes, that is why we did it this way.  It was my understanding based on
> previous comments by yourself and LinusW that you both had patches
> depending on (now called) mvebu/of_pci.  So we got it into arm-soc
> early so those branches could depend on it.

Right. I wasn't paying enough attention for the early merges that
Olof did.

	Arnd
