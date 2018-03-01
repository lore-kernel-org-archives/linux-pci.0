Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8527c92b2e2920b8cd9096ddcbbb6d0f4004eb69.1519882849.git.jan.kiszka@siemens.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com> <8527c92b2e2920b8cd9096ddcbbb6d0f4004eb69.1519882849.git.jan.kiszka@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 12:31:58 +0200
Message-ID: <CAHp75VeaE_fm53Ga+zMNsvC2Ew6E5D0hbruV5jDwPeGvZk8v2g@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] x86: Consolidate PCI_MMCONFIG configs
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 1, 2018 at 7:40 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Since e279b6c1d329 ("x86: start unification of arch/x86/Kconfig.*"), we
> have two PCI_MMCONFIG entries, one from the original i386 and another
> from x86_64. This consolidates both entries into a single one.
>
> The logic for x86_32, where this option was not under user control,
> remains identical. On x86_64, PCI_MMCONFIG becomes additionally
> configurable for SFI systems even if ACPI was disabled. This just
> simplifies the logic without restricting the configurability in any way.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/Kconfig | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eb7f43f23521..aef9d67ac186 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2641,8 +2641,9 @@ config PCI_DIRECT
>         depends on PCI && (X86_64 || (PCI_GODIRECT || PCI_GOANY || PCI_GOOLPC || PCI_GOMMCONFIG))
>
>  config PCI_MMCONFIG
> -       def_bool y
> -       depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
> +       bool "Support mmconfig PCI config space access" if X86_64
> +       default y
> +       depends on PCI && (ACPI || SFI) && (X86_64 || (PCI_GOANY || PCI_GOMMCONFIG))
>
>  config PCI_OLPC
>         def_bool y
> @@ -2657,10 +2658,6 @@ config PCI_DOMAINS
>         def_bool y
>         depends on PCI
>
> -config PCI_MMCONFIG
> -       bool "Support mmconfig PCI config space access"
> -       depends on X86_64 && PCI && ACPI
> -
>  config PCI_CNB20LE_QUIRK
>         bool "Read CNB20LE Host Bridge Windows" if EXPERT
>         depends on PCI
> --
> 2.13.6
>



-- 
With Best Regards,
Andy Shevchenko
