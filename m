Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E54756B4;
	Fri, 11 Sep 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130022; cv=none; b=gIW7rikf67fyzpAj1eeQarGAUElNCATHHAzH9F+N9QxX81xT8GirItyfBrdoyIcd4eoo+AWgLlHs+UAOmufRCj/aRF0YcW+b3v+Vm7fsD9bdGU9bGUXE6GRONJ2ZDNMVu/8bowCfChrynejHg3VnA3kW1d9E+kTB6HEGkUZDgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130022; c=relaxed/simple;
	bh=VjakNwENdXvrn/9FZZ8OZL8oQvOvPLvx4BwTPCaqVYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6EtxOxObkCxn7BOK2juIo2gvI63s0W7fPtf7sfG5gEjbi+Nzb5GCNDaJ1lHCyUhjZ4TdEnm60S5AGRBsVE/UfAHK6G4LLr+G5mF1lYNrACwTppwvp1aJD50wJh2g2cQVYr/vY17rb1pMSrSiJergEmJIAZIIzYyDvHZTawRcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=BNT1qZXH; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="BNT1qZXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789130020; x=1820666020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1vETXbf3r5hI7BpXmqQgNKVdrE3cdotOo6s5YjUJkp8=;
  b=BNT1qZXHQdirSLM7AMFEOdjhMZDdq1P/NLKosfCZnGfjaxjOmUmGMnLx
   VLp8b9LKnRamHv3Ojz4X08BXPsjXoykfzWUfQZnJmo6hWFV7N/8jS4ovh
   +8+MBoR/mQ0yVmC8JhIDLTkcNVU4MuVZfFBD/ijky6+5FRRfjYZzUEimX
   pMTTlnudUXg3FN03kRFmJCTypMWEUrhWCFkkFHipFiRsHtW5SNaYKaH3k
   VJL3Po5ogIl3/oZX9Z8G4QmEe3oRmJ6EKLqr2iELFSC0UrSLVC0PSAC/k
   yGc5vuSf253vHk8eY8Oqqk0norjEE6InZbDYrQimojOgpwMCx3dvOMc1C
   g==;
X-CSE-ConnectionGUID: UkOggjMGQ66LJB+WpG4Ung==
X-CSE-MsgGUID: 0IQ9IS1yRgOD0kiITQ7KdQ==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="27924283"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:33:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:4960]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id fe2077a9-0e1e-48fc-8900-b530f5abcdae; Fri, 11 Sep 2026 12:33:40 +0000 (UTC)
X-Farcaster-Flow-ID: fe2077a9-0e1e-48fc-8900-b530f5abcdae
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:33:39 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:33:37 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Matlack
	<dmatlack@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kees Cook <kees@kernel.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, "Ionut
 Nechita" <ionut.nechita@windriver.com>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 7/8] PCI/IOV: Initialize virtual functions in parallel
Date: Fri, 11 Sep 2026 14:33:35 +0200
Message-ID: <20260911123335.7558-1-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Serial per-VF scanning and device addition dominate SR-IOV enable time at
large VF counts, and a kexec-based live update re-creates every VF
through this same loop. Distribute the per-VF work over the kernel's
async machinery.

VF0 is added synchronously first because pci_iov_scan_device() writes the
config fields shared by every VF only on the id == 0 pass and reads them
locklessly afterwards. The rest are fanned out over async entries
sharing an on-stack context with an atomic id cursor, scheduled on the
PF's node with async_schedule_node_domain(). A worker that fails records
the first error there and the enabling task unwinds every id descending;
when several fail the temporally first errno is reported where the serial
code reported the lowest failing id's, and nothing in-tree consumes the
distinction.

The workers claim ids from that cursor and keep draining until the range
is exhausted, so entries are capped at one per online CPU rather than one
per VF.

One entry per VF would make the submission cost -- an allocation plus the
global async_lock per entry -- scale with the VF count and fall on the
enabling task, contending with the workers it has already queued.

No worker takes pci_rescan_remove_lock, which the sysfs enable path holds
around the whole sriov_configure() call, and each runs exactly the code
the enabling task ran serially, so no new deadlock class is
constructible. The probe-time pci_enable_sriov() path holds no rescan
lock, so its failure unwind reaches pci_stop_and_remove_bus_device()
unlocked, a pre-existing hole this neither widens nor closes.

