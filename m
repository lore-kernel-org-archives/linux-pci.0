Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:45896 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887Ab2HGLR5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Aug 2012 07:17:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Tue, 7 Aug 2012 13:23:51 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <CACVXFVPNO2yQXJjwPGm8oLeNHsj72wtHnJ5YKLg65hR2X7BWDg@mail.gmail.com> <Pine.LNX.4.44L0.1208061045020.1649-100000@iolanthe.rowland.org> <CACVXFVP=RJ=Zcj4NDpr7zD1+X=oVPg40v6yR7_osOxN8mPowEA@mail.gmail.com>
In-Reply-To: <CACVXFVP=RJ=Zcj4NDpr7zD1+X=oVPg40v6yR7_osOxN8mPowEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208071323.51275.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 07, 2012, Ming Lei wrote:
> On Mon, Aug 6, 2012 at 10:47 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > No, no, you have completely misunderstood the whole point of this
> > change.
> 
> Sorry, you are right. And the callback should be renamed as
> '.runtime_post_resume', which should do something I/O related in
> theory just after device becomes active.
> 
> >
> > The idea is for "func" to be called at a time when it is known that the
> > device is at full power.  That means it _has_ to be called after the
> > runtime_resume callback returns.
> 
> Yes, I agree, but I don't think it may make .runtime_post_resume
> not doable, do I?

No more device PM callbacks, please.

Besides, callbacks in struct dev_pm_ops are not only for drivers.

> > Also, "func" should not be stored in dev_pm_ops because it won't be a
> > read-only value.
> 
> Sorry, could you explain it in detail that why the 'func'
> has to switch to multiple functions dynamically? I understand
> one function is enough and sometimes it can be bypassed with
> one flag(such as, ignore_post_resume is introduced in dev_pm_info)
> set.  Also, the driver can store the device specific states
> in its own device instance to deal with different situations in the callback.
> 
> If the idea is doable, we can save one pointer in 'struct device',
> since the 'func' may not be used by more than 90% devices, also
> have document benefit, even may simplify implementation of the
> mechanism.

And how many struct device objects there are for the one extra pointer to
matter, let alone the fact that you want to replace it by one extra pointer
somewhere else?

Rafael
