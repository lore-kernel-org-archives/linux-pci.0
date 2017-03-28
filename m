Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Sricharan R <sricharan@codeaurora.org>, Robin Murphy
 <robin.murphy@arm.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>
Subject: RE: [PATCH V9 00/11] IOMMU probe deferral support
Date: Tue, 28 Mar 2017 14:15:56 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA81750D76E@lhreml504-mbs>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <58D49845.9060407@hisilicon.com>
 <0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
 <db3d68f8-713c-9ae2-7df9-324bc1b375b1@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA81750CCC4@lhreml504-mbs>
 <f67fb561-4238-6933-04f3-0f910f9232d1@arm.com>
 <8d7ba471-84d4-b9f3-9d2a-de166f6839d4@codeaurora.org>
In-Reply-To: <8d7ba471-84d4-b9f3-9d2a-de166f6839d4@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Sricharan R [mailto:sricharan@codeaurora.org]
> Sent: Tuesday, March 28, 2017 5:54 AM
> To: Robin Murphy; Shameerali Kolothum Thodi; Wangzhou (B);
> will.deacon@arm.com; joro@8bytes.org; lorenzo.pieralisi@arm.com;
> iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> linux-arm-msm@vger.kernel.org; m.szyprowski@samsung.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> acpi@vger.kernel.org; tn@semihalf.com; hanjun.guo@linaro.org;
> okaya@codeaurora.org
> Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
> 
> Hi,
> 
[...]

> >>>  From the logs its clear that  when ixgbevf driver originally probes
> >>> and adds the device  to smmu  the dma mask is 32, but when it binds
> >>> to vfio-pci, it becomes 64 bit.
> >>
> >> Just to add to that, the mask is set to 64 bit in the ixgebvf driver
> >> probe[1]
> >
> > Aha, but of course it's still the same struct device getting bound to
> > VFIO later, so whatever mask the first driver set is still in there
> > when we go through of_dma_configure() the second time (and the fact
> > that we go through more than once being the new behaviour). So yes,
> > this is a legitimate problem and we really do need to be robust
> > against size overflow. I reckon the below tweak of your fix is
> > probably the way to go; cleaning up the arch_setup_dma_ops() interface
> can happen later.
> >
> 
> ok, i will add this fix separately and also the acpi fix that lorenzo has
> suggested in patch #8 in to the series after testing confirmation.
> 
I can confirm that the patches fixes the issues reported here . Both 
DT and ACPI works now.
 
Cheers,
Shameer 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
