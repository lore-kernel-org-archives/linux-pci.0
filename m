Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Nipun Gupta <nipun.gupta@nxp.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH 0/7 v6] Support for fsl-mc bus and its devices in SMMU
Date: Fri, 31 Aug 2018 11:57:48 +0000
Message-ID: <VI1PR04MB4480D192810E7DEB38895F0AE60F0@VI1PR04MB4480.eurprd04.prod.outlook.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 Bharat Bhushan <bharat.bhushan@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg/Robin,

Can you please let me know when these patches will be applied onto the tree.
Is there anything else pending from my side.

Thanks,
Nipun

> -----Original Message-----
> From: Nipun Gupta
> Sent: Monday, July 9, 2018 4:48 PM
> To: robin.murphy@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> robh@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> gregkh@linuxfoundation.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> bhelgaas@google.com; hch@lst.de
> Cc: joro@8bytes.org; m.szyprowski@samsung.com; shawnguo@kernel.org;
> frowand.list@gmail.com; iommu@lists.linux-foundation.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linux-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>
> Subject: [PATCH 0/7 v6] Support for fsl-mc bus and its devices in SMMU
> 
> This patchset defines IOMMU DT binding for fsl-mc bus and adds
> support in SMMU for fsl-mc bus.
> 
> The patch series is based on top of dma-mapping tree (for-next branch):
> http://git.infradead.org/users/hch/dma-mapping.git
> 
> These patches
>   - Define property 'iommu-map' for fsl-mc bus (patch 1)
>   - Integrates the fsl-mc bus with the SMMU using this
>     IOMMU binding (patch 2,3,4)
>   - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
>   - Updates the fsl-mc device node with iommu/dma related changes (patch 7)
> 
> Changes in v2:
>   - use iommu-map property for fsl-mc bus
>   - rebase over patchset https://patchwork.kernel.org/patch/10317337/
>     and make corresponding changes for dma configuration of devices on
>     fsl-mc bus
> 
> Changes in v3:
>   - move of_map_rid in drivers/of/address.c
> 
> Changes in v4:
>   - move of_map_rid in drivers/of/base.c
> 
> Changes in v5:
>   - break patch 5 in two separate patches (now patch 5/7 and patch 6/7)
>   - add changelog text in patch 3/7 and patch 5/7
>   - typo fix
> 
> Changes in v6:
>   - Updated fsl_mc_device_group() API to be more rational
>   - Added dma-coherent property in the LS2 smmu device node
>   - Minor fixes in the device-tree documentation
> 
> Nipun Gupta (7):
>   Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc
>     bus
>   iommu/of: make of_pci_map_rid() available for other devices too
>   iommu/of: support iommu configuration for fsl-mc devices
>   iommu/arm-smmu: Add support for the fsl-mc bus
>   bus: fsl-mc: support dma configure for devices on fsl-mc bus
>   bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
>   arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
> 
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   7 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 +++-
>  drivers/iommu/arm-smmu.c                           |   7 ++
>  drivers/iommu/iommu.c                              |  13 +++
>  drivers/iommu/of_iommu.c                           |  25 ++++-
>  drivers/of/base.c                                  | 102 +++++++++++++++++++++
>  drivers/of/irq.c                                   |   5 +-
>  drivers/pci/of.c                                   | 101 --------------------
>  include/linux/fsl/mc.h                             |   8 ++
>  include/linux/iommu.h                              |   2 +
>  include/linux/of.h                                 |  11 +++
>  include/linux/of_pci.h                             |  10 --
>  13 files changed, 224 insertions(+), 122 deletions(-)
> 
> --
> 1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
