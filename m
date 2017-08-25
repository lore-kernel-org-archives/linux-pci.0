Return-Path: <SRS0=zhA9=73=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=zhA9=73=arm.com=robin.murphy@kernel.org>
Subject: Re: [PATCH v10] PCI: tango: Add MSI controller support
To: Mason <slash.tmp@free.fr>, Marc Zyngier <marc.zyngier@arm.com>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Marc Gonzalez <Marc_Gonzalez@sigmadesigns.com>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
 <8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com>
 <4b93964c-49eb-efbf-f6b2-956c67694182@sigmadesigns.com>
 <86efs3wesi.fsf@arm.com>
 <20170824170445.GO31858@bhelgaas-glaptop.roam.corp.google.com>
 <e2d48341-3ab1-f80a-b044-ff7dcc059ed4@sigmadesigns.com>
 <CAKv+Gu8ksqfBgXUTitDOB8O6Ke5Swkp2Agdt=3F0KJ130uUkBw@mail.gmail.com>
 <e381170c-e462-01cd-12db-30773005602b@free.fr> <871so09j6g.fsf@arm.com>
 <acdef092-3fb9-4338-5199-a458ac2439c7@free.fr>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4954977e-46fd-8d54-ec76-db2134d3073a@arm.com>
Date: Fri, 25 Aug 2017 16:25:58 +0100
MIME-Version: 1.0
In-Reply-To: <acdef092-3fb9-4338-5199-a458ac2439c7@free.fr>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 25/08/17 16:01, Mason wrote:
> On 25/08/2017 09:54, Marc Zyngier wrote:
>> On Thu, Aug 24 2017 at 10:53:16 pm BST, Mason <slash.tmp@free.fr> wrote:
>>> On 24/08/2017 20:35, Ard Biesheuvel wrote:
>>>> On 24 August 2017 at 18:51, Marc Gonzalez wrote:
>>>>> On 24/08/2017 19:04, Bjorn Helgaas wrote:
>>>>>> On Tue, Aug 22, 2017 Marc Zyngier wrote:
>>>>>>> Marc Gonzalez wrote:
>>>>>>>> On 22/08/2017 18:29, Marc Zyngier wrote:
>>>>>>>>> On 22/08/17 15:56, Marc Gonzalez wrote:
>>>>>>>>>
>>>>>>>>>>  #define SMP8759_MUX              0x48
>>>>>>>>>>  #define SMP8759_TEST_OUT 0x74
>>>>>>>>>> +#define SMP8759_STATUS           0x80
>>>>>>>>>> +#define SMP8759_ENABLE           0xa0
>>>>>>>>>> +#define SMP8759_DOORBELL 0xa002e07c
>>>>>>>>>
>>>>>>>>> Why is this hardcoded and not coming from the device-tree, just like any
>>>>>>>>> other address property?
>>>>>>>>
>>>>>>>> Since this bus address is software-configurable, I didn't think
>>>>>>>> it belonged in the DT. Also, I didn't see anything similar in
>>>>>>>> other binding docs, especially
>>>>>>>>
>>>>>>>> Documentation/devicetree/bindings/interrupt-controller/msi.txt
>>>>>>>
>>>>>>> If that's software configurable, how on Earth did you pick the address?
>>>>>>> How do you ensure that it doesn't conflict with DMA? How is it
>>>>>>> configured into the RC?
>>>>>>
>>>>>> But we *do* need to resolve this.  This does seem like an address that
>>>>>> shouldn't be hard-coded into the driver.  Since this driver is
>>>>>> programming the address into an MSI message, but not into the receiver
>>>>>> of that message, there's a coordination issue between this driver and
>>>>>> whatever other software does that receiver configuration.
>>>>>
>>>>> OK. I'll move the doorbell address to the DT for v11.
>>>>>
>>>>> What property should be used for this address?
>>>>>
>>>>> sigma,doorbell ?
>>>>>
>>>>> Or maybe I can put it in reg, since I have a 1:1 mapping
>>>>> between bus and cpu addresses?
>>>>>
>>>>> git grep -i doorbell arch/arm/boot/dts/ arch/arm64/boot/dts/
>>>>> returns nothing.
>>>>
>>>> You haven't answered the question yet: you stated that the doorbell
>>>> address is software configurable, yet your code does not seem to
>>>> configure it. It only returns the doorbell address so that it gets
>>>> communicated to the downstream devices.
>>>>
>>>> So how does the RC know which address is special, so it can trigger on
>>>> inbound writes hitting that address and assert the SPI ?
>>>
>>> The CPU address of the MSI doorbell address is 0x2e07c
>>> i.e. within the reg space of the PCIe controller block.
>>
>> Which you describe in DT already, right? So why aren't you using an
>> offset in this region as your MSI ddorbell (potentially applying an
>> offset, see below)?
>>
>>
>>> As I discussed back in March, the RC implements an odd
>>> bus-to-system mapping.
>>>
>>> RC BAR0 defines a window in PCI address space (max 1GB).
>>> Accesses outside this window are silently ignored.
>>> The window is divided into 8 "regions" and there are 8
>>> registers defining the offset into CPU space.
>>>
>>> In pseudo code, assuming pci_address is within the
>>> window defined by BAR0:
>>>
>>> cpu_address map_bus_to_system(pci_address)
>>> {
>>>     temp = pci_address - BAR0.base
>>>     region = temp / region_size
>>>     offset = temp % region_size
>>>     cpu_address = region_reg[region] + offset
>>>     return cpu_address
>>> }
>>>
>>> The current setup is:
>>>
>>> DRAM at 0x80000000-0xa0000000
>>> BAR0.base = 0x80000000
>>> REGION[0] = 0x80000000
>>> REGION[1] = 0x88000000
>>> REGION[2] = 0x90000000
>>> REGION[3] = 0x98000000
>>> REGION[4] = 0x0
>>>
>>> (This map means 1:1 identity for DRAM addresses.)
>>>
>>> Thus when a device writes to 0xa002e07c (region 4)
>>> the write is forwarded to 0x2e07c.
>>
>> But how do you find out about the 0xa0000000 offset? You must make sure
>> that the provided address is outside of RAM, should you end-up on a
>> system more than 1GB of RAM.
> 
> Robin wrote a prophetic post back in March:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/492965.html
> 
>> The appropriate DT property would be "dma-ranges", i.e.
>>
>> pci@... {
>> 	...
>> 	dma-ranges = <(PCI bus address) (CPU phys address) (size)>;
>> }
> 
> The dma-ranges property seems to be exactly what I'm looking for:
> 
> Restrict DMA to the first X MB of RAM (use a bounce buffer
> for other physical addresses).
> 
> I added the following property to my PCIe node
> 
>   dma-ranges = <0x0 0x80000000 0x80000000 0x20000000>;
> 
> with the intent to create a 1:1 mapping for [0x80000000, 0xa0000000[
> 
> But it does not work. Arg!
> 
> My PCIe controller driver seems to be correctly calling of_dma_get_range:
> 
> [    0.520469] [<c03d85e8>] (of_dma_get_range) from [<c03d5ad8>] (of_dma_configure+0x48/0x234)
> [    0.520483] [<c03d5ad8>] (of_dma_configure) from [<c02fa154>] (pci_device_add+0xac/0x350)
> [    0.520493] [<c02fa154>] (pci_device_add) from [<c02fa488>] (pci_scan_single_device+0x90/0xb0)
> [    0.520501] [<c02fa488>] (pci_scan_single_device) from [<c02fa500>] (pci_scan_slot+0x58/0x100)
> [    0.520510] [<c02fa500>] (pci_scan_slot) from [<c02fb418>] (pci_scan_child_bus+0x20/0xf8)
> [    0.520519] [<c02fb418>] (pci_scan_child_bus) from [<c02fb6e8>] (pci_scan_root_bus_msi+0xcc/0xd8)
> [    0.520527] [<c02fb6e8>] (pci_scan_root_bus_msi) from [<c02fb70c>] (pci_scan_root_bus+0x18/0x20)
> [    0.520537] [<c02fb70c>] (pci_scan_root_bus) from [<c0310544>] (pci_host_common_probe+0xc8/0x314)
> [    0.520546] [<c0310544>] (pci_host_common_probe) from [<c0310ce8>] (tango_pcie_probe+0x148/0x350)
> [    0.520557] [<c0310ce8>] (tango_pcie_probe) from [<c034d398>] (platform_drv_probe+0x34/0x6c)
> 
> of_dma_get_range() is called on the pcie node (which is expected)
> but after parsing n_addr_cells and n_size_cells in the while loop,
> the code jumps to the parent node ("soc")... while my property is
> attached to the pcie node...

This is not your driver calling of_dma_get_range(), this is the PCI core
doing so in the act of DMA master configuration for a discovered
*endpoint*. The fact that the "pass the host controller's OF node
because we don't have one for the endpoint" bodge only works properly
for dma-coherent and not dma-ranges is a known, but irrelevant, problem.

If your host controller driver needs to discover its windows from DT to
configure *itself*, it needs to parse dma-ranges itself; see pcie-iproc,
pcie-racar, pcie-xgene, etc. for examples.

Robin.

> 
> [    0.507754] of_dma_get_range: node=dfbf74cc np=dfbf74cc name=/soc/pcie@2e000 name2=/soc/pcie@2e000
> ...
> [    0.509162] __of_find_property: node=soc find=#address-cells prop=compatible
> [    0.509168] __of_find_property: node=soc find=#address-cells prop=interrupt-parent
> [    0.509173] __of_find_property: node=soc find=#address-cells prop=#address-cells
> [    0.509178] __of_find_property: node=soc find=#size-cells prop=compatible
> [    0.509182] __of_find_property: node=soc find=#size-cells prop=interrupt-parent
> [    0.509186] __of_find_property: node=soc find=#size-cells prop=#address-cells
> [    0.509190] __of_find_property: node=soc find=#size-cells prop=#size-cells
> [    0.509195] __of_find_property: node=soc find=dma-ranges prop=compatible
> [    0.509199] __of_find_property: node=soc find=dma-ranges prop=interrupt-parent
> [    0.509203] __of_find_property: node=soc find=dma-ranges prop=#address-cells
> [    0.509207] __of_find_property: node=soc find=dma-ranges prop=#size-cells
> [    0.509211] __of_find_property: node=soc find=dma-ranges prop=ranges
> [    0.509215] __of_find_property: node=soc find=dma-ranges prop=name
> [    0.509219] dma-ranges=  (null)
> 
> http://elixir.free-electrons.com/linux/latest/source/drivers/of/address.c#L838
> 
> What am I missing?
> 
> Regards.
> 
