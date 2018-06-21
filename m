Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:34552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932521AbeFUH3K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2018 03:29:10 -0400
Date: Thu, 21 Jun 2018 00:29:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH 6/7] PCI/DPC: Use threaded IRQ for bottom half handling
Message-ID: <20180621072909.GC18738@infradead.org>
References: <20180620213833.25072-1-keith.busch@intel.com>
 <20180620213833.25072-6-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620213833.25072-6-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
> +	struct dpc_dev *dpc = (struct dpc_dev *)context;

No need to cast a void pointer.
