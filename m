Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAMmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Sep 2018 08:42:38 -0400
Date: Sat, 1 Sep 2018 01:31:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 05/16] PCI/ERR: Handle fatal error recovery
Message-ID: <20180901083121.GA32164@infradead.org>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-6-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-6-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
> +{
> +	pcie_do_recovery(dev, pci_channel_io_frozen, service);
> +}
> +
> +void pcie_do_nonfatal_recovery(struct pci_dev *dev)
> +{
> +	pcie_do_recovery(dev, pci_channel_io_normal, PCIE_PORT_SERVICE_AER);
> +}

Is there any good reason to not just expose pcie_do_recovery
directly and skip these wrappers?
