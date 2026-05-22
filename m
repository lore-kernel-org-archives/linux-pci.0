Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2E351C27
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436509; cv=none; b=I+MOYDUfqzq+opS/ODDmGvUrtIgpo0w3jMmRHCSJfYpA9JNTbxvWOUMBZ5Iwhdr6/Zu2pdXdkmZ8IJgaHX6TLVCDI9DQaIeyH21PuE9Kwn2Fc+Gbm1d9G/K9je872YXyYdJ88uZIoHwcrj/sYBcmJ6raV6CqWgj4p2wuKwdtwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436509; c=relaxed/simple;
	bh=qmOmnRV39F4d9XYQmcrIDHQlBv/mrMZ6RdxPzWKSRcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArMDHgAR66WY0bbXnA+rimXW9vK7KmbEW+nAVXMNkIGSB11Y9rP5DVyU2rCnd/exlEEGAT32jbhJ9KVBH2hTEc0vTmGvWvBoVmrWSm8dsVnSf+ZGcQnOIikpKWT/BAdSNLzUSt2LS2lKjCd03uMjfOhVqaouDCpAfsHPksHwfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: jpwovy6vSkmgFuL8T7oodg==
X-CSE-MsgGUID: sX0bFsCrQgWXIDUftENFww==
X-IronPort-AV: E=Sophos;i="6.24,161,1774281600"; 
   d="scan'208";a="176591016"
From: weipengliang <weipengliang@xiaomi.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Frederic Weisbecker" <frederic@kernel.org>, Niklas Schnelle
	<schnelle@linux.ibm.com>, Danilo Krummrich <dakr@kernel.org>, Uwe
 Kleine-Konig <u.kleine-koenig@baylibre.com>, Samiullah Khawaja
	<skhawaja@google.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, <weipengliang@xiaomi.com>
Subject: [PATCH v2] PCI: Avoid unnecessary cpu_hotplug_disable() for non-NUMA devices
Date: Fri, 22 May 2026 15:54:52 +0800
Message-ID: <20260522075453.473-1-weipengliang@xiaomi.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <ahAB2BFymPVFGKaG@wunner.de>
References: <ahAB2BFymPVFGKaG@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX13.mioffice.cn (10.237.8.133) To YZ-MBX11.mioffice.cn
 (10.237.88.131)

When a PCI device is on an invalid/offline NUMA node or is a VF being
probed from PF context, the code path calls local_pci_probe() directly
without needing work_on_cpu(). In these cases, the cpu_hotplug_disable()
/ cpu_hotplug_enable() round-trip is unnecessary overhead.

Move cpu_hotplug_disable() into the NUMA-valid else branch so non-NUMA
devices skip it entirely, returning early after local_pci_probe(). Also
move cpu_hotplug_enable() directly below each rcu_read_unlock() call to
keep the disable/enable symmetrical and improve readability.

Changes since v1:
- Moved cpu_hotplug_enable() directly below each rcu_read_unlock()
  (Lukas Wunner)
- Moved cpu_hotplug_disable() below INIT_WORK_ONSTACK() to minimize
  critical section and keep declaration + initialization together
  (Lukas Wunner)

Signed-off-by: weipengliang <weipengliang@xiaomi.com>
---
 drivers/pci/pci-driver.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e3f59001785a..ea213555fb6c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -384,7 +384,6 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	node = dev_to_node(&dev->dev);
 	dev->is_probed = 1;
 
-	cpu_hotplug_disable();
 	/*
 	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
 	 * device is probed from work_on_cpu() of the Physical device.
@@ -392,10 +391,13 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
 	    pci_physfn_is_probed(dev)) {
 		error = local_pci_probe(&ddi);
+		dev->is_probed = 0;
+		return error;
 	} else {
 		struct pci_probe_arg arg = { .ddi = &ddi };
 
 		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
+		cpu_hotplug_disable();
 		/*
 		 * The target election and the enqueue of the work must be within
 		 * the same RCU read side section so that when the workqueue pool
@@ -414,10 +416,12 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 				wq = system_percpu_wq;
 			queue_work_on(cpu, wq, &arg.work);
 			rcu_read_unlock();
+			cpu_hotplug_enable();
 			flush_work(&arg.work);
 			error = arg.ret;
 		} else {
 			rcu_read_unlock();
+			cpu_hotplug_enable();
 			error = local_pci_probe(&ddi);
 		}
 
@@ -425,7 +429,6 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	}
 
 	dev->is_probed = 0;
-	cpu_hotplug_enable();
 	return error;
 }
 
-- 
2.47.1.windows.1

