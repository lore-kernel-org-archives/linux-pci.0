Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:33049 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754282AbdCMQvn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Mar 2017 12:51:43 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Borislav Petkov <bp@alien8.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, lkml@pengaru.com,
        linux-kernel <linux-kernel@vger.kernel.org>, vcaputo@pengaru.com,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org, khalidm <khalidm@cisco.com>,
        David Singleton <davsingl@cisco.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [BUG] 4.11.0-rc1 panic on shutdown X61s
References: <20170312053723.GH802@shells.gnugeneration.com>
        <20170312115703.GA18197@nazgul.tnic>
        <20170312122621.GA2823@nazgul.tnic>
        <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
        <20170312222333.hm54nl2ul5iuixap@pd.tnic>
Date: Mon, 13 Mar 2017 17:46:06 +0100
In-Reply-To: <20170312222333.hm54nl2ul5iuixap@pd.tnic> (Borislav Petkov's
        message of "Sun, 12 Mar 2017 23:23:33 +0100")
Message-ID: <87shmhjfap.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Borislav Petkov <bp@alien8.de> writes:
> On Sun, Mar 12, 2017 at 03:55:08PM +0200, Andy Shevchenko wrote:
>
>> The only change that IMHO matters happened between v4.10 and v4.11-rc1 i=
s this:
>>=20
>> @@ -6276,8 +6274,8 @@ static int e1000e_pm_freeze(struct device *dev)
>>                 /* Quiesce the device without resetting the hardware */
>>                 e1000e_down(adapter, false);
>>                 e1000_free_irq(adapter);
>> +               e1000e_reset_interrupt_capability(adapter);
>>         }
>> -       e1000e_reset_interrupt_capability(adapter);
>>=20
>> So, it apparently misses something for the other case, like
>> pci_disable_msi() call or so.
>
> Well, lemme add the people from
>
>   7e54d9d063fa ("e1000e: driver trying to free already-free irq")
>
> to CC then. :-)

Already did that a week ago:
https://www.spinics.net/lists/netdev/msg423379.html

Haven't heard anything back yet.  Wondering if they are waiting for
someone else to submit the pretty obvious revert?  Don't understand why
that should take more than a minute to figure out.  It's not like they
are testing these changes anyway...


Bj=C3=B8rn
