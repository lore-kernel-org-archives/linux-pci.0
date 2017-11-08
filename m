Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
Date: Wed, 8 Nov 2017 17:50:40 +0000
Message-ID: <BLUPR0201MB150538FDD455F6042803B54FA5560@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

+static struct iommu_process *
+iommu_process_alloc(struct iommu_domain *domain, struct task_struct 
+*task) {
+	int err;
+	int pasid;
+	struct iommu_process *process;
+
+	if (WARN_ON(!domain->ops->process_alloc || !domain->ops->process_free))
+		return ERR_PTR(-ENODEV);
+
+	process = domain->ops->process_alloc(task);
+	if (IS_ERR(process))
+		return process;
+	if (!process)
+		return ERR_PTR(-ENOMEM);
+
+	process->pid		= get_task_pid(task, PIDTYPE_PID);
+	process->release	= domain->ops->process_free;
+	INIT_LIST_HEAD(&process->domains);
+	kref_init(&process->kref);
+
+	if (!process->pid) {
+		err = -EINVAL;
+		goto err_free_process;
+	}
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&iommu_process_lock);
+	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
+				 domain->max_pasid + 1, GFP_ATOMIC);
If EP supports only one pasid; domain->min_pasid=1 and domain->max_pasid=0.
When idr_alloc_cyclic is called it invokes idr_get_free_cmn function where we have following condition. (Based on kernel 4.14-rc6)
	if (!radix_tree_tagged(root, IDR_FREE)) 
                start = max(start, maxindex + 1);
              if (start > max) 
		return ERR_PTR(-ENOSPC);
Here max is being assigned zero by the time this function is invoked, this value is based on domain->max_pasid.
This condition fails and ENOSPC is returned.
	
In this case even though hardware supports PASID, BIND flow fails.
Any reason why pasid allocation moved to idr allocations rather than bitmap allocations as in v1 patches ?

+	process->pasid = pasid;

Regards,
Bharat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
