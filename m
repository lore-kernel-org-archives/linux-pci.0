Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from m12-18.163.com ([220.181.12.18]:60846 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbeIKQSL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Sep 2018 12:18:11 -0400
Subject: Re: [PATCH] pci: dwc: pcie_designware: Fix a sleep-in-atomic-context
 bug in dw_pcie_prog_outbound_atu
To: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180902033811.26858-1-baijiaju1990@gmail.com>
 <a21f3cc1-d593-edf7-19d1-3917cf5d5c98@synopsys.com>
From: Jia-Ju Bai <baijiaju1990@163.com>
Message-ID: <ba4cc984-48c7-f940-f1ea-903113ace1d2@163.com>
Date: Tue, 11 Sep 2018 19:18:38 +0800
MIME-Version: 1.0
In-Reply-To: <a21f3cc1-d593-edf7-19d1-3917cf5d5c98@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2018/9/11 16:40, Gustavo Pimentel wrote:
> Hi Jia,
>
> On 02/09/2018 04:38, Jia-Ju Bai wrote:
>> The driver may sleep with holding a spinlock and in an interupt handler.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] usleep_range
>> drivers/pci/dwc/pcie-designware.c, 181:
>> 	usleep_range in dw_pcie_prog_outbound_atu
>> drivers/pci/dwc/pcie-designware-host.c, 479:
>> 	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
>> drivers/pci/dwc/pcie-designware-host.c, 561:
>> 	dw_pcie_rd_other_conf in dw_pcie_rd_conf
>> drivers/pci/access.c, 66:
>> 	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
>> drivers/pci/access.c, 918:
>> 	pci_bus_read_config_word in pci_read_config_word
>> drivers/block/umem.c, 630:
>> 	pci_read_config_word in mm_interrupt (interrupt handler)
>>
>> [FUNC] usleep_range
>> drivers/pci/dwc/pcie-designware.c, 181:
>> 	usleep_range in dw_pcie_prog_outbound_atu
>> drivers/pci/dwc/pcie-designware-host.c, 479:
>> 	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
>> drivers/pci/dwc/pcie-designware-host.c, 561:
>> 	dw_pcie_rd_other_conf in dw_pcie_rd_conf
>> drivers/pci/access.c, 66:
>> 	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
>> drivers/pci/access.c, 918:
>> 	pci_bus_read_config_word in pci_read_config_word
>> drivers/ata/pata_efar.c, 115:
>> 	pci_read_config_word in efar_set_piomode
>> drivers/ata/pata_efar.c, 113:
>> 	_raw_spin_lock_irqsave in efar_set_piomod
>>
>> [FUNC] usleep_range
>> drivers/pci/dwc/pcie-designware.c, 181:
>> 	usleep_range in dw_pcie_prog_outbound_atu
>> drivers/pci/dwc/pcie-designware-host.c, 479:
>> 	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
>> drivers/pci/dwc/pcie-designware-host.c, 561:
>> 	dw_pcie_rd_other_conf in dw_pcie_rd_conf
>> drivers/pci/access.c, 66:
>> 	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
>> drivers/pci/access.c, 918:
>> 	pci_bus_read_config_word in pci_read_config_word
>> drivers/block/mtip32xx/mtip32xx.c, 158:
>> 	pci_read_config_word in mtip_check_surprise_removal
>> drivers/block/mtip32xx/mtip32xx.c, 843:
>> 	mtip_check_surprise_removal in mtip_handle_irq
>> drivers/block/mtip32xx/mtip32xx.c, 879:
>> 	mtip_handle_irq in mtip_irq_handler (interrupt handler)
>>
>> [FUNC] usleep_range
>> drivers/pci/dwc/pcie-designware.c, 181:
>> 	usleep_range in dw_pcie_prog_outbound_atu
>> drivers/pci/dwc/pcie-designware-host.c, 479:
>> 	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
>> drivers/pci/dwc/pcie-designware-host.c, 561:
>> 	dw_pcie_rd_other_conf in dw_pcie_rd_conf
>> drivers/pci/access.c, 66:
>> 	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
>> drivers/pci/access.c, 918:
>> 	pci_bus_read_config_word in pci_read_config_word
>> drivers/gpu/vga/vgaarb.c, 645:
>> 	pci_read_config_word in vga_arbiter_add_pci_device
>> drivers/gpu/vga/vgaarb.c, 629:
>> 	_raw_spin_lock_irqsave in vga_arbiter_add_pci_device
>>
>> [FUNC] usleep_range
>> drivers/pci/dwc/pcie-designware.c, 181:
>> 	usleep_range in dw_pcie_prog_outbound_atu
>> drivers/pci/dwc/pcie-designware-host.c, 479:
>> 	dw_pcie_prog_outbound_atu in dw_pcie_rd_other_conf
>> drivers/pci/dwc/pcie-designware-host.c, 561:
>> 	dw_pcie_rd_other_conf in dw_pcie_rd_conf
>> drivers/pci/access.c, 66:
>> 	[FUNC_PTR]dw_pcie_rd_conf in pci_bus_read_config_word
>> drivers/pci/access.c, 918:
>> 	pci_bus_read_config_word in pci_read_config_word
>> drivers/pci/ats.c, 139:
>> 	pci_read_config_word in pci_ats_queue_depth
>> drivers/iommu/intel-iommu.c, 1519:
>> 	pci_ats_queue_depth in iommu_enable_dev_iotlb
>> drivers/iommu/intel-iommu.c, 5295:
>> 	iommu_enable_dev_iotlb in intel_iommu_enable_pasid
>> drivers/iommu/intel-iommu.c, 5241:
>> 	_raw_spin_lock_irqsave in intel_iommu_enable_pasid
>>
>> To fix this bug, usleep_range() is replaced with udelay().
>>
>> This bug is found by my static analysis tool DSAC.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 778c4f76a884..7f50f7e51543 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>>   		if (val & PCIE_ATU_ENABLE)
>>   			return;
>>   
>> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
>> +		udelay(LINK_WAIT_IATU_MAX);
> You might use the mdelay instead of udelay, however this fix and others were
> already made on patch on [1]
>
> [1] https://lkml.org/lkml/2018/9/10/284
>

Okay, that is good.


Best wishes,
Jia-Ju Bai
