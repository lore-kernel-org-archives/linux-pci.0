Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F7383C66;
	Mon,  2 Mar 2026 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435710; cv=fail; b=qETvpGMZQaWKzwHITTatXYJtzmAQEH6TfjMCxUlx9rr8HFRf7dTK6DKxe35/BckNLr/lvGx9vtoh4gs/8BCC8Ywp+VH8l+EcJHuXsuYdYFK6aCqFfAuYcDmOnTmcDii2bSCvMbwHcQd2jh78icgOw/zL9nkuWY5LC00SoW5430A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435710; c=relaxed/simple;
	bh=ITA6U7uL0+pf2WgyzbtYj2FplI4HztPd5WV/rptJ7mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GqWcxUCpGmqgDg4cOAqbN5lYSiRFwz32acaDr2MmAdk1nFolC6mef8puUFmIQs3tfhzn36gsipZHhBbcQeKkYwv73Uq6H+cMTebjd7T4eDmE5pQzuj3QrUzz+wiJRJw4ojh9giir0two0EdXPNEMp3svKhQAOsmbHtOaFUctbkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fzAPjE/B; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fzAPjE/B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyQ3M5Xz2dVRTmA8/srswF0LZq1aiA0/VD3h9J/vWrTvtwi66c5UUG/ae7QpCQxpkSoNGbYNo4hwwLi2h1Hfa4uKDucyvMXIewnOt3tKy6DJgE7kDHTsMWZJNtjLIngoHhWYCzkdzDezEk90Xq5L1D1fXiMDsYZ7m6kbYC52ube0ES1UfISfeytE/00M61OKz8D/Krp6PuiQul31HEvniJHTFraO2nX6Scyd0CSW5e4epi49Q/WXncK4BpvQnQiaBN2uLYUE2+8s9UyJkeT6y8DGLh1+x+IjB153xKQp/lPTV/Z08T1sfS9bBlVo4sF+gHkrW413wuRTRlgyTpvW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAYGjLxytfJj6Ra9KbHbNZK1hCagMhSOsjJVgnK5kvY=;
 b=oj5qnTQECLnuVbCmVqgoSBcnnBNx5b17UWz039Mc0IwVuQlfHKr3vt5sQiGe59mRsKN71rzCoBbssBeD0pQDWHT7aY/CGHsJc/s5wOxxgleueMJoPOA96ijUNFr0O4YdkcnVXSqycmPsVxuREsBDl8HU2r3Jd6sNFYm98HIOKKMCBkv7CVXmxlZJN/iOQhNg0g+XfDYilb7KXeplwS+8rSbEWa0M0dHQwMKQACYdXgAm5kQBaX3nNn/RmuUqTPIAoxC13bZTF8KsyeIDuViy3oP8CquHaV98ZI6cBtCiu1YfiGQMNtbIIvIMBTJlPzItuBPFCeGWbD1L1bbY+fBNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAYGjLxytfJj6Ra9KbHbNZK1hCagMhSOsjJVgnK5kvY=;
 b=fzAPjE/BSXNvC19Dydm48NLG+f8YrbJ/SURXPMDRGeHCtBoiWcgtwhvUDtTSMkt73n1s9HX8pPy/VeC73vSyKcGl5QYaYa/EdHjacdSKnvcYIG1hpXa+PlkkBzT/FXoh9MZVfhPnHcRlsCjIqC+pvjAKt8sZeOEQ1koq593ws3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB4872.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 07:15:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:15:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v10 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
