Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:36627 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762236AbcLTL2y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2016 06:28:54 -0500
Date: Tue, 20 Dec 2016 12:28:56 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Amir Levy <amir.jer.levy@intel.com>
Subject: Re: [PATCH v3 6/7] thunderbolt: Power down controller when idle
Message-ID: <20161220112856.GA14428@wunner.de>
References: <cover.1481926599.git.lukas@wunner.de>
 <df0bb7cd6a3e11ec12d3e1a6c1f98351f4aea3ce.1481926599.git.lukas@wunner.de>
 <CAHp75VfzuTaBpZd+Hu2uHbhAPHzHQDdPOwOvb9ejP2j22OWoog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VfzuTaBpZd+Hu2uHbhAPHzHQDdPOwOvb9ejP2j22OWoog@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 19, 2016 at 01:05:10AM +0200, Andy Shevchenko wrote:
> On Sat, Dec 17, 2016 at 4:39 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > Document and implement Apple's ACPI-based (but nonstandard) pm mechanism
> > for Thunderbolt.  Briefly, an ACPI method provided by Apple is used to
> > cut power to the controller.  A GPE is enabled while the controller is
> > powered down which sideband-signals a plug event, whereupon we reinstate
> > power using the ACPI method.
> >
> > This saves 1.7 W on machines with a Light Ridge controller and is
> > reported to save 4 W on Cactus Ridge 4C and Falcon Ridge 4C.  (I believe
> > 4 W includes the bus power drawn by Apple's Gigabit Ethernet adapter.)
> > It fixes (at least partially) a power regression introduced in 3.17 by
> > commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly").
> >
> 
> > +++ b/drivers/thunderbolt/power.c
> > @@ -0,0 +1,347 @@
> 
> > +#include <linux/delay.h>
> > +#include <linux/pci.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#include "power.h"
> > +
> 
> > +#ifdef pr_fmt
> > +#undef pr_fmt
> > +#endif
> > +#define pr_fmt(fmt) KBUILD_MODNAME " %s: " fmt, dev_name(dev)
> 
> Perhaps just define pr_fmt before any other include?
> We have such check where actually default pr_fmt is defined. No need
> to duplicate.

If I put the '#define pr_fmt(fmt)' line above all includes, I get:

    include/linux/ratelimit.h: In function 'ratelimit_state_exit':
    drivers/thunderbolt/power.c:93:49: error: implicit declaration of function 'dev_name'

This is caused by 6b1d174b0c27 which was introduced this August.


If I try to solve this by including <linux/device.h> before the
'#define pr_fmt(fmt)' line, I get:

    drivers/thunderbolt/power.c:95:0: warning: "pr_fmt" redefined
     #define pr_fmt(fmt) KBUILD_MODNAME " %s: " fmt, dev_name(dev)
     ^
    In file included from /root/kernel/linux/include/linux/kernel.h:13:0,
                 from /root/kernel/linux/include/linux/list.h:8,
                 from /root/kernel/linux/include/linux/kobject.h:20,
                 from /root/kernel/linux/include/linux/device.h:17,
                 from /root/kernel/linux/drivers/thunderbolt/power.c:93:
    include/linux/printk.h:260:0: note: this is the location of the previous definition
     #define pr_fmt(fmt) fmt
     ^


So it seems there's no alternative to the '#undef pr_fmt'.


> > +       /* prevent interrupts during system sleep transition */
> > +       if (ACPI_FAILURE(acpi_disable_gpe(NULL, power->wake_gpe))) {
> > +               pr_err("cannot disable wake GPE, resuming\n");
> 
> dev_err?

This is intentionally pr_err for cosmetic reasons. :-)

With dev_err it would look like this in dmesg:

    pcieport 0000:05:00.0: cannot disable wake GPE, resuming

With pr_err it looks like this:

    thunderbolt 0000:05:00.0: cannot disable wake GPE, resuming

Thus, someone grepping for this error message will get a hint that
they have to look in drivers/thunderbolt/ rather than drivers/pci/pcie/.

The code of this PM callback is located in the thunderbolt driver,
which binds to the NHI, 0000:07:00.0.  But the PM callback is
assigned to the upstream bridge, which is the grandparent of the NHI,
0000:05:00.0.  The pr_fmt is crafted such that the KBUILD_MODNAME
("thunderbolt") is logged rather than "pcieport".  So I use pr_*
in the PM callbacks assigned to the upstream bridge and dev_*
in thunderbolt_power_init() / _fini() (which is executed in the
context of the NHI).

This is also much nicer for end users looking at dmesg.  E.g. when
the chip is suspended, it looks like this:

    thunderbolt 0000:07:00.0: suspending...
    thunderbolt 0000:07:00.0: stopping RX ring 0
    thunderbolt 0000:07:00.0: disabling interrupt at register 0x38204 bit 0 (0x1 -> 0x0)
    thunderbolt 0000:07:00.0: stopping TX ring 0
    thunderbolt 0000:07:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
    thunderbolt 0000:07:00.0: control channel stopped
    thunderbolt 0000:07:00.0: suspend finished
    thunderbolt 0000:05:00.0: powering down

It would be confusing for end users if it would say here that
the pcieport is powering down.


> > +       /*
> > +        * On gen 2 controllers, the wake GPE fires as long as the controller
> > +        * is powered up. Poll until it's powered down before enabling the GPE.
> > +        */
> > +       for (i = 0; i < 300; i++) {
> 
> 300 is magic.
[...]
> Why 800? Perhaps comment on this.

We mimic the behaviour of the macOS driver here which polls up to
300 times with a 1 ms delay.  I've now extended the comment above
in my working branch to explain this.


> > +err:
> 
> err_resume: ?

Ok.


> > +err:
> 
> err_free: ?

Ok.


> > +void thunderbolt_power_fini(struct tb *tb)
> > +{
> > +       struct device *nhi_dev = &tb->nhi->pdev->dev;
> > +       struct device *upstream_dev = nhi_dev->parent->parent;
> > +       struct tb_power *power = tb->power;
> > +
> 
> > +       if (!power)
> > +               return;
> 
> Would be the case?

That would be the case if thunderbolt_power_init() failed, then we
have to skip removing the GPE handler and all that.  I've now added
a comment to explain this.

I've also discovered and fixed a bug in thunderbolt_power_init(),
in the "cannot find upstream bridge" error path I have to remove
the GPE handler.

I'll wait a bit if there's further feedback and will post a
rectified version probably next week, after the merge window
has closed.

Thanks!

Lukas
