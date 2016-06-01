Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45808 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbcFAH6P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 03:58:15 -0400
Date: Wed, 1 Jun 2016 00:58:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] NVMe: Use pci_(request|release)_mem_regions
Message-ID: <20160601075813.GB11923@infradead.org>
References: <cover.1464694724.git.jthumshirn@suse.de>
 <1c28b653e543d25754e39f6294ab044ce73b2107.1464694724.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1c28b653e543d25754e39f6294ab044ce73b2107.1464694724.git.jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
