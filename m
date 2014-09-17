Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5418F0FB.6090004@linux.intel.com>
Date: Wed, 17 Sep 2014 10:24:59 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC Part2 v1 03/21] x86, irq: Save destination CPU ID in irq_cfg
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com> <1410444228-3134-4-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.10.1409161046460.4247@nanos>
In-Reply-To: <alpine.DEB.2.10.1409161046460.4247@nanos>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014/9/17 1:47, Thomas Gleixner wrote:
> 
> 
> On Thu, 11 Sep 2014, Jiang Liu wrote:
> 
>> Cache destination CPU APIC ID into struct irq_cfg when assigning vector
>> for interrupt. Upper layer just needs to read the cached APIC ID instead
>> of calling apic->cpu_mask_to_apicid_and(), it helps to hide APIC driver
>> details from IOAPIC/HPET/MSI drivers..
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  arch/x86/include/asm/hw_irq.h |    1 +
>>  arch/x86/kernel/apic/vector.c |    4 ++++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
>> index 7624fffc2822..3d51d74d6c01 100644
>> --- a/arch/x86/include/asm/hw_irq.h
>> +++ b/arch/x86/include/asm/hw_irq.h
>> @@ -116,6 +116,7 @@ struct irq_data;
>>  struct irq_cfg {
>>  	cpumask_var_t		domain;
>>  	cpumask_var_t		old_domain;
>> +	unsigned int		dest_apicid;
>>  	u8			vector;
>>  	u8			move_in_progress : 1;
>>  #ifdef CONFIG_IRQ_REMAP
>> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
>> index 7562cb15b3bd..287ae4e8d500 100644
>> --- a/arch/x86/kernel/apic/vector.c
>> +++ b/arch/x86/kernel/apic/vector.c
>> @@ -188,6 +188,10 @@ next:
>>  	}
>>  	free_cpumask_var(tmp_mask);
> 
> Lacks a comment what this call is actually doing.
How about this?
/* cache destination APIC IDs into cfg->dest_apicid */
Regards!
Gerry
>   
>> +	if (!err)
>> +		err = apic->cpu_mask_to_apicid_and(mask, cfg->domain,
>> +						   &cfg->dest_apicid);
>> +
> 
> Thanks,
> 
> 	tglx
> 
