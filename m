Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
 <1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 May 2017 21:13:38 +0200
Message-ID: <CAK8P3a3hoeCET5Z+KUJDCHgGEJUmLF49bDozEE0ra5jcbjvoXQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] of/pci/dma: fix DMA configuration for PCI masters
To: Oza Pawandeep <oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>,
 linux-pci <linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 16, 2017 at 7:22 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
> current device framework and OF framework integration assumes
> dma-ranges in a way where memory-mapped devices define their
> dma-ranges. (child-bus-address, parent-bus-address, length).
>
> of_dma_configure is specifically written to take care of memory
> mapped devices. but no implementation exists for pci to take
> care of pcie based memory ranges.

Hi Oza,

I'm trying to make sense of this, but am still rather puzzled. I have
no idea what the distinction between memory-mapped devices and
pcie based devices is in your description, as PCIe is usually memory
mapped, and Linux doesn't actually support other kinds of PCIe
devices on most architectures.

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
>
> for e.g.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
> we should get dev->coherent_dma_mask=0x7fffffffff.

do you mean the coherent_dma_mask of the PCI host bridge
or an attached device here?

If you require PCI devices to come up with an initial
coherent_dma_mask other than 0xffffffffff, there are other
problems involved. In particular, you will need to use
swiotlb, which is not supported on arm32 at the moment,
and the dma_set_mask()/dma_set_coherent_mask()
functions need to be modified.

> +       while (1) {
> +               dma_ranges = of_get_property(node, "dma-ranges", &rlen);
> +
> +               /* Ignore empty ranges, they imply no translation required. */
> +               if (dma_ranges && rlen > 0)
> +                       break;
> +
> +               /* no dma-ranges, they imply no translation required. */
> +               if (!dma_ranges)
> +                       break;

A missing parent dma-ranges property here should really indicate that there
is no valid translation. If we have existing cases where this happens
in DT files, we may treat it as allowing only 32-bit DMA (as we already
do for having no dma-ranges at all), but treating it the same way
as an empty dma-ranges property sounds wrong.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
