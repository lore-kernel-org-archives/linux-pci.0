Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:36496 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab3KAMhp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Nov 2013 08:37:45 -0400
From: Marek Vasut <marex@denx.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [QUERY] Number of address translation regions in designware
Date: Fri, 1 Nov 2013 13:37:40 +0100
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Tim Harvey <tharvey@gateworks.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>
References: <52652BF1.4040507@ti.com> <5267EF1E.1010101@ti.com> <20131029071015.GB2297@pratyush-vbox>
In-Reply-To: <20131029071015.GB2297@pratyush-vbox>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201311011337.40181.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

> + Marek, Tim, arnd
> 
> Hi Kishon,
> 
> On Wed, Oct 23, 2013 at 11:45:34PM +0800, Kishon Vijay Abraham I wrote:
> > Hi Pratyush,
> > 
> > On Wednesday 23 October 2013 10:06 AM, Pratyush Anand wrote:
> > > Hi Kishon,
> > > 
> > > On Tue, Oct 22, 2013 at 10:20:01PM +0800, Kishon Vijay Abraham I wrote:
> > >> Hi Pratyush, Jingoo,
> > >> 
> > >> On Tuesday 22 October 2013 10:46 AM, Jingoo Han wrote:
> > >>> On Monday, October 21, 2013 10:28 PM, Kishon Vijay Abraham I wrote:
> > >>>> Currently I see in pcie-designware.c we use only 2 ATU regions. We
> > >>>> re-use INDEX0 for mem outbound and cfg0, and INDEX1 for cfg1 and
> > >>>> io. So I'd like to know if in your platform, do you have only 2
> > >>>> address translation regions? In DRA7xx we have 16 outbound regions
> > >>>> and 4 inbound regions.
> > >>> 
> > >>> In Exynos, there are only 2 inbound and 2 outbound viewpoints.

Jumping in a tad late, MX6 has 4 inbound and 4 outbound according to MX6DQRM 
Rev. 1, 04/2013 sections:
- 48.3.9.1.1 (bullet 8)
- 48.3.9.1.2 (bullet 7)
- 48.10.42 (Region_Index description in the table PCIE_PL_iATUVR)

Best regards,
Marek Vasut
