Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2 0/4] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
To: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
References: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <240091906.Gl2z931jjW@wuerfel>
CC: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <hanjun.guo@linaro.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Message-ID: <55DD262C.3010008@amd.com>
Date: Wed, 26 Aug 2015 09:36:28 +0700
MIME-Version: 1.0
In-Reply-To: <240091906.Gl2z931jjW@wuerfel>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 8/26/15 01:48, Arnd Bergmann wrote:
> On Wednesday 26 August 2015 00:33:25 Suravee Suthikulpanit wrote:
>> This patch adds support to setup DMA coherency for PCI device using
>> the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
>> is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
>> support for ARM64 which is currently in development.
>>
>> Also, this should not affect other architectures that does not define
>> CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.
>>
>
> We only support ACPI on SBSA compliant platforms, and SBSA mandates
> cache-coherent PCI, so I don't think this is actually needed,
> just use coherent all the time and do WARN_ON(!CCA) to catch people
> that try to incorrectly use ACPI on a non-SBSA platform.
>
> 	Arnd

Thanks for pointing out. The CONFIG_ACPI_CCA_REQUIRED is already existed 
and selected in arch/arm64/Kconfig, and used for both PCI and non-PCI 
devices. I am not adding anything specific for the PCI case.

Although, I think WARN_ON(!CCA) when it is required is a good idea. I'll 
find a proper place for it.

Thanks,
Suravee.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
