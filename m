Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42557 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510AbaHGDB6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 23:01:58 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N9X00KX91R7JY10@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 07 Aug 2014 12:01:56 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Fabio Estevam' <festevam@gmail.com>
Cc: kishon@ti.com, 'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Shawn Guo' <shawn.guo@freescale.com>,
	=?UTF-8?Q?'Marek_Va=C5=A1ut'?= <marex@denx.de>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Sascha Hauer' <kernel@pengutronix.de>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <CAOMZO5CmDa4=AcHZpWcaLanDZQ3fXNfQbcN_0Oc04MWPw9bY1Q@mail.gmail.com>
 <20140806043204.GA2755@pratyush-vbox>
 <1407314357.5208.2.camel@weser.hi.pengutronix.de>
In-reply-to: <1407314357.5208.2.camel@weser.hi.pengutronix.de>
Subject: Re: designware: missing *config* reg space
Date: Thu, 07 Aug 2014 12:01:55 +0900
Message-id: <001901cfb1eb$f22cd8d0$d6868a70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 06, 2014 5:39 PM, Lucas Stach wrote:
> 
> Am Mittwoch, den 06.08.2014, 10:02 +0530 schrieb Pratyush Anand:
> > On Wed, Aug 06, 2014 at 02:26:10AM +0800, Fabio Estevam wrote:
> > > Hi,
> > >
> > > I am running linux-next 20140805 on a imx6q-sabresd board and noticed
> > > the following error:
> > >
> > > root@freescale /$ dmesg | grep pci
> > > [    0.168095] imx6q-pcie 1ffc000.pcie: missing *config* reg space
> > > [    0.501019] imx6q-pcie 1ffc000.pcie: phy link never came up
> > > [    0.501579] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> > >
> > > This 'missing *config* reg space' was introduced by:
> >
> > dev_err printing the above message should be dev_dbg until all the
> > platform specifies its configuration space definition through *reg*
> > instead of *ranges*.
> >
> No it's completely right. Printing errors actually triggers people to
> fix their DTs.

I agree with Lucas Stach's opinion.
Printing errors is necessary to let people change to fix the DT.
According to the DT spec, using *ranges* is wrong. So, dev_err()
can be used.

> 
> > > commit 4dd964df36d0e548e1806ec2ec275b62d4dc46e8
> > > Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > Date:   Thu Jul 17 14:30:40 2014 +0530
> > >
> > >     PCI: designware: Look for configuration space in 'reg', not 'ranges'
> > >
> > >     The configuration address space has so far been specified in *ranges*,
> > >     however it should be specified in *reg* making it a platform MEM resource.
> > >     Hence used 'platform_get_resource_*' API to get configuration address space
> > >     in the designware driver.
> > >
> > >     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > >     Acked-by: Mohit Kumar <mohit.kumar@st.com>
> > >     Acked-by: Jingoo Han <jg1.han@samsung.com>
> > >     Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > >     Cc: Marek Vasut <marex@denx.de>
> > >     Cc: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Wouldn't this break dt compatibility?
> >
> > In spite of the above missing *config* message, your system should
> > work fine. This patch should not affect any older platform.They will
> > assign their cfg space through restype == 0.
> >
> As Pratyush said things should work fine despite this warning. I'll send
> a DT patch out to Shawn today to get rid of this warning.

Good! :-)

Best regards,
Jingoo Han

> 
> Regards,
> Lucas
> --
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |

