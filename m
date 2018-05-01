Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v7 3/9] PCI: endpoint: functions/pci-epf-test: Add second
 entry
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <cover.1524577064.git.gustavo.pimentel@synopsys.com>
 <c6cfd167838ae8e226dee0820983efe918fa4e1f.1524577064.git.gustavo.pimentel@synopsys.com>
 <20180426165605.GA6370@e107981-ln.cambridge.arm.com>
CC: <bhelgaas@google.com>, <Joao.Pinto@synopsys.com>,
        <jingoohan1@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b65caf2e-b002-f591-6215-ff2241b2dfb8@ti.com>
Date: Tue, 1 May 2018 15:37:47 +0530
MIME-Version: 1.0
In-Reply-To: <20180426165605.GA6370@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Thursday 26 April 2018 10:26 PM, Lorenzo Pieralisi wrote:
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
> 
> In pci-test-howto.txt an explanation should be added to the configs
> device creation paragraph to clarify it.
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

pci_epf_test is an independent driver on its own that operates in a layer above
the controller driver. So it does not get the controller compatible (which is
used in controller drivers like pcie-designware-plat.c). pci_epf_test uses
"pci_epf_device_id" which is _similar_ to "of_device_id" used by platform drivers.

Thanks
Kishon
