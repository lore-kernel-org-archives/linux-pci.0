Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136D3A9D8A
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439741; cv=none; b=UjX2uJDYcMAt5a4YodjaHicjbo91R4PK9i/z7PeZiMHw0ACwh2+bX8DMw0Ac+DUGg2erEu9ylJ1+XXjY0nND9/S8igyXYEyvTMo+6p+WLmj7QumfEzbDPpDXBj+LIHCvc/y7arRAexPl2tnk8GCr6sRnlmNSbOuX8R15REy+IX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439741; c=relaxed/simple;
	bh=WDOu7Fk8CogvViiBRZAwXnG+zZQY/9z+9URxlXQnjdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aikyGjZbs71AvHhFXNm0PKZnRSVQKSrXrRSN2HmjC5fZrNOi5fpMb8VFTVqVl75IKOVqDhHqzUtncqROPVfBnatelQBtcI6bAFQ2XisDv5grpjXD0REPNvYQsQCszsZ4xU3Y9Z0KE/A+thpxJA6m1IhhFDdxvv+5GF+ORmJuBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: DQqQXVcvQWKZ0dmMCflyow==
X-CSE-MsgGUID: RctD9uEBQMacw9NX/2LGOw==
X-IronPort-AV: E=Sophos;i="6.24,162,1774281600"; 
   d="scan'208";a="150371945"
From: weipengliang <weipengliang@xiaomi.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Frederic Weisbecker" <frederic@kernel.org>, Niklas Schnelle
	<schnelle@linux.ibm.com>, Danilo Krummrich <dakr@kernel.org>, Uwe
 Kleine-Konig <u.kleine-koenig@baylibre.com>, Samiullah Khawaja
	<skhawaja@google.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, <weipengliang@xiaomi.com>
Subject: [PATCH v3] PCI: Avoid unnecessary cpu_hotplug_disable() for non-NUMA devices
Date: Fri, 22 May 2026 16:48:43 +0800
Message-ID: <20260522084844.1901-1-weipengliang@xiaomi.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <20260522084244.1844-1-weipengliang@xiaomi.com>
References: <20260522084244.1844-1-weipengliang@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX01.mioffice.cn (10.237.8.121) To YZ-MBX11.mioffice.cn
 (10.237.88.131)

When a PCI device is on an invalid/offline NUMA node or is a VF being
probed from PF context, the code path calls local_pci_probe() directly
without needing work_on_cpu(). In these cases, the cpu_hotplug_disable()
/ cpu_hotplug_enable() round-trip is unnecessary overhead.

Move cpu_hotplug_disable() into the NUMA-valid else branch so non-NUMA
devices skip it entirely. Place a single cpu_hotplug_enable() after
destroy_work_on_stack() to keep hotplug disabled during flush_work()
and local_pci_probe(), preventing CPU offline from migrating the probe
work to an incorrect NUMA node.

Signed-off-by: weipengliang <weipengliang@xiaomi.com>
---
 drivers/pci/pci-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e3f59001785a..27c1cc7c247c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -384,7 +384,6 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	node = dev_to_node(&dev->dev);
 	dev->is_probed = 1;
 
-	cpu_hotplug_disable();
 	/*
 	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
 	 * device is probed from work_on_cpu() of the Physical device.
@@ -396,6 +395,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 		struct pci_probe_arg arg = { .ddi = &ddi };
 
 		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
+		cpu_hotplug_disable();
 		/*
 		 * The target election and the enqueue of the work must be within
 		 * the same RCU read side section so that when the workqueue pool
@@ -421,11 +421,11 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			error = local_pci_probe(&ddi);
 		}
 
+		cpu_hotplug_enable();
 		destroy_work_on_stack(&arg.work);
 	}
 
 	dev->is_probed = 0;
-	cpu_hotplug_enable();
 	return error;
 }
 
-- 
2.47.1.windows.1

