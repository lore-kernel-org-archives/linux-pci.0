Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59372 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754581AbdGUU5A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2017 16:57:00 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] ACPI / PM: Split acpi_device_wakeup()
Date: Fri, 21 Jul 2017 22:49:06 +0200
Message-ID: <4010863.7uINOS7bBU@aspire.rjw.lan>
In-Reply-To: <CAHp75VdJqyNBC=iy_FGVsxeskHko=P9=SJqrN8Hq1GtXZEyoRA@mail.gmail.com>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <3408475.MC8krXn0zk@aspire.rjw.lan> <CAHp75VdJqyNBC=iy_FGVsxeskHko=P9=SJqrN8Hq1GtXZEyoRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 21, 2017 06:27:39 PM Andy Shevchenko wrote:
> On Fri, Jul 21, 2017 at 3:40 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > To prepare for a subsequent change and make the code somewhat easier
> > to follow, do the following in the ACPI device wakeup handling code:
> >
> >  * Replace wakeup.flags.enabled under struct acpi_device with
> >    wakeup.enable_count as that will be necessary going forward.
> >
> >    For now, wakeup.enable_count is not allowed to grow beyond 1,
> >    so the current behavior is retained.
> >
> >  * Split acpi_device_wakeup() into acpi_device_wakeup_enable()
> >    and acpi_device_wakeup_disable() and modify the callers of
> >    it accordingly.
> >
> >  * Introduce a new acpi_wakeup_lock mutex to protect the wakeup
> >    enabling/disabling code from races in case it is executed
> >    more than once in parallel for the same device (which may
> >    happen for bridges theoretically).
> 
> I prefer more self-explaining labels, though it's minor here

Well, I prefer shorter ones.

> To be constructive:
> out -> err_unlock
> out -> out_unlock or err_unlock (depends on context)
> 
> 
> > +out:
> > +       mutex_unlock(&acpi_wakeup_lock);
> > +       return error;
> 
> > +out:
> > +       mutex_unlock(&acpi_wakeup_lock);
> 
> 

So while I don't have a particular problem with appending the "_unlock" to the
"out", I'm not exactly sure why this would be an improvement.

If that's just a matter of personal preference, then I would prefer to follow
my personal preference here, with all due respect.  [And besides, it follows
the general style of this file which matters too IMO.]

But if there's more to it, just please let me know. :-)

Thanks,
Rafael
