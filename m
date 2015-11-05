Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [Linaro-acpi] [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI
 based PCI hostbridge init
To: Arnd Bergmann <arnd@arndb.de>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <5802577.H74A3Lg5B3@wuerfel> <5638E1CE.9000805@codeaurora.org>
 <3736182.0iiYWufyXZ@wuerfel> <5638F243.2050907@codeaurora.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	will.deacon@arm.com, ddaney@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, linaro-acpi@lists.linaro.org,
	wangyijing@huawei.com, robert.richter@caviumnetworks.com,
	tglx@linutronix.de, catalin.marinas@arm.com, bhelgaas@google.com,
	Liviu.Dudau@arm.com, jiang.liu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <563B6C52.8020204@codeaurora.org>
Date: Thu, 5 Nov 2015 09:48:50 -0500
MIME-Version: 1.0
In-Reply-To: <5638F243.2050907@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/3/2015 12:43 PM, Sinan Kaya wrote:
> In any case, the hardware document says 32 bit configuration space
> access to the host bridge only. I'll get more clarification.
>
I got confirmation this morning that this chip supports 32 bit access to 
the root complex configuration space. 8/16/32 bits accesses to the 
endpoints are supported.

>>
>> You can probably work around this by using the legacy I/O port method
>> rather than ECAM, if the PCI host bridge itself is functional and just
>> the host bus it is connected to is buggy.
>
>  From the sounds of it, we'll need a quirk for config space. We support
> legacy I/O only to make the endpoints happy. Some endpoints do not get
> initialized if they don't have a BAR address assigned to all the BAR
> resources.

We'll need an MCFG fix up.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