Date: Mon,  2 Mar 2026 16:14:25 +0900
Message-ID: <20260302071427.534158-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302071427.534158-1-den@valinux.co.jp>
References: <20260302071427.534158-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0209.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 12522fa6-4521-41b0-1056-08de782b6e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	HnXAioPkDNel9XZ+1xIT4MMZklcYghPQ8qtKpqnP2HlL2jvtyOeZJ7OKd7Cj5CPAhkvuLADXI8W5FBWpp4aNy1rVs2xoT/Jc3+WItyAyXFMTZBPfCwO1Bi4H+JdkQMWDzb1nWF6OIZWBD1nql7ishJ2BOfwiGtQFBde7XksN3mBFERLe8+BfDTJpCIvUcxHukts9EnmCV4sK1v0KtNvDPoNxw6oM+6xqtmYE66J+LcNnnoV8kPC1vdDClIZd487TOFfdimT1W4RkV5nXh9wEnESujAi4cC066DZNFDymicHQHmhXvq8osPVSNg7pVABAf7qM04jo+wcbqL25W0OJ0hB+Qr0/FqC125zP38ada+vHIKRw/+2ujq8hJoImtb5oF1iJPpeOxa3hGsuaevm5aCxVxj6vSAWZ5GBtx4xRjrWIXoSlzS6e03D4x98exA3BDV/sQ22BsIlkqw76MCpe8sa3jIjvaY9qLVakuuU2uizG2gFRPSMfSKb6HOlaf9QveR+sEf6YfrDmqE8FK7WkzkKymPqojx1tfLJOpGhA1cAVtYGEmoTQP33pCeWgvvaavHw1JkpSce/NcLOss6lHYkaVmZeqMPpAOZb20970oUqNcxm1OvwoMx7bZESCpU5zLcLk+FCMl6yWWXlpAtgysXADtVDRxe6Lyy0IrZ2z3RSTDMmVb1mnSazw5eaa/lh3F8jzDjTTWUl0RRl40MXnDcNnwpzITITwUIpszetAhOLXNUtQ30ksqQgfD13nHlTVIa8iPqR1N7YcMSn0ji4wfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EADrWqLf4nbTLvySUfD1q496G/jPvJIXpE/Lh7bywLAUAHpHmLyENbyZpUM2?=
 =?us-ascii?Q?sFiFCVDRB7esr5Peyy2UPOPxM407pD2EE8hCw5P1oNSiUHWtl+VhDB7jgHU4?=
 =?us-ascii?Q?eSMVIXRPHs33hPyfMS93oaANDSMlOHbtBnyzkvIDA5RXMFUCUiBiWbhAvT1G?=
 =?us-ascii?Q?Wvl5fIfMmbqOqUlVsyHKaq+Glf+M5hBmexrbt81zKhrW/Q0fgIT4kgJXXsK4?=
 =?us-ascii?Q?MYhUG9N4Xw7Q0D01jHeLPT0L9WwGSL4zO2nqU/Pw/0oeOPdSXB5SlF/kfmLL?=
 =?us-ascii?Q?ri9f/lTQJMlpDGjBnc7ilv0W9LwTZ/6u2q65ScsaXMzDSEBDsoWOLBOHiREG?=
 =?us-ascii?Q?aUZA/p6N+gsIH4ViRsTQkbegO0LogyZRrrF5T6sxgBJd7VLGaY1t+YlJDw7/?=
 =?us-ascii?Q?pumyrga2RV90Wn4kJZlLcLX30nNksBpU4w7S7JDIKPS/U6CeWZyOsSKSb0Cz?=
 =?us-ascii?Q?h1KdqpGTPiYbUCDjt8fzXUO/PIw0ZyBPJFw6sbrMWBihcteHUsRMfq6EvkGJ?=
 =?us-ascii?Q?z/PviNDt/r2FV0sE7AAF1B2lQGTviiJeoTx6hLVSw7p7kDTvt91U0lzggmr8?=
 =?us-ascii?Q?adJk4jZFQqMWpK1uOVN9iBPexwbv1re50R6GIQBXG14Ypk8RV9F6N/B0HyFt?=
 =?us-ascii?Q?b19KGlvTXjB64XFETa6sTkluhJC5JxsUKTwHRm6pF7GUuLNbGxUfOgbcBjW0?=
 =?us-ascii?Q?ORw/ZOTGI/eSV39yRsQU0nUQC50dysChD7OEBsWnJvK2ugWxejrF2EE1dBr1?=
 =?us-ascii?Q?oPiBdRhrjA69jbJB+Vr5faOb2kcg8hJIkARYruWUsWrTWtyVyE9S1boWTwG9?=
 =?us-ascii?Q?8LVwQlenS2QJ08HCpA6fDxqCOEP4o8nO3j23dJ2RDMS3ynxIJN/ZWgc93lLa?=
 =?us-ascii?Q?mfSNiDZY+8rEO3lGBo4n8krNnku21V1nTendEWQ+Hedmke99fLRwnt9ug6Y0?=
 =?us-ascii?Q?YDibLO9Ltg5MQilwAcFHqGD8WCZYofvunsbh8xOH/ZLEHhVP4JGAV5hASdZL?=
 =?us-ascii?Q?PSNAxF8s9R2tKXy8Mt4Mwg9ftHlMWPTEflIwyhOMvTSGh3DajqW8wx5Y231A?=
 =?us-ascii?Q?eeRMCBduncAeIjHB12cB12by0zpNlKK7XPCl0fejA/0RWLZEVoyPxHHX+df/?=
 =?us-ascii?Q?FRUCHzfgvCZBX6O9gr4T19h1Fe0AcgGdusM1XENNDLr7Nf2ILGDhJGxdp1E+?=
 =?us-ascii?Q?Weow8YCJy3Skc08v5vljMobEhFGiPApqZAoAMm1AmiKxK1MH+DZhAO4uVDPq?=
 =?us-ascii?Q?wn9bfhfXt/vTElpTkO7GRI+E/8N0CPiPN2Y4FzO3UWAMCV+SiDPCRQd7EhVO?=
 =?us-ascii?Q?mR4HllXwvPuSRZGvbxjtVtg8GpKBNZT6Kfn0vbPc44aY+KPGqMRIIitFM/kP?=
 =?us-ascii?Q?SXg2ALZJb9D15ZW1/kZxLgbv/f0Il6PgvsA5eed62RI5V542OvZafbrtmIK1?=
 =?us-ascii?Q?v9zso6zWTzkmP4XnLxjdZrIZzsv1Cd0Da9yqduFBI1Ks6e8QekycmgtSmvY2?=
 =?us-ascii?Q?BkomxfexWrR7yCZsbIR+IkThg+OCWJlwbkS6vtOMJcr2b1AO9I1aKm84lvrf?=
 =?us-ascii?Q?A3pDSjVwE9qAxrjyJ5nQa9TXvcbuQqqo3KExY3VDwZehZBUtWqegXuQ1gkug?=
 =?us-ascii?Q?F6VIwFVQVnFbhSooSmRDcdtqaMwYoZh5Z3RB2JEgxOih0k7doBHrdpD+96t4?=
 =?us-ascii?Q?U6tYHWj4dIhK8K+L3RYr6UhmnA+Kpt3YydGDyJjF4wcU3ob3qVmJkD+Xgil+?=
 =?us-ascii?Q?x9cTsLH04cTltrp7Zt4M5BJzn+3WqyzIs06FjHjXfx53niYR35RV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 12522fa6-4521-41b0-1056-08de782b6e51
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:15:06.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IGmxA4SHypEqzJ1Y6+Oc/6ItJz81Q8XkiudZyGPaiqT+KcNjcFPF4cU2OuLVfQU4CBEt2VIdTypnhq3O0+5bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4872

