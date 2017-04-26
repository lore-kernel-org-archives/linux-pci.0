Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
To: Tomasz Nowicki <tn@semihalf.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-30-jean-philippe.brucker@arm.com>
 <f5745241-83b0-0945-7616-4b59d7ebcd48@semihalf.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c53478ed-20a9-414f-06ef-385c9252556f@arm.com>
Date: Wed, 26 Apr 2017 11:08:17 +0100
MIME-Version: 1.0
In-Reply-To: <f5745241-83b0-0945-7616-4b59d7ebcd48@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Harv Abdulhamid <harba@qti.qualcomm.com>, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 26/04/17 07:53, Tomasz Nowicki wrote:
>> +        mutex_lock(&device->tasks_lock);
>> +        list_for_each_entry(vfio_task, &device->tasks, list) {
>> +            if (vfio_task->pasid != svm.pasid)
>> +                continue;
>> +
>> +            ret = iommu_unbind_task(device->dev, svm.pasid, flags);
>> +            if (ret)
>> +                dev_warn(device->dev, "failed to unbind PASID %u\n",
>> +                     vfio_task->pasid);
>> +
>> +            list_del(&vfio_task->list);
>> +            kfree(vfio_task);
> 
> Please use list_for_each_entry_safe.

There is:

+            break;

right after kfree, so we'd never follow vfio_task->list.next after freeing
vfio_task. The code searches for the _only_ task matching the PASID,
removes it and leaves the loop.

Thanks,
Jean-Philippe


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
