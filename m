Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:48967 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3KOP5f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 10:57:35 -0500
From: Marek Vasut <marex@denx.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [QUERY] Number of address translation regions in designware
Date: Fri, 15 Nov 2013 16:37:53 +0100
Cc: "'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	linux-pci@vger.kernel.org,
	"'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	"'Ajay KHANDELWAL'" <ajay.khandelwal@st.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>
References: <52652BF1.4040507@ti.com> <5285B0E7.5000802@ti.com> <000901cee1c9$d8ec6450$8ac52cf0$%han@samsung.com>
In-Reply-To: <000901cee1c9$d8ec6450$8ac52cf0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201311151637.53867.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon, Jingoo,

> On Friday, November 15, 2013 2:28 PM, Kishon Vijay Abraham I wrote:
> > On Friday 15 November 2013 06:10 AM, Marek Vasut wrote:
> > > Hi Kishon,
> > > 
> > > just curious, what's the current status of the DWC PCIe driver? How's
> > > the iATU issue going? Can you please update us a little?
> > 
> > I was able to get it working in DRA7. Few of the dependent stuffs are not
> > in mainline yet (some clock related patches, rest framework changes, PHY
> > changes). Will post a RFC soon for pcie only part.
> 
> OK, I see.
> If you send the RFC patch, I will review ant test your patch
> as soon as possible. Thank you for your effort. :-)

DTTO here, I can test it on MX6 as well. If you can roll out a prototype, I'm 
sure we can help in some ways too :)

Best regards,
Marek Vasut
