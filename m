Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752637AbeCUUKT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 16:10:19 -0400
Date: Wed, 21 Mar 2018 15:10:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Tal Gilboa <talgi@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: Re: [PATCH next V3 3/5] PCI: Print PCI device link status in kernel
 log
Message-ID: <20180321201017.GD38649@bhelgaas-glaptop.roam.corp.google.com>
References: <1520856370-15404-1-git-send-email-talgi@mellanox.com>
 <1520856370-15404-4-git-send-email-talgi@mellanox.com>
 <20180320140527.GL77194@bhelgaas-glaptop.roam.corp.google.com>
 <c513c09c-69d6-3a01-b183-496622daebdc@mellanox.com>
 <20180321194758.GC38649@bhelgaas-glaptop.roam.corp.google.com>
 <02874ECE860811409154E81DA85FBB5882D020D9@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <02874ECE860811409154E81DA85FBB5882D020D9@ORSMSX115.amr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 21, 2018 at 07:59:21PM +0000, Keller, Jacob E wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Wednesday, March 21, 2018 12:48 PM
> > To: Tal Gilboa <talgi@mellanox.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; Linux PCI <linux-
> > pci@vger.kernel.org>; Tariq Toukan <tariqt@mellanox.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>
> > Subject: Re: [PATCH next V3 3/5] PCI: Print PCI device link status in kernel log
> > 
> > On Wed, Mar 21, 2018 at 09:43:48AM +0200, Tal Gilboa wrote:
> > > On 3/20/2018 4:05 PM, Bjorn Helgaas wrote:
> > > > [+cc Jacob]
> > > >
> > > > On Mon, Mar 12, 2018 at 02:06:08PM +0200, Tal Gilboa wrote:
> > > > > Add pcie_print_link_status() function for querying and verifying
> > > > > a PCI device link status. The PCI speed and width are reported
> > > > > in kernel log.
> > > > > This provides a unified method for all PCI devices to
> > > > > report status and issues, instead of each device reporting in a
> > > > > different way, using different code.

> > > So let's see if we agree on the steps:
> > > 1. my_speed_cap, my_width_cap <- calculate device PCIe caps
> > > 2. avail_bw, limiting_dev <- calculate PCIe chain bandwidth
> > > 3. my_bw <- my_speed_cap * my_width_cap
> > > 4. If avail_bw == my_bw print available bandwidth + PCIe caps
> > > 5. Else print available bandwidth + limited by + capable bandwidth + PCIe
> > > caps
> > >
> > > What do you think?
> > 
> > Steps 2 and 3 might need to be smart enough to apply the effect of
> > encoding differences between generations.
> > 
> > In step 2, we don't have any current user of the "limiting_dev"
> > information, so I'd omit it until we have somebody who wants it.
> > 
> > In step 5, we don't know the "limited by" part (unless you want to add
> > that).
> 
> It might be useful to have the limited by information printed, even
> if no driver yet bothered to do it today.

I wouldn't object to printing that information (although it increases
the challenge of making the message pithy), and it's basically free to
collect it.
