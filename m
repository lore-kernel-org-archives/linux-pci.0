Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53308 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbaBZHrq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 26 Feb 2014 02:47:46 -0500
Message-ID: <530D9C0F.30200@ti.com>
Date: Wed, 26 Feb 2014 13:17:27 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Ajay Khandelwal <ajay.khandelwal@st.com>
CC: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io
 and mem viewport
References: <17773172.14231392946292058.JavaMail.weblogic@epml01> <5306E3FE.1070405@ti.com> <530D8A40.2070707@st.com>
In-Reply-To: <530D8A40.2070707@st.com>
Content-Type: text/plain; charset="EUC-KR"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 26 February 2014 12:01 PM, Ajay Khandelwal wrote:
> Hi Kishon,
> 
> On 2/21/2014 10:58 AM, Kishon Vijay Abraham I wrote:
>> Thanks for the patch. I have just burnt my PCIE-to-PCI bridge card :-s Will
>> test this once I get a new card.
> 
> were you able to solve issue in PCIE-to-PCI bridge.

oh yes. I was giving the total configuration space as 4k (2k for cfg0 and  2k
for cfg1). But there was some problem when I write 0x800 to
PCIE_ATU_LOWER_BASE. If I read back PCIE_ATU_LOWER_BASE after writing 0x800, it
has 0x0.

So I increased the configuration space to 8k (4k for cfg0 and  4k for cfg1).
With this I write 0x1000 to  PCIE_ATU_LOWER_BASE and able to enumerate devices
behind a PCIE-to-PCI bridge.
> 
> On SPEAr I see issues with PCIe to PCI bridge and PCIe to PCIe switch.
> 
> Imprecise external abort is generated, providing hook for abort(similar
> to imx6) solves this.

But this issue seems to be different :-s

Thanks
Kishon
