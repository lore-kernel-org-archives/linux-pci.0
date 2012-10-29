Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:36086 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757633Ab2J2ILp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 04:11:45 -0400
Message-ID: <508E3A2E.3000204@st.com>
Date: Mon, 29 Oct 2012 13:41:26 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: viresh kumar <viresh.kumar@linaro.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>
Subject: Re: [PATCH 03/15] SPEAr13xx: Add mach/io.h
References: <cover.1351492562.git.pratyush.anand@st.com> <cce9cba6020c30f0edb15e43fa51208524b59322.1351492562.git.pratyush.anand@st.com> <CAOh2x==1McRP4eNFZa8qH4hjnOr003Ozb6J3XP8B87E9yZB4zw@mail.gmail.com>
In-Reply-To: <CAOh2x==1McRP4eNFZa8qH4hjnOr003Ozb6J3XP8B87E9yZB4zw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/29/2012 12:59 PM, viresh kumar wrote:
> On Mon, Oct 29, 2012 at 12:31 PM, Pratyush Anand <pratyush.anand@st.com> wrote:
>> In case of PCIe we need to have a different __io macro, which can write
>> into PCIe address space.
>
> You may find this interesting:
>
> Do, git log --stat -p dd9bf78040fa0da4cecc228e1682b9682b8cb180
>
> There is a series of commits like:
>
> commit dd9bf78040fa0da4cecc228e1682b9682b8cb180
> Author: Rob Herring <rob.herring@calxeda.com>
> Date:   Wed Jul 4 11:18:40 2012 -0500
>
>      ARM: iop3xx: use fixed PCI i/o mapping
>
>      Move iop33x and iop32x PCI to fixed i/o mapping and remove io.h. This
>      changes the PCI bus addresses from the cpu address to 0 based. It appears
>      that there is translation h/w for this, but its untested.

In case of SPEAr we can not translate a CPU address 0 to PCIe space. To 
explain it better, lets say we allocate 0x0000 - 0xFFFF for PCIe IO 
transaction. Now if CPU writes on these addressed, there is no way we 
can route those transactions to PCIe bus.

Any transaction between 0x80000000 to 0x8FFFFFFF can only be used for 
any type(IO/MEM/CFG0/CFG1) of PCIe transaction. Therefore , we need to 
have this mapping in io.h.

Regards
Pratyush

>
>      Not sure what to do with io_offset. I think it should always be 0.
>      AFAICT, PCI setup is skipped if the ATU is already setup.
>
>      Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>      Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> All mach/io.h are removed and you are adding one of those. :)
>
>>
>> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
>> ---
>>   arch/arm/mach-spear13xx/include/mach/io.h |   35 +++++++++++++++++++++++++++++
>>   1 files changed, 35 insertions(+), 0 deletions(-)
>>   create mode 100644 arch/arm/mach-spear13xx/include/mach/io.h
>>
>> diff --git a/arch/arm/mach-spear13xx/include/mach/io.h b/arch/arm/mach-spear13xx/include/mach/io.h
>> new file mode 100644
>> index 0000000..a0d93ca
>> --- /dev/null
>> +++ b/arch/arm/mach-spear13xx/include/mach/io.h
>> @@ -0,0 +1,35 @@
>> +/*
>> + * arch/arm/mach-spear13xx/include/mach/io.h
>> + *
>> + * spear13xx machine family generic header file
>
> SPEAr
>
>> + *
>> + * Copyright (C) 2012 ST Microelectronics
>> + * Pratyush Anand <pratyush.anand@st.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#ifndef __MACH_IO_H
>> +#define __MACH_IO_H
>> +
>> +#define IO_SPACE_LIMIT 0xFFFF
>> +
>> +#ifdef CONFIG_SPEAR13XX_PCI
>> +extern void __iomem *spear13xx_pcie_io_base(unsigned long addr);
>> +
>> +static inline void __iomem *__io(unsigned long addr)
>> +{
>> +       return spear13xx_pcie_io_base(addr) + (addr & IO_SPACE_LIMIT);
>> +}
>> +#else
>> +static inline void __iomem *__io(unsigned long addr)
>> +{
>> +       return (void __iomem *)addr;
>> +}
>> +#endif
>> +
>> +#define __io(a)                __io(a)
>> +
>> +#endif /* __MACH_IO_H */
>> --
>> 1.7.5.4
>>
> .
>


