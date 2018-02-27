Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 4/6] x86: Consolidate PCI_MMCONFIG configs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <cover.1516601570.git.jan.kiszka@siemens.com>
 <5dcaec50bb59140c1cb63c35ce566ccc02188bcb.1516601570.git.jan.kiszka@siemens.com>
 <CAHp75Vd3AsdOayA0FSaug6L4K+Xx5pk=Eeh4F5mZQsKiV3RxwA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <45f0d934-c4cf-fdc7-d7ca-17373c01e733@siemens.com>
Date: Tue, 27 Feb 2018 08:19:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd3AsdOayA0FSaug6L4K+Xx5pk=Eeh4F5mZQsKiV3RxwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-28 18:26, Andy Shevchenko wrote:
> On Mon, Jan 22, 2018 at 8:12 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Not sure if those two worked by design or just by chance so far. In any
>> case, it's at least cleaner and clearer to express this in a single
>> config statement.
> 
> Congrats! You found by the way a bug in
> 
> commit e279b6c1d329e50b766bce96aacc197eae8a053b
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Tue Nov 6 20:41:05 2007 +0100
> 
>    x86: start unification of arch/x86/Kconfig.*
> 
> ...and proper fix seems to split PCI stuff to common + X86_32 only + X86_64 only
> 

Hmm, is that a change request on this patch?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
