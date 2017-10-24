Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 04/12] PM / core: Add SMART_SUSPEND driver flag
Date: Tue, 24 Oct 2017 10:55:14 +0200
Message-ID: <2295745.hKSUUfvB5u@aspire.rjw.lan>
In-Reply-To: <CAPDyKFopE6Pv8fH1U1mhY4io76BbtdNLTJ2b5f-vyfG=rnksvw@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <2481137.OYGUrPQscL@aspire.rjw.lan> <CAPDyKFopE6Pv8fH1U1mhY4io76BbtdNLTJ2b5f-vyfG=rnksvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 24, 2017 7:22:25 AM CEST Ulf Hansson wrote:
> On 16 October 2017 at 03:29, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Define and document a SMART_SUSPEND flag to instruct bus types and PM
> > domains that the system suspend callbacks provided by the driver can
> > cope with runtime-suspended devices, so from the driver's perspective
> > it should be safe to leave devices in runtime suspend during system
> > suspend.
> >
> > Setting that flag also causes the PM core to skip the "late" and
> > "noirq" phases of device suspend for devices that remain in runtime
> > suspend at the beginning of the "late" phase (when runtime PM has
> > been disabled for them) under the assumption that their state cannot
> > (and should not) change after that point until the system suspend
> > transition is complete.  Moreover, the PM core prevents runtime PM
> > from acting on devices with DPM_FLAG_SMART_SUSPEND during system
> > resume by setting their runtime PM status to "active" at the end of
> > the "early" phase (right prior to enabling runtime PM for them).
> > That allows system resume callbacks to do whatever is necessary to
> > resume the device without worrying about runtime PM possibly
> > running in parallel with them.
> 
> After some sleep, I woke up and realized that the hole thing of making
> the PM core skip invoking system sleep callbacks, is not compatible
> with devices being attached to the genpd. Sorry.

That's OK. :-)

It just means I need to move that logic up to the concerned middle layers.

I was going to do that to start with, but then I thought I would do it in
the core to avoid duplicated checks.  I overlooked the genpd case, however.

> The reason is because genpd may not power off the PM domain, even if
> all devices attached to it are runtime suspended. For example, due to
> a subdomain holding it powered or because a PM QoS constraints
> prevents to power off it in runtime. Then to understand whether it
> shall power off/on the PM domain, during system-wide PM it requires
> the system sleep callbacks to be invoked.
> 
> So, even if the driver can cope with the behavior from
> DPM_FLAG_SMART_SUSPEND, then what happens when the PM domain (genpd)
> can not?
> 
> Taking this into account, this feels like solution entirely specific
> to ACPI and PCI. That is fine by me, however then we still have those
> cross SoC drivers, the i2c-designware driver, which may have its
> device attached to an ACPI PM domain or perhaps a genpd.

Yes, that should be fine if the logic above goes to the PCI bus type
and ACPI PM domain.  Then, setting the flag will have no effect on
genpd at all, but that's OK.

Thanks,
Rafael

