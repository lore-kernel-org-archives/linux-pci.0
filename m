Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <538451E7.7030206@linux.intel.com>
Date: Tue, 27 May 2014 16:50:47 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Grant Likely <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, x86@kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [Patch V3 01/37] x86, irq: update high address field when updating
 affinity for MSI IRQ
References: <1401178092-1228-1-git-send-email-jiang.liu@linux.intel.com> <1401178092-1228-2-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.02.1405271010570.21720@ionos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.02.1405271010570.21720@ionos.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yes, I think it should be marked for stable branches.

On 2014/5/27 16:11, Thomas Gleixner wrote:
> On Tue, 27 May 2014, Jiang Liu wrote:
> 
>> If x2apic is enabled, the MSI high address field should also be aslo
>> updated when setting affinity for MSI IRQ, otherwise the MSI IRQ may
>> target wrong APIC IDs.
> 
> That should be tagged for stable, right?
>  
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  arch/x86/kernel/apic/io_apic.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
>> index 9d0a9795a0f8..2de992501a1b 100644
>> --- a/arch/x86/kernel/apic/io_apic.c
>> +++ b/arch/x86/kernel/apic/io_apic.c
>> @@ -3007,6 +3007,10 @@ msi_set_affinity(struct irq_data *data, const struct cpumask *mask, bool force)
>>  
>>  	__get_cached_msi_msg(data->msi_desc, &msg);
>>  
>> +	msg.address_hi = MSI_ADDR_BASE_HI;
>> +	if (x2apic_enabled())
>> +		msg.address_hi |= MSI_ADDR_EXT_DEST_ID(dest);
>> +
>>  	msg.data &= ~MSI_DATA_VECTOR_MASK;
>>  	msg.data |= MSI_DATA_VECTOR(cfg->vector);
>>  	msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
>> -- 
>> 1.7.10.4
>>
>>
