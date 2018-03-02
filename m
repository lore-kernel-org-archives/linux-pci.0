Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:42489 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426319AbeCBK2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 05:28:11 -0500
Subject: Re: [PATCH v3 3/6] x86/jailhouse: Enable PCI mmconfig access in
 inmates
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <cover.1519882849.git.jan.kiszka@siemens.com>
 <188edc11aa5fa11d4915097831a2a4a153f6ed83.1519882849.git.jan.kiszka@siemens.com>
 <CAHp75VeH5tBBY4D-1_VVaYiCdRyBG+2vA8ZGg_QBfVujawh=iA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cb20d2c8-761d-1aca-2b3b-07e25a54a803@siemens.com>
Date: Fri, 2 Mar 2018 11:27:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75VeH5tBBY4D-1_VVaYiCdRyBG+2vA8ZGg_QBfVujawh=iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-03-01 11:31, Andy Shevchenko wrote:
> On Thu, Mar 1, 2018 at 7:40 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> Use the PCI mmconfig base address exported by jailhouse in boot
>> parameters in order to access the memory mapped PCI configuration space.
> 
> 
>> --- a/arch/x86/kernel/jailhouse.c
>> +++ b/arch/x86/kernel/jailhouse.c
>> @@ -124,6 +124,13 @@ static int __init jailhouse_pci_arch_init(void)
>>         if (pcibios_last_bus < 0)
>>                 pcibios_last_bus = 0xff;
>>
>> +#ifdef CONFIG_PCI_MMCONFIG
>> +       if (setup_data.pci_mmconfig_base) {
> 
>> +               pci_mmconfig_add(0, 0, 0xff, setup_data.pci_mmconfig_base);
> 
> Hmm... Shouldn't be pcibios_last_bus instead of 0xff?
> 

Indeed.

Thanks,
Jan

>> +               pci_mmcfg_arch_init();
>> +       }
>> +#endif
> 
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
