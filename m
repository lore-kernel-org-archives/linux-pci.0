Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, okaya@codeaurora.org
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <5673281E.7020204@codeaurora.org> <5673FB6C.80008@semihalf.com>
 <4bccc2de7668dde04436ac9c19aac25d.squirrel@www.codeaurora.org>
 <20151221121050.GB11145@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, stefano.stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	liviu.dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, suravee.suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5677F3C8.8040200@semihalf.com>
Date: Mon, 21 Dec 2015 13:42:48 +0100
MIME-Version: 1.0
In-Reply-To: <20151221121050.GB11145@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21.12.2015 13:10, Lorenzo Pieralisi wrote:
> On Fri, Dec 18, 2015 at 06:56:39PM +0000, okaya@codeaurora.org wrote:
>
> [...]
>
>> Here is what I have as an IO resource.
>>
>> 		QWORDIO(			//Consumed-And-produced resource
>> 			ResourceProducer,	// bit 0 of general flags is 0
>> 			MinFixed,		// Range is fixed
>> 			MaxFixed,		// Range is fixed
>> 			PosDecode,
>> 			EntireRange,
>> 			0x0000,			// Granularity
>> 			0x1000,		// Min, 0 is not accepted
>> 			0x10FFF,		// Max
>> 			0x8FFFFFEF000,	// Translation
>> 			0x10000,		// Range Length
>> 			,, PI00
>> 		 )
>>
>> I don't have any type specified.
>>
>> I agree with Lorenzo's assessment. The min and max values represent the
>> PCI IO bus addresses. The translation offset is added to these values to
>> figure out the CPU view of the PCI IO range.
>>
>> The endpoints BAR addresses are programmed with IO addresses ranging
>> between 0x1000 and 0x10FFF for this example above.
>>
>> Here is another question. Chris Covington and I asked this question on a
>> private email to you but we didn't hear back.
>>
>> We were referring to a Linaro IO hack patch as we were not sure whether
>> this was a limitation of the hack or a general expectation for ARM64 PCI
>> in general.
>>
>> I'll repeat it here.
>>
>> I have multiple root ports with the same IO port configuration in the
>> current ACPI table.
>>
>> Root port 0 = IO range 0x1000-0x10FFF
>> Root port 1 = IO range 0x1000-0x10FFF
>> Root port 2 = IO range 0x1000-0x10FFF
>
> It is fine. You end up mapping for each of those a 4k window of the
> virtual address space allocated to IO and that's what you will have in
> the kernel PCI resources (not in the HW BARs though). If that was a problem
> it would be even for the current DT host controllers eg:
>
> arch/arm64/boot/dts/apm/apm-storm.dtsi
>
> it should not be (again I will let Arnd comment on this since he may be
> aware of issues encountered on other arches/platforms).
>

Root port 0 = IO range 0x1000-0x10FFF
Root port 1 = IO range 0x1000-0x10FFF
Root port 2 = IO range 0x1000-0x10FFF

If above ranges are mapped into different CPU windows, then yes, it is fine.

Tomasz

