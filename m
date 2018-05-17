Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 17 May 2018 10:00:23 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
Message-ID: <20180517100023.43585c42@jacob-builder>
In-Reply-To: <96c1e0f0-0aa7-badf-123e-cbb1b05e645e@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <20180516134150.34fc8857@jacob-builder>
 <96c1e0f0-0aa7-badf-123e-cbb1b05e645e@arm.com>
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

On Thu, 17 May 2018 11:02:02 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi Jacob,
> 
> Thanks for reviewing this
> 
> On 16/05/18 21:41, Jacob Pan wrote:
>  [...]  
> > seems the min_pasid never gets used. do you really need it?  
> 
> Yes, the SMMU sets it to 1 in patch 28/40, because it needs to reserve
> PASID 0
> 
>  [...]  
> > should it be !features?  
> 
> This checks if the user sets any unsupported bit in features. No
> feature is supported right now, but patch 09/40 adds
> IOMMU_SVA_FEAT_IOPF, and changes this line to "features &
> ~IOMMU_SVA_FEAT_IOPF"
> 
> >> +	mutex_lock(&dev->iommu_param->lock);
> >> +	param = dev->iommu_param->sva_param;
> >> +	dev->iommu_param->sva_param = NULL;
> >> +	mutex_unlock(&dev->iommu_param->lock);
> >> +	if (!param)
> >> +		return -ENODEV;
> >> +
> >> +	if (domain->ops->sva_device_shutdown)
> >> +		domain->ops->sva_device_shutdown(dev, param);  
> > seems a little mismatch here, do you need pass the param. I don't
> > think there is anything else model specific iommu driver need to do
> > for the param.  
> 
> SMMU doesn't use it, but maybe it would remind other IOMMU driver
> which features were enabled, so they don't have to keep track of that
> themselves? I can remove it if it isn't useful
> 
If there is a use case, I guess iommu driver can always retrieve the
param from struct device.
> Thanks,
> Jean

[Jacob Pan]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
