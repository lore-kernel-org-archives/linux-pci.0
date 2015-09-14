Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39783 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900AbbINQyP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Sep 2015 12:54:15 -0400
Message-ID: <1442249653.23936.17.camel@redhat.com>
Subject: Re: [RFC PATCH] vfio/pci: Use kernel VPD access functions
From: Alex Williamson <alex.williamson@redhat.com>
To: "Rustad, Mark D" <mark.d.rustad@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.h.duyck@redhat.com" <alexander.h.duyck@redhat.com>,
	"myron.stowe@redhat.com" <myron.stowe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 14 Sep 2015 10:54:13 -0600
In-Reply-To: <80CE59CA-1B93-42FF-96D1-6276B724203F@intel.com>
References: <20150911181332.32399.74472.stgit@gimli.home>
	 <80CE59CA-1B93-42FF-96D1-6276B724203F@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2015-09-12 at 01:11 +0000, Rustad, Mark D wrote:
> Alex,
> 
> > On Sep 11, 2015, at 11:16 AM, Alex Williamson <alex.williamson@redhat.com> wrote:
> > 
> > RFC - Is this something we should do?
> 
> Superficially this looks pretty good. I need to think harder to be sure of the details.
> 
> > Should we consider providing
> > similar emulation through PCI sysfs to allow lspci to also make use
> > of the vpd interfaces?
> 
> It looks to me like lspci already uses the vpd attribute in sysfs to access VPD, so maybe nothing more than this is needed. No doubt lspci can be coerced into accessing VPD directly, but is that really worth going after? I'm not so sure.
> 
> An strace of lspci accessing a device with VPD shows me:
> 
> write(1, "\tCapabilities: [e0] Vital Produc"..., 39	Capabilities: [e0] Vital Product Data
> ) = 39
> open("/sys/bus/pci/devices/0000:02:00.0/vpd", O_RDONLY) = 4
> ----------------------------------------^^^ accesses to this should be safe, I think
> 
> pread(4, "\202", 1, 0)                  = 1
> pread(4, "\10\0", 2, 1)                 = 2
> pread(4, "PVL Dell", 8, 3)              = 8
> write(1, "\t\tProduct Name: PVL Dell\n", 25		Product Name: PVL Dell
> ) = 25
> 
> and so forth.

Oh good, so aside from some rouge admin poking around with setpci access
through pci-sysfs is hopefully not an issue.  Thanks for looking into
it.

Alex

