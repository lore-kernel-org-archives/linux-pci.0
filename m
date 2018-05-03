Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v7 3/9] PCI: endpoint: functions/pci-epf-test: Add second
 entry
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <cover.1524577064.git.gustavo.pimentel@synopsys.com>
 <c6cfd167838ae8e226dee0820983efe918fa4e1f.1524577064.git.gustavo.pimentel@synopsys.com>
 <20180426165605.GA6370@e107981-ln.cambridge.arm.com>
 <b65caf2e-b002-f591-6215-ff2241b2dfb8@ti.com>
 <20180501115417.GD19391@e107981-ln.cambridge.arm.com>
 <5d625d04-38fe-7d5a-67fc-5ea92039474c@ti.com>
 <20180501142607.GA21911@e107981-ln.cambridge.arm.com>
 <bfaebf3c-2175-f4b2-89c5-336ff9396ed0@synopsys.com>
 <20180502165144.GB4871@e107981-ln.cambridge.arm.com>
 <cf2772d5-26c0-b0e3-1e5b-ace91c1ea105@ti.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <f7e00843-747f-07bd-6c13-934a828ac6e1@synopsys.com>
Date: Thu, 3 May 2018 16:21:22 +0100
MIME-Version: 1.0
In-Reply-To: <cf2772d5-26c0-b0e3-1e5b-ace91c1ea105@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo and Kishon,

