Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2907778.ZNoNjGGGYl@vostro.rjw.lan>
References: <37310416.jZXoh5nfSC@vostro.rjw.lan>
	<CAPDyKFox8bXyFT0861Tc8YY5HLyq5uPVGkfN0G4fXDKqQynkYQ@mail.gmail.com>
	<2907778.ZNoNjGGGYl@vostro.rjw.lan>
Date: Thu, 27 Nov 2014 18:00:17 +0100
Message-ID: <CAMuHMdVD7+GqgjhXEHYsema5uLPG4A4HANAKyGO2DSTnoskezA@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM: Use CONFIG_PM instead of CONFIG_PM_RUNTIME in
 core code
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On Thu, Nov 27, 2014 at 5:52 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> I have also tested the two Kconfig options; CONFIG_PM_SLEEP (which
>> selects CONFIG_PM_RUNTIME) and for CONFIG_PM_RUNTIME (with
>> CONFIG_PM_SLEEP unset).
>>
>> That brings me to a raise a question; why do we need to keep these two
>> configurations options? Couldn't we also have CONFIG_PM_RUNTIME to
>> select CONFIG_PM_SLEEP, that will further simplify things?
>
> My plan is different.  I'm going to eliminate PM_RUNTIME from the code
> and then replace it with PM as a selectable option.  Then, PM_SLEEP will
> select PM (directly) and PM_RUNTIME can be entirely dropped.

What's your rationale for keeping PM_SLEEP, and not consolidating both
PM_RUNTIME and PM_SLEEP into PM? I.e. what am I missing, still
considering myself a PM newbie?

> So in the end we'll have one Kconfig option less, which is a win IMO.

Having two less may be a bigger win ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
