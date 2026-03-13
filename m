Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5744126F3B;
	Fri, 13 Mar 2026 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378579; cv=none; b=ZtYHhpukACOLUx9fokkFkvNASS/neSic4lfYV296zzCUEonKJK9QYHMkGqQAoze2xxANPgPNvz7ctNlCJ9ZfWUv6rZ5eqvFFdCKzrhbEXAq5fwrSW5FqG7uiiI4vm+fej51gInWY1ibfad7bHh6auhrMSRe5FDeiAXK3wSo4rbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378579; c=relaxed/simple;
	bh=qqcGYlYva40DJutqJmnMB5JkrrPlb6d04iK3LoxVwII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ErzRnFHItU4i1NhpXJy4d1hjBlswm2T8kaPRzD8GG/GCUFjA3otj3Tj0gWaduhaFO9PSj1PcwIncvjoRvvGrMa6YushfwrC0WxtCrAp0TPaKwxiQkbmSUK4NMlXChQe+N/Xtex6sg/FqZm6V09BVoqDhMMq/BInh6ymMGVoGKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] PCI: sysfs: Suppress FW_BUG warning when NUMA node already matches
Date: Fri, 13 Mar 2026 01:08:26 -0400
Message-ID: <20260313050826.2126-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The numa_node sysfs interface allows users to manually override a PCI
device's NUMA node assignment. Currently, every write triggers a
FW_BUG warning and taints the kernel, even when writing the same value
that is already set.

Fix by comparing the new value against the existing dev->numa_node.
Only emit the warning and update the node when they differ. Writing
the same value becomes a harmless no-op.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/pci/pci-sysfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 16eaaf7..9f52410 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -378,11 +378,13 @@ static ssize_t numa_node_store(struct device *dev,
 	if (node != NUMA_NO_NODE && !node_online(node))
 		return -EINVAL;
 
-	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-	pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
-		  node);
+	if (node != dev->numa_node) {
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
+			  node);
+		dev->numa_node = node;
+	}
 
-	dev->numa_node = node;
 	return count;
 }
 
-- 
2.9.4

