Return-Path: <SRS0=9BsA=BZ=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=9BsA=BZ=free.fr=slash.tmp@kernel.org>
From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH 4/5] PCI: tango: Fix platform_get_irq() error handling
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Fabio Estevam <festevam@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mark Brown <broonie@kernel.org>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com>
 <1508018851-9272-4-git-send-email-festevam@gmail.com>
 <169eac7a-4dd1-f164-6342-9bac8b7dbf3a@sigmadesigns.com>
 <20171020223149.GU6332@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <29c830bb-6648-aaf5-08b9-cc22f94e2e93@free.fr>
Date: Thu, 26 Oct 2017 08:37:19 +0200
MIME-Version: 1.0
In-Reply-To: <20171020223149.GU6332@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

+ linus t, mark b

On 21/10/2017 00:31, Bjorn Helgaas wrote:

> On Mon, Oct 16, 2017 at 11:09:15AM +0200, Marc Gonzalez wrote:
>
>> + gkh, maz, tglx, linus w
>>
>> On 15/10/2017 00:07, Fabio Estevam wrote:
>>
>>> When platform_get_irq() fails we should propagate the real error value
>>> instead of always returning -ENXIO.
>>>
>>> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>> Signed-off-by: Fabio Estevam <festevam@gmail.com>
>>> ---
>>>  drivers/pci/host/pcie-tango.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
>>> index e23f738..5196583 100644
>>> --- a/drivers/pci/host/pcie-tango.c
>>> +++ b/drivers/pci/host/pcie-tango.c
>>> @@ -272,9 +272,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
>>>  		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
>>>  
>>>  	virq = platform_get_irq(pdev, 1);
>>> -	if (virq <= 0) {
>>> +	if (virq < 0) {
>>>  		dev_err(dev, "Failed to map IRQ\n");
>>> -		return -ENXIO;
>>> +		return virq;
>>>  	}
>>>  
>>>  	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
>>
>> Hello Fabio,
>>
>> I don't think this patch is correct.
>>
>> AFAIU, on all but legacy platforms, when platform_get_irq() returns 0,
>> it is to signal an error condition.
>>
>> Marc Z pointed out this discussion:
>> http://yarchive.net/comp/linux/zero.html
>>
>> Looking more closely at the platform_get_irq implementation, and ignoring
>> the CONFIG_SPARC special-case, the return value is either:
>>
>> * a valid virq > 0, or
>> * -EPROBE_DEFER, or
>> * some error code < 0, in the ACPI case, or
>> * -ENXIO, or
>> * res->start (an unsigned type, so >= 0)
>>
>>
>> I suppose it would be slightly nicer to write:
>>
>> 	virq = platform_get_irq(pdev, 1);
>> 	if (virq <= 0)
>> 		return virq ? virq : -ENODEV;
> 
> All these return values end up getting returned by the driver probe()
> functions.  I don't think there's much value in returning the exact
> error we got from platform_get_irq() vs a generic error like -ENXIO or
> -ENODEV, so my $0.02 is that the above is more complicated than it's
> worth.
> 
> I think existing code that looks like:
> 
>   irq = platform_get_irq(pdev, 0);
>   if (irq <= 0)
>     return -ENODEV;
> 
> is fine and there's no reason to change it.  For code that doesn't
> check the platform_get_irq() return value, I'd say it's worth adding a
> check for "irq <= 0".  Maybe somebody will point out an arch that can
> return 0 as a legitimate IRQ, and then we'll have to rethink.

I agree with what Bjorn wrote, but there might be one exception
to consider: mapping EPROBE_DEFER to something else will likely
prevent the driver core from correctly handling deferred probes.

References for myself:
https://lwn.net/Articles/485194/
https://patchwork.kernel.org/patch/9558675/

Regards.
