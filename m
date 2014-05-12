Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:23405 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbaELBoK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 11 May 2014 21:44:10 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Arnd Bergmann' <arnd@arndb.de>,
	'Santosh Shilimkar' <santosh.shilimkar@ti.com>,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	rogerq@ti.com, balajitk@ti.com,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Marek Vasut' <marex@denx.de>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <4764413.ZAEU5S5p0p@wuerfel> <000201cf6a9c$9dd295e0$d977c1a0$%han@samsung.com>
 <6882241.amuhzvbd8n@wuerfel> <536CC0F1.301@ti.com>
In-reply-to: <536CC0F1.301@ti.com>
Subject: Re: [PATCH 06/17] pci: host: pcie-designware: Use *base-mask* for
 configuring the iATU
Date: Mon, 12 May 2014 10:44:07 +0900
Message-id: <006501cf6d83$a9f39510$fddabf30$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, May 09, 2014 8:50 PM, Kishon Vijay Abraham I wrote:
> On Thursday 08 May 2014 02:48 PM, Arnd Bergmann wrote:
> > On Thursday 08 May 2014 18:05:11 Jingoo Han wrote:
> >> On Tuesday, May 06, 2014 10:59 PM, Arnd Bergmann wrote:
> >>> On Tuesday 06 May 2014 19:03:52 Kishon Vijay Abraham I wrote:
> >>>> In DRA7, the cpu sees 32bit address, but the pcie controller can see only 28bit
> >>>> address. So whenever the cpu issues a read/write request, the 4 most
> >>>> significant bits are used by L3 to determine the target controller.
> >>>> For example, the cpu reserves 0x2000_0000 - 0x2FFF_FFFF for PCIe controller but
> >>>> the PCIe controller will see only (0x000_0000 - 0xFFF_FFF). So for programming
> >>>> the outbound translation window the *base* should be programmed as 0x000_0000.
> >>>> Whenever we try to write to say 0x2000_0000, it will be translated to whatever
> >>>> we have programmed in the translation window with base as 0x000_0000.
> >>>>
> >>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>>> Cc: Marek Vasut <marex@denx.de>
> >>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>> Acked-by: Jingoo Han <jg1.han@samsung.com>
> >>>> Acked-by: Mohit Kumar <mohit.kumar@st.com>
> >>>
> >>> Sorry, but NAK.
> >>>
> >>> We have a standard 'dma-ranges' property to handle this, so use it.
> >>>
> >>> See the x-gene PCIe driver patches for an example. Please also talk
> >>> to Santosh about it, as he is implementing generic support for
> >>> parsing dma-ranges in platform devices at the moment.
> >>
> >> Hi Arnd,
> >>
> >> Do you mean the following patch?
> >> http://www.spinics.net/lists/kernel/msg1737725.html
> >>
> >
> > That is the patch Santosh did for platform devices, which is related but not
> > what I meant here. For the PCI inbound window setup, please have a look
> > at https://lkml.org/lkml/2014/3/19/607
> 
> For some reason lkml is not showing any contents. Do you have a different link?

Hi Kishon,

Please refer to the following link. :-)
http://www.spinics.net/lists/linux-pci/msg29855.html


Best regards,
Jingoo Han

