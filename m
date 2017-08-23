Return-Path: <SRS0=K6gr=7Z=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=K6gr=7Z=davemloft.net=davem@kernel.org>
Date: Wed, 23 Aug 2017 11:47:05 -0700 (PDT)
Message-Id: <20170823.114705.2104676201534244497.davem@davemloft.net>
To: hch@lst.de
Cc: helgaas@kernel.org, mroos@linux.ee, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/msi: don't warn on irq_create_affinity_masks NULL
 return
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170823115459.2058-1-hch@lst.de>
References: <20170823115459.2058-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>
Date: Wed, 23 Aug 2017 13:54:59 +0200

> irq_create_affinity_masks can easily return NULL when there are not
> enough "free" vectors available to spread, while the memory allocation
> failure for the CPU masks not only is unlikely, but also relatively
> harmless as the system will work just fine except for non-optimally
> spread vectors.  Thus remove the warnings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
