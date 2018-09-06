Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 03/40] iommu/sva: Manage process address spaces
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Auger Eric <eric.auger@redhat.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-4-jean-philippe.brucker@arm.com>
 <d785ec89-6743-d0f1-1a7f-85599a033e5b@redhat.com>
 <20180905111835.7f3ae40e@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <574a1792-7ac5-e4db-6eae-16ef700cba02@arm.com>
Date: Thu, 6 Sep 2018 18:40:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180905111835.7f3ae40e@jacob-builder>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
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
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "rgummal@xilinx.com" <rgummal@xilinx.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 05/09/2018 19:18, Jacob Pan wrote:
> On Wed, 5 Sep 2018 14:14:12 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>>> + *
>>> + * On Arm and AMD IOMMUs, entry 0 of the PASID table can be used
>>> to hold
>>> + * non-PASID translations. In this case PASID 0 is reserved and
>>> entry 0 points
>>> + * to the io_pgtable base. On Intel IOMMU, the io_pgtable base
>>> would be held in
>>> + * the device table and PASID 0 would be available to the
>>> allocator.
>>> + */  
>> very nice explanation
> With the new Vt-d 3.0 spec., 2nd level IO page table base is no longer
> held in the device context table. Instead it is held in the PASID table
> entry pointed by the RID_PASID field in the device context entry. If
> RID_PASID = 0, then it is the same as ARM and AMD IOMMUs.
> You can refer to ch3.4.3 of the VT-d spec.

I could simplify that paragraph by removing the specific implementations:

"In some IOMMUs, entry 0 of the PASID table can be used to hold
non-PASID translations. In this case PASID 0 is reserved and entry 0
points to the io_pgtable base. In other IOMMUs the io_pgtable base is
held in the device table and PASID 0 is available to the allocator."

I guess in Linux there isn't any reason to set RID_PASID to a non-zero
value? Otherwise the iommu-sva allocator will need minor changes.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
