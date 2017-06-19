Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbdFSVHq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jun 2017 17:07:46 -0400
Date: Mon, 19 Jun 2017 16:07:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: haiyangz@microsoft.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Message-ID: <20170619210742.GA554@bhelgaas-glaptop.roam.corp.google.com>
References: <1495658355-13103-1-git-send-email-haiyangz@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495658355-13103-1-git-send-email-haiyangz@exchange.microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Christoph]

On Wed, May 24, 2017 at 01:39:15PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> This patch uses the lower 16 bits of the serial number as PCI
> domain, otherwise some drivers may not be able to handle it.
> 
> Besides Nvidia drivers, we also found X.org, and DPDK handle
> only 16 bit PCI domain.

If you've sent patches to X.org and DPDK, please includes URLs to
them.

Christoph pointed out the conflict with VMD: vmd_find_free_domain()
allocates domains starting at 0x10000 to avoid the 16-bit domains
returned by ACPI _SEG.

I think we need a solution that works for both Nvidia/Hyper-V and VMD.
As it is, it looks like this will fix one place but break things
elsewhere.

If you believe that this will not break VMD, please explain.

Bjorn

> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 8493638..51a815d 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1335,9 +1335,11 @@ static void put_pcichild(struct hv_pci_dev *hpdev,
>  	 * can have shorter names than based on the bus instance UUID.
>  	 * Only the first device serial number is used for domain, so the
>  	 * domain number will not change after the first device is added.
> +	 * The lower 16 bits of the serial number is used, otherwise some
> +	 * drivers may not be able to handle it.
>  	 */
>  	if (list_empty(&hbus->children))
> -		hbus->sysdata.domain = desc->ser;
> +		hbus->sysdata.domain = desc->ser & 0xFFFF;
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	return hpdev;
> -- 
> 1.7.1
> 
