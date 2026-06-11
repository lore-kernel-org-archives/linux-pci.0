Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772B32863D;
	Thu, 11 Jun 2026 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211620; cv=fail; b=mj+q8qauccRu1n6xKwTlJlpNuBgh9SQVqE6edTUbWrP/Rg8TLqf9NUlOpoxeTk/DzjprEWnbJwihd/UvCqZL3THDpOVUyttQf5+mtsDVbzJ9XEbZct5WJKseig1Nw1gs25d9v4nFUboF4I+1BPkuwJL306huYWUCx9MkQCNlYCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211620; c=relaxed/simple;
	bh=3g8MHVBixgjZNnOk6WO3cxS8gEVE1fvVKMPExmnyZRs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P0IOo591HdGeS8l8VW/a24ufmuBZYG3LzIiLHASD/UgjsHhzcEU6I2cRcJhrbkPgorMkfiyL8stvOz6/jV8uvanro1LhPsaMBkRpW0J0Epv3Tfn1E/00eHUA9ZStNM+hXayRgA7HKwBVCzNN7SCr4digfGzFJpWWKokrhe++qzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bwIKcWS1; arc=fail smtp.client-ip=52.101.83.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bwIKcWS1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6aTKbo/zRJrdSpe2dqVoHYBflPL0ZqtgFIRQP0hLmvy3ZTAV+TCVMNBEK7fa/spvjfhsAECNtwpAQEUpuIo4KC8mQ8Aj+alV2mjzKsCqHwqSYl43a8Eu8jpnwS4YAp0LxvjdzywjsccWZk0TSHozqbiHplNbhK15woUG9Y2V6Am13LemDaW1pRrotbBvKyedKxvEUNDTe8TLCapr71+5XLFoi5z1nnRAAyxInj9diYObsuBYyN2xkiEqHVf0kWDSusbv0gO8LCzdBFPsjFOhyKpMTPcT2+wllDiCOhemV0qiTj1dF8iTvT7H4QFRh81VltQaqzKXtAURiWWLrX7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/79D8BmEsWJZgXomdvw4Wh1wafDCAcSk5lj7hAThCY=;
 b=rY3yucvsPyLEb2Bvp0S2HcqjncHGZYjrDL5eoEu1v6i9shipEp7lzq90uDNgQjF3FjRMpDzhUmbdi1/rQf1MP36+Wn7kbBbpt2hUtSsMqIJSmUT3diwFCNkgNUGyd5yiW6o9ln8kSBIQM8QkqJXrMZwF19orIomvEAcsmKSaPURpVQZRK20YKJ5jkz1Fc8cw9zl5Vg38AmkT9dPD97XMKkrX6xGw92Krm15vYunmOn6HYP5XQqJnESsn9VY1xsfxCvg8IPfRTou94R/JEtjTNRCtlu0SR173w1LJXR2by9LRaTkmn2NRBmKAYideHENoj0UGQPs2lcj40wQQqh/biA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/79D8BmEsWJZgXomdvw4Wh1wafDCAcSk5lj7hAThCY=;
 b=bwIKcWS1pxz9EiSvfkbBXvV7nGx71c9N4miHhbRFv0vFRpbvWI6wMODJtSHVkEX969CdbZdhkd2r4IDsW/ebyo7pzdcqdVgI886udcm76XotIuQRuQFNO3/pTHANKQVQkeOB9K8olucR3iHjvVlD05rSDvQLwYHC1nlNIH2lsWbp6wXkhql3+AJZZBo1AiCeI38pft4EEcCUi/q+O4FpPfO2Ehi9FgAnsI38jVaS9eLG3cV/1lVY1nmuTYRiMY22m4Wgflg+aoMOkJ/d6T3SZUAWiftbFgu9Oa9IucH8z9AyJaVJ+tQWV9bDe4ClI+uHzzo674/e8c2CZ8YkN7hg5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10563.eurprd04.prod.outlook.com (2603:10a6:150:221::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 21:00:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 21:00:13 +0000
From: Frank.Li@oss.nxp.com
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] MAINTAINERS: PCI: endpoint: Add Frank Li as reviewer
Date: Thu, 11 Jun 2026 17:00:05 -0400
Message-ID: <20260611210007.529205-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0010.prod.exchangelabs.com (2603:10b6:805:b6::23)
 To GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10563:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5bab1e-80f9-44b4-aa2f-08dec7fc6e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|19092799006|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	3Sq42ENsufbwBO1fkPPvQbtfChsBCEhgMZgHGkr4KFcDJj5RUg7RHmHNQICejnOLYLnKSr+y7IQzQlmY/LT6MMbB2eVHJJh71QxZMzlcbi+JDbbAmXPXDXRvFZLLM5HkSVJh/U9PkSEEDAHhwClFRHGW27H0X2H/Y+yh7LEdJzoPAUDDFvy4mpeAxuuYI4O3EXpsdbnMaWx8OgvM5qebS6Vm855+rcX652KnRaes6daLOA9z7vxjyHbRDWDo4ojep0B82S+4arrCwU+pxomAws2rBGiY1aTZzTjWc57FZFHhOgilcFUe75baksYgtIAm1+45uhws6/ZJiWZgzC4VfntEIfrssAQ69b5dt3K5scwb94bDGFgu/gLN3z/uOx+Vm6l8kfCL5qIIXoMw60eEP0g27E0PexiLRGft3xwryg7yKUTogHZZpbw8dsoaNBFGsRAGKqObymsa5ZROI4rzUX7MxOSI0QKj+F70GGCOL3sVsbkSk0GgMgPpbtqmC4oKLGzYl7MZHYBuBJcmo0ieiTTJ05TYM/NiyLCFdRMIZWT8VTvUEwPMiJ6JwpU7HEpzXZfRPzB8NvxviaKNE/X/5QxlCvy9JrFO590/EVC24+RL5czyGRLnbtip7ye2UykyCHqZlIKT1yJKgT+iOKqlqYuaWslMyD3EL2uQtvRWoEgRbbez2iVmXHdKVruJX9lk6rt/a3u8knnwZcsl9xaAYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(19092799006)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUI5Z28rWXo2a2w1QWxnWm1sS2d4QlZReUlOSlR0bW50NkVhTTNEY29LRlc5?=
 =?utf-8?B?QzlEcVcvUmNMNENFYUE2M1JFODJiajVmQ1NGc3cxSkZxaTZiTk8wdTlBMlpK?=
 =?utf-8?B?eUdtckI4aEd5SVVwTnc4YXcwck1DVkRLYVhqZFpUYWwwSTdBZ0R2OVh1ZHQ5?=
 =?utf-8?B?N0tyR2tQRDAyZkRORCswaGFTTTRvc01oRk0wS28rUE1rbVduMnVta0FVNjNW?=
 =?utf-8?B?SlFzeDhaSm9OalNrOWg5YVdJSnl6amhUTDQyMzNTNCs4Rk5LelIzaGl0NDMv?=
 =?utf-8?B?UVo4NzJiQzd1SlRGRlg1bk9MN2NOOUZlSmlFS1MycHhHVGhMc0VkQUljR3p6?=
 =?utf-8?B?SGMxN25aV3JocWNHS3lSKzlXOExQR3phUm94bFRyL1lsQS9jbXFFaDFUcXBa?=
 =?utf-8?B?TG1uYWpHeTg2MjJScXMvOVBsNWxwMmU2eGtraTMybUFkOHJscndkaGNUVWFm?=
 =?utf-8?B?UE1Qd1F6V1BYSEZuSnN3dXdJZGFZT3dGNHlydmpaRzRvcTFJb05lbDJYWXg5?=
 =?utf-8?B?aC9IZ1dBeHF6REttbW50SUtSK2tlTWsvRnNmUjBwOXVhdmlnS1lGdzUweXVa?=
 =?utf-8?B?QUhsYzJZL2cxT3A5azcyU2pqdURQNlZ0NlRkbFpNcmxlNG80TEFxM1kwbmo5?=
 =?utf-8?B?NjhrMXFVY056UXRMdVhyaVQyTTRQUFNubUlzTk1ENHBCTFBUWFZUZi9sVXFK?=
 =?utf-8?B?RkgzWVlHZ2ZlbUJFaHZzSDZZYndjelNNWTRhVUViL0FlL1FjY1RUdU4xd3lQ?=
 =?utf-8?B?dVZhcHVPYWZaQVJCNThpRWg5M0M1ZmFySjh4VXZpNTRrWHBhRjNtVWRFK1RE?=
 =?utf-8?B?NWNhRmJKUklxMitaZFdxTkV1Z0tCUGo4RlVPbnN0RmFJejlXYm1JZ2xqajFS?=
 =?utf-8?B?Uk5iN05oVEU1WFJnR1JQQUg2WnlrS0pOQ2d4UTAyREFCc0VyTk5KMDZRRXNj?=
 =?utf-8?B?WlRiYW9ydjlsVW1DTk5zYVVZM3lxRkNrT1hZME40UDdONFJGQ2FFYk5mV2Vj?=
 =?utf-8?B?Q04xM051WURicC9jZXlQSk9kTStLOEc1QUtGTDFrQkYrZDRsbUtGbjZnT0V0?=
 =?utf-8?B?MWhsaHU4SWFOTVZ2UzIzMGQ3K0VZVWpsUkdDTXluVFlMWElvaTB3ZDJjOXV0?=
 =?utf-8?B?SllibTVjYm5OT0NSVk43WHhKUVZkcGVLUDROVFdQaHhTMnNhcTZSK2xhTTg1?=
 =?utf-8?B?L3BmNTZkNk05bjBabHZtc29DN1VKclRIdSsvWk9JTkU3bHFUdHJGTGxPajhq?=
 =?utf-8?B?S1JYbFExbUw5RmtJcDY0SlRESTVwY1gvVlA4SFFpZExycnhnZ0YwT3V6Tmsy?=
 =?utf-8?B?c1FYYm1aaGVKMFhKbExMb1RySm5VRHVDL3JPbkYzQ1lrR2pnTWNVVDJxaXVO?=
 =?utf-8?B?T3Jycm5nZG1sVHlsNWtCM0lmNnF3L0VVNHVZakNPQzFSd2xLS1MraUFCSmU0?=
 =?utf-8?B?WEdOWU96QW5KZm9tdjFWekdoVTd0L2NGMDhuZFVVSE0zVDU0ZllWaWdEaVlr?=
 =?utf-8?B?dVlMYkN3azFFNVdkNGRua1Yvem5MMmJaRldaSVF6VWc5US90WWR6VTBUNStw?=
 =?utf-8?B?Z3htWDdhK0hzTy9Eb29TL3EzSlYxNEhQcWRXZ1o5L3ZxMlRZT2htUDlIdHZn?=
 =?utf-8?B?Z0hpWWlnd1Q2Rk53RlFMTU1xd25hd0tiYkJDMDM2eEtURUFvdjBMdytwc1p6?=
 =?utf-8?B?RllnbVlUSWpCQ0dMd3hiL096UlNnbGJwNEJJMlRuck5YRjhXcFdab1VwbzMx?=
 =?utf-8?B?S2pOU1ZqNk5ETUN6ZVB3WHhxYkZleFkrYmgvRGhiRkc5VnVPNHlJc1lFdlR6?=
 =?utf-8?B?c2ZNSlByY2xoNHYxVys2Z2tuUGRlVEM5N3RlSGVsNVVRcVpXMmxMdGZ2S3hE?=
 =?utf-8?B?MmJtbElFd2RiYjFuOE03TitLVnVWTlYxdGpkRUEvenBaSDFQM1JRNC9qQlZu?=
 =?utf-8?B?YVIrdkhSZ0dEQ0JXR2hyTTlIaXFJQWNUVDc5RXp3bWI2WU9HdktQSzd3N1Ur?=
 =?utf-8?B?RzZoWjdEbTlIUXNJblBFTVhnQ0VQQlpTRmtMNlVxWWRTZVVlZWZlRndaTmZy?=
 =?utf-8?B?MG5UNmVJMnhVL0taeXFxNTZrU0NoL1BFWWY0YjMyRmU4Z29NK0F5SHBXdzR6?=
 =?utf-8?B?aWZEQWU5d1Z2cUlJS0VScis2M2poUHFQeDBBbkJmcG5vV0dBM2Rwd3loOGRB?=
 =?utf-8?B?TjlLMVdZQzgwSm5CbmtjcVFRTWtkL3I3UmowcmVSOVl3VXJpdktCQkdHWk5T?=
 =?utf-8?B?OXRmT2kxSHVhenBzVzBPeGh5RTBFd0o3M0RpdU03VG5GSEcxUVVxd2JFZkl6?=
 =?utf-8?B?TlU2OWtsaDgwVFB4N082aDVLc1Q4Y3NRMnFCd1lTNndZS3RTY0lqU21OSEp4?=
 =?utf-8?Q?JYgro8b6xClzN5jRtAOQWd4YEd4wra0cwS5RB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5bab1e-80f9-44b4-aa2f-08dec7fc6e64
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 21:00:13.2726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUVo1JddsdDwidhkpdVsPmN1RavxgcxDQ0ge85kqDDFiNET/qF8h9lxJOFaaVYbwNOFZcUzA4BJCluz+vSd/HgOgNaJgx40M1nLTB3dw4BKKfzMrdLhNLpU5Z7EKPsxt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10563

From: Frank Li <Frank.Li@nxp.com>

I has been working on the PCI endpoint subsystem for an extended period,
including contributions such as the MSI doorbell implementation and vNTB
function drivers. I have volunteered to review PCI endpoint-related
changes.

Add myself as a reviewer to ensure he is notified when related patches are
posted.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5cea10654fd4..8a9144e9206ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20749,6 +20749,7 @@ PCI ENDPOINT SUBSYSTEM
 M:	Manivannan Sadhasivam <mani@kernel.org>
 M:	Krzysztof Wilczyński <kwilczynski@kernel.org>
 R:	Kishon Vijay Abraham I <kishon@kernel.org>
+R:	Frank Li <Frank.Li@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pci/list/
-- 
2.43.0

