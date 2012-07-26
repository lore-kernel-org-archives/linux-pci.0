Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60218 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751961Ab2GZPDk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 11:03:40 -0400
Date: Thu, 26 Jul 2012 11:03:40 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
cc: Huang Ying <ying.huang@intel.com>,
	huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
In-Reply-To: <87k3xqyfm3.fsf@nemi.mork.no>
Message-ID: <Pine.LNX.4.44L0.1207261101350.1295-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 26 Jul 2012, Bjørn Mork wrote:

> Huang Ying <ying.huang@intel.com> writes:
> 
> > Do you have time to try the below patch?
> 
> Sure.  Looks OK wrt the USB problems, but may cause problems with the
> PCIe WiFi card.  Unless those are related to other changes in -next.
> 
> Anyway, for I applied your patch on top of next-20120724 for
> consistency (still without Rafael print fix, so we get the D4 below).  
> This results in different stats for the uhci_hcd and ehci_hcd:
> 
> 
> Jul 26 12:13:42 nemi kernel: [   72.820305] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D2
> Jul 26 12:13:42 nemi kernel: [   72.835101] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D2
> Jul 26 12:13:44 nemi kernel: [   74.808770] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D2
> Jul 26 12:13:44 nemi kernel: [   74.840293] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D4
> Jul 26 12:13:44 nemi kernel: [   74.840326] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D4
> 
> I assume that is expected, based on the lspci output I posted earlier.
> Overall I get a nice mix of allowed/disallowed:

...

> USB hotplugging seems to work fine with this.

Don't be too sure.  Have you tested to see if it still works after 
doing "rmmod ehci-hcd"?

So far you have tested the EHCI controllers, but have you tested the 
UHCI controllers?  Unloading ehci-hcd will force them to be used.

Alan Stern

