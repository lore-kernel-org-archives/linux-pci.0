Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 10 Jan 2017 15:48:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@linaro.org>
Subject: Re: NVMe vs DMA addressing limitations
Message-ID: <20170110144839.GB27156@lst.de>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170110070719.GA17208@lst.de>
 <c4fd007c-3f07-fc2a-8cbb-7152f578609d@cogentembedded.com>
 <4137257.d2v87kqLLv@wuerfel>
MIME-Version: 1.0
In-Reply-To: <4137257.d2v87kqLLv@wuerfel>
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

On Tue, Jan 10, 2017 at 12:01:05PM +0100, Arnd Bergmann wrote:
> Another workaround me might need is to limit amount of concurrent DMA
> in the NVMe driver based on some platform quirk. The way that NVMe works,
> it can have very large amounts of data that is concurrently mapped into
> the device.

That's not really just NVMe - other storage and network controllers also
can DMA map giant amounts of memory.  There are a couple aspects to it:

 - dma coherent memoery - right now NVMe doesn't use too much of it,
   but upcoming low-end NVMe controllers will soon start to require
   fairl large amounts of it for the host memory buffer feature that
   allows for DRAM-less controller designs.  As an interesting quirk
   that is memory only used by the PCIe devices, and never accessed
   by the Linux host at all.

 - size vs number of the dynamic mapping.  We probably want the dma_ops
   specify a maximum mapping size for a given device.  As long as we
   can make progress with a few mappings swiotlb / the iommu can just
   fail mapping and the driver will propagate that to the block layer
   that throttles I/O.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
