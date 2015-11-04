Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59278 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401AbbKDJD4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Nov 2015 04:03:56 -0500
Message-ID: <5639C9F9.2010704@arm.com>
Date: Wed, 04 Nov 2015 09:03:53 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: "majun (F)" <majun258@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 7/7] irqchip: [Example] dummy wired interrupt/MSI
 bridge driver
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <1444923568-17413-8-git-send-email-marc.zyngier@arm.com> <5639BB10.1090108@huawei.com>
In-Reply-To: <5639BB10.1090108@huawei.com>
Content-Type: text/plain; charset=gbk
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/11/15 08:00, majun (F) wrote:
> Hi Marc:
> 
> ÔÚ 2015/10/15 23:39, Marc Zyngier Ð´µÀ:
>> In order to demonstrate how to put together a wire/MSI bridge,
>> add a dummy driver that doesn't do anything at all, except
>> for allocating interrupts.
>>
>> It comes together with an even more stupid client driver that
>> allocates an interrupt and dump the hierarchy of that interrupt.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
> [...]
>> +
>> +static int msichip_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +				   unsigned int nr_irqs, void *arg)
>> +{
>> +	int i, err;
>> +	irq_hw_number_t hwirq;
>> +	unsigned int type;
>> +	struct irq_fwspec *fwspec = arg;
>> +	void *data;
>> +
>> +	err = msichip_domain_translate(domain, fwspec, &hwirq, &type);
>> +	if (err)
>> +		return err;
>> +
> 
> .translate function already called once in  irq_domain_translate(),
> I think we don't need call this fucntion one more time here.

if you don't translate it here, how do you obtain the hwirq that you
have to pass to irq_domain_set_hwirq_and_chip just below?

>> +	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
>> +	if (err)
>> +		return err;
>> +
>> +	data = platform_msi_get_host_data(domain);
>> +	for (i = 0; i < nr_irqs; i++)
>> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> +					      &msichip_chip, data);
>> +
>> +	return 0;
>> +}
>> +
> [...]
>> +
>> +static struct platform_driver msichip_driver = {
>> +	.driver = {
>> +		.name		= "msichip",
>> +		.of_match_table	= msichip_of_match,
>> +	},
>> +	.probe			= msichip_probe,
>> +};
>> +/* Do not define this as an irqchip */
>> +module_platform_driver(msichip_driver);
>> +
>> +
> 
> I think,for a interrupt controller, msichip driver initialization maybe is too late
> for some devices which connect to this irqchip if we use module_platform_driver.

That's a consequence of this design. This is why I insisted on the fact
that this is currently avoided by using deferred probe in drivers, and
that it should be solved by having a probe order. Either way, this is
not something that we can solve at that level (see the multiple proposal
for this on the various lists).

> So, how about use the arch_initcall to register the msichip driver?

You're only pushing the problem one level up. And you'll realize that
this is not enough for some random driver. This is not sustainable, and
must be addressed properly.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
