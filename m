Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745621;
	b=rH9C5dHRuCAdpIgKh5A7cfrmNOR5QJAWQhJJOSLcx3iNt03YGs2wsiW5ah+l4d8PLfAU
	 ZWgf7o7hzWXlE+mOwY2UQluYraeC4JIV317QGUclsry4UONpqGPuYO4gLX3B+mM4ljLT+
	 OkVLMy+W9RGfcFs+lCMix1Z30D1kdYjmFiuWMXhXG6m+XCpUjkq5KuEy8zPaHUU0URZd7
	 YWVsFTKvXk31V5dNlOG5IHTIZsEGmeQvR1BZtwuzpgucwULjOSyDslEn5Rhjs7Jt+JUn6
	 3oH/ja9+l9V/xljSb7q9tr5nnerQYyolWuOi1T8F9NmkiyeevHaXrHRiENAaXhyq3nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745621;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=tmAMRT5gnO7o7dZsfloEhQo766cmZulzh/sCdHNygzU=;
	b=YYdRS9mdqMUBmpq14BEctc+bAcx9Ri5DxJe54c+wtboypbJtthR7EAha7/gBHfi6RjTq
	 /8FPQGg9Qyt5lZHk7NlFYLI448E28zrXrIkGprBUGSwnN84mvXO8iFOLs2yDoK8q2Xj8c
	 xnW75Fn9Kz9jhDvli2qLxyXnXeK746pg90Sf5zycXi1QdxR5sI2/83Vpkx8EpYhCWwlT6
	 Afk+k8kM88oWc8lcmjyDNRyNaUCmXy7laAD1M6/xcZRKcoRMYjAB97Cpyz6Wk5rC2wOcy
	 7BKX1soBGy+EdzOBtTK18cFojcRD8XIc9aTlaxlBTFxS5o5rWuLfaP2UNnIrmwm+Okw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991B606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 02:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2991B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 24fd06baea0811f19a56ed5b684f684d-20261127
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:bde6e9fb-c0c9-497e-acf7-8c8ea96ea300,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:bde6e9fb-c0c9-497e-acf7-8c8ea96ea300,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:401c534ed605d370a747208a393f022d,BulkI
	D:261127101334F2U5WGDY,BulkQuantity:0,SF:17|19|38|66|78|81|82|102|127|136|
	153|865|898,TC:nil,Content:0|15|50|99,EDM:5|-100,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 24fd06baea0811f19a56ed5b684f684d-20261127
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(36.112.179.124)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 41371534; Fri, 27 Nov 2026 10:13:32 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: bhelgaas@google.com,
	mani@kernel.org,
	krishna.chundru@oss.qualcomm.com,
	ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	david.e.box@linux.intel.com,
	vidyas@nvidia.com
Cc: linux-pci@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 1/3] PCI/ASPM: Only update ASPM and CLKREQ bits in the saved LNKCTL
Date: Fri, 27 Nov 2026 10:13:28 +0800
Message-ID: <20261127021329.149617-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127021128.147354-1-tianyaxiong@kylinos.cn>
References: <20261127021128.147354-1-tianyaxiong@kylinos.cn>
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

The comment above this code says it updates the ASPM and CLKREQ bits of
LNKCTL in the snapshot, and explains that CCC cannot change after
enumeration.  The code did not do that: it rebuilt the whole word from
the value read back from hardware, so every bit of cap[1] was replaced,
and the result of pcie_capability_read_word() was ignored.

An unusable read then destroys the snapshot in either of two ways.  A
failed read sets the value to zero, and pci_restore_pcie_state() writes
those zeroes back: ASPMC is cleared, so ASPM is disabled, and CCC is
cleared with nothing in the kernel programming it again after
enumeration (pcie_aspm_configure_common_clock() is only called from
pcie_aspm_cap_init()), so the link stays misconfigured until the next
enumeration.  A read that succeeds but returns PCI_ERROR_RESPONSE is
just as unusable, and worse: on an unreachable device the bridge
synthesizes all ones, so ASPMC would be recorded as L0s+L1 and CLKREQ_EN
as set, and the restore would force ASPM on.  In both cases
link->aspm_enabled still records the old state, so
pcie_config_aspm_link() does not correct the hardware either.

Such reads are reachable: pcie_config_aspm_link() runs for every link in
the system when the ASPM policy changes, including links whose devices
are already inaccessible, for example runtime suspended in D3cold.

Keep the snapshot untouched when the read is unusable, and merge only
the ASPM and CLKREQ bits into it when the read returns a usable value.

No functional change when the read returns a usable value.

Fixes: 6d4266675279 ("PCI/ASPM: Update save_state when configuration changes")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/pci/pcie/aspm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b039b57f8466..f1ef3d41f089 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -331,7 +331,16 @@ static void pci_update_aspm_saved_state(struct pci_dev *dev)
 	if (!save_state)
 		return;
 
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+	/*
+	 * Both a failed read and a read that returns PCI_ERROR_RESPONSE
+	 * leave the snapshot unusable: the first sets *val to zero, the
+	 * second reports all ones from an unreachable device.  Writing
+	 * either back would clear ASPMC and CCC, or set ASPMC to L0s+L1
+	 * and CLKREQ_EN, when pci_restore_pcie_state() runs.
+	 */
+	if (pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl) ||
+	    PCI_POSSIBLE_ERROR(lnkctl))
+		return;
 
 	/*
 	 * Update ASPM and CLKREQ bits of LNKCTL in save_state. We only
@@ -339,11 +348,11 @@ static void pci_update_aspm_saved_state(struct pci_dev *dev)
 	 * change after being captured in save_state.
 	 */
 	aspm_ctl = lnkctl & (PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
-	lnkctl &= ~(PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
 
 	/* Depends on pci_save_pcie_state(): cap[1] is LNKCTL */
 	cap = (u16 *)&save_state->cap.data[0];
-	cap[1] = lnkctl | aspm_ctl;
+	cap[1] = (cap[1] & ~(PCI_EXP_LNKCTL_ASPMC |
+			     PCI_EXP_LNKCTL_CLKREQ_EN)) | aspm_ctl;
 }
 
 static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
-- 
2.43.0

