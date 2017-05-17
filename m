Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 17 May 2017 12:10:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <oza.oza@broadcom.com>
Subject: Re: [PATCH v6 1/3] of/pci/dma: fix DMA configuration for PCI masters
Message-ID: <20170517171016.GE31462@bhelgaas-glaptop.roam.corp.google.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
 <1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>,
 linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 bcm-kernel-feedback-list@broadcom.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 16, 2017 at 10:52:05AM +0530, Oza Pawandeep wrote:
> current device framework and OF framework integration assumes

s/current/The current/

> dma-ranges in a way where memory-mapped devices define their
> dma-ranges. (child-bus-address, parent-bus-address, length).
> 
> of_dma_configure is specifically written to take care of memory
> mapped devices. but no implementation exists for pci to take
> care of pcie based memory ranges.

s/pci/PCI/	(also other occurrences below)
s/pcie/PCIe/

I don't see how PCIe is relevant here.  The bridge might support PCIe,
but I don't think anything here is actually specific to PCIe.  If
that's the case, I think it's confusing to mention PCIe.

> for e.g. iproc based SOCs and other SOCs(suc as rcar) have PCI
> world dma-ranges.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
> 
> this patch serves following:
> 
> 1) exposes interface to the pci host driver for their
> inbound memory ranges
> 
> 2) provide an interface to callers such as of_dma_get_ranges.
> so then the returned size get best possible (largest) dma_mask.
> because PCI RC drivers do not call APIs such as
> dma_set_coherent_mask() and hence rather it shows its addressing
> capabilities based on dma-ranges.
> for e.g.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
> we should get dev->coherent_dma_mask=0x7fffffffff.
> 
> 3) this patch handles multiple inbound windows and dma-ranges.
> it is left to the caller, how it wants to use them.
> the new function returns the resources in a standard and unform way
> 
> 4) this way the callers of for e.g. of_dma_get_ranges
> does not need to change.

Please start sentences with a capital letter.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
