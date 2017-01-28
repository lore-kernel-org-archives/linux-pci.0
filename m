Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 28 Jan 2017 15:06:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH V7 09/11] arm64: dma-mapping: Remove the notifier trick
 to handle early setting of dma_ops
Message-ID: <20170128210611.GF20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-10-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1485188293-20263-10-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org, joro@8bytes.org,
 will.deacon@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 09:48:11PM +0530, Sricharan R wrote:
> With arch_setup_dma_ops now being called late during device's probe after
> the device's iommu is probed, the notifier trick required to handle the
> early setup of dma_ops before the iommu group gets created is not
> required. So removing the notifier's here.

s/notifier's/notifiers/

Personally I'd capitalize "IOMMU" in the English text above, too.

> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [rm: clean up even more]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 132 ++++----------------------------------------
>  1 file changed, 12 insertions(+), 120 deletions(-)

Nice :)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
