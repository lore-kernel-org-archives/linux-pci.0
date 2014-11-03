Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34342 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaKCLeJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Nov 2014 06:34:09 -0500
Message-ID: <1415014431.26755.1.camel@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] arm: pcibios: move to generic PCI domains
From: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Phil Edworthy' <phil.edworthy@renesas.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Murali Karicheri' <m-karicheri2@ti.com>
Date: Mon, 03 Nov 2014 12:33:51 +0100
In-Reply-To: <20141103112309.GB24433@red-moon>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
	 <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
	 <003401cff704$09755cd0$1c601670$%han@samsung.com>
	 <20141103112309.GB24433@red-moon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 03.11.2014, 11:23 +0000 schrieb Lorenzo Pieralisi:
> On Mon, Nov 03, 2014 at 01:18:12AM +0000, Jingoo Han wrote:
> > On Thursday, October 30, 2014 8:45 PM, Lorenzo Pieralisi wrote:
> > >
> > > Most if not all ARM PCI host controller device drivers either ignore the
> > > domain field in the pci_sys_data structure or just increment it every
> > > time a host controller is probed, using it as a domain counter.
> > >
> > > Therefore, instead of relying on pci_sys_data to stash the domain number
> > > in a standard location, ARM pcibios code can be moved to the newly
> > > introduced generic PCI domains code, implemented in commits:
> > >
> > > commit 41e5c0f81d3e676d671d96a0a1fafb27abfbd9
> > > ("of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr()")
> > >
> > > commit 670ba0c8883b576d0aec28bd7a838358a4be1
> > > ("PCI: Add generic domain handling")
> > >
> > > In order to assign a domain number dynamically, the ARM pcibios defines
> > > the function, called by core PCI code:
> > >
> > > void pci_bus_assign_domain_nr(...)
> > >
> > > that relies on a DT property to define the domain number or falls back to
> > > a counter; its usage replaces the current domain assignment code in PCI
> > > host controllers present in the kernel.
> > >
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > > Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > > Cc: Jingoo Han <jg1.han@samsung.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Cc: Mohit Kumar <mohit.kumar@st.com>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > 
> > (+CC Richard Zhu, Lucas Stach, Kishon Vijay Abraham I, Murali Karicheri)
> > 
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> Thank you Jingoo.
> 
> > For a long time, I have wanted the patch like this. Personally,
> > I want to increase the build coverage and keep the same binary
> > regardless of config options as possible; thus, I don't like
> > #ifdef guards such as '#ifdef CONFIG_PCI_DOMAINS'. When I submitted
> > the first patch for 'pcie-designware.c', I was not able to find
> > a way to remove '#ifdef CONFIG_PCI_DOMAINS' from 'pcie-designware.c'.
> > 
> > This patch looks good and I think that this patch will not make
> > the problem. However, I didn't test this patch with Exynos platform,
> > due to some reasons. So, I hope that other engineers test this patch
> > on other SoC platforms related to designware PCIe.
> > 
> > To Mohit Kumar (ST SPEAR13XX), Richard Zhu/Lucas Stach (IMX6)
> >     Kishon Vijay Abraham I (TI DRA7XX), Murali Karicheri (TI KEYSTONE)
> > 
> > Would you test this patch and share the result?
> > It would be very helpful. Thank you.
> 
> I am happy to wait for a week or two before asking to add this code to -next,
> it would be definitely great to get more coverage on pcie-designware.
> 
I've just tested this on i.MX6 on top of 3.18-rc3. Given that we only
use a single domain there this patch should obviously not break
anything. Testing backs this claim, so:

Tested-by: Lucas Stach <l.stach@pengutronix.de>

I also looked through the patch briefly and it seems sane to me, so this
is also:

Acked-by: Lucas Stach <l.stach@pengutronix.de>

I don't like the fact that a proper binding documentation is missing for
the "linux,pci-domain" property, but this isn't the fault of this
patchset.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

