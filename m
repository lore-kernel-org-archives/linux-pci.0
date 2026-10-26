Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046420;
	b=IEEzK0J0kY9lI6eCqpxeS4r9Ze7b9/Nm6LstI8frMvulNMwxEFCKhmT3g4aFsfdh0ReH
	 yvjiDEwRypcBp6O5feL4Gka8mMoiFZKSkenbH3eIwVTAM9CkW+aAR4dUHM9ZJHeGlMnjq
	 PzzWdvyMDhPR+xjVRPsNN0DGql+RfYRKJsDyVYDmkDvq0jGHTWrnMo8OWmFcn2XwDfEQq
	 dX8DNaPRsg9rHdCPOb/7K/7Q9vipnW1f6qcRfCO5teh66F4WLa8vpqGWBRGMFtXo262sd
	 13QZZPmxsZfVa/7fIUL5p/YzabytJ7rme3vGdNdY1nBN4rP7iUmFjh3M2LFz6X/8MMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xVGU6u8I9I81Dy5biX5l7sqw5Y6L3E/3yFeQDovPiro=;
	b=Aa7VMhpW3Z0x4gL0uWo55AvGBD5eZFWNpsKCMJ9qcQKPha1CoA86xc8muWbnAWgg9Kvr
	 7myKFoErcYgJJK1nPT5oYYRCN0kW+2RFuTxr2ftYceo9M3/v6sQBgxzg/wJ79Cgj0ydY3
	 I6lEaTawbkivgpjICLNB0wcypnrNeVbpzhdYjbX+z3ay1RROkx6KTDYvEKqJrlx1uX1lA
	 fn2pqYsujcA7WLivT3NNS5sfci6xOwgSbFC53lhCQ4UpmNQofn91FeRqIdKOjjsr07lTC
	 sx/nSj5KIb5O87Y68oYQVl7uVL+VKeO8sg4bV8VF62lIrCCmbsuVbp43/TzEp23oGEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TdhsmT4a;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA866606A31A
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 20:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA866606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TdhsmT4a
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a214af2076so24998765e9.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793046418; x=1793651218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xVGU6u8I9I81Dy5biX5l7sqw5Y6L3E/3yFeQDovPiro=;
        b=TdhsmT4a/cUqCmC9KIOY0x2L+L1Wh18an084AV/M2PnU9akY2yRJ5npaGhKFyi3hJO
         xXW8A1v5DdrqYmVYGk4j5lo9BfS/T4OnNHbqi/MyJQod9E1xdE9iuJVuVzEIfuS9tVYH
         pgiL3p5Ni/1e8ZgGJ1jVgUZfG7Jj2hbfLWzuknejeAiT6C0qzRQR00sqwSiANN1hfHi0
         Y22OkxNW5RoD+5culXs+pW67soIdYQ0EsinF4zh+bsNPCFFZWVG149HEwbl30Cz0xFxa
         iCmwuFBZWCfZa9djaQD8J3NPG2sgmJzLwXXhSFE4pqep3VXQhIFBfED+TGEMfxGcPlpd
         FO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046418; x=1793651218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xVGU6u8I9I81Dy5biX5l7sqw5Y6L3E/3yFeQDovPiro=;
        b=N2Qwbmy4TcTggMm8LIgYpznO9ZVBN9btLqjnj23PXxkCY0kQxXpULw9cEKzy9lvLGk
         JnRWrL/J/ooErlSFPTvsQ70RlCjj9Fr1xs3bsyail+aLRW96C6q4K4rBqubRlM+S40SG
         oCwsAqi0DBSn063yAZUiozDDE841yYOgMQhcGJ6CAvbu2snxT07yTqkYMFEyN6Lklt7m
         f8etVgEX8lsw3Wni0GgTB59okENidMS0AmdcJ33odjZLshaVNzncyHu1zbEDmWm2HXrz
         AgNIelKPDQqqx7y2LeE2RtCC0RJOzkt4LjgE9IQ6wEi46DrjZJjwr3XU4cK44m47e+Me
         ed/Q==
X-Gm-Message-State: AFq9FYLNaiyhbffSqB3rKiI3MXtOwpaEXqUSeDUvrjRb+NM7k+wmkLhR
	KgbuxNx15o20JMuGoL0mbDoj9fGnK27rPjF/QastZ4+UmAhRd1M5ehhO
X-Gm-Gg: AYBFou28r0N9RlfnXs8Ht3Ik4Wxw88caw88JMEkWALoIXSynfo8KlTWU9ZXjtKtBS1J
	6W0WZHu6jWBjFDd1TgO+nygrmKIPPp/M3ZWIn/2Ro1D0D7/ALb9V8p4Zt4oG5Tm967tEJPgxVPt
	7iTt1TLsSLV8/6Cf5z/wzTxRunozIqBUpjpmNqOyrJ4TUlToOXuww3QXoRgCLunDYm8xGajMY85
	Co9oIcUDeQu7P+9INsKbn/eXiXeUJxVAFDiZ4Hcfxf6dtznflcnnMkAonwDMGsLBQWE2aFiK24X
	12pp/nrXNgLh+UnPQfHsJpq9JqYulJBsRB/CRoHeb2txSL57LTWH1JFezMTZBQZz2Wa/ouAGXgU
	FyMV4J2kyoXtYKD2fSFEYW1ztrYl3wBG+gq08woX6+6pUY+yrU+sTVJ51ruuriudRbOLZkJqD5F
	RsPvROWc4u08MzKDV5AByhUu2lv5x+s/0ypFIbypcMms3t1iMCOkAnj1MmXOU1M7SpWQYo6yTuN
	2/SOrxAJPjbfEKAUvkNuQcd6pO8VPcuTxiJc8hDKCmb1/0P8C6P7p0hs3OxHWM7ThI=
