Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56718 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbbJUKXL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 06:23:11 -0400
Message-ID: <1445422246.3025.26.camel@kernel.crashing.org>
Subject: Re: [PATCH 09/22] PCI: Add pci_peer_traffic_supported()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Will Davis <wdavis@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
In-Reply-To: <1442337067-22964-10-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
	 <1442337067-22964-10-git-send-email-wdavis@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 21 Oct 2015 21:10:46 +1100
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-09-15 at 12:10 -0500, Will Davis wrote:

> +bool pci_peer_traffic_supported(struct pci_dev *dev, struct pci_dev
> *peer)
> +{
> +> 	> struct pci_host_bridge *dev_host_bridge;
> +> 	> struct pci_host_bridge *peer_host_bridge;
> +
> +> 	> /*
> +> 	>  * Disallow the peer-to-peer traffic if the devices do not share a
> +> 	>  * host bridge. The PCI specifications does not make any guarantees
> +> 	>  * about P2P capabilities between devices under separate domains.
> +> 	>  *
> +> 	>  * PCI Local Bus Specification Revision 3.0, section 3.10:
> +> 	>  *    "Peer-to-peer transactions crossing multiple host bridges
> +> 	>  *     PCI host bridges may, but are not required to, support PCI
> +> 	>  *     peer-to-peer transactions that traverse multiple PCI host
> +> 	>  *     bridges."
> +> 	>  */
> +	dev_host_bridge = pci_find_host_bridge(dev->bus);
> +> 	> peer_host_bridge = pci_find_host_bridge(peer->bus);
> +> 	> if (dev_host_bridge != peer_host_bridge)
> +> 	> 	> return false;

This needs to be platform specific. Some architectures will allow
routing between multiple bridges, some won't.

> +		/*
> +> 	> 	>  * Access Control Services (ACS) Checks
> +> 	> 	>  *
> +> 	> 	>  * ACS has a capability bit for P2P Request Redirects (RR),
> +> 	> 	>  * but unfortunately it doesn't tell us much about the real
> +> 	> 	>  * capabilities of the hardware.
> +> 	> 	>  *
> +> 	> 	>  * PCI Express Base Specification Revision 3.0, section
> +> 	> 	>  * 6.12.1.1:
> +> 	> 	>  *    "ACS P2P Request Redirect: must be implemented by Root
> +> 	> 	>  *     Ports that support peer-to-peer traffic with other
> +> 	> 	>  *     Root Ports; [80]"
> +> 	> 	>  * but
> +> 	> 	>  *    "[80] Root Port indication of ACS P2P Request Redirect
> +> 	> 	>  *     or ACS P2P Completion Redirect support does not imply
> +> 	> 	>  *     any particular level of peer-to-peer support by the
> +> 	> 	>  *     Root Complex, or that peer-to-peer traffic is
> +> 	> 	>  *     supported at all"
> +> 	> 	>  */
> +> 	> 	> struct pci_dev *rpdev = dev->bus->self;
> +> 	> 	> struct pci_dev *rppeer = peer->bus->self;
> +> 	> 	> struct pci_dev *common_upstream;
> +> 	> 	> int pos;
> +> 	> 	> u16 cap;
> +
> +> 	> 	> while ((rpdev) && (pci_is_pcie(rpdev)) &&
> +> 	> 	>        (pci_pcie_type(rpdev) != PCI_EXP_TYPE_ROOT_PORT))
> +> 	> 	> 	> rpdev = rpdev->bus->self;
> +
> +> 	> 	> while ((rppeer) && (pci_is_pcie(rppeer)) &&
> +> 	> 	>        (pci_pcie_type(rppeer) != PCI_EXP_TYPE_ROOT_PORT))
> +> 	> 	> 	> rppeer = rppeer->bus->self;
> +
> +> 	> 	> common_upstream = pci_find_common_upstream_dev(dev, peer);
> +
> +> 	> 	> /*
> +> 	> 	>  * If ACS is not implemented, we have no idea about P2P
> +> 	> 	>  * support. Optimistically allow this if there is a common
> +> 	> 	>  * upstream device.
> +> 	> 	>  */
> +> 	> 	> pos = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ACS);
> +> 	> 	> if (!pos)
> +> 	> 	> 	> return common_upstream != NULL;

We might need a hook as well here. PLX switch may or may not allow it
depending on some configuration bits.

> +		/*
> +> 	> 	>  * If the devices are under the same root port and have a common
> +> 	> 	>  * upstream device, allow if the root port is further upstream
> +> 	> 	>  * from the common upstream device and the common upstream
> +> 	> 	>  * device has Upstream Forwarding disabled, or if the root port
> +> 	> 	>  * is the common upstream device and ACS is not implemented.
> +> 	> 	>  */
> +> 	> 	> pci_read_config_word(rpdev, pos + PCI_ACS_CAP, &cap);
> +> 	> 	> if ((rpdev == rppeer && common_upstream) &&
> +> 	> 	>     (((common_upstream != rpdev) &&
> +> 	> 	>       !pci_acs_enabled(common_upstream, PCI_ACS_UF)) ||
> +> 	> 	>      ((common_upstream == rpdev) && ((cap & PCI_ACS_RR) == 0))))
> +> 	> 	> 	> return true;
> +
> +> 	> 	> /*
> +> 	> 	>  * If ACS RR is implemented and disabled, allow only if the
> +> 	> 	>  * devices are under the same root port.
> +> 	> 	>  */
> +> 	> 	> if (cap & PCI_ACS_RR && !pci_acs_enabled(rpdev, PCI_ACS_RR))
> +> 	> 	> 	> return rpdev == rppeer;
> +
> +> 	> 	> /*
> +> 	> 	>  * If ACS RR is not implemented, or is implemented and enabled,
> +> 	> 	>  * only allow if there's a translation agent enabled to do the
> +> 	> 	>  * redirect.
> +> 	> 	>  */
> +> 	> 	> return iommu_present(&pci_bus_type);
> +> 	> }
> +
> +> 	> return false;
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
>  > 	> return bus->self && bus->self->ari_enabled;
>  }
> +
>  #endif /* LINUX_PCI_H */
