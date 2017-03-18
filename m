Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36564 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdCROp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Mar 2017 10:45:58 -0400
Date: Sat, 18 Mar 2017 15:42:15 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170318144211.GA1014@lerouge>
References: <20170203190414.GA3701@amd>
 <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
 <20170203205129.GA3791@amd>
 <20170203211854.GA3697@amd>
 <20170214175956.GA3587@amd>
 <20170214192743.GA3869@amd>
 <20170223162825.GA16646@lerouge>
 <20170223184013.GA5177@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170223184013.GA5177@amd>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 23, 2017 at 07:40:13PM +0100, Pavel Machek wrote:
> On Thu 2017-02-23 17:28:26, Frederic Weisbecker wrote:
> > On Tue, Feb 14, 2017 at 08:27:43PM +0100, Pavel Machek wrote:
> > > On Tue 2017-02-14 18:59:56, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > > > > > Hmm. I moved keyboard between USB ports, and now 4.10-rc6 no longer
> > > > > > > > boots. v4.6 works ok. Let me try with keyboard unplugged... no, I
> > > > > > > > could not get it to work. I believe v4.9 and some v4.10-rc's worked,
> > > > > > > > but I'll have to double check.
> > > > > > > 
> > > > > > > But all the kernel versions worked when the keyboard was plugged into
> > > > > > > its original USB port?
> > > > > > 
> > > > > > Aha. So it looks difference is probably in "where is keyboard plugged
> > > > > > in" but in "reboot" vs. "cold boot". I did not do a cold boot in quite
> > > > > > a while :-(.
> > > > > > 
> > > > > > Booting to grub, then hitting ctrl-alt-del is enough to make it work. Ouch.
> > > > > > 
> > > > > > It happens with current Linus' tree.
> > > > > 
> > > > > v4.10-rc6-feb3 : broken
> > > > > v4.9 : ok
> > > > > (v4.6 : ok)
> > > > 
> > > > Hmm. It hangs during PCI fixups, and it hangs in v4.10-rc8, too.   
> > > > 
> > > > With debug patch below, I get
> > > > 
> > > > ...1d.7: PCI fixup... pass 2
> > > > ...1d.7: PCI fixup... pass 3
> > > > ...1d.7: PCI fixup... pass 3 done
> > > > 
> > > > ...followed by hang. So yes, it looks USB related.
> > > > 
> > > > (Sometimes it hangs with some kind backtrace involving secondary CPU
> > > > startup, unfortunately useful info is off screen at that point).
> > > 
> > > Forgot to say, 1d.7 is EHCI controller.
> > > 
> > > 00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI
> > > Controller (rev 01)
> > 
> > Ok, I should have access soon to a EeePc 1015CX (which seem to have this controller).
> > I hope I'll be able to reproduce the issue there. If not, I'm sorry but I'll have to
> > burden you again :-)
> 
> Go through more mails. It is only reproducible after cold boot. .. so
> I doubt it will be easy to reproduce on another machine.
> 
> Now... I do have serial port, and I even might have serial cable
> somewhere, but.... Giving how sensitive it is, it is probably going to
> go away with console on ttyS...

So I had access to a machine with NM10/ICH7 chipset and I failed to reproduce.
What machine is it you're using?

I fear you're my last resort. I suspect something is programming the clockevent
behind the tick. I thought it could be the clockevents switch code but I can't find
any issue there.

I see you have CONFIG_HIGH_RES_TIMERS=n. Could you try with it enabled?

For a quick rewind:

    git reset --hard v4.10
    git revert 558e8e27e73f53f8a512485be538b07115fe5f3c

Thanks!
