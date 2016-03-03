Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V5 00/15] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <56D49611.2050202@codeaurora.org> <20160303112332.GC28359@red-moon>
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, yinghai@kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D84938.6020102@codeaurora.org>
Date: Thu, 3 Mar 2016 09:24:56 -0500
MIME-Version: 1.0
In-Reply-To: <20160303112332.GC28359@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/3/2016 6:23 AM, Lorenzo Pieralisi wrote:
> x86 and IA64 claim PCI resources on boot and live with that (well, minus
> the gazillions x86 pci= parameters that change the PCI resources assignment
> one way or another), comments very welcome in particular on the pci=realloc
> option and its usage.

I have been working with Linux PCIe over 3 years. I never used pci=realloc argument.

The v5 series minus [PATCH V5 11/15] drivers: pci: add generic code to claim bus resources
is working just fine and is ready to go upstream in my opinion. It passed my internal 
testing with different types of endpoints.

The inclusion of this patch is now requiring everybody to add pci=realloc argument
otherwise the resources assigned by the UEFI BIOS are not working.

I think there is still some work to be done in this patch and is too early to be included
into the series. It is blocking progress of the series which is sitting on review over 1 
year already.

[    0.752916] pci 0000:01:00.0: VF(n) BAR2 space: [mem 0x80360800000-0x8037fffffff 64bit pref] (contains BAR2 for 63 VFs)
[    0.771799] pci 0000:00:00.0: PCI bridge to [bus 01-06]
[    0.777054] pci 0000:00:00.0: root [mem 0x80100100000-0x8013fffffff window] res [mem 0x8013ff00000-0x8013fffffff] nr 14
[    0.787846] pci 0000:00:00.0: pci_claim_bridge_resource:714 1: i:14
[    0.794135] pci 0000:00:00.0: root [mem 0x80300000000-0x8037fffffff window] res [mem 0x80360000000-0x8037fffffff 64bit pref] nr 15
[    0.805881] pci 0000:00:00.0: pci_claim_bridge_resource:714 1: i:15
[    0.812155] pci 0000:01:00.0: root [mem 0x8013ff00000-0x8013fffffff] res [mem 0x8013ff00000-0x8013fffffff 64bit] nr 0
[    0.822773] pci 0000:01:00.0: root [mem 0x80360000000-0x8037fffffff 64bit pref] res [mem 0x80360000000-0x803607fffff 64bit pref] nr 2
[    0.834778] pci 0000:01:00.0: root [mem 0x80360000000-0x8037fffffff 64bit pref] res [mem 0x8037ff00000-0x8037fffffff pref] nr 6
[    0.846265] pci 0000:01:00.0: can't claim BAR 9 [mem 0x80360800000-0x8037fffffff 64bit pref]: address conflict with 0000:01:00.0 [mem 0x8037ff00000-0x8037fffffff pref]
[    0.861237] pci 0000:01:00.0: BAR 9: no space for [mem size 0x1f800000 64bit pref]
[    0.868811] pci 0000:01:00.0: BAR 9: failed to assign [mem size 0x1f800000 64bit pref]


I keep saying this but the type of CPU is not important when it comes to PCIe. Both PCIe and
ACPI are governed by specs. If it is working for x86 and i64; it needs to work for ARM64 as
well. 

Even ARM64 has the luxury to omit the old BIOS behaviors. Most ARM64 systems use tianocore based
UEFI BIOS.

This is pointing to an implementation problem in arm64 adaptation. Need to figure out
what is different.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
