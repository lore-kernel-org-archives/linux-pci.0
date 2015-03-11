Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:19011 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbCKIAN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 04:00:13 -0400
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NL100BMFFKBQO90@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 11 Mar 2015 17:00:11 +0900 (KST)
Message-id: <54FFF60B.4090300@samsung.com>
Date: Wed, 11 Mar 2015 17:00:11 +0900
From: Jaehoon Chung <jh80.chung@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	cpGS <cpgs@samsung.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [RFC] Build with arm64 configuration
References: <54FD8F94.20305@samsung.com>
 <CAErSpo6jOJUcvStVk=9=xUBb7E2E-MCRcFqBmV1o0X2pULAW6Q@mail.gmail.com>
 <54FE4A9D.5010001@samsung.com>
 <CAErSpo4Fx6BGEtBwJB4c=q_QMm+x0Xd3k=Gs9mJV9JnQE6YiuA@mail.gmail.com>
In-reply-to: <CAErSpo4Fx6BGEtBwJB4c=q_QMm+x0Xd3k=Gs9mJV9JnQE6YiuA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear, Bjorn.

On 03/10/2015 11:17 AM, Bjorn Helgaas wrote:
> [+cc Jingoo, Mohit]
> 
> On Mon, Mar 9, 2015 at 8:36 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Dear, Bjorn.
>>
>> Thanks for reply.
>>
>> On 03/10/2015 08:35 AM, Bjorn Helgaas wrote:
>>> On Mon, Mar 9, 2015 at 7:18 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> Hi,
>>>>
>>>> I have a question for building arm64.
>>>> (Actually, i didn't have many knowledges for PCIe.)
>>>> When i built with arm64 configuration, then i always found the compiler errors.
>>>
>>> The kernel does build for arm64, so you'll have to be more specific
>>> about the problem you're seeing.
>>
>> I built the pcie-designware.c and pci-exynos.c.
>>
>> When pcie-designware.c is built, i found the below error message.
>> drivers/pci/host/pcie-designware.c:74:52: warning: Ëstruct pci_sys_dataâ¢ declared inside parameter list
>>  static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
>>                                                     ^
>> drivers/pci/host/pcie-designware.c:74:52: warning: its scope is only this definition or declaration, which is probably not what you want
>> In file included from include/uapi/linux/stddef.h:1:0,
>>                  from include/linux/stddef.h:4,
>>                  from ./include/uapi/linux/posix_types.h:4,
>>                  from include/uapi/linux/types.h:13,
>>                  from include/linux/types.h:5,
>>                  from include/linux/smp.h:10,
>>                  from include/linux/irq.h:12,
>>                  from drivers/pci/host/pcie-designware.c:14:
>> drivers/pci/host/pcie-designware.c: In function Ësys_to_pcie":
>> drivers/pci/host/pcie-designware.c:76:13: error: dereferencing pointer to incomplete type
>>   BUG_ON(!sys->private_data);
>>
>> I found it's located at arch/arm/include/asm/mach/pci.h.
>> It can't refer when do build for arm64.
>> So I think that i missed something..I have also searched the patches relevant to this at patchwork.
>> Some patch have copied header files relevant to "pci" to "arch/arm64/include/".
>> (This is not solution.)
>>
>> And i don't want to add #ifdef CONFIG_ARM64 into pcie-designware.c
>> I think mailing should know the graceful solution.
>>
>> If i can solve this problem, i will contribute for pci-exynos.c.
> 
> Oh, I think pcie-designware.c and pci-exynos.c currently only work on
> arm, not on arm64.  I don't know enough about them to know whether
> they could be made to work on arm64.  But Jingoo and Mohit probably
> do.

I'm checking the code..
If my understanding is right, pci_sys_data is just used to take data relevant to pice_port.
So I think it can get from device-tree or other.
I don't exactly know why needs "pci_sys_data".

It seems to discuss about pcie (struct pci_sys_data and hw_pci) on arm64 at mailing..right?
([RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x))

If need to work, i have interesting for contributing pcie on arm64.(pcie-designware.c and pci-exynos.c)
But i need to gain the knowledge of pcie..

Best Regards,
Jaehoon Chung

> 
> Bjorn
> 

