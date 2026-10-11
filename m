Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239A372B4B
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791704781; cv=none; b=U4m2lWDKtlSTzOWX2ICTUUqSk4bOQfQIL3/R1gCAaSWHH2Ii5fXMs+yfOog4ZC5qOIkome8Hg1Vzz8AOvBKRiSw7gqtDUT7jbsjR7mLjkn0YeK9mH6qkodJQMvNraY/S2xzEppWw/+r1or02laWsVMHkMRbSmts2E3HLej6KaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791704781; c=relaxed/simple;
	bh=vULt5hnCOdtw+DNCo58XtJna0dS4+83jeIyLxzFV8ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpnG/vRKBvHFLu7vLE4vPj0pR1t4U791LFxdnCOW2V8A1ypFUurt9zUxJwxRpYUbO0BK4OAjn5MXaSNtd8EdDLoR2FSrKkw9c8cqlEt4okN0x5veG3vryxaOXzlnfbmt7ktCO4azoR7UZTmZOwjDhBWN+PBBPAZami7+MTs5aoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKfnhw20; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKfnhw20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791704779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDczcUrL6mkC7ujJYMcbPRDLm9sS9djvARkpJuHR2gw=;
	b=TKfnhw20olj0qaAjacCvPW8uTo9lx5S1Z3DQlSTYwPUvjRwADD+98+ajrhVQeY/MGjEBbo
	C6gydPktz8IOG+haTOutW7gxUwQSWL1P0wYKv6ZtWd3/lKiWSeZQPf4DspZI0Nu6OV/yx1
	DwM0rwanLUcGZwgX8kYvGBP/+u0K0yI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-AJVP1s3dMr2Gtr6bx8ycRA-1; Sun,
 11 Oct 2026 07:46:15 +0000
X-MC-Unique: AJVP1s3dMr2Gtr6bx8ycRA-1
X-Mimecast-MFC-AGG-ID: AJVP1s3dMr2Gtr6bx8ycRA_1791704773
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A8941953993;
	Sun, 11 Oct 2026 07:46:13 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C35A1956041;
	Sun, 11 Oct 2026 07:46:08 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jgg@ziepe.ca,
	alex@shazbot.org,
	bhelgaas@google.com,
	jjohnson@kernel.org
Cc: johannes@sipsolutions.net,
	mani@kernel.org,
	yishaih@nvidia.com,
	skolothumtho@nvidia.com,
	kevin.tian@intel.com,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v2 6/7] ath12k: add PCIe link recovery retry
Date: Sun, 11 Oct 2026 09:45:13 +0200
Message-ID: <20261011074514.515894-7-jtornosm@redhat.com>
In-Reply-To: <20261011074514.515894-1-jtornosm@redhat.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When ath12k devices are passed through to VMs via PCIe passthrough,
the PCIe link may not stabilize immediately after global reset due to
virtualization layer timing variations. This causes MHI initialization
to fail with "BHI offset: 0xffffffff is out of range" errors because
the device is read before it's ready.

Currently, ath12k_pci_soc_global_reset() just warns if the link is
down but continues anyway, leading to inevitable MHI failures.

This patch adds:
1. A retry loop (up to 5000ms) to wait for the PCIe link to recover
   after global reset (similar to the existing LTSSM retry logic)
2. Proper error propagation to prevent continuing with a dead link

This is especially important for VM environments where timing can vary
significantly from bare metal.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v2: Address Sashiko comments: 
  - Replace jiffies-based timeout with iteration counter to work
    correctly when called from ath12k_pci_panic_handler() where
    interrupts are disabled and jiffies does not advance
v1: https://lore.kernel.org/all/20260930140833.576941-7-jtornosm@redhat.com/

 drivers/net/wireless/ath/ath12k/pci.c | 38 ++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index af0e882fd0b5..65712486d312 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -181,8 +181,10 @@ static void ath12k_pci_restore_window(struct ath12k_base *ab)
 	spin_unlock_bh(&ab_pci->window_lock);
 }
 
-static void ath12k_pci_soc_global_reset(struct ath12k_base *ab)
+static int ath12k_pci_soc_global_reset(struct ath12k_base *ab)
 {
+	bool link_recovered = false;
+	int retries = 250;
 	u32 val, delay;
 
 	val = ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
@@ -206,14 +208,28 @@ static void ath12k_pci_soc_global_reset(struct ath12k_base *ab)
 
 	mdelay(delay);
 
-	val = ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
-	if (val == 0xffffffff)
-		ath12k_warn(ab, "link down error during global reset\n");
+	/* Wait for PCIe link to recover, especially important in VM environments
+	 * where timing can vary significantly from bare metal.
+	 */
+	while (retries-- > 0) {
+		val = ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
+		if (val != 0xffffffff) {
+			link_recovered = true;
+			break;
+		}
+		mdelay(20);
+	}
+	if (!link_recovered) {
+		ath12k_err(ab, "PCIe link failed to recover - device may need power cycle\n");
+		return -ETIMEDOUT;
+	}
 
 	/* Restore window register as its content is cleared during
 	 * hardware global reset, such that it aligns with host cache.
 	 */
 	ath12k_pci_restore_window(ab);
+
+	return 0;
 }
 
 static void ath12k_pci_clear_dbg_registers(struct ath12k_base *ab)
@@ -299,8 +315,10 @@ static void ath12k_pci_force_wake(struct ath12k_base *ab)
 	mdelay(5);
 }
 
-static void ath12k_pci_sw_reset(struct ath12k_base *ab, bool power_on)
+static int ath12k_pci_sw_reset(struct ath12k_base *ab, bool power_on)
 {
+	int ret;
+
 	if (power_on) {
 		ath12k_pci_enable_ltssm(ab);
 		ath12k_pci_clear_all_intrs(ab);
@@ -309,8 +327,12 @@ static void ath12k_pci_sw_reset(struct ath12k_base *ab, bool power_on)
 
 	ath12k_mhi_clear_vector(ab);
 	ath12k_pci_clear_dbg_registers(ab);
-	ath12k_pci_soc_global_reset(ab);
+	ret = ath12k_pci_soc_global_reset(ab);
+	if (ret)
+		return ret;
 	ath12k_mhi_set_mhictrl_reset(ab);
+
+	return 0;
 }
 
 static void ath12k_pci_free_ce_irq(struct ath12k_base *ab, int num_ce)
@@ -1452,7 +1474,9 @@ int ath12k_pci_power_up(struct ath12k_base *ab)
 
 	ab_pci->register_window = 0;
 	clear_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
-	ath12k_pci_sw_reset(ab_pci->ab, true);
+	ret = ath12k_pci_sw_reset(ab_pci->ab, true);
+	if (ret)
+		return ret;
 
 	/* Disable ASPM during firmware download due to problems switching
 	 * to AMSS state.
-- 
2.55.0

