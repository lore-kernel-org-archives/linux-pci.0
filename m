Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADE7260D;
	Sun, 15 Mar 2026 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773589520; cv=none; b=OawdDS98JoFmdaRY1l3GEQchG+qRhgOtv4fQdtZYov/6cfzN1nmQ/xXdBJo2oLxwKZq08+apteBMWHHpYCSwh0W4jQV0qwGVKPR++clmjrETHyc7RCHVct7SJB2xwAO+HKod9br0+qL/asU0uHaBy52OlLFgSN1cdTq/BFDYglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773589520; c=relaxed/simple;
	bh=J1NHey3Kg1jHlGSf4n2SFF2IAtCXRS42xUrUm2LpWr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BKDuX+3k8djLzhqk4Hjk4E0a1gE0iqXikg7ECqdzVdBWcq2HR32W0XR1D9ZCZX9QTxWKR2xZHoamu9unbpbsmCeAc3SYqO+oAWMD+iQTV7IA+VtACAIs7cSTaZuxj1olHkzSIl6zRrfs7/MNIvV1tDH9Afn4R9UVkB/exGFYFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=orXzWSyA; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="orXzWSyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Wz
	+TuIZesqoROqR9OuWTDTC635Nt1AASuNuY52p2Vdo=; b=orXzWSyA8+ALt8O+te
	p/nUdJvCxf6+dRPTZPWj0uT25Fl2PggFT7zso9zpe68jZxBzRDPzioIl3LRMMivh
	nh0duoYOflAS1Oge7H3g/JFv6vmzEWgZUd0i1iOUb83vax+FHKWyCFJtbJZ4ZwPH
	dAhAl5OL4NPBhHC0DYP7qIuzI=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC3T4sC1LZpiCiKBA--.28890S2;
	Sun, 15 Mar 2026 23:45:07 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: pciehp: Use PSN macro for Physical Slot Number consistently
Date: Sun, 15 Mar 2026 23:45:07 +0800
Message-Id: <20260315154507.126524-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3T4sC1LZpiCiKBA--.28890S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy8tF4fGrW5Cw4rJry8AFb_yoW8Zryrpr
	W7GryjkF48Krsruanava4DCF1SkF9xCrWDCr4DCw1a9FySyw18AFyjkrWYqw1SgF42qr98
	Gr90k3ykCFyDuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUndjiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AM94Gm21AOGJwAA3b

Replace open-coded bit shift in PSN macro with FIELD_GET() to improve
readability and consistency. Additionally, convert a direct FIELD_GET()
call in pciehp_hpc.c to use the PSN macro instead.

This makes the code easier to understand and maintain by using the same
accessor everywhere for the Physical Slot Number.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/hotplug/pciehp.h     | 2 +-
 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb..e0d5d24b3351 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -159,7 +159,7 @@ struct controller {
 #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
 #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
-#define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
+#define PSN(ctrl)		FIELD_GET(PCI_EXP_SLTCAP_PSN, (ctrl)->slot_cap)
 
 void pciehp_request(struct controller *ctrl, int action);
 void pciehp_handle_button_press(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb4..8f6c583a96dd 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -1059,7 +1059,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
 
 	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c IbPresDis%c LLActRep%c%s\n",
-		FIELD_GET(PCI_EXP_SLTCAP_PSN, slot_cap),
+		PSN(ctrl),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_MRLSP),
-- 
2.34.1

