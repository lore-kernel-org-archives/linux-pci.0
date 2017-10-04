Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47840 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbdJDGa3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Oct 2017 02:30:29 -0400
Date: Wed, 4 Oct 2017 08:30:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: Use PCI bus address for data/queues in CMB
Message-ID: <20171004063027.GA20459@lst.de>
References: <1506763722-10687-1-git-send-email-abhishek.shah@broadcom.com> <20171001074203.GA11115@lst.de> <20171002172128.GV8463@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002172128.GV8463@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 02, 2017 at 11:21:29AM -0600, Keith Busch wrote:
> Yah, calling this a DMA address was a misnomer and confusing.

Abhishek, can you test if this works for you?
