Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:45187 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab2GZQYz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 12:24:55 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huang Ying <ying.huang@intel.com>,
	huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
References: <Pine.LNX.4.44L0.1207261101350.1295-100000@iolanthe.rowland.org>
Date: Thu, 26 Jul 2012 18:24:36 +0200
In-Reply-To: <Pine.LNX.4.44L0.1207261101350.1295-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Thu, 26 Jul 2012 11:03:40 -0400 (EDT)")
Message-ID: <87d33iij7f.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

>> USB hotplugging seems to work fine with this.
>
> Don't be too sure.  Have you tested to see if it still works after 
> doing "rmmod ehci-hcd"?
>
> So far you have tested the EHCI controllers, but have you tested the 
> UHCI controllers?  Unloading ehci-hcd will force them to be used.

Good point.  Now tested and seems to work.

But I'd appreciate it if someone else were able to doublecheck my
results.  I am juggling with a number of settings and could easily mess
up something, invalidating the tests.  I believe the issue should be
present in lots of systems, isn't that correct?  Any GM45 based laptop
should do as a test bench, and maybe others too.

The WiFi issues I had also indicates that these changes should be tested
on as many different systems as possible. 



Bjørn
