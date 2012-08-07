Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56167 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863Ab2HGBfe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2012 21:35:34 -0400
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1208061045020.1649-100000@iolanthe.rowland.org>
References: <CACVXFVPNO2yQXJjwPGm8oLeNHsj72wtHnJ5YKLg65hR2X7BWDg@mail.gmail.com>
	<Pine.LNX.4.44L0.1208061045020.1649-100000@iolanthe.rowland.org>
Date: Tue, 7 Aug 2012 09:35:32 +0800
Message-ID: <CACVXFVP=RJ=Zcj4NDpr7zD1+X=oVPg40v6yR7_osOxN8mPowEA@mail.gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
From: Ming Lei <tom.leiming@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 6, 2012 at 10:47 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> No, no, you have completely misunderstood the whole point of this
> change.

Sorry, you are right. And the callback should be renamed as
'.runtime_post_resume', which should do something I/O related in
theory just after device becomes active.

>
> The idea is for "func" to be called at a time when it is known that the
> device is at full power.  That means it _has_ to be called after the
> runtime_resume callback returns.

Yes, I agree, but I don't think it may make .runtime_post_resume
not doable, do I?

>
> Also, "func" should not be stored in dev_pm_ops because it won't be a
> read-only value.

Sorry, could you explain it in detail that why the 'func'
has to switch to multiple functions dynamically? I understand
one function is enough and sometimes it can be bypassed with
one flag(such as, ignore_post_resume is introduced in dev_pm_info)
set.  Also, the driver can store the device specific states
in its own device instance to deal with different situations in the callback.

If the idea is doable, we can save one pointer in 'struct device',
since the 'func' may not be used by more than 90% devices, also
have document benefit, even may simplify implementation of the
mechanism.


Thanks,
-- 
Ming Lei
