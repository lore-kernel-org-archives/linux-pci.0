Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63073 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751560AbdJaL20 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Oct 2017 07:28:26 -0400
Date: Tue, 31 Oct 2017 17:01:30 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Romain Perier <romain.perier@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH v14 2/5] dmaengine: pch_dma: Replace PCI pool old API
Message-ID: <20171031113129.GO3187@localhost>
References: <20171023175958.8327-1-romain.perier@gmail.com>
 <20171023175958.8327-3-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171023175958.8327-3-romain.perier@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 23, 2017 at 07:59:55PM +0200, Romain Perier wrote:
> From: Romain Perier <romain.perier@collabora.com>
> 
> The PCI pool API is deprecated. This commit replaces the PCI pool old
> API by the appropriate function with the DMA pool API.

Applied, thanks

-- 
~Vinod
