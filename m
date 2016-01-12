Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36971 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbcALWnm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 17:43:42 -0500
Message-ID: <1452638620.9674.64.camel@redhat.com>
Subject: Re: [PATCH] don't allow vfio drivers to bind on driver_attach
From: Alex Williamson <alex.williamson@redhat.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "arjan@linux.intel.com" <arjan@linux.intel.com>,
	"rjw@sisk.pl" <rjw@sisk.pl>,
	"kay.sievers@vrfy.org" <kay.sievers@vrfy.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Date: Tue, 12 Jan 2016 15:43:40 -0700
In-Reply-To: <1452637513.30228.16.camel@intel.com>
References: <1452634390-17729-1-git-send-email-jacob.e.keller@intel.com>
	 <1452636370.9674.47.camel@redhat.com> <1452637513.30228.16.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-01-12 at 22:25 +0000, Keller, Jacob E wrote:
> On Tue, 2016-01-12 at 15:06 -0700, Alex Williamson wrote:
> > We already have a solution in the kernel for this, it's the
> > driver_override interface.  Rather than your above example of
> > adding
> > a
> > new ID to the dynamic list for the driver, such that it will
> > automatically probe the device, we reverse the process to allow the
> > device to match the driver.  The sequence becomes:
> > 
> > echo vfio-pci > /sys/bus/pci/devices/<pci address>/driver_override
> > echo <pci address> > /sys/bus/pci/drivers/<old driver>/unbind
> > echo <pci address> /sys/bus/pci/drivers_probe
> > 
> > The old interface is kept around because there are quite a few
> > users
> > of
> > it, some of which would be broken by the proposed manual_bind_only
> > code
> > change, including the example of using driver_override above.  This
> > also avoids even the need for pci-stub (which has the same issue),
> > since we can simply put a dummy name in driver_override to avoid a
> > device from matching any driver.  Thanks,
> > 
> > Alex
> 
> 
> Hmm, that makes sense. So really I should see about getting the tools
> which currently use the old interface to use a new one?
> 
> (Don't we still want/need vfio-pci for other reasons besides just being
> a stub driver?)

Of course, vfio-pci is much more than a stub driver, I was only noting
pci-stub as another meta driver that only uses dynamic adds.  It's more
of a side comment that the functionality that pci-stub provides is mostly unnecessary with driver_override.  Thanks,
Alex
