Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35391 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759025Ab3E1WKK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 18:10:10 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so1685904obb.25
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2013 15:10:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130528183527.3318.5365.stgit@bling.home>
References: <20130528183527.3318.5365.stgit@bling.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 May 2013 16:09:49 -0600
Message-ID: <CAErSpo4rjifYfC_4vcs2g-Pb-LR_n2NB6e5en3=CSWgW4iQcJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iommu/intel: Quirk non-compliant PCIe-to-PCI bridges
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 28, 2013 at 12:40 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> This series tries to address:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=44881
>
> Where pci_find_upstream_pcie_bridge() gets lost trying to find the
> upstream PCIe-to-PCI bridge for a device because the bridge doesn't
> expose a PCIe capability.  To do this, we add a iommu_pci_is_pcie_bridge
> function which includes a quirk to look to the next upstream device
> as a sanity check.  We can then replace pci_find_upstream_pcie_bridge
> with a function that's a bit more generic and less tied to intel-iommu
> eccentricities.
>
> v2 uses the same logic as v1, but moves the search and match code to
> IOMMU-core since PCI-core doesn't want it.  v1 has several reports
> from users that this solves the problem they have in the above bz.
> Thanks,
>
> Alex
>
> ---
>
> Alex Williamson (2):
>       iommu: Quirked PCIe bridge test and search function
>       intel-iommu: Convert to iommu_pci_find_upstream + iommu_pci_is_pcie_bridge
>
>
>  drivers/iommu/Kconfig               |    5 ++
>  drivers/iommu/Makefile              |    1
>  drivers/iommu/intel-iommu.c         |   77 ++++++++++++++++++++++-------------
>  drivers/iommu/intel_irq_remapping.c |   15 +++++--
>  drivers/iommu/pci.c                 |   69 +++++++++++++++++++++++++++++++
>  drivers/iommu/pci.h                 |   23 ++++++++++
>  6 files changed, 157 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/iommu/pci.c

These both look OK to me, for whatever that's worth (since they don't
touch drivers/pci any more :)).

I assume you probably removed the only users of
pci_find_upstream_pcie_bridge(), right?  If so, and you want to remove
that in this same series, you can add my Acked-by to that.

Bjorn
