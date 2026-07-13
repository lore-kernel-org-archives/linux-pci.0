Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2105.outbound.protection.partner.outlook.cn [139.219.17.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E8265620;
	Mon, 13 Jul 2026 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909566; cv=fail; b=tOsq4A9bke78Z6shsj71P987y4OHNmuCRaD/AgjYkhS4eFB/JQMyQXJ8XJs1dhnOJKCiRcdq17KJoXBhNpEvUcoIQES0G254KIWgqnLGTEBrbJo58PKUm1o2a6gbwYX9pYRVjOXOvWKDVzO+LqweirYTzYt/2KdETTfeAG1hqjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909566; c=relaxed/simple;
	bh=Whf9VZrfF8efR9i3VthxVIMmlOyzldCkU62rbBt96h4=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=SsDhVmkEP/THdmorfAlzbsm5YsBKde8rkyvPdDdlYvCKw3Zt+f5YFAjtFiFZo/UuCYj1xe/FRFSp99argUPTNqBKO4WWkRUqC/m4aaA510psDAHzavF+NCnUCmZKF7MF64qwfWUHJ0E9PE843ONQYZ8c6/rVrYU3/V8Avs/d1yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.17.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKzHbxbI6GMqWTgnMA+apghyEz4qPnuhdNFrHEBxt22TAymyLyF9LtWYeiZs/U4zOB1en8TnDVWN9oeD1h1hb7v3LQUp1Bf8e0GaNR2LwnBv/SuMmqdATOiw0AUxUfpYBIHijSZgu/OLk7ZYE1T/T2Adrvbvtd6XeIMdvvEb4OPL8HIe+Vy3jFhB46FyF5qCVBSpz8IBgrEX98kD6ag9KmFHRjEf5fp7nIclqhyps/ZAjdjfa0qmeI/Dkpg9JdcmFb5aBJ4hmug8uim04826MQkcO3jcoMaQzNJwLBMGtM1wSgJYD16dSQSC3gFIip2NPgQy0r3a/O5GJewRCLHTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOObv0OOWrUd8CmIu4cZkFTfmHdIcMofNS+Z+EhLYC8=;
 b=Qe29Og5cnbMQus811I/jlv25kJheLySB18otYd7NuP6TZtdjUSYQ/YjassuD13edZP9zOmUccMnuR+ABY2F7N6BrO/DwX/ByWC5bD5qrMaGTwvhRNKyO4ucy2R6D5Q+4PuwREA2znR7uKBs/lMguCxn57FvLUdVM9gxvpr7u472YHn6+xAS98wu1JODw2S/3wfD4pdlGGDpFrorH3WozbLnA2ORIH2+UO9XNeEp358t3xmTQ5auKtvtdv334g7nvx8694lDdmWQclGOdMZZ15PpYKnt5d4K9jHx7gs8ePTJYN0KQqW/bvO/CDh9lS/VMDXtkwrmYsO0ncKJlWtA12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) by ZQ0PR01MB1207.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Mon, 13 Jul
 2026 02:10:26 +0000
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 ([fe80::9e88:7d6b:fd6c:cc6a]) by
 ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn ([fe80::9e88:7d6b:fd6c:cc6a%6])
 with mapi id 15.21.0113.021; Mon, 13 Jul 2026 02:10:26 +0000
From: Braden Zhang <braden_zhang@lecomputing.com>
Date: Mon, 13 Jul 2026 10:10:13 +0800
Subject: [PATCH v3 v3] PCI: dwc: Add pci id for LECARC pcie pmu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com>
X-B4-Tracking: v=1; b=H4sIAARJVGoC/3WNyw6CMBBFf4XM2po+LA9X/odxAe0ANQJNC42G8
 O+WuiRmNnMn555ZwaMz6OGareAwGG+mMQZxykD19dghMTpm4JTntGCUWGWQ2GEhEtuiVDJXosk
 h4tZha95JdYcg4PG7+aV5opp3x071xs+T+6R/gSX2qA6MxJGsQllSwUR7e6GaBrvMZuzOcUvyw
 P/VeazXQhdCX3RFJTvWt237AkBMf1n7AAAA
