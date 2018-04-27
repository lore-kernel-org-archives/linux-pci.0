Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 27 Apr 2018 12:20:16 -0500
From: Rob Herring <robh@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Subject: Re: [PATCH 1/6 v3] Docs: dt: add fsl-mc iommu-map device-tree binding
Message-ID: <20180427172016.phpsjiique25impv@rob-hp-laptop>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-2-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
In-Reply-To: <1524824826-29473-2-git-send-email-nipun.gupta@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bharat.bhushan@nxp.com,
 stuyoder@gmail.com, frowand.list@gmail.com, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, joro@8bytes.org, linuxppc-dev@lists.ozlabs.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com, bhelgaas@google.com,
 shawnguo@kernel.org, laurentiu.tudor@nxp.com, robin.murphy@arm.com, hch@lst.de,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:57:01PM +0530, Nipun Gupta wrote:
> The existing IOMMU bindings cannot be used to specify the relationship
> between fsl-mc devices and IOMMUs. This patch adds a generic binding for
> mapping fsl-mc devices to IOMMUs, using iommu-map property.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
