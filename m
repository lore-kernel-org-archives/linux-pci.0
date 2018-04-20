Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752689AbeDTRiL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 13:38:11 -0400
Date: Fri, 20 Apr 2018 12:38:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: oss-drivers@netronome.com, Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add PCIe to pcie_print_link_status() messages
Message-ID: <20180420173809.GR28657@bhelgaas-glaptop.roam.corp.google.com>
References: <20180413181638.6424-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180413181638.6424-1-jakub.kicinski@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 13, 2018 at 11:16:38AM -0700, Jakub Kicinski wrote:
> Currently the pcie_print_link_status() will print PCIe bandwidth
> and link width information but does not mention it is pertaining
> to the PCIe.  Since this and related functions are used exclusively
> by networking drivers today users may get confused into thinking
> that it's the NIC bandwidth that is being talked about.  Insert a
> "PCIe" into the messages.
> 
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Applied to for-linus for v4.17, thanks!

> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aa86e904f93c..73a0a4993f6a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5273,11 +5273,11 @@ void pcie_print_link_status(struct pci_dev *dev)
>  	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
>  
>  	if (bw_avail >= bw_cap)
> -		pci_info(dev, "%u.%03u Gb/s available bandwidth (%s x%d link)\n",
> +		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
>  			 bw_cap / 1000, bw_cap % 1000,
>  			 PCIE_SPEED2STR(speed_cap), width_cap);
>  	else
> -		pci_info(dev, "%u.%03u Gb/s available bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
> +		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
>  			 bw_avail / 1000, bw_avail % 1000,
>  			 PCIE_SPEED2STR(speed), width,
>  			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
> -- 
> 2.16.2
> 
