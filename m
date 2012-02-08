Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43638 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756118Ab2BHPO3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2012 10:14:29 -0500
Date: Wed, 8 Feb 2012 10:14:28 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Felipe Balbi <balbi@ti.com>
cc: Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/4] usb: dwc3: second part of hibernation support
In-Reply-To: <20120208061452.GF3707@legolas.emea.dhcp.ti.com>
Message-ID: <Pine.LNX.4.44L0.1202081008040.1697-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 8 Feb 2012, Felipe Balbi wrote:

> Just keep in mind that glue layer also needs to keep track of its own
> usage counters, what I mean by that, is that on dwc3-pci probe you
> should probably call pm_runtime_get_sync() and right before returning
> from probe, you call pm_runtime_put(). This will make sure that the PCIe
> device is powered up when you need and can be autosuspended when you
> don't need it anymore.

Runtime PM for PCI devices uses a slightly different scheme.  The PCI
core increments the usage counter when a PCI device is first probed,
and doesn't decrement the counter until the device is removed.  This 
helps drivers without runtime PM support; the device will never be 
autosuspended.

As a result, if a PCI driver does support autosuspend, it doesn't need
to make any special calls in its probe and remove routines.  It just
has to call pm_runtime_put[_sync] when not using the device and 
pm_runtime_get[_sync] when ready to start using it again.

Alan Stern

