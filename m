Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:33333 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbdGJTMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2017 15:12:03 -0400
Received: by mail-wr0-f175.google.com with SMTP id r103so151623819wrb.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Jul 2017 12:12:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170630052436.15212-1-aik@ozlabs.ru>
References: <20170630052436.15212-1-aik@ozlabs.ru>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Jul 2017 14:11:41 -0500
Message-ID: <CAErSpo5kv+oPKt6=czZiJE5XUG8soZMuqrwsDXgRYOaznVdxzg@mail.gmail.com>
Subject: Re: [PATCH kernel v4 0/6] vfio-pci: Add support for mmapping MSI-X table
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        Yongji Xie <elohimes@gmail.com>,
        Eric Auger <eric.auger@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Fri, Jun 30, 2017 at 12:24 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> Here is a patchset which Yongji was working on before
> leaving IBM LTC. Since we still want to have this functionality
> in the kernel (DPDK is the first user), here is a rebase
> on the current upstream.
>
>
> Current vfio-pci implementation disallows to mmap the page
> containing MSI-X table in case that users can write directly
> to MSI-X table and generate an incorrect MSIs.
>
> However, this will cause some performance issue when there
> are some critical device registers in the same page as the
> MSI-X table. We have to handle the mmio access to these
> registers in QEMU emulation rather than in guest.
>
> To solve this issue, this series allows to expose MSI-X table
> to userspace when hardware enables the capability of interrupt
> remapping which can ensure that a given PCI device can only
> shoot the MSIs assigned for it. And we introduce a new bus_flags
> PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
> for different archs.
>
>
> This is based on sha1
> 3c2bfbaadff6 Linus Torvalds "Merge branch 'fixes' of git://git.armlinux.org.uk/~rmk/linux-arm".
>
> Please comment. Thanks.
>
> Changes:
> v4:
> * rebased on recent upstream
> * got all 6 patches from v2 (v3 was missing some)
>
>
> Alexey Kardashevskiy (1):
>   PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller enables IRQ
>     remapping
>
> Yongji Xie (5):
>   PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
>   PCI: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ
>     remapping
>   iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu driver initialization
>   pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
>   vfio-pci: Allow to expose MSI-X table to userspace if interrupt
>     remapping is enabled
>
>  include/linux/pci.h                       |  1 +
>  arch/powerpc/platforms/powernv/pci-ioda.c |  7 +++++++
>  drivers/iommu/iommu.c                     |  8 ++++++++
>  drivers/pci/probe.c                       |  8 ++++++++
>  drivers/vfio/pci/vfio_pci.c               | 17 ++++++++++++++---
>  drivers/vfio/pci/vfio_pci_rdwr.c          |  3 ++-
>  6 files changed, 40 insertions(+), 4 deletions(-)

Since this modifies drivers/pci/probe.c, it should be posted to
linux-pci@vger.kernel.org.
