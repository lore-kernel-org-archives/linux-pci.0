Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20248 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302AbaHGDVF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 23:21:05 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N9X0032G2N29H40@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 07 Aug 2014 12:21:03 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Fabio Estevam' <festevam@gmail.com>
Cc: 'Lucas Stach' <l.stach@pengutronix.de>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Shawn Guo' <shawn.guo@freescale.com>,
	=?UTF-8?Q?'Marek_Va=C5=A1ut'?= <marex@denx.de>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Sascha Hauer' <kernel@pengutronix.de>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <CAOMZO5CmDa4=AcHZpWcaLanDZQ3fXNfQbcN_0Oc04MWPw9bY1Q@mail.gmail.com>
 <20140806043204.GA2755@pratyush-vbox>
 <1407314357.5208.2.camel@weser.hi.pengutronix.de>
 <001901cfb1eb$f22cd8d0$d6868a70$%han@samsung.com>
 <CAOMZO5BNSEyM+Y4PrTdm6Q=a8vQ+GL02aJmJ+dCOQ+yky0fN8A@mail.gmail.com>
In-reply-to: <CAOMZO5BNSEyM+Y4PrTdm6Q=a8vQ+GL02aJmJ+dCOQ+yky0fN8A@mail.gmail.com>
Subject: Re: designware: missing *config* reg space
Date: Thu, 07 Aug 2014 12:21:02 +0900
Message-id: <001a01cfb1ee$9dd4de60$d97e9b20$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 07, 2014 12:12 PM, Fabio Estevam wrote:
> On Thu, Aug 7, 2014 at 12:01 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> 
> > I agree with Lucas Stach's opinion.
> > Printing errors is necessary to let people change to fix the DT.
> > According to the DT spec, using *ranges* is wrong. So, dev_err()
> > can be used.
> 
> Could you please point me to a dts that uses 'config' in the PCI node,
> so I could use it as reference?

Kishon already sent the patch to use 'config' in the PCI node.
As far as I know, there is no objections. Please refer to the
following links.

[RESEND PATCH 8/8] ARM: dts: dra7: Add dt data for PCIe controller
(http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272131.html)

[PATCH v3 3/4] Documentation: pci: ti: Add dt binding documentation for PCIe in DRA7xx
(http://www.spinics.net/lists/linux-pci/msg32988.html)

Best regards,
Jingoo Han

> 
> Thanks

