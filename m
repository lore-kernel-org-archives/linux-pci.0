Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:47557 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbcLUKx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2016 05:53:28 -0500
Date: Wed, 21 Dec 2016 11:53:36 +0100
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
Message-ID: <20161221105336.GA14971@wunner.de>
References: <cover.1481926599.git.lukas@wunner.de>
 <df0bb7cd6a3e11ec12d3e1a6c1f98351f4aea3ce.1481926599.git.lukas@wunner.de>
 <CAHp75VfzuTaBpZd+Hu2uHbhAPHzHQDdPOwOvb9ejP2j22OWoog@mail.gmail.com>
 <20161220112856.GA14428@wunner.de>
 <CAHp75Vf1ejYPi_Td769-by=_9HrhCVwif5z6-EkTbTswzUds8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75Vf1ejYPi_Td769-by=_9HrhCVwif5z6-EkTbTswzUds8w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 20, 2016 at 03:44:31PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 20, 2016 at 1:28 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Dec 19, 2016 at 01:05:10AM +0200, Andy Shevchenko wrote:
> >> On Sat, Dec 17, 2016 at 4:39 PM, Lukas Wunner <lukas@wunner.de> wrote:
> >> > +#include <linux/delay.h>
> >> > +#include <linux/pci.h>
> >> > +#include <linux/pm_runtime.h>
> >> > +
> >> > +#include "power.h"
> >> > +
> >> > +#ifdef pr_fmt
> >> > +#undef pr_fmt
> >> > +#endif
> >> > +#define pr_fmt(fmt) KBUILD_MODNAME " %s: " fmt, dev_name(dev)
> >>
> >> Perhaps just define pr_fmt before any other include?
> >> We have such check where actually default pr_fmt is defined. No need
> >> to duplicate.
> >
> > If I put the '#define pr_fmt(fmt)' line above all includes, I get:
> >
> >     include/linux/ratelimit.h: In function 'ratelimit_state_exit':
> >     drivers/thunderbolt/power.c:93:49: error: implicit declaration of function 'dev_name'
> >
> > This is caused by 6b1d174b0c27 which was introduced this August.
> >
> > If I try to solve this by including <linux/device.h> before the
> 
> Not before, but rather after?
> 
> printk.h defines default pr_fmt. What you need is to define it before.

If I define pr_fmt and then include <linux/printk.h> I get the error
above because <linux/printk.h> seems to include <linux/ratelimit.h>
via some sub-includes, and this defines the static inline which
expands pr_fmt and fails because dev_name() is not yet defined.


> > So it seems there's no alternative to the '#undef pr_fmt'.
> 
> Imagine how many drivers could suffer of this. So, something is wrong
> either in your code, in headers, or in both. But many drivers for now
> are using cusotm pr_fmt() in a way I described.

There are already 51 files in the tree using the '#undef pr_fmt' idiom,
so this is pretty common:

    # /bin/ls | egrep -v '(\.git|debian)' | xargs egrep -r '#undef pr_fmt' | wc -l
      51

However what I can do is drop the '#ifdef pr_fmt', it's unnecessary,
I think I cargo-culted this from one of these 51 files.


> >> > +       /* prevent interrupts during system sleep transition */
> >> > +       if (ACPI_FAILURE(acpi_disable_gpe(NULL, power->wake_gpe))) {
> >> > +               pr_err("cannot disable wake GPE, resuming\n");
> >>
> >> dev_err?
> >
> > This is intentionally pr_err for cosmetic reasons. :-)
> >
> > With dev_err it would look like this in dmesg:
> >
> >     pcieport 0000:05:00.0: cannot disable wake GPE, resuming
> >
> > With pr_err it looks like this:
> >
> >     thunderbolt 0000:05:00.0: cannot disable wake GPE, resuming
> >
> > Thus, someone grepping for this error message will get a hint that
> > they have to look in drivers/thunderbolt/ rather than drivers/pci/pcie/.
> >
> > The code of this PM callback is located in the thunderbolt driver,
> > which binds to the NHI, 0000:07:00.0.  But the PM callback is
> > assigned to the upstream bridge, which is the grandparent of the NHI,
> > 0000:05:00.0.  The pr_fmt is crafted such that the KBUILD_MODNAME
> > ("thunderbolt") is logged rather than "pcieport".  So I use pr_*
> > in the PM callbacks assigned to the upstream bridge and dev_*
> > in thunderbolt_power_init() / _fini() (which is executed in the
> > context of the NHI).
> 
> I understand rationale, here my question: could pcie bridge driver
> replace name for the port which serves as thunderbolt?

The "pcieport" string is hardcoded in drivers/pci/pcie/portdrv_pci.c
and I'd like to avoid cluttering this file with some quirk which is
specific to this Mac Thunderbolt driver.


> >> > +void thunderbolt_power_fini(struct tb *tb)
> >> > +{
> >> > +       struct device *nhi_dev = &tb->nhi->pdev->dev;
> >> > +       struct device *upstream_dev = nhi_dev->parent->parent;
> >> > +       struct tb_power *power = tb->power;
> >> > +
> >>
> >> > +       if (!power)
> >> > +               return;
> >>
> >> Would be the case?
> >
> > That would be the case if thunderbolt_power_init() failed, then we
> > have to skip removing the GPE handler and all that.  I've now added
> > a comment to explain this.
> 
> And you can't do this outside because outside has no knowledge what is
> tb_power is. Am I right?

thunderbolt_power_fini() is called from the ->remove hook of
thunderbolt.ko.  I could in principle call it conditionally
but I think clarity improves if I perform the check here because
the conditions that might lead to tb->power being NULL are
visible immediately before this function in thunderbolt_power_init().

Thanks,

Lukas
