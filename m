Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:41820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933292AbdCLWXr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 12 Mar 2017 18:23:47 -0400
Date: Sun, 12 Mar 2017 23:23:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: lkml@pengaru.com, linux-kernel <linux-kernel@vger.kernel.org>,
        vcaputo@pengaru.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org, khalidm <khalidm@cisco.com>,
        David Singleton <davsingl@cisco.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [BUG] 4.11.0-rc1 panic on shutdown X61s
Message-ID: <20170312222333.hm54nl2ul5iuixap@pd.tnic>
References: <20170312053723.GH802@shells.gnugeneration.com>
 <20170312115703.GA18197@nazgul.tnic>
 <20170312122621.GA2823@nazgul.tnic>
 <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 12, 2017 at 03:55:08PM +0200, Andy Shevchenko wrote:
> On Sun, Mar 12, 2017 at 2:26 PM, Borislav Petkov <bp@alien8.de> wrote:
> > On Sun, Mar 12, 2017 at 12:57:03PM +0100, Borislav Petkov wrote:
> >> On Sat, Mar 11, 2017 at 09:37:23PM -0800, lkml@pengaru.com wrote:
> >> > Hello list,
> >> >
> >> > Here's a photo of the panic, on imgur to be kind to vger:
> >> > http://imgur.com/a/wZI32
> >> >
> >> > I'm out on a sailboat so can't really do much, but had a chance with internet
> >>
> >> So you didn't bring another box with you on the sailboat to connect it to the
> >> laptop over netconsole to catch full dmesg, did you?
> >
> > Hahah, you're so in luck: I just sent this mail and hibernated my laptop
> > and got the same BUG. What's the chance of that happening?! Apparently
> > big enough.
> >
> > But I was able to catch the warning before it too. So the question is,
> > do you have an e1000e eth controller in that machine too?
> >
> > Because the symptoms below are consistent with the observed behavior:
> > e1000e fails to initialize MSI interrupts for whatever reason and falls
> > back to legacy interrupts.
> >
> > Then, PCI core shuts down and BUGs because the msi_list is empty.
> >
> > Anyway, lemme add e1000e people too to the fun thread.
> >
> 
> The only change that IMHO matters happened between v4.10 and v4.11-rc1 is this:
> 
> @@ -6276,8 +6274,8 @@ static int e1000e_pm_freeze(struct device *dev)
>                 /* Quiesce the device without resetting the hardware */
>                 e1000e_down(adapter, false);
>                 e1000_free_irq(adapter);
> +               e1000e_reset_interrupt_capability(adapter);
>         }
> -       e1000e_reset_interrupt_capability(adapter);
> 
> So, it apparently misses something for the other case, like
> pci_disable_msi() call or so.

Well, lemme add the people from

  7e54d9d063fa ("e1000e: driver trying to free already-free irq")

to CC then. :-)

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
