Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Arnd Bergmann' <arnd@arndb.de>,
	'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Santosh Shilimkar' <santosh.shilimkar@ti.com>,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	rogerq@ti.com, balajitk@ti.com,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Marek Vasut' <marex@denx.de>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <1399383244-14556-7-git-send-email-kishon@ti.com> <4764413.ZAEU5S5p0p@wuerfel>
In-reply-to: <4764413.ZAEU5S5p0p@wuerfel>
Subject: Re: [PATCH 06/17] pci: host: pcie-designware: Use *base-mask* for
 configuring the iATU
Date: Thu, 08 May 2014 18:05:11 +0900
Message-id: <000201cf6a9c$9dd295e0$d977c1a0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, May 06, 2014 10:59 PM, Arnd Bergmann wrote:
> On Tuesday 06 May 2014 19:03:52 Kishon Vijay Abraham I wrote:
> > In DRA7, the cpu sees 32bit address, but the pcie controller can see only 28bit
> > address. So whenever the cpu issues a read/write request, the 4 most
> > significant bits are used by L3 to determine the target controller.
> > For example, the cpu reserves 0x2000_0000 - 0x2FFF_FFFF for PCIe controller but
> > the PCIe controller will see only (0x000_0000 - 0xFFF_FFF). So for programming
> > the outbound translation window the *base* should be programmed as 0x000_0000.
> > Whenever we try to write to say 0x2000_0000, it will be translated to whatever
> > we have programmed in the translation window with base as 0x000_0000.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Marek Vasut <marex@denx.de>
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> > Acked-by: Mohit Kumar <mohit.kumar@st.com>
> 
> Sorry, but NAK.
> 
> We have a standard 'dma-ranges' property to handle this, so use it.
> 
> See the x-gene PCIe driver patches for an example. Please also talk
> to Santosh about it, as he is implementing generic support for
> parsing dma-ranges in platform devices at the moment.

Hi Arnd,

Do you mean the following patch?
http://www.spinics.net/lists/kernel/msg1737725.html

Thank you.

Best regards,
Jingoo Han

> 
> I also suspect you will have to implement swiotlb support to make
> generic PCI devices work behind this bridge. Otherwise you end up
> with random physical addresses passed into DMA registers.


