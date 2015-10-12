Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0095.outbound.protection.outlook.com ([65.55.169.95]:48160
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752331AbbJLTvp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 12 Oct 2015 15:51:45 -0400
Subject: Re: [PATCH V3 0/4] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <55F02331.2060001@amd.com> <8172790.rR5Ld4j83C@vostro.rjw.lan>
 <55F0EF79.3090202@amd.com>
CC: <bhelgaas@google.com>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<hanjun.guo@linaro.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Message-ID: <561C0F45.8090107@amd.com>
Date: Mon, 12 Oct 2015 14:51:33 -0500
MIME-Version: 1.0
In-Reply-To: <55F0EF79.3090202@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On 9/9/15 21:48, Suthikulpanit, Suravee wrote:
> Hi Rafael,
>
> On 9/10/2015 3:38 AM, Rafael J. Wysocki wrote:
>> On Wednesday, September 09, 2015 07:16:49 PM Suthikulpanit, Suravee
>> wrote:
>>> >Hi All,
>>> >
>>> >Are there any other concerns about this patch series?
>> I have none, but then it sort of missed the merge window.
>>
>> I can easily queue it up for the next one unless it is super-urgent,
>> but in that case I need to know why that's the case.
>>
>
> This is not urgent. This mainly needed to enable the ACPI PCI supports
> for ARM64 which is still work in progress.
>
> Thanks,
> Suravee
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Just wondering if you are planning to queue this series up for 4.4 as well?

Thank you,
Suravee
