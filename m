Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:41884 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeFALHZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 07:07:25 -0400
Subject: Re: [PATCH v2 4/7] PCI: dwc: Rework MSI callbacks handler
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1526576613.git.gustavo.pimentel@synopsys.com>
 <9558d4fcd6f888599e3b70133f1f242c7a6664ee.1526576613.git.gustavo.pimentel@synopsys.com>
 <ba3df388-9ec1-fe87-e575-0eddc5a565b7@ti.com>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <8e4a3cf2-51e2-58b8-3745-06dde8f8f7c1@synopsys.com>
Date: Fri, 1 Jun 2018 12:05:35 +0100
MIME-Version: 1.0
In-Reply-To: <ba3df388-9ec1-fe87-e575-0eddc5a565b7@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31/05/2018 11:54, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 17 May 2018 10:39 PM, Gustavo Pimentel wrote:
>> Remove duplicate defines located on pcie-designware.h file already
>> available on /include/uapi/linux/pci-regs.h file.
>>
>> Add pci_epc_set_msi() maximum 32 interrupts validation.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v1->v2:
>>  - Nothing changed, just to follow the patch set version.
>>
>>  drivers/pci/dwc/pcie-designware-ep.c | 49 ++++++++++++++++++++++++------------
>>  drivers/pci/dwc/pcie-designware.h    | 11 --------
>>  drivers/pci/endpoint/pci-epc-core.c  |  3 ++-
>>  3 files changed, 35 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
>> index e5f2377..a4baa0d 100644
>> --- a/drivers/pci/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>> @@ -246,29 +246,38 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
>>  
>>  static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no)
>>  {
>> -	int val;
>>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 val, reg;
>> +
>> +	if (!ep->msi_cap)
> 
> Ah, msi_cap is used here.
>> +		return 0;
> 
> return -EINVAL.

Another copy & paste issue :)

>>  
>> -	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
>> -	if (!(val & MSI_CAP_MSI_EN_MASK))
>> +	reg = ep->msi_cap + PCI_MSI_FLAGS;
>> +	val = dw_pcie_readw_dbi(pci, reg);
>> +	if (!(val & PCI_MSI_FLAGS_ENABLE))
>>  		return -EINVAL;
>>  
>> -	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
>> +	val = (val & PCI_MSI_FLAGS_QSIZE) >> 4;
>> +
>>  	return val;
>>  }
>>  
>> -static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
>> +static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
>>  {
>> -	int val;
>>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 val, reg;
>>  
>> -	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
>> -	val &= ~MSI_CAP_MMC_MASK;
>> -	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
>> +	if (!ep->msi_cap)
>> +		return 0;
> 
> return -EINVAL.

Another copy & paste issue :)

>> +
>> +	reg = ep->msi_cap + PCI_MSI_FLAGS;
>> +	val = dw_pcie_readw_dbi(pci, reg);
>> +	val &= ~PCI_MSI_FLAGS_QMASK;
>> +	val |= (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
>>  	dw_pcie_dbi_ro_wr_en(pci);
>> -	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
>> +	dw_pcie_writew_dbi(pci, reg, val);
>>  	dw_pcie_dbi_ro_wr_dis(pci);
>>  
>>  	return 0;
>> @@ -367,21 +376,29 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>  	struct pci_epc *epc = ep->epc;
>>  	u16 msg_ctrl, msg_data;
>> -	u32 msg_addr_lower, msg_addr_upper;
>> +	u32 msg_addr_lower, msg_addr_upper, reg;
>>  	u64 msg_addr;
>>  	bool has_upper;
>>  	int ret;
>>  
>> +	if (!ep->msi_cap)
>> +		return 0;
> 
> return -EINVAL.

Another copy & paste issue :)

> 
> Thanks
> Kishon
> 
