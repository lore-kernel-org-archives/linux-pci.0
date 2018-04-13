Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754188AbeDMOGf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Apr 2018 10:06:35 -0400
Date: Fri, 13 Apr 2018 09:06:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jakub Kicinski <kubakici@wp.pl>
Cc: Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link
 speed and whether it's limited
Message-ID: <20180413140633.GD46420@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244391852.135666.14903825998610307052.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180412213249.06661048@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412213249.06661048@cakuba.netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2018 at 09:32:49PM -0700, Jakub Kicinski wrote:
> On Fri, 30 Mar 2018 16:05:18 -0500, Bjorn Helgaas wrote:
> > +	if (bw_avail >= bw_cap)
> > +		pci_info(dev, "%d Mb/s available bandwidth (%s x%d link)\n",
> > +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
> > +	else
> > +		pci_info(dev, "%d Mb/s available bandwidth, limited by %s x%d link at %s (capable of %d Mb/s with %s x%d link)\n",
> > +			 bw_avail, PCIE_SPEED2STR(speed), width,
> > +			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
> > +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
> 
> I was just looking at using this new function to print PCIe BW for a
> NIC, but I'm slightly worried that there is nothing in the message that
> says PCIe...  For a NIC some people may interpret the bandwidth as NIC
> bandwidth:
> 
> [   39.839989] nfp 0000:04:00.0: Netronome Flow Processor NFP4000/NFP6000 PCIe Card Probe
> [   39.848943] nfp 0000:04:00.0: 63.008 Gb/s available bandwidth (8 GT/s x8 link)
> [   39.857146] nfp 0000:04:00.0: RESERVED BARs: 0.0: General/MSI-X SRAM, 0.1: PCIe XPB/MSI-X PBA, 0.4: Explicit0, 0.5: Explicit1, fre4
> 
> It's not a 63Gbps NIC...  I'm sorry if this was discussed before and I
> didn't find it.  Would it make sense to add the "PCIe: " prefix to the
> message like bnx2x used to do?  Like:
> 
> nfp 0000:04:00.0: PCIe: 63.008 Gb/s available bandwidth (8 GT/s x8 link)

I agree, that does look potentially confusing.  How about this:

  nfp 0000:04:00.0: 63.008 Gb/s available PCIe bandwidth (8 GT/s x8 link)

I did have to look twice at this before I remembered that we're
printing Gb/s (not GB/s).  Most of the references I found on the web
use GB/s when talking about total PCIe bandwidth.

But either way I think it's definitely worth mentioning PCIe
explicitly.
