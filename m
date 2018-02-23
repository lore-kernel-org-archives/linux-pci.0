Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35159 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeBWNXi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 08:23:38 -0500
MIME-Version: 1.0
In-Reply-To: <66bfcfc6dc1832baa3fbd8e4879764d36aa9c1e7.1516601570.git.jan.kiszka@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com> <66bfcfc6dc1832baa3fbd8e4879764d36aa9c1e7.1516601570.git.jan.kiszka@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 15:23:37 +0200
Message-ID: <CAHp75VcssoPE8ZCiHOt8-BKcponpr3xpzn42KZGx=Y+nMmZjYw@mail.gmail.com>
Subject: Re: [PATCH 2/6] pci: Scan all functions when probing while running
 over Jailhouse
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Benedikt Spranger <b.spranger@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 22, 2018 at 8:12 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

>  #include <linux/export.h>
>  #include <linux/pci.h>
>  #include <asm/pci_x86.h>
> +#include <asm/jailhouse_para.h>

Keep it in order?


>  #include <linux/acpi.h>
>  #include <linux/irqdomain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/hypervisor.h>

Ditto.

-- 
With Best Regards,
Andy Shevchenko
