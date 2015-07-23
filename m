Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36561 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbbGWMuh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jul 2015 08:50:37 -0400
Message-ID: <55B0E317.9030700@ti.com>
Date: Thu, 23 Jul 2015 18:20:31 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Jingoo Han <jingoohan1@gmail.com>
CC: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
Subject: Re: [PATCH 2/3] PCI: host: pcie-designware: add support for suspend
 and resume
References: <1435921425-15121-1-git-send-email-kishon@ti.com> <1435921425-15121-3-git-send-email-kishon@ti.com> <000301d0bc8d$e067e420$a137ac60$@com>
In-Reply-To: <000301d0bc8d$e067e420$a137ac60$@com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Sunday 12 July 2015 04:01 PM, Jingoo Han wrote:
> On Friday, July 03, 2015 8:04 PM, Kishon Vijay Abraham I wrote:
>>
>> Certain platforms require MSE bit to be cleared to set the master
>> in standby mode. (In DRA7xx TRM_vE, section 24.9.4.5.2.2.1 PCIe
> 
> This patch is a work-around specific for DRA7xx chips?
> If so, please move this patch to 'pci-dra7xx.c'.
> I don't want to include chip-specific codes, because
> 'pcie-designware.c' is designed for including common codes.

Alright. Will change it that way in the next version.

Thanks
Kishon
> 
> Best regards,
> Jingoo Han
> 
>> Controller Master Standby Behavior advises to use the clearing
>> of the local MSE bit to set the master in standby. Without this
>> some of the clocks do not idle).
>>
>> Cleared the MSE bit on suspend and enabled it back on resume.
>> This is required to get suspend/resume working.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>  drivers/pci/host/pcie-designware.c |   20 ++++++++++++++++++++
>>  drivers/pci/host/pcie-designware.h |    2 ++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> index 69486be..cfb2bd6 100644
>> --- a/drivers/pci/host/pcie-designware.c
>> +++ b/drivers/pci/host/pcie-designware.c
>> @@ -811,6 +811,26 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>  	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
>>  }
>>
>> +void dw_pcie_suspend_rc(struct pcie_port *pp)
>> +{
>> +	u32 val;
>> +
>> +	/* clear MSE */
>> +	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
>> +	val &= ~PCI_COMMAND_MEMORY;
>> +	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
>> +}
>> +
>> +void dw_pcie_resume_rc(struct pcie_port *pp)
>> +{
>> +	u32 val;
>> +
>> +	/* set MSE */
>> +	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
>> +	val |= PCI_COMMAND_MEMORY;
>> +	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
>> +}
>> +
>>  MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
>>  MODULE_DESCRIPTION("Designware PCIe host controller driver");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
>> index d0bbd27..0df2dfa 100644
>> --- a/drivers/pci/host/pcie-designware.h
>> +++ b/drivers/pci/host/pcie-designware.h
>> @@ -83,5 +83,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>>  int dw_pcie_link_up(struct pcie_port *pp);
>>  void dw_pcie_setup_rc(struct pcie_port *pp);
>>  int dw_pcie_host_init(struct pcie_port *pp);
>> +void dw_pcie_suspend_rc(struct pcie_port *pp);
>> +void dw_pcie_resume_rc(struct pcie_port *pp);
>>
>>  #endif /* _PCIE_DESIGNWARE_H */
>> --
>> 1.7.9.5
> 
