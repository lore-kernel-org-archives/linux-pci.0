Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38609 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdL2UaD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 15:30:03 -0500
Subject: Re: [PATCH v2 7/9] PCI: endpoint: Add the function number as argument
 to EPC ops
To: Kishon Vijay Abraham I <kishon@ti.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <425171aaba3a9e8ea68b9e94f37b1c97e8cf9861.1513620412.git.cyrille.pitchen@free-electrons.com>
 <ca8f5a74-3db5-87f4-3af5-ed5ee0d3b634@ti.com>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Message-ID: <22c6a835-86e1-4145-e20b-aa74444dfd94@free-electrons.com>
Date: Fri, 29 Dec 2017 21:30:00 +0100
MIME-Version: 1.0
In-Reply-To: <ca8f5a74-3db5-87f4-3af5-ed5ee0d3b634@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

Le 29/12/2017 à 10:23, Kishon Vijay Abraham I a écrit :
> Hi,
> 
> On Monday 18 December 2017 11:46 PM, Cyrille Pitchen wrote:
>> This patch updates the prototype of most handlers from 'struct
>> pci_epc_ops' so the EPC library can now support multi-function devices.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>> ---
>>  drivers/pci/dwc/pcie-designware-ep.c          | 20 +++++----
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 41 ++++++++++--------
>>  drivers/pci/endpoint/pci-epc-core.c           | 62 ++++++++++++++++-----------
>>  include/linux/pci-epc.h                       | 43 +++++++++++--------
>>  4 files changed, 96 insertions(+), 70 deletions(-)
>>
[...]
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index cd7d4788b94d..77420364a728 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -141,25 +141,26 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
>>  /**
>>   * pci_epc_raise_irq() - interrupt the host system
>>   * @epc: the EPC device which has to interrupt the host
>> + * @func_no: the endpoint function number in the EPC device
>>   * @type: specify the type of interrupt; legacy or MSI
>>   * @interrupt_num: the MSI interrupt number
>>   *
>>   * Invoke to raise an MSI or legacy interrupt
>>   */
>> -int pci_epc_raise_irq(struct pci_epc *epc, enum pci_epc_irq_type type,
>> -		      u8 interrupt_num)
>> +int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
>> +		      enum pci_epc_irq_type type, u8 interrupt_num)
>>  {
>>  	int ret;
>>  	unsigned long flags;
>>  
>> -	if (IS_ERR(epc))
>> +	if (IS_ERR(epc) || func_no > BAR_5)
> 
> why is function number compared with BAR? here and everywhere below..
>

Oops! sorry for that. Actually it's a silly mistake, thanks for
catching it!

I plan to fix it replacing with something like this:

s/func_no > BAR_5/func_no >= epc->max_functions/

Then I guess if we already test with IS_ERR(), I should now replace
IS_ERR() by IS_ERR_OR_NULL() before dereferencing epc when reading
max_functions.

Best regards,

Cyrille
 
> Thanks
> Kishon
> 


-- 
Cyrille Pitchen, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
