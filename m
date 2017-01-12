Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 12 Jan 2017 14:07:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@linaro.org>
Subject: Re: NVMe vs DMA addressing limitations
Message-ID: <20170112130752.GA14465@lst.de>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170110144839.GB27156@lst.de>
 <80676b35-121b-0462-23fc-ed5608e1e671@grimberg.me>
 <3306663.hKmLLq1hhl@wuerfel>
MIME-Version: 1.0
In-Reply-To: <3306663.hKmLLq1hhl@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Jens Axboe <axboe@fb.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, artemi.ivanov@cogentembedded.com,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 12:56:07PM +0100, Arnd Bergmann wrote:
> That is an interesting question: We actually have the
> "DMA_ATTR_NO_KERNEL_MAPPING" for this case, and ARM implements
> it in the coherent interface, so that might be a good fit.

Yes. my WIP HMB patch uses DMA_ATTR_NO_KERNEL_MAPPING, although I'm
workin on x86 at the moment where it's a no-op.

> Implementing it in the streaming API makes no sense since we
> already have a kernel mapping here, but using a normal allocation
> (possibly with DMA_ATTR_NON_CONSISTENT or DMA_ATTR_SKIP_CPU_SYNC,
> need to check) might help on other architectures that have
> limited amounts of coherent memory and no CMA.

Though about that - but in the end DMA_ATTR_NO_KERNEL_MAPPING implies
those, so instead of using lots of flags in driver I'd rather fix
up more dma_ops implementations to take advantage of
DMA_ATTR_NO_KERNEL_MAPPING.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
