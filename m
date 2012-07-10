Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:35452 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159Ab2GJQRd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 12:17:33 -0400
Received: by gglu4 with SMTP id u4so170107ggl.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 09:17:33 -0700 (PDT)
Date: Tue, 10 Jul 2012 09:17:27 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	AceLan Kao <acelan.kao@canonical.com>,
	=?iso-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>,
	Javier Marcet <jmarcet@gmail.com>,
	Andrey Rahmatullin <wrar@wrar.name>,
	Oleksij Rempel <bug-track@fisher-privat.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] PCI: EHCI: fix crash during suspend on ASUS computers
Message-ID: <20120710161727.GA18361@kroah.com>
References: <20120710160042.GA17949@kroah.com>
 <Pine.LNX.4.44L0.1207101209150.1308-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1207101209150.1308-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 12:11:41PM -0400, Alan Stern wrote:
> On Tue, 10 Jul 2012, Greg KH wrote:
> 
> > > I'm fine with this patch.  I was going to add these:
> > > 
> > >     Based-on-patch-by: AceLan Kao <acelan.kao@canonical.com>
> > >     Reference: https://bugzilla.kernel.org/show_bug.cgi?id=37632
> > >     Reference: https://bugzilla.kernel.org/show_bug.cgi?id=42728
> > > 
> > > I don't have the previous iteration (c2fb8a3fa25513d) in my "next"
> 
> The commit is already in 3.5-rc6.  And I intended this fix to get into 
> 3.5-final, not into Linux-next (I should have said so explicitly in the 
> patch).

Ah, ok, if so, and Bjorn doesn't mind, I can add it to the other USB
patches that I have queued up to go in before 3.5-final is released.

Bjorn, want me to take it?  If so, can I get your ack?

thanks,

greg k-h
