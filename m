Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56168 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbaB0BhI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 20:37:08 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1M00J8VSHUCME0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 27 Feb 2014 10:37:06 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Ajay KHANDELWAL' <ajay.khandelwal@st.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'spear-devel' <spear-devel@list.st.com>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <17773172.14231392946292058.JavaMail.weblogic@epml01>
 <5306E3FE.1070405@ti.com> <530D8A40.2070707@st.com> <530D9C0F.30200@ti.com>
 <20140226105212.GE4222@pratyush-vbox>
 <003401cf3359$cea06dc0$6be14940$%han@samsung.com>
In-reply-to: <003401cf3359$cea06dc0$6be14940$%han@samsung.com>
Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1,
 io and mem viewport
Date: Thu, 27 Feb 2014 10:37:05 +0900
Message-id: <003501cf335c$6bcb5810$43620830$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, February 27, 2014 10:18 AM, Jingoo Han wrote:
> On Wednesday, February 26, 2014 7:52 PM, Pratyush Anand wrote:
> > On Wed, Feb 26, 2014 at 03:47:27PM +0800, Kishon Vijay Abraham I wrote:
> > > On Wednesday 26 February 2014 12:01 PM, Ajay Khandelwal wrote:
> > > > Hi Kishon,
> > > >
> > > > On 2/21/2014 10:58 AM, Kishon Vijay Abraham I wrote:
> > > >> Thanks for the patch. I have just burnt my PCIE-to-PCI bridge card :-s Will
> > > >> test this once I get a new card.
> > > >
> > > > were you able to solve issue in PCIE-to-PCI bridge.
> > >
> > > oh yes. I was giving the total configuration space as 4k (2k for cfg0 and  2k
> > > for cfg1). But there was some problem when I write 0x800 to
> > > PCIE_ATU_LOWER_BASE. If I read back PCIE_ATU_LOWER_BASE after writing 0x800, it
> > > has 0x0.
> > >
> > > So I increased the configuration space to 8k (4k for cfg0 and  4k for cfg1).
> > > With this I write 0x1000 to  PCIE_ATU_LOWER_BASE and able to enumerate devices
> > > behind a PCIE-to-PCI bridge.
> >
> > As per designware specs minimum value of CX_ATU_MIN_REGION_SIZE is 4 KB.
> > Depending on the SOC it can be configured from 4 to 64KB. So you can
> > not have an address translation unit less than 4 KB in any SOC.
> 
> In the case of Exynos, the minimum value of CX_ATU_MIN_REGION_SIZE is 64KB.

Oh! Sorry.

I got the response from one of our hardware engineers
about 'CX_ATU_MIN_REGION_SIZE'. The minimum value of
CX_ATU_MIN_REGION_SIZE is 4KB.

Sorry for confusing you. :-(

Best regards,
Jingoo Han

> 
> >
> > I think, it would be worth to mention this information in designware pcie binding
> > documentation.
> >
> > However I am surprised, how does it work in case of exynos. Jingoo??
> 
> I don't know. However, there was no issue at my side.
> Currently, I am testing only Ethernet cards & SATA cards.
> 
> > Size of configuration space passed from DT is 0x1000 in exynos. As per
> > my understanding (and what snps specs says), this value should be
> > minimum 0x2000 in any SOC, as we divide this space equally for cfg0 and
> > cfg1 in driver.
> 
> I changed 'Size of configuration space passed from DT' from 0x1000 to
> 0x2000 as below:
> 
> 	ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00002000   /* configuration space */
> 		     0x81000000 0 0          0x40002000 0 0x00010000   /* downstream I/O */
>    		     0x82000000 0 0x40012000 0x40012000 0 0x1ffee000>; /* non-prefetchable memory */
> 
> Then, I tested it on Exynos platform; it works properly with
> Ethernet card.
> 
> Best regards,
> Jingoo Han
> 
> >
> > Regards
> > Pratysuh
> >
> > > >
> > > > On SPEAr I see issues with PCIe to PCI bridge and PCIe to PCIe switch.
> > > >
> > > > Imprecise external abort is generated, providing hook for abort(similar
> > > > to imx6) solves this.
> > >
> > > But this issue seems to be different :-s
> > >
> > > Thanks
> > > Kishon

