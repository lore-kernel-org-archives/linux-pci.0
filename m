Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38715 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbbHNOsy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 14 Aug 2015 10:48:54 -0400
Message-ID: <55CDFFC0.40604@arm.com>
Date: Fri, 14 Aug 2015 15:48:32 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
To: Zhou Wang <wangzhou1@hisilicon.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"yuanzhichang@hisilicon.com" <yuanzhichang@hisilicon.com>,
	"zhudacai@hisilicon.com" <zhudacai@hisilicon.com>,
	"zhangjukuo@huawei.com" <zhangjukuo@huawei.com>,
	"qiuzhenfa@hisilicon.com" <qiuzhenfa@hisilicon.com>,
	"liudongdong3@huawei.com" <liudongdong3@huawei.com>,
	"qiujiang@huawei.com" <qiujiang@huawei.com>,
	"kangfenglong@huawei.com" <kangfenglong@huawei.com>,
	"xuwei5@hisilicon.com" <xuwei5@hisilicon.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
	Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v6 3/6] PCI: designware: Add ARM64 support
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com> <1438848559-232109-4-git-send-email-wangzhou1@hisilicon.com> <55C44B18.4010103@hisilicon.com>
In-Reply-To: <55C44B18.4010103@hisilicon.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/08/15 07:07, Zhou Wang wrote:
> On 2015/8/6 16:09, Zhou Wang wrote:
>> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
>> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
>> move related operations to dw_pcie_host_init.
>>
>> In past, we use:
>> pci_common_init_dev
>>       -> pcibios_init_hw
>>               -> hw->scan (dw_pcie_scan_bus)
>> to pass 0 to root_bus_nr in struct pcie_port. This patch set pp->root_bus_nr = 0
>> in each PCIe host driver which is based on pcie-designware.
>>
>> This patch also try to use of_pci_get_host_bridge_resources for ARM32 and ARM64
>> according to the suggestion for Gabriele[1]
>>
>> Finally this patch reverts commit f4c55c5a3f7f "PCI: designware: Program ATU
>> with untranslated address" based on 1/6 in this series. we delete *_mod_base in
>> pcie-designware. This was discussed in [2]
>>
>> I have compiled the driver with multi_v7_defconfig. However, I don't have
>> ARM32 PCIe related board to do test. It will be appreciated if someone could
>> help to test it.

I've tested this whole series on an ARM32 PCIe board:'Freescale i.MX6 Quad
SABRE Lite Board' with an Intel wireless card on v4.2-rc6.

I can rescan the bus, load firmware, list nearby APs, and even get MSIs
coming from the card.

Tested-By: James Morse <james.morse@arm.com>


Thanks,

James
