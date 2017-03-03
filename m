Return-Path: <SRS0=h4+z=2M=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=h4+z=2M=arm.com=marc.zyngier@kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Mason <slash.tmp@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>,  linux-pci <linux-pci@vger.kernel.org>,  Linux ARM <linux-arm-kernel@lists.infradead.org>,  Will Deacon <will.deacon@arm.com>,  David Daney <david.daney@cavium.com>,  Rob Herring <robh@kernel.org>,  Thierry Reding <treding@nvidia.com>,  Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,  Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
Subject: Re: Using the generic host PCIe driver
In-Reply-To: <5074ad21-9020-bba8-9890-fe4d9855bd9a@free.fr> (Mason's message
	of "Fri, 3 Mar 2017 17:53:58 +0100")
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
	<20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
	<8643c952-e915-bcd1-390e-9d4001789872@free.fr>
	<20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
	<347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
	<20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
	<01f41dd8-e8e6-f880-cad8-5cb83bf0a167@arm.com>
	<4059f88f-0f70-38c2-f2f9-58dd2bd5b280@free.fr>
	<87tw7a2tz1.fsf@on-the-bus.cambridge.arm.com>
	<5074ad21-9020-bba8-9890-fe4d9855bd9a@free.fr>
Date: Fri, 03 Mar 2017 17:08:20 +0000
Message-ID: <87lgsm2sqj.fsf@on-the-bus.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 03 2017 at  4:53:58 pm GMT, Mason <slash.tmp@free.fr> wrote:
> On 03/03/2017 17:41, Marc Zyngier wrote:
>> On Fri, Mar 03 2017 at 11:26:27 am GMT, Mason <slash.tmp@free.fr> wrote:
>>> On 01/03/2017 17:36, Marc Zyngier wrote:
>>>
>>>> Mason: while the kernel has generic support for dealing with MSI, there
>>>> is not standardization at the interrupt controller level, so you do have
>>>> to write your own driver, and wire it in the rest of the framework.
>>>>
>>>> I suggest you look at things like drivers/pci/host/pcie-altera-msi.c,
>>>> which has an extremely simple implementation. You can use this as a
>>>> starting point for your own driver.
>>>
>>> Thanks Marc,
>>>
>>> I'll have a close look at the Altera driver.
>>>
>>> I'm having a hard time understanding 3 different kinds of interrupts:
>>>
>>>   1. MSI (message-signalled interrupts)
>>>   2. legacy interrupts
>>>   3. custom interrupts
>> 
>> [...]
>> 
>>> I suppose the interrupt controller I'm supposed to write needs
>>> to handle all 3 types of interrupts?
>> 
>> That's entirely up to you. INTx is the bare minimum.
>
> That's going to be a problem. Rev 1 of the PCIe controller does not
> support legacy interrupts at all.

Well, let's hope that you never run out of MSIs, and that you don't face
a PCI device that insists (for better or worse) on using INTx.

>
>> MSI is what people
>> actually need. The rest has more to do with configuring your host
>> controller, but only you know about it (and I'm not really interested in
>> the gory details of how this particular HW works).
>
> I was under the impression that some of the error interrupts might be
> required for proper PCIe functionality.

Maybe, but that's not something the PCIe *device* will ever have to care
about. That's the host controller's business.

>> I mentioned the Altera driver because it is a very simple example of an
>> MSI controller driver that uses the generic MSI domains. It doesn't care
>> about INTx, nor host controller management interrupts (that's handled
>> separately).
>
> OK, MSI support is all I need to start with, so I'll try my best to
> decipher the cryptic intc API, without melting my remaining neuron.

What cryptic for someone is usually crystal clear for someone else. We
deal with it.

     M.
-- 
Jazz is not dead, it just smell funny.
