Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53750 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753165Ab2G2Oz4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2012 10:55:56 -0400
Date: Sun, 29 Jul 2012 10:55:55 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Huang Ying <ying.huang@intel.com>,
	=?iso-8859-1?q?Bj=F8rn_Mork?= <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
In-Reply-To: <201207291555.52749.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1207291051310.18141-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 29 Jul 2012, Rafael J. Wysocki wrote:

> The difference is, if you use _put_sync(), you need to wait the extra 10 ms
> for local_pci_probe() to return (if the parent is actually suspended),
> although you might not need to wait for it if you used _put(), right?

Yes, that's the difference.  But who waits for local_pci_probe() to 
return?  :-)

> Which, to me, means that using _put_sync() may not be always better.
> It probably doesn't matter a lot, but then the workqueue overhead shouldn't
> matter a lot either.

It's that in the end, the extra overhead is pretty small.  For me
there's also an issue of style: If you do a synchronous get then it
looks odd not to do a synchronous put.  My feeling has always been that
the async routines are for use in non-process contexts, where the sync
routines can't be used.  Using them just to return a little more
quickly is a foreign idea.

Alan Stern

