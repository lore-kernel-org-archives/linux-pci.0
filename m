Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39537 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab3GOI0K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2013 04:26:10 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org
References: <001201ce7dfa$716b3370$54419a50$@samsung.com>
 <20130711154121.GC2198@dhcp-172-17-186-34.nvidia.com>
 <000301ce7e8e$4b7d9420$e278bc60$@samsung.com>
 <20130712171529.GA9620@dhcp-172-17-186-34.nvidia.com>
In-reply-to: <20130712171529.GA9620@dhcp-172-17-186-34.nvidia.com>
Subject: Re: [PATCH V2] pci: exynos: split into two parts such as Synopsys part
 and Exynos part
Date: Mon, 15 Jul 2013 17:26:07 +0900
Message-id: <000a01ce8134$f44554f0$dccffed0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, July 13, 2013 2:16 AM, Thierry Reding wrote:
> On Fri, Jul 12, 2013 at 08:28:05AM +0900, Jingoo Han wrote:
> > On Friday, July 12, 2013 12:41 AM, Thierry Reding wrote:
> > > On Thu, Jul 11, 2013 at 02:49:43PM +0900, Jingoo Han wrote:
> > > [...]
> > > > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > > [...]
> > > >  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> > > >  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> > > > +obj-$(CONFIG_PCI_EXYNOS) += pcie-exynos.o
> > >
> > > I think we should keep these sorted alphabetically. Also Tegra and
> > > Marvell are PCIe controllers but they still use the pci- prefix instead
> > > of pcie-. Perhaps it'd be good to keep consistency here? I initially
> > > chose pci- because from a software point of view it doesn't matter all
> > > that much whether it's PCI or PCIe and because the drivers are part of
> > > the PCI subsystem. However if Exynos now uses the pcie- prefix it makes
> > > it look like Tegra and Marvell are plain old PCI.
> > >
> >
> > Hi Thierry,
> >
> > I initially chose 'pci-' prefix such as 'pci-designware.c'.
> >
> > However, Pratyush Anand suggested as below:
> > "I would suggest to rename it as pcie-designware.c,
> > because synopsis pcie and pci controllers are different."
> >
> > If you have a good idea, please give it to me. :)
> 
> Alternatively the plain old PCI variant could be suffixed -legacy or
> similar, but I guess pcie- as a prefix works okay in this case.
> 
> However I still think you should sort them properly:
> 
> 	obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> 	obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> 	obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o

Hi Thierry Reding,

Thank you for your suggestion. :)
I will use it as you guided.

Best regards,
Jingoo Han


