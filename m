Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 24 Apr 2018 09:56:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to
 lib/Kconfig
Message-ID: <20180424075645.GA19379@lst.de>
References: <20180423170419.20330-1-hch@lst.de>
 <20180423170419.20330-12-hch@lst.de>
 <20180423235205.GH16141@n2100.armlinux.org.uk>
 <20180424065549.GA18468@lst.de>
 <20180424074726.GI16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20180424074726.GI16141@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-pci@vger.kernel.org, x86@kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 24, 2018 at 08:47:27AM +0100, Russell King - ARM Linux wrote:
> Therefore, the default state for SWIOTLB and hence NEED_SG_DMA_LENGTH
> becomes 'y' on ARM, and any defconfig file that does not mention SWIOTLB
> explicitly ends up with both these enabled.

Indeed, sorry.

> It does look a bit weird though - patch 10 arranged stuff so that we
> didn't end up with SWIOTLB always enabled, but this patch reintroduces
> that with the allowance that the user can disable if so desired.

I am not very happy with that patch, but I have a hard time coming
up with something saner.

Bascially x86_64 and mips/loongson default to SWIOTLB=y but allow to
deselect it, powerpc has it optional without any real dependency
and defaults to n and everyone just selects it otherwise.

I suspect the right thing is to just have it always one for x86_64
and loongson and have a ppc-specific option to enable it on powerpc
so that we can always use select statements.  I'll do that for the
next round.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
