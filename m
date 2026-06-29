Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6D3F54C5
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725264; cv=none; b=F/77QZOahd8vxZ40rsM7NXLAcsDLGH2vEmsqP/BjU5KxiojMk1KKP8JkciLh64YNjb0u+j9mA4+/lJxwIS8B7SYlNUnimurroxDQW/Ch7hYFhuGVrTdUMBxzx38B7GwTBHc3kuWd1pNFK6Sh5nHywaD2LStTrzQtymwq5UbVGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725264; c=relaxed/simple;
	bh=5aaZBDbcve+P+W7KvqNLqSav+Jerjan+Z+bMsKne4gY=;
	h=Message-Id:Mime-Version:Cc:From:Subject:Content-Type:References:
	 To:Date:In-Reply-To; b=sNNm+7mf4I6fqBwSg5AbWSvCINCGRvQBWLQ2GE5NsxckgSxeQO2oOCOW5DcQGUec8yd2gsI87kKufWhmYZoTOeD4wqKeckTqOgS2CQlpSy+ePRnWvu6IdTRV/7nIDqUFJ3H5mm9JrsdtF3qbU1SDKbmbNk7UFj96UgPsCLqDitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=aHTQ62DL; arc=none smtp.client-ip=209.127.231.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="aHTQ62DL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782725252; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=b5BAAAZipvP5JTNHhbmgBrqRLCN09k3e5yoGODZc3Fs=;
 b=aHTQ62DLnokPl1HYYh4WOIIAT6gG+ZcvXgMT72xT11NLLOajZk+REvmHfT+toSwmkwj8l8
 AJhDy8mpt5KvRi8zPh4qBwCGsC6EHwrmrA8P5/kJXs2HoB/YRj2S2B72VeyzqwRwwq43Sn
 jzgu2XItL+flvRCD2DvN6v+EsixTGYuZoRUU6Mcbs+G4tLfVAQ3oedBBFSCAltUukXJwPa
 1yWSRq4uZjuuD4VyJ0CzCuQ26+dj4irjNrdLsLDfEuHWeTjcNoURMi/Mm/ATqcMnYO3cku
 TpJFSvdhdAF0w5aIMPJtllDTX8kBXpYZ2wuGNchqY/eLULVIVedNajg0soZvRw==
Message-Id: <20260629092717.74946-4-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.50.1
Cc: <jingoohan1@gmail.com>, <mani@kernel.org>, <juwenlong@picoheart.com>, 
	<geshijian@picoheart.com>, <yang.yicong@picoheart.com>, 
	<douyufan@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: [PATCH v2 3/3] perf/dwc_pcie: Convert to faux device interface
Content-Type: text/plain; charset=UTF-8
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
To: <xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>, 
	<will@kernel.org>, <mark.rutland@arm.com>, <jic23@kernel.org>, 
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
X-Lms-Return-Path: <lba+26a423a82+adbdd3+vger.kernel.org+yang.yicong@picoheart.com>
Date: Mon, 29 Jun 2026 17:27:17 +0800
In-Reply-To: <20260629092717.74946-1-yang.yicong@picoheart.com>
Received: from G9WYR9K0VW.bytedance.net ([61.141.241.118]) by smtp.feishu.cn with ESMTPS; Mon, 29 Jun 2026 17:27:28 +0800

The DWC PCIe PMU makes use of the platform device interface but
is not the real device, it's actually the RAS DES capability of
the root port. It's more appropriate to use the lightweight
faux framework to abstract this, it'll be more simple and no
need for the complete device and drivers model. So convert to
the faux device interface.

Move the cpuhp state registration prior to faux device creation
since the probe depends on this and will run by the faux device
creation.

No functional changes intended.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
 drivers/perf/dwc_pcie_pmu.c | 101 +++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 53 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 7ec8302d4090..3a9965b5abf4 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -10,6 +10,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
 #include <linux/device.h>
+#include <linux/device/faux.h>
 #include <linux/errno.h>
 #include <linux/hrtimer.h>
 #include <linux/kernel.h>
@@ -17,7 +18,6 @@
 #include <linux/pcie-dwc.h>
 #include <linux/perf_event.h>
 #include <linux/pci.h>
-#include <linux/platform_device.h>
 #include <linux/smp.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -110,9 +110,10 @@ static struct list_head dwc_pcie_dev_info_head =
 static bool notify;
 
 struct dwc_pcie_dev_info {
-	struct platform_device *plat_dev;
+	struct faux_device *fdev;
 	struct pci_dev *pdev;
 	struct list_head dev_node;
+	char *name;
 };
 
 static ssize_t cpumask_show(struct device *dev,
@@ -658,6 +659,12 @@ static void dwc_pcie_unregister_pmu(void *data)
 	perf_pmu_unregister(&pcie_pmu->pmu);
 }
 
