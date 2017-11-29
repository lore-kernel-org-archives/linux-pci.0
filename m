Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932328AbdK2RBh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Nov 2017 12:01:37 -0500
Date: Wed, 29 Nov 2017 11:01:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, rjw@rjwysocki.net,
        tglx@linutronix.de, vidyas@nvidia.com, kthota@nvidia.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V2 5/9] PCI: Export pci_flags
Message-ID: <20171129170133.GC6469@bhelgaas-glaptop.roam.corp.google.com>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
 <1511638333-22951-6-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511638333-22951-6-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo]

On Sun, Nov 26, 2017 at 01:02:09AM +0530, Manikanta Maddireddy wrote:
> pci_flags variable is used in inline functions in 'pci.h', Tegra PCIe
> driver use one of these functions pci_add_flags() and includes 'pci.h'.
> Export pci_flags to allow Tegra PCIe host controller driver to be
> compiled as loadable kernel module.

Here's the usage in tegra_pcie_probe():

  pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);

We've probably had this discussion before, but  I don't know why Tegra
needs PCI_REASSIGN_ALL_RSRC and PCI_REASSIGN_ALL_BUS.

I would prefer to drop this usage of pci_add_flags() if possible.  It
seems to be just an arm/powerpc thing and I'm not convinced it's
really necessary.

> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * commit message update
> 
>  drivers/pci/setup-bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b1ad466199ad..3567e1c4e340 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -29,6 +29,7 @@
>  #include "pci.h"
>  
>  unsigned int pci_flags;
> +EXPORT_SYMBOL(pci_flags);
>  
>  struct pci_dev_resource {
>  	struct list_head list;
> -- 
> 2.1.4
> 
