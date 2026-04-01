Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB14359A6C;
	Wed,  1 Apr 2026 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010683; cv=none; b=rtKqJTjhHSeProgRZEAtd4MH0tUPYNfZdoIhf6wDvq5+sYOwhBvBLCK9+ZFerXbR5zTYP4kGMw0TXbIxAFwfqhfSVsKCEAVFrpE4XD6VQtFFOaOOpwwwsoYWwopfUavYJiaYJ2BhthvovbPPGaBw8yBjGwF3nTXo8pDGsxAiMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010683; c=relaxed/simple;
	bh=jhj6OALAW/j0S9U6dZ34SrH2T2P3LLykjrR1LMlE1dw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WkvkmiXJyjfL7HA1Iwm94dAtZs3uoGbpP4o0fhXpcCZ7C6NpDzrYKui1/2Fr/i9PtNopRWsSls4RKAKyEu0w/JIIY1OlVuNqJ5S3jLWQrkcgh+mVYrOJXSF06kDBbhcdmbm0Rsm81UxQ6LdNKxQWARVtQfLDKoECcVtYsItz15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lhJQtSk3; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lhJQtSk3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MY
	HPlhgTLcl6zJ4QtPRY8XxdvLYMofLuhFyrxcXVLoY=; b=lhJQtSk3heZIAUac4r
	CE3Hz6h0gK6fei8sktwBZcLtQZX8DEku9fi0APkHozyrFRGxYpH5oviRuJHy7Vus
	JqNk8F2cv4wVtZQsNoUo+p3lUyjOGB8gfSR3Yx3IWXIX16lg1UgdLzlj1lWU14PJ
	ECREAttzIrsiVKsutIFmsPNLw=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wA36OZZg8xpxfdkCg--.32151S2;
	Wed, 01 Apr 2026 10:30:50 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: dwc: Fix type mismatch for kstrtou32_from_user return value
Date: Wed,  1 Apr 2026 10:30:48 +0800
Message-Id: <20260401023048.4182452-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA36OZZg8xpxfdkCg--.32151S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryxWryxuF4xCw13Xry5Jwb_yoW8trWxpa
	yrCryYyF4rtr13WF98AayDZa4fA397ur98G39Fkw1I9w17KrWav34rKas0yFyfGrW0yr1D
	Ka1Fg3s09FnrJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ73kUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBuEKGnMg1tc5QAA33

kstrtou32_from_user() returns int, but the return value was stored in
a u32 variable 'val', risking sign loss. Use a dedicated int variable
to correctly handle the return code.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../controller/dwc/pcie-designware-debugfs.c  | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 0d1340c9b364..9461be074490 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -208,10 +208,11 @@ static ssize_t lane_detect_write(struct file *file, const char __user *buf,
 	struct dw_pcie *pci = file->private_data;
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
 	u32 lane, val;
+	int ret;
 
-	val = kstrtou32_from_user(buf, count, 0, &lane);
-	if (val)
-		return val;
+	ret = kstrtou32_from_user(buf, count, 0, &lane);
+	if (ret)
+		return ret;
 
 	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
 	val &= ~(LANE_SELECT);
@@ -347,10 +348,11 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 	struct dw_pcie *pci = pdata->pci;
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
 	u32 val, enable;
+	int ret;
 
-	val = kstrtou32_from_user(buf, count, 0, &enable);
-	if (val)
-		return val;
+	ret = kstrtou32_from_user(buf, count, 0, &enable);
+	if (ret)
+		return ret;
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
@@ -408,10 +410,11 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
 	struct dw_pcie *pci = pdata->pci;
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
 	u32 val, lane;
+	int ret;
 
-	val = kstrtou32_from_user(buf, count, 0, &lane);
-	if (val)
-		return val;
+	ret = kstrtou32_from_user(buf, count, 0, &lane);
+	if (ret)
+		return ret;
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);

base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
-- 
2.34.1

