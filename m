Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1214408618;
	Tue, 21 Jul 2026 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615775; cv=fail; b=ewyW5Uw9mwJ9unJ//NB66MjkS7JyqWjDAwep9oIBJrpNzMsR/StgR6lcYwwTBedEtGUGv1OqaVQrRFcZ5tasahICofaGrJ26dZt8WZpxq/HxMcvOUewFejDFuk1zJV5BY/3puvNWw4QllIx4iNut1Wf38fsO0mEYWX6aunBQOEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615775; c=relaxed/simple;
	bh=naHIT6CM0huFtX0CrEDPeX48yhCzwRc6wM8xxWqtEdo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=SVUKCwHJYOLMjh5K5ilk9k67m5XE+Ln6sFullW8N3QbkmGkTDNGoV31FMAUgA/JjPLbZV/8b5Yp28B/LTGg5namcvbh9lvqREphB/kFBXKWM6jnic7fwdiPoC9lmvqKW6caI69mlK+eoXdxBfoPSDLJ0TJqkyWNuU8/bTfeGn54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdyh4oCTLdFiXDXGJsRAzNLH002AOlkumXt9EPVSz9MVWn/iDjs7Fxjzzx4Z+zeFdV7lpn0h6lMYtc0PXGeRwF46MReEUzVnTJpwn0qwQIAvUedrsc391npIxqT2j0i/XfGKrwq4JcjJ7IoeYkB4kNnPjtyiZq5LEhN3BBcKxsTPn0sN4T5yj4kEdaIzjacaU5Up3JN9htVsHIhOlTXyABYIbaWk1zw3Jo5g/9u2/f6RB3ee1Ge/N5mcUej4+Q0ckArbLUo3EFW0ey0yqd4a4otIhjYA60RmK94vZ0gLo832r6qKo8DU4mYjDImEPJRgLqcNZD3jRCx7xZyU7KdmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUJG64L+bu7t58i1zhGNqDHThM4o73JftA0e7xgEKCM=;
 b=ByM5Uh/zeailZCPIw3QostzX6ymaTl/Vq6C39Xl7xiqA5Xexh8I5iUuC915z2QwsiXUWhDm0+Ng66xlLZklfXcqs5VRFkIqIYPtz+mx9d3UwXnn1n+/tpQomfLizZgE58Gqy0ALsoJ9ZR580oynsdLRJAxJ5WhU0Fr/Qi4lBKSTU3vDGngvRQ2nQ4sl35FRgA3ukSM20oxX0bAaX69cwCrZ/QoW/EI6j3nHifssvu/296QJJgaRmkJZFPHsSCEnEqnYuJaRJfQTry/+ttU3mUc/34KdnOdG5jL/4E0zNS/3uAP0Teu+xqaHX5JUvMAAFD3n76GSdG61kKmblPv0QNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) by ZQ0PR01MB1158.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.17; Tue, 21 Jul
 2026 06:21:25 +0000
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 ([fe80::9e88:7d6b:fd6c:cc6a]) by
 ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn ([fe80::9e88:7d6b:fd6c:cc6a%5])
 with mapi id 15.21.0223.017; Tue, 21 Jul 2026 06:21:24 +0000
From: Braden Zhang <braden_zhang@lecomputing.com>
Date: Tue, 21 Jul 2026 14:21:13 +0800
Subject: [PATCH v4 v4] PCI: dwc: Add PCI ID for LECARC PCIe pmu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-pcie-pmu-v4-1-850a4e695b19@lecomputing.com>
X-B4-Tracking: v=1; b=H4sIANgPX2oC/3WNyw6CMBBFf4V0bU2fUFz5H8YFtAPUyCMtNBrCv
 1twQ4JmNnMn95yZkQdnwaNLMiMHwXrbdzGIU4J0U3Q1YGtiRoywlGSU4EFbwEM7YQlVprRMNS9
 TFOuDg8q+NtUNBYHu35ufygfocXWsrcb6sXfv7V+gW/eoDhTHkTQHqQinvLo+QfftMI22q89x2
 +SB/cNZxAtuMm6EyYmkv3G+x/kO5xGXIAplFGNCmSO+LMsHd1fVYzoBAAA=
X-Change-ID: 20260710-pcie-pmu-5ef78c56c3b6
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Brett Zhou <brett_zhou@lecomputing.com>, 
 Lumin Liu <lumin_liu@lecomputing.com>, 
 Notics Zhang <Notics_zhang@lecomputing.com>, linux-pci@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Braden Zhang <braden_zhang@lecomputing.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784614884; l=2202;
 i=braden_zhang@lecomputing.com; s=20260518; h=from:subject:message-id;
 bh=FnyETFb//U9q7q/lWx3XfLsRC6/BbGBE6o4EJlEkuxw=;
 b=V96glR58Ab5BKd3HkIqHKdVjPaQQDnR+DeXAdD1qQrTeddmNzwd67nEaAqDDyPUhhuvV3BWhF
 G6iS1+aLLf2C1wZjQYhqRD/pDsqgAqbAwfQhTwv22trxSZxEad44iVe
