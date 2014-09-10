Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46310 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803AbaIJIZ7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Sep 2014 04:25:59 -0400
Date: Wed, 10 Sep 2014 13:55:19 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Zhudacai <zhudacai@hisilicon.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	"marex@denx.de" <marex@denx.de>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
	zhanweitao <zhanweitao@huawei.com>, <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: Designware about Arm64 supported
Message-ID: <20140910082519.GA5797@pratyush-vbox>
References: <54017B10.4090004@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <54017B10.4090004@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dacai,

Sorry for delayed response. I do not work directly with PCIe these
days. Please always keep PCI mailing list in CC.

On Sat, Aug 30, 2014 at 03:19:44PM +0800, Zhudacai wrote:
> Hi all,
> I just use the designware patch for my arm64 board' PCIe .
> 
> And here is some conflict while I patched it with the Liviu's PCI patch of ARM64.

I just had a quick look on current state of designware driver and
Liviu's V10 patchset.

As a first step,
There would be couple of things which we need to get rid of DW
driver, before it is usable with generic pci support. 

-- Replace pci_common_init_dev with following:

        dw_pcie_setup
        pci_scan_root_bus (should help in getting rid of  dw_pcie_scan_bus)

-- Get rid of 'struct hw_pci dw_pci' and 'sys_to_pcie(struct
pci_sys_data *sys)'

-- in order to get rid of dw_pci, you might need
        to add following for arch/arm, so that existing platform works:
                pcibios_add_device : (should help in getting rid of  dw_pcie_map_irq)

-- of_pci_get_host_bridge_resources can be used (may be with some
modification) to cleanup most of the code of dw_pcie_host_init.

-- Above should help in working with intx. To use msi, I think you might
need to work on core layer a bit. One easiest way, could be to modify
pci_scan_root_bus to accept struct msi_chip as additional argument and
assign msi_chip to bus->msi in this function. 


> 
> however, it's will be accepted at kernel version 3.18 about Liviu's PCI patch of ARM64
> (http://patchwork.ozlabs.org/patch/379423/).
> 
> so ,I wondered if you have some follow-up plan with the designware patch on arm64.

I think Mohit/Jingoo can comment here. What I know, they do not have
ARM64 bit platform, so they might not be able to work for designware
patch on arm64. But yes, I agree that designware can be modified on
top of Liviu's patch to work with ARM 32 bit, while independent of
arch/arm/kernel/bios32.c code.

~Pratyush
> 
> Best regards
> 
> Dacai
> 
