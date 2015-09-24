Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39520 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbbIXVtZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 17:49:25 -0400
Date: Thu, 24 Sep 2015 16:49:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Will Davis <wdavis@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 09/22] PCI: Add pci_peer_traffic_supported()
Message-ID: <20150924214921.GH10481@localhost>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
 <1442337067-22964-10-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442337067-22964-10-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 12:10:54PM -0500, Will Davis wrote:
> Add checks for topology and ACS configuration to determine whether or not
> peer traffic should be supported between two PCI devices.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> ---
>  drivers/pci/pci.c   | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  3 ++
>  2 files changed, 102 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0008c95..b8ba0f0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -25,6 +25,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/iommu.h>
>  #include <asm-generic/pci-bridge.h>
>  #include <asm/setup.h>
>  #include "pci.h"
> @@ -4302,6 +4303,104 @@ void pci_ignore_hotplug(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
>  
> +bool pci_peer_traffic_supported(struct pci_dev *dev, struct pci_dev *peer)
> +{
> +	struct pci_host_bridge *dev_host_bridge;
> +	struct pci_host_bridge *peer_host_bridge;
> +
> +	/*
> +	 * Disallow the peer-to-peer traffic if the devices do not share a
> +	 * host bridge. The PCI specifications does not make any guarantees
> +	 * about P2P capabilities between devices under separate domains.
> +	 *
> +	 * PCI Local Bus Specification Revision 3.0, section 3.10:
> +	 *    "Peer-to-peer transactions crossing multiple host bridges
> +	 *     PCI host bridges may, but are not required to, support PCI
> +	 *     peer-to-peer transactions that traverse multiple PCI host
> +	 *     bridges."
> +	 */
> +	dev_host_bridge = pci_find_host_bridge(dev->bus);
> +	peer_host_bridge = pci_find_host_bridge(peer->bus);
> +	if (dev_host_bridge != peer_host_bridge)
> +		return false;
> +
> +	if (pci_is_pcie(dev) && pci_is_pcie(peer)) {

Can you use the same "return errors early" trick here to unindent
everything below, e.g.,

  if (!pci_is_pcie(dev) || !pci_is_pcie(peer))
    return false;

> +		/*
> +		 * Access Control Services (ACS) Checks
> +		 *
> +		 * ACS has a capability bit for P2P Request Redirects (RR),
> +		 * but unfortunately it doesn't tell us much about the real
> +		 * capabilities of the hardware.
> +		 *
> +		 * PCI Express Base Specification Revision 3.0, section
> +		 * 6.12.1.1:
> +		 *    "ACS P2P Request Redirect: must be implemented by Root
> +		 *     Ports that support peer-to-peer traffic with other
> +		 *     Root Ports; [80]"
> +		 * but
> +		 *    "[80] Root Port indication of ACS P2P Request Redirect
> +		 *     or ACS P2P Completion Redirect support does not imply
> +		 *     any particular level of peer-to-peer support by the
> +		 *     Root Complex, or that peer-to-peer traffic is
> +		 *     supported at all"
> +		 */
> +		struct pci_dev *rpdev = dev->bus->self;
> +		struct pci_dev *rppeer = peer->bus->self;

This will oops if rpdev or rppeer is a VF on a "virtual" bus (bus->self
is NULL in that case); see the comment near pci_is_root_bus().

> +		struct pci_dev *common_upstream;
> +		int pos;
> +		u16 cap;
> +
> +		while ((rpdev) && (pci_is_pcie(rpdev)) &&
> +		       (pci_pcie_type(rpdev) != PCI_EXP_TYPE_ROOT_PORT))
> +			rpdev = rpdev->bus->self;

I think we might need some sort of pcie_root_port() function.  We already
have a static pcie_find_root_port() that is basically the same.  And
dmar_find_matched_atsr_unit() does something very similar.  And
ixgbe_io_error_detected().  And myri10ge_enable_ecrc().

> +
> +		while ((rppeer) && (pci_is_pcie(rppeer)) &&
> +		       (pci_pcie_type(rppeer) != PCI_EXP_TYPE_ROOT_PORT))
> +			rppeer = rppeer->bus->self;
> +
> +		common_upstream = pci_find_common_upstream_dev(dev, peer);

This (and the ACS check) logically belongs above the rpdev/rppeer stuff.

> +		/*
> +		 * If ACS is not implemented, we have no idea about P2P
> +		 * support. Optimistically allow this if there is a common
> +		 * upstream device.
> +		 */
> +		pos = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ACS);
> +		if (!pos)
> +			return common_upstream != NULL;
> +
> +		/*
> +		 * If the devices are under the same root port and have a common
> +		 * upstream device, allow if the root port is further upstream
> +		 * from the common upstream device and the common upstream
> +		 * device has Upstream Forwarding disabled, or if the root port
> +		 * is the common upstream device and ACS is not implemented.
> +		 */
> +		pci_read_config_word(rpdev, pos + PCI_ACS_CAP, &cap);
> +		if ((rpdev == rppeer && common_upstream) &&
> +		    (((common_upstream != rpdev) &&
> +		      !pci_acs_enabled(common_upstream, PCI_ACS_UF)) ||
> +		     ((common_upstream == rpdev) && ((cap & PCI_ACS_RR) == 0))))
> +			return true;
> +
> +		/*
> +		 * If ACS RR is implemented and disabled, allow only if the
> +		 * devices are under the same root port.
> +		 */
> +		if (cap & PCI_ACS_RR && !pci_acs_enabled(rpdev, PCI_ACS_RR))
> +			return rpdev == rppeer;
> +
> +		/*
> +		 * If ACS RR is not implemented, or is implemented and enabled,
> +		 * only allow if there's a translation agent enabled to do the
> +		 * redirect.
> +		 */
> +		return iommu_present(&pci_bus_type);
> +	}
> +
> +	return false;
> +}
> +
>  #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
>  static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
>  static DEFINE_SPINLOCK(resource_alignment_lock);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8262b9e..db0cb51 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -824,6 +824,8 @@ void pci_stop_root_bus(struct pci_bus *bus);
>  void pci_remove_root_bus(struct pci_bus *bus);
>  void pci_setup_cardbus(struct pci_bus *bus);
>  void pci_sort_breadthfirst(void);
> +bool pci_peer_traffic_supported(struct pci_dev *dev, struct pci_dev *peer);
> +
>  #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
>  #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
>  #define dev_num_vf(d) ((dev_is_pci(d) ? pci_num_vf(to_pci_dev(d)) : 0))
> @@ -1914,4 +1916,5 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
>  {
>  	return bus->self && bus->self->ari_enabled;
>  }
> +
>  #endif /* LINUX_PCI_H */
> -- 
> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
