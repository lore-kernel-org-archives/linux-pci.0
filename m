Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 9 May 2018 07:03:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: centralize SWIOTLB config symbol and misc other cleanups V3
Message-ID: <20180509050306.GA18336@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
 <20180502124617.GA22001@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20180502124617.GA22001@infradead.org>
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
 sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 02, 2018 at 05:46:17AM -0700, Christoph Hellwig wrote:
> Any more comments?  Especially from the x86, mips and powerpc arch
> maintainers?  I'd like to merge this in a few days as various other
> patches depend on it.

I've pulled it in to make forward progress.  Any additional comments
will have to be sent in the form of incremental patches.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
