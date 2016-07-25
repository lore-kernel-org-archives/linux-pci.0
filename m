Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34698 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbcGYP4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jul 2016 11:56:22 -0400
Date: Mon, 25 Jul 2016 16:56:21 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sinan Kaya <okaya@codeaurora.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>
Subject: Re: [RFC PATCH v3 05/13] drivers: iommu: make iommu_fwspec OF
 agnostic
Message-ID: <20160725155620.GB28507@red-moon>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1469013815-24380-6-git-send-email-lorenzo.pieralisi@arm.com>
 <1499f802-5f98-b0c0-d3aa-dabcac81e84e@arm.com>
 <CAL_JsqKc4aJ1xiJAS6HRKeVO8mrZWpBF0uugvmCgNuUamJF=Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqKc4aJ1xiJAS6HRKeVO8mrZWpBF0uugvmCgNuUamJF=Eg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 25, 2016 at 10:21:10AM -0500, Rob Herring wrote:
> On Mon, Jul 25, 2016 at 10:09 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> > Hi Lorenzo,
> >
> > On 20/07/16 12:23, Lorenzo Pieralisi wrote:
> >> The iommu_fwspec structure, used to hold per device iommu configuration
> >> data is not OF specific and therefore can be moved to a generic
> >> and OF independent compilation unit.
> >>
> >> In particular, the iommu_fwspec handling hinges on the device_node
> >> pointer to identify the IOMMU device associated with the iommu_fwspec
> >> structure, that is easily converted to a more generic fwnode_handle
> >> pointer that can cater for OF and non-OF (ie ACPI) systems.
> >>
> >> Create the files and related Kconfig entry to decouple iommu_fwspec
> >> structure from the OF iommu kernel layer.
> >>
> >> Given that the current iommu_fwspec implementation relies on
> >> the arch specific struct device.archdata.iommu field in its
> >> implementation, by making the code standalone and independent
> >> of the OF layer this patch makes sure that the iommu_fwspec
> >> kernel code can be selected only on arches implementing the
> >> struct device.archdata.iommu field by adding an explicit
> >> arch dependency in its config entry.
> >>
> >> Current drivers using the iommu_fwspec for streamid translation
> >> are converted to the new iommu_fwspec API by simply converting
> >> the device_node to its fwnode_handle pointer.
> >>
> >> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> >> Cc: Robin Murphy <robin.murphy@arm.com>
> >> Cc: Joerg Roedel <joro@8bytes.org>
> >> ---
> >>  drivers/iommu/Kconfig        |   4 ++
> >>  drivers/iommu/Makefile       |   1 +
> >>  drivers/iommu/arm-smmu-v3.c  |  13 +++--
> >>  drivers/iommu/iommu-fwspec.c | 114 +++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/iommu/of_iommu.c     |  52 --------------------
> >>  include/linux/iommu-fwspec.h |  60 +++++++++++++++++++++++
> >>  include/linux/of_iommu.h     |  24 +++------
> >>  7 files changed, 196 insertions(+), 72 deletions(-)
> >>  create mode 100644 drivers/iommu/iommu-fwspec.c
> >>  create mode 100644 include/linux/iommu-fwspec.h
> >>
> >> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> >> index d1c66af..2b26bfb 100644
> >> --- a/drivers/iommu/Kconfig
> >> +++ b/drivers/iommu/Kconfig
> >> @@ -67,6 +67,10 @@ config OF_IOMMU
> >>         def_bool y
> >>         depends on OF && IOMMU_API
> >>
> >> +config IOMMU_FWSPEC
> >> +       def_bool y
> >> +       depends on ARM64 && IOMMU_API
> >
> > I think that could be at least (ARM || ARM64).
> 
> Why any arch dependency?
> 
> Seems like OF_IOMMU (and ACPI?) should select this.

Absolutely, that's the end goal. Current issue is that the iommu_fwspec
mechanism relies on dev_archdata.iommu pointer internally to work and
since that's arch specific I can't select it on arches that do not have
that field, it would break the compilation.

I will follow up with Robin to make sure we will be able to
implement what you request above.

Thanks !
Lorenzo
