Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7248 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbcBWXrW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 18:47:22 -0500
Date: Tue, 23 Feb 2016 16:47:10 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: helgaas@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	bryan.e.veal@intel.com, linux-pci@vger.kernel.org,
	tglx@linutronix.de, dan.j.williams@intel.com
Subject: Re: [PATCH] VMD: Attach vmd resources to parent domain's resource
 tree
Message-ID: <20160223234710.GA8670@localhost.localdomain>
References: <1456264213-3546-1-git-send-email-jonathan.derrick@intel.com>
 <20160223231610.GC20250@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160223231610.GC20250@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 23, 2016 at 11:16:11PM +0000, Keith Busch wrote:
> On Tue, Feb 23, 2016 at 02:50:13PM -0700, Jon Derrick wrote:
> > This patch attaches the new VMD domain's resources to the VMD device's
> > resources. This allows /proc/iomem to display a more complete picture.
> > 
> > Before:
> >   c0000000-c1ffffff : 0000:5d:05.5
> >   c2000000-c3ffffff : 0000:5d:05.5
> >     c2010000-c2013fff : nvme
> >   c4000000-c40fffff : 0000:5d:05.5
> > 
> > After:
> >   c0000000-c1ffffff : 0000:5d:05.5
> >     c0000000-0000001f : VMD CFGBAR
> >   c2000000-c3ffffff : 0000:5d:05.5
> >     c2000000-c3ffffff : VMD MEMBAR1
> >       c2000000-c22fffff : PCI Bus 10000:01
> >         c2000000-c200ffff : 10000:01:00.0
> >         c2010000-c2013fff : 10000:01:00.0
> >           c2010000-c2013fff : nvme
> >       c2300000-c24fffff : PCI Bus 10000:01
> >   c4000000-c40fffff : 0000:5d:05.5
> >     c4002000-c40fffff : VMD MEMBAR2
> 
> I think we should drop the CFGBAR from here since that's a bus resource
> rather than IO memory. Otherwise, this looks good and useful.
Yes that entry doesn't make much sense for iomem does it. I'll drop that part.

> 
> I think in the near future we should come up with a better name than
> "VMD MEMBAR" to help distinguish multiple VMD's in a system.
Seconded. I'm fine with naming it by its PCI designator, eg 10000:01:00.0, and maybe a bar designator after that (or not).
