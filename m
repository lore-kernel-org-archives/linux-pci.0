Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Sinan Kaya <okaya@codeaurora.org>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <563131B0.9060305@codeaurora.org>
Cc: jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <56320538.6000905@semihalf.com>
Date: Thu, 29 Oct 2015 12:38:32 +0100
MIME-Version: 1.0
In-Reply-To: <563131B0.9060305@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 28.10.2015 21:36, Sinan Kaya wrote:
> 1. ACPI code is unable to discover the interrupt numbers when objects
> are ordered as follows in the ACPI file
>
> PNP0A08 object
> PNP0C0F INTA object
> PNP0C0F INTB object
> PNP0C0F INTC object
> PNP0C0F INTD object
>
> This gives me invalid link context error.
>
> pci 0000:00:00.0: PCI INT A: no GSI
> pci 0000:01:00.0: Derived GSI for 0000:01:00.0 INT A from 0000:00:00.0
> acpi PNP0C0F:00: Invalid link context
>
> If I order it like this in the ACPI file,
>
> PNP0C0F INTA object
> PNP0C0F INTB object
> PNP0C0F INTC object
> PNP0C0F INTD object
> PNP0A08 object
>
> then, the legacy interrupt numbers can be discovered properly.

Can you show full content of your PNP0C0F and PNP0A08 objects?

Regards,
Tomasz
