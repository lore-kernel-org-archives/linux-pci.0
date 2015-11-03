Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35861 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbbKCOjr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2015 09:39:47 -0500
Received: by lffz202 with SMTP id z202so20372684lff.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Nov 2015 06:39:45 -0800 (PST)
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <20151103141512.GC3574@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5638C728.2020503@semihalf.com>
Date: Tue, 3 Nov 2015 15:39:36 +0100
MIME-Version: 1.0
In-Reply-To: <20151103141512.GC3574@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03.11.2015 15:15, Lorenzo Pieralisi wrote:
> On Wed, Oct 28, 2015 at 02:46:37PM -0400, Sinan Kaya wrote:
>
> [...]
>
>>> -int raw_pci_write(unsigned int domain, unsigned int bus,
>>> -		unsigned int devfn, int reg, int len, u32 val)
>>> +struct pci_ops pci_root_ops = {
>>> +	.map_bus = pci_mcfg_dev_base,
>>> +	.read = pci_generic_config_read,
>>> +	.write = pci_generic_config_write,
>>
>>
>> Can you change these with pci_generic_config_read32 and
>> pci_generic_config_write32? We have some targets that can only do 32
>> bits PCI config space access.
>
> No.
>
> http://www.spinics.net/lists/linux-pci/msg44869.html
>
> Can you be a bit more specific please ?
>
> Sigh. Looks like we have to start adding platform specific quirks even
> before we merged the generic ACPI PCIe host controller implementation.
>

The sad reality... But my next version will be still generic. Once that 
one appear to be in good shape then we can add quirks.

Regards,
Tomasz
