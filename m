Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:58832 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbdLHQhP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Dec 2017 11:37:15 -0500
Date: Fri, 8 Dec 2017 08:37:10 -0800
From: Tony Lindgren <tony@atomide.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, shawn.lin@rock-chips.com,
        dianders@chromium.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v10 6/7] PCI / PM: Move acpi wakeup code to pci core
Message-ID: <20171208163710.GB24344@atomide.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <1894178.xtK0vD2N4H@aspire.rjw.lan>
 <20171114025109.GA43048@google.com>
 <1882670.s3LR2t44nD@aspire.rjw.lan>
 <20171206193421.GA143886@google.com>
 <20171207001754.GB28152@atomide.com>
 <20171207002955.GA40447@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171207002955.GA40447@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Brian Norris <briannorris@chromium.org> [171207 00:32]:
> On Wed, Dec 06, 2017 at 04:17:54PM -0800, Tony Lindgren wrote:
> > * Brian Norris <briannorris@chromium.org> [171206 19:36]:
> > > By the way, it seems pretty ambiguous how we want to handle things like
> > > (a) multiple devices sharing the same WAKE#
> > > (b) systems where a slot is swappable
> > > 
> > > For (a), the main problem is that if we have to repeat the interrupt
> > > definition in multiple devices, then we have to deal with something like
> > > IRQF_SHARED. That can be done, but it makes it much harder to use the
> > > dedicated wakeirq helpers.
> > 
> > This will get messy, let's not go there :) That is unless the hardware
> > really has a single interrupt wired to multiple devices. And in that
> > case almost certainly a custom interrupt handler is needed.
> 
> As Rafael mentioned, the spec doesn't clearly delineate a required
> hierarchy to the WAKE# pin, and it's certainly possible to share it. I'm
> fine dodging that question for now, and only writing said custom
> interrupt handler if/when needed.

OK if the WAKE# pin is shared then PCI (or hardware specific?) code needs
to figure out from where it came from.

> But device tree bindings are "forever", so it seems reasonable to at
> least agree how it should be defined.

Well that's why we're just using the existing interrupts-extended
binding there :) It does not leave out the option for shared interrupts,
it's just that drivers/base/power/wakeirq.c can't deal with them in a
sane way or at least we'd have to add a flag to not enable/disable the
wakeirq automatically.

Regards,

Tony
