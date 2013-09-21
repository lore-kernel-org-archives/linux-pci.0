Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63180 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab3IUWDt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 21 Sep 2013 18:03:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH V3] pci: exynos: split into two parts such as Synopsys part and Exynos part
Date: Sun, 22 Sep 2013 00:03:34 +0200
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	"'Kukjin Kim'" <kgene.kim@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	"'Sean Cross'" <xobs@kosagi.com>,
	"'Thierry Reding'" <thierry.reding@gmail.com>,
	"'SRIKANTH TUMKUR SHIVANAND'" <ts.srikanth@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <000701ce8741$fe47deb0$fad79c10$@samsung.com> <20130912104602.GC5995@pratyush-vbox> <523DB38B.4070307@ti.com>
In-Reply-To: <523DB38B.4070307@ti.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309220003.34732.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 21 September 2013, Kishon Vijay Abraham I wrote:
> {
>         u32 val;
>         void __iomem *val1;
>         void __iomem *dbi_base = pp->dbi_base;
> 
>         /* Program viewport 0 : INBOUND : MEMORY*/
>         val = PCIE_ATU_REGION_INBOUND | (0 & 0xF);
>         dw_pcie_writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
>         val1 = ioremap(0x80000000, 0x5fffffff);

The ioremap here makes no sense at all, and I suspect it will fail anyway,
because you exhaust the vmalloc area size, but since the value is not
used anywhere, it won't matter.

>         dw_pcie_writel_rc(pp, 0x80000000, dbi_base + PCIE_ATU_LOWER_BASE);
>         dw_pcie_writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
>         /* in_mem_size must be in power of 2 */
>         dw_pcie_writel_rc(pp, 0x5FFFFFFF, dbi_base + PCIE_ATU_LIMIT);
>         dw_pcie_writel_rc(pp, 0x80000000, dbi_base + PCIE_ATU_LOWER_TARGET);
>         dw_pcie_writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);

These numbers need to come from somewhere, you shouldn't just hardcode them, 

I guess you should either program an inbound window covering the entire 64-bit
address space, or you should look at the top-level "memory" nodes to find
the location of physical RAM.

I can't see anything wrong with the way it's set up though, unless you have
an IOMMU. Can you confirm that there is no IOMMU (aka SMMU) in your system
that handles the PCIe root complex?

> I somehow starting to doubt the DMA address programmed in the ethernet card
> which is in my RAM address range (0x80000000 to 0xBFFFFFFF). Should this
> address be programmed in the BAR of the ethernet card? How should it be done?

No, it should not be in the BAR. The ethernet device driver calls dma_map_*
or pci_map_* interfaces to get a valid token that can be passed into the
device registers that are starting the DMA. You have to ensure that the
dma_map_ops for the device return the value that is set up in the translation.

The normal case is an identity mapping between device DMA space and host
memory space, i.e. PCIE_ATU_LOWER_TARGET == PCIE_ATU_LOWER_BASE, so
in the dma_map_single implementation, phys_addr_t == dma_addr_t.

If you set up the dma_addr_t space to start at 0 instead, you have to add
the offset in the dma_map_ops.

	Arnd