Within one enable, sysfs links, uevents and VF binds now occur in
nondeterministic order, and a failed enable may transiently create VFs
past the failing id before unwinding them all. VF probes run in async
context, where a synchronous request_module() WARNs.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/iov.c | 83 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index a32b2c295922..ac2ddda4bf14 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2009 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
  */
 
+#include <linux/async.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bits.h>
@@ -350,6 +351,12 @@ static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
 	return virtfn;
 }
 
+/*
+ * Safe to run concurrently for distinct ids only, on pre-created buses
+ * the caller keeps alive; id 0 must complete first
+ * (pci_read_vf_config_common()).  Must not take pci_rescan_remove_lock;
+ * failures are unwound by the caller via pci_iov_remove_virtfn().
+ */
 static int __pci_iov_add_virtfn(struct pci_dev *dev, struct pci_bus *bus,
 				int id)
 {
@@ -644,11 +651,41 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
 	return 0;
 }
 
+/* On-stack; live until async_synchronize_full_domain() drains the workers. */
+struct sriov_add_ctx {
+	struct pci_dev *dev;
+	struct pci_bus **buses;
+	u16 num_vfs;
+	atomic_t next_id;
+	atomic_t error;
+};
+
+static void sriov_add_vf_work(void *data, async_cookie_t cookie)
+{
+	struct sriov_add_ctx *ctx = data;
+	int id;
+	int rc;
+
+	while ((id = atomic_fetch_inc(&ctx->next_id)) < ctx->num_vfs) {
+		rc = __pci_iov_add_virtfn(ctx->dev, ctx->buses[id], id);
+		if (rc)
+			atomic_cmpxchg(&ctx->error, 0, rc);
+	}
+}
+
 static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 {
+	/*
+	 * EXCLUSIVE: a registered domain joins async_global_pending, so a
+	 * VF probe calling async_synchronize_full() from a worker would
+	 * self-deadlock.
+	 */
+	ASYNC_DOMAIN_EXCLUSIVE(sriov_async_domain);
+	struct sriov_add_ctx ctx;
 	unsigned long *created_buses;
 	struct pci_bus **buses;
 	struct pci_bus *bus;
+	unsigned int nr_workers;
 	unsigned int i;
 	int rc;
 
@@ -678,17 +715,48 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 			__set_bit(i, created_buses);
 	}
 
-	for (i = 0; i < num_vfs; i++) {
-		rc = __pci_iov_add_virtfn(dev, buses[i], i);
-		if (rc)
-			goto failed;
+	/* Id 0 writes the shared config fields later ids read locklessly. */
+	rc = __pci_iov_add_virtfn(dev, buses[0], 0);
+	if (rc) {
+		i = 0;
+		goto failed;
+	}
+
+	ctx.dev = dev;
+	ctx.buses = buses;
+	ctx.num_vfs = num_vfs;
+	atomic_set(&ctx.next_id, 1);	/* VF0 was added above */
+	atomic_set(&ctx.error, 0);
+
+	/*
+	 * An entry async_schedule_node_domain() cannot queue (allocation
+	 * failure or async backlog) runs in the caller and drains the
+	 * remaining range -- every id is added exactly once.
+	 */
+	nr_workers = min_t(unsigned int, num_vfs - 1, num_online_cpus());
+	for (i = 0; i < nr_workers; i++)
+		async_schedule_node_domain(sriov_add_vf_work, &ctx,
+					   dev_to_node(&dev->dev),
+					   &sriov_async_domain);
+
+	async_synchronize_full_domain(&sriov_async_domain);
+
+	rc = atomic_read(&ctx.error);
+	if (rc) {
+		i = num_vfs - 1;
+		goto failed;
 	}
 
 	bitmap_free(created_buses);
 	kvfree(buses);
 	return 0;
 failed:
-	/* VF i may be partially added: unwind ids 0..i inclusive. */
+	/*
+	 * Unwind ids 0..i inclusive: i is 0 on the sync VF0 path and
+	 * num_vfs - 1 on the worker path (workers past the first failure
+	 * may have added more); pci_iov_remove_virtfn() copes with
+	 * partial and never-added ids.
+	 */
 	do {
 		pci_iov_remove_virtfn(dev, i);
 	} while (i--);
@@ -832,6 +900,11 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	/*
+	 * Deliberately serial: the parallel-add locking arguments (and the
+	 * powerpc pcibios_bus_add_device() serialization) assume removal
+	 * never runs concurrently.
+	 */
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
 }
-- 
2.47.3