X-Change-ID: 20260710-pcie-pmu-5ef78c56c3b6
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brett Zhou <brett_zhou@lecomputing.com>, Bjorn Helgaas <helgaas@kernel.org>, 
 Braden Zhang <braden_zhang@lecomputing.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783908625; l=1794;
 i=braden_zhang@lecomputing.com; s=20260518; h=from:subject:message-id;
 bh=+Mj/m2DFzONZNBtVFIXZhu26nuzOaExKW7w3djm7zJg=;
 b=hcj9LK9lHcjuwLdktGPaoWFFIMwN609adgpr8Bz8y/ZB40n0FeNxqde+ogEdVraqjWelY6wVs
 +n4630tJSQpBkZ6u34MkIpn7HSnJotIDnABL0Cjxg/5VwhtysdVu+XV
X-Developer-Key: i=braden_zhang@lecomputing.com; a=ed25519;
 pk=d7V8RTvs1pxSx8mPaXNAe9XWo7K/eHkcVBWTjw1rwrQ=
X-ClientProxiedBy: BJXPR01CA0064.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::31) To ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1206:EE_|ZQ0PR01MB1207:EE_
X-MS-Office365-Filtering-Correlation-Id: 672988c4-d2fd-40db-6dec-08dee083e747
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|52116014|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Ex1VbQRk877a5gCPY7e78ynMtHGDGpdrcxczjMerQgvrw+rBMFWTcHoOST0nTQT5P6y27viGZmZBkXkwGaXnFZerAjV3U6yFMR8RP30M7XSXxtKA7GZtLbe/3fEXYbDjhRaWf+db+AE00nB1164OvBtMtub56vHnO+7oGdgQFyXeczTf6j7aOb4niU0YCS4oG5q5ybT39XdAdhz5N77iZStbVZhvE6GGjsGAZ6qbvK+lACJpH2IbEt2Sqb9MGagZvF8tncAqM08j3BT0mnTTZ3Hjsum/pOOIlBFDExMDNnqqRqdfgxOx2kZ96BPHS+1kikq9J9XSeRhnqad0ze86q0Tw4owOl5Ssdzl48jMP8gPS0o/PiwRYLoGgrwwIUXpSAL+aUVEzCjDmIcbJrhdqkh5iCBlOq3eVgzoTMCTlbk4rRbmywI3+iGfXV53HAR5NkZb45nbRmfFegybILMuzSa6UnvWSdU9uRnvDZXIKPsA8XHdqOOEZlqrLqrfonpUfLGy8DFGq56x3+n2GudRKv1SCzaDVlx1nWc9pfXzZoahomj2FVx2iRaJIS7lgqbFG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(52116014)(56012099006)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUJxRE81YkpxTTlleWVtdkNXQTkwK1JzUjd1S24zVEprMWUxSEFHcEZQKzUz?=
 =?utf-8?B?Q1ZxRWZsQVVraHlneXYyZkRSODJWd2pCZUpDVEl0Q1ZkamtiQys2NWFvUVEw?=
 =?utf-8?B?bFFGbWY0eUdGSWhIaWRzdUtEQm1hck9FcmIydHJDWk9CMVR2QmVENEhxOE54?=
 =?utf-8?B?NFlWbDhPNW1yWUJIZ2pBQmVpbXphSm5HZE9CbkFTWEowdG1QMHRKaGhUdC9H?=
 =?utf-8?B?Q1UwaTIweFpKazlrbDc5R1N4R2ZmZVNUcThtVEtWRitHcFQ3Slg1TVp5YVlX?=
 =?utf-8?B?aE9ZMUFCdFlDTlVackRYOWxIanVVZlF6Z0puQnhldlVNcHg0L05rcHZCQ3Fz?=
 =?utf-8?B?Z3UzbUFKaUpCTHFXZmZ3Qk4rcmwxSFJaQUpJcDdGZFd3WHh2Wlpqb1F1eDZa?=
 =?utf-8?B?UHJ6R1c0aXB6R2F0NUhrUWZaYmRuUm90UjlmRHVDODBmelRyREM4VG53MFlI?=
 =?utf-8?B?cGQvS0QwenFwZTE5R0MyTll3Y1dFbk9UNm1jbW5YazJKUEdUYnYvM3VBWit5?=
 =?utf-8?B?RnFmQzR3N0lBTlAyeDlsOVVCbWs2U1h5TzVDaXZwb2x3Z1ZxZkZmTGdlM1lU?=
 =?utf-8?B?SVFzWnRaL0tYczhFelhEMkFNc3Z2dnplTHFmSWtVdC9LTm9NUGtTZlNTUGY4?=
 =?utf-8?B?a2VBUlRZTXlUYzBDTXBvanIrZzUrUU5OSDRoZDRkekF2dHBXaEdmdkgxUG9X?=
 =?utf-8?B?R2pQVzdHdTd3YU1GV09mWWtyWnp0ZWVjVFpUYWFsdk5ZZ0RNbDl1Qkc3b051?=
 =?utf-8?B?U2RobkZxeUVnUVlpdlBXR3d6QVZXWU9tR2RGcVlzdTkzdStobFR6dXFzOC90?=
 =?utf-8?B?eTBUZFh2MW0yc1UraG9pc2xoQmlVdlFaN0xGSUhheVVGTUNuWEdSZFBJKzJj?=
 =?utf-8?B?alp1Z0IwZDEyWEpWamVITEFmbFBjY1ZrNngwMFdKREs5MTRmMFcvS2l5YWFl?=
 =?utf-8?B?dGZQcHZqc2NWMVdDOU9PaEQyV002cW5jWTl4amFZWW5DMmV6ejFlbGlzL0Jr?=
 =?utf-8?B?Z1MxTnZWWEN0Y1NzZnlDbUNqNTl5aUREVWFGS3N4VzY0RStwN254WVUyWElo?=
 =?utf-8?B?OGhlUzdFNHVmeGs5WW5TQ3JKaWYxK3lXUUNsOERXdVRyWUo3bGViM3ZMRnlD?=
 =?utf-8?B?ZWJOTERrRjcyc0tCdW11bGN1THF4Z1N1QlZCdnEzYTZrMW16dXNsZm5KVEJm?=
 =?utf-8?B?OWZkNm9nRDZIMUZpVS83TS9PSzF3aW54b0pEQWh6RTBkMFFMRmIrOTBYS20x?=
 =?utf-8?B?NTlPZ0VKODRGRGJQTGEwL3BROWtNTUVBYmVTc3NURzU0STFWTFptbk1xWFda?=
 =?utf-8?B?NjE0cmRONmJGQnV1Y3lDYzNlS3QrYVNBbmM1b3lhL0E4SWhyMXRYTUZHRkEw?=
 =?utf-8?B?Zk9CT1g5M1U0ZnhjbG5PWUMwWjBhYUVKM2t2ckMvcWNXbjVVUTlXRFdWQmxq?=
 =?utf-8?B?bHNSZ0RsdkxSWFNsS3VUM1pyM3RCTnA1NEJ0Y0lKczZHZjJrbSsrRmRiRGJh?=
 =?utf-8?B?bkkzRDRUMStsSDN5VzAwWVBOWHNOSUh0M1NlV1JOcjUva1pNUFp5cEZ5enlw?=
 =?utf-8?B?K0w2Q2dEOFNnNGJnWjBNOElxcG5tLy8wQXdmMkJUUmxlZkIvWnVTNXRBY1Vu?=
 =?utf-8?B?Ym5iT2N4T3RFYUZzL3NiWjdRdi85UkMvNFZBZzV5L0JSVk40YzhjOEhSK3ZZ?=
 =?utf-8?B?VVhoYnFBRW05bEZFU3NzZG5vM3kvZi9XaXZlenVGVFUwdHptUm9XRDdkc3hV?=
 =?utf-8?B?RVNtQnQ3SjFteE55cFJyblVZNEVSVXVVbG43QS9rLy8yUkozaVpzbUt1K0Er?=
 =?utf-8?B?Q0V4VEJMb000VFpMQjNCaE83QUw1RWZSY2c2cWcwWXZpTFpweGhpUW92aENP?=
 =?utf-8?B?ZGU5a3NQUEx6YmhCcmNmVTRzU2taVkNSZzYyMlhWYUhxT01HZDFLQzV1WFhF?=
 =?utf-8?B?dWFxRm83c0s0RTRKMXdQbDRrYUpBOUR0MkFVenpxY1lEVmJRK3g4TjR4YWZH?=
 =?utf-8?B?aFVpK3czVVhzeWsxekxXcXpKa0p5cVdyd3M1VjlHU25UZEpHSHdReGNSNUZa?=
 =?utf-8?B?R00rbmV2Szh2Uzd3WW8rN1pGSTRxSEV6ZUp0b3diUDNIMk4rZi9YMm5sVWhy?=
 =?utf-8?B?Sk5kN2JVaE9hc09oQWZUQzlWY1E4N0VoaTMxcWI3Wld3aVZBT3I0ZnhxaDYy?=
 =?utf-8?B?RUtaNitrbW5OajNFcksvYUdsK3hCb1A5SjJEdTErY2JvVlVJZ01hU0dqeU4z?=
 =?utf-8?B?VUp6bGxqWUhlV1p1ZVVtbWJESkhib2d4dlUvbDdCazJkSisxNG1oTWJZZ0RO?=
 =?utf-8?B?QzNGeEN3Q0s1UVdsVTA5OUNUWlNScEtOZDd5cy9WTDRwY2ppN3l4N3ZlNmdr?=
 =?utf-8?Q?ZgbVpmeRkfVzbnBs=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672988c4-d2fd-40db-6dec-08dee083e747
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 02:10:26.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox8yH/s5H643l+qmrtMGpQVs2LBqORzOEWn+VenAxUwZpaYULYExMW1ZIflNlIuhPvz/wweaal7yqrzfewZtC2MZs9+4E7LMtmiO2gVUgXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1207

From: Brett Zhou <brett_zhou@lecomputing.com>

This patch adds support for the PCIe PMU found
on LECARC SoCs, which utilize the DesignWare PCIe Controller IP

Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>
---
Changes in v3:
- Update: move definition to pcie-dwc.h a
- Format: Update the subject line to follow the style of previous pcie-dwc.h changes.
- Link to v2: https://patch.msgid.link/20260710-pcie-pmu-v2-1-a3d73d4d9051@lecomputing.com

Changes in v2:
- Format: repalce space with tab to separate the macro name and the value.
- Link to v1: https://patch.msgid.link/20260710-pcie-pmu-v1-1-1519e580313f@lecomputing.com

To: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jingoohan1@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/pcie-dwc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 8ff778e7aec0..0df5fa81b561 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -11,6 +11,8 @@
 
 #include <linux/pci_ids.h>
 
+#define PCI_VENDOR_ID_LECARC           0x0720
+
 struct dwc_pcie_vsec_id {
 	u16 vendor_id;
 	u16 vsec_id;
@@ -32,6 +34,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_LECARC,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{}
 };
 

---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-pcie-pmu-5ef78c56c3b6

Best regards,
--  
Braden Zhang <braden_zhang@lecomputing.com>

