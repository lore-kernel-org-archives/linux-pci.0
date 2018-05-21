Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 07/40] iommu: Add a page fault handler
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-8-jean-philippe.brucker@arm.com>
 <20180517162555.00002bd3@huawei.com>
Message-ID: <d00405e5-9742-1b24-d6b0-6d389bb815ab@arm.com>
Date: Mon, 21 May 2018 15:48:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180517162555.00002bd3@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: bharatku@xilinx.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, xuzaibo@huawei.com,
 ilias.apalodimas@linaro.org, will.deacon@arm.com,
 iommu@lists.linux-foundation.org, okaya@codeaurora.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, rgummal@xilinx.com, rfranz@cavium.com,
 dwmw2@infradead.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 17/05/18 16:25, Jonathan Cameron wrote:
> On Fri, 11 May 2018 20:06:08 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> Some systems allow devices to handle I/O Page Faults in the core mm. For
>> example systems implementing the PCI PRI extension or Arm SMMU stall
>> model. Infrastructure for reporting these recoverable page faults was
>> recently added to the IOMMU core for SVA virtualisation. Add a page fault
>> handler for host SVA.
>>
>> IOMMU driver can now instantiate several fault workqueues and link them to
>> IOPF-capable devices. Drivers can choose between a single global
>> workqueue, one per IOMMU device, one per low-level fault queue, one per
>> domain, etc.
>>
>> When it receives a fault event, supposedly in an IRQ handler, the IOMMU
>> driver reports the fault using iommu_report_device_fault(), which calls
>> the registered handler. The page fault handler then calls the mm fault
>> handler, and reports either success or failure with iommu_page_response().
>> When the handler succeeded, the IOMMU retries the access.
>>
>> The iopf_param pointer could be embedded into iommu_fault_param. But
>> putting iopf_param into the iommu_param structure allows us not to care
>> about ordering between calls to iopf_queue_add_device() and
>> iommu_register_device_fault_handler().
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Hi Jean-Phillipe,
> 
> One question below on how we would end up with partial faults left when
> doing the queue remove. Code looks fine, but I'm not seeing how that
> would happen without buggy hardware... + we presumably have to rely on
> the hardware timing out on that request or it's dead anyway...

>> +/**
>> + * iopf_queue_remove_device - Remove producer from fault queue
>> + * @dev: device to remove
>> + *
>> + * Caller makes sure that no more fault is reported for this device, and no more
>> + * flush is scheduled for this device.
>> + *
>> + * Note: safe to call unconditionally on a cleanup path, even if the device
>> + * isn't registered to any IOPF queue.
>> + *
>> + * Return 0 if the device was attached to the IOPF queue
>> + */
>> +int iopf_queue_remove_device(struct device *dev)
>> +{
>> +	struct iopf_context *fault, *next;
>> +	struct iopf_device_param *iopf_param;
>> +	struct iommu_param *param = dev->iommu_param;
>> +
>> +	if (!param)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&param->lock);
>> +	iopf_param = param->iopf_param;
>> +	if (iopf_param) {
>> +		refcount_dec(&iopf_param->queue->refs);
>> +		param->iopf_param = NULL;
>> +	}
>> +	mutex_unlock(&param->lock);
>> +	if (!iopf_param)
>> +		return -EINVAL;
>> +
>> +	list_for_each_entry_safe(fault, next, &iopf_param->partial, head)
>> +		kfree(fault);
>> +
> 
> Why would we end up here with partials still in the list?  Buggy hardware?

Buggy hardware is one possibility. There also is the nasty case of PRI
queue overflow. If the PRI queue is full, then the SMMU discards new
Page Requests from the device. It may discard a 'last' PR of a group
that is already in iopf_param->partial. This group will never be freed
until this cleanup.

The spec dismisses PRIq overflows because the OS is supposed to allocate
PRI credits to devices such that they can't send more than the PRI queue
size. This isn't possible in Linux because we don't know exactly how
many PRI-capable devices will share a queue (the upper limit is 2**32,
and devices may be hotplugged well after we allocated the PRI queue). So
PRIq overflow is possible.

Ideally when detecting a PRIq overflow we need to immediately remove all
partial faults of all devices sharing this queue. Since I can't easily
test that case (my device doesn't do PRGs) and it's complicated code, I
left it as TODO in patch 39, and this is our only chance to free
orphaned page requests.

>> +void iopf_queue_free(struct iopf_queue *queue)
>> +{
>> +
> 
> Nitpick : Blank line here doesn't add anything.

Ok

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
