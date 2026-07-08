Received: from va-2-29.ptr.blmpb.com (va-2-29.ptr.blmpb.com [209.127.231.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E913403EB5
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500335; cv=none; b=BItRYQ9Vl0MIBdeF1mjSHsul37BgmzlcdyVzsqjKKcUkGj7Oq68WNfxGqNHLpdjdz/3pMVfDsmeg2DrAtlzxCEskuG0KmHBquP+EITDrXzROHHkKc7CFSV4exmmSEcSJXznMNFlZ1+84OsbfHWS7ZdVTQ825Mi4dCU03GNS2eOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500335; c=relaxed/simple;
	bh=HZvNcotclggEvLRkJ2aSKqtjfwjjyNTkcCY3X6o/ZD4=;
	h=References:Message-Id:Mime-Version:From:In-Reply-To:Content-Type:
	 To:Cc:Subject:Date; b=XJOuFHMbUaiwvv2SRntbwOJue2GR6HGIwLO4+COyXNhgwo1VbHw9jlWfwu7c2UUSlXLb5f9PGMLjHaMT0Sru1G8M3lmkz+xeNbU7QuzGn59veVfgnqjSH7oDNZYewe3+BJAfYxrODcwr6ytUZ9sRI0CQehIUsQWyrTL8R2DN3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=uMmgksjx; arc=none smtp.client-ip=209.127.231.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="uMmgksjx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1783500324; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4ya4ST+7LD2fOSESsJRuSEShYFHsixZDftxaryo07zM=;
 b=uMmgksjxh1xrixHambnSh9TUOV2ClfJ4vc+JhhjpaIek3a5C2blUgAqIhHSoFAs0bZyUXb
 36NyxJXZKWuW3WAamw1WNXyN7KeHa19PF0tAGsxlFUrVVxtaqZ9LgFG7EqWN3XJO6sk9EF
 haLn5yq4jOvYm9Ag1t+K3p0bTNC2KAXsPNmZKxcOGj6fDd6J8bE0DfTXbdYeOUuxAWqIkd
 6PjyYJDzWeZ+jiCVfHkETWA4++8165aMoAZTfpa+kFc3md1gHfeT/4vO8u4wtYSHSGeUBm
 jZRLy2NNZEYxkVxSa2WV/j6xRxgfJwlYHMnI3PHxf/VzJuCqXYcK3NPReBCTxQ==
References: <20260708084507.98242-1-yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
Message-Id: <20260708084507.98242-5-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Yicong Yang" <yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
In-Reply-To: <20260708084507.98242-1-yang.yicong@picoheart.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
To: <xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>, 
	<will@kernel.org>, <mark.rutland@arm.com>, <jic23@kernel.org>, 
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Cc: <jingoohan1@gmail.com>, <mani@kernel.org>, <juwenlong@picoheart.com>, 
	<geshijian@picoheart.com>, <yang.yicong@picoheart.com>, 
	<douyufan@picoheart.com>
X-Lms-Return-Path: <lba+26a4e0e22+22befc+vger.kernel.org+yang.yicong@picoheart.com>
Subject: [PATCH v3 4/4] drivers/perf: Fix the condition where the root port is runtime suspended
Date: Wed,  8 Jul 2026 16:45:06 +0800
Received: from G9WYR9K0VW.bytedance.net ([61.141.241.112]) by smtp.feishu.cn with ESMTPS; Wed, 08 Jul 2026 16:45:21 +0800

The PMU is based on the corresponding root port's VSEC capability,
which could be inaccessible if the target root port is runtime
suspended to D3Cold. Fix this by getting/putting the root port's
runtime pm when the event of this PMU is init/destroy. It cannot
be done in the add()/del() callbacks where the events is actually
scheduled, since there's not way to runtime resume the device
synchronously in the atomic context (add()/del()).

With this patch, the root port will keep D0 while counting and suspend
after counting finished (for prove the correctness since my board does
not support D3Cold):
  root@localhost:~# cat /sys/bus/pci/devices/0008\:00\:00.0/power_state
  D3hot
  root@localhost:~# perf stat -e dwc_rootport_8000/one_cycle/ &
  [1] 14580
  root@localhost:~# cat /sys/bus/pci/devices/0008\:00\:00.0/power_state
  D0
  root@localhost:~# kill %1
  [1]+  Terminated              perf stat -e dwc_rootport_8000/one_cycle/
  root@localhost:~# cat /sys/bus/pci/devices/0008\:00\:00.0/power_state
  D3hot

The root port also needs to be runtime resumed during PCIe PMU
device registration and probe, so get/put the runtime pm there
as well.

Fixes: af9597adc2f1 ("drivers/perf: add DesignWare PCIe PMU driver")
Closes: https://lore.kernel.org/linux-pci/20260629094234.F25E71F000E9@smtp.kernel.org/
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
 drivers/perf/dwc_pcie_pmu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 7b4ee71b966b..aea387d0d0fe 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/pcie-dwc.h>
 #include <linux/perf_event.h>
+#include <linux/pm_runtime.h>
 #include <linux/pci.h>
 #include <linux/smp.h>
 #include <linux/sysfs.h>
@@ -474,12 +475,20 @@ static enum hrtimer_restart dwc_pcie_pmu_hrtimer_callback(struct hrtimer *hrtime
 	return HRTIMER_RESTART;
 }
 
+static void dwc_pcie_pmu_event_destroy(struct perf_event *event)
+{
+	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
+
+	pm_runtime_put_autosuspend(&pcie_pmu->pdev->dev);
+}
+
 static int dwc_pcie_pmu_event_init(struct perf_event *event)
 {
 	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
 	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
 	struct perf_event *sibling;
 	u32 lane;
+	int ret;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -509,7 +518,16 @@ static int dwc_pcie_pmu_event_init(struct perf_event *event)
 	if (dwc_pcie_pmu_validate_group(event))
 		return -ENOSPC;
 
+	/*
+	 * Resume the root port for VSEC access. Use RPM_TRANSPARENT as the
+	 * VSEC is accessible if root port's runtime pm is disabled.
+	 */
+	ret = pm_runtime_get_active(&pcie_pmu->pdev->dev, RPM_TRANSPARENT);
+	if (ret < 0)
+		return ret;
+
 	event->cpu = pcie_pmu->on_cpu;
+	event->destroy = dwc_pcie_pmu_event_destroy;
 
 	return 0;
 }
@@ -776,6 +794,7 @@ static int dwc_pcie_pmu_probe(struct faux_device *fdev)
 	if (!name)
 		return -ENOMEM;
 
+	guard(pm_runtime_active_auto)(&pdev->dev);
 	vsec = dwc_pcie_des_cap(pdev);
 	if (!vsec)
 		return -ENODEV;
@@ -909,6 +928,8 @@ static int __init dwc_pcie_pmu_init(void)
 	dwc_pcie_pmu_hp_state = ret;
 
 	for_each_pci_dev(pdev) {
+		guard(pm_runtime_active_auto)(&pdev->dev);
+
 		if (!dwc_pcie_des_cap(pdev))
 			continue;
 
-- 
2.50.1 (Apple Git-155)
