Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:37830 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbCJCR3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2015 22:17:29 -0400
Received: by qcxr5 with SMTP id r5so11773328qcx.4
        for <linux-pci@vger.kernel.org>; Mon, 09 Mar 2015 19:17:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54FE4A9D.5010001@samsung.com>
References: <54FD8F94.20305@samsung.com> <CAErSpo6jOJUcvStVk=9=xUBb7E2E-MCRcFqBmV1o0X2pULAW6Q@mail.gmail.com>
 <54FE4A9D.5010001@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Mar 2015 21:17:08 -0500
Message-ID: <CAErSpo4Fx6BGEtBwJB4c=q_QMm+x0Xd3k=Gs9mJV9JnQE6YiuA@mail.gmail.com>
Subject: Re: [RFC] Build with arm64 configuration
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	cpGS <cpgs@samsung.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jingoo, Mohit]

On Mon, Mar 9, 2015 at 8:36 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Bjorn.
>
> Thanks for reply.
>
> On 03/10/2015 08:35 AM, Bjorn Helgaas wrote:
>> On Mon, Mar 9, 2015 at 7:18 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi,
>>>
>>> I have a question for building arm64.
>>> (Actually, i didn't have many knowledges for PCIe.)
>>> When i built with arm64 configuration, then i always found the compiler errors.
>>
>> The kernel does build for arm64, so you'll have to be more specific
>> about the problem you're seeing.
>
> I built the pcie-designware.c and pci-exynos.c.
>
> When pcie-designware.c is built, i found the below error message.
> drivers/pci/host/pcie-designware.c:74:52: warning: ˜struct pci_sys_data™ declared inside parameter list
>  static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
>                                                     ^
> drivers/pci/host/pcie-designware.c:74:52: warning: its scope is only this definition or declaration, which is probably not what you want
> In file included from include/uapi/linux/stddef.h:1:0,
>                  from include/linux/stddef.h:4,
>                  from ./include/uapi/linux/posix_types.h:4,
>                  from include/uapi/linux/types.h:13,
>                  from include/linux/types.h:5,
>                  from include/linux/smp.h:10,
>                  from include/linux/irq.h:12,
>                  from drivers/pci/host/pcie-designware.c:14:
> drivers/pci/host/pcie-designware.c: In function ˜sys_to_pcie":
> drivers/pci/host/pcie-designware.c:76:13: error: dereferencing pointer to incomplete type
>   BUG_ON(!sys->private_data);
>
> I found it's located at arch/arm/include/asm/mach/pci.h.
> It can't refer when do build for arm64.
> So I think that i missed something..I have also searched the patches relevant to this at patchwork.
> Some patch have copied header files relevant to "pci" to "arch/arm64/include/".
> (This is not solution.)
>
> And i don't want to add #ifdef CONFIG_ARM64 into pcie-designware.c
> I think mailing should know the graceful solution.
>
> If i can solve this problem, i will contribute for pci-exynos.c.

Oh, I think pcie-designware.c and pci-exynos.c currently only work on
arm, not on arm64.  I don't know enough about them to know whether
they could be made to work on arm64.  But Jingoo and Mohit probably
do.

Bjorn
