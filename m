Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 13 Nov 2017 18:51:11 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, dianders@chromium.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v10 6/7] PCI / PM: Move acpi wakeup code to pci core
Message-ID: <20171114025109.GA43048@google.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <20171027072612.26565-7-jeffy.chen@rock-chips.com>
 <1894178.xtK0vD2N4H@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1894178.xtK0vD2N4H@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

I'll answer some of it from my perspective, though Jeffy might have had
different ideas (and answers) when he implemented this.

On Wed, Nov 08, 2017 at 11:32:20PM +0100, Rafael J. Wysocki wrote:
> On Friday, October 27, 2017 9:26:11 AM CET Jeffy Chen wrote:
> > Move acpi wakeup code to pci core as pci_set_wakeup(), so that other
> > platforms could reuse it.
> 
> What exactly do you want to reuse?
> 
> It looks like that's just several lines of code in acpi_pci_wakeup()
> and acpi_pci_propagate_wakeup() which invoke ACPI-specific lower-level
> functions, so IMO not worth it at all.

The important part he's sharing here is the walking of the tree
structure, in which it's possible for some parent along the way to
handle wakeup for its children. I'm not sure how valuable nor how
reusable that is.

In this case (the Rockchip platforms Jeffy and I are working on), I
think we really want to just support a single WAKE# pin for the whole
system, so maybe the complexity isn't needed. The spec does describe
that there are good reasons for supporting more than 1 WAKE# pin though
(e.g., 1 per device), so it doesn't seem really wise to shoehorn
oursleves into a single setup.

But that can be implemented either via copying the "few" lines of
tree-walking logic, or by trying to share them.

> The structure for other platform code may be the same or similar, but
> the details will almost certainly be different and I don't think that
> having more callback pointers in pci_platform_pm_ops is necessarily better.

I suppose that's reasonable.

> > Also add .setup_dev() / .setup_host_bridge() / .cleanup() platform pm
> > ops's callbacks to setup and cleanup pci devices and host bridge for
> > wakeup.
> 
> Why are they needed?

The implementation is in patch 7, if you really needed more info about
why, or provide alternatives.

The current set of hooks assumes that there is no state information or
initialization needed for tracking actions of these platform PM hooks on
a device. For ACPI this works, because devices have "companion"
acpi_dev's to handle everything, and the ACPI framework generally
prepares GPE's for you, IIUC. For 'pci-mid', the operations happen to be
trivial (and arguably wrong -- several are no-ops, where we might expect
the platform to tell us whether the operation was actually supported or
not).

For device tree, there isn't really a canonical place to store this
information, nor to initialize something like wakeup interrupts.

Technically, we could shoehorn this into the .set_wakeup() call, but
we'd probably rather not do things like request_irq() on every attempt
to suspend/resume the system (among other reasons, we'd lose information
that we might otherwise track in /proc/ or /sys/).

Or the inverse of the above: where would you suggest initializing or
tearing down the wakeirq?

An alternative could be to include any necessary state into the
pci_host_bridge or pci_dev and just inline the setup code into
pci.c/remove.c (e.g., pci_register_host_bridge()) and pci-driver.c
(pci_device_{probe,remove}()). But I'm not sure that's much more
beautiful.

Brian

> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Thanks,
> Rafael
> 
