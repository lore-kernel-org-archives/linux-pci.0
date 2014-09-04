Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <54082ADD.6040004@arm.com>
Date: Thu, 04 Sep 2014 10:03:25 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: Sudeep Holla <sudeep.holla@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 01/11] cpumask: factor out show_cpumap into separate
 helper function
References: <1409763617-17074-1-git-send-email-sudeep.holla@arm.com> <1409763617-17074-2-git-send-email-sudeep.holla@arm.com> <20140904062006.GC3190@worktop.ger.corp.intel.com>
In-Reply-To: <20140904062006.GC3190@worktop.ger.corp.intel.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Peter,

On 04/09/14 07:20, Peter Zijlstra wrote:
> On Wed, Sep 03, 2014 at 06:00:07PM +0100, Sudeep Holla wrote:
>> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
>> index 2997af6d2ccd..26d8348292dd 100644
>> --- a/include/linux/cpumask.h
>> +++ b/include/linux/cpumask.h
>> @@ -11,6 +11,8 @@
>>   #include <linux/bitmap.h>
>>   #include <linux/bug.h>
>>
>> +#include <asm/page.h>
>> +
>>   typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
>>
>>   /**
>> @@ -792,6 +794,31 @@ static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
>>   }
>>   #endif /* NR_CPUS > BITS_PER_LONG */
>>
>> +/**
>> + * cpumap_copy_to_buf  - copies the cpumask into the buffer either
>> + *	as comma-separated list of cpus or hex values of cpumask
>> + * @list: indicates whether the cpumap must be list
>> + * @mask: the cpumask to copy
>> + * @buf: the buffer to copy into
>> + *
>> + * Returns the length of the (null-terminated) @buf string, zero if
>> + * nothing is copied.
>> + */
>> +static inline ssize_t
>> +cpumap_copy_to_buf(bool list, const struct cpumask *mask, char *buf)
>> +{
>> +	ptrdiff_t len = PTR_ALIGN(buf + PAGE_SIZE - 1, PAGE_SIZE) - buf - 2;
>> +	int n = 0;
>> +
>> +	if (len > 1) {
>> +		n = list ? cpulist_scnprintf(buf, len, mask) :
>> +			   cpumask_scnprintf(buf, len, mask);
>> +		buf[n++] = '\n';
>> +		buf[n] = '\0';
>> +	}
>> +	return n;
>> +}
>> +
>
> Does that really make sense as an inline?
>

If I don't, every file including this header generates "warning:
‘cpumap_copy_to_buf’ defined but not used". Alternatively I can just
declare here and define it elsewhere but I could not find more apt
place than this. Any suggestions ? kernel/cpu.c ?

Regards,
Sudeep

