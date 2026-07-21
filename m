Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2098.outbound.protection.partner.outlook.cn [139.219.146.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039303B42E1;
	Tue, 21 Jul 2026 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622551; cv=fail; b=D+0psYIBQJKpBkCSSvtHn4Eq4vBKmM78jTRUJAO22DgOrLFSHIBUFw1uwpTplMn91xkByFf8mgX2mwhZ9w5/GNPltucDXjv32L1DIn9+Uv79bW9ro1GGBHPvXb/IyryT961PUreC2Kr3Ku48NcWSOP5Yq9HiNpHb6Oo9vti1eic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622551; c=relaxed/simple;
	bh=XdHDZ5bEBzaYwjKef60CzIvDQ52qEXhStCtsBsjDGt4=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=YCJ+PMFq8zpfVS+M7frHe/3sMIqN9vVyhK6DGYkYQjZPC43QJrP4QwdfvaOGegMV3sk7A8h5bi8QfWriqQCIhq6pqdS/AFXG20Wri33jR7subuoLrdaK3A/L5yevcOsZcLbX41h2KbYpHboXnMOmXm8z11+HCpAxNywqhf7DXYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.146.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCyMD6+E1dYauZut2i82sn1fKZId/lF/wIgCZv3Z7p9qTK3ICTg/5Pa1C/dMgb/TGs2YEtHzmSKdjt0LXqGbfWHw33hKw/hKBkvyeBXzlEPpyD8vyF+JoS3I3tPhKYJyOr5ccFeADCtbZHAd00PGuLOMiRdZdnx8O8MOX720VQJ2O5K1wLvVScZgslBUJEKqF7G9d3JTHVB7REXsW0SXk6PHIdzOH9S1yGVDUp4wWi6yDjv4HA5DwCMH/zvvWQvItRYF2xsXi1iv4kHjI3AqR5UXUXuua+fAV7KOatWD6yVuP9+Sq0uClg1DjVer0X5vEsmDRbJenbRgJQC7bcK8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+/C9HuWTX+cbupYT9QWXSaE2ukju07MKenLsRWkcNs=;
 b=T9fffh6cEqayXNeHpHpgNIkd9SDKBCNMegVm6DsCNHAzcchMJ+PqBxELbGtQquVOTnPLHyqb8xSuzENKcT1WCWbNV2n+5QQYh7tDy85mgE1FWuCULyZ86MkLC+DVvLLGYgR8djmiZ7V9J943I5mDEWlLJiJ49HCVRMhMvPGMF8dt/4qL6P23YQ77jS9rJSP9UrnGQdKxRuvYMqIR8yfosgu/C3cGhWw+v8k3KincojkrEXTODftDxKyp8z9a4FVRNtg5JQ7O06Inh1NFpIxUFcL0sgu4GUjZnPpQrcs34CwBZkYyqaWiF14okE/fJHO465iheW8MKp0hPFVU9zSv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) by ZQ0PR01MB1127.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 08:28:57 +0000
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 ([fe80::9e88:7d6b:fd6c:cc6a]) by
 ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn ([fe80::9e88:7d6b:fd6c:cc6a%5])
 with mapi id 15.21.0223.017; Tue, 21 Jul 2026 08:28:57 +0000
From: Braden Zhang <braden_zhang@lecomputing.com>
Date: Tue, 21 Jul 2026 16:28:47 +0800
Subject: [PATCH v5 v5] PCI: dwc: Add PCI ID for LECARC PCIe pmu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-pcie-pmu-v5-1-570e44af7cde@lecomputing.com>
X-B4-Tracking: v=1; b=H4sIAL4tX2oC/3XNTQ6CMBAF4KuQrq3p30Bx5T2MC2gHqVEgFBoN4
 e4W3JCgmU2ned+biXjsHXpySibSY3DetU1c4JAQUxfNDamzcSeCiZRlnNHOOKTdc6SAVaYNpEa
 WKYnxrsfKvdaqCwlArt8/P5Z3NMPSsaRq54e2f6/3Al+z++rAaRzgOYJmksvq/EDTPrtxcM3tG
 F9reRD/uIi8kDaTVtmcAf/N5ZbLDZeRA6pCWy2E0vY3Vxsu+IaryDWwQmGaQ8nzPZ/n+QNZGCg
 BeQEAAA==
X-Change-ID: 20260710-pcie-pmu-5ef78c56c3b6
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Brett Zhou <brett_zhou@lecomputing.com>, 
 Lumin Liu <lumin_liu@lecomputing.com>, 
 Notics Zhang <Notics_zhang@lecomputing.com>, linux-pci@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Braden Zhang <braden_zhang@lecomputing.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784622536; l=2317;
 i=braden_zhang@lecomputing.com; s=20260518; h=from:subject:message-id;
 bh=Bn8sFfhttXNDUjsaFyb55YreGdPK8lXj/kP2zKY+k7U=;
 b=IPEFYb0SHsPofFM0yjsAUzajFYaYTxDGtsBW2BeDEEE3Q5dpIiPbp7C5HRINjarqF7SsmqWhj
 EKGMzymH7dmArFsalfl2+gE31w+d4yjhv+uxbbJ52aHuH8qfv/iS3KL
