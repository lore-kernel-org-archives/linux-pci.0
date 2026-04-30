Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3C47887E;
	Thu, 30 Apr 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565641; cv=none; b=ZlZwWhJxWGL4vKcUpuharHqGY1yFNGncBUlKTuvXB2g+qI+kOchWhcHLH+/+8tvbb+v94amBkUnQ5APa+EH2In8NlpeZ+cU8bvt2G3W+mZP+Yu8/EnPwP4l0y01eLU5TkWQc0Hngc0O7hbdLMZLBA2BYiQyr5Tjzc58vrczY+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565641; c=relaxed/simple;
	bh=kWLXzGvNQCyVvpBjxUULMbl2qVzLrafiBrAxhget9ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKb7bu1Ib9qa83KuUtJZtdtNdjhG8Q7cKrAka1VTjZ1t6KCovtxcwX6iKZfNBeX5PfqrkEEhEj3+3+1kr5JlU21wP0iwAG8HeiEjd1wV+hUMHVAubSYY34PUOBZDvhPSiocI+p9O9fZgmM90WlcQF+xDQVa39NewIUhZFLftgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EXGCvXZQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EXGCvXZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yI
	MCJJEglyEHgy/8KND7/lOemDk9Of90Cg3VIrBcc4k=; b=EXGCvXZQEUCD1F4HGp
	GDLh5DKVxmrYaRZFgHE1oilIy1nIaq8GJItYCgQ5qKvBsGF+rRQhA9XoLbVLrE3O
	PbBWjMSPiVJO03UFFamyAU9rGfmipVO2f7xu6hGkKbsF3PGuYLGG3AjLHswvzwJc
	E3EihEvMWc9H/ewZoo6xQji+M=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnbymkf_NpTNe+Cg--.31297S10;
	Fri, 01 May 2026 00:13:30 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	s32@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 08/16] PCI/CARDBUS: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:12:46 +0800
Message-Id: <20260430161254.40278-9-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430161254.40278-1-18255117159@163.com>
References: <20260430161254.40278-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbymkf_NpTNe+Cg--.31297S10
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw4ftFW3KrWktr43KFg_yoWfKwc_Wr
	n7ZFs7Ar4DAF1vyw45Cr1fA3s09a15Xryv93Z3ta4ayr1vqasY9FZxWrykZFyDuw4ruF9I
	grZrJr1ruF9FyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi7PE3UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAphBWnzf6oBpgAA3C

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/setup-cardbus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
index 1ebd13a1f730..f7c62054f227 100644
--- a/drivers/pci/setup-cardbus.c
+++ b/drivers/pci/setup-cardbus.c
@@ -253,8 +253,7 @@ int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	 * yenta.c forces a secondary latency timer of 176.
 	 * Copy that behaviour here.
 	 */
-	buses &= ~PCI_SEC_LATENCY_TIMER_MASK;
-	buses |= FIELD_PREP(PCI_SEC_LATENCY_TIMER_MASK, CARDBUS_LATENCY_TIMER);
+	FIELD_MODIFY(PCI_SEC_LATENCY_TIMER_MASK, &buses, CARDBUS_LATENCY_TIMER);
 
 	/* We need to blast all three values with a single write */
 	pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
-- 
2.34.1

