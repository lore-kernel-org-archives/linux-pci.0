Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33301 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964934AbdDTOwK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2017 10:52:10 -0400
Date: Thu, 20 Apr 2017 16:52:06 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170420145205.GD25160@lerouge>
References: <20170203205129.GA3791@amd>
 <20170203211854.GA3697@amd>
 <20170214175956.GA3587@amd>
 <20170214192743.GA3869@amd>
 <20170223162825.GA16646@lerouge>
 <20170223184013.GA5177@amd>
 <20170403153850.GA4418@lerouge>
 <20170403182050.GA6555@amd>
 <20170412150832.GE21309@lerouge>
 <20170415213447.GA9506@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170415213447.GA9506@amd>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 15, 2017 at 11:34:47PM +0200, Pavel Machek wrote:
> On Wed 2017-04-12 17:08:35, Frederic Weisbecker wrote:
> > On Mon, Apr 03, 2017 at 08:20:50PM +0200, Pavel Machek wrote:
> > > > > > > > ...1d.7: PCI fixup... pass 2
> > > > > > > > ...1d.7: PCI fixup... pass 3
> > > > > > > > ...1d.7: PCI fixup... pass 3 done
> > > > > > > > 
> > > > > > > > ...followed by hang. So yes, it looks USB related.
> > > > > > > > 
> > > > > > > > (Sometimes it hangs with some kind backtrace involving secondary CPU
> > > > > > > > startup, unfortunately useful info is off screen at that point).
> > > > > > > 
> > > > > > > Forgot to say, 1d.7 is EHCI controller.
> > > > > > > 
> > > > > > > 00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI
> > > > > > > Controller (rev 01)
> > > > > > 
> > > > > > Ok, I should have access soon to a EeePc 1015CX (which seem to have this controller).
> > > > > > I hope I'll be able to reproduce the issue there. If not, I'm sorry but I'll have to
> > > > > > burden you again :-)
> > > > > 
> > > > > Go through more mails. It is only reproducible after cold boot. .. so
> > > > > I doubt it will be easy to reproduce on another machine.
> > > > > 
> > > > > Now... I do have serial port, and I even might have serial cable
> > > > > somewhere, but.... Giving how sensitive it is, it is probably going to
> > > > > go away with console on ttyS...
> > > > 
> > > > I also tried on an eeepc (which has ICH7/NM10 as well), with your config.
> > > > I even plugged a usb keyboard but even then I have been unable to
> > > > reproduce either :-(
> > > 
> > > Ok, give me some time. I'm no longer using the affected machine, so no
> > > promises.
> > 
> > Actually someone reported me a very similar issue than yours lately. It's probably
> > the same. And I have a potential fix.
> 
> Got the machine back to work -- I guess it will be useful for distcc.
> 
> And yes, you seem to have right fix :-). 
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks a lot! I'm posting the fix.