X-Received: by 2002:a05:600c:a012:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4a35ac95b2dmr135170795e9.16.1793046418191;
        Mon, 26 Oct 2026 13:26:58 -0700 (PDT)
Received: from unicorn.lan.internal ([2a0d:3341:b894:4600:8f9a:af38:72d6:7c0e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a046fefsm276775665e9.5.2026.10.26.13.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:26:57 -0700 (PDT)
From: Giuseppe Piscitelli <ooonea@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/PM: Serialize PMCSR updates against PME handling
Date: Mon, 26 Oct 2026 21:26:45 +0100
Message-ID: <20261026202647.669817-1-ooonea@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PME handling and native power transitions independently read and update
PMCSR. Config access locking protects individual transactions, so a PME
worker can read D0, another CPU can request D3hot, and the worker can write
its stale D0 state back while acknowledging PME status. This was observed
during normal runtime PM of an NVIDIA UCSI controller, followed by a
D0-to-D3hot refusal message.

Serialize native PCI-core PMCSR writers with the existing capability
lock, releasing it before transition delays and readiness waits.
State-only updates write zero to the RW1C PME_Status bit to preserve
pending wakeups. Read fresh PMCSR for each PM-reset transition instead of
keeping a stale word across the cooldown. Keep the literal-zero power-up
write.

Fixes: 58ff463396ad ("PCI PM: Add function for checking PME status of devices")
Signed-off-by: Giuseppe Piscitelli <ooonea@gmail.com>
---
OpenAI Codex analyzed the passive trace and wrote this fix and its local
tests without changing the running system.

Earlier validation used a source-derived RW1C model and four KUnit tests
on Linux 7.2.11 in QEMU with lockdep. The tests use a fake PCI bus; no
physical hardware, PREEMPT_RT or other architectures were runtime-tested.
This base was checked for applicability; no new build or runtime test
was run.

 drivers/pci/pci.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d79d2ee..3628886 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1315,6 +1315,22 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	return 0;
 }
 
+static int pci_pm_set_state(struct pci_dev *dev, pci_power_t state)
+{
+	u16 pmcsr;
+
+	guard(spinlock_irqsave)(&dev->pcie_cap_lock);
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (PCI_POSSIBLE_ERROR(pmcsr))
+		return -EIO;
+
+	/* PME_Status is RW1C; leave pending wakeups for PME handling. */
+	pmcsr &= ~(PCI_PM_CTRL_STATE_MASK | PCI_PM_CTRL_PME_STATUS);
+	pmcsr |= state;
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
+	return 0;
+}
+
 /**
  * pci_power_up - Put the given device into D0
  * @dev: PCI device to power up
@@ -1380,7 +1396,8 @@ int pci_power_up(struct pci_dev *dev)
 	 * Force the entire word to 0. This doesn't affect PME_Status, disables
 	 * PME_En, and sets PowerState to 0.
 	 */
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
+	scoped_guard(spinlock_irqsave, &dev->pcie_cap_lock)
+		pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
 
 	/* Mandatory transition delays; see PCI PM 1.2. */
 	if (state == PCI_D3hot) {
@@ -1537,8 +1554,7 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
 	if (dev->current_state == state)
 		return 0;
 
-	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	if (PCI_POSSIBLE_ERROR(pmcsr)) {
+	if (pci_pm_set_state(dev, state)) {
 		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
@@ -1546,12 +1562,6 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
 		return -EIO;
 	}
 
-	pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
-	pmcsr |= state;
-
-	/* Enter specified state */
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
-
 	/* Mandatory power management transition delays; see PCI PM 1.2. */
 	if (state == PCI_D3hot)
 		pci_dev_d3_sleep(dev);
@@ -2311,6 +2321,7 @@ bool pci_check_pme_status(struct pci_dev *dev)
 	if (!dev->pm_cap)
 		return false;
 
+	guard(spinlock_irqsave)(&dev->pcie_cap_lock);
 	pmcsr_pos = dev->pm_cap + PCI_PM_CTRL;
 	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
 	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
@@ -2433,6 +2444,7 @@ static void __pci_pme_active(struct pci_dev *dev, bool enable)
 	if (!dev->pme_support)
 		return;
 
+	guard(spinlock_irqsave)(&dev->pcie_cap_lock);
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	/* Clear PME_Status by writing 1 to it and enable PME# */
 	pmcsr |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
@@ -2453,6 +2465,7 @@ void pci_pme_restore(struct pci_dev *dev)
 	if (!dev->pme_support)
 		return;
 
+	guard(spinlock_irqsave)(&dev->pcie_cap_lock);
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (dev->wakeup_prepared) {
 		pmcsr |= PCI_PM_CTRL_PME_ENABLE;
@@ -4564,17 +4577,18 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 		return ret;
 	}
 
-	csr &= ~PCI_PM_CTRL_STATE_MASK;
-	csr |= PCI_D3hot;
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
+	ret = pci_pm_set_state(dev, PCI_D3hot);
+	if (ret)
+		goto out_iommu;
 	pci_dev_d3_sleep(dev);
 
-	csr &= ~PCI_PM_CTRL_STATE_MASK;
-	csr |= PCI_D0;
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
+	ret = pci_pm_set_state(dev, PCI_D0);
+	if (ret)
+		goto out_iommu;
 	pci_dev_d3_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+out_iommu:
 	pci_dev_reset_iommu_done(dev);
 	return ret;
 }
base-commit: f4319f548f7d8cb595ac1c91bfd459876399eeb3
-- 
2.54.0

