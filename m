Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 03/40] iommu/sva: Manage process address spaces
To: Auger Eric <eric.auger@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-mm@kvack.org
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-4-jean-philippe.brucker@arm.com>
 <d785ec89-6743-d0f1-1a7f-85599a033e5b@redhat.com>
Message-ID: <ec209a7f-dfc4-c762-3ad8-491eeb8e8744@arm.com>
Date: Thu, 6 Sep 2018 12:10:14 +0100
MIME-Version: 1.0
In-Reply-To: <d785ec89-6743-d0f1-1a7f-85599a033e5b@redhat.com>
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

On 05/09/2018 13:14, Auger Eric wrote:
>> +static struct io_mm *
>> +io_mm_alloc(struct iommu_domain *domain, struct device *dev,
>> +	    struct mm_struct *mm, unsigned long flags)
>> +{
>> +	int ret;
>> +	int pasid;
>> +	struct io_mm *io_mm;
>> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
>> +
> don't you need to check param != NULL and flags are compatible with
> those set at init?

It would be redundant, parameters are already checked by bind().
Following your comment below I think this function should also be called
under iommu_param->lock

>> +	idr_preload(GFP_KERNEL);
>> +	spin_lock(&iommu_sva_lock);
>> +	pasid = idr_alloc(&iommu_pasid_idr, io_mm, param->min_pasid,
>> +			  param->max_pasid + 1, GFP_ATOMIC);
> isn't it param->max_pasid - 1?

max_pasid is the last allocatable PASID, and the 'end' parameter of
idr_alloc is exclusive, so this needs to be max_pasid + 1.

>> +static int io_mm_attach(struct iommu_domain *domain, struct device *dev,
>> +			struct io_mm *io_mm, void *drvdata)
>> +{
>> +	int ret;
>> +	bool attach_domain = true;
>> +	int pasid = io_mm->pasid;
>> +	struct iommu_bond *bond, *tmp;
>> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
>> +
>> +	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
>> +		return -ENODEV;
> don't you need to check param is not NULL?

As mm_alloc, this is called by bind() which already performs argument checks

>> +
>> +	if (pasid > param->max_pasid || pasid < param->min_pasid)
> pasid >= param->max_pasid ?

max_pasid is inclusive

>> +	ret = domain->ops->mm_attach(domain, dev, io_mm, attach_domain);
> the fact the mm_attach/detach() must not sleep may be documented in the
> API doc.

Ok

>>  int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
>>  			    int *pasid, unsigned long flags, void *drvdata)
>>  {
>> -	return -ENOSYS; /* TODO */
>> +	int i, ret = 0;
>> +	struct io_mm *io_mm = NULL;
>> +	struct iommu_domain *domain;
>> +	struct iommu_bond *bond = NULL, *tmp;
>> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
>> +
>> +	domain = iommu_get_domain_for_dev(dev);
>> +	if (!domain)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The device driver does not call sva_device_init/shutdown and
>> +	 * bind/unbind concurrently, so no need to take the param lock.
>> +	 */
> what does guarantee that?

The doc for iommu_sva_bind_device mandates that iommu_sva_device_init()
is called before bind(), but nothing is said about unbind and shutdown.
I think that was just based on the assumption that the device driver
doesn't have any reason to call unbind and shutdown concurrently, but
taking the lock here and in unbind is probably safer.

>> +	ret = io_mm_attach(domain, dev, io_mm, drvdata);
>> +	if (ret)
>> +		io_mm_put(io_mm);
> dont't you want to free the io_mm if just allocated?

We do: if the io_mm has just been allocated, it has a single reference
so io_mm_put frees it.

>> + * @mm_attach: attach io_mm to a device. Install PASID entry if necessary
>> + * @mm_detach: detach io_mm from a device. Remove PASID entry and
>> + *             flush associated TLB entries.
> if necessary too?

Right

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
