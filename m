Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAMo7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Sep 2018 08:44:59 -0400
Date: Sat, 1 Sep 2018 01:33:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 08/16] PCI/ERR: Simplify broadcast callouts
Message-ID: <20180901083346.GB32164@infradead.org>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-9-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-9-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +static int report_forzen_detected(struct pci_dev *dev, void *data)

s/forzen/frozen/ ?

>  static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
> +				pci_ers_result_t result, char *error_mesg,
> +				int (*cb)(struct pci_dev *, void *))
>  {
>  	pci_printk(KERN_DEBUG, dev, "broadcast %s message\n", error_mesg);
> +	pci_walk_bus(dev->subordinate, cb, &result);
> +	return result;
>  }

Is there any point in keeping this helper?
