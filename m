Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020106.outbound.protection.outlook.com [52.101.228.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911D43B6D4;
	Mon, 31 Aug 2026 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200835; cv=fail; b=NULAQAeG17v72tHrgCNiUkQPaYkeGpT8/iIBl9Mf5UJHUm4cqhTFyYRjiUCq2V9/14y8KIMd7pIgaIQ2LqLfHR0eNpHcizVz6p/3v58FTfSwn5Y5uMteHw06s+5T8WCQseojWTh0CKlH5KlJGgZwdscb77CB84o0JR+b+S/UpnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200835; c=relaxed/simple;
	bh=7OXSP2skdpffiQzuQJH5cn3b4eX1k8IKT2Nd2xh7WYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HgfMD1iJ6AA9kAAWRiQCMgibkEsOpLlZN0EtvWs+hhasN3n26HOsMDRK5SKQsDTiR46HId2R/2y/pDUvDZbsjlmNMCsc8yP3izIgreVQdJBCO3hLiBL9lk0q6CYCsaI3jk4fZ2eOVsrcjia7h6d2gFyL/L+3t33gpg0xcD1Q+/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pBBdBSTr; arc=fail smtp.client-ip=52.101.228.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pBBdBSTr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6qGkCqqM6p0DzBAp0Ung+LCRTM4Ciln2+EXV1DtosofjllBYnjQAfW8zKff35jaCma9IEJTTFahZor0eyEpk2EBFkEuQNI09TL+bDqMCecbjYJdVuv86h6gG9xY8I90f7+gk2c5Gfo8ZHo2ivBVlO+yYK5mm030lkxpJlIpMo/4L+3LpQR+RNi21v0EB7lzOoVu/TM7S/cvct2Q1qHQp2Z8Ri4ow2JKKwrWpoF/fhTdZWWP3ag0uMHlqL8S5K719XjA/a78MINMYApSzHOIxGMLO0HPSaQcAFjKpWY0J9/trEcP35Ea38bZcWB1G7bSaaxrd10lpciTxbtirSE3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOShXoqXtPyilZL1URfFVUkfCauaSP+JEBXj6iFVGPo=;
 b=INl1SAJovEGXND2ooXhYGWW3E5KjB5PukzpvRGTx08fKB8btODbhVosREEsYWZO20WTv6vgSGuJxkgbsbwJDgATZPf4NW3znuChilu9UODMgd4qTYXmiJEN3WWxLwggqo58jsacWW9c8f32CNK1PZzSxMv/Pn2AbQatrYgp4momW0V1zDUR/zqJ+2/gAZt+ud9NNFSUs6IqGEB3SehuFMfz7E1nR7SJlbugjgJ/l5lwbCiq/A4rNPiFMEmJqj34ljdlHbuTttJzn4o9iYpb5nza6jk0frokgL9IoyUVt5TNarTostgUGeUX7tatqf2UENibauo09Cjr4bvmK7weErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOShXoqXtPyilZL1URfFVUkfCauaSP+JEBXj6iFVGPo=;
 b=pBBdBSTrD57KaQTyR0KVi0ODfp6OrjTj+p3owITZgEw2PMT7T9prZo7tRtW4Hyl7h3Bm9YcGq/yRHS0Id5EyP+7U2MGlwVr+m1ImcsgdJiiUnxXyKJ/Ew3myHq9Y3W+seFYZ9CbI1TyY1zORnenlAVTkNyjH2IXVvdPHVidZRfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1802.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:27:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:27:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v3 7/7] Documentation: PCI: endpoint: Document vNTB DMA export