On 03/05/2018 07:33, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On Wednesday 02 May 2018 10:21 PM, Lorenzo Pieralisi wrote:
>> On Wed, May 02, 2018 at 11:39:00AM +0100, Gustavo Pimentel wrote:
>>> Hi Lorenzo,
>>>
>>> On 01/05/2018 15:26, Lorenzo Pieralisi wrote:
>>>> On Tue, May 01, 2018 at 05:53:59PM +0530, Kishon Vijay Abraham I wrote:
>>>>> Hi Lorenzo,
>>>>>
>>>>> On Tuesday 01 May 2018 05:24 PM, Lorenzo Pieralisi wrote:
>>>>>> On Tue, May 01, 2018 at 03:37:47PM +0530, Kishon Vijay Abraham I wrote:
>>>>>>> Hi Lorenzo,
>>>>>>>
>>>>>>> On Thursday 26 April 2018 10:26 PM, Lorenzo Pieralisi wrote:
>>>>>>>> On Tue, Apr 24, 2018 at 02:44:40PM +0100, Gustavo Pimentel wrote:
>>>>>>>>> Adds a seconds entry on the pci_epf_test_ids structure that disables the
>>>>>>>>
>>>>>>>> "Add a second entry to..."
>>>>>>>>
>>>>>>>>> linkup_notifier parameter on driver for the designware EP.
>>>>>>>>>
>>>>>>>>> This allows designware EPs that doesn't have linkup notification signal
>>>>>>>>> to work with pcitest.
>>>>>>>>>
>>>>>>>>> Updates the binding documentation accordingly.
>>>>>>>>
>>>>>>>> Valid for all the series: use imperative sentences.
>>>>>>>>
>>>>>>>> eg:
>>>>>>>>
>>>>>>>> "Update the binding documentation accordingly".
>>>>>>>>
>>>>>>>> not
>>>>>>>>
>>>>>>>> "Updates the binding documentation accordingly".
>>>>>>>>
>>>>>>>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>>>>>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>>>>> ---
>>>>>>>>> Change v2->v3:
>>>>>>>>>  - Added second entry in pci_epf_test_ids structure.
>>>>>>>>>  - Remove test_reg_bar field assignment on second entry.
>>>>>>>>> Changes v3->v4:
>>>>>>>>>  - Nothing changed, just to follow the patch set version.
>>>>>>>>> Changes v4->v5:
>>>>>>>>>  - Changed pci_epf_test_cfg2 to pci_epf_test_designware.
>>>>>>>>> Changes v5->v6:
>>>>>>>>>  - Changed name field from pci_epf_test_designware to pci_epf_test_dw.
>>>>>>>>> Changes v6->v7:
>>>>>>>>>  - Changed variable name from data_cfg2 to data_linkup_notifier_disabled.
>>>>>>>>>
>>>>>>>>>  Documentation/PCI/endpoint/function/binding/pci-test.txt | 2 ++
>>>>>>>>>  drivers/pci/endpoint/functions/pci-epf-test.c            | 8 ++++++++
>>>>>>>>>  2 files changed, 10 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
>>>>>>>>> index 3b68b95..dc39f47 100644
>>>>>>>>> --- a/Documentation/PCI/endpoint/function/binding/pci-test.txt
>>>>>>>>> +++ b/Documentation/PCI/endpoint/function/binding/pci-test.txt
>>>>>>>>> @@ -1,6 +1,8 @@
>>>>>>>>>  PCI TEST ENDPOINT FUNCTION
>>>>>>>>>  
>>>>>>>>>  name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
>>>>>>>>> +name: Should be "pci_epf_test_dw" to bind to the pci_epf_test driver
>>>>>>>>> +      with a custom configuration for the designware EP.
>>>>>>>>
>>>>>>>> The link between the "name" and the device created is quite obscure and
>>>>>>>> reading pci-test-howto.txt certainly does not clarify it.
>>>>>>>>
>>>>>>>> In pci-test-howto.txt an explanation should be added to the configs
>>>>>>>> device creation paragraph to clarify it.
>>>>>>>>
>>>>>>>>>  Configurable Fields:
>>>>>>>>>  vendorid	 : should be 0x104c
>>>>>>>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>>>>>>> index 7cef851..4ab463b 100644
>>>>>>>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>>>>>>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>>>>>>> @@ -459,10 +459,18 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>>>>>>>>  	return 0;
>>>>>>>>>  }
>>>>>>>>>  
>>>>>>>>> +static const struct pci_epf_test_data data_linkup_notifier_disabled = {
>>>>>>>>> +	.linkup_notifier = false
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>>  static const struct pci_epf_device_id pci_epf_test_ids[] = {
>>>>>>>>>  	{
>>>>>>>>>  		.name = "pci_epf_test",
>>>>>>>>>  	},
>>>>>>>>> +	{
>>>>>>>>> +		.name = "pci_epf_test_dw",
>>>>>>>>> +		.driver_data = (kernel_ulong_t)&data_linkup_notifier_disabled,
>>>>>>>>> +	},
>>>>>>>>>  	{},
>>>>>>>>
>>>>>>>> Should not this be a property derived from the controller compatible
>>>>>>>> property instead of the test device name written in configfs ?
>>>>>>>
>>>>>>> pci_epf_test is an independent driver on its own that operates in a layer above
>>>>>>> the controller driver. So it does not get the controller compatible (which is
>>>>>>> used in controller drivers like pcie-designware-plat.c). pci_epf_test uses
>>>>>>> "pci_epf_device_id" which is _similar_ to "of_device_id" used by platform drivers.
>>>>>>
>>>>>> I understand that, the problem is that the independent driver depends on
>>>>>> features of the related controller driver as this patch shows. This
>>>>>> patch basically says that if you use a specific path in configfs (that
>>>>>> includes pci_epf_test_dw) your device has specific HW features (eg
>>>>>> linkup notifier above), that obviously depends on the platform HW not on
>>>>>> the string you use in configfs.
>>>>>>
>>>>>> What I am questioning is a) if I understand this right and b) whether
>>>>>> this is the right approach.
>>>>>
>>>>> Your understanding is right. Ideally pci-epf-test driver shouldn't have any HW
>>>>> specific configuration. But different HW have different configurations and
>>>>> pci-epf-test should be informed of the configuration the HW supports.
>>>>
>>>> I am honestly very confused. First off, I do not understand what this
>>>> patch really does (or better what DW can't do so that it needs a
>>>> specific configfs string and therefore a specific configuration).
>>>>
>>>> What's the purpose of the linkup notifier ? What does it mean that
>>>> the DW HW can't handle it ?
>>>>
>>>> Are we referring to the pci_epf_linkup() function ?
>>>>
>>>> If it is a HW configuration (ie the DW HW does not have a signal to
>>>> report that the link is up ?) its enablement must depend on HW
>>>> controller properties not configfs entries, I do not like what this
>>>> patch does (probably because I am confused and I do not understand it).
>>>>
>>>> Please let me know your thoughts on this, thanks.
>>>
>>> On my setup, the EP is unable generate a signal which is responsible
>>> for notify that the link is established, being therefore necessary to
>>> emulate it, this is done by setting the linkup_notifier variable to
>>> false.
>>
>> What I do not understand is why the workqueue notification can't be called
>> irrespective of the linkup notifier value from pci_epf_test_bind(),
>> what's the point in calling it earlier with pci_epf_linkup() (or the
>> other way around why is it safe to call it a bind() time if there
>> is no notification available - which is the DW case).
> 
> The linkup notifier is used just to prevent the system from wasting cpu cycles.
> Without linkup notifier, pci_epf_test will start checking for commands from
> host after the pci_epf_test is bound to the EP controller (bind() callback)
> though the host can issue commands only when after the link is up. So for
> platforms which supports linkup notification, it's better we poll command
> register only after link is established.
>>
>> [...]
>>
>>> Since the linkup notifier and BAR index (where auxiliary registers are
>>> located) may be configurable and is something platform dependent,
>>> perhaps the configuration of this variables should be done by module
>>> parameter and not by configfs, leaving this configuration
>>> responsibility in charge of each platform.
>>
>> They are platform dependent because they depend on the EP controller.
>> That's why I said that those are EP controller parameters. I do not
>> think they are module parameters either - they should be part of HW
>> description in firmware.
> 
> The problem is because pci-epf-test cannot be described in HW. pci-epf-test is
> also not automatically bound to the EP controller but is bound by the user like
> below
> ln -s functions/pci_epf_test/func1 controllers/51000000.pcie_ep/
> 
> So given that user anyways has to bind the epf device to the controller, based
> on the platform the user can use a different configfs entry like below
> ln -s functions/pci_epf_test_dw/func1 controllers/51000000.pcie_ep/ or
> ln -s functions/pci_epf_test_k2g/func1 controllers/21800000.pcie-ep/
> 
> If the epf can be described in dt, then something like below can be done
> pcie1_ep: pcie_ep@51000000 {
> 	compatible = "ti,dra7-pcie-ep";
> 	interrupts = <0 232 0x4>;
> 	num-lanes = <1>;
> 	num-ib-windows = <4>;
> 	num-ob-windows = <16>;
> 	phys = <&pcie1_phy>;
> 	phy-names = "pcie-phy0";
> 	pci_epf_test: pci_epf_test@0 {
> 		name = "pci_epf_test_dw";
> 		<other properties>;
> 	}
> };
> 
> With this pci-dra7xx.c driver should create pci_epf_device using
> pci_epf_create("pci_epf_test_dw");
> 
> Then the driver_data corresponding to "pci_epf_test_dw" will select linkup
> notifier or BAR index etc.
> 
> Having different pci_epf_device_id entries and corresponding driver_data for
> each entry seems fine to me (as done in this patch). We use configfs only since
> pci_epf_test cannot be described in dt.

I think I understood your point of view Lorenzo and it makes sense.
However I think I have an alternative, since this 2 parameters are platform
dependent, but there aren't quite a HW description, so they shouldn't be
described on DT, right?

So I would propose another alternative. What if each EP driver (in my case
pcie-designware-plat) provided a callback that could be used to set the test
configuration data, if needed? Similar to the dw_plat_set_num_vectors callback.

In fact, something similar mechanism already exists, for example when the
pci_epf_test driver tries to get the number of MSI/MSI-X, the driver retrieves
the value through callbacks.

In this way each driver would be responsible for adapting to their needs, there
would be no changes to the DT modification or extra configfs entries.

What do you think?

Regards,
Gustavo

> 
> Thanks
> Kishon
> 
