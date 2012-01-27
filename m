Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:34762 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab2A0TJw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2012 14:09:52 -0500
Date: Fri, 27 Jan 2012 14:07:22 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xensource.com
Subject: Re: [PATCH 1/2] pci: Introduce __pci_reset_function_locked to be
 used when holding device_lock.
Message-ID: <20120127190722.GA14256@phenom.dumpdata.com>
References: <1326388007-19178-1-git-send-email-konrad.wilk@oracle.com>
 <1326388007-19178-2-git-send-email-konrad.wilk@oracle.com>
 <20120127093225.7c1194ae@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120127093225.7c1194ae@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 27, 2012 at 09:32:25AM -0800, Jesse Barnes wrote:
> On Thu, 12 Jan 2012 12:06:46 -0500
> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> 
> > The use case of this is when a driver wants to call FLR when a device
> > is attached to it using the SysFS "bind" or "unbind" functionality.
> > 
> > The call chain when a user does "bind" looks as so:
> > 
> >  echo "0000:01.07.0" > /sys/bus/pci/drivers/XXXX/bind
> > 
> > and ends up calling:
> >   driver_bind:
> >     device_lock(dev);  <=== TAKES LOCK
> >     XXXX_probe:
> >          .. pci_enable_device()
> >          ...__pci_reset_function(), which calls
> >                  pci_dev_reset(dev, 0):
> >                         if (!0) {
> >                                 device_lock(dev) <==== DEADLOCK
> 
> I have these two in my -next branch now; but you could also push them
> through the Xen tree.  If you have other deps and the Xen tree would be
> easier, just let me know and I'll drop them.

Thanks! Lets keep them in your tree.
