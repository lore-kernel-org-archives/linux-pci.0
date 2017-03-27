Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Mar 2017 09:46:21 -0500
Message-ID: <CAL_JsqLtTiH7DhqKf_x7xy1KZYQyiOreK=M90HFr=8BDW9542w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] of/pci: dma-ranges to account highest possible
 host bridge dma_mask
To: Oza Pawandeep <oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 25, 2017 at 12:31 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
> it is possible that PCI device supports 64-bit DMA addressing,
> and thus it's driver sets device's dma_mask to DMA_BIT_MASK(64),
> however PCI host bridge may have limitations on the inbound
> transaction addressing. As an example, consider NVME SSD device
> connected to iproc-PCIe controller.
>
> Currently, the IOMMU DMA ops only considers PCI device dma_mask
> when allocating an IOVA. This is particularly problematic on
> ARM/ARM64 SOCs where the IOMMU (i.e. SMMU) translates IOVA to
> PA for in-bound transactions only after PCI Host has forwarded
> these transactions on SOC IO bus. This means on such ARM/ARM64
> SOCs the IOVA of in-bound transactions has to honor the addressing
> restrictions of the PCI Host.
>
> current pcie frmework and of framework integration assumes dma-ranges
> in a way where memory-mapped devices define their dma-ranges.
> dma-ranges: (child-bus-address, parent-bus-address, length).
>
> but iproc based SOCs and even Rcar based SOCs has PCI world dma-ranges.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;

If you implement a common function, then I expect to see other users
converted to use it. There's also PCI hosts in arch/powerpc that parse
dma-ranges.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
