Return-Path: <SRS0=1op+=4W=bombadil.srs.infradead.org=BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@kernel.org>
Return-Path: <SRS0=1op+=4W=bombadil.srs.infradead.org=BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@kernel.org>
Date: Tue, 16 May 2017 05:11:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, linuxarm@huawei.com,
	linux-pci@vger.kernel.org, lukas@wunner.de,
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH 2/2] PCI/portdrv: allocate MSI/MSIx vector for DPC RP
 service
Message-ID: <20170516121112.GA16209@infradead.org>
References: <1494930342-7132-1-git-send-email-gabriele.paoloni@huawei.com>
 <1494930342-7132-3-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494930342-7132-3-git-send-email-gabriele.paoloni@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

> +		 * pci_irq_vector() below is able to handle entry differently
> +		 * depending on MSI vs MSI-x case
> +		 *

No need to mention that for every users.

Except for that this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
