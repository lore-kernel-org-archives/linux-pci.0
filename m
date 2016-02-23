Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59546 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbcBWRLu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 12:11:50 -0500
Date: Tue, 23 Feb 2016 11:11:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH v4 00/11] PCI VPD access fixes
Message-ID: <20160223171146.GA25987@localhost>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 22, 2016 at 06:46:23PM -0600, Bjorn Helgaas wrote:
> Hi Hannes,
> 
> This is a revision of your v3 series:
> http://lkml.kernel.org/r/1455525722-122040-1-git-send-email-hare@suse.de
> 
> Here's the description from your v3 posting:
> 
>   the current PCI VPD page access assumes that the entire possible VPD
>   data is readable. However, the spec only guarantees a VPD data up to
>   the 'end' marker, with everything beyond that being undefined.
>   This causes a system lockup on certain devices.
> 
>   With this patch we always set the VPD sysfs attribute size to '0', and
>   calculate the available VPD size on the first access.
>   If no valid data can be read an I/O error is returned.
> 
>   I've also included the patch from Babu to blacklists devices which
>   are known to lockup when accessing the VPD data.
> 
> I tweaked a few things, mostly whitespace and printk changes.  The
> appended diff shows the changes I made.
> 
> I added some patches on top to clean up and simplify the VPD code.
> These shouldn't make any functional difference unless I've made a
> mistake.  I've built these, but I don't really have a way to test
> them.
> 
> I am still waiting for bugzilla links from Babu for the blacklist
> patch.
> 
> Bjorn
> 
> ---
> 
> Babu Moger (1):
>       FIXME need bugzilla link
> 
> Bjorn Helgaas (7):
>       PCI: Use bitfield instead of bool for struct pci_vpd_pci22.busy
>       PCI: Move pci_read_vpd() and pci_write_vpd() close to other VPD code
>       PCI: Move pci_vpd_release() from header file to pci/access.c
>       PCI: Remove struct pci_vpd_ops.release function pointer
>       PCI: Rename VPD symbols to remove unnecessary "pci22"
>       PCI: Fold struct pci_vpd_pci22 into struct pci_vpd
>       PCI: Sleep rather than busy-wait for VPD access completion
> 
> Hannes Reinecke (3):
>       PCI: Update VPD definitions
>       PCI: Allow access to VPD attributes with size 0
>       PCI: Determine actual VPD size on first access
> 
> 
>  drivers/pci/access.c    |  240 ++++++++++++++++++++++++++++++-----------------
>  drivers/pci/pci-sysfs.c |   22 +++-
>  drivers/pci/pci.h       |   16 ++-
>  drivers/pci/probe.c     |    2 
>  drivers/pci/quirks.c    |   29 ++++++
>  include/linux/pci.h     |   27 +++++
>  6 files changed, 231 insertions(+), 105 deletions(-)

I added Hannes' reviewed-by and applied these, with the exception of
"PCI: Prevent VPD access for buggy devices" (I'm waiting for bugzilla
links for those quirks), to pci/vpd for v4.6.

Bjorn
