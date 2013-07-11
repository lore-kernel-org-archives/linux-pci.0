Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43373 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab3GKX2I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2013 19:28:08 -0400
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
	linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
References: <001201ce7dfa$716b3370$54419a50$@samsung.com>
 <20130711154121.GC2198@dhcp-172-17-186-34.nvidia.com>
In-reply-to: <20130711154121.GC2198@dhcp-172-17-186-34.nvidia.com>
Subject: Re: [PATCH V2] pci: exynos: split into two parts such as Synopsys part
 and Exynos part
Date: Fri, 12 Jul 2013 08:28:05 +0900
Message-id: <000301ce7e8e$4b7d9420$e278bc60$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 12, 2013 12:41 AM, Thierry Reding wrote:
> On Thu, Jul 11, 2013 at 02:49:43PM +0900, Jingoo Han wrote:
> [...]
> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> [...]
> >  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> >  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> > +obj-$(CONFIG_PCI_EXYNOS) += pcie-exynos.o
> 
> I think we should keep these sorted alphabetically. Also Tegra and
> Marvell are PCIe controllers but they still use the pci- prefix instead
> of pcie-. Perhaps it'd be good to keep consistency here? I initially
> chose pci- because from a software point of view it doesn't matter all
> that much whether it's PCI or PCIe and because the drivers are part of
> the PCI subsystem. However if Exynos now uses the pcie- prefix it makes
> it look like Tegra and Marvell are plain old PCI.
> 

Hi Thierry,

I initially chose 'pci-' prefix such as 'pci-designware.c'.

However, Pratyush Anand suggested as below:
"I would suggest to rename it as pcie-designware.c,
because synopsis pcie and pci controllers are different."

If you have a good idea, please give it to me. :)
Thank you.

Best regards,
Jingoo Han


