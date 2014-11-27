Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <37310416.jZXoh5nfSC@vostro.rjw.lan>
References: <37310416.jZXoh5nfSC@vostro.rjw.lan>
Date: Thu, 27 Nov 2014 09:57:33 +0100
Message-ID: <CAPDyKFox8bXyFT0861Tc8YY5HLyq5uPVGkfN0G4fXDKqQynkYQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM: Use CONFIG_PM instead of CONFIG_PM_RUNTIME in
 core code
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Hilman <khilman@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27 November 2014 at 01:37, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Hi,
>
> After commit b2b49ccbdd54 "PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected" (currently in Linux next) CONFIG_PM_RUNTIME is set whenever
> CONFIG_PM is set, so CONFIG_PM can be used in #ifdefs instead of
> CONFIG_PM_RUNTIME which simplifies things in quite a few cases.
>
> For this reason, the following patches modify some core code to use
> CONFIG_PM instead of CONFIG_PM_RUNTIME.
>
> [1/4] Drop a macro which is redundant after the above commit.
> [2/4] Use PM instead of PM_RUNTIME in the core device PM code.
> [3/4] Use PM instead of PM_RUNTIME in the ACPI core.
> [4/4] Use PM instead of PM_RUNTIME in the PCI core.
>
> They build for me for all of the relevant combinations of options (on x86),
> but more testing (on the other architectures) would be welcome.

I really like the looks of this patchset!

Noticed that you have applied it for your bleeding edge branch, I
suppose that means you will get some "free" testing in linux-next?

Anyway, I have tested it for ux500 (including the genpd support for
it, available in linux-next). It works nicely!

I have also tested the two Kconfig options; CONFIG_PM_SLEEP (which
selects CONFIG_PM_RUNTIME) and for CONFIG_PM_RUNTIME (with
CONFIG_PM_SLEEP unset).

That brings me to a raise a question; why do we need to keep these two
configurations options? Couldn't we also have CONFIG_PM_RUNTIME to
select CONFIG_PM_SLEEP, that will further simplify things?

Kind regards
Uffe
