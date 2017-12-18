Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:40424 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbdLRUGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Dec 2017 15:06:52 -0500
Date: Mon, 18 Dec 2017 15:06:49 -0500 (EST)
Message-Id: <20171218.150649.1306487926708532702.davem@davemloft.net>
To: romain.perier@gmail.com
Cc: axboe@kernel.dk, akpm@linux-foundation.org,
        dan.j.williams@intel.com, vinod.koul@intel.com,
        jeffrey.t.kirsher@intel.com, aviad.krawczyk@huawei.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, romain.perier@collabora.com
Subject: Re: [PATCH v16 2/4] net: e100: Replace PCI pool old API
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171215193123.13395-3-romain.perier@gmail.com>
References: <20171215193123.13395-1-romain.perier@gmail.com>
        <20171215193123.13395-3-romain.perier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Romain Perier <romain.perier@gmail.com>
Date: Fri, 15 Dec 2017 20:31:21 +0100

> From: Romain Perier <romain.perier@collabora.com>
> 
> The PCI pool API is deprecated. This commit replaces the PCI pool old
> API by the appropriate function with the DMA pool API.
> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> Acked-by: Peter Senna Tschudin <peter.senna@collabora.com>
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Tested-by: Peter Senna Tschudin <peter.senna@collabora.com>

Acked-by: David S. Miller <davem@davemloft.net>
