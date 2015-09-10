Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V3 0/4] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <55F02331.2060001@amd.com> <8172790.rR5Ld4j83C@vostro.rjw.lan>
CC: <bhelgaas@google.com>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<hanjun.guo@linaro.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <55F0EF79.3090202@amd.com>
Date: Thu, 10 Sep 2015 09:48:25 +0700
MIME-Version: 1.0
In-Reply-To: <8172790.rR5Ld4j83C@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On 9/10/2015 3:38 AM, Rafael J. Wysocki wrote:
> On Wednesday, September 09, 2015 07:16:49 PM Suthikulpanit, Suravee wrote:
>> >Hi All,
>> >
>> >Are there any other concerns about this patch series?
> I have none, but then it sort of missed the merge window.
>
> I can easily queue it up for the next one unless it is super-urgent,
> but in that case I need to know why that's the case.
>

This is not urgent. This mainly needed to enable the ACPI PCI supports 
for ARM64 which is still work in progress.

Thanks,
Suravee
