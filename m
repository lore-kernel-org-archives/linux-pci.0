Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <b3750d7918712f6035ea875d90c25471.squirrel@www.codeaurora.org>
In-Reply-To: <201512211515.55447.arnd@arndb.de>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
    <20151221121050.GB11145@red-moon> <5677F3C8.8040200@semihalf.com>
    <201512211515.55447.arnd@arndb.de>
Date: Mon, 21 Dec 2015 15:26:14 -0000
Subject: Re: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
From: Okaya@codeaurora.org
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Tomasz Nowicki" <tn@semihalf.com>,
	"Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
	okaya@codeaurora.org, bhelgaas@google.com, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, stefano.stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	liviu.dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, suravee.suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Monday 21 December 2015, Tomasz Nowicki wrote:
>> On 21.12.2015 13:10, Lorenzo Pieralisi wrote:
>> > On Fri, Dec 18, 2015 at 06:56:39PM +0000, okaya@codeaurora.org wrote:
>
>> >> I have multiple root ports with the same IO port configuration in the
>> >> current ACPI table.
>> >>
>> >> Root port 0 = IO range 0x1000-0x10FFF
>> >> Root port 1 = IO range 0x1000-0x10FFF
>> >> Root port 2 = IO range 0x1000-0x10FFF
>> >
>> > It is fine. You end up mapping for each of those a 4k window of the
>> > virtual address space allocated to IO and that's what you will have in
>> > the kernel PCI resources (not in the HW BARs though). If that was a
>> problem
>> > it would be even for the current DT host controllers eg:
>> >
>> > arch/arm64/boot/dts/apm/apm-storm.dtsi
>> >
>> > it should not be (again I will let Arnd comment on this since he may
>> be
>> > aware of issues encountered on other arches/platforms).
>> >
>>
>> Root port 0 = IO range 0x1000-0x10FFF
>> Root port 1 = IO range 0x1000-0x10FFF
>> Root port 2 = IO range 0x1000-0x10FFF
>>
>> If above ranges are mapped into different CPU windows, then yes, it is
>> fine.
>
> Ideally, they should all be the same CPU address so we only have to map
> the window
> once, each device gets an address below 64K, and you can have legacy port
> numbers
> (below 4K) on any bus, which is required to make certain GPUs work.
>
> I haven't actually seen anyone do that on ARM though, every implementation
> so
> far has a separate mapping per host bridge, and we can cope with that too,
> and we can live with either overlapping bus addresses or unique bus
> addresses,
> any of them can be expressed by the PCI core in Linux, we just have to
> make sure
> that we correctly translate the firmware tables into our internal
> structures.
>
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thanks, I won't be touching the acpi tables then and I will assume the
hack had a problem. It was trying to remap the io range of the second root
port  to the first port io address map.

I was getting a warning from resource.c

Btw, when I tested the io ranges before, kernel didn't accept anything
below 1k like 0. That is why my range starts at 1k.

