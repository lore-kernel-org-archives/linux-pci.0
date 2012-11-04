Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: "Rafael J . Wysocki" <rjw@sisk.pl>,
	Yinghai Lu <yinghai@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Wen Congyang <wency@cn.fujitsu.com>,
	Tang Chen <tangchen@cn.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Huang Ying <ying.huang@intel.com>,
	Bob Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	"Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <liuj97@gmail.com>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Subject: [ACPIHP PATCH part4 1/9] ACPI/processor: remove dead code from processor_driver.c
Date: Sun,  4 Nov 2012 23:23:54 +0800
Message-Id: <1352042642-7306-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1352042642-7306-1-git-send-email-jiang.liu@huawei.com>
References: <1352042642-7306-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is some dead code in processor_driver.c, so clean it up.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/processor_driver.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index e78c2a5..aa9c43a 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -61,17 +61,11 @@
 
 #define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_DEVICE_NAME	"Processor"
-#define ACPI_PROCESSOR_FILE_INFO	"info"
-#define ACPI_PROCESSOR_FILE_THROTTLING	"throttling"
-#define ACPI_PROCESSOR_FILE_LIMIT	"limit"
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
 #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
 #define ACPI_PROCESSOR_DEVICE_HID	"ACPI0007"
 
-#define ACPI_PROCESSOR_LIMIT_USER	0
-#define ACPI_PROCESSOR_LIMIT_THERMAL	1
-
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_driver");
 
@@ -261,9 +255,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	if (!pr)
 		return -EINVAL;
 
-	if (num_online_cpus() > 1)
-		errata.smp = TRUE;
-
 	acpi_processor_errata(pr);
 
 	/*
-- 
1.7.9.5

