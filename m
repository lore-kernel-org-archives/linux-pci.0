Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 4 Nov 2015 15:30:29 +0000
From: Will Deacon <will.deacon@arm.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Magnus <magnus.damm@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: PCIe host controller behind IOMMU on ARM
Message-ID: <20151104153028.GR5405@arm.com>
References: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151104142412.GS963@e106497-lin.cambridge.arm.com>
 <PS1PR06MB11804263DD55C54C5987654EF52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151104150147.GT963@e106497-lin.cambridge.arm.com>
 <PS1PR06MB11804C3D0155E3EFB5C43C47F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <PS1PR06MB11804C3D0155E3EFB5C43C47F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 04, 2015 at 03:19:13PM +0000, Phil Edworthy wrote:
> On 04 November 2015 15:02, Liviu wrote:
> > On Wed, Nov 04, 2015 at 02:48:38PM +0000, Phil Edworthy wrote:
> > > Sure, though since this is bog standard Intel PCIe ethernet card which works
> > > fine when the IOMMU is effectively unused, I don’t think there is a problem
> > > with that.
> > >
> > > The driver for the PCIe controller sets up the IOMMU mapping ok when I
> > > do a test call to dma_alloc_coherent() in the controller's driver. i.e. when I
> > > do this, it ends up in arm_iommu_alloc_attrs(), which calls
> > > __iommu_alloc_buffer() and __alloc_iova().
> > >
> > > When an endpoint driver allocates and maps a dma coherent buffer it
> > > also needs to end up in arm_iommu_alloc_attrs(), but it doesn't.
> > 
> > Why do you think that? Remember that the only thing attached to the IOMMU is
> > the
> > host controller. The endpoint is on the PCIe bus, which gets a different
> > translation
> > that the IOMMU knows nothing about. If it helps you to visualise it better, think
> > of the host controller as another IOMMU device. It's the ops of the host
> > controller
> > that should be invoked, not the IOMMU's.
> Ok, that makes sense. I'll have a think and poke it a bit more...

Take a look at of_iommu_configure, which is currently lacking support
for PCI devices. It should be using a variant on the device-tree bindings
already in use for describing MSI device IDs, so that we can translate
the RequesterID of the endpoint into an ID that the IOMMU can understand.

Will
