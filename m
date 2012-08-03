Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38994 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab2HCDhh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2012 23:37:37 -0400
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1208022151450.22991-100000@netrider.rowland.org>
References: <201208022326.31178.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1208022151450.22991-100000@netrider.rowland.org>
Date: Fri, 3 Aug 2012 11:37:35 +0800
Message-ID: <CACVXFVOdwNiSkF1_Bs-FY-PT4gqZ86j6pcr4A=Yckc0bxykgRQ@mail.gmail.com>
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

On Fri, Aug 3, 2012 at 10:20 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 2 Aug 2012, Rafael J. Wysocki wrote:

> Hmmm.  You'd probably want a version that does a "get" at the same
> time.  I suppose you would call func directly if the device was already
> resumed, without going through the workqueue?

Maybe it isn't good, the 'func' might not be run in the current context
(irq context or some spinlock is held).

>> And what if you are a parent waited for by a child to resume so that _it_
>> can process its data?  Would you still want to process your data in the
>> resume callback in that case?

Looks the child is always resumed after its parent completes the resuming,
and current pm_runtime_get doesn't delay the resume of the parent, and
just make the .runtime_resume run in another context.

Also are there actual examples about the above situation?

>
> Okay, those are valid reasons.  (Although a device handling I/O
> requests isn't likely to have a child with its own independent I/O
> handling.)

IMO, the .runtime_resume callback can handle the IO things easily
via scheduling worker function if the driver don't want to delay
its children's resume.

Thanks,
-- 
Ming Lei
