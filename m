Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:36422 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751192AbaBZKxg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 05:53:36 -0500
Date: Wed, 26 Feb 2014 16:22:12 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
	"jg1.han@samsung.com" <jg1.han@samsung.com>
Cc: Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io and
 mem viewport
Message-ID: <20140226105212.GE4222@pratyush-vbox>
References: <17773172.14231392946292058.JavaMail.weblogic@epml01>
 <5306E3FE.1070405@ti.com>
 <530D8A40.2070707@st.com>
 <530D9C0F.30200@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <530D9C0F.30200@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 26, 2014 at 03:47:27PM +0800, Kishon Vijay Abraham I wrote:
> On Wednesday 26 February 2014 12:01 PM, Ajay Khandelwal wrote:
> > Hi Kishon,
> > 
> > On 2/21/2014 10:58 AM, Kishon Vijay Abraham I wrote:
> >> Thanks for the patch. I have just burnt my PCIE-to-PCI bridge card :-s Will
> >> test this once I get a new card.
> > 
> > were you able to solve issue in PCIE-to-PCI bridge.
> 
> oh yes. I was giving the total configuration space as 4k (2k for cfg0 and  2k
> for cfg1). But there was some problem when I write 0x800 to
> PCIE_ATU_LOWER_BASE. If I read back PCIE_ATU_LOWER_BASE after writing 0x800, it
> has 0x0.
> 
> So I increased the configuration space to 8k (4k for cfg0 and  4k for cfg1).
> With this I write 0x1000 to  PCIE_ATU_LOWER_BASE and able to enumerate devices
> behind a PCIE-to-PCI bridge.

As per designware specs minimum value of CX_ATU_MIN_REGION_SIZE is 4 KB.
Depending on the SOC it can be configured from 4 to 64KB. So you can
not have an address translation unit less than 4 KB in any SOC.

I think, it would be worth to mention this information in designware pcie binding
documentation.

However I am surprised, how does it work in case of exynos. Jingoo??
Size of configuration space passed from DT is 0x1000 in exynos. As per
my understanding (and what snps specs says), this value should be
minimum 0x2000 in any SOC, as we divide this space equally for cfg0 and
cfg1 in driver.

Regards
Pratysuh

> > 
> > On SPEAr I see issues with PCIe to PCI bridge and PCIe to PCIe switch.
> > 
> > Imprecise external abort is generated, providing hook for abort(similar
> > to imx6) solves this.
> 
> But this issue seems to be different :-s
> 
> Thanks
> Kishon
