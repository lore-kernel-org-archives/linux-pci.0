Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 5 Sep 2018 11:18:35 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, xieyisheng1@huawei.com, liubo95@huawei.com,
        xuzaibo@huawei.com, thunder.leizhen@huawei.com,
        will.deacon@arm.com, okaya@codeaurora.org, yi.l.liu@intel.com,
        ashok.raj@intel.com, tn@semihalf.com, joro@8bytes.org,
        bharatku@xilinx.com, liudongdong3@huawei.com, rfranz@cavium.com,
        kevin.tian@intel.com, jcrouse@codeaurora.org, rgummal@xilinx.com,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        robin.murphy@arm.com, ilias.apalodimas@linaro.org,
        alex.williamson@redhat.com, robdclark@gmail.com,
        dwmw2@infradead.org, christian.koenig@amd.com,
        nwatters@codeaurora.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 03/40] iommu/sva: Manage process address spaces
Message-ID: <20180905111835.7f3ae40e@jacob-builder>
In-Reply-To: <d785ec89-6743-d0f1-1a7f-85599a033e5b@redhat.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
        <20180511190641.23008-4-jean-philippe.brucker@arm.com>
        <d785ec89-6743-d0f1-1a7f-85599a033e5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 5 Sep 2018 14:14:12 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> > + *
> > + * On Arm and AMD IOMMUs, entry 0 of the PASID table can be used
> > to hold
> > + * non-PASID translations. In this case PASID 0 is reserved and
> > entry 0 points
> > + * to the io_pgtable base. On Intel IOMMU, the io_pgtable base
> > would be held in
> > + * the device table and PASID 0 would be available to the
> > allocator.
> > + */  
> very nice explanation
With the new Vt-d 3.0 spec., 2nd level IO page table base is no longer
held in the device context table. Instead it is held in the PASID table
entry pointed by the RID_PASID field in the device context entry. If
RID_PASID = 0, then it is the same as ARM and AMD IOMMUs.
You can refer to ch3.4.3 of the VT-d spec.
