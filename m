Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 25 Apr 2018 10:58:20 -0400 (EDT)
Message-Id: <20180425.105820.1294383479112934639.davem@davemloft.net>
To: hch@lst.de
Subject: Re: [PATCH 01/13] iommu-common: move to arch/sparc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180425051539.1989-2-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-2-hch@lst.de>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, sstabellini@kernel.org, konrad.wilk@oracle.com,
 linux-pci@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>
Date: Wed, 25 Apr 2018 07:15:27 +0200

> This code is only used by sparc, and all new iommu drivers should use the
> drivers/iommu/ framework.  Also remove the unused exports.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Acked-by: David S. Miller <davem@davemloft.net>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
