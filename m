Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Arnd Bergmann <arnd@arndb.de>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <5638C728.2020503@semihalf.com> <5638CE5D.4030703@codeaurora.org>
 <5802577.H74A3Lg5B3@wuerfel>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bhelgaas@google.com, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5638E1CE.9000805@codeaurora.org>
Date: Tue, 3 Nov 2015 11:33:18 -0500
MIME-Version: 1.0
In-Reply-To: <5802577.H74A3Lg5B3@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/3/2015 10:59 AM, Arnd Bergmann wrote:
> On Tuesday 03 November 2015 10:10:21 Sinan Kaya wrote:
>>
>> I don't see anywhere in the SBSA spec addendum that the PCI
>> configuration space section that unaligned accesses *MUST* be supported.
>>
>> If this is required, please have this info added to the spec. I can work
>> with the designers for the next chip.
>>
>> Unaligned access on the current hardware returns incomplete values or
>> can cause bus faults. The behavior is undefined.
>
> Unaligned accesses are not allowed, but any PCI compliant device must
> support aligned 1, 2 or 4 byte accesses on its configuration space,
> though the byte-enable mechanism. In an ECAM host bridge, those are
> mapped to load/store accesses from the CPU with the respective width
> and natural alignment.
>
> 	Arnd
>

As far as I see, the endpoints do not have any problems with unaligned 
accesses. It is the host bridge itself (stuff that doesn't get on the 
PCIe bus and uses traditional AXI kind bus internally) has problems with 
alignment.

If Linux is expecting all HW vendors to implement alignment support, 
this needs to be put in the SBSA spec as a hard requirement.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
