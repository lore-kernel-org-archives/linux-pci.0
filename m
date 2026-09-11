Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CD46AA60;
	Fri, 11 Sep 2026 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130076; cv=none; b=KRLZ6914IhBYNZwGqueHmadBeGVz52NLHJTwG0f8eoFdllJ44SLsDJR+yU8GA0iCv6Xly8GbG1YTkdQrAsV5WP18DmS45eoFlVJRLZbzi4Ss58AuXDz9duEVIx9GuVf4qiuyiP292qn+3zUYgrCg4DqDE3FZA5ZqvCINyo6toWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130076; c=relaxed/simple;
	bh=cmspiYdTEUA6pGHUuwd7h1loRX0CIRxqktQS3CmMLoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPuyNRENq8UJR8xqx9UQO6rpBhtJqVdZ/Tt4Kz1uRLcLJ8Szap8k+LSk1pwoRSRsp6RIXPuIatz2W0RtOZwZo4b1WtiQ7eRf2Oct62IHl9uLxIW6Nj1wdwLc2PZ/NBJTDTOoEStzweV1SC+3eb7fmJXMp187j+zk5M2BosYs+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=optqVINp; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="optqVINp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789130074; x=1820666074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TtB3+ZqqigKPMCEU3NIGj/FC5xLnLRZnxg1hSDBeBgU=;
  b=optqVINpGpbjNAwMpGcawgo4mvXrafOxx0oedHj62ETScRgdho84pSmT
   4znE5BWZv9C2s7NexK8tlYKEFnQOdMebaBmAh5sNiuzWv2xYJ50V1cj0Q
   HqH3d+P9tzp2tSo47ydq0b4gbR3FoPnVK8Vz68d8QFZ4SLF6NNCPiMpZ2
   mGcNEsCcp/1+NauJ9eKkA9cwbkojXFCUkPa0YfNMoGF2iDalrUt7wQrSj
   R9VGcDdMjQtk1H2EJrYpaWFOGQcW8DKJ46nft5cTOL2tTHZoDutGyj1Ex
   BtobLzC1v/eIcn4vQOUHDQ53KtLGgvZLlCT9gyWPEzQ/s5wWFqvOxXpC5
   g==;
X-CSE-ConnectionGUID: V8kWbUZpS0uhb04BY/Kk5g==
X-CSE-MsgGUID: ZOhDAvsiSRaGYYP42HgeRg==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28294073"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:34:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:3959]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.93:2525] with esmtp (Farcaster)
 id 48290a84-2435-4cd0-b88c-3197c072d08d; Fri, 11 Sep 2026 12:34:34 +0000 (UTC)
X-Farcaster-Flow-ID: 48290a84-2435-4cd0-b88c-3197c072d08d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:34:33 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:34:31 +0000
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
Subject: [RFC PATCH 8/8] PCI: Probe inline from node-local workqueue workers
Date: Fri, 11 Sep 2026 14:34:29 +0200
Message-ID: <20260911123429.11491-1-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

pci_call_probe() dispatches each probe with queue_work_on() to a
housekeeping CPU of the device's node, except where it already probes
inline. A VF added by one of the preceding node-placed async VF-add
workers already executes on its device's node, so the dispatch buys it no
locality: it funnels every VF probe through the single CPU
cpumask_any_and() elects and re-serializes the parallel enable at the
probe step.

Call local_pci_probe() directly when the caller is a workqueue worker
(PF_WQ_WORKER) whose current CPU is on the device's node and in the same
HK_TYPE_DOMAIN housekeeping mask the dispatch elects from. The gate is
not VF-specific: any probe already running in a node-local housekeeping
kworker takes it, while a probe from a task that is not a worker keeps
the dispatch.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/pci-driver.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd7ac..f5e12a5044cf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -392,6 +392,22 @@ static bool pci_physfn_is_probed(struct pci_dev *dev)
 #endif
 }
 
+static bool pci_probe_inline(int node)
+{
+	/* The CPU is a placement hint; an unstable raw read is fine. */
+	int cpu = raw_smp_processor_id();
+	bool ret;
+
+	if (!(current->flags & PF_WQ_WORKER) || cpu_to_node(cpu) != node)
+		return false;
+
+	rcu_read_lock();
+	ret = housekeeping_cpu(cpu, HK_TYPE_DOMAIN);
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			  const struct pci_device_id *id)
 {
@@ -412,7 +428,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	 * device is probed from work_on_cpu() of the Physical device.
 	 */
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev)) {
+	    pci_physfn_is_probed(dev) || pci_probe_inline(node)) {
 		error = local_pci_probe(&ddi);
 	} else {
 		struct pci_probe_arg arg = { .ddi = &ddi };
-- 
2.47.3

