Return-Path: <SRS0=QSaZ=2P=arm.com=jean-philippe.brucker@kernel.org>
Return-Path: <SRS0=QSaZ=2P=arm.com=jean-philippe.brucker@kernel.org>
Date: Mon, 6 Mar 2017 11:29:28 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Sinan Kaya <okaya@qti.qualcomm.com>,
	Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org,
	Harv Abdulhamid <harba@qti.qualcomm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	Nate Watterson <nwatters@qti.qualcomm.com>
Subject: Re: [RFC PATCH 03/30] PCI: Move ATS declarations outside of
 CONFIG_PCI
Message-ID: <20170306112928.GB28804@e106794-lin.localdomain>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-4-jean-philippe.brucker@arm.com>
 <20170303210926.GB31767@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170303210926.GB31767@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 03/03/17 21:09, Bjorn Helgaas wrote:
> On Mon, Feb 27, 2017 at 07:54:14PM +0000, Jean-Philippe Brucker wrote:
>> Currently ATS helpers like pci_enable_ats are only defined when CONFIG_PCI
>> is enabled. The ARM SMMU driver might get built with CONFIG_PCI disabled.
>> It would thus have to wrap any use of ATS helpers around #ifdef
>> CONFIG_PCI, which isn't ideal.
>>
>> A nicer solution is to always define these helpers. Since CONFIG_PCI_ATS
>> is only enabled in association with CONFIG_PCI, move defines outside of
>> CONFIG_PCI to prevent build failure when PCI is disabled.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> I don't think there's any reason to make a pci_ats_init() stub when
> CONFIG_PCI is not enabled, because it's only called from the PCI core.
> But it does make some sense to keep them all together in one place.
> 
> I think you could also remove the #ifdef CONFIG_PCI_ATS in
> arm_smmu_enable_ats() ("[RFC PATCH 04/30] iommu/arm-smmu-v3: Add
> support for PCI ATS"), right?
> 
> If you remove the #ifdef, we'll call pci_enable_ats(), and it will
> fail if !pdev->ats_cap.

I wanted to display something when ATS is supported and enable fails.
But this method is ugly and device drivers can check whether ATS is
enabled, so I'll remove the #ifdef and the error message in patch 4.

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
Jean-Philippe
