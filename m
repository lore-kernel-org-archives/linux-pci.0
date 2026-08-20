Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76412459E1;
	Thu, 20 Aug 2026 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268228; cv=none; b=L4TmHNBX7hUX0PKw9veZPjwN8S/fU6e3lTzjPifYFF9GhuKOeuFI6vxutkZKwg2/YvqvNe/nTPaguAiU7wPWXAsg9WFIELAQjKFMx0KBaj3xiIIsjHxBSlgaOyX52DVfBwZm8/g25F8+Oz5Ubx/Z1qIgbMPeBldV34zAUXBX6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268228; c=relaxed/simple;
	bh=AGKCqqCKGeHaLY5rfM7eeWpwkz1/juqipnRseJKJAaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qfDAP87xhhZG8efqray2QjtTvUWHS3wFU6CTLkhXo7jW/DRA0IJHEL4NKyQPevrK/yp6xK2n2lEVaCkr99XpD0b8HYRLgpE9pzW9Agl/Cq08N11hkuneY+blrNRTLnB+fWIUajc+4MLZmKVbBkoLrlNLsWWJU8Jaa3ZEuOlzCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jLHWmyw9; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jLHWmyw9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=FL
	dfRGlukcigdAqxYFAmwnnJgvtMaS41a1uKIxFw6AQ=; b=jLHWmyw97953mqOXyc
	nuPw1xx8rHUoo6tFQjBuIGlnYU13i2ZOKziOewPcU51OCs3Vx32VoTOShkvNZ0pc
	y6sFpK6UPtjoaQ/FgcwCYvVDPTXpwGRRZjhsy8u1I63d3DE7+502cc1bQOcDxsfq
	Fhg5/5+GAg0AA19guNPtuLXX8=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDH2gFbjIdqVWQZOw--.20708S2;
	Fri, 21 Aug 2026 07:23:08 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	mpillai@cadence.com,
	a-garg7@ti.com,
	s-vadapalli@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] PCI: cadence: Fix enum type mismatch warning in LTSSM debugfs
Date: Fri, 21 Aug 2026 07:23:05 +0800
Message-Id: <20260820232305.80596-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH2gFbjIdqVWQZOw--.20708S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1UCF4DCF48trWDCw17Wrg_yoW8uw1rp3
	ZrGrW0k3WfZrWav3Wqy3Z8ZryrtFn8C3yxG392kw18WF1DuryUZFn7tFy8XF98G3yDXr47
	Xa1Yyr9rAa1YyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piahF7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B+2WmqHjF9crgAA3T

Fix Clang -Wenum-compare-conditional warning by using a single u32
variable to hold the LTSSM status value, replacing two separate enum
variables of different types.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608201933.w2579mwx-lkp@intel.com/
Fixes: d70e964dc099 ("PCI: cadence: Add LGA IP debugfs for LTSSM status")
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../pci/controller/cadence/pcie-cadence-debugfs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
index 0a308f95e9f6..7b8354052aea 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
@@ -210,24 +210,21 @@ static const char *cdns_pcie_hpa_ltssm_status_string(enum cdns_pcie_hpa_ltssm lt
 static int ltssm_status_show(struct seq_file *s, void *v)
 {
 	struct cdns_pcie *pci = s->private;
-	enum cdns_pcie_lga_ltssm lga_ltssm;
-	enum cdns_pcie_hpa_ltssm hpa_ltssm;
 	const char *str_ltssm;
-	u32 val;
+	u32 val, ltssm_val;
 
 	if (pci->is_hpa) {
 		val = cdns_pcie_hpa_readl(pci, REG_BANK_IP_REG,
 					  CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
-		hpa_ltssm = FIELD_GET(CDNS_PCIE_HPA_LTSSM_STATUS_MASK, val);
-		str_ltssm = cdns_pcie_hpa_ltssm_status_string(hpa_ltssm);
+		ltssm_val = FIELD_GET(CDNS_PCIE_HPA_LTSSM_STATUS_MASK, val);
+		str_ltssm = cdns_pcie_hpa_ltssm_status_string(ltssm_val);
 	} else {
 		val = cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
-		lga_ltssm = FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, val);
-		str_ltssm = cdns_pcie_lga_ltssm_status_string(lga_ltssm);
+		ltssm_val = FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, val);
+		str_ltssm = cdns_pcie_lga_ltssm_status_string(ltssm_val);
 	}
 
-	seq_printf(s, "%s (0x%02x)\n", str_ltssm,
-		   pci->is_hpa ? hpa_ltssm : lga_ltssm);
+	seq_printf(s, "%s (0x%02x)\n", str_ltssm, ltssm_val);
 
 	return 0;
 }
-- 
2.34.1

