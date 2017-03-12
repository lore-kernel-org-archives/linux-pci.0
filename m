Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170312122621.GA2823@nazgul.tnic>
References: <20170312053723.GH802@shells.gnugeneration.com>
 <20170312115703.GA18197@nazgul.tnic> <20170312122621.GA2823@nazgul.tnic>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Mar 2017 15:55:08 +0200
Message-ID: <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
Subject: Re: [BUG] 4.11.0-rc1 panic on shutdown X61s
To: Borislav Petkov <bp@alien8.de>
Cc: lkml@pengaru.com, linux-kernel <linux-kernel@vger.kernel.org>,
        vcaputo@pengaru.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 12, 2017 at 2:26 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Sun, Mar 12, 2017 at 12:57:03PM +0100, Borislav Petkov wrote:
>> On Sat, Mar 11, 2017 at 09:37:23PM -0800, lkml@pengaru.com wrote:
>> > Hello list,
>> >
>> > Here's a photo of the panic, on imgur to be kind to vger:
>> > http://imgur.com/a/wZI32
>> >
>> > I'm out on a sailboat so can't really do much, but had a chance with internet
>>
>> So you didn't bring another box with you on the sailboat to connect it to the
>> laptop over netconsole to catch full dmesg, did you?
>
> Hahah, you're so in luck: I just sent this mail and hibernated my laptop
> and got the same BUG. What's the chance of that happening?! Apparently
> big enough.
>
> But I was able to catch the warning before it too. So the question is,
> do you have an e1000e eth controller in that machine too?
>
> Because the symptoms below are consistent with the observed behavior:
> e1000e fails to initialize MSI interrupts for whatever reason and falls
> back to legacy interrupts.
>
> Then, PCI core shuts down and BUGs because the msi_list is empty.
>
> Anyway, lemme add e1000e people too to the fun thread.
>

The only change that IMHO matters happened between v4.10 and v4.11-rc1 is this:

@@ -6276,8 +6274,8 @@ static int e1000e_pm_freeze(struct device *dev)
                /* Quiesce the device without resetting the hardware */
                e1000e_down(adapter, false);
                e1000_free_irq(adapter);
+               e1000e_reset_interrupt_capability(adapter);
        }
-       e1000e_reset_interrupt_capability(adapter);

So, it apparently misses something for the other case, like
pci_disable_msi() call or so.

P.S. I'm not PCI or e1000e guy :-)

-- 
With Best Regards,
Andy Shevchenko
