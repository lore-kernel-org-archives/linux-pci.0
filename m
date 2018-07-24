Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34576 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388321AbeGXQy5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jul 2018 12:54:57 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so1801765ybq.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2018 08:47:52 -0700 (PDT)
Date: Tue, 24 Jul 2018 11:47:50 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Myron Stowe <myron.stowe@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        keith.busch@intel.com
Subject: Re: [PATCH] PCI: Match Root Port's MPS to endpoint's MPSS when
 necessary
Message-ID: <20180724154749.GC5871@kudzu.us>
References: <20180718185158.149373.77902.stgit@tak.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180718185158.149373.77902.stgit@tak.stowe>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 18, 2018 at 12:51:58PM -0600, Myron Stowe wrote:
> In commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge"), we made
> sure every device's MPS setting matches its upstream bridge, making it more
> likely that a hot-added device will work in a system with an optimized MPS
> configuration.
> 
> Recently I've started encountering systems where the endpoint device's MPSS
> capability is less than its root port's current MPS value, thus the
> endpoint is not capable of matching its upstream bridge's MPS setting (see:
> bugzilla via "Link:" below).  This leaves the system vunerable - the
> upstream root port could respond with larger sized TLPs than the endpoint
> can handle, and the endpoint will consider them to be 'Malformed'.
> 
> One could use the "pci=pcie_bus_safe" kernel parameter to resolve the
> issue, but, it both forces a user to have to supply a kernel parameter to
> get the system to function reliable, and may end up limiting MPS settings
> of other, non-related, sub-topologies which could benefit from maintaining
> their larger values.
> 
> This patch augments Keith's approach to include tuning down a root port's
> MPS setting when its hot-added endpoint device is not capable of matching
> it.  The tuning down, so that both the root port and endpoint match, is
> limited to root ports with downstream endpoint device sub-topologies.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200527
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jon Mason <jdmason@kudzu.us>

Looks good to me
Acked-by: Jon Mason <jdmason@kudzu.us>

> Cc: Sinan Kaya <okaya@kernel.org>
> Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
> ---
>  drivers/pci/probe.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac91b6f..2987bd9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1670,7 +1670,7 @@ int pci_setup_device(struct pci_dev *dev)
>  static void pci_configure_mps(struct pci_dev *dev)
>  {
>  	struct pci_dev *bridge = pci_upstream_bridge(dev);
> -	int mps, p_mps, rc;
> +	int mps, mpss, p_mps, rc;
>  
>  	if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
>  		return;
> @@ -1694,6 +1694,14 @@ static void pci_configure_mps(struct pci_dev *dev)
>  	if (pcie_bus_config != PCIE_BUS_DEFAULT)
>  		return;
>  
> +	mpss = 128 << dev->pcie_mpss;
> +	if (mpss < p_mps && pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT) {
> +		pcie_set_mps(bridge, mpss);
> +		pci_info(dev, "Upstream bridge's Max Payload Size set to %d (was %d, max %d)\n",
> +			 mpss, p_mps, 128 << bridge->pcie_mpss);
> +		p_mps = pcie_get_mps(bridge);
> +	}
> +
>  	rc = pcie_set_mps(dev, p_mps);
>  	if (rc) {
>  		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
> @@ -1702,7 +1710,7 @@ static void pci_configure_mps(struct pci_dev *dev)
>  	}
>  
>  	pci_info(dev, "Max Payload Size set to %d (was %d, max %d)\n",
> -		 p_mps, mps, 128 << dev->pcie_mpss);
> +		 p_mps, mps, mpss);
>  }
>  
>  static struct hpp_type0 pci_default_type0 = {
> 
