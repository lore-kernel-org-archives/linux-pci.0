Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
 <1519280641-30258-37-git-send-email-xieyisheng1@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kvm@vger.kernel.org>, <joro@8bytes.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "Lorenzo Pieralisi" <Lorenzo.Pieralisi@arm.com>,
        <hanjun.guo@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <tn@semihalf.com>,
        <liubo95@huawei.com>, <thunder.leizhen@huawei.com>,
        <xuzaibo@huawei.com>, <ilias.apalodimas@linaro.org>,
        <jonathan.cameron@huawei.com>, <shunyong.yang@hxt-semitech.com>,
        <nwatters@codeaurora.org>, <okaya@codeaurora.org>,
        <jcrouse@codeaurora.org>, <rfranz@cavium.com>,
        <dwmw2@infradead.org>, <jacob.jun.pan@linux.intel.com>,
        <yi.l.liu@intel.com>, <ashok.raj@intel.com>, <robdclark@gmail.com>,
        <christian.koenig@amd.com>, <bharatku@xilinx.com>,
        <robh@kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <e3ae1693-0ed8-65e1-352a-07f79038dcbd@huawei.com>
Date: Mon, 19 Mar 2018 17:47:15 +0800
MIME-Version: 1.0
In-Reply-To: <1519280641-30258-37-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

vfio can be compiled as module, however you use some functions which are not
exported.

comment inline:

[...]
> Add two new ioctl for VFIO containers. VFIO_IOMMU_BIND_PROCESS creates a
> bond between a container and a process address space, identified by a
> device-specific ID named PASID. This allows the device to target DMA
> transactions at the process virtual addresses without a need for mapping
> and unmapping buffers explicitly in the IOMMU. The process page tables are
> shared with the IOMMU, and mechanisms such as PCI ATS/PRI are used to
> handle faults. VFIO_IOMMU_UNBIND_PROCESS removes a bond created with
> VFIO_IOMMU_BIND_PROCESS.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
[...]
> +static struct mm_struct *vfio_iommu_get_mm_by_vpid(pid_t vpid)
> +{
> +	struct mm_struct *mm;
> +	struct task_struct *task;
> +
> +	rcu_read_lock();
> +	task = find_task_by_vpid(vpid);

Maybe can use?
	task = pid_task(find_vpid(params.vpid), PIDTYPE_PID)

> +	if (task)
> +		get_task_struct(task);
> +	rcu_read_unlock();
> +	if (!task)
> +		return ERR_PTR(-ESRCH);
> +
> +	/* Ensure that current has RW access on the mm */
> +	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);

You will try to export mm_access, I find Felix have tried to, but seems give up:

 https://patchwork.kernel.org/patch/9744281/

Thanks
Yisheng