Date: Tue,  1 Sep 2026 03:26:57 +0900
Message-ID: <20260831182657.329614-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260831182657.329614-1-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acc8338-2ef9-41b2-99fa-08df078d7628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|366016|376014|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	V5CFbhuJQR/dwoBZrfE9JYG7IllQt+wclY/m0qtyp8NY2mx49Vcl3odZ7VfgGWgYecudm9pEc9gvH5rvQBr3eiaQEifJuag6fYMqy772D0ZUKDinXnfQhFXktw7Ayek+SyVxga8VRYM5E+6G7HZ3I7wsBjQHkzPp3B0jE0Cm91OFuXYvlmCf6DXCf44pA4v7vmZs/iMmlUEIYJ3clPpo1+6r7k7ipAdvR1zgSmU5dxQBYk4g85Eri3fal2TCEgCpGtdobD1JI27wE2OZfHbjXbEQmOzYk8A3yygTo0jxQaQpWAs3XhgGgcJP4SkbV95iVKQANO8JkYexvmTf5QZac9bLUx+oozP3ZhYpjFCJUfZ2O3r4tsQhkpyEmq9zy+n+EgFb4rTi7K21S9yyMMMl+18LpR5HhcrC6hORJj2uYJ4RRhn490+3D4gX4073/Tp93N8Z9lFAIMqGqEI/OWZRoreZg0d9V1CmrVjGNxU93AnKlHgMUHE2WxaEYIORhSsSNtSC49W2c9SKaM9dQqC4qwz731N1MALS9atvYiyB9ZczTkwejlL2TjARkuAuUZ0vxr8Upd5OzQWsHQRGFYxIgEzPDladNC4MdpRfEgdsa2mmKBZaCTJFUp9zLF/nfJL2dPnrxsqdxLAoQgB4ssL5UbOUByB/IL3VBZ8vyLbDD7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IWEbX83EiHfCjmCSJqQVTTZPHRxdou37PYxnRS+ZcogXcBF/UwYN2F4jEAP5?=
 =?us-ascii?Q?gpEQ367vKyQ9WnI1FhOVrzQl+8f1ieOrG+GRbaWWE8hpT13xj4EiV2OhYrto?=
 =?us-ascii?Q?gCanXs3B7XDRe8cHdjQIsXF7eRRzuUIts0mTGW95crv0NILlqPjNr9stigYs?=
 =?us-ascii?Q?6WT5d3CI0YqosTsnourfglRm3EU1R6WAlPrwcu4Da5GIs5LGlJmAvT+cbpmf?=
 =?us-ascii?Q?fEZZUILiXxJjTV9IkYkzfkmX87gGhWc69SlooaZEnp9nliHVe1tiMi/J7ekN?=
 =?us-ascii?Q?HdlP5v9YuBuTT3Nb+CNZk8IW8o8H1WIVUB4hbLClda/qEB/gGT36l0Fd34di?=
 =?us-ascii?Q?qJbCyGSNIcxZWqGQaRMyQeypl5EYSWmy3ipZXBifh5xO0bMdo99MpanzeVOn?=
 =?us-ascii?Q?tidrTI6FHx4cf+RMAo1u/Rce73qUUown6MXocbTqNNDV2vDPJl6jtajUrxCX?=
 =?us-ascii?Q?lZeU88B3FdNbjeVwj7TX3YbBuH8m7L/W4YKLyyC/fl2FLdw1SkcM/49ynAVo?=
 =?us-ascii?Q?MSMHMG9J8B9MnJ4BOQOizQuRw3Qm3GUH6HU2MDSX1CrBX2jnAGBWo9uXJ5ER?=
 =?us-ascii?Q?gSx4EAtt6K5QKX9zvuRTaDPINpiUN5b/wyPgwEboMdKCWyU7vOpviVbBB27u?=
 =?us-ascii?Q?9vc0ofQHMl4iOQPr3echuwO+RyUwWC96AZIzS8J4Z/wNX5iyNz4j7VFq0p3Y?=
 =?us-ascii?Q?wYlyU318Rx0Cei3Qe+5HUGxNoxLRCjL8aQOKARFDDvY7AWNoj2ReMTuJOAg7?=
 =?us-ascii?Q?csQ3IUOV9nSsa0ABXxMwe0AWL3JFAXn2FSQ1CYBmW8aL+H5sdW6K9+pOUqCk?=
 =?us-ascii?Q?7+lSxikLo9nWxRH4jqIaILWOiNW3JBrwV1IYPY61CEznCxysIox6Mi3FFLGt?=
 =?us-ascii?Q?KxWXQjU7MBrX3fXN6HNRk62v9srMYFvvfYYmSRNoFJtAD0nYHIxOHC5ssHA4?=
 =?us-ascii?Q?S+L5c2oBiqqseT43RUlx9/eLtiWVPz+iZGJAAX7rEFu/vYiOZT2uHGO3mDjA?=
 =?us-ascii?Q?MT+A7P2e6ztOZ7wViHdYTRKUq3EmwNYu6sTe6AWl8XjREocrSJUkhxEh5Y0M?=
 =?us-ascii?Q?rNzL2PZcp/qLC8nkuJpE1I2IWAPY84u7p9uKwOzfnFZZ/M3HE4uXWl04T3WW?=
 =?us-ascii?Q?F1WyVk9CIvV62cymXoSFLuKBGa6D8ZTlMyNazzBjWlAycI14FZ5fVmSJuyRm?=
 =?us-ascii?Q?ED1VRsd0RkPVsCn6LhnEzPEV0c4YedBy1ecMIke7a2EFiQY2+EKp0Xb3XCGC?=
 =?us-ascii?Q?btmc+NCYvqUV8Z/qjS2eAHFMgu2HEwODg04trhlgbwy8+NddgvzfkXW9tYI5?=
 =?us-ascii?Q?BQ7oB1hBw2s6Vk6l/WLZp5pnddgKqRKxbM6L6utt30Jin4MBkWBK7vr9bbzp?=
 =?us-ascii?Q?tCy0U5rszsNNc7qQPpoOUxnjJaXBOCbw31MCUt9nSjz0CTP5guYAMbExHS/c?=
 =?us-ascii?Q?M38wIMj6I3uzxQ+vGuaH1416zGspVQ+7+PzxXWUk1jPz2BaEX3eWZsMkK/If?=
 =?us-ascii?Q?gHc3skb6rVJl1nViFC1O2O9mPVGbcwXwl2FWKa1cLW4a5cxoVhBeffBhfeAp?=
 =?us-ascii?Q?UWSNrqE8x25cuTUdII0k77SfevQE/D4Bsx+ch2qojEUwo+5x+Mh0DzY5ee/0?=
 =?us-ascii?Q?G+kl2/W1mCfmzN426gXgk2oLwvgwH1rbwvZpSmgIcudYhkz05qh8gvjb02Z7?=
 =?us-ascii?Q?9AmXN8OCaSVJ+QJksneeKNTX/kChy1QHiG1+nbVWidp5wMmkqzv+2ZXPg2hx?=
 =?us-ascii?Q?rfbdXNg9aVeThRRKyHFCkrQV42vS0slyjczcemc6Jhj4fFYwBxkb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acc8338-2ef9-41b2-99fa-08df078d7628
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:27:06.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSAV/aZnbYQNKelLWm8dN1ncH1EHykJggddiNNwlIrQgk3wJ9pC+l1GF7ZVc3Xqa1vNxUyUl4bue7c7pf60l0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1802

