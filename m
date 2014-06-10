Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <53967992.2020808@linux.intel.com>
Date: Tue, 10 Jun 2014 11:20:50 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [Patch V4 11/42] x86, ioapic: kill unused global variable timer_through_8259
References: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com> <1402302011-23642-12-git-send-email-jiang.liu@linux.intel.com> <alpine.LFD.2.11.1406091538320.14982@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1406091538320.14982@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014/6/9 22:41, Maciej W. Rozycki wrote:
> On Mon, 9 Jun 2014, Jiang Liu wrote:
> 
>> index d4aba16e6bbf..94a56c233e87 100644
>> --- a/arch/x86/kernel/apic/io_apic.c
>> +++ b/arch/x86/kernel/apic/io_apic.c
>> @@ -2638,8 +2638,6 @@ static int __init disable_timer_pin_setup(char *arg)
>>  }
>>  early_param("disable_timer_pin_1", disable_timer_pin_setup);
>>  
>> -int timer_through_8259 __initdata;
>> -
>>  /*
>>   * This code may look a bit paranoid, but it's supposed to cooperate with
>>   * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
>> @@ -2744,7 +2742,6 @@ static inline void __init check_timer(void)
>>  		legacy_pic->unmask(0);
>>  		if (timer_irq_works()) {
>>  			apic_printk(APIC_QUIET, KERN_INFO "....... works.\n");
>> -			timer_through_8259 = 1;
>>  			goto out;
>>  		}
>>  		/*
> 
>  So how does the new NMI watchdog handle systems that use this '8259A 
> Virtual Wire' mode, pretty common on pre-P6 computers?
Hi Maciej,
	We just kill the useless variable "timer_through_8259", 8259 virtual
wire mode is still supported.
Thanks!
Gerry

> 
>   Maciej
> 
