Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbdGBViW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Jul 2017 17:38:22 -0400
Date: Sun, 2 Jul 2017 16:38:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: kys@microsoft.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        devel@linuxdriverproject.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] hv: fix msi affinity when device requests all possible
 CPU's
Message-ID: <20170702213819.GF18324@bhelgaas-glaptop.roam.corp.google.com>
References: <20170628232204.15227-1-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170628232204.15227-1-sthemmin@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 28, 2017 at 04:22:04PM -0700, Stephen Hemminger wrote:
> When Intel 10G (ixgbevf) is passed to a Hyper-V guest with SR-IOV,
> the driver requests affinity with all possible CPU's (0-239) even
> those CPU's are not online (and will never be). Because of this the device
> is unable to correctly get MSI interrupt's setup.
> 
> This was caused by the change in 4.12 that converted this affinity
> into all possible CPU's (0-31) but then host reports
> an error since this is larger than the number of online cpu's.
> 
> Previously, this worked (up to 4.12-rc1) because only online cpu's
> would be put in mask passed to the host.
> 
> This patch applies only to 4.12.
> The driver in linux-next needs a a different fix because of the changes
> to PCI host protocol version.

If Linus decides to postpone v4.12 a week, I can ask him to pull this.  But
I suspect he will release v4.12 today.  In that case, I don't know what to
do with this other than maybe send it to Greg for a -stable release.

> Fixes: 433fcf6b7b31 ("PCI: hv: Specify CPU_AFFINITY_ALL for MSI affinity when >= 32 CPUs")
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 84936383e269..3cadfcca3ae9 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -900,10 +900,12 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	 * processors because Hyper-V only supports 64 in a guest.
>  	 */
>  	affinity = irq_data_get_affinity_mask(data);
> +	cpumask_and(affinity, affinity, cpu_online_mask);
> +
>  	if (cpumask_weight(affinity) >= 32) {
>  		int_pkt->int_desc.cpu_mask = CPU_AFFINITY_ALL;
>  	} else {
> -		for_each_cpu_and(cpu, affinity, cpu_online_mask) {
> +		for_each_cpu(cpu, affinity) {
>  			int_pkt->int_desc.cpu_mask |=
>  				(1ULL << vmbus_cpu_number_to_vp_number(cpu));
>  		}
> -- 
> 2.11.0
> 
