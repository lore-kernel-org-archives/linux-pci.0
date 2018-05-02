Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 2 May 2018 05:46:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: centralize SWIOTLB config symbol and misc other cleanups V3
Message-ID: <20180502124617.GA22001@infradead.org>
References: <20180425051539.1989-1-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, sstabellini@kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Any more comments?  Especially from the x86, mips and powerpc arch
maintainers?  I'd like to merge this in a few days as various other
patches depend on it.

On Wed, Apr 25, 2018 at 07:15:26AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this seris aims for a single defintion of the Kconfig symbol.  To get
> there various cleanups, mostly about config symbols are included as well.
> 
> Changes since V2:
>  - swiotlb doesn't need the dma_length field by itself, so don't select it
>  - don't offer a user visible SWIOTLB choice
> 
> Chages since V1:
>  - fixed a incorrect Reviewed-by that should be a Signed-off-by.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
