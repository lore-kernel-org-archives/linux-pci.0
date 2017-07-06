Return-Path: <SRS0=9N9N=6J=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=9N9N=6J=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v9 0/3] Tango PCIe controller support
To: Mason <slash.tmp@free.fr>, Bjorn Helgaas <helgaas@kernel.org>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <20170704202412.GK13824@bhelgaas-glaptop.roam.corp.google.com>
 <6256cab3-dd77-c0f6-66b8-be261695bbb1@free.fr>
 <20170705180359.GL13824@bhelgaas-glaptop.roam.corp.google.com>
 <5a1207cb-31fd-6b85-86af-8c37bd57ad4f@free.fr>
 <20170705213419.GD25063@bhelgaas-glaptop.roam.corp.google.com>
 <8dcab663-245b-880a-be3a-2965fd12d663@free.fr>
 <20170706033946.GO13824@bhelgaas-glaptop.roam.corp.google.com>
 <d04e1632-17b8-85f9-31c4-b789d55cc853@free.fr>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <37d9f990-c037-5ccd-c162-786ca2bd07b5@arm.com>
Date: Thu, 6 Jul 2017 13:40:37 +0100
MIME-Version: 1.0
In-Reply-To: <d04e1632-17b8-85f9-31c4-b789d55cc853@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 06/07/17 13:26, Mason wrote:
> On 06/07/2017 05:39, Bjorn Helgaas wrote:
> 
>> On Wed, Jul 05, 2017 at 11:59:33PM +0200, Mason wrote:
>>
>>> There were a few nits I wanted to address:
>>>
>>> - Since we added suppress_bind_attrs = true, probe()
>>> can only be called at init, so I wanted to mark __init
>>> all the probe functions, to save space.
>>>
>>> - I left the definition of MSI_MAX in the wrong patch
>>>
>>> - You put a pointer to the pdev in the struct tango_pcie.
>>> I think this is redundant, since the pdev already has a
>>> pointer to the struct, as drvdata.
>>> So I wanted to change tango_msi_probe() to take a pdev
>>> as argument (to make it more like an actual probe function)
>>> and derive pcie from pdev, instead of the other way around.
>>
>> I don't think tango_msi_probe() is really a "probe" function.  It's
>> all part of the tango driver, and it's not claiming a separate piece
>> of hardware.
> 
> I agree that tango_msi_probe() is not a probe function;
> it is merely a piece of the actual probe function (static
> with single call site). I split the probe function in two,
> because it seemed to make sense at the time.
> 
> Perhaps it's better to inline tango_msi_probe? That would
> avoid the issues of that function's name and parameters.
> 
> If you think it's better to keep the two pieces separate,
> I can rename the MSI part to tango_msi_init() or some such.
> But I'd like to avoid adding unnecessary fields to the struct.
> 
>>  So I would keep the name and structure similar to these:
>>
>>   advk_pcie_init_msi_irq_domain()
>>   nwl_pcie_init_msi_irq_domain()
>>
>> BTW, those functions use irq_domain_add_linear(), while you are one of
>> the very few callers of irq_domain_create_linear().  Why the difference?
>> If your code does basically the same thing, it's very helpful to me if
>> it *looks* basically the same.

irq_domain_add_linear() can only take an of_node as the identifier for
the domain, while the _create_ variants use a fwnode. Given that an
of+node is also a fwnode, the former is now deprecated in favour of the
latter.

> 
> It was a suggestion from Marc Z on 2017-03-23.
> 
> <QUOTE>
> + irq_dom = irq_domain_add_linear(NULL, MSI_COUNT, &msi_domain_ops, pcie);
> 
> Use irq_domain_create_linear, pass the same fwnode.
> </QUOTE>
> 
> It seems odd to pass NULL as the first argument.
> (As I had first done, when copying the Altera driver.)

Indeed, as it creates a "default" domain, which is almost always wrong.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