X-Developer-Key: i=braden_zhang@lecomputing.com; a=ed25519;
 pk=d7V8RTvs1pxSx8mPaXNAe9XWo7K/eHkcVBWTjw1rwrQ=
X-ClientProxiedBy: SHXPR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::33) To ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1206:EE_|ZQ0PR01MB1158:EE_
X-MS-Office365-Filtering-Correlation-Id: f8908ddf-3b73-4f56-e1fd-08dee6f04a62
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|38350700014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rxm2D2stroqJTJ3HgFC0itqP3DXpeH74vzWg/rWzrxcLpc6vNYltXnKAs9+Qx+lP+tjTFeHzSPoGh3GySHGH8dSXDZwrajNnkW48D+Tx9OnZaRbOQoB6kIJhT/axQPS1XguixwjSIeuoOhHRdRPAuGxS4hQXp3Mkbf+Vh/blI93iTSPsos7nUtM9FENh6l1PtQg1l7Yq/u3uAk1sxKv2Z89Som24DpwIvwtrmgppDijIXImz0wzj/iz3CzJ6S379VKcejTMaI0wNUbJXCbbFPCnPG2gAMLirHL0y5MUFfm/q/dbvWZD3G7wYHCJ5Ye5RfsxKAXa4EwcIC6ubMS3fPQwRjgzJvkZjk9X2HkhAQRr1Agreu1Kn3jKcTNfkazlVkQB/UFAemGSgn1fX1RnRPyv6UK7UWop9XUdXhlWSUIJ09PW9FTEiJM5HqvUP7kOvHA/DkT/mmY/VSUH0aTzMkV5eZMGF6GaKbT6y781PwdhH7TVDFQBkaPJgJO6xvxM0be9yRkvKoJZquaK4VZ9UxuyoVAkz3+iGWbAimSTxfekRbsvxpKepBSyUgNNS+tX0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(38350700014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUtCc1B6bFJRYnR0RndlV0hmSDVLL0FpdVR1WjBScUVaZDZUNGNreERLMkNv?=
 =?utf-8?B?YnBYZllxNlhyTkVBSHlncVNYNzBuZ3BWUVdPUlZTckJIMmw4MFgyazRjd2I5?=
 =?utf-8?B?NTFJVmgrakNER080NjVWVlpFMlorUTcwWitTUDJaZTVYdEZzMXRIZTk2QUtB?=
 =?utf-8?B?Q0h4SmFpTHNsWkdUcCtGbHlzTDYwWVpSdTUzL0lEUkkvdXZVQ2VKRndEVmxK?=
 =?utf-8?B?TE9xK1N3dnRtMXZ2RHM3NHh1ZUdEWWFKU1E2Nmhoejg3bE82OGZlanNqdG94?=
 =?utf-8?B?VTRyNUQzM2d2N3BnM3JzeUZraEtVQWI0V2hyQWViclVTaU5PakxSSTJ2MTJK?=
 =?utf-8?B?alc1L1NZRVh3d1drekdybXVTTGEybHZpTFlUUmFobnFxRGVjUXAzWTNRaDhD?=
 =?utf-8?B?cEpEVlNBMmpHWVFZN29kUGgyUmgxV3NwN2tUMVhaOVRGcnluS1AzTFlORkdw?=
 =?utf-8?B?SytDQXJUenNPN3NHT0Y0R3l5SWV6K3dRZ2l1Zm1ualBmM29VUmZZeEZrQng5?=
 =?utf-8?B?WlhWN2IreWRaa3FjYTJGQUsyVzMxQ3FQUG5KYjFIanRZT00xcEM0S3NlcWlj?=
 =?utf-8?B?TmV2bXRrVTViU3RpaVBodGhwZ0tjdzNBR1U3dS9oWFV0N0VDV1pTeVN0Z09X?=
 =?utf-8?B?M0w4VEx5Ym9OK1FBK2hYZUE4bjQ5VGVVVUhUeTJSYUFrWGVuenFBdk1pK3Fz?=
 =?utf-8?B?cTFtZXhKcTdCVWRBOEVVZXNmeUs3VGFsRjFwdU54enBFNG04UzJOZWhQVXpI?=
 =?utf-8?B?U3JoREc2d0tQK2R0TGRmc21jdzVkREwrb0h3Y0g2T1hvenMxN0lSUTNoZ0po?=
 =?utf-8?B?K1RkcVRjME9YL3djLzU1SmtSWVZZb2JHeXN1bCtYWngwc3lRSExYUWRaWXMv?=
 =?utf-8?B?dUVHQjFjNEZEdFRCYXBBeVRZdjZXbGN0MitLRk9nQlNSb0dlaTlHNGt2K1R1?=
 =?utf-8?B?R0VHczNLRVR4YTVFSFcyWnd5ei9GNW1aNUpCVTV4Q25nNGliY1hTY3JRczdP?=
 =?utf-8?B?Ylc1YTF2eW01dEVJMnd2d1dQU3JQU21OcVBUVlpuRXh2UzhGTGRteXVoMVBj?=
 =?utf-8?B?bHplUEIzT1JNd2x6YlpVUTR5Y09ZUjRXUk5kbWh2TDJXMUQ2UkMzdHRYTzhF?=
 =?utf-8?B?MWVieHBEbWtzSWFYallOdkpUcHJYVDk3akZZZW5naUVqRXRxM2ZDcC9DeDVP?=
 =?utf-8?B?QSs3L3ZuYzFVREhaZjF2L2ZsSTBRN3NxaXYxVHRRaDJIYlUxWStVYzI0RnlI?=
 =?utf-8?B?Yk9FVjM4V0VEa2w4WHhWWC9rMGQrdkpRYmdQbmdtZkxUVFBVd2tLZzFYM0VW?=
 =?utf-8?B?YjZjTDdyemp2eUJsMUJBSjJlUnViQnZHUEdudDNxVEJCMW1VTGNybXY5ZXdT?=
 =?utf-8?B?WFBKc25GeVpCVDcyaERycFpSTXdnTlg2SDVVSXVjVk9lSzVZT1RrUHl5aE1z?=
 =?utf-8?B?OWxwcldTRXlSdXBGaDdPZ1RRL3cyQk9VSHk3Y0tELzFhK25XaWVzQ0w0M21M?=
 =?utf-8?B?a3BmMCs5Z2kzRXZpbmpoaHB5WVI2aDVFbjNTcE9ibzkxMHpMQndoRWtVVlRv?=
 =?utf-8?B?bjMvWmFZUDF2cUNFb3BPbEZlYzFpaVRpUllTVVpsQXRkZDJXaG8wUkJvZWhB?=
 =?utf-8?B?MFdwR1hTQ3E3aHhMYStEWjFqdjVtcEVKVlJQZVcxNW1mU29yUk9CUGw0UEl4?=
 =?utf-8?B?UXBWcFJJWDY2UWl2TXJQWHcydU42citLQkdUMTNCV0k4bWx6NVFVcEw4Y0sr?=
 =?utf-8?B?alo5dkFkSUM3akNqVHBwV0h2NTd1TkliVGRTRmVNMVZVbG9JZVllV3o0TlAr?=
 =?utf-8?B?TXNLVyttM3hXRnZDbHBMbzlnbFRpQi9KM1plMEJmOFFuWThKVEtGY2syaXhV?=
 =?utf-8?B?bjhobitYT20yK0dlTEJtM0grZmpvK1M0N0UxUm1WRjdITnBnSnNoRlB5Y0FL?=
 =?utf-8?B?SEsrOTVxUEhvSm4zTlNQK0wyRUVEbVdoYlYxSTU4WDJqMnhBS1NaOFlmQlVa?=
 =?utf-8?B?K3c5RWtKK2IyQWs5OGorNnJIME5pVFFRL2JMT29FTFVNSjUvSFJHRGE4SEhj?=
 =?utf-8?B?UTR6UEsxSnNBMDczak9UbGZXdjBIdHVYdTJNRmUzaFhBbzJ1Yk5BSENqNnhH?=
 =?utf-8?B?R2F4UnBvcDM4WG5FWUEzR2JWaUNTemg1cXBuRDhkWTdjY1ZjVzZuNm9BTU5v?=
 =?utf-8?B?UGlVa2lGRUZUSlpzZExRUzJXbEp1VFFEOTl3a3RtMlRrQ0Z3bW93Rk4wYzhX?=
 =?utf-8?B?dnUxYjFDZlByS21qeUh3aXVzZndjbm5TV0V0UmhTNE5rTUd3RzhZTTY3Mlpj?=
 =?utf-8?B?czVaNzFhVUNsdXFDR0xlaTBkT0pQTURlUHFUZktvNWhYaE5QTEZ2eU1IQ3JL?=
 =?utf-8?Q?fX8e1qYLAbtZVQ5E=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8908ddf-3b73-4f56-e1fd-08dee6f04a62
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:21:24.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyUifanMlVgciG5l8p5mf953oqGrI5KFZ7pMF6erCE5OH6jrYPgPFQGRYPbz3BID7ssRNDpaUTsOHdh0PA43xXSBXtPvAymUjTrNiEDXFBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1158

From: Brett Zhou <brett_zhou@lecomputing.com>

This patch adds support for the PCIe PMU found
on LECARC SoCs.

LECARC platforms use the standard DesignWare PCIe Controller,
and the existing DWC driver already handles the enumeration
and basic functionality through the generic PCIe core.
This patch only adds the PCI vendor ID to the vendor-specific
capability (VSEC) list, which enables the standard DWC
RAS/DES feature detection.

Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>
---
Changes in v4:
- Doc: Update description for the DWC RAS/DES feature detection.
- Link to v3: https://patch.msgid.link/20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com

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

