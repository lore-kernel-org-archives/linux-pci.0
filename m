Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:51641 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab3BVC3Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2013 21:29:24 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so118577pbc.36
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2013 18:29:24 -0800 (PST)
Date: Thu, 21 Feb 2013 18:29:49 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Cole Mickens <cole.mickens@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Hot (un)plugging a Thunderbolt Ethernet adapter causes kernel
 panic
Message-ID: <20130222022949.GA25464@kroah.com>
References: <CAJ9Gbf1o0JHTWRvx=5x51q-wpZctkjFQuufR4fdNja_kV56dqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJ9Gbf1o0JHTWRvx=5x51q-wpZctkjFQuufR4fdNja_kV56dqw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 21, 2013 at 05:45:29PM -0600, Cole Mickens wrote:
> Hello, I was instructed to send this issue to this mailing list:
> https://bugzilla.kernel.org/show_bug.cgi?id=54131
> 
> --
> 
> I have a Macbook Air 2012 running Ubuntu 13.04 with the 3.8.0 kernel
> (not an RC).
> 
> My Thunderbolt Ethernet adapter is usable but only if it is inserted at boot.
> 
> If it is removed after being available, the kernel will panic. Generally it
> takes a minute or two or I have to fire up Chrome or something to stir it.
> 
> I assume the crash isn't written out on a Mac EFI system but I can easily
> reproduce it and retype whatever bits are important. I did take a
> snapshot with my camera: http://i.imgur.com/q2iuHWZ.jpg

This doesn't happen in 3.7.0, right?  Any chance you can run 'git
bisect' to track down the offending patch?

If not, no big deal, I can do it tomorrow as I have one of these boxes
here as well.

thanks,

greg k-h
