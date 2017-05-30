Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 30 May 2017 11:27:59 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v5 1/5] iommu: of: Fix check for returning EPROBE_DEFER
Message-ID: <20170530092759.GC2818@8bytes.org>
References: <1495544493-14219-1-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1495544493-14219-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
 laurent.pinchart@ideasonboard.com, frowand.list@gmail.com,
 m.szyprowski@samsung.com, linux-arch@vger.kernel.org,
 lorenzo.pieralisi@arm.com, tn@semihalf.com, magnus.damm@gmail.com,
 linux-acpi@vger.kernel.org, geert@linux-m68k.org, linux-pci@vger.kernel.org,
 lenb@kernel.org, devicetree@vger.kernel.org, arnd@arndb.de,
 linux-arm-msm@vger.kernel.org, j.neuschaefer@gmx.net, robh+dt@kernel.org,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 06:31:29PM +0530, Sricharan R wrote:
> Now with IOMMU probe deferral, we return -EPROBE_DEFER
> for masters that are connected to an IOMMU which is not
> probed yet, but going to get probed, so that we can attach
> the correct dma_ops. So while trying to defer the probe of
> the master, check if the of_iommu node that it is connected
> to is marked in DT as 'status=disabled', then the IOMMU is never
> is going to get probed. So simply return NULL and let the master
> work without an IOMMU.
> 
> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Magnus Damn <magnus.damn@gmail.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

Applied all to iommu/fixes, thanks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
