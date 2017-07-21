Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2663063.mdkNhtKpS0@aspire.rjw.lan>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <4010863.7uINOS7bBU@aspire.rjw.lan>
 <CAHp75Vdp8L7FXL85umQGGVyP-J_2dELssw0V8vKLEaCN6doMXg@mail.gmail.com> <2663063.mdkNhtKpS0@aspire.rjw.lan>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 Jul 2017 00:31:14 +0300
Message-ID: <CAHp75VciK=2ZQEwHqxxn-HNnc60nTG-002n35=1PLnL=xeor9w@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI / PM: Split acpi_device_wakeup()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 22, 2017 at 12:16 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, July 22, 2017 12:19:51 AM Andy Shevchenko wrote:
>> On Fri, Jul 21, 2017 at 11:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Friday, July 21, 2017 06:27:39 PM Andy Shevchenko wrote:

>> >> I prefer more self-explaining labels, though it's minor here

...

>> > But if there's more to it, just please let me know. :-)
>>
>> "Choose label names which say what the goto does or why the goto exists.  An
>> example of a good name could be ``out_free_buffer:`` if the goto frees
>> ``buffer``.
>> Avoid using GW-BASIC names like ``err1:`` and ``err2:``, as you would have to
>> renumber them if you ever add or remove exit paths, and they make correctness
>> difficult to verify anyway."
>
> This is a totally made-up argument in this particular case.
>
> Both of the functions in question are 1 screen long and you can *see* what
> happens in there without even scrolling them.
>
> Second, the subsequent patch actually *does* add a label to one of the without
> renamling the existing one or such.
>
> "out" pretty much represents the purpose of the goto in both cases and making
> the label longer doesn't make it any better.

That's why I put "though it's a minor here".

You can read my first message as "you might consider change label
names if you like the idea".

-- 
With Best Regards,
Andy Shevchenko
