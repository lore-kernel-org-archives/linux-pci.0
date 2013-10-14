Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:59700 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817Ab3JNDXd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Oct 2013 23:23:33 -0400
From: Marek Vasut <marex@denx.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/2] PCI: imx6: Make reset-gpio optional
Date: Mon, 14 Oct 2013 05:23:15 +0200
Cc: "'Shawn Guo'" <shawn.guo@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Frank Li'" <lznuaa@gmail.com>,
	"'Richard Zhu'" <r65037@freescale.com>,
	"'Sascha Hauer'" <s.hauer@pengutronix.de>,
	"'Sean Cross'" <xobs@kosagi.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	"'Yinghai Lu'" <yinghai@kernel.org>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	"'Mohit KUMAR'" <Mohit.KUMAR@st.com>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com> <201310140317.56961.marex@denx.de> <000401cec885$d3567fb0$7a037f10$%han@samsung.com>
In-Reply-To: <000401cec885$d3567fb0$7a037f10$%han@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310140523.15623.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Han,

> On Monday, October 14, 2013 10:18 AM, Marek Vasut wrote:
> > > > On Saturday, October 12, 2013 6:29 PM, Marek Vasut wrote:
> > > > > > On Fri, Oct 11, 2013 at 04:12:31AM +0200, Marek Vasut wrote:
> [.....]
> 
> > > > +cc Kishon Vijay Abraham I, Pratyush Anand, Mohit KUMAR
> > > > 
> > > > Yes, right.
> > > > "reset-gpio" property can be moved to an optional property.
> > > > Also, the patch to fix 'Designware' part such as
> > > > 'designware-pcie.txt' can be shared with other related people as
> > > > below.
> > > > 
> > > >   - Samsung Exynos PCIe: Jingoo Han
> > > >   - ST Spear PCIe: Pratyush Anand, Mohit KUMAR
> > > >   - TI OMAP PCIe: Kishon Vijay Abraham I
> > > 
> > > I'm in the process of rebasing the patches on top of next 2013-10-10.
> > > Right now I'm getting a crash in __write_msi_msg() when my Intel "igb"
> > > reports "enabling bus mastering" . Any quick idea? Seems like this MSI
> > > support is new in the pcie- designware.c .
> > > 
> > > I'll just start plumbing to see what it is.
> > 
> > Looks like irq_alloc_descs() return -EEXIST for me in assign_irq() .
> > Noone checks the return value of it , so it can fail later on ;-) Now,
> > why does it return -EEXIST in the first place? I'm sure someone more
> > experienced with PCI would know right away .
> 
> Hi Marek,
> 
> How about applying the following patch, which was made by Pratyush Anand?
> :-) I am not sure; however, the patch resolved some problems that were
> found on OMAP PCIe and Exynos PCIe, when MSI is enabled.
> 
> "PCI: designware: Add irq_create_mapping()"
> 
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/h
> ost-exynos&id=904d0e7889933fb48d921c998fd1cabb3a9d6635

Wow, thanks! I'll check it once I get some sleep, I've been at it for too long 
now.

btw. do you happen to have any idea why would the whole system freeze when I do 
"ifconfig up" on my PCIe-connected intel i210 ethernet adapter (driven by the 
"igb" driver)? It seems that upon reception or transmission of a single packet, 
the whole system freezes to a point where not even JTAG can break (halt) the CPU 
so I can figure out what the problem is. Interestingly enough, the whole probe 
routine of the "igb" driver finishes correctly, the hard-freeze only happens 
shortly after I see that the link is up. Any new ideas on why this might happen 
would be really helpful. Just for completeness, it seems Tim has the same issue 
on Marvell Yucon card (sky2 driver).

Thank you for your help again!

Best regards,
Marek Vasut
