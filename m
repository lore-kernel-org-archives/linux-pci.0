Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52042 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161150AbcFQL1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 07:27:22 -0400
Date: Fri, 17 Jun 2016 13:27:16 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/6] NVMe: Use pci_(request|release)_mem_regions
Message-ID: <20160617112716.74e4hgy5bhkkgmi6@c203.arch.suse.de>
References: <cover.1465200424.git.jthumshirn@suse.de>
 <5c9932602e6d43ef8ad77856c686765f9e63aa9c.1465200424.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5c9932602e6d43ef8ad77856c686765f9e63aa9c.1465200424.git.jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 07, 2016 at 09:44:02AM +0200, Johannes Thumshirn wrote:
> Now that we do have pci_request_mem_regions() and pci_release_mem_regions() at
> hand, use it in the NVMe driver.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: linux-nvme@lists.infradead.org

Bjorn, 

Jens merged a band aid here which conflicts with the patch. Shall I send you
this patch re-based or the entire series?

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
