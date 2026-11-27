Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745629;
	b=zzZ51TSe2cIzDnQZCXB3IQH4JNFo6mmUZVza66HkRNjQRnC5KEkj8EJKmc+VFt3vXSAo
	 F6IIFF0FhjYyyc6W8TblLl5+vGjLT5hGgOd/SEnBYXOrz7xqKRjlE3d5Cn0cesfNOcqug
	 5/LSUxz6pWgFODRhsOH8NmqeiefRISkQ1mun5ToRYy4RN/ttObhwfmLRRDg50DS0YvGgv
	 +ps0+eglYkpcDZ+eixbTG0uyZmhBE1qTdZ9yco76poclJ0ZufqF+kUnQ86kZI+X/Ze+Hj
	 xwnrzNHwwsUBBG4gJwu9mh2+9ZlZZ99r8vAOCrUQZI+m/bwRcQiC9IjyqixHdefXa1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745629;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=JxyUm6WpNQFdUGMtmw9aM+Ovqmr1DCh+DAythFecf9Y=;
	b=eYvV6KVwV5oHsKeKnlaD1vx+6J/aNgXsELCurAk+/G3hwSJYxhz1HRmcVQBxsEE/kdH8
	 oYUzAJTS0JkA1/mQaadD/c4epKEV1lNUoVmBUGxnmOFppnxaX1WdL71B3ozZV6kdzAWIN
	 6pb8bimm7EH3M3+Xei8EGni8daEN3C6HTz02LhJVs6F2UXZoQSkZdvisCxEY1+yds39+7
	 d+1Jvvi8fjDnqmKutx6eXGrYmVc0gT+3LYqK7jMzOc9Pq1Ms+RjOYdMyKq3wdKftfxapj
	 ftW7eFZCGPZr1lRxCOQH4LB57/eqxJzzrPcRO7irPZTFNtZ/mophoA39XclfiTWhBKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF062606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 02:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF062606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 29e106c2ea0811f19a56ed5b684f684d-20261127
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
X-CID-O-INFO: VERSION:1.3.19,REQID:2b1b87d9-7c3e-4e2a-8b9d-64c808398cc2,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:2b1b87d9-7c3e-4e2a-8b9d-64c808398cc2,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:06f9eed984d7a9d1e636744086e02536,BulkI
	D:261127101343U9IGXY54,BulkQuantity:0,SF:17|19|38|66|78|81|82|102|127|136|
	153|865|898,TC:nil,Content:0|15|50|99,EDM:5|-100,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 29e106c2ea0811f19a56ed5b684f684d-20261127
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(36.112.179.124)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 219694124; Fri, 27 Nov 2026 10:13:40 +0800
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
Subject: [PATCH 2/3] PCI/ASPM: Update saved LNKCTL for every function of the link
Date: Fri, 27 Nov 2026 10:13:37 +0800
Message-ID: <20261127021337.149749-1-tianyaxiong@kylinos.cn>
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

pcie_config_aspm_link() programs PCI_EXP_LNKCTL on every function of the
downstream component, as recommended by PCIe r7.0, sec 7.5.3.7:

	list_for_each_entry(child, &linkbus->devices, bus_list)
		pcie_config_aspm_dev(child, dwstream);

Only the saved state of function 0 (link->downstream) is refreshed,
though.  The other functions keep whatever ASPMC value
pci_save_state() captured, so a driver that calls pci_restore_state()
from its slot_reset() hook restores the stale value on them.  After
that the functions of the link disagree on ASPM Control, which is the
state sec 7.5.3.7 asks software to avoid.

Refresh the saved state of each function right after its LNKCTL has
been programmed.  pci_save_aspm_l1ss_state() stays on function 0, since
the L1 PM Substates capability is only implemented there.

Found by inspection; not yet reproduced on hardware.

Fixes: 6d4266675279 ("PCI/ASPM: Update save_state when configuration changes")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/pci/pcie/aspm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f1ef3d41f089..6dbae7985bdc 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1114,11 +1114,19 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 
 	link->aspm_enabled = state;
 
-	/* Update latest ASPM configuration in saved context */
+	/*
+	 * Update the saved LNKCTL of every function that was programmed
+	 * above; otherwise pci_restore_state() from a driver's slot_reset()
+	 * would put the other functions back to the stale ASPMC value and
+	 * leave the functions of the link disagreeing.
+	 */
+	pci_update_aspm_saved_state(parent);
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		pci_update_aspm_saved_state(child);
+
+	/* L1 PM Substates are only implemented in function 0 */
 	pci_save_aspm_l1ss_state(link->downstream);
-	pci_update_aspm_saved_state(link->downstream);
 	pci_save_aspm_l1ss_state(parent);
-	pci_update_aspm_saved_state(parent);
 }
 
 static void pcie_config_aspm_path(struct pcie_link_state *link)
-- 
2.43.0

