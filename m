Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 12 Apr 2018 21:32:49 -0700
From: Jakub Kicinski <kubakici@wp.pl>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20180412213249.06661048@cakuba.netronome.com>
In-Reply-To: <152244391852.135666.14903825998610307052.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
        <152244391852.135666.14903825998610307052.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 30 Mar 2018 16:05:18 -0500, Bjorn Helgaas wrote:
> +	if (bw_avail >= bw_cap)
> +		pci_info(dev, "%d Mb/s available bandwidth (%s x%d link)\n",
> +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
> +	else
> +		pci_info(dev, "%d Mb/s available bandwidth, limited by %s x%d link at %s (capable of %d Mb/s with %s x%d link)\n",
> +			 bw_avail, PCIE_SPEED2STR(speed), width,
> +			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
> +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);

I was just looking at using this new function to print PCIe BW for a
NIC, but I'm slightly worried that there is nothing in the message that
says PCIe...  For a NIC some people may interpret the bandwidth as NIC
bandwidth:

[   39.839989] nfp 0000:04:00.0: Netronome Flow Processor NFP4000/NFP6000 PCIe Card Probe
[   39.848943] nfp 0000:04:00.0: 63.008 Gb/s available bandwidth (8 GT/s x8 link)
[   39.857146] nfp 0000:04:00.0: RESERVED BARs: 0.0: General/MSI-X SRAM, 0.1: PCIe XPB/MSI-X PBA, 0.4: Explicit0, 0.5: Explicit1, fre4

It's not a 63Gbps NIC...  I'm sorry if this was discussed before and I
didn't find it.  Would it make sense to add the "PCIe: " prefix to the
message like bnx2x used to do?  Like:

nfp 0000:04:00.0: PCIe: 63.008 Gb/s available bandwidth (8 GT/s x8 link)

Sorry for a very late comment.
