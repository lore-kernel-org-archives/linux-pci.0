Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632FD2BEC2E
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430305; cv=none; b=rC/FQdTBJwS/Pt6Trh4jTIwBu60M+sPslxQfZmswhegyaiEyAmzj3/Ht11ugfi9GKFZ0bouwEZKbEh/KFAWlm0yU7DRjKImrDcmwcaE1bYqmXXaGE1jGTgsG/mabX8I8J+KjF7Uef0FABf3/AXbc7R7fAZ9b4IWRi6SyoGyqot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430305; c=relaxed/simple;
	bh=ppUQXjp34G1Q/H20tFeUnkWCotyjWB7kfNBG/0Z9dHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hD60talBQMgu1u3zEklGR6aIUPTGhzpqfEWvfvZSQcuI/vWyAkPbPzlkfru4XQGjN3HwKDf5uaDOcdKFj+oC0uKEq4dW/q2VJ0ZHfa9HTsThV1qa5ghtquw2ysp+ndTXuBJUoEuJo6OnYoPp8QXZxtCbfvQjz1XGFIpoRfsP7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: NILqclP2TPWl43IyhiIeOQ==
X-CSE-MsgGUID: um0zf0DSTayQ5T9CWAsXog==
X-IronPort-AV: E=Sophos;i="6.24,161,1774281600"; 
   d="scan'208";a="176577437"
From: weipengliang <weipengliang@xiaomi.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>, Uwe Kleine-Konig
	<u.kleine-koenig@baylibre.com>, Samiullah Khawaja <skhawaja@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	<weipengliang@xiaomi.com>
Subject: [PATCH] PCI: Avoid unnecessary cpu_hotplug_disable() for non-NUMA devices
Date: Fri, 22 May 2026 14:11:24 +0800
Message-ID: <20260522061124.1660-1-weipengliang@xiaomi.com>
X-Mailer: git-send-email 2.47.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX19.mioffice.cn (10.237.8.139) To YZ-MBX11.mioffice.cn
 (10.237.88.131)

When a PCI device is on an invalid/offline NUMA node or is a VF being
probed from PF context, the code path calls local_pci_probe() directly
without needing work_on_cpu(). In these cases, the cpu_hotplug_disable()
/ cpu_hotplug_enable() round-trip is unnecessary overhead.

Move cpu_hotplug_disable() into the NUMA-valid else branch so non-NUMA
devices skip it entirely, returning early after local_pci_probe().
---
 drivers/pci/pci-driver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e3f59001785a..d3df90f58cf4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -384,7 +384,6 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	node = dev_to_node(&dev->dev);
 	dev->is_probed = 1;
 
-	cpu_hotplug_disable();
 	/*
 	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
 	 * device is probed from work_on_cpu() of the Physical device.
@@ -392,9 +391,13 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
 	    pci_physfn_is_probed(dev)) {
 		error = local_pci_probe(&ddi);
+		dev->is_probed = 0;
+		return error;
 	} else {
 		struct pci_probe_arg arg = { .ddi = &ddi };
 
+		cpu_hotplug_disable();
+
 		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
 		/*
 		 * The target election and the enqueue of the work must be within
-- 
2.47.1.windows.1

