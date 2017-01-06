Return-Path: <SRS0=901g=YU=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=901g=YU=gmail.com=valmikibow@kernel.org>
Subject: Re: Need clarity on MSI handling in RC driver
To: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <2fea5a0c-7410-97fd-91d1-ae6a06ab1a52@gmail.com>
 <307e8512-7e14-39a2-c225-6db44e443aea@gmail.com>
 <060e94a4-00a2-bdb7-caf3-72785b333c83@arm.com>
Cc: helgaas@kernel.org, arnd@arndb.de, mark.rutland@arm.com
From: valmiki <valmikibow@gmail.com>
Message-ID: <da4f909c-54ff-530f-93a4-f77642ec9195@gmail.com>
Date: Fri, 6 Jan 2017 08:00:35 +0530
MIME-Version: 1.0
In-Reply-To: <060e94a4-00a2-bdb7-caf3-72785b333c83@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Thanks Marc

On 1/4/2017 11:16 PM, Marc Zyngier wrote:
> On 04/01/17 17:39, valmiki wrote:
>> Hi All,
>>
>> I have a doubt, the MSI domains are handled differently in different RC
>> drivers.
>>
>> Some drivers use irq_domain_add_linear alone, and some use
>> pci_msi_create_irq_domain also to handle MSI.
>>
>> In most of the 32-bit architectures only irq_domain_add_linear is used
>> and in 64 bit drivers both pci_msi_create_irq_domain and
>> irq_domain_add_linear are used.
>>
>> So is this because of architecture difference between ARM and ARM64 ?
>
> Neither. This is purely a software construct. Newer drivers use the
> generic MSI infrastructure (which also allows things like non-PCI MSI),
> while older drivers use some ad-hoc infrastructure which is more or less
> specific to PCI.
>
> The former is the way to go, and the latter is being phased out.
>
> I'll let Mark draw some shiny ASCII art.
>
> Thanks,
>
> 	M.
>
