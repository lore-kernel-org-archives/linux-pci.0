Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <29100eb4-ab8a-a10e-f23b-356658d9a925@codeaurora.org>
Date: Fri, 20 Oct 2017 19:32:47 -0400
MIME-Version: 1.0
In-Reply-To: <20171006133203.22803-2-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

few nits below.

> +/*
> + * Allocate a iommu_process structure for the given task.
> + *
> + * Ideally we shouldn't need the domain parameter, since iommu_process is
> + * system-wide, but we use it to retrieve the driver's allocation ops and a
> + * PASID range.
> + */
> +static struct iommu_process *
> +iommu_process_alloc(struct iommu_domain *domain, struct task_struct *task)
> +{
> +	int err;
> +	int pasid;
> +	struct iommu_process *process;
> +
> +	if (WARN_ON(!domain->ops->process_alloc || !domain->ops->process_free))
> +		return ERR_PTR(-ENODEV);
> +
> +	process = domain->ops->process_alloc(task);
> +	if (IS_ERR(process))
> +		return process;
> +	if (!process)
> +		return ERR_PTR(-ENOMEM);
> +
> +	process->pid		= get_task_pid(task, PIDTYPE_PID);
> +	process->release	= domain->ops->process_free;
> +	INIT_LIST_HEAD(&process->domains);
> +	kref_init(&process->kref);
> +
nit, I think you should place this check right after the pid assignment.

> +	if (!process->pid) {
> +		err = -EINVAL;
> +		goto err_free_process;
> +	}
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&iommu_process_lock);
> +	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
> +				 domain->max_pasid + 1, GFP_ATOMIC);
> +	process->pasid = pasid;
> +	spin_unlock(&iommu_process_lock);
> +	idr_preload_end();
> +

nit, You can maybe return here if pasid is not negative.

> +	if (pasid < 0) {
> +		err = pasid;
> +		goto err_put_pid;
> +	}
> +
> +	return process;
> +
> +err_put_pid:
> +	put_pid(process->pid);
> +
> +err_free_process:
> +	domain->ops->process_free(process);
> +
> +	return ERR_PTR(err);
> +}
> +
> +static void iommu_process_release(struct kref *kref)
> +{
> +	struct iommu_process *process;
> +	void (*release)(struct iommu_process *);
> +
> +	assert_spin_locked(&iommu_process_lock);
> +
> +	process = container_of(kref, struct iommu_process, kref);

if we are concerned about things going wrong (assert above), we should
also add some pointer check here (WARN) for process and release pointers as well.

> +	release = process->release;
> +
> +	WARN_ON(!list_empty(&process->domains));
> +
> +	idr_remove(&iommu_process_idr, process->pasid);
> +	put_pid(process->pid);
> +	release(process);
> +}
> +
> +/*
> + * Returns non-zero if a reference to the process was successfully taken.
> + * Returns zero if the process is being freed and should not be used.
> + */
> +static int iommu_process_get_locked(struct iommu_process *process)
> +{
> +	assert_spin_locked(&iommu_process_lock);
> +
> +	if (process)
> +		return kref_get_unless_zero(&process->kref);
> +
> +	return 0;
> +}
> +
> +static void iommu_process_put_locked(struct iommu_process *process)
> +{
> +	assert_spin_locked(&iommu_process_lock);
> +
> +	kref_put(&process->kref, iommu_process_release);
> +}
> +
> +static int iommu_process_attach(struct iommu_domain *domain, struct device *dev,
> +				struct iommu_process *process)
> +{
> +	int err;
> +	int pasid = process->pasid;
> +	struct iommu_context *context;
> +
> +	if (WARN_ON(!domain->ops->process_attach || !domain->ops->process_detach))
> +		return -ENODEV;
> +
> +	if (pasid > domain->max_pasid || pasid < domain->min_pasid)
> +		return -ENOSPC;
> +
> +	context = kzalloc(sizeof(*context), GFP_KERNEL);
> +	if (!context)
> +		return -ENOMEM;
> +

devm_kzalloc maybe?

> +	context->process	= process;
> +	context->domain		= domain;
> +	refcount_set(&context->ref, 1);
> +
> +	spin_lock(&iommu_process_lock);
> +	err = domain->ops->process_attach(domain, dev, process, true);
> +	if (err) {
> +		kfree(context);
> +		spin_unlock(&iommu_process_lock);
> +		return err;
> +	}
> +
> +	list_add(&context->process_head, &process->domains);
> +	list_add(&context->domain_head, &domain->processes);
> +	spin_unlock(&iommu_process_lock);
> +
> +	return 0;
> +}

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
