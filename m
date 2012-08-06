Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36557 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932074Ab2HFOrT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2012 10:47:19 -0400
Date: Mon, 6 Aug 2012 10:47:18 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ming Lei <tom.leiming@gmail.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, <linux-pci@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <CACVXFVPNO2yQXJjwPGm8oLeNHsj72wtHnJ5YKLg65hR2X7BWDg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1208061045020.1649-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 6 Aug 2012, Ming Lei wrote:

> Maybe the return value should be passed to caller. Also the race between
> 'func' and its .runtime_resume callback should be stated in comment.
> 
> In fact, maybe it is better to call 'func' always first, then call
> ' rpm_resume(dev, RPM_ASYNC);', otherwise the driver may
> be confused about the order between 'func' and its .runtime_resume
> callback.

> Another way is to define 'func' as 'runtime_pre_resume'
> in 'struct dev_pm_ops', and there are some advantages about this way:
> 
>         - save one pointer in 'struct devices, since most of devices
> don't need the 'func'
>         - well documents on 'runtime_pre_resume'
>         - caller of pm_runtime_get_and_call may be happier, maybe just
>         pm_runtime_get or *_aync is enough.

No, no, you have completely misunderstood the whole point of this 
change.

The idea is for "func" to be called at a time when it is known that the 
device is at full power.  That means it _has_ to be called after the 
runtime_resume callback returns.

Also, "func" should not be stored in dev_pm_ops because it won't be a 
read-only value.

Alan Stern

