Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47809 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752468Ab2GaVFZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2012 17:05:25 -0400
Date: Tue, 31 Jul 2012 17:05:24 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <201207312231.19505.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1207311658340.1532-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[CC: list trimmed]

On Tue, 31 Jul 2012, Rafael J. Wysocki wrote:

> Now it occured to me that perhaps we don't need the current asynchronous
> pm_runtime_get() at all.  The usefulness of it is quite questionable, because
> either we want to resume the device immediately, for which pm_runtime_get_sync()
> should be used, or we just want to bump up the usage counter, in which cases
> pm_runtime_get_noresume() should always be sufficient.  I fail to see any
> particularly compelling use case for pm_runtime_get() doing an asynchronous
> resume at the moment, but perhaps that's just me.

There are indeed valid uses for pm_runtime_get().  We are forced to use
it in non-sleepable contexts when we want to resume the device as
quickly as possible.  Example: a driver receives an I/O request from an
interrupt handler.

> However, I receive reports of people using pm_runtime_get() where they really
> should use pm_runtime_get_sync(), so I wonder if we can simply rename
> pm_runtime_get_sync() as pm_runtime_get() and drop the asynchronous version
> altogether?

Well, IMO the naming should have been the other way around from the
start.  That is, we should have made pm_runtime_get be the synchronous
routine and pm_runtime_get_async be the asynchronous one.  But it's too
late to change now.

And no, we can't get rid of the async version.

Alan Stern

