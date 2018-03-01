Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42515 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935832AbeCAKbJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 05:31:09 -0500
MIME-Version: 1.0
In-Reply-To: <188edc11aa5fa11d4915097831a2a4a153f6ed83.1519882849.git.jan.kiszka@siemens.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com> <188edc11aa5fa11d4915097831a2a4a153f6ed83.1519882849.git.jan.kiszka@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 12:31:08 +0200
Message-ID: <CAHp75VeH5tBBY4D-1_VVaYiCdRyBG+2vA8ZGg_QBfVujawh=iA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] x86/jailhouse: Enable PCI mmconfig access in inmates
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 1, 2018 at 7:40 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Use the PCI mmconfig base address exported by jailhouse in boot
> parameters in order to access the memory mapped PCI configuration space.


> --- a/arch/x86/kernel/jailhouse.c
> +++ b/arch/x86/kernel/jailhouse.c
> @@ -124,6 +124,13 @@ static int __init jailhouse_pci_arch_init(void)
>         if (pcibios_last_bus < 0)
>                 pcibios_last_bus = 0xff;
>
> +#ifdef CONFIG_PCI_MMCONFIG
> +       if (setup_data.pci_mmconfig_base) {

> +               pci_mmconfig_add(0, 0, 0xff, setup_data.pci_mmconfig_base);

Hmm... Shouldn't be pcibios_last_bus instead of 0xff?

> +               pci_mmcfg_arch_init();
> +       }
> +#endif

-- 
With Best Regards,
Andy Shevchenko
