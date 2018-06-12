Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbeFLG52 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2018 02:57:28 -0400
Date: Mon, 11 Jun 2018 23:57:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] pci/shpchp: no claim on pcie port device
Message-ID: <20180612065727.GA5195@infradead.org>
References: <1528785733-19442-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528785733-19442-1-git-send-email-kernelfans@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 12, 2018 at 02:42:13PM +0800, Pingfan Liu wrote:
> The Linux Device Driver Model allows a physical device to be handled
> by only a single driver. But at present, both shpchp and portdrv_pci
> claim PCI_CLASS_BRIDGE_PCI, and touch devices_kset. This causes a
> few problems, one is the wrong shutdown seq of devices, owing to the
> broken devices_kset.

How can they both touch devices_kset?  Once one driver has claimed the
device it should not be available to others.

> +	/* do not claim pcie port device */
> +	if (pci_is_pcie(dev) &&
> +	    ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	     (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) ||
> +	     (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)))
> +		return -ENODEV;

No need for the inner braces.
