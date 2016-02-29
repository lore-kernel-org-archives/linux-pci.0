Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50126 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbcB2TDy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Feb 2016 14:03:54 -0500
Subject: Re: [PATCH V5 00/15] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, Stefano.Stabellini@eu.citrix.com
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D49611.2050202@codeaurora.org>
Date: Mon, 29 Feb 2016 14:03:45 -0500
MIME-Version: 1.0
In-Reply-To: <1455630825-27253-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/16/2016 8:53 AM, Tomasz Nowicki wrote:
> From the functionality point of view this series might be split into the
> following logic parts:
> 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
>    PCI config regions and used when necessary.
> 2. Move non-arch specific bits to the core code.
> 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
> 
> Patches has been built on top of 4.5-rc3 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v5)
> 
> NOTE, this patch set depends on Lorenzo's fixes:
> https://patchwork.ozlabs.org/patch/576450/
> which can be found in pci-acpi-v5 branch.
> 
> This has been tested on Cavium ThunderX server, JunoR2, HP RX2660 IA64, x86,
> Hip05, X-Gene and QEMU-aarch64. Any help in reviewing and testing is very appreciated.
> 
> v4 -> v5
> - dropped MCFG refactoring group patches 1-6 from series v4 and integrated Jayachandran's patch
>   https://patchwork.ozlabs.org/patch/575525/
> - rewrite PCI legacy IRQs allocation
> - squashed two patches 11 and 12 from series v4, fixed bisection issue
> - changelog improvements
> - rebased to 4.5-rc3
> 
> v3 -> v4
> - dropped Jiang's fix http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04318.html
> - added Lorenzo's fix patch 19/24
> - ACPI PCI bus domain number assigning cleanup
> - changed resource management, we now claim and reassign resources
> - improvements for applying quirks
> - dropped Matthew's http://www.spinics.net/lists/linux-pci/msg45950.html dependency
> - rebased to 4.5-rc1
> 

Having tested v4 and v5, I'm seeing some resource assignment problems and address conflicts. 
And problems booting QEMU.

Anybody else seeing the same?



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
