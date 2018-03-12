Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50509 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbeCLRiR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Mar 2018 13:38:17 -0400
Date: Mon, 12 Mar 2018 11:40:12 -0600
From: Keith Busch <keith.busch@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        netanel@amazon.com, mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
Subject: Re: [pci PATCH v5 1/4] pci: Add pci_sriov_configure_simple for PFs
 that don't manage VF resources
Message-ID: <20180312174012.GE18494@localhost.localdomain>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172031.3487.20651.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180312172031.3487.20651.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:21:29AM -0700, Alexander Duyck wrote:
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 024a1beda008..9cab9d0d51dc 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1953,6 +1953,7 @@ static inline void pci_mmcfg_late_init(void) { }
>  int pci_vfs_assigned(struct pci_dev *dev);
>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
> +int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
>  resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
>  void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
>  #else

I recommend stubbing 'pci_sriov_configure_simple' or defining it to
NULL in the '#else' section here so you don't need to repeat the "#ifdef
CONFIG_PCI_IOV" in each driver wishing to use this function. Otherwise
looks fine to me.
