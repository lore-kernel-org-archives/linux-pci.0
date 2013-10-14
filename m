Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28610 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab3JNCd5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Oct 2013 22:33:57 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUN0052L0GIYV40@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 14 Oct 2013 11:33:54 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marek Vasut' <marex@denx.de>
Cc: 'Shawn Guo' <shawn.guo@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Frank Li' <lznuaa@gmail.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Yinghai Lu' <yinghai@kernel.org>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
 <000501cec870$9aebcc80$d0c36580$%han@samsung.com>
 <201310140244.48433.marex@denx.de> <201310140317.56961.marex@denx.de>
In-reply-to: <201310140317.56961.marex@denx.de>
Subject: Re: [PATCH 1/2] PCI: imx6: Make reset-gpio optional
Date: Mon, 14 Oct 2013 11:33:54 +0900
Message-id: <000401cec885$d3567fb0$7a037f10$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, October 14, 2013 10:18 AM, Marek Vasut wrote:
> > > On Saturday, October 12, 2013 6:29 PM, Marek Vasut wrote:
> > > > > On Fri, Oct 11, 2013 at 04:12:31AM +0200, Marek Vasut wrote:

[.....]

> > > +cc Kishon Vijay Abraham I, Pratyush Anand, Mohit KUMAR
> > >
> > > Yes, right.
> > > "reset-gpio" property can be moved to an optional property.
> > > Also, the patch to fix 'Designware' part such as 'designware-pcie.txt'
> > > can be shared with other related people as below.
> > >
> > >   - Samsung Exynos PCIe: Jingoo Han
> > >   - ST Spear PCIe: Pratyush Anand, Mohit KUMAR
> > >   - TI OMAP PCIe: Kishon Vijay Abraham I
> >
> > I'm in the process of rebasing the patches on top of next 2013-10-10. Right
> > now I'm getting a crash in __write_msi_msg() when my Intel "igb" reports
> > "enabling bus mastering" . Any quick idea? Seems like this MSI support is
> > new in the pcie- designware.c .
> >
> > I'll just start plumbing to see what it is.
> 
> Looks like irq_alloc_descs() return -EEXIST for me in assign_irq() . Noone
> checks the return value of it , so it can fail later on ;-) Now, why does it
> return -EEXIST in the first place? I'm sure someone more experienced with PCI
> would know right away .

Hi Marek,

How about applying the following patch, which was made by Pratyush Anand? :-)
I am not sure; however, the patch resolved some problems that were found on
OMAP PCIe and Exynos PCIe, when MSI is enabled.

"PCI: designware: Add irq_create_mapping()"

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-exynos&id=904d0e7889933fb48d921c998fd1cabb3a9d6635

Best regards,
Jingoo Han

