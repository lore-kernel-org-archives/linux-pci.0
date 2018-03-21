Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 21 Mar 2018 13:40:13 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
Message-ID: <09ecbaf4-477c-1a06-4f37-523391e5b92e@arm.com>
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
 <1519280641-30258-37-git-send-email-xieyisheng1@huawei.com>
 <e3ae1693-0ed8-65e1-352a-07f79038dcbd@huawei.com>
MIME-Version: 1.0
In-Reply-To: <e3ae1693-0ed8-65e1-352a-07f79038dcbd@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "robh@kernel.org" <robh@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 19/03/18 09:47, Yisheng Xie wrote:
> Hi Jean,
> 
> vfio can be compiled as module, however you use some functions which are not
> exported.

Oh right. I remember the kbuild test robot warning about this once, I
wonder why it didn't find this one.

> comment inline:
> 
> [...]
>> Add two new ioctl for VFIO containers. VFIO_IOMMU_BIND_PROCESS creates a
>> bond between a container and a process address space, identified by a
>> device-specific ID named PASID. This allows the device to target DMA
>> transactions at the process virtual addresses without a need for mapping
>> and unmapping buffers explicitly in the IOMMU. The process page tables are
>> shared with the IOMMU, and mechanisms such as PCI ATS/PRI are used to
>> handle faults. VFIO_IOMMU_UNBIND_PROCESS removes a bond created with
>> VFIO_IOMMU_BIND_PROCESS.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
> [...]
>> +static struct mm_struct *vfio_iommu_get_mm_by_vpid(pid_t vpid)
>> +{
>> +	struct mm_struct *mm;
>> +	struct task_struct *task;
>> +
>> +	rcu_read_lock();
>> +	task = find_task_by_vpid(vpid);
> 
> Maybe can use?
> 	task = pid_task(find_vpid(params.vpid), PIDTYPE_PID)

I'd rather submit a patch requesting to export the symbol. Especially
since this function can be further simplified by using the brand new
find_get_task_by_vpid() helper, introduced by 2ee0826085d1.

>> +	if (task)
>> +		get_task_struct(task);
>> +	rcu_read_unlock();
>> +	if (!task)
>> +		return ERR_PTR(-ESRCH);
>> +
>> +	/* Ensure that current has RW access on the mm */
>> +	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> 
> You will try to export mm_access, I find Felix have tried to, but seems give up:
> 
>  https://patchwork.kernel.org/patch/9744281/

Thanks for the pointer, I'll try to revive this.

Thanks,
Jean


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
