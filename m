Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33638 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeB0Psh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 10:48:37 -0500
MIME-Version: 1.0
In-Reply-To: <17710852-a221-c707-0438-44031666028e@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com> <66bfcfc6dc1832baa3fbd8e4879764d36aa9c1e7.1516601570.git.jan.kiszka@siemens.com>
 <CAHp75VcssoPE8ZCiHOt8-BKcponpr3xpzn42KZGx=Y+nMmZjYw@mail.gmail.com> <17710852-a221-c707-0438-44031666028e@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 17:48:35 +0200
Message-ID: <CAHp75Vc+DpKPwm7us+1kDYU3e5UMF25MjmqLBfghdih8_FSWtw@mail.gmail.com>
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

On Tue, Feb 27, 2018 at 9:22 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2018-02-23 14:23, Andy Shevchenko wrote:
>> On Mon, Jan 22, 2018 at 8:12 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

>>>  #include <linux/acpi.h>
>>>  #include <linux/irqdomain.h>
>>>  #include <linux/pm_runtime.h>
>>> +#include <linux/hypervisor.h>
>>
>> Ditto.
>>
>
> Despite the context suggesting it, this file has no ordering.

At least you might not increase disordering by putting the line after acpi.h.

-- 
With Best Regards,
Andy Shevchenko
