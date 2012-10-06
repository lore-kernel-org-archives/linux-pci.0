Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Wen Congyang <wency@cn.fujitsu.com>,
	Tang Chen <tangchen@cn.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Hanjun Guo <guohanjun@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Gong Chen <gong.chen@linux.intel.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Bob Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	"Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [RFC PATCH v3 22/28] ACPIHP/processor: protect accesses to device->driver_data
Date: Sat,  6 Oct 2012 23:27:30 +0800
Message-Id: <1349537256-21670-23-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1349537256-21670-1-git-send-email-jiang.liu@huawei.com>
References: <1349537256-21670-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CPU hotplug notification handler acpi_cpu_soft_notify() and driver
unbind method acpi_processor_remove() may be concurrently called.
acpi_cpu_soft_notify() will access device->driver_data, but that
data structure may be destroyed by acpi_processor_remove().

On the other hand, acpi_cpu_soft_notify() is always called under
protection of get_online_cpus(), so use get_online_cpus() to serialize
all accesses and modifications to device->driver_data.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/processor_driver.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 4f2fec0..110c5ac 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -616,6 +616,8 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		return 0;
 	BUG_ON((pr->id >= nr_cpu_ids) || (pr->id < 0));
 
+	/* block CPU online/offline operations */
+	get_online_cpus();
 	result = acpi_processor_link(device, pr);
 	if (result)
 		goto err_unlock;
@@ -624,6 +626,7 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		if (result)
 			goto err_unlink;
 	}
+	put_online_cpus();
 
 	return 0;
 
@@ -654,8 +657,10 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
 			return -EINVAL;
 	}
 
-	acpi_processor_stop(device, pr);
+	get_online_cpus();
+	acpi_processor_stop(pr);
 	acpi_processor_unlink(device, pr);
+	put_online_cpus();
 
 free:
 	device->driver_data = NULL;
-- 
1.7.9.5

