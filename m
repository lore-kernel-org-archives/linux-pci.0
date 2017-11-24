Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3853 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753795AbdKXPya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 10:54:30 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 03/10] PM / QoS: Fix device resume latency for non PM QoS devices
Date: Fri, 24 Nov 2017 21:23:13 +0530
Message-ID: <1511538800-8275-4-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In 'commit 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")'
PM QoS resume latency modified 0 as "no latency at all". However
dev_pm_qos_raw_read_value() returns 0 for devices which doesn't have
PM QoS constraints. This is blocking runtime suspend for these devices
in rpm_check_suspend_allowed(). Return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
when PM QoS constraints are not available for a particular device.

Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 include/linux/pm_qos.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6737a8c9e8c6..d68b0569a5eb 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -175,7 +175,8 @@ static inline s32 dev_pm_qos_requested_flags(struct device *dev)
 static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
 {
 	return IS_ERR_OR_NULL(dev->power.qos) ?
-		0 : pm_qos_read_value(&dev->power.qos->resume_latency);
+		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
+		pm_qos_read_value(&dev->power.qos->resume_latency);
 }
 #else
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
-- 
2.1.4
