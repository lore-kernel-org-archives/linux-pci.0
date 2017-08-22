Return-Path: <SRS0=PxOY=7Y=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=PxOY=7Y=arm.com=marc.zyngier@kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,  linux-pci <linux-pci@vger.kernel.org>,  Linux ARM <linux-arm-kernel@lists.infradead.org>,  Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,  Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v10] PCI: tango: Add MSI controller support
In-Reply-To: <4b93964c-49eb-efbf-f6b2-956c67694182@sigmadesigns.com> (Marc
	Gonzalez's message of "Tue, 22 Aug 2017 20:02:18 +0200")
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
	<8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com>
	<4b93964c-49eb-efbf-f6b2-956c67694182@sigmadesigns.com>
Date: Tue, 22 Aug 2017 21:03:41 +0100
Message-ID: <86efs3wesi.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 22 2017 at  8:02:18 pm BST, Marc Gonzalez <marc_gonzalez@sigmadesigns.com> wrote:
> On 22/08/2017 18:29, Marc Zyngier wrote:
>
>> On 22/08/17 15:56, Marc Gonzalez wrote:
>>
>>>  #define SMP8759_MUX		0x48
>>>  #define SMP8759_TEST_OUT	0x74
>>> +#define SMP8759_STATUS		0x80
>>> +#define SMP8759_ENABLE		0xa0
>>> +#define SMP8759_DOORBELL	0xa002e07c
>> 
>> Why is this hardcoded and not coming from the device-tree, just like any
>> other address property?
>
> Since this bus address is software-configurable, I didn't think
> it belonged in the DT. Also, I didn't see anything similar in
> other binding docs, especially
>
> Documentation/devicetree/bindings/interrupt-controller/msi.txt

If that's software configurable, how on Earth did you pick the address?
How do you ensure that it doesn't conflict with DMA? How is it
configured into the RC?

	M.
-- 
Jazz is not dead. It just smells funny.
