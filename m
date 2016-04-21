Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34179 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbcDUKJK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2016 06:09:10 -0400
Received: by mail-lb0-f171.google.com with SMTP id b1so21323805lbi.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2016 03:09:09 -0700 (PDT)
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
To: Arnd Bergmann <arnd@arndb.de>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <3830999.dF71UWYsBP@wuerfel> <57189D2F.9070802@semihalf.com>
 <8950494.UV8UrWiFbx@wuerfel>
Cc: Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	Jon Masters <jcm@redhat.com>, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, Wangyijing <wangyijing@huawei.com>,
	Marcin Wojtas <mw@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5718A6AE.4080203@semihalf.com>
Date: Thu, 21 Apr 2016 12:08:46 +0200
MIME-Version: 1.0
In-Reply-To: <8950494.UV8UrWiFbx@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21.04.2016 11:36, Arnd Bergmann wrote:
> On Thursday 21 April 2016 11:28:15 Tomasz Nowicki wrote:
>> On 19.04.2016 15:06, Arnd Bergmann wrote:
>>> On Monday 18 April 2016 21:31:54 Tomasz Nowicki wrote:
>>>>
>>>> Basically the whole content of pci-thunder-ecam.c and pci-thunder-pem.c.
>>>>
>>>> pci-thunder-ecam.c contains config space accessors. Similar for
>>>> pci-thunder-pem.c but it also has extra init call (it is now called
>>>> thunder_pem_init) which finds and maps related registers.
>>>
>>> They seem to do much more than just override the accessors, they actually
>>> change the contents of the config space as well. Is that really necessary
>>> on ACPI based systems as well?
>>
>> Yes, the pci-thunder-ecam.c accessors are meant to emulate config space
>> capabilities. They are necessary to synthesize EA capabilities (fixed
>> PCI BARs), it wont work without this, for ACPI boot as well.
>
> Why is that? I thought the BARs never get reassigned when using ACPI,
> so I'm surprised it's actually needed. Maybe I misunderstood what
> you mean by fixed PCI BARs.

Yes, I meant something else. ThunderX has non-programmable PCI BAR 
addresses. So it uses PCI EA (Extended allocation) capabilities to get 
know PCI BARs addresses. But the early implementation (pass1.x) misses 
EA capabilities hence we need to emulate it in config space accessors.

Tomasz
