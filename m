Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753623AbcHWUDM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Aug 2016 16:03:12 -0400
Date: Tue, 23 Aug 2016 15:02:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160823200232.GB3725@localhost>
References: <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
 <20160822165524.GC18628@localhost>
 <20160822211536.GE28276@localhost.localdomain>
 <20160823133913.GN18628@localhost>
 <20160823171018.GB10224@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160823171018.GB10224@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 01:10:18PM -0400, Keith Busch wrote:
> On Tue, Aug 23, 2016 at 08:39:13AM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 22, 2016 at 05:15:36PM -0400, Keith Busch wrote:
> > 
> > The other IBPI states (fail, rebuild, predicted failure, hotspare,
> > degraded, failed) all seem like storage-related things without an
> > obvious connection to pciehp.  I would expect a kernel driver like md
> > to manage those states.
> 
> Yes, that's fairly accurate on how this works with other storage
> transports. While md doesn't directly affect LED states, 'ledmon'
> subscribes to md events and executes an appropriate LED control method
> specific to that transport.

This is a tangent, but is there some reason for putting ledmon in the
middle of this scheme?  It seems like the important pieces (md and LED
control) are intimately related and both in the kernel, so why the
trip through userland?  ledmon sounds like a glorified special-case
/dev/mem, with similar security and stability issues.  Plus it must
have to associate a storage device with a PCIe port, grub through its
config space to find the Slot Control register, deal with possible
hotplug, etc.  It all sounds icky.

Bjorn
