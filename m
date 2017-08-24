Return-Path: <SRS0=K1PJ=72=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=K1PJ=72=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <e2d48341-3ab1-f80a-b044-ff7dcc059ed4@sigmadesigns.com>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
 <8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com> <4b93964c-49eb-efbf-f6b2-956c67694182@sigmadesigns.com>
 <86efs3wesi.fsf@arm.com> <20170824170445.GO31858@bhelgaas-glaptop.roam.corp.google.com>
 <e2d48341-3ab1-f80a-b044-ff7dcc059ed4@sigmadesigns.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Aug 2017 19:35:20 +0100
Message-ID: <CAKv+Gu8ksqfBgXUTitDOB8O6Ke5Swkp2Agdt=3F0KJ130uUkBw@mail.gmail.com>
Subject: Re: [PATCH v10] PCI: tango: Add MSI controller support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Mason <slash.tmp@free.fr>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 24 August 2017 at 18:51, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
> On 24/08/2017 19:04, Bjorn Helgaas wrote:
>> On Tue, Aug 22, 2017 at 09:03:41PM +0100, Marc Zyngier wrote:
>>> Marc Gonzalez wrote:
>>>> On 22/08/2017 18:29, Marc Zyngier wrote:
>>>>> On 22/08/17 15:56, Marc Gonzalez wrote:
>>>>>
>>>>>>  #define SMP8759_MUX              0x48
>>>>>>  #define SMP8759_TEST_OUT 0x74
>>>>>> +#define SMP8759_STATUS           0x80
>>>>>> +#define SMP8759_ENABLE           0xa0
>>>>>> +#define SMP8759_DOORBELL 0xa002e07c
>>>>>
>>>>> Why is this hardcoded and not coming from the device-tree, just like any
>>>>> other address property?
>>>>
>>>> Since this bus address is software-configurable, I didn't think
>>>> it belonged in the DT. Also, I didn't see anything similar in
>>>> other binding docs, especially
>>>>
>>>> Documentation/devicetree/bindings/interrupt-controller/msi.txt
>>>
>>> If that's software configurable, how on Earth did you pick the address?
>>> How do you ensure that it doesn't conflict with DMA? How is it
>>> configured into the RC?
>>
>> But we *do* need to resolve this.  This does seem like an address that
>> shouldn't be hard-coded into the driver.  Since this driver is
>> programming the address into an MSI message, but not into the receiver
>> of that message, there's a coordination issue between this driver and
>> whatever other software does that receiver configuration.
>
> OK. I'll move the doorbell address to the DT for v11.
>
> What property should be used for this address?
>
> sigma,doorbell ?
>
> Or maybe I can put it in reg, since I have a 1:1 mapping
> between bus and cpu addresses?
>
> git grep -i doorbell arch/arm/boot/dts/ arch/arm64/boot/dts/
> returns nothing.
>

You haven't answered the question yet: you stated that the doorbell
address is software configurable, yet your code does not seem to
configure it. It only returns the doorbell address so that it gets
communicated to the downstream devices.

So how does the RC know which address is special, so it can trigger on
inbound writes hitting that address and assert the SPI ?