Support doorbell backends where the doorbell target is already exposed
via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
must be requested with specific flags.

When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
pre-exposed BAR window and skip programming a new inbound mapping. Also
honor db_msg[].irq_flags when requesting the doorbell IRQ.

Multiple doorbells may share the same Linux IRQ. Avoid duplicate
request_irq() calls by requesting each unique virq once.

Make pci-epf-vntb work with platform-defined or embedded doorbell
backends without exposing backend-specific details to the consumer
layer.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 61 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 148a3b160812..8e9a3048c2e5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -134,6 +134,11 @@ struct epf_ntb {
 	u16 vntb_vid;
 
 	bool linkup;
+
+	/*
+	 * True when doorbells are interrupt-driven (MSI or embedded), false
+	 * when polled.
+	 */
 	bool msi_doorbell;
 	u32 spad_size;
 
@@ -517,6 +522,17 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static bool epf_ntb_db_irq_is_duplicated(const struct pci_epf *epf, unsigned int idx)
+{
+	unsigned int i;
+
+	for (i = 0; i < idx; i++)
+		if (epf->db_msg[i].virq == epf->db_msg[idx].virq)
+			return true;
+
+	return false;
+}
+
 static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 					    struct pci_epf_bar *db_bar,
 					    const struct pci_epc_features *epc_features,
@@ -533,9 +549,24 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	if (ret)
 		return ret;
 
+	/*
+	 * The doorbell target may already be exposed by a platform-owned fixed
+	 * BAR. In that case, we must reuse it and the requested db_bar must
+	 * match.
+	 */
+	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
+		ret = -EINVAL;
+		goto err_free_doorbell;
+	}
+
 	for (req = 0; req < ntb->db_count; req++) {
+		/* Avoid requesting duplicate handlers */
+		if (epf_ntb_db_irq_is_duplicated(epf, req))
+			continue;
+
 		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
-				  0, "pci_epf_vntb_db", ntb);
+				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
+				  ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
@@ -545,6 +576,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		}
 	}
 
+	if (epf->db_msg[0].bar != NO_BAR) {
+		for (i = 0; i < ntb->db_count; i++) {
+			msg = &epf->db_msg[i].msg;
+
+			if (epf->db_msg[i].bar != barno) {
+				ret = -EINVAL;
+				goto err_free_irq;
+			}
+
+			ntb->reg->db_data[i] = msg->data;
+			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
+		}
+		goto out;
+	}
+
+	/* Program inbound mapping for the doorbell */
 	msg = &epf->db_msg[0].msg;
 
 	high = 0;
@@ -591,6 +638,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		ntb->reg->db_offset[i] = offset;
 	}
 
+out:
 	ntb->reg->db_entry_size = 0;
 
 	ntb->msi_doorbell = true;
@@ -598,9 +646,13 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	return 0;
 
 err_free_irq:
-	for (req--; req >= 0; req--)
+	for (req--; req >= 0; req--) {
+		if (epf_ntb_db_irq_is_duplicated(epf, req))
+			continue;
 		free_irq(epf->db_msg[req].virq, ntb);
+	}
 
+err_free_doorbell:
 	pci_epf_free_doorbell(ntb->epf);
 	return ret;
 }
@@ -666,8 +718,11 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 	if (ntb->msi_doorbell) {
 		int i;
 
-		for (i = 0; i < ntb->db_count; i++)
+		for (i = 0; i < ntb->db_count; i++) {
+			if (epf_ntb_db_irq_is_duplicated(ntb->epf, i))
+				continue;
 			free_irq(ntb->epf->db_msg[i].virq, ntb);
+		}
 	}
 
 	if (ntb->epf->db_msg)
-- 
2.51.0

