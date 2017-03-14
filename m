Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:53791 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbdCNIn6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Mar 2017 04:43:58 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: "Brown\, Aaron F" <aaron.f.brown@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "lkml\@pengaru.com" <lkml@pengaru.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "vcaputo\@pengaru.com" <vcaputo@pengaru.com>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "intel-wired-lan\@lists.osuosl.org"
        <intel-wired-lan@lists.osuosl.org>, khalidm <khalidm@cisco.com>,
        "David Singleton" <davsingl@cisco.com>,
        "Kirsher\, Jeffrey T" <jeffrey.t.kirsher@intel.com>
Subject: Re: [BUG] 4.11.0-rc1 panic on shutdown X61s
References: <20170312053723.GH802@shells.gnugeneration.com>
        <20170312115703.GA18197@nazgul.tnic>
        <20170312122621.GA2823@nazgul.tnic>
        <CAHp75Ve7SWivf=TTuq-qA=iM20E==OmSZD2YAmt0LVJQg47Osg@mail.gmail.com>
        <20170312222333.hm54nl2ul5iuixap@pd.tnic>
        <87shmhjfap.fsf@miraculix.mork.no>
        <309B89C4C689E141A5FF6A0C5FB2118B8C5B3F9B@ORSMSX101.amr.corp.intel.com>
        <87varci7om.fsf@miraculix.mork.no>
Date: Tue, 14 Mar 2017 09:40:24 +0100
In-Reply-To: <87varci7om.fsf@miraculix.mork.no> (=?utf-8?Q?=22Bj=C3=B8rn?=
 Mork"'s message of
        "Tue, 14 Mar 2017 09:28:09 +0100")
Message-ID: <87pohki747.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bj=C3=B8rn Mork <bjorn@mork.no> writes:
> "Brown, Aaron F" <aaron.f.brown@intel.com> writes:
>>> From: Bj=C3=B8rn Mork [mailto:bjorn@mork.no]
>>>
>>> Already did that a week ago:
>>> https://www.spinics.net/lists/netdev/msg423379.html
>>>=20
>>> Haven't heard anything back yet.  Wondering if they are waiting for
>>> someone else to submit the pretty obvious revert?  Don't understand why
>>> that should take more than a minute to figure out.  It's not like they
>>> are testing these changes anyway...
>>
>> Believe it or not we actually do test these changes.
>
> Yes, I know you did. Sorry. I should stop throwing such comments around.

So I have made that mistake before, and never learn.  But the good thing
about that is that it now rang a bell.  I once had suspend issues with a
completely different Intel device on another Lenovo laptop, which turned
out to be caused by the Lenovo firmware accessing the device while it is
in D3: https://lkml.org/lkml/2015/3/2/183

I don't have a clue about how these things work so this might be
completely unrelated.  Just thought I'd mention it as an example of how
the Lenovo firmware can do unexpected things.

>From the reports so far, it looks like the issue at hand affects most
(all?)  Lenovo Thinkpads with an e1000e part.  If you haven't tried
already, it might be interesting to see if you can reproduce it on a
Thinkpad.



Bj=C3=B8rn
