Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org
Cc: joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, liudongdong3@huawei.com,
        shunyong.yang@hxt-semitech.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, jcrouse@codeaurora.org, rfranz@cavium.com,
        dwmw2@infradead.org, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, robdclark@gmail.com,
        christian.koenig@amd.com, bharatku@xilinx.com, rgummal@xilinx.com,
        akpm@linux-foundation.org
Subject: [PATCH v2 11/40] mm: export symbol find_get_task_by_vpid
Date: Fri, 11 May 2018 20:06:12 +0100
Message-Id: <20180511190641.23008-12-jean-philippe.brucker@arm.com>
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Userspace drivers implemented with VFIO might want to bind sub-processes
to their devices. In a VFIO ioctl, they provide a pid that is used to find
a task and its mm. Since VFIO can be built as a module, export the
find_get_task_by_vpid symbol.

Cc: akpm@linux-foundation.org
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

---
Here I didn't add a comment because neighbouring functions that get
exported don't have a comment either, and the name seems fairly clear.
---
 kernel/pid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/pid.c b/kernel/pid.c
index 157fe4b19971..0b6d3201c42d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -355,6 +355,7 @@ struct task_struct *find_get_task_by_vpid(pid_t nr)
 
 	return task;
 }
+EXPORT_SYMBOL_GPL(find_get_task_by_vpid);
 
 struct pid *get_task_pid(struct task_struct *task, enum pid_type type)
 {
-- 
2.17.0

