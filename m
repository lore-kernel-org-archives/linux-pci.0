Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp05.br.ibm.com ([32.104.18.26]:39575 "EHLO
	e24smtp05.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab3CNSwY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 14:52:24 -0400
Received: from /spool/local
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <cascardo@linux.vnet.ibm.com>;
	Thu, 14 Mar 2013 15:52:21 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 46612352006E
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 14:52:19 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2EIpasT16121946
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 15:51:36 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2EIqG6w026095
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 15:52:17 -0300
Date: Thu, 14 Mar 2013 15:52:14 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: lucaskt@linux.vnet.ibm.com
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, brking@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] ppc64: Add arch-specific pcie_get_speed_cap_mask
Message-ID: <20130314185214.GA13230@oc0268524204.ibm.com>
References: <1363283147-8852-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1363283147-8852-3-git-send-email-lucaskt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363283147-8852-3-git-send-email-lucaskt@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 14, 2013 at 02:45:47PM -0300, lucaskt@linux.vnet.ibm.com wrote:
> From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
> 
> Betters support for gen2 speed detections on PCI buses on ppc64
> architectures.
> 
> Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/pci.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 0b580f4..58469fe 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -24,6 +24,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/string.h>
> +#include <linux/device.h>
> 
>  #include <asm/eeh.h>
>  #include <asm/pci-bridge.h>
> @@ -108,3 +109,34 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
>  			 fixup_winbond_82c105);
> +
> +int pcibios_get_speed_cap_mask(struct pci_dev *dev, u32 *mask)
> +{
> +	struct device_node *dn, *pdn;
> +	const uint32_t *pcie_link_speed_stats = NULL;
> +
> +	*mask = 0;
> +	dn = pci_bus_to_OF_node(dev->bus);
> +
> +	/* Find nearest ibm,pcie-link-speed-stats, walking up the device tree */
> +	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
> +		pcie_link_speed_stats = (const uint32_t *) of_get_property(pdn,
> +			"ibm,pcie-link-speed-stats", NULL);
> +		if (pcie_link_speed_stats != NULL)
> +			break;
> +	}
> +
> +	if (pcie_link_speed_stats == NULL) {
> +		dev_info(&dev->dev, "no ibm,pcie-link-speed-stats property\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (pcie_link_speed_stats[0]) {
> +		case 0x02:
> +		*mask |= PCIE_SPEED_50;
> +		case 0x01:
> +		*mask |= PCIE_SPEED_25;
> +	}

I recall seeing this returns 0x00 as well. Maybe you should include both
0x00 and a default case and return EINVAL.

Regards.
Cascardo.

> +
> +	return 0;
> +}
> -- 
> 1.7.4.4
> 

