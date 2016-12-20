Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34007 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755263AbcLTNoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2016 08:44:32 -0500
MIME-Version: 1.0
In-Reply-To: <20161220112856.GA14428@wunner.de>
References: <cover.1481926599.git.lukas@wunner.de> <df0bb7cd6a3e11ec12d3e1a6c1f98351f4aea3ce.1481926599.git.lukas@wunner.de>
 <CAHp75VfzuTaBpZd+Hu2uHbhAPHzHQDdPOwOvb9ejP2j22OWoog@mail.gmail.com> <20161220112856.GA14428@wunner.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Dec 2016 15:44:31 +0200
Message-ID: <CAHp75Vf1ejYPi_Td769-by=_9HrhCVwif5z6-EkTbTswzUds8w@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] thunderbolt: Power down controller when idle
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Amir Levy <amir.jer.levy@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 20, 2016 at 1:28 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Mon, Dec 19, 2016 at 01:05:10AM +0200, Andy Shevchenko wrote:
>> On Sat, Dec 17, 2016 at 4:39 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> > Document and implement Apple's ACPI-based (but nonstandard) pm mechanism
>> > for Thunderbolt.  Briefly, an ACPI method provided by Apple is used to
>> > cut power to the controller.  A GPE is enabled while the controller is
>> > powered down which sideband-signals a plug event, whereupon we reinstate
>> > power using the ACPI method.
>> >
>> > This saves 1.7 W on machines with a Light Ridge controller and is
>> > reported to save 4 W on Cactus Ridge 4C and Falcon Ridge 4C.  (I believe
>> > 4 W includes the bus power drawn by Apple's Gigabit Ethernet adapter.)
>> > It fixes (at least partially) a power regression introduced in 3.17 by
>> > commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly").

>> > +++ b/drivers/thunderbolt/power.c
>> > @@ -0,0 +1,347 @@
>>
>> > +#include <linux/delay.h>
>> > +#include <linux/pci.h>
>> > +#include <linux/pm_runtime.h>
>> > +
>> > +#include "power.h"
>> > +
>>
>> > +#ifdef pr_fmt
>> > +#undef pr_fmt
>> > +#endif
>> > +#define pr_fmt(fmt) KBUILD_MODNAME " %s: " fmt, dev_name(dev)
>>
>> Perhaps just define pr_fmt before any other include?
>> We have such check where actually default pr_fmt is defined. No need
>> to duplicate.
>
> If I put the '#define pr_fmt(fmt)' line above all includes, I get:
>
>     include/linux/ratelimit.h: In function 'ratelimit_state_exit':
>     drivers/thunderbolt/power.c:93:49: error: implicit declaration of function 'dev_name'
>
> This is caused by 6b1d174b0c27 which was introduced this August.
>
>
> If I try to solve this by including <linux/device.h> before the

Not before, but rather after?

printk.h defines default pr_fmt. What you need is to define it before.

> '#define pr_fmt(fmt)' line, I get:
>
>     drivers/thunderbolt/power.c:95:0: warning: "pr_fmt" redefined
>      #define pr_fmt(fmt) KBUILD_MODNAME " %s: " fmt, dev_name(dev)
>      ^
>     In file included from /root/kernel/linux/include/linux/kernel.h:13:0,
>                  from /root/kernel/linux/include/linux/list.h:8,
>                  from /root/kernel/linux/include/linux/kobject.h:20,
>                  from /root/kernel/linux/include/linux/device.h:17,
>                  from /root/kernel/linux/drivers/thunderbolt/power.c:93:
>     include/linux/printk.h:260:0: note: this is the location of the previous definition
>      #define pr_fmt(fmt) fmt
>      ^
>
>
> So it seems there's no alternative to the '#undef pr_fmt'.

Imagine how many drivers could suffer of this. So, something is wrong
either in your code, in headers, or in both. But many drivers for now
are using cusotm pr_fmt() in a way I described.

>> > +       /* prevent interrupts during system sleep transition */
>> > +       if (ACPI_FAILURE(acpi_disable_gpe(NULL, power->wake_gpe))) {
>> > +               pr_err("cannot disable wake GPE, resuming\n");
>>
>> dev_err?
>
> This is intentionally pr_err for cosmetic reasons. :-)
>
> With dev_err it would look like this in dmesg:
>
>     pcieport 0000:05:00.0: cannot disable wake GPE, resuming
>
> With pr_err it looks like this:
>
>     thunderbolt 0000:05:00.0: cannot disable wake GPE, resuming
>
> Thus, someone grepping for this error message will get a hint that
> they have to look in drivers/thunderbolt/ rather than drivers/pci/pcie/.
>
> The code of this PM callback is located in the thunderbolt driver,
> which binds to the NHI, 0000:07:00.0.  But the PM callback is
> assigned to the upstream bridge, which is the grandparent of the NHI,
> 0000:05:00.0.  The pr_fmt is crafted such that the KBUILD_MODNAME
> ("thunderbolt") is logged rather than "pcieport".  So I use pr_*
> in the PM callbacks assigned to the upstream bridge and dev_*
> in thunderbolt_power_init() / _fini() (which is executed in the
> context of the NHI).

I understand rationale, here my question: could pcie bridge driver
replace name for the port which serves as thunderbolt?

>> > +void thunderbolt_power_fini(struct tb *tb)
>> > +{
>> > +       struct device *nhi_dev = &tb->nhi->pdev->dev;
>> > +       struct device *upstream_dev = nhi_dev->parent->parent;
>> > +       struct tb_power *power = tb->power;
>> > +
>>
>> > +       if (!power)
>> > +               return;
>>
>> Would be the case?
>
> That would be the case if thunderbolt_power_init() failed, then we
> have to skip removing the GPE handler and all that.  I've now added
> a comment to explain this.

And you can't do this outside because outside has no knowledge what is
tb_power is. Am I right?

-- 
With Best Regards,
Andy Shevchenko
