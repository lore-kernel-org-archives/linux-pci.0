Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <20151221121050.GB11145@red-moon> <5677F3C8.8040200@semihalf.com>
 <201512211515.55447.arnd@arndb.de>
 <b3750d7918712f6035ea875d90c25471.squirrel@www.codeaurora.org>
 <20160111153949.GA2366@red-moon>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
	bhelgaas@google.com, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, stefano.stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	liviu.dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, suravee.suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5693D0AE.4020306@codeaurora.org>
Date: Mon, 11 Jan 2016 10:56:30 -0500
MIME-Version: 1.0
In-Reply-To: <20160111153949.GA2366@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/11/2016 10:39 AM, Lorenzo Pieralisi wrote:
>> Thanks, I won't be touching the acpi tables then and I will assume the
>> > hack had a problem. It was trying to remap the io range of the second root
>> > port  to the first port io address map.
>> > 
>> > I was getting a warning from resource.c
>> > 
>> > Btw, when I tested the io ranges before, kernel didn't accept anything
>> > below 1k like 0. That is why my range starts at 1k.
> And that's what you should not do. ACPI tables have to have a 1:1
> correspondence with HW resources and you must not change them to
> make the kernel (which version by the way, given that ARM64 ACPI PCI
> support is not in the mainline) work. I already said that: we must not
> interpret ACPI tables, we must define them according to specifications,
> and that's what everyone should follow to write FW.
> 

What confused me was the kernel view of IO addresses vs. PCI IO addresses. I looked at
Mark Salter's patch and I realized that the kernel is maintaining global IO addresses with offsets 
to real PCI IO addresses.

I was expecting to see the PCI addresses to match kernel IO addresses. I wondered if somebody put some
restriction into Linux or not which happened to me below.

_#_cat_/proc/ioports
00000000-0000efff : PCI Bus 0000:00
  00001000-00001fff : PCI Bus 0000:01
0000f000-0001dfff : PCI Bus 0002:00
  0000f000-0000ffff : PCI Bus 0002:01
0001e000-0002cfff : PCI Bus 0006:00
  0001e000-0001efff : PCI Bus 0006:01
    0001e000-0001e01f : 0006:01:00.0
    0001e020-0001e03f : 0006:01:00.1
/ #

#_dmesg_|_grep_resource
[    2.945762] pci_bus 0000:00: root bus resource [io  0x0000-0xefff window] (bus address [0x1000-0xffff])
[    3.652201] pci_bus 0002:00: root bus resource [io  0xf000-0x1dfff window] (bus address [0x1000-0xffff])
[    6.546716] pci_bus 0006:00: root bus resource [io  0x1e000-0x2cfff window] (bus address [0x1000-0xffff])
/ #

Since we are talking about what ACPI dictates vs. what kernel does. Here is something that got me 
while testing.

Somebody sneaked in a 0x10003 upper limit on PCI addresses for some reason below. There is nothing magic
about 0x10003 and I'm wonding why we have this limit.

static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
				      u8 io_decode, u8 translation_type)
{
	res->flags = IORESOURCE_IO;

	if (!acpi_dev_resource_len_valid(res->start, res->end, len, true))
		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;

	if (res->end >= 0x10003)
		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;



I did a debug session with Tomasz last week. He fixed the issue. The range for
IO resources were not being registered properly. The second root port was causing
a bug check in the kernel because the IO range was overlapping with the first root port.
The issue is fixed now. 


> So, why does your PCI IO range starts at 1k ? Please define what you
> mean by "kernel didn't accept anything below 1k", I want to understand
> what you are referring to.

I created my own version of ACPI PCI root port patch by porting ia64 to ARMv7 two years ago
and wrote the ACPI table on an ARMv7 platform. I have been reusing the same tables since
then. 

The issue was what Arnd described in his email to this thread. (PCIBIOS_MIN_IO) macro. 
I have tested the IO range starting from 0 on Tomasz's patches. I'm not seeing any problems.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
