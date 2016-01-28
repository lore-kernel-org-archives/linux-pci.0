Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35122 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934144AbcA1KXg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2016 05:23:36 -0500
Received: by mail-pf0-f173.google.com with SMTP id 65so21526694pfd.2
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2016 02:23:36 -0800 (PST)
Subject: Re: [PATCH V3 18/21] ACPI, PCI: Refine the way to handle
 translation_offset for ACPI resources
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, jiang.liu@linux.intel.com
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-19-git-send-email-tn@semihalf.com>
 <20160119122026.GA5185@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, okaya@codeaurora.org,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <56A9EC1C.4080806@linaro.org>
Date: Thu, 28 Jan 2016 18:23:24 +0800
MIME-Version: 1.0
In-Reply-To: <20160119122026.GA5185@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 2016/1/19 20:20, Lorenzo Pieralisi wrote:
> Gerry,
>
> On Wed, Jan 13, 2016 at 02:21:04PM +0100, Tomasz Nowicki wrote:
>> From: Liu Jiang <jiang.liu@linux.intel.com>
>>
>> Some architectures, such as IA64 and ARM64, have no instructions to
>> directly access PCI IO ports, so they map PCI IO ports into PCI MMIO
>> address space. Typically PCI host bridges on those architectures take
>> the responsibility to map (translate) PCI IO port transactions into
>> Memory-Mapped IO transactions. ACPI specification provides support
>> of such a usage case by using resource translation_offset.
>>
>> But current ACPI resource parsing interface isn't neutral enough,
>> it still has some special logic for IA64. So refine the ACPI resource
>> parsing interface and IA64 code to neutrally handle translation_offset
>> by:
>> 1) ACPI resource parsing interface doesn't do any translation, it just
>>     save the translation_offset to be used by arch code.
>> 2) Arch code will do the mapping(translation) based on arch specific
>>     information. Typically it does:
>> 2.a) Translate per PCI domain IO port address space into system global
>>     IO port address space.
>> 2.b) Setup MMIO address mapping for IO ports.
>
> This patch fixes IO space handling on IA64 and should go in as a fix.
>
> IA64 PCI IO space is currently broken (Hanjun tested this on an IA64 box).
>
> The first broken commit is:
>
> 3772aea7d6f3 ("ia64/PCI/ACPI: Use common ACPI resource parsing interface for host bridge")
>
> because acpi core code checks (in acpi_dev_ioresource_flags()) the
> resource.end>=0x10003, which fails on ia64 - currently resource.end is
> set in acpi_decode_space() to:
>
> AddressMaximum + AddressTranslation
>
> where AddressTranslation is the CPU physical address mapping IO space
> on IA64, the >=0x10003 check in acpi_dev_ioresource_flags always
> triggers and the IO resource is then disabled.
>
> Do you want me to re-send this patch as a fix, with updated commit log ?

I talked to Gerry offline, he is busy these days, he said it's pretty
OK for you to resend this patch and fix the problem.

Thanks
Hanjun
