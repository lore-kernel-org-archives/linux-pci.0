Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jphilippe.brucker@gmail.com>
Subject: Re: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
To: Bharat Kumar Gogada <bharatku@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150538FDD455F6042803B54FA5560@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <67e7ad60-3f71-26d8-6ff6-59c95275f0e3@gmail.com>
Date: Thu, 9 Nov 2017 12:13:13 +0000
MIME-Version: 1.0
In-Reply-To: <BLUPR0201MB150538FDD455F6042803B54FA5560@BLUPR0201MB1505.namprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bharat,

On 11/08/2017 05:50 PM, Bharat Kumar Gogada wrote:
> Hi Jean,
> 
> +static struct iommu_process *
> +iommu_process_alloc(struct iommu_domain *domain, struct task_struct
> +*task) {
> +       int err;
> +       int pasid;
> +       struct iommu_process *process;
> +
> +       if (WARN_ON(!domain->ops->process_alloc ||
> !domain->ops->process_free))
> +               return ERR_PTR(-ENODEV);
> +
> +       process = domain->ops->process_alloc(task);
> +       if (IS_ERR(process))
> +               return process;
> +       if (!process)
> +               return ERR_PTR(-ENOMEM);
> +
> +       process->pid            = get_task_pid(task, PIDTYPE_PID);
> +       process->release        = domain->ops->process_free;
> +       INIT_LIST_HEAD(&process->domains);
> +       kref_init(&process->kref);
> +
> +       if (!process->pid) {
> +               err = -EINVAL;
> +               goto err_free_process;
> +       }
> +
> +       idr_preload(GFP_KERNEL);
> +       spin_lock(&iommu_process_lock);
> +       pasid = idr_alloc_cyclic(&iommu_process_idr, process,
> domain->min_pasid,
> +                                domain->max_pasid + 1, GFP_ATOMIC);
> If EP supports only one pasid; domain->min_pasid=1 and domain->max_pasid=0.
> When idr_alloc_cyclic is called it invokes idr_get_free_cmn function
> where we have following condition. (Based on kernel 4.14-rc6)
>         if (!radix_tree_tagged(root, IDR_FREE))
>                 start = max(start, maxindex + 1);
>               if (start > max)
>                 return ERR_PTR(-ENOSPC);
> Here max is being assigned zero by the time this function is invoked,
> this value is based on domain->max_pasid.
> This condition fails and ENOSPC is returned.
>        
> In this case even though hardware supports PASID, BIND flow fails.

It should fail, since we're reserving PASID 0 for non-PASID transactions
with S1DSS=0b10. In addition, the SMMUv3 specification does not allow
using PASID with a single entry. See the description of S1CDMax in 5.2
Stream Table Entry:

"when this field is 0, the substreams of the STE are disabled and one CD
is available. (The minimum useful number of substreams is 2.) Any
transaction with a SubstreamID will be terminated with an abort and a
C_BAD_SUBSTREAMID event recorded."

> Any reason why pasid allocation moved to idr allocations rather than
> bitmap allocations as in v1 patches ?

Yes, idr provides a convenient way to quickly retrieve the context
associated with a PASID, when handling a fault. v1 had the allocation in a
bitmap and storing in a rb-tree. By using an idr we combine both and rely
on a well-tested infrastructure.

Note that in the future we might need to go back to handcrafting the PASID
allocation, but it will probably still be based on idr.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