Document the dma_bar attribute and the requirements for exporting endpoint
DMA channels. Also document how the selected BAR may be shared with an MW.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch split from the DMA export patch.
  - Document dma_bar as the only knob and describe DMA/MW BAR sharing.

 Documentation/PCI/endpoint/pci-vntb-howto.rst | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..3a01327208cc 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -90,9 +90,9 @@ of the function device and is populated with the following NTB specific
 attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-	ctrl_bar  db_count  mw1_bar  mw2_bar  mw3_bar  mw4_bar	spad_count
-	db_bar	  mw1	    mw2      mw3      mw4      num_mws	vbus_number
-	vntb_vid  vntb_pid
+	ctrl_bar  dma_bar  mw2      mw3_bar  num_mws     vntb_pid
+	db_bar    mw1      mw2_bar  mw4      spad_count  vntb_vid
+	db_count  mw1_bar  mw3      mw4_bar  vbus_number
 
 A sample configuration for NTB function is given below::
 
@@ -105,6 +105,24 @@ By default, each construct is assigned a BAR, as needed and in order.
 Should a specific BAR setup be required by the platform, BAR may be assigned
 to each construct using the related ``XYZ_bar`` entry.
 
+To export DMA channels, select their BAR before binding the function::
+
+	# echo 5 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_bar
+
+This currently supports the unrolled DesignWare eDMA layout. If any DMA
+resource has no fixed BAR assignment, the EPC must support subrange and
+dynamic inbound mappings.
+
+Leaving ``dma_bar`` unassigned disables DMA export.
+With a separate DMA BAR, an older ``ntb_hw_epf`` peer can ignore the extension
+and continue using legacy NTB. A peer that understands the extension treats the
+advertised DMA type as required and fails probe if its support is unavailable.
+
+``dma_bar`` may instead select an MW BAR, placing the DMA resources after that
+MW. Any rounded-up tail is scratch-backed. This requires an updated peer because
+older peers treat the whole BAR as an MW. Control and doorbell BARs cannot be
+shared.
+
 A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
-- 
2.51.0

