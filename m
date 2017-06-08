Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbdFHNGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 09:06:10 -0400
Date: Thu, 8 Jun 2017 07:06:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: kvm@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Stefan Assmann <sassmann@redhat.com>,
        linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] vfio/pci: Add Intel XXV710 to hidden INTx devices
Message-ID: <20170608070609.435a7187@t450s.home>
In-Reply-To: <20170608080017.GA12580@infradead.org>
References: <20170607190132.22711.46831.stgit@gimli.home>
        <20170608080017.GA12580@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+linux-pci]

On Thu, 8 Jun 2017 01:00:17 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 07, 2017 at 01:01:46PM -0600, Alex Williamson wrote:
> > XXV710 has the same broken INTx behavior as the rest of the X/XL710
> > series, the interrupt status register is not wired to report pending
> > INTx interrupts, thus we never associate the interrupt to the device.
> > Extend the device IDs to include these so that we hide that the
> > device supports INTx at all to the user.  
> 
> Is vfio really the right place for the list?  Shouldn't this be
> keyed off the core PCI quirk for these devices?

I sent a separate patch to add these devices to the regular broken INTx
quirk in pci-core:

http://www.spinics.net/lists/linux-pci/msg61971.html

We don't currently have a device flag to specify that INTx is broken in
this particular way that vfio can work around, nor do I really know how
other drivers might make use of this info.  If I'm wrong, then
certainly let's make a common way to do this, but this patch is just a
trivial extension to an existing mechanism.  Thanks,

Alex
