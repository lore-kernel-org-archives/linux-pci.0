Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
To: Sinan Kaya <okaya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "liubo95@huawei.com" <liubo95@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <29100eb4-ab8a-a10e-f23b-356658d9a925@codeaurora.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <bc535e79-bb07-70bc-07d2-2c86c9009239@arm.com>
Date: Thu, 2 Nov 2017 16:20:44 +0000
MIME-Version: 1.0
In-Reply-To: <29100eb4-ab8a-a10e-f23b-356658d9a925@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

Sorry for the delay, thanks for reviewing this!

On 21/10/17 00:32, Sinan Kaya wrote:
> few nits below.
> 
>> +/*
>> + * Allocate a iommu_process structure for the given task.
>> + *
>> + * Ideally we shouldn't need the domain parameter, since iommu_process is
>> + * system-wide, but we use it to retrieve the driver's allocation ops and a
>> + * PASID range.
>> + */
>> +static struct iommu_process *
>> +iommu_process_alloc(struct iommu_domain *domain, struct task_struct *task)
>> +{
>> +	int err;
>> +	int pasid;
>> +	struct iommu_process *process;
>> +
>> +	if (WARN_ON(!domain->ops->process_alloc || !domain->ops->process_free))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	process = domain->ops->process_alloc(task);
>> +	if (IS_ERR(process))
>> +		return process;
>> +	if (!process)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	process->pid		= get_task_pid(task, PIDTYPE_PID);
>> +	process->release	= domain->ops->process_free;
>> +	INIT_LIST_HEAD(&process->domains);
>> +	kref_init(&process->kref);
>> +
> nit, I think you should place this check right after the pid assignment.

Sure

>> +	if (!process->pid) {
>> +		err = -EINVAL;
>> +		goto err_free_process;
>> +	}
>> +
>> +	idr_preload(GFP_KERNEL);
>> +	spin_lock(&iommu_process_lock);
>> +	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
>> +				 domain->max_pasid + 1, GFP_ATOMIC);
>> +	process->pasid = pasid;
>> +	spin_unlock(&iommu_process_lock);
>> +	idr_preload_end();
>> +
> 
> nit, You can maybe return here if pasid is not negative.

Ok

>> +	if (pasid < 0) {
>> +		err = pasid;
>> +		goto err_put_pid;
>> +	}
>> +
>> +	return process;
>> +
>> +err_put_pid:
>> +	put_pid(process->pid);
>> +
>> +err_free_process:
>> +	domain->ops->process_free(process);
>> +
>> +	return ERR_PTR(err);
>> +}
>> +
>> +static void iommu_process_release(struct kref *kref)
>> +{
>> +	struct iommu_process *process;
>> +	void (*release)(struct iommu_process *);
>> +
>> +	assert_spin_locked(&iommu_process_lock);
>> +
>> +	process = container_of(kref, struct iommu_process, kref);
> 
> if we are concerned about things going wrong (assert above), we should
> also add some pointer check here (WARN) for process and release pointers as well.

We can probably get rid of this assert, as any external users releasing
the process will have to go through iommu_process_put() which takes the
lock. process_alloc() ensures that release isn't NULL, and process should
always be valid here since we're being called from kref_put, but I should
check the value in process_put.

>> +	release = process->release;
>> +
>> +	WARN_ON(!list_empty(&process->domains));
>> +
>> +	idr_remove(&iommu_process_idr, process->pasid);
>> +	put_pid(process->pid);
>> +	release(process);
>> +}
>> +
>> +/*
>> + * Returns non-zero if a reference to the process was successfully taken.
>> + * Returns zero if the process is being freed and should not be used.
>> + */
>> +static int iommu_process_get_locked(struct iommu_process *process)
>> +{
>> +	assert_spin_locked(&iommu_process_lock);
>> +
>> +	if (process)
>> +		return kref_get_unless_zero(&process->kref);
>> +
>> +	return 0;
>> +}
>> +
>> +static void iommu_process_put_locked(struct iommu_process *process)
>> +{
>> +	assert_spin_locked(&iommu_process_lock);
>> +
>> +	kref_put(&process->kref, iommu_process_release);
>> +}
>> +
>> +static int iommu_process_attach(struct iommu_domain *domain, struct device *dev,
>> +				struct iommu_process *process)
>> +{
>> +	int err;
>> +	int pasid = process->pasid;
>> +	struct iommu_context *context;
>> +
>> +	if (WARN_ON(!domain->ops->process_attach || !domain->ops->process_detach))
>> +		return -ENODEV;
>> +
>> +	if (pasid > domain->max_pasid || pasid < domain->min_pasid)
>> +		return -ENOSPC;
>> +
>> +	context = kzalloc(sizeof(*context), GFP_KERNEL);
>> +	if (!context)
>> +		return -ENOMEM;
>> +
> 
> devm_kzalloc maybe?

I don't think we can ever leak contexts. Before the device is released, it
has to detach() from the domain, which will unbind from any process (call
unbind_dev_all()).

Thanks,
Jean
