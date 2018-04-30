Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:52431 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753425AbeD3Rd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Apr 2018 13:33:26 -0400
Subject: Re: [PATCH v7 3/9] PCI: endpoint: functions/pci-epf-test: Add second
 entry
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <cover.1524577064.git.gustavo.pimentel@synopsys.com>
 <c6cfd167838ae8e226dee0820983efe918fa4e1f.1524577064.git.gustavo.pimentel@synopsys.com>
 <20180426165605.GA6370@e107981-ln.cambridge.arm.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <d6f3d669-aa94-f6ab-e166-8af0fa7f4d0a@synopsys.com>
Date: Mon, 30 Apr 2018 18:32:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180426165605.GA6370@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26/04/2018 17:56, Lorenzo Pieralisi wrote:
> On Tue, Apr 24, 2018 at 02:44:40PM +0100, Gustavo Pimentel wrote:
>> Adds a seconds entry on the pci_epf_test_ids structure that disables the
> 
> "Add a second entry to..."
> 
>> linkup_notifier parameter on driver for the designware EP.
>>
>> This allows designware EPs that doesn't have linkup notification signal
>> to work with pcitest.
>>
>> Updates the binding documentation accordingly.
> 
> Valid for all the series: use imperative sentences.
> 
> eg:
> 
> "Update the binding documentation accordingly".
> 
> not
> 
> "Updates the binding documentation accordingly".
> 

Ok, I will do an overall check to fix the entries.

>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> Change v2->v3:
>>  - Added second entry in pci_epf_test_ids structure.
>>  - Remove test_reg_bar field assignment on second entry.
>> Changes v3->v4:
>>  - Nothing changed, just to follow the patch set version.
>> Changes v4->v5:
>>  - Changed pci_epf_test_cfg2 to pci_epf_test_designware.
>> Changes v5->v6:
>>  - Changed name field from pci_epf_test_designware to pci_epf_test_dw.
>> Changes v6->v7:
>>  - Changed variable name from data_cfg2 to data_linkup_notifier_disabled.
>>
>>  Documentation/PCI/endpoint/function/binding/pci-test.txt | 2 ++
>>  drivers/pci/endpoint/functions/pci-epf-test.c            | 8 ++++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
>> index 3b68b95..dc39f47 100644
>> --- a/Documentation/PCI/endpoint/function/binding/pci-test.txt
>> +++ b/Documentation/PCI/endpoint/function/binding/pci-test.txt
>> @@ -1,6 +1,8 @@
>>  PCI TEST ENDPOINT FUNCTION
>>  
>>  name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
>> +name: Should be "pci_epf_test_dw" to bind to the pci_epf_test driver
>> +      with a custom configuration for the designware EP.
> 
> The link between the "name" and the device created is quite obscure and
> reading pci-test-howto.txt certainly does not clarify it.

I will add more information about it.

> 
> In pci-test-howto.txt an explanation should be added to the configs
> device creation paragraph to clarify it.

That's true, it should exist some explanation of that. To be honest I didn't
remember of the pci-test-howto.txt file existence.

> 
>>  Configurable Fields:
>>  vendorid	 : should be 0x104c
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 7cef851..4ab463b 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -459,10 +459,18 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>  	return 0;
>>  }
>>  
>> +static const struct pci_epf_test_data data_linkup_notifier_disabled = {
>> +	.linkup_notifier = false
>> +};
>> +
>>  static const struct pci_epf_device_id pci_epf_test_ids[] = {
>>  	{
>>  		.name = "pci_epf_test",
>>  	},
>> +	{
>> +		.name = "pci_epf_test_dw",
>> +		.driver_data = (kernel_ulong_t)&data_linkup_notifier_disabled,
>> +	},
>>  	{},
> 
> Should not this be a property derived from the controller compatible
> property instead of the test device name written in configfs ?
> 
> I think I am missing something in the whole scheme of things, please
> clarify.

This type of configuration / configuration was suggested by Kishon. I can only
assume that it would not be possible (or no one thought of it) to correlate the
compatible string of the controller to select the configuration, perhaps Kishon
could give his opinion on the feasibility of this and even to provide some
example of it. :)

If it is possible, it will be quite straightforward.

> 
> Thanks,
> Lorenzo
> 
