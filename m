Return-Path: <SRS0=lr18=72=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=lr18=72=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v10] PCI: tango: Add MSI controller support
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
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
From: Mason <slash.tmp@free.fr>
Message-ID: <e381170c-e462-01cd-12db-30773005602b@free.fr>
Date: Thu, 24 Aug 2017 22:53:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8ksqfBgXUTitDOB8O6Ke5Swkp2Agdt=3F0KJ130uUkBw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 24/08/2017 20:35, Ard Biesheuvel wrote:
> On 24 August 2017 at 18:51, Marc Gonzalez wrote:
>> On 24/08/2017 19:04, Bjorn Helgaas wrote:
>>> On Tue, Aug 22, 2017 Marc Zyngier wrote:
>>>> Marc Gonzalez wrote:
>>>>> On 22/08/2017 18:29, Marc Zyngier wrote:
>>>>>> On 22/08/17 15:56, Marc Gonzalez wrote:
>>>>>>
>>>>>>>  #define SMP8759_MUX              0x48
>>>>>>>  #define SMP8759_TEST_OUT 0x74
>>>>>>> +#define SMP8759_STATUS           0x80
>>>>>>> +#define SMP8759_ENABLE           0xa0
>>>>>>> +#define SMP8759_DOORBELL 0xa002e07c
>>>>>>
>>>>>> Why is this hardcoded and not coming from the device-tree, just like any
>>>>>> other address property?
>>>>>
>>>>> Since this bus address is software-configurable, I didn't think
>>>>> it belonged in the DT. Also, I didn't see anything similar in
>>>>> other binding docs, especially
>>>>>
>>>>> Documentation/devicetree/bindings/interrupt-controller/msi.txt
>>>>
>>>> If that's software configurable, how on Earth did you pick the address?
>>>> How do you ensure that it doesn't conflict with DMA? How is it
>>>> configured into the RC?
>>>
>>> But we *do* need to resolve this.  This does seem like an address that
>>> shouldn't be hard-coded into the driver.  Since this driver is
>>> programming the address into an MSI message, but not into the receiver
>>> of that message, there's a coordination issue between this driver and
>>> whatever other software does that receiver configuration.
>>
>> OK. I'll move the doorbell address to the DT for v11.
>>
>> What property should be used for this address?
>>
>> sigma,doorbell ?
>>
>> Or maybe I can put it in reg, since I have a 1:1 mapping
>> between bus and cpu addresses?
>>
>> git grep -i doorbell arch/arm/boot/dts/ arch/arm64/boot/dts/
>> returns nothing.
> 
> You haven't answered the question yet: you stated that the doorbell
> address is software configurable, yet your code does not seem to
> configure it. It only returns the doorbell address so that it gets
> communicated to the downstream devices.
> 
> So how does the RC know which address is special, so it can trigger on
> inbound writes hitting that address and assert the SPI ?

The CPU address of the MSI doorbell address is 0x2e07c
i.e. within the reg space of the PCIe controller block.

As I discussed back in March, the RC implements an odd
bus-to-system mapping.

RC BAR0 defines a window in PCI address space (max 1GB).
Accesses outside this window are silently ignored.
The window is divided into 8 "regions" and there are 8
registers defining the offset into CPU space.

In pseudo code, assuming pci_address is within the
window defined by BAR0:

cpu_address map_bus_to_system(pci_address)
{
    temp = pci_address - BAR0.base
    region = temp / region_size
    offset = temp % region_size
    cpu_address = region_reg[region] + offset
    return cpu_address
}

The current setup is:

DRAM at 0x80000000-0xa0000000
BAR0.base = 0x80000000
REGION[0] = 0x80000000
REGION[1] = 0x88000000
REGION[2] = 0x90000000
REGION[3] = 0x98000000
REGION[4] = 0x0

(This map means 1:1 identity for DRAM addresses.)

Thus when a device writes to 0xa002e07c (region 4)
the write is forwarded to 0x2e07c.

Regards.
