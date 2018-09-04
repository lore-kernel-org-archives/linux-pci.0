Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbeIEDTS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 23:19:18 -0400
Date: Tue, 4 Sep 2018 16:52:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: RFC on PCI Device Lock
Message-ID: <20180904165202.4e5bb59d@t450s.home>
In-Reply-To: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
References: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 31 Aug 2018 16:03:38 -0700
Sinan Kaya <okaya@kernel.org> wrote:

> Hi Bjorn, Alex;
> 
> Since my recent series to relocate secondary bus reset code into the PCI core,
> we hit a deadlock while trying to obtain a device lock during probe since
> device lock is already held.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=200985
> 
> I posted a patch into the bugzilla so that we skip locks if we are probing
> to follow the same strategy found in other lock routines in pci.c.
> 
> https://bugzilla.kernel.org/attachment.cgi?id=278221
> 
> I wanted to hear some opinions since this is a regression and need to find
> a solution and also waiting for test feedback

TBH, I'm having a hard time seeing the value in the original series.
Commit 811c5cb37df4 is fiddling with two drivers, hfi1 and vfio-pci.
In the case of hfi1 the comment before the call is specifically talking
about performing a secondary bus reset, so all they're looking for is
bouncing the link, it seems they don't even necessarily want a slot
reset, which might entail a full power cycle. In the case of vfio-pci,
we're looking for whatever gets the device closest to a power on state,
so by all means we want the slot reset if we can get it.  So really
there's only one driver here looking for a slot reset and this commit
doesn't do anything to abstract bus vs slot reset because vfio-pci
needs to collect all the devices affected by the reset, which can be
different depending on whether it's a slot or bus (think conventional
PCI).  So all the logic in vfio-pci to figure out which it is still
exists, we just no longer have control over which option PCI-core uses.

Commit 409888e0966e switches hfi1 to use pci_try_reset_bus(), which of
course does the device save and restore, but the hfi1 driver still has
their own logic for all of that and of course it doesn't rely on device
lock and doesn't need to because they're within their own probe path.

I won't deny that we're getting a little sloppy with some of the reset
interfaces and I'd love to solve the device lock issue more generally,
but trying to abstract slot vs bus and hide the lower level interfaces
from drivers doesn't seem like it's really working here.  Thanks,

Alex
