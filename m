Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 25 Jul 2016 09:36:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dennis Chen <dennis.chen@arm.com>
Cc: iommu@lists.linux-foundation.org,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [RFC PATCH v3 00/13] ACPI IORT ARM SMMU v3 support
Message-ID: <20160725083641.GA20044@red-moon>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160725055330.GA21004@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160725055330.GA21004@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 25, 2016 at 01:53:32PM +0800, Dennis Chen wrote:
> Hi
> On Wed, Jul 20, 2016 at 12:23:22PM +0100, Lorenzo Pieralisi wrote:
> > This RFC patch series is v3 of a previous posting:
> > 
> > https://lkml.org/lkml/2016/6/7/523
> > 
> > v2 -> v3
> > 	- Rebased on top of dependencies series [1][2][3](v4.7-rc3)
> > 	- Added back reliance on ACPI early probing infrastructure
> > 	- Patch[1-3] merged through other dependent series
> > 	- Added back IOMMU fwnode generalization
> > 	- Move SMMU v3 static functions configuration to IORT code
> > 	- Implemented generic IOMMU fwspec API
> > 	- Added code to implement fwnode platform device look-up
> > 
> > v1 -> v2:
> > 	- Rebased on top of dependencies series [1][2][3](v4.7-rc1)
> > 	- Removed IOMMU fwnode generalization
> > 	- Implemented ARM SMMU v3 ACPI probing instead of ARM SMMU v2
> > 	  owing to patch series dependencies [1]
> > 	- Moved platform device creation logic to IORT code to
> > 	  generalize its usage for ARM SMMU v1-v2-v3 components
> > 	- Removed reliance on ACPI early device probing
> > 	- Created IORT specific iommu_xlate() translation hook leaving
> > 	  OF code unchanged according to v1 reviews
> > 
> > The ACPI IORT table provides information that allows instantiating
> > ARM SMMU devices and carrying out id mappings between components on
> > ARM based systems (devices, IOMMUs, interrupt controllers).
> > 
> > http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
> > 
> > Building on basic IORT support, available through [2]:
> > 
> > this patchset enables ARM SMMU v3 support on ACPI systems.
> > 
> > Most of the code is aimed at building the required generic ACPI
> > infrastructure to create and enable IOMMU components and to bring
> > the IOMMU infrastructure for ACPI on par with DT, which is going to
> > make future ARM SMMU components easier to integrate.
> > 
> > PATCH (1) adds a FWNODE_IOMMU type to the struct fwnode_handle type.
> >           It is required to attach a fwnode identifier to platform
> >           devices allocated/detected through IORT tables entries;
> >           IOMMU devices have to have an identifier to look them up
> >           eg IOMMU core layer carrying out id translation. This can be
> >           done through a fwnode_handle (ie IOMMU platform devices created
> >           out of IORT tables are not ACPI devices hence they can't be
> >           allocated as such, otherwise they would have a fwnode_handle of
> >           type FWNODE_ACPI). This patch requires discussion and it is key
> >           to the RFC.
> > 
> > PATCH (2) makes use of the ACPI early probing API to add a linker script
> >           section for probing devices via IORT ACPI kernel code.
> > 
> > PATCH (3) provides IORT support for registering IOMMU IORT node through
> >           their fwnode handle.
> > 
> > PATCH (4) implements core code fwnode based platform devices look-up.
> > 
> > PATCH (5) extends iommu_fwspec so that it can be used on ACPI based
> >           system by creating a generic IOMMU fwspec kernel layer.
> > 
> > PATCH (6) implements the of_dma_configure() API in ACPI world -
> >           acpi_dma_configure() - and patches PCI and ACPI core code to
> >           start making use of it.
> > 
> > PATCH (7) provides an IORT function to detect existence of specific type
> >           of IORT components.
> > 
> > PATCH (8) creates the kernel infrastructure required to create ARM SMMU
> >           platform devices for IORT nodes.
> > 
> > PATCH (9) refactors the ARM SMMU v3 driver so that the init functions are
> >           split in a way that groups together code that probes through DT
> >           and code that carries out HW registers FW agnostic probing, in
> >           preparation for adding the ACPI probing path.
> > 
> > PATCH (10) rework ARM SMMU v3 platform driver registration to make it work
> >            on ACPI systems.
> > 
> > PATCH (11) Building on patch (8), it adds ARM SMMU v3 IORT IOMMU
> >            operations to create and probe ARM SMMU v3 components.
> > 
> > PATCH (12) Extend the IORT iort_node_map_rid() to work on a type mask
> >            instead of a single type so that the translation API can
> >            be used on a range of components.
> > 
> > PATCH (13) provides IORT infrastructure to carry out IOMMU configuration
> >            for devices and hook it up to the previously introduced ACPI
> >            DMA configure API.
> > 
> > This patchset is built on top and depends on these three patch series:
> > 
> > [1] R.Murphy "Generic DT bindings for PCI and ARM SMMU v3" v4
> >     https://marc.info/?l=devicetree&m=146739193215518&w=2
> > 
> > [2] T.Nowicki "Introduce ACPI world to ITS irqchip" v7
> >     https://marc.info/?l=linux-arm-kernel&m=146642080022289&w=2
> > 
> > [3] T.Nowicki "Support for ARM64 ACPI based PCI host controller" v8
> >     http://marc.info/?l=linux-acpi&m=146462129816292&w=2
> > 
> > and is provided for early review/testing purposes here:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/iort-smmu-v3i
> >
> I thought I can got all the 13 patches applied with the above git
> tree, but I can't find any ACPI related stuff after I cloned the git
> repos to my local machine, am I missing something here?

Have you pulled the acpi/iort-smmu-v3 branch ?

Thanks,
Lorenzo
