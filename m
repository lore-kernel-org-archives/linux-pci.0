Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Feb 2018 12:22:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/6] x86: Consolidate PCI_MMCONFIG configs
Message-ID: <20180228182252.GG127842@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1519799691.git.jan.kiszka@siemens.com>
 <76a05abd818c89032161585ba130511a5bd673f0.1519799691.git.jan.kiszka@siemens.com>
 <CAHp75Vf35N1Q0aVjKNwz5UMAVKR-q8PypoDhgr8bCbbiqVeSqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75Vf35N1Q0aVjKNwz5UMAVKR-q8PypoDhgr8bCbbiqVeSqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 05:45:37PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 28, 2018 at 8:34 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > Not sure if those two worked by design or just by chance so far. In any
> > case, it's at least cleaner and clearer to express this in a single
> > config statement.

It would be nice if this were a complete statement of what the patch
does, but without the subject, it's not.  E.g., as I'm composing this
response in an editor window, I can't see the subject, so it seems
incomplete.

> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  arch/x86/Kconfig | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index eb7f43f23521..63e85e7da12e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2641,8 +2641,9 @@ config PCI_DIRECT
> >         depends on PCI && (X86_64 || (PCI_GODIRECT || PCI_GOANY || PCI_GOOLPC || PCI_GOMMCONFIG))
> >
> >  config PCI_MMCONFIG
> > -       def_bool y
> > -       depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
> > +       bool "Support mmconfig PCI config space access" if X86_64
> > +       default y
> > +       depends on PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY || X86_64)
> 
> Looking to the above context I would rather put it like
> 
> depends on PCI && (ACPI || SFI) && (X86_64 || (PCI_GOANY || PCI_GOMMCONFIG))

The changelog doesn't point out any intended functional change, but I
think both these proposals add some new configs that previously could
not occur, e.g.,

  CONFIG_X86_64=y
  CONFIG_SFI=y
  # CONFIG_ACPI is unset
  CONFIG_PCI_MMCONFIG=y

If this is intended, the changelog should mention it.
