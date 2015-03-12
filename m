Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34482 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbbCLNnB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 09:43:01 -0400
Received: by lbvn10 with SMTP id n10so16070092lbv.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2015 06:43:00 -0700 (PDT)
Message-ID: <550197DB.7030900@linaro.org>
Date: Thu, 12 Mar 2015 14:42:51 +0100
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
MIME-Version: 1.0
To: Brian Gerst <brgerst@gmail.com>
CC: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, rjw@rjwysocki.net,
	al.stone@linaro.org, linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH v4 7/9] x86, pci, ecam: mmconfig_64.c becomes default
 implementation for ECAM driver.
References: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org>	<1426083169-8698-8-git-send-email-tomasz.nowicki@linaro.org> <CAMzpN2gLjuddMYKJY9z=e=oG0P-NjV-mfjtvYRAY6HXCWn5-UQ@mail.gmail.com>
In-Reply-To: <CAMzpN2gLjuddMYKJY9z=e=oG0P-NjV-mfjtvYRAY6HXCWn5-UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11.03.2015 17:30, Brian Gerst wrote:
> On Wed, Mar 11, 2015 at 10:12 AM, Tomasz Nowicki
> <tomasz.nowicki@linaro.org> wrote:
>
>> diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
>> index 5c6fc35..35c765b 100644
>> --- a/arch/x86/pci/Makefile
>> +++ b/arch/x86/pci/Makefile
>> @@ -1,7 +1,10 @@
>>   obj-y                          := i386.o init.o
>>
>>   obj-$(CONFIG_PCI_BIOS)         += pcbios.o
>> -obj-$(CONFIG_PCI_MMCONFIG)     += mmconfig_$(BITS).o direct.o mmconfig-shared.o
>> +obj-$(CONFIG_PCI_MMCONFIG)     += direct.o mmconfig-shared.o
>> +ifeq ($(BITS),32)
>> +obj-$(CONFIG_PCI_MMCONFIG)     += mmconfig_32.o
>> +endif
>>   obj-$(CONFIG_PCI_DIRECT)       += direct.o
>>   obj-$(CONFIG_PCI_OLPC)         += olpc.o
>>   obj-$(CONFIG_PCI_XEN)          += xen.o
>
> This would be better written as:
>
> mmconfig-y := direct.o mmconfig-shared.o
> mmconfig-$(CONFIG_X86_32) += mmconfig_32.o
> obj-$(CONFIG_PCI_MMCONFIG) += $(mmconfig-y)

Nice! Will update my patch.

Tomasz
