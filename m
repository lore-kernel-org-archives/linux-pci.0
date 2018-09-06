Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 04/40] iommu/sva: Add a mm_exit callback for device
 drivers
To: Auger Eric <eric.auger@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-mm@kvack.org
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-5-jean-philippe.brucker@arm.com>
 <d1dc28c4-7742-9c41-3f91-3fbcb8b13c1c@redhat.com>
Message-ID: <27b964dc-68c4-3bb3-288c-166c25864e45@arm.com>
Date: Thu, 6 Sep 2018 12:10:58 +0100
MIME-Version: 1.0
In-Reply-To: <d1dc28c4-7742-9c41-3f91-3fbcb8b13c1c@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: xieyisheng1@huawei.com, ilias.apalodimas@linaro.org, xuzaibo@huawei.com,
 thunder.leizhen@huawei.com, will.deacon@arm.com, okaya@codeaurora.org,
 yi.l.liu@intel.com, ashok.raj@intel.com, tn@semihalf.com, joro@8bytes.org,
 bharatku@xilinx.com, liudongdong3@huawei.com, rfranz@cavium.com,
 kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
 alex.williamson@redhat.com, rgummal@xilinx.com, jonathan.cameron@huawei.com,
 shunyong.yang@hxt-semitech.com, dwmw2@infradead.org, liubo95@huawei.com,
 jcrouse@codeaurora.org, robdclark@gmail.com, robin.murphy@arm.com,
 christian.koenig@amd.com, nwatters@codeaurora.org, baolu.lu@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 05/09/2018 14:23, Auger Eric wrote:
>> + * If the driver intends to share process address spaces, it should pass a valid
>> + * @mm_exit handler. Otherwise @mm_exit can be NULL.
> I don't get case where mm_exit is allowed to be NULL.

Right, this comment is a bit premature. Next version adds a "private
PASID" patch to allocate private address spaces per PASID (modifiable
with map/unmap). That mode doesn't require mm_exit, and I can move the
comment there

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
