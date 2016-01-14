Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Mark Salter <msalter@redhat.com>, Tomasz Nowicki <tn@semihalf.com>,
	bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452785393.28109.16.camel@redhat.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5697C0EB.4020404@codeaurora.org>
Date: Thu, 14 Jan 2016 10:38:19 -0500
MIME-Version: 1.0
In-Reply-To: <1452785393.28109.16.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/14/2016 10:29 AM, Mark Salter wrote:
On Wed, 2016-01-13 at 14:20 +0100, Tomasz Nowicki wrote:
> IO resources on Mustang get disabled unless I do:
> 
> @@ -126,9 +126,10 @@ static void acpi_dev_ioresource_flags(struct
> resource *res, u64 len, if (!acpi_dev_resource_len_valid(res->start,
> res->end, len, true)) res->flags |= IORESOURCE_DISABLED |
> IORESOURCE_UNSET;
> 
> +#if 0 if (res->end >= 0x10003) res->flags |= IORESOURCE_DISABLED |
> IORESOURCE_UNSET; - +#endif
> 
> res->end is way beyond 0x10003 on Mustang:
> 
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus
> address [0x10000000-0x1000ffff])
> 
> 

Join the club. I complained about this and I got the message that we just do what Intel does. 
See Arnd Bergmann's reply.

[PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI hostbridge init based on ACPI

1/12/2016 9:30 AM

It is an artificial limit coming from the x86 world introduced into common code.

> -- To unsubscribe from this list: send the line "unsubscribe
> linux-pci" in the body of a message to majordomo@vger.kernel.org More
> majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
