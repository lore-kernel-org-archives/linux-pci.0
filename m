Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E571443C15;
	Sat, 10 Oct 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791648350; cv=none; b=BjGsezaVUq3zdCGoBrjFxK3qVco1/dgLRURaNddhhR2UAmjaBxg34rpr2iJkcz/w9Mzelj/Gt8SNXi7dj6q297tYxiKJ6W2fsC5wsc0NcZ2AI3zpThh27clsoDn5T+93OzylALHmaMMMEA776CX9WAeXTM3BrBHDyK6fWvkUqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791648350; c=relaxed/simple;
	bh=6UcIkbnFq9fPBTy73wLR0JYg0rnziSCx0xmWEO54ALQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ez23sHLYLx4Lj4TBGLF4v3lrQeawv/Mj1LRXm9/3aiYg2Gr7eRNqPGmxJUP5f6Qaboiib3Wb9xm3hPMSIssAkGMGsJzx9Obibhhz+ymsSwavztgTJUEKl2qUr+3CTDRJgiyL5XN22275oyOl8BzRieBNIFrbwd3kxmrqmT0ErG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Pzk7UOWP; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Pzk7UOWP"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j27ql3dzvzMlCg;
	Sat, 10 Oct 2026 18:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791648339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GaXQLuaNtYwcE0I6WuUTmrjF1Wc9eZrySop6U9Or/s=;
	b=Pzk7UOWPGfd/HBao4Wp1UEz467ZxW+aZVzJFRWMChQ4ehDKWQCJV9Nd/XiJNTWgYOVtePD
	jDSSTx1JI6WDGWf0qUUN5DBtl2eXpu2YKGktgnPp+Zu6q14kB02X9GCkBlNYJg9I8MOStu
	r6jydHX6lGPwxJ8uidXf3ocxGy7pc2H+aAc6q/qop/Oq2flASgFpyhHwWqwWrA2uymcJTi
	lmD63uR7fbbnFJJjfVQohHNnEc09q+3seiH39DCWUONoi8hgtJ3AeBaOQC3QgChAXzUvD9
	HoJ/N3njSsJvGBUDN4sNGBjmIw+cL2LTijPsOjvCmodzonDFy55SrhjTZYtV1Q==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Alexander Gruhlke <gruhlke@mailbox.org>
Subject: [PATCH 2/2] PCI: Wait for readiness after FLR even with Immediate Readiness
Date: Sat, 10 Oct 2026 18:05:29 +0200
Message-ID: <20261010160529.27974-3-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010160529.27974-1-gruhlke@mailbox.org>
References: <20261010160529.27974-1-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fc8530650e1a6f708d8
X-MBO-RS-META: dj87rz77ehqwf1rf488uqh5e4p74jwjm

pcie_flr() and pci_af_flr() skip pci_dev_wait() if the device advertises
Immediate Readiness.  Since commit 10baa9b4df40 ("PCI: Drop unnecessary
retries when restoring BARs"), the subsequent config restore isn't
retried, so it is lost if the device isn't ready after all.

The Samsung 990 PRO [144d:a80c] advertises Immediate Readiness but
returns ~0 for 1-7 ms after FLR, which breaks VFIO passthrough.  Keep
skipping the 100 ms delay, but call pci_dev_wait().

Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
Link: https://bbs.archlinux.org/viewtopic.php?id=314833
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>
---
 drivers/pci/pci.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 26be5d1ca9..59856e3fdf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4379,18 +4379,15 @@ int pcie_flr(struct pci_dev *dev)
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
 
-	if (dev->imm_ready)
-		goto done;
-
 	/*
 	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
 	 * 100ms, but may silently discard requests while the FLR is in
 	 * progress.  Wait 100ms before trying to access the device.
 	 */
-	msleep(100);
+	if (!dev->imm_ready)
+		msleep(100);
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
-done:
 	pci_dev_reset_iommu_done(dev);
 	return ret;
 }
@@ -4456,19 +4453,16 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
 
-	if (dev->imm_ready)
-		goto done;
-
 	/*
 	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
 	 * updated 27 July 2006; a device must complete an FLR within
 	 * 100ms, but may silently discard requests while the FLR is in
 	 * progress.  Wait 100ms before trying to access the device.
 	 */
-	msleep(100);
+	if (!dev->imm_ready)
+		msleep(100);
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
-done:
 	pci_dev_reset_iommu_done(dev);
 	return ret;
 }
-- 
2.56.0

