Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>, Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 0/4] PCI PM refinements
Date: Tue, 13 Sep 2016 00:15:01 +0200
Message-ID: <2965902.zGUbeGnQJl@vostro.rjw.lan>
In-Reply-To: <20160912220710.GH23532@localhost>
References: <cover.1472554278.git.lukas@wunner.de> <20160912220710.GH23532@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Monday, September 12, 2016 05:07:10 PM Bjorn Helgaas wrote:
> On Wed, Aug 31, 2016 at 08:15:18AM +0200, Lukas Wunner wrote:
> > The following patches are part of my Thunderbolt Runtime PM series.
> > I'm posting them separately to split the series into digestible chunks.
> > 
> > They benefit everyone, not just Thunderbolt, and Thunderbolt works fine
> > without them (just not with the same degree of perfection).
> > 
> > Patch [1/4] affords direct-complete to devices which are not platform-
> > power-manageable, yet can be suspended to D3cold with a nonstandard
> > mechanism. It does so using a heuristic: If a device's current_state
> > is D3cold and it is not power-manageable, it is assumed that a
> > nonstandard PM mechanism is at work and the device is left asleep.
> > The patch is the outcome of a discussion with Rafael and Alan on
> > linux-pci@ and I would like to thank both for tirelessly responding
> > to my questions.
> > 
> > Patch [3/4] replaces the unconditional resume after direct-complete with
> > a conditional resume by determining if the platform firmware has put the
> > device in reset-power-on or not.
> > 
> > Because the D3cold state cannot be determined from the PMCSR, patch [2/4]
> > adds a hook to query the platform firmware for its opinion on the device's
> > power state.
> > 
> > Finally, patch [4/4] changes the shutdown handling of PCI devices such
> > that they are no longer woken without reason.
> > 
> > The result of these patches should be a speedup and decreased power
> > consumption for system sleep and system shutdown (both for devices that
> > are platform-power-manageable and those that aren't).
> > 
> > If you prefer point & click interfaces, the patches are browsable here:
> > https://github.com/l1k/linux/commits/thunderbolt_runpm_v3
> 
> Rafael, do you have any comment on these?  I don't have any objections
> myself, but I'd like your opinion as the PM expert :)

Please give me some more time (a day or two should be sufficient).

Thanks,
Rafael
