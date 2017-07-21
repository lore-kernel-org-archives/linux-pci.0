Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60155 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752811AbdGUVdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2017 17:33:39 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] ACPI / PM: Split acpi_device_wakeup()
Date: Fri, 21 Jul 2017 23:25:44 +0200
Message-ID: <2556690.5i2IZsUu2g@aspire.rjw.lan>
In-Reply-To: <CAHp75VciK=2ZQEwHqxxn-HNnc60nTG-002n35=1PLnL=xeor9w@mail.gmail.com>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <2663063.mdkNhtKpS0@aspire.rjw.lan> <CAHp75VciK=2ZQEwHqxxn-HNnc60nTG-002n35=1PLnL=xeor9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, July 22, 2017 12:31:14 AM Andy Shevchenko wrote:
> On Sat, Jul 22, 2017 at 12:16 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Saturday, July 22, 2017 12:19:51 AM Andy Shevchenko wrote:
> >> On Fri, Jul 21, 2017 at 11:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Friday, July 21, 2017 06:27:39 PM Andy Shevchenko wrote:
> 
> >> >> I prefer more self-explaining labels, though it's minor here
> 
> ...
> 
> >> > But if there's more to it, just please let me know. :-)
> >>
> >> "Choose label names which say what the goto does or why the goto exists.  An
> >> example of a good name could be ``out_free_buffer:`` if the goto frees
> >> ``buffer``.
> >> Avoid using GW-BASIC names like ``err1:`` and ``err2:``, as you would have to
> >> renumber them if you ever add or remove exit paths, and they make correctness
> >> difficult to verify anyway."
> >
> > This is a totally made-up argument in this particular case.
> >
> > Both of the functions in question are 1 screen long and you can *see* what
> > happens in there without even scrolling them.
> >
> > Second, the subsequent patch actually *does* add a label to one of the without
> > renamling the existing one or such.
> >
> > "out" pretty much represents the purpose of the goto in both cases and making
> > the label longer doesn't make it any better.
> 
> That's why I put "though it's a minor here".
> 
> You can read my first message as "you might consider change label
> names if you like the idea".

Fair enough.

I clearly don't like it, then. :-)
