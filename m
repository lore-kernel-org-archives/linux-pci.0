Return-Path: <SRS0=onno=3A=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=onno=3A=gmail.com=valmikibow@kernel.org>
Subject: Re: Purpose of PCI address in ranges property
To: Arnd Bergmann <arnd@arndb.de>
References: <26e69b06-dde2-2ed5-0288-ee5d58676d7e@gmail.com>
 <CAK8P3a1gAFFjmxY70-YaX+woSJLPUN7Ss-gatgVKgG1uNxWc9A@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>
From: valmiki <valmikibow@gmail.com>
Message-ID: <dc0416ae-d28b-0d9a-cfbd-2bd98abc69d0@gmail.com>
Date: Thu, 23 Mar 2017 08:29:25 +0530
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1gAFFjmxY70-YaX+woSJLPUN7Ss-gatgVKgG1uNxWc9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 3/20/2017 3:15 AM, Arnd Bergmann wrote:
> On Sun, Mar 19, 2017 at 3:14 PM, valmiki <valmikibow@gmail.com> wrote:
>> Hi,
>>
>> When ranges property is being parsed using of_pci_get_host_bridge_resources,
>> the pci address is being used for
>> calculating the offset for pci_add_resource_offset.
>>
>> What is this offset for ?
>>
>> So the cpu address is being used for programming memory base and limit
>> registers ?
>
> Linux IORESOURCE_MEM resources are defined in terms of CPU addresses,
> while PCI config space BAR registers are programmed with bus addresses.
> These are often the same, but on some machines they are not, which results
> in an offset that has to be used when accessing the BARs.
>
Thanks Arnd. So mem base and limit registers of RP are programmed with 
CPU addresses,
and EP BARs are programmed with PCI bus addresses ?
So when will this offset be used, only when RP assigns BAR's to RP ?

Regards,
Valmiki
