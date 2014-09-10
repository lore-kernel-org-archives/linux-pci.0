Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <540FB3EA.5030109@linux.intel.com>
Date: Wed, 10 Sep 2014 10:14:02 +0800
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
	Grant Likely <grant.likely@linaro.org>, x86@kernel.org,
	Prarit Bhargava <prarit@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [Patch v4 07/16] x86, irq: Prefer assigned ID in APIC ID register
 for x86_64
References: <1409192561-19744-1-git-send-email-jiang.liu@linux.intel.com> <1409192561-19744-8-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.10.1409091256270.11037@nanos>
In-Reply-To: <alpine.DEB.2.10.1409091256270.11037@nanos>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014/9/9 19:04, Thomas Gleixner wrote:
> On Thu, 28 Aug 2014, Jiang Liu wrote:
> 
>> From: Yinghai Lu <yinghai@kernel.org>
>>
>> Perfer the assigned ID in APIC ID register for x86_64 if it's still
>> available.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  arch/x86/kernel/apic/io_apic.c |   38 +++++++++++++++++++++++++++++++++-----
>>  1 file changed, 33 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
>> index 3faf9599ff29..196d9c15fdec 100644
>> --- a/arch/x86/kernel/apic/io_apic.c
>> +++ b/arch/x86/kernel/apic/io_apic.c
>> @@ -3575,26 +3575,54 @@ static int __init io_apic_get_unique_id(int ioapic, int apic_id)
>>  	return apic_id;
>>  }
>>  
>> -static u8 __init io_apic_unique_id(u8 id)
>> +static u8 io_apic_unique_id(int idx, u8 id)
> 
> How is that change related to the changelog?
My bad, removal of __init marker belongs to next patch.

> 
>>  {
>>  	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
>>  	    !APIC_XAPIC(apic_version[boot_cpu_physical_apicid]))
>> -		return io_apic_get_unique_id(nr_ioapics, id);
>> +		return io_apic_get_unique_id(idx, id);
>>  	else
>>  		return id;
>>  }
>>  #else
>> -static u8 __init io_apic_unique_id(u8 id)
>> +static u8 io_apic_unique_id(int idx, u8 id)
>>  {
>>  	int i;
>> +	u8 new_id;
>> +	unsigned long flags;
>>  	DECLARE_BITMAP(used, 256);
>> +	union IO_APIC_reg_00 reg_00;
>>  
>>  	bitmap_zero(used, 256);
>>  	for_each_ioapic(i)
>>  		__set_bit(mpc_ioapic_id(i), used);
>>  	if (!test_bit(id, used))
>>  		return id;
>> -	return find_first_zero_bit(used, 256);
>> +
>> +	/* check register at first */
>> +	raw_spin_lock_irqsave(&ioapic_lock, flags);
>> +	reg_00.raw = io_apic_read(idx, 0);
>> +	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
>> +	new_id = reg_00.bits.ID;
>> +	if (!test_bit(new_id, used)) {
>> +		apic_printk(APIC_VERBOSE, KERN_INFO
>> +			"IOAPIC[%d]: Using reg apic_id %d instead of %d\n",
>> +			 idx, new_id, id);
>> +		return new_id;
>> +	}
>> +
>> +	new_id = find_first_zero_bit(used, 256);
>> +	reg_00.bits.ID = new_id;
>> +	raw_spin_lock_irqsave(&ioapic_lock, flags);
>> +	io_apic_write(idx, 0, reg_00.raw);
>> +	reg_00.raw = io_apic_read(idx, 0);
>> +	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
>> +
>> +	/* Sanity check */
>> +	if (reg_00.bits.ID != new_id)
>> +		pr_warn("IOAPIC[%d]: Unable to change apic_id to %d!\n",
>> +			idx, new_id);
> 
> So we detect, that the ID could not be changed and we return it
> nevertheless?
Seems it deserves a BUG_ON here. We have tried the ID from ACPI table,
the ID from hardware register, they all fails. And we can't change the
hardware register too. Seems no way out here.
Regards!
Gerry
> 
> Thanks,
> 
> 	tglx
> 
