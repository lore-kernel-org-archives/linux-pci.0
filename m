Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36822 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbcAROh4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2016 09:37:56 -0500
Received: by mail-pf0-f181.google.com with SMTP id n128so158753406pfn.3
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2016 06:37:56 -0800 (PST)
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <5698D163.6050404@linaro.org>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <569CF8BC.8060102@linaro.org>
Date: Mon, 18 Jan 2016 22:37:48 +0800
MIME-Version: 1.0
In-Reply-To: <5698D163.6050404@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/1/15 19:00, Hanjun Guo wrote:
> On 2016/1/13 21:20, Tomasz Nowicki wrote:
>>  From the functionality point of view this series might be split into the
>> following logic parts:
>> 1. Make MMCONFIG code arch-agnostic which allows all architectures to
>> collect
>>     PCI config regions and used when necessary.
>> 2. Move non-arch specific bits to the core code.
>> 3. Use MMCONFIG code and implement generic ACPI based PCI host
>> controller driver.
>> 4. Enable above driver on ARM64
>>
>> Patches has been built on top of 4.4 and can be found here:
>> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
>>
>> NOTE, this patch set depends on Matthew's patches:
>> http://www.spinics.net/lists/linux-pci/msg45950.html
>> https://github.com/Vality/linux/tree/pci-fixes
>>
>> This has been tested on Cavium ThunderX server and QEMU.
>> Any help in reviewing and testing is very appreciated.
>>
>> v2 -> v3
>> - fix legacy IRQ assigning and IO ports registration
>> - remove reference to arch specific companion device for ia64
>> - move ACPI PCI host controller driver to pci_root.c
>> - drop generic domain assignment for x86 and ia64 as I am not
>>    able to run all necessary test variants
>> - drop patch which cleaned legacy IRQ assignment since it belongs to
>>    Mathew's series:
>>    https://patchwork.ozlabs.org/patch/557504/
>> - extend MCFG quirk code
>> - rebased to 4.4
>
> Tested this patch set (and Matthew's) on a HP RX2660 IA64 machine,
> with the CONFIG_ACPI_PCI_HOST_GENERIC disabled on IA64 ( it's a minor
> comment needs to be addressed in my previous email), it can boot
> the system ok with NIC working properly, with the /pro/ioports [1] and
> the boot log [2] if anyone needs refer to it.
>
> For this patch set, on IA64 machine,
>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

I tested this patch set on x86 server with CONFIG_ACPI_PCI_HOST_GENERIC
disabled today, also booted ok with NIC working properly.

Thanks
Hanjun
