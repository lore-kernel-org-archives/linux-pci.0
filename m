Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA154723;
	Sun, 15 Mar 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590482; cv=none; b=ZS1fPq5rkYdSqoRCiy19cdJRjTWM4e8/j36zNmFbnUz0ZmkuAXQv9EM4WmbBrIIWDy9OTuLxYQqlsPvGQXTd3ISs8Kp3Cpa1Cz0sPwczM2tTQB1hwqiuHZZmltqn0KjVqh2+6BOaZMOK5ssKNpuFXy3V5LS9izllH15HfKnyDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590482; c=relaxed/simple;
	bh=Y1AnyHAav22SAFmbJKuI/jxkQ4wST/gYkY58BOqFr9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQVEfkcuJd6QyHhbgbAAWIOadfKaEklUm3FgUvx0B4Wu4A8ajQlQsctIzQaCe9GI5vPYFdLS7pXVWjSzrUCBuXli1XOA2QshPRVXWONrqMDJZ89yyiEbAZfENhg3CZyzgyOGo1lwOGdGOmbqCGpfxTW9vJfFlcqRMABIDsaIpP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d40Vtyg9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d40Vtyg9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sH
	WBBMxa5mGbfFmcKFkPPyvdgyTCIlj6ndt/oqs2vgo=; b=d40Vtyg9GXLCVwnFHv
	tuKIHYJu0GAF7Ao9Wy/fJsw3BXxQ6tcenIw1q7w9fnx77wTgQr14HWjjiZ2PMrKx
	4QGMYnqsHRBI6zKe5i81O8j+eaP3+JTTBsnVdlf/B7KtYvMqK4/7AXIZg+KNCeoh
	IhTZVqmhl5xfJamwt5eyzS4xU=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBHvwy817ZpjnSYBA--.30374S3;
	Mon, 16 Mar 2026 00:01:02 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v1 1/3] PCI: Move to_pcie_link_speed() to probe.c and export it
Date: Mon, 16 Mar 2026 00:00:55 +0800
Message-Id: <20260315160057.127639-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315160057.127639-1-18255117159@163.com>
References: <20260315160057.127639-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHvwy817ZpjnSYBA--.30374S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWkAryrCFy3KFWfCFWkCrg_yoW8tFW7pa
	9rCa10yr18JF15Zr4jv3W5Zry5Xanxu3y2krWxCa4kZFy7AF93XFyaqF43Ar9ayrZrZFy3
	A3WayryUC3W7AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piU5rsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxB8t0Gm217-RnAAA3c

Move the static helper function to_pcie_link_speed() from pci.c to
probe.c and export it. This function converts a PCIe link status
register value to the corresponding pci_bus_speed enum. Exporting it
allows other parts of the PCI subsystem (e.g., sysfs and inline helpers)
to use this helper instead of directly accessing the pcie_link_speed
array, preparing for better encapsulation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c   | 5 -----
 drivers/pci/probe.c | 6 ++++++
 include/linux/pci.h | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..b93693575573 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5886,11 +5886,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
-static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
-{
-	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
-}
-
 int pcie_link_speed_mbps(struct pci_dev *pdev)
 {
 	u16 lnksta;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f85da50a3d83..40f2185ac3b5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -799,6 +799,12 @@ unsigned char pcie_get_link_speed(unsigned int speed)
 }
 EXPORT_SYMBOL_GPL(pcie_get_link_speed);
 
+enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
+{
+	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
+}
+EXPORT_SYMBOL_GPL(to_pcie_link_speed);
+
 const char *pci_speed_string(enum pci_bus_speed speed)
 {
 	/* Indexed by the pci_bus_speed enum */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..751a2b2ba04c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1459,6 +1459,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
+enum pci_bus_speed to_pcie_link_speed(u16 lnksta);
 int pcie_link_speed_mbps(struct pci_dev *pdev);
 void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, bool probe);
-- 
2.34.1

