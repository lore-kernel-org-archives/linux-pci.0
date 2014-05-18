Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5378764C.5050601@linux.intel.com>
Date: Sun, 18 May 2014 16:58:52 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	sfi-devel@simplefirmware.org
Subject: Re: [RFC Patch Part1 V1 00/30] use irqdomain to dynamically allocate
 IRQ for IOAPIC pin
References: <1400227550-5935-1-git-send-email-jiang.liu@linux.intel.com> <CAE9FiQVHG5hPChCYXb2St4WpDhdwvaNwDLXzhRt_T0wbyfnvwg@mail.gmail.com>
In-Reply-To: <CAE9FiQVHG5hPChCYXb2St4WpDhdwvaNwDLXzhRt_T0wbyfnvwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014/5/16 23:01, Yinghai Lu wrote:
> On Fri, May 16, 2014 at 1:05 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
>> On x86 platforms, IRQ number are statically allocated to IOAPIC pins at boot.
>> There are two issues with this design. First it causes trouble to IOAPIC
>> hotplug because we need to allocate a block of IRQ numbers for each IOAPIC.
>> Second it may waste IRQ nubmers even if some IOAPIC pins are not used because
>> IRQ numbers are statically assigned.
>>
>> This patchset tries to enable dynamic IRQ number allocation for IOAPIC
>> by adopting the irqdomain framework, it solves the two issues mentioned
>> above. It also simplifies the IOAPIC driver by consolidating ways to
>> program IOAPIC pins with the irqdomain map interface.
>>
>> We will enhance the IOAPIC driver core to support ACPI based IOAPIC hotplug
>> once the IOAPIC driver has been converted to irqdomain.
>>
>> This patchset applies to v3.15-rc4-260-g38583f095c5a and has been tested
>> on a two socket 64 bit Intel platforms with:
>> 1) ACPI and mpparse enabled (boot successfully)
>> 2) Mpparse enabled with ACPI disabled (boot successfully)
>> 3) ACPI enabled with Mpparse disabled (boot successfully)
> 
> Great. I don't need to look into using irqdomain for x86 by myself.
> 
> Thomas put some irq clean up patches in tip irq branch.
> 
> Can you rebase your irqdomain/for x86 on top of that?
> Also would be better if you can put your patches in git branch.
Hi Yinghai,
	I have rebased to tip/irq/core branch and will send out new patch set
after basic tests. I have no account at kernel.org, so will
try to setup a gate on github next time.
Thanks!
> 
> Thanks
> 
> Yinghai
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
