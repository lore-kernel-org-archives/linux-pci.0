Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:45970 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeERRVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 May 2018 13:21:31 -0400
Date: Fri, 18 May 2018 11:23:35 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: bhelgaas@google.com, arjan@linux.intel.com, jthumshirn@suse.de,
        ming.lei@redhat.com, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] PCI/sysfs: do not allow enabling/disabling a device with
 a driver
Message-ID: <20180518172335.GB27795@localhost.localdomain>
References: <20180518165624.13993-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518165624.13993-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 06:56:24PM +0200, Christoph Hellwig wrote:
> Manpulating the enable_cnt behind the back of the driver will wreck
> complete havok with the kernel state, so disallow it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice, looks like you beat me to it, and used device locking that I
missed.

Acked-by: Keith Busch <keith.busch@intel.com>

Bjorn,
Please disregard https://marc.info/?l=linux-pci&m=152666267830742&w=2
