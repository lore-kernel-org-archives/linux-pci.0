Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] ACPI / PM: Split acpi_device_wakeup()
Date: Fri, 21 Jul 2017 23:16:27 +0200
Message-ID: <2663063.mdkNhtKpS0@aspire.rjw.lan>
In-Reply-To: <CAHp75Vdp8L7FXL85umQGGVyP-J_2dELssw0V8vKLEaCN6doMXg@mail.gmail.com>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <4010863.7uINOS7bBU@aspire.rjw.lan> <CAHp75Vdp8L7FXL85umQGGVyP-J_2dELssw0V8vKLEaCN6doMXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, July 22, 2017 12:19:51 AM Andy Shevchenko wrote:
> On Fri, Jul 21, 2017 at 11:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, July 21, 2017 06:27:39 PM Andy Shevchenko wrote:
> >> On Fri, Jul 21, 2017 at 3:40 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> >> I prefer more self-explaining labels, though it's minor here
> >
> > Well, I prefer shorter ones.
> >
> >> To be constructive:
> >> out -> err_unlock
> >> out -> out_unlock or err_unlock (depends on context)
> >>
> >>
> >> > +out:
> >> > +       mutex_unlock(&acpi_wakeup_lock);
> >> > +       return error;
> >>
> >> > +out:
> >> > +       mutex_unlock(&acpi_wakeup_lock);
> >>
> >>
> >
> > So while I don't have a particular problem with appending the "_unlock" to the
> > "out", I'm not exactly sure why this would be an improvement.
> >
> > If that's just a matter of personal preference, then I would prefer to follow
> > my personal preference here, with all due respect.  [And besides, it follows
> > the general style of this file which matters too IMO.]
> >
> > But if there's more to it, just please let me know. :-)
> 
> "Choose label names which say what the goto does or why the goto exists.  An
> example of a good name could be ``out_free_buffer:`` if the goto frees
> ``buffer``.
> Avoid using GW-BASIC names like ``err1:`` and ``err2:``, as you would have to
> renumber them if you ever add or remove exit paths, and they make correctness
> difficult to verify anyway."

This is a totally made-up argument in this particular case.

Both of the functions in question are 1 screen long and you can *see* what
happens in there without even scrolling them.

Second, the subsequent patch actually *does* add a label to one of the without
renamling the existing one or such.

"out" pretty much represents the purpose of the goto in both cases and making
the label longer doesn't make it any better.

Thanks,
Rafael
