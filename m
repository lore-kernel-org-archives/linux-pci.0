Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38721 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdGUVTw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2017 17:19:52 -0400
MIME-Version: 1.0
In-Reply-To: <4010863.7uINOS7bBU@aspire.rjw.lan>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <3408475.MC8krXn0zk@aspire.rjw.lan>
 <CAHp75VdJqyNBC=iy_FGVsxeskHko=P9=SJqrN8Hq1GtXZEyoRA@mail.gmail.com> <4010863.7uINOS7bBU@aspire.rjw.lan>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 Jul 2017 00:19:51 +0300
Message-ID: <CAHp75Vdp8L7FXL85umQGGVyP-J_2dELssw0V8vKLEaCN6doMXg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI / PM: Split acpi_device_wakeup()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 21, 2017 at 11:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, July 21, 2017 06:27:39 PM Andy Shevchenko wrote:
>> On Fri, Jul 21, 2017 at 3:40 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

>> I prefer more self-explaining labels, though it's minor here
>
> Well, I prefer shorter ones.
>
>> To be constructive:
>> out -> err_unlock
>> out -> out_unlock or err_unlock (depends on context)
>>
>>
>> > +out:
>> > +       mutex_unlock(&acpi_wakeup_lock);
>> > +       return error;
>>
>> > +out:
>> > +       mutex_unlock(&acpi_wakeup_lock);
>>
>>
>
> So while I don't have a particular problem with appending the "_unlock" to the
> "out", I'm not exactly sure why this would be an improvement.
>
> If that's just a matter of personal preference, then I would prefer to follow
> my personal preference here, with all due respect.  [And besides, it follows
> the general style of this file which matters too IMO.]
>
> But if there's more to it, just please let me know. :-)

"Choose label names which say what the goto does or why the goto exists.  An
example of a good name could be ``out_free_buffer:`` if the goto frees
``buffer``.
Avoid using GW-BASIC names like ``err1:`` and ``err2:``, as you would have to
renumber them if you ever add or remove exit paths, and they make correctness
difficult to verify anyway."

-- 
With Best Regards,
Andy Shevchenko
