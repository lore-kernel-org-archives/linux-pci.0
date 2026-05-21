Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020080.outbound.protection.outlook.com [52.101.229.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630AC394EAF;
	Thu, 21 May 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345262; cv=fail; b=udTyxinoMvGXJAKfV1fQENDrpLiKuJNyArSvZ1jIdji9C1KCLfnYVjnKIDhZE62+RHmqyO1a3H2SEaAXL8hFh2I6Ix4C/+rBrkPA4wyiyWdFoA2aCHjlMDlPWeWWBkh9IqdpdWnIp5PP9LQUOxZYXtCFuzAffrfeNX0NfpzQbsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345262; c=relaxed/simple;
	bh=NVV7POCyMX79xGYMDETyy5/XOe/apFlJTwjolaJigZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oOkZKf0cypPJFPPEY3wmBI5iSIpDTIZofBTz0tI9AnLSoYNiFawXX3/zpHMd1jP+O8YpblcZG/qY4xcNvnYJJ5T0VAZJloFxcpLMmHWnHon1dPNb420we2GFf88Qt0teoS9wDv4wInH+jvmjwYqWX41Ewk91FCaiiCI6NbBG+ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=V3sfHXh7; arc=fail smtp.client-ip=52.101.229.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="V3sfHXh7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgKGb/GOguqsfag58eJkRaPUl5hXpQGuVry1qjzahFYvivcglZb5ARi+UX7/vCrgGNjUJhd/pHb8TBNRFnn/hZVpBNxaGSQ1sDX2qT97Ri3gHsWHDQ7DD4qO3+tayqsFmaek3u/2RP+O0bjN4LhbtjPM07qTklKbvYYuo9Rp6IrFy/IA7hnSTmjNpbylrzk6eiY99b0reAtjM/Kodxj2CP24KuXPUfH5Cro96uJOu7TtdYDK6P8q37P993LEv/AgyJyzbHVyQcHM7pgjAKHfqK7O0pDCmyOXCkH7/E/c5cjQMpBbSTuA/GgYJajDnqMWqmJ89AKQgZeqpkO/YN+Flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uksFBQg+21gbEXzD1ujQ9ElPTlHHk9ku4R0QT0l2ZUU=;
 b=YJIyzRLPBPcNh/JwiqF/ExtfbvQnEAGE6ma5jY8p0BCyR+5+S/CYTj3nWsyF80WLHiMB1dnkgdYwYvxSSgZgoEzZgPuKNr5448WM5YdlIxGED+1172+lpkW+jD+la4Gnkihy7yznW4mPzfnJDZF7gnyWlI9j706SUIPScjYISDfI6rXp7lFWYwbkdVoKl8kzL6LZ4KXMysl6Ks5upJe2Q4gY0Lot/fHb+4hdPhUBGogFK0wXtJaVM7GC0UlSPpZBigbiYKKl3UCCbiv4AN/EobS1TB+TpQz/iR+sUbZjiLGHZggC9G1NQ94JCMtraQ3m58zYFxfqd86rVIu+H5ejrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uksFBQg+21gbEXzD1ujQ9ElPTlHHk9ku4R0QT0l2ZUU=;
 b=V3sfHXh7gj2C6ivyff6/Lxdklv+y1Bjw6RWIez1dlw9I3wfXN9RxCRuQf9a+W5Cwd5tALGQ97runmpYm8G3fz7k9l9My3m2dN+SaYMu2c8JXtr3pclgU1IBGMfcTMWZYLy44cgLWzRBpAQUJpM5YJDtkz3EitVkJrBJ1VjnxuAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB3955.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:34:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:34:15 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Thu, 21 May 2026 15:34:04 +0900
Message-ID: <20260521063405.2842644-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063405.2842644-1-den@valinux.co.jp>
References: <20260521063405.2842644-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB3955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1595b3-3830-459c-8a4a-08deb702fa74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|56012099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	70F5zdUbugCTQo8RncLs+vx65nYbW/yuhbw4mLVRKVf4RmcVBt3id1sSWXVt0vbszmiVE0qYQcZOVQ/K9LrQNxNk/zfrFszNsoqtcYN63zDYljhaBSJKpOX8FJr8avdI0LeVvlJGj8u9V3VxQan0tYJNKHNDrMkuc6N2+PtyFXoTeR5eUofRnoe3sYFRgkl6bNqYSv/rL1uWWy9mM1Yz1PevcdGPSVTyd6tiZssZ8gL2+7M8DxbOb+3VVWASn+gmTL+nhmuBc+xH+woRW0xxLrHeikwLtNel8f2zErjysN0XB/OAb6JW9E36V3+scqIgosT929wQFzdiCsSemW7iRi0iHrJFNb8gXb6HNhDrKXMWNmrZhOZlaC1vycdGtxpgD2xLKVpyVL6kDrREn1nOSEeltIW49kIPGf5FnjSOT262Vz0QE0+Ez0fhTJzR0yW+5DU0XBu36SZ4K4ADlYa5LgklhLl6agtHamsky8peTEpcwNSaj6EotkHWZQb9t8jJMJ+MI56mhSZj81WLuQlV2d03q6eVFgAoG9X9GJL+FVy0UYR76qwz4Aaj1x3w6Bur2vlMJUDLTgCmqhnXSspqjA02OwsDWqRWC5qLrwBfX8l7zhmxKbfTnyqicayQUGdzKJAvM68PooYZqJ/TAjL+k4NVnmJ93qZurES7OMpWBT6l2BSOQ7ZJf3y10FnnDATl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(56012099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rA183WY5f015nlLGG+G+NKT/9g34Rry7rZcLRJbxNdLOecYV7eWfsYmQSyob?=
 =?us-ascii?Q?KWEVioCgQhDciGC0Sh5bGQY7s1c3ijy5n0RfEfkHb9z+meU9xb+Nl5eeuWHy?=
 =?us-ascii?Q?89vj9d3Cj1Og0C+8vbymAOhdTkKnDKmcnvARTZk9hXaS2UBMt9EdC3fNum0x?=
 =?us-ascii?Q?aZaZGlDQ2yHSx2iORu/dH2GY1Jbps5rw/KchOKlsrR6+ECvFALl627chbHM7?=
 =?us-ascii?Q?69UzcUQzgTb02hYfeI+3ZhdG37qEGyW+YflTrA+BHMm9e9sBx1FNaKs0QO8p?=
 =?us-ascii?Q?kJFGa4WmYgxm2gvspag7vZcfkAnfaKXw7GxZb7wC/YcdmjdOXvOd/P8miANT?=
 =?us-ascii?Q?tkHDQsIt+jWReoqrxpCDHYA3wFQo5Hwu/gH7oeO/nX39gSaaEP5fpiY08+O1?=
 =?us-ascii?Q?F9Bw6C8rA5r6FS3jHffCpNIlvl/nwtmop1vA5sjjxJF4pp8jGSj89KLG2utP?=
 =?us-ascii?Q?bWaLuigpGq+btkyFtmMou5A0nCy9tuJP+MOFlAbQpzrTgBFC9MUja/7CQ3P+?=
 =?us-ascii?Q?oykJoAGuZx5lm5jihCrNIiqx9KzJHWUVJj9P5zbnF9MqNElifZ6Ogc8qiiMd?=
 =?us-ascii?Q?eF/358fHl2GwxXLDu0PIs/xWIGxEU79wwdtZIvDXxMDBv/Ri922aSzgN7RlL?=
 =?us-ascii?Q?gmrCZjzv/+q+8KnLcgFVXEpbp/glbbZtyBeOu0fMNf/lnQV/Sl2KIy5t/AOo?=
 =?us-ascii?Q?wwQSVL+9GEp3KM3GZ+4lnC2wJ1A1aYdCcXnvKntKH0aknLlC+g8E7TZv0Fu3?=
 =?us-ascii?Q?4B8oS0/mcLjcVnOnLtYCESn7gKozqPmgKBn2evVuoGdO556BgMx6Fjb5qwrj?=
 =?us-ascii?Q?orYyHDaNmawoHj35PBbddNN7tXcUR2RiDDxTRGOw0soktxpjuMJjPc+3rlDZ?=
 =?us-ascii?Q?kMcHLcdVXiVUWzts0Bg4DfbeAwFkcyfnlg1RZ5X7O3wm7K83Z6CNyxTiQsIc?=
 =?us-ascii?Q?tItVG5ln8mTlv7AkNVni+KqePCTDnUdQM3Zvq/vG7vh88Fa7XcymoGt7fOkL?=
 =?us-ascii?Q?hYn7ten1NmINXUL6CCeL3m1P70jh13R8AVMjTHmg9X4mySLhtTZXLIVw32Dd?=
 =?us-ascii?Q?iNcSTJzIM7uuHQPur+q9851GLZf8a/ZupY04p+Bq1XXXmEldAOWljLPCUE/V?=
 =?us-ascii?Q?IXCDV/3TqS1pPIm3W1pTm92h8/T1fjDotGlsHGm4RUNmG73oxp/GyDjXX4aw?=
 =?us-ascii?Q?ROA8TZAwh7BbDmGkkLLY7+PtML3ZUJEsnIZry8/0K/Fnw1cabUr5gDkLOkeZ?=
 =?us-ascii?Q?6cbpw/o4RncMxqxEnQxwZMNS5IYqiO8axEpn97xiIiGUru2V7N8RyhTBeKOz?=
 =?us-ascii?Q?B5yiAjYNc/iEP92zBooBjONqB8Wut2YBG7WlaWgp/PZMdRHRBVjtaiIEpuJh?=
 =?us-ascii?Q?mUiGNNMKdHwaw5oqrYrbVkdlyNvWAYDgvBH+pW74d1qD1W3PzwAlWTTYW8v7?=
 =?us-ascii?Q?1INGJt3dzqLn2KiIb1SGlGnzzNRApmDt8MKp0BSkb7hZqUbeFqai1gxrqn7S?=
 =?us-ascii?Q?WdJ8xIoo0nB5DAcUaMsQZ6lkzIQ8sEza68BHnlhfgMDcdBuVulFVe1A5IQ0p?=
 =?us-ascii?Q?TY2XTMh5TmwauT9PGhVjybw82QlrT1PwltTSeSSGVmlFtHf/d0v2x/8tNmn0?=
 =?us-ascii?Q?64tU6b67i7g1V2tatXZ6ju4A6Z/tKhdMP+Anr2LhRCq1qMo+eispZcesPtYJ?=
 =?us-ascii?Q?YOEOxXYT/THCYYzCQEH3b1qlNM5duujR9Rp92xZo3KXpolA4r4NlPY815/H1?=
 =?us-ascii?Q?+x+58cueb8lcP4DngBewnLp6oqbyhdNcZDI7feDMrJrrZCXAZmxw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1595b3-3830-459c-8a4a-08deb702fa74
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:34:15.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tqyewXPsZ0jYFbiu/mv17ebo5b0OwkkiAFCB/ycVtvdjzhmtGYj2LSCPjxewWpJQp6QC2zh9qmLqim6SH5gPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB3955

Extend EPC auxiliary resource metadata so endpoint functions can discover
controller-owned DMA registers and descriptor memory.

The DMA metadata is intentionally generic at the EPC layer. A backend
reports the register layout, channel counts, descriptor memory, hardware
channel numbers and, when available, the local DMAengine channel for exact
ownership reservation. An endpoint function can then decide whether it can
expose those resources to the host.

For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
format so a consumer can distinguish legacy, unroll, HDMA compatible,
and HDMA native register layouts without making the EPC API itself
DesignWare-specific.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/pci-epc.h | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..1afa491ff6e7 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -11,6 +11,7 @@
 
 #include <linux/pci-epf.h>
 
+struct dma_chan;
 struct pci_epc;
 
 enum pci_epc_interface_type {
@@ -65,6 +66,8 @@ struct pci_epc_map {
  * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
  * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
  *                             controller register window
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
+ * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
  *
  * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
  * register windows and descriptor memories into BAR space. This enum
@@ -72,6 +75,26 @@ struct pci_epc_map {
  */
 enum pci_epc_aux_resource_type {
 	PCI_EPC_AUX_DOORBELL_MMIO,
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_DESC_MEM,
+};
+
+/**
+ * enum pci_epc_aux_dma_reg_layout - DMA controller register layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA: Synopsys DesignWare eDMA/HDMA layout
+ */
+enum pci_epc_aux_dma_reg_layout {
+	PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+};
+
+/**
+ * enum pci_epc_aux_dma_dir - DMA channel direction relative to the endpoint
+ * @PCI_EPC_AUX_DMA_EP_TO_RC: channel moves data from endpoint to root complex
+ * @PCI_EPC_AUX_DMA_RC_TO_EP: channel moves data from root complex to endpoint
+ */
+enum pci_epc_aux_dma_dir {
+	PCI_EPC_AUX_DMA_EP_TO_RC,
+	PCI_EPC_AUX_DMA_RC_TO_EP,
 };
 
 /**
@@ -99,6 +122,26 @@ struct pci_epc_aux_resource {
 			int irq; /* IRQ number for the doorbell handler */
 			u32 data; /* write value to ring the doorbell */
 		} db_mmio;
+
+		/* PCI_EPC_AUX_DMA_CTRL_MMIO */
+		struct {
+			enum pci_epc_aux_dma_reg_layout reg_layout;
+			u32 reg_layout_data;
+			u16 ep_to_rc_ch_cnt;
+			u16 rc_to_ep_ch_cnt;
+		} dma_ctrl;
+
+		/* PCI_EPC_AUX_DMA_DESC_MEM */
+		struct {
+			enum pci_epc_aux_dma_dir dir;
+			u16 hw_ch;
+			/*
+			 * Local DMAengine channel for ownership reservation.
+			 * Consumers may reserve it with dma_get_slave_channel()
+			 * while delegating @hw_ch to a peer.
+			 */
+			struct dma_chan *dma_chan;
+		} dma_desc;
 	} u;
 };
 
-- 
2.51.0

