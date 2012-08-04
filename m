Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42068 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211Ab2HDTlq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 4 Aug 2012 15:41:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Sat, 4 Aug 2012 21:47:25 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <201208022326.31178.rjw@sisk.pl> <Pine.LNX.4.44L0.1208022151450.22991-100000@netrider.rowland.org> <CACVXFVOdwNiSkF1_Bs-FY-PT4gqZ86j6pcr4A=Yckc0bxykgRQ@mail.gmail.com>
In-Reply-To: <CACVXFVOdwNiSkF1_Bs-FY-PT4gqZ86j6pcr4A=Yckc0bxykgRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208042147.25845.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, August 03, 2012, Ming Lei wrote:
> On Fri, Aug 3, 2012 at 10:20 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, 2 Aug 2012, Rafael J. Wysocki wrote:
> 
> > Hmmm.  You'd probably want a version that does a "get" at the same
> > time.  I suppose you would call func directly if the device was already
> > resumed, without going through the workqueue?
> 
> Maybe it isn't good, the 'func' might not be run in the current context
> (irq context or some spinlock is held).

Then I'd say don't use this interface.  If you have code that needs to
be run in a different context, then you have to use a work item (or
equivalent) anyway and you can do a synchronous runtime resume from there.

The problem we want to address here is when there's code that should be
run as soon as the device is active, preferably _without_ a context switch.

Thanks,
Rafael