+static int dwc_pcie_pmu_probe(struct faux_device *fdev);
+
+static struct faux_device_ops dwc_pcie_faux_ops = {
+	.probe = dwc_pcie_pmu_probe,
+};
+
 static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
 {
 	const struct dwc_pcie_vsec_id *vid;
@@ -684,31 +691,41 @@ static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
 
 static void dwc_pcie_unregister_dev(struct dwc_pcie_dev_info *dev_info)
 {
-	platform_device_unregister(dev_info->plat_dev);
+	faux_device_destroy(dev_info->fdev);
 	list_del(&dev_info->dev_node);
+	kfree(dev_info->name);
 	kfree(dev_info);
 }
 
 static int dwc_pcie_register_dev(struct pci_dev *pdev)
 {
-	struct platform_device *plat_dev;
 	struct dwc_pcie_dev_info *dev_info;
+	struct faux_device *fdev;
+	char *name;
 	u32 sbdf;
 
 	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
-	plat_dev = platform_device_register_simple("dwc_pcie_pmu", sbdf, NULL, 0);
-	if (IS_ERR(plat_dev))
-		return PTR_ERR(plat_dev);
+	name = kasprintf(GFP_KERNEL, "dwc_pcie_pmu_%x", sbdf);
+	if (!name)
+		return -ENOMEM;
+
+	fdev = faux_device_create(name, &pdev->dev, &dwc_pcie_faux_ops);
+	if (!fdev) {
+		kfree(name);
+		return -ENODEV;
+	}
 
 	dev_info = kzalloc_obj(*dev_info);
 	if (!dev_info) {
-		platform_device_unregister(plat_dev);
+		faux_device_destroy(fdev);
+		kfree(name);
 		return -ENOMEM;
 	}
 
-	/* Cache platform device to handle pci device hotplug */
-	dev_info->plat_dev = plat_dev;
+	/* Cache faux device to handle pci device hotplug */
+	dev_info->fdev = fdev;
 	dev_info->pdev = pdev;
+	dev_info->name = name;
 	list_add(&dev_info->dev_node, &dwc_pcie_dev_info_head);
 
 	return 0;
@@ -743,33 +760,25 @@ static struct notifier_block dwc_pcie_pmu_nb = {
 	.notifier_call = dwc_pcie_pmu_notifier,
 };
 
-static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
+static int dwc_pcie_pmu_probe(struct faux_device *fdev)
 {
-	struct pci_dev *pdev;
+	struct pci_dev *pdev = to_pci_dev(fdev->dev.parent);
 	struct dwc_pcie_pmu *pcie_pmu;
 	char *name;
 	u32 sbdf;
 	u16 vsec;
 	int ret;
 
-	sbdf = plat_dev->id;
-	pdev = pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf & 0xffff),
-					   sbdf & 0xff);
-	if (!pdev) {
-		pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
-		return -ENODEV;
-	}
+	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
+	name = devm_kasprintf(&fdev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
+	if (!name)
+		return -ENOMEM;
 
 	vsec = dwc_pcie_des_cap(pdev);
 	if (!vsec)
 		return -ENODEV;
 
-	pci_dev_put(pdev);
-	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
-	if (!name)
-		return -ENOMEM;
-
-	pcie_pmu = devm_kzalloc(&plat_dev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
+	pcie_pmu = devm_kzalloc(&fdev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
 	if (!pcie_pmu)
 		return -ENOMEM;
 
@@ -789,7 +798,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 
 	pcie_pmu->pmu = (struct pmu){
 		.name		= name,
-		.parent		= &plat_dev->dev,
+		.parent		= &fdev->dev,
 		.module		= THIS_MODULE,
 		.attr_groups	= dwc_pcie_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
@@ -811,7 +820,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	}
 
 	/* Unwind when platform driver removes */
-	ret = devm_add_action_or_reset(&plat_dev->dev,
+	ret = devm_add_action_or_reset(&fdev->dev,
 				       dwc_pcie_pmu_remove_cpuhp_instance,
 				       &pcie_pmu->cpuhp_node);
 	if (ret)
@@ -822,7 +831,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 		pci_err(pdev, "Error %d registering PMU @%x\n", ret, sbdf);
 		return ret;
 	}
-	ret = devm_add_action_or_reset(&plat_dev->dev, dwc_pcie_unregister_pmu,
+	ret = devm_add_action_or_reset(&fdev->dev, dwc_pcie_unregister_pmu,
 				       pcie_pmu);
 	if (ret)
 		return ret;
@@ -874,11 +883,6 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
 	return 0;
 }
 
-static struct platform_driver dwc_pcie_pmu_driver = {
-	.probe = dwc_pcie_pmu_probe,
-	.driver = {.name = "dwc_pcie_pmu",},
-};
-
 static void dwc_pcie_cleanup_devices(void)
 {
 	struct dwc_pcie_dev_info *dev_info, *tmp;
@@ -893,6 +897,15 @@ static int __init dwc_pcie_pmu_init(void)
 	struct pci_dev *pdev = NULL;
 	int ret;
 
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/dwc_pcie_pmu:online",
+				      dwc_pcie_pmu_online_cpu,
+				      dwc_pcie_pmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+
+	dwc_pcie_pmu_hp_state = ret;
+
 	for_each_pci_dev(pdev) {
 		if (!dwc_pcie_des_cap(pdev))
 			continue;
@@ -904,32 +917,15 @@ static int __init dwc_pcie_pmu_init(void)
 		}
 	}
 
-	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
-				      "perf/dwc_pcie_pmu:online",
-				      dwc_pcie_pmu_online_cpu,
-				      dwc_pcie_pmu_offline_cpu);
-	if (ret < 0)
-		goto err_cleanup;
-
-	dwc_pcie_pmu_hp_state = ret;
-
-	ret = platform_driver_register(&dwc_pcie_pmu_driver);
-	if (ret)
-		goto err_remove_cpuhp;
-
 	ret = bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
 	if (ret)
-		goto err_unregister_driver;
+		goto err_cleanup;
 	notify = true;
 
 	return 0;
-
-err_unregister_driver:
-	platform_driver_unregister(&dwc_pcie_pmu_driver);
-err_remove_cpuhp:
-	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
 err_cleanup:
 	dwc_pcie_cleanup_devices();
+	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
 	return ret;
 }
 
@@ -938,7 +934,6 @@ static void __exit dwc_pcie_pmu_exit(void)
 	if (notify)
 		bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
 	dwc_pcie_cleanup_devices();
-	platform_driver_unregister(&dwc_pcie_pmu_driver);
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
 }
 
-- 
2.50.1 (Apple Git-155)
