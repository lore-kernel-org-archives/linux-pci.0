Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:16450 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754305AbeDCFj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2018 01:39:57 -0400
Subject: Re: [PATCH v5 06/12] PCI: designware-ep: Make dw_pcie_ep_set_bar()
 handle 64-bit BARs properly
To: Niklas Cassel <nks@flawful.org>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-7-niklas.cassel@axis.com>
 <45971780-3a46-061d-bb76-2f450401c797@ti.com>
 <20180402193703.GB23587@flawful.org>
CC: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fbb19171-5318-70c5-d6fa-9a405b5c8db4@ti.com>
Date: Tue, 3 Apr 2018 11:09:37 +0530
MIME-Version: 1.0
In-Reply-To: <20180402193703.GB23587@flawful.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 03 April 2018 01:07 AM, Niklas Cassel wrote:
> On Thu, Mar 29, 2018 at 03:17:11PM +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
>>> Since a 64-bit BAR consists of a BAR pair, we need to write to both
>>> BARs in the BAR pair to setup the BAR properly.
>>>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>>> ---
>>>  drivers/pci/dwc/pcie-designware-ep.c | 11 +++++++++--
>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
>>> index 5a0bb53c795c..571b90f88d84 100644
>>> --- a/drivers/pci/dwc/pcie-designware-ep.c
>>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>>> @@ -138,8 +138,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
>>>  		return ret;
>>>  
>>>  	dw_pcie_dbi_ro_wr_en(pci);
>>> -	dw_pcie_writel_dbi2(pci, reg, size - 1);
>>> -	dw_pcie_writel_dbi(pci, reg, flags);
>>> +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
>>> +		dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
>>> +		dw_pcie_writel_dbi(pci, reg, flags);
>>> +		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
>>> +		dw_pcie_writel_dbi(pci, reg + 4, 0);
>>> +	} else {
>>> +		dw_pcie_writel_dbi2(pci, reg, size - 1);
>>> +		dw_pcie_writel_dbi(pci, reg, flags);
>>> +	}
>>
>>
>> I think this should work too?
>> 	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
>> 	dw_pcie_writel_dbi(pci, reg, flags);
>>
>> 	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
>> 		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
>> 		dw_pcie_writel_dbi(pci, reg + 4, 0);
>> 	}
>>
> 
> Hello Kishon,
> 
> I agree, your suggestion is more neat.
> 
> 
> Kishon, please tell me if you insist that the long if-statement
> in pci_epc_set_bar() should be split, since there are 5 different
> conditions. Because imho, having 5 succeeding if-statements isn't

I'm okay as it is as well if Lorenzo/Bjorn is also fine with it.

Thanks
Kishon
