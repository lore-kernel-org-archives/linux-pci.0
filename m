Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 22 May 2018 09:43:34 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 03/40] iommu/sva: Manage process address spaces
Message-ID: <20180522094334.71f0e36b@jacob-builder>
In-Reply-To: <de478769-9f7a-d40b-a55e-e2c63ad883e8@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-4-jean-philippe.brucker@arm.com>
 <20180516163117.622693ea@jacob-builder>
 <de478769-9f7a-d40b-a55e-e2c63ad883e8@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, jacob.jun.pan@linux.intel.com,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "rgummal@xilinx.com" <rgummal@xilinx.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 17 May 2018 11:02:42 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 17/05/18 00:31, Jacob Pan wrote:
> > On Fri, 11 May 2018 20:06:04 +0100
> > I am a little confused about domain vs. pasid relationship. If
> > each domain represents a address space, should there be a domain for
> > each pasid?  
> 
> I don't think there is a formal definition, but from previous
> discussion the consensus seems to be: domains are a collection of
> devices that have the same virtual address spaces (one or many).
> 
> Keeping that definition makes things easier, in my opinion. Some time
> ago, I did try to represent PASIDs using "subdomains" (introducing a
> hierarchy of struct iommu_domain), but it required invasive changes in
> the IOMMU subsystem and probably all over the tree.
> 
> You do need some kind of "root domain" for each device, so that
> "iommu_get_domain_for_dev()" still makes sense. That root domain
> doesn't have a single address space but a collection of subdomains.
> If you need this anyway, representing a PASID with an iommu_domain
> doesn't seem preferable than using a different structure (io_mm),
> because they don't have anything in common.
> 
My main concern is the PASID table storage. If PASID table storage
is tied to domain, it is ok to scale up, i.e. multiple devices in a
domain share a single PASID table. But to scale down, e.g. further
partition device with VFIO mdev for assignment, each mdev may get its
own domain via vfio. But there is no IOMMU storage for PASID table at
mdev device level. Perhaps we do need root domain or some parent-child
relationship to locate PASID table.

> Thanks,
> Jean

[Jacob Pan]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