X-Developer-Key: i=braden_zhang@lecomputing.com; a=ed25519;
 pk=d7V8RTvs1pxSx8mPaXNAe9XWo7K/eHkcVBWTjw1rwrQ=
X-ClientProxiedBy: BJSPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (10.43.34.157) To ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn (10.2.3.238)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1206:EE_|ZQ0PR01MB1127:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e08b37-ab1d-476d-6a96-08dee7021b6a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|1800799024|366016|38350700014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	r7HZCQbRp6pb7KJ40T8QSyvX66FPiAa6Etv9CfUPtVeJVSxQjuTUjoSQcClKZeC77USuIdKimK5e1hpwvsmZdXsJLHpXjgQ7UGY2ridugLkpOxKeZqkGH3SpfcVuMi8CG3oKS1x2ZbrVl6PuTu1gmQBCAh5V4zEfKRdBIM1JH/UvffotgnLTlds1VSU/xZabkM9EH44+niDidsj36oA6U4PBxQceOaaUEg4vR5Zmg7l+TMxAlNJa6jAz1QO6KEJjGwAeBkeck+6S5cFBGqqUCsQU3BGGKC/muOg9ZGI1eSvw3svAgvx/QadpqTOtFtUliJuALfxieLebcnW72mHxFKLFHvTpv32SQXwpPxoL1pK/V2OAVK2mljHuHcqrJlcPIjaD5/nJ4Z+CzECTyaLVBq59lvbmJ52fm4TdY81XhDAg/0F8Rdiyzwq6Mz2II2/LKLEkv7OcPu2kQyx534EUT3QsH7G6IV1KRcF2OWSpfA1RP/mNnQT+2zmkJjgaDFFvAg1VLHrX0ITW3wQh4hQCiL0Lr5uMQfJ/484XHc0o8FohU8WyiNvy4x40QVZZIxMu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(1800799024)(366016)(38350700014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlBLNE01OWlFZEJjY0RVVkJGaXBtOUUraGl5ck04T2JSd0RLUDkyNHFMcHQz?=
 =?utf-8?B?Q2V6cFFXZC95OWxGTjJrdGJBeGRVVkhpK0J3b21xbVdBcEJGWmFkT3UycXVP?=
 =?utf-8?B?eFU4QjRjRUs3SHZ2amlqMlhsaTNlcmVVYkxOcXJDY1RWbytBOHBhZlhxS1Zl?=
 =?utf-8?B?RjR5Q1V3NFVJcHU0Yzczaml3N25JM3hlYTRGZkxiK3h0dGJ6alpNTFhHTWx6?=
 =?utf-8?B?eTJzdFRwRWdCVi9BV1VTdFdrWVhKaWxpOHJNZEpJTHNKMWhONnV0UEJNUFYv?=
 =?utf-8?B?N2FBUDdRNkdlNWppR3hIalVXcHI0bDVRbXpCdUV1Z1NXZlFWR1JTSWpHQ2FK?=
 =?utf-8?B?dFRla1g5T0JPUlo3dUVqVElHMlFZUGg2YzllZXBlSE5adlIzbDliTU1zZFBH?=
 =?utf-8?B?K0hJVHgvUFUreStIUlVZeTJEWkJoTDRQL3hUSGxKMUJrSkZ0K1l4WVNUQTNU?=
 =?utf-8?B?VHVWVlVhRXhCaXk2cm5ZUTY2RnRMNElPZTczS2tJeFJEN01oMVVpME5UT05h?=
 =?utf-8?B?M1QySjFpNnRRaGtnaitaeE9YcmNSc3NUa3hva05xOGJUeS9CNytBcXgwc2lX?=
 =?utf-8?B?QTl3dUpWVWFySDl2NVVTQ04rQ2pGa0UrSG91TGFQOFdRSmFva00vdlhvTFA1?=
 =?utf-8?B?TDlab0s2REdOSGw0empHTjdhY25haE5KT0dYV1lKVGJqWUFCMUpsVW9NVE14?=
 =?utf-8?B?VUpzOWxzOUtGK1NqaDYyQk8zbTdybTB5aWE2UkNUTHA1V0kwYlRrZzVyOXhm?=
 =?utf-8?B?UWlTcHluRVRqdVozRVo3SHZqSFlpeVZYMndFdHZrRUtvMGZYTzN1aDl2UnVz?=
 =?utf-8?B?YWptMndjeXQxWkM0SExmVVFVWkhDTUkyWmZiRlE3NGs4dVVnM0l0T3BnM08y?=
 =?utf-8?B?Y0tiU2JnbXRnanRHMFpTOU01cHNLcHlJYm1SbzhObFZwaTBBd0R3SGFUMURC?=
 =?utf-8?B?dWpUckFoQS9CRUhPK0tDMWdrejZBV095cVN6bE0weTNvMnVDOXRwYVdwcDlL?=
 =?utf-8?B?aXR3R3FKbzZ2Mk9mVmI0a0ZQcjlkeC9HMkx3NDgxdkVXanVCRS9oT0tBK1dr?=
 =?utf-8?B?UXhic0E0V1dsRHo2RlVlZEdsWnc1ZWRFcHUzb1ZUZ2wvSkJ6YldKaHBrMjVW?=
 =?utf-8?B?VVdLczZKdnZKMG9kbFpqN01EcnJkYndmS0V3NXZBdUhWeDRLZDEzT1hvbTd1?=
 =?utf-8?B?WHkzbGxyV2U1YkxyZGtoZ1p0NDFOVGw5eXZ3bTJqSTdHYXZYNGFMeXdwZ21G?=
 =?utf-8?B?am5Lc0lrT3dnNVBKT0c3TG9oMXFJT3F6eFZCbjExTDhqQUdOOVJHQVlDOWxt?=
 =?utf-8?B?WUQ5dmZIV0JuZ0VUT2daTS9BdmEyWU5NZWRtclI4aHA2azBmRzRyOU5uNm8y?=
 =?utf-8?B?SzFCTWZ2MjJlRExoaUc2bE9mak03amNIa1JyaW9xS3lwQm9NcitITVV5NTNa?=
 =?utf-8?B?a3hSY2t5L0pOYzAwRExnMU5KZmVFK1ZnSFBqcUxyL0dGaWtRSmUvTUc2Tmdz?=
 =?utf-8?B?RGx0eENqQzR2ZkxRcTRTT1QxUzRZMmhRVU5mM0tMY3lpQkV3UG9PNEFUb3BB?=
 =?utf-8?B?dVMxdkQxUmpIT0JQZjJ2THZVK1l3MkxWNmlHQmhmKzNBMTFJeERrNmtwZ3hT?=
 =?utf-8?B?dkc4N010bWIwd1p3bUNCeGdiVlEyb0tLQkcrODFpYkw3OVZSS0tiQXZSWFRU?=
 =?utf-8?B?L0xUanVTL282SFp5RlVRNXlFakxxQ1lGeFlPU3I0RlNiOVJoR0FlV0EzOHRI?=
 =?utf-8?B?cSsvQ3ExVHpKWGFMWld6ZEFwOEdSQUJ6N1FHNzRTNktySVVxR2xLOStNbXpC?=
 =?utf-8?B?QTNXRUt1aGVxV3E0N0FMazV6MjF5cHJkdWRRVEZHcnVWV3FKdUo0cTBBNUxR?=
 =?utf-8?B?TG16a1lVN29wc0xmQ2p6R08vYzZKcUpScDgwdGpNM1cva09lTEdpQSt4K1gr?=
 =?utf-8?B?M2hBQTJVQ2J1UFltYXFZTzZSdGNxRTlxNHVZVFYrZUNidFRFOTE3bXFOUGNr?=
 =?utf-8?B?M0UxWjhoVFJtbERnenZzVDVpdHNSN0d6VHZuOFVOSVRucFprSUd4cCtVUkdP?=
 =?utf-8?B?djdwTU1UNUczL0pMSmdyUXRRdm0vdWUzYnd0MG5tUFIvVzUvTXhselhvQWpm?=
 =?utf-8?B?Zlp5QlcwZGpqQm1BTWpnTC9vRzcyUlU3d1JZdVJSSDZrc3B1Q2VSRU52M0o3?=
 =?utf-8?B?Q2hweTN2ZElUVzM2My8xUjJ1OHY5VSt5QkcrY0FWcXVvNmRZWWdZYm4zaDBy?=
 =?utf-8?B?NHFtYUJTbWZLUGxJellxc1k1V29YYklDMWprYU9LdWZFMUdVOXAxT1dpNWtx?=
 =?utf-8?B?Y1BuenhpTDdyWThhSlpxTnZSZ3h4VzVLc29TL0U5aGQ0aktvWXBZSnlWeEc0?=
 =?utf-8?Q?R0mACZE186fdzK3w=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e08b37-ab1d-476d-6a96-08dee7021b6a
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:28:57.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlmAUtpT3cJmFEKwZ9VXIaG3Q+U1TG6KIul0LkBsJwaE0jRkTRxzgBpJsVmzZ0/XkE4UGPRF1/iwrejg10yAFTQLwlfl2oa3FKrgdbyQrho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1127

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
Changes in v5:
- No change: Add PGP sign for b4 apply.
- Link to v4: https://patch.msgid.link/20260721-pcie-pmu-v4-1-850a4e695b19@lecomputing.com

Changes in v4:
- Doc: Update description for the DWC RAS/DES feature detection.
- Link to v3: https://patch.msgid.link/20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com

Changes in v3:
- Update: move definition to pcie-dwc.h a
- Format: Update the subject line to follow the style of previous pcie-dwc.h changes.
- Link to v2: https://patch.msgid.link/20260710-pcie-pmu-v2-1-a3d73d4d9051@lecomputing.com

Changes in v2:
- Format: Use tab to align with lines.
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

