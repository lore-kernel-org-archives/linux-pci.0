Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab3GHRIL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Jul 2013 13:08:11 -0400
Message-ID: <1373303240.2602.28.camel@ul30vt.home>
Subject: Re: [PATCH v2 0/2] iommu/intel: Quirk non-compliant PCIe-to-PCI
 bridges
From: Alex Williamson <alex.williamson@redhat.com>
To: iommu@lists.linux-foundation.org
Cc: dwmw2@infradead.org, joro@8bytes.org, stephen@networkplumber.org,
	linux-pci@vger.kernel.org, ddutile@redhat.com
Date: Mon, 08 Jul 2013 11:07:20 -0600
In-Reply-To: <20130528183527.3318.5365.stgit@bling.home>
References: <20130528183527.3318.5365.stgit@bling.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Joerg,

Where do we stand on this series?  You had a concern that the heuristic
used in patch 1/ could be dangerous.  The suggestion for detecting the
issue was actually from Bjorn who replied with his rationale.  Do you
want to go in the direction of a fixed whitelist or do you agree that
even if the heuristic breaks it provides better behavior than what we
have now?  Thanks,

Alex


On Tue, 2013-05-28 at 12:40 -0600, Alex Williamson wrote:
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



