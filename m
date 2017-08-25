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
 <4954977e-46fd-8d54-ec76-db2134d3073a@arm.com>
 <de6d3ad7-80ee-3b47-d084-54cada956232@free.fr>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <349671d2-077f-4702-2dac-d82276ddd675@arm.com>
Date: Fri, 25 Aug 2017 16:45:42 +0100
MIME-Version: 1.0
In-Reply-To: <de6d3ad7-80ee-3b47-d084-54cada956232@free.fr>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 25/08/17 16:35, Mason wrote:
> On 25/08/2017 17:25, Robin Murphy wrote:
> 
>> On 25/08/17 16:01, Mason wrote:
>>
>>> Robin wrote a prophetic post back in March:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/492965.html
>>>
>>>> The appropriate DT property would be "dma-ranges", i.e.
>>>>
>>>> pci@... {
>>>> 	...
>>>> 	dma-ranges = <(PCI bus address) (CPU phys address) (size)>;
>>>> }
>>>
>>> The dma-ranges property seems to be exactly what I'm looking for:
>>>
>>> Restrict DMA to the first X MB of RAM (use a bounce buffer
>>> for other physical addresses).
>>>
>>> I added the following property to my PCIe node
>>>
>>>   dma-ranges = <0x0 0x80000000 0x80000000 0x20000000>;
>>>
>>> with the intent to create a 1:1 mapping for [0x80000000, 0xa0000000[
>>>
>>> But it does not work. Arg!
>>>
>>> My PCIe controller driver seems to be correctly calling of_dma_get_range:
>>>
>>> [    0.520469] [<c03d85e8>] (of_dma_get_range) from [<c03d5ad8>] (of_dma_configure+0x48/0x234)
>>> [    0.520483] [<c03d5ad8>] (of_dma_configure) from [<c02fa154>] (pci_device_add+0xac/0x350)
>>> [    0.520493] [<c02fa154>] (pci_device_add) from [<c02fa488>] (pci_scan_single_device+0x90/0xb0)
>>> [    0.520501] [<c02fa488>] (pci_scan_single_device) from [<c02fa500>] (pci_scan_slot+0x58/0x100)
>>> [    0.520510] [<c02fa500>] (pci_scan_slot) from [<c02fb418>] (pci_scan_child_bus+0x20/0xf8)
>>> [    0.520519] [<c02fb418>] (pci_scan_child_bus) from [<c02fb6e8>] (pci_scan_root_bus_msi+0xcc/0xd8)
>>> [    0.520527] [<c02fb6e8>] (pci_scan_root_bus_msi) from [<c02fb70c>] (pci_scan_root_bus+0x18/0x20)
>>> [    0.520537] [<c02fb70c>] (pci_scan_root_bus) from [<c0310544>] (pci_host_common_probe+0xc8/0x314)
>>> [    0.520546] [<c0310544>] (pci_host_common_probe) from [<c0310ce8>] (tango_pcie_probe+0x148/0x350)
>>> [    0.520557] [<c0310ce8>] (tango_pcie_probe) from [<c034d398>] (platform_drv_probe+0x34/0x6c)
>>>
>>> of_dma_get_range() is called on the pcie node (which is expected)
>>> but after parsing n_addr_cells and n_size_cells in the while loop,
>>> the code jumps to the parent node ("soc")... while my property is
>>> attached to the pcie node...
>>
>> This is not your driver calling of_dma_get_range(), this is the PCI core
>> doing so in the act of DMA master configuration for a discovered
>> *endpoint*. The fact that the "pass the host controller's OF node
>> because we don't have one for the endpoint" bodge only works properly
>> for dma-coherent and not dma-ranges is a known, but irrelevant, problem.
>>
>> If your host controller driver needs to discover its windows from DT to
>> configure *itself*, it needs to parse dma-ranges itself; see pcie-iproc,
>> pcie-racar, pcie-xgene, etc. for examples.
> 
> Yes, I'm aware that I need to do my own parsing of dma-ranges.
> I can use that information to configure BAR0.base and the
> region registers.
> 
> But Linux needs to record my settings at some point, right?
> Otherwise, how does the DMA framework know that devices can
> only reach cpu addresses [0x80000000, 0xa0000000[ and when
> to use bounce buffers?
> 
> What's preventing the XHCI driver from allocating memory
> outside of my "safe" range, and having the DMA framework
> blindly map that?

At the moment, nothing. Systems that have physical memory that is not
visible in PCI mem space are having a bad time and will not go to space
today.

But that bears no relation to your MSI controller getting its doorbell
address set appropriately.

Robin.
