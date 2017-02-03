Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37876 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752717AbdBCV7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2017 16:59:07 -0500
Date: Fri, 3 Feb 2017 16:59:05 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: v4.10-rc6 boot regression on Intel desktop, does not boot after
 cold boots, boots after reboot
In-Reply-To: <20170203211854.GA3697@amd>
Message-ID: <Pine.LNX.4.44L0.1702031658100.1794-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 3 Feb 2017, Pavel Machek wrote:

> Hi!
> 
> > > > Hmm. I moved keyboard between USB ports, and now 4.10-rc6 no longer
> > > > boots. v4.6 works ok. Let me try with keyboard unplugged... no, I
> > > > could not get it to work. I believe v4.9 and some v4.10-rc's worked,
> > > > but I'll have to double check.
> > > 
> > > But all the kernel versions worked when the keyboard was plugged into
> > > its original USB port?
> > 
> > Aha. So it looks difference is probably in "where is keyboard plugged
> > in" but in "reboot" vs. "cold boot". I did not do a cold boot in quite
> > a while :-(.
> > 
> > Booting to grub, then hitting ctrl-alt-del is enough to make it work. Ouch.
> > 
> > It happens with current Linus' tree.
> 
> v4.10-rc6-feb3 : broken
> v4.9 : ok
> (v4.6 : ok)

All I can suggest is git bisect.  :-(  But I agree that the problem is 
unlikely to be in the USB layer.

Alan Stern
