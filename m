Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [BUG] 4.11.0-rc1 panic on shutdown X61s
To: "Brown, Aaron F" <aaron.f.brown@intel.com>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        Borislav Petkov <bp@alien8.de>
References: <20170312053723.GH802@shells.gnugeneration.com>
 <20170312115703.GA18197@nazgul.tnic> <20170312122621.GA2823@nazgul.tnic>
 <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
 <20170312222333.hm54nl2ul5iuixap@pd.tnic> <87shmhjfap.fsf@miraculix.mork.no>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
Cc: "vcaputo@pengaru.com" <vcaputo@pengaru.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        David Singleton <davsingl@cisco.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        khalidm <khalidm@cisco.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "lkml@pengaru.com" <lkml@pengaru.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
From: "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <985d8ca4-df0a-5eb7-6c43-d57b843cbd18@intel.com>
Date: Tue, 14 Mar 2017 09:49:24 +0200
MIME-Version: 1.0
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/14/2017 03:20, Brown, Aaron F wrote:
>> From: Bjørn Mork [mailto:bjorn@mork.no]
>> Sent: Monday, March 13, 2017 9:46 AM
>> To: Borislav Petkov <bp@alien8.de>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; lkml@pengaru.com;
>> linux-kernel <linux-kernel@vger.kernel.org>; vcaputo@pengaru.com; linux-
>> pci@vger.kernel.org; intel-wired-lan@lists.osuosl.org; khalidm
>> <khalidm@cisco.com>; David Singleton <davsingl@cisco.com>; Brown, Aaron
>> F <aaron.f.brown@intel.com>; Kirsher, Jeffrey T
>> <jeffrey.t.kirsher@intel.com>
>> Subject: Re: [BUG] 4.11.0-rc1 panic on shutdown X61s
>>
>> Borislav Petkov <bp@alien8.de> writes:
>>> On Sun, Mar 12, 2017 at 03:55:08PM +0200, Andy Shevchenko wrote:
>>>
>>>> The only change that IMHO matters happened between v4.10 and v4.11-
>> rc1 is this:
>>>> @@ -6276,8 +6274,8 @@ static int e1000e_pm_freeze(struct device *dev)
>>>>                  /* Quiesce the device without resetting the hardware */
>>>>                  e1000e_down(adapter, false);
>>>>                  e1000_free_irq(adapter);
>>>> +               e1000e_reset_interrupt_capability(adapter);
>>>>          }
>>>> -       e1000e_reset_interrupt_capability(adapter);
>>>>
>>>> So, it apparently misses something for the other case, like
>>>> pci_disable_msi() call or so.
>>> Well, lemme add the people from
>>>
>>>    7e54d9d063fa ("e1000e: driver trying to free already-free irq")
>>>
>>> to CC then. :-)
>> Already did that a week ago:
>> https://www.spinics.net/lists/netdev/msg423379.html
>>
>> Haven't heard anything back yet.  Wondering if they are waiting for
>> someone else to submit the pretty obvious revert?  Don't understand why
>> that should take more than a minute to figure out.  It's not like they
>> are testing these changes anyway...
> Believe it or not we actually do test these changes.  This one was tested by me and I did not have the same results you and the other people reporting this trace did.  I made it back in the lab today and have spent a good part of the day attempting to reproduce this bug without success.  Freeze / resume works for me on all the systems I have tried, which includes a sampling of all the current parts and many older ones.  Given there are several other reports of this it is obviously an issue and I would like to be able to reproduce it in case another patch to resolve the issue this attempts to fix comes back in another form.  So I want to know what's different between the systems that hit this and my bank of systems that don't.
>
> What exact part (or parts) are we looking at (lspci|grep -i eth) that trigger this?  Could it be a difference in .config files?  The trace says it is falling back to legacy interrupts, does the system continue to work and does the network continue to function in that mode?  In case it's related to user space what is the base distro?  Any other information you think can help me reproduce the issue would be appreciated.
>
> Thanks,
> Aaron
>
>>
>> Bjørn
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Hello,

I suggest revert commit of this patch. We recommended do not apply this 
change.

Thanks,

Sasha
