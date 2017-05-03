Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
References: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 May 2017 14:55:25 -0500
Message-ID: <CAL_JsqLE+CmukEYFnjkYTApGiXZVQn_Xz2GvOshPWLZoaoXvCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] of/pci/dma: fix DMA configuration for PCI masters
To: Oza Pawandeep <oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Oza Pawandeep <oza.pawandeep@gmail.com>,
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

On Tue, May 2, 2017 at 11:46 PM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
> current device framework and of framework integration assumes
> dma-ranges in a way where memory-mapped devices define their
> dma-ranges. (child-bus-address, parent-bus-address, length).
>
> of_dma_configure is specifically written to take care of memory
> mapped devices. but no implementation exists for pci to take
> care of pcie based memory ranges.
>
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
>
> 5) leaves scope of adding PCI flag handling for inbound memory
> by the new function.
>
> Bug: SOC-5216
> Change-Id: Ie045386df91e1e0587846bb147ae40d96f6d7d2e
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-on: http://gerrit-ccxsw.broadcom.net/40428
> Reviewed-by: vpx_checkpatch status <vpx_checkpatch@broadcom.com>
> Reviewed-by: CCXSW <ccxswbuild@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Tested-by: vpx_autobuild status <vpx_autobuild@broadcom.com>
> Tested-by: vpx_smoketest status <vpx_smoketest@broadcom.com>
> Tested-by: CCXSW <ccxswbuild@broadcom.com>

All these non-person, probably internal Broadcom Tested-by and
Reviewed-by's should be removed too.

> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
