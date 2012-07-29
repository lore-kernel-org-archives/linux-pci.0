Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:42643 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753629Ab2G2VoF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2012 17:44:05 -0400
Date: Sun, 29 Jul 2012 17:44:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Jassi Brar <jassisinghbrar@gmail.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>,
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
In-Reply-To: <CABb+yY2G7VurriJEbo-5WXY0kpyBB0cEWeACDDv++AHcKFZ+hQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1207291739460.26196-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 30 Jul 2012, Jassi Brar wrote:

> On Sun, Jul 29, 2012 at 8:25 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > For me there's also an issue of style: If you do a synchronous get then it
> > looks odd not to do a synchronous put.  My feeling has always been that
> > the async routines are for use in non-process contexts, where the sync
> > routines can't be used.  Using them just to return a little more
> > quickly is a foreign idea.
> >
> Another way of looking at it is - I need h/w to be active in order to
> proceed so I call get_sync but I don't care if the h/w is not put down
> immediately after I am done using it. So the put could be
> relaxed/async - At best, we could avoid an unnecessary suspend-resume
> cycle which could be expensive power and time wise. At worst, we
> return a bit quicker. Or so do I think.

If the reason for the choice is to opportunistically delay suspending,
there are better ways of doing it: pm_schedule_suspend,
pm_runtime_put_autosuspend.

Alan Stern

