Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745638;
	b=kZcFbblFzpyPuAyu4R1qVDhBiIN5vS1IFl/j7R/0CED+ZFDO1BFuzfMoxh2sV12OqGfd
	 ZeRIx3CpJ1Jc+PobqX20paW/ZNFWFbBvpSkHKT9tUtr4sWbHFAKyTy50VaPJan6WCNlct
	 87eK/86TQ0VVLRNQhVHDkRVj3CJM9FoiAww1XsRXYTaOmTXBFoxNocprvQ61trVL6OG5e
	 Hu0TGL6zI8EcDrZdk9vyGTOD7GXA+lt97i+3E3BMHikR28MrFppHmMOhR2nzDojR0LOdy
	 Sr9Dr+fFi4Onv5aZi3bRZU6TlHfP6ZQba4t4wcTTbWlK+3Mh/8WGOpMu2n173+1P37A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745638;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=quFqglUGcOsxMT7LXWBLL7fB8yQxvK8KO2f0qt3bqjg=;
	b=PZt+rskk8OHoEwt1kN3q4ur6CsUubC/yvfNHKnjiAoFevIxsrZVP3zcdC/2MliEcDrS5
	 1fjJheVIuiiVEcG3y8y0nzIR4dpgfgQsLuuUegXUCi2UD+WWlW8aGQmZQ9tkt7rFnXA/v
	 EZBC7DsxqmUGzjFXjXQLcxuHy04hFIzH6DdDLAvmlpd9KrjKN3IaEx+J+83EpU6o8kahw
	 uhHcXHQitHZtEZ62WA3M9CgO8v3/ox135bx5vaXzkHlq6u4koNqJ8yrrMspg1voL70qy8
	 7qkdbUm+5zc93NKsV5K9UaMTw6NOqdhJJZ9SMmKUTqwbFpDVQRm00Ep/hAIvDcCtxPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D79606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 02:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D79606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2ee6cca6ea0811f19a56ed5b684f684d-20261127
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
X-CID-O-INFO: VERSION:1.3.19,REQID:f53ea1cd-0859-4d04-91f7-eced82848f15,IP:10,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:f53ea1cd-0859-4d04-91f7-eced82848f15,IP:10,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:2cdbe70d6e0cab851bec24c83e8acc4b,BulkI
	D:261127101352RXWW7AB7,BulkQuantity:0,SF:17|19|38|66|78|81|82|102|127|153|
	865|898,TC:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ee6cca6ea0811f19a56ed5b684f684d-20261127
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(36.112.179.124)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 852319242; Fri, 27 Nov 2026 10:13:49 +0800
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
Subject: [PATCH 3/3] PCI/ASPM: Disable ASPM left on by firmware after a HEADER quirk
Date: Fri, 27 Nov 2026 10:13:45 +0800
Message-ID: <20261127021345.149857-1-tianyaxiong@kylinos.cn>
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

"PCI/ASPM: Convert quirks to override advertised link states" turned
the ASPM quirks into HEADER quirks that clear the cached L0s/L1 support
instead of calling pci_disable_link_state(), so that ASPM is never
enabled on the affected devices in the first place.

pcie_aspm_cap_init() returns before reading LNKCTL when the cached L0s
and L1 support of the two ends has no overlap.  A HEADER quirk can empty
that cache on hardware that does implement ASPM, and firmware may well
have enabled ASPM on it already, so the link is left running with ASPM
on while the kernel believes it is off: link->aspm_enabled stays zero,
so pcie_config_aspm_link() sees the link as already being in the
requested (disabled) state and returns without touching the hardware.
No later request can correct it either, for the same reason.  This
affects [1b21:1080], whose quirk was converted, and [1957:0451], whose
Root Port quirk was added by "Avoid L0s and L1 on Freescale [1957:0451]
Root Ports", under every policy including the default one.

The blacklist path already handles this situation: it marks all states
enabled and disabled, so the next pcie_config_aspm_path() runs
pcie_config_aspm_link() once and clears LNKCTL.ASPMC instead of
returning early.  Do the same before returning here.  For a link whose
support was removed by a quirk, this is the cleanup that the conversion
to a HEADER quirk dropped.

A link whose hardware really lacks ASPM support is not affected in
practice: it never advertises ASPM, so clearing ASPMC is harmless.

The L1 PM Substate enables are intentionally left alone, matching the
blacklist path.  They cannot take effect while L1 is disabled.

Found by inspection; not yet reproduced on hardware.

Fixes: 30579eebba6a ("PCI/ASPM: Convert quirks to override advertised link states")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/pci/pcie/aspm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 6dbae7985bdc..dc400cddf13c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -955,12 +955,19 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 
 	/*
-	 * If ASPM not supported, don't mess with the clocks and link,
-	 * bail out now.
+	 * If ASPM not supported, don't compute anything else here.  Mark all
+	 * states enabled and disabled so that the next
+	 * pcie_config_aspm_path() writes ASPMC=0 instead of returning early,
+	 * the same way the blacklist case has always worked: the cached
+	 * support may have been removed by a HEADER quirk while firmware left
+	 * ASPM enabled on hardware that does implement it.
 	 */
 	if (!(parent->aspm_l0s_support && child->aspm_l0s_support) &&
-	    !(parent->aspm_l1_support && child->aspm_l1_support))
+	    !(parent->aspm_l1_support && child->aspm_l1_support)) {
+		link->aspm_enabled = PCIE_LINK_STATE_ASPM_ALL;
+		link->aspm_disable = PCIE_LINK_STATE_ASPM_ALL;
 		return;
+	}
 
 	/* Configure common clock before checking latencies */
 	pcie_aspm_configure_common_clock(link);
-- 
2.43.0

