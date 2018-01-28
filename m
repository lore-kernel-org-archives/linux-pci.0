Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42590 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeA1R0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jan 2018 12:26:45 -0500
MIME-Version: 1.0
In-Reply-To: <5dcaec50bb59140c1cb63c35ce566ccc02188bcb.1516601570.git.jan.kiszka@siemens.com>
References: <cover.1516601570.git.jan.kiszka@siemens.com> <5dcaec50bb59140c1cb63c35ce566ccc02188bcb.1516601570.git.jan.kiszka@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 28 Jan 2018 19:26:44 +0200
Message-ID: <CAHp75Vd3AsdOayA0FSaug6L4K+Xx5pk=Eeh4F5mZQsKiV3RxwA@mail.gmail.com>
Subject: Re: [PATCH 4/6] x86: Consolidate PCI_MMCONFIG configs
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

On Mon, Jan 22, 2018 at 8:12 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Not sure if those two worked by design or just by chance so far. In any
> case, it's at least cleaner and clearer to express this in a single
> config statement.

Congrats! You found by the way a bug in

commit e279b6c1d329e50b766bce96aacc197eae8a053b
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Tue Nov 6 20:41:05 2007 +0100

   x86: start unification of arch/x86/Kconfig.*

...and proper fix seems to split PCI stuff to common + X86_32 only + X86_64 only

-- 
With Best Regards,
Andy Shevchenko
