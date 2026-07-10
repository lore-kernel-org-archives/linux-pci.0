Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10A3F6C39;
	Fri, 10 Jul 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676639; cv=fail; b=XikgSqfzZnzgEJTTUklwiofY18QCj2UMGLAejkPZQcAJfi/9zHsFjZjnvXVpIBM96D5RzVaNfbDyZsk1yN/SC6d5jANemOts4CH0/twYr8s7NXeNRPEqbGg/fr84NwgeQFsqa5VWGzKK49/KSWBqOxp9l2eOp1fMkwyp4mqM7JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676639; c=relaxed/simple;
	bh=7luQFvrTWfUapFCF3XAPzGnnigMl3AYWwdL39LgVTHc=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=bJ+OWqU4MmUhayfFeQkQuoZmwUwdt2uenIdS5dMuePTjqpymfx6GoEdkHalaXtcQwnaHT9rP4o5KIC0aW+hPQIIsmnnj/7sAANWt61tv4ZQfvGBsDwfavRr8WNLwDF0WYtFxR4vtWb7GwL8VbPNVkiKo2X4chL9WTSt6MyH/Y/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.146.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEIcw8+XVaFKN7Kpkf10Mk3a/qXvnRvgG3ugnV0dG7ItuRc9oFnejf8bDb7oyN2wg5uOo/F+y4ccbM6/pmEQ330Q6Pi5pOOXegTyyj9KVBMD9OGqO37M6dJnTCKpgE+0YjmF9fB+/fbrpsSC+fcS8E/tpjkXhSGrNuoIKFxiQWc1QZj8U716kMxwH8vsClrG0W7AIUC8dsdt2EBM1atW8RY7cKRqya9uwEtOJh5GU83ySM1uHlEu/wbmEk8yW0wY6LLTYYfSgNykQQE8O7wTR+XUcE5/K7pYDSEP0NqsxAKcxwaAxCXuzNaivXoeQl937lNV5+yglu4BbdTrfn3zOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TCvu10NQHfXKCXfcbqy19Xgi228/LBLkZEVgmrJQvc=;
 b=W0Q3teUk8uht5kFnnS/s4pIGAISkmeUU5/kXXKwWnnPug3S5jMFKK7epDW2aCcnBLlU62xlQfHsZTFwCuL6uYbV61GcGBb3F8mq5rkUryP7+GsUSVL5hJJpQ6Hm852bMFTe1/J7MABkUzpi717JR4HVOG+UT2GcvaefsoXsnfilJp0F6CT6mUvIfMdU1P6NpkjuQxTwYBG3k3z/R3/fCv1rfKtvFQNikDS13rv8/GlJqWYN/XO1fDnJtZxLalq4Y4/Xzq3o0WaJkwkTuSkszXv/hKS9yD5kwfU6xQ7qXtIpXmhKf29E99+kxTVEfvHSKvMNm1O647ZpvyCdKrmKc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) by ZQ0PR01MB1254.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.21; Fri, 10 Jul
 2026 09:10:39 +0000
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 ([fe80::9e88:7d6b:fd6c:cc6a]) by
 ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn ([fe80::9e88:7d6b:fd6c:cc6a%6])
 with mapi id 15.21.0113.021; Fri, 10 Jul 2026 09:10:39 +0000
From: Braden Zhang <braden_zhang@lecomputing.com>
Date: Fri, 10 Jul 2026 17:10:34 +0800
Subject: [PATCH] arm64/pcie/pmu: Add pci id for LECARC pcie pmu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-pcie-pmu-v1-1-1519e580313f@lecomputing.com>
X-B4-Tracking: v=1; b=H4sIAAm3UGoC/yXM0QpAMBTG8VfRubYa2siryAXHwVFYm0lp7264/
 NX/+25wZJkc1MkNlk52vG8RWZoAzt02keAhGnKZa1lmUhhkEmb1QtFYVqg0Fr2GmBtLI1/fVdP
 +dr5fCI93DyE8gRHukWwAAAA=
X-Change-ID: 20260710-pcie-pmu-5ef78c56c3b6
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brett Zhou <brett_zhou@lecomputing.com>, 
 Braden Zhang <braden_zhang@lecomputing.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783674638; l=1394;
 i=braden_zhang@lecomputing.com; s=20260518; h=from:subject:message-id;
 bh=mZ/Zm4sqxtMRShDnpJ/2FHezl5kK0RAktBntKxKyfXU=;
 b=DuyHX+EhkY93PlhgU0lQHJW9C32lK3OYt7yswvuVkLAPK/hqqnbfOs0V5Nx3hYln0Q6A3dLwN
 k/FQbwn82sGDTqN3KU0KpFhY4AYiHjVTZtLHx9+pHIJeVaNgUL79A/7
X-Developer-Key: i=braden_zhang@lecomputing.com; a=ed25519;
 pk=d7V8RTvs1pxSx8mPaXNAe9XWo7K/eHkcVBWTjw1rwrQ=
X-ClientProxiedBy: BJSPR01CA0001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::13) To ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1206:EE_|ZQ0PR01MB1254:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bf8c5d-b1f2-43ca-b84b-08dede631c4b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|52116014|1800799024|366016|38350700014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	n0djdIOvgL07ohEZkdzdI6KgMLUhohumMONJtO18xCx9bPthBIut77HVhnTn1XM6aQbZ6dxamvSOAhFed/8HJt58WHp2OqzJdqUyYACK2oMW0G+5j2O54sGCwg57iWlD80U5dT4RR119wa/AIkMJGnkYceCAIndpIBrl5vfkEC72JIV7TjNMK9nPbXPPzskWh6MrnrOCoX3b5lEB2NTWopFdIv9VRIZItALMHMaSZrA1jkVVFx0XDXHE3P3TGYRPmwaonR6tuQYQUxg8MtkSLTWXpCLFgJevCF66WswWdIObKFBlOnhutTyC1yYIDtQFfl1KxnZkpiu29cRqBh0QKwBEmaymga20jD3LONTTXvVNkrz+UYP3GxGiHUXlCJFFrMZAg3zBd13UYNLvLjuqZ3rd6ggb8JSyK6BqUEVwTYPGBLEKApKgQd1U/eWnsqm/dn3pMMYTXs7x504JiZelS0bw+U1+63m6fmsYj6fFdaOqHXKDV0DM00nMTfrlrmvHcik2tl7Udaw1zuj0j3p4UgBE6GCPnPTd5MOBYN4nVuflHWSicZTbWosNqzM5WvQ9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(52116014)(1800799024)(366016)(38350700014)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFd0TStuTVhQaE5ZdGtGR2VkOC9XM1ZtZHpnQUg3Q3EyYUNUOU54TXdnam1C?=
 =?utf-8?B?UndGVDNGaHFqd3I5aCtJdXBCYlNzS1dyWTVXbzJDZVNMTnVnYnkwU0NMWWw5?=
 =?utf-8?B?ZXkrSW16blJIRDlNdUMrbXhHMjBKQWJHbXRBN1dzc2pUajlaSE1TN2xSSnBV?=
 =?utf-8?B?K2E5ZWxLMkZWNXRxT0wwUGU2T1ZKekd2b0NhQVJDUWYzNlNOUUlLazBUYXRv?=
 =?utf-8?B?SUZnSndmSjB3R293QnoyYlduTnFNak55NFBxS29hSCtmandKcUwrRHhWTHZm?=
 =?utf-8?B?Z3FpYzNlcksxbzQzVlZvcnJRZU5KbW4vRkgwN012eFo4TVp2RkJSK2granUv?=
 =?utf-8?B?WUhraXI3ZzN6YnVmUGlaOGJqNVBCaHBzRkV5TGVuR0V3dmYwUG9Fb0ZDWGhz?=
 =?utf-8?B?ZEpMUG9uTnpkK1E5V3lGcUtCY1luMWdVY1dOYlRiUS9FRVVabU1zSTRZZ1ll?=
 =?utf-8?B?aDdCcGk4WEhDVW5vK0xmWmV4Tkc4dVhyQVl2V0RiVDFwQXN6YmVFUTNNOThB?=
 =?utf-8?B?NThUeVNtUHhQL2EzYUFuRURlSHAzazY0eVB0MWs3UzliL3E4VkFSa0FYcEMx?=
 =?utf-8?B?bi9NbkFtemZybk52ZkZ5eGJqMHpDZXA0VVdwVndqZmliVitiV1ZCRDR3WmMv?=
 =?utf-8?B?bVB3cUNWcWs2ZWZ6SkdBd3M5d1JmYWxOUkRWZTRBRUY3NngwWTdJMkxlTHdh?=
 =?utf-8?B?QnhsQTBNb3JNRzEwY0J1b09zV2dhbnJCWUNBYzR4QUFiRVA2cC9uY1Z4SjBq?=
 =?utf-8?B?enVUa0QxNHRqM1FaallzeGRMUE56bW8xRCtYQ0ZWRFJDdHhGWUk4Q21NcjE3?=
 =?utf-8?B?SWZFQVI5WmZFQlFxNHExczB3dFpzOXNGMmVqR3JVN3gzVmtWWmdLZ2czS28w?=
 =?utf-8?B?WnFCMTg2MUtHVm9RUGZ1MUFJQUVFREJQZ1FneWgyNEpvZlJqM1d1Z2c4eUlS?=
 =?utf-8?B?Q0VKbzN5djhyVGc4bFBpOTJjOXBXVkFqdlQxRG5KTTNBUUJwRWFZK2dKZWla?=
 =?utf-8?B?eGduZENCOWhyNGVXNERFdTNjV2E4SVRxMnNHRGQ2R0N2Sjk5SmhPbXkvbDlI?=
 =?utf-8?B?OFpaM0wxZWFiNlR1WXJBSVpIMDcrR2JZQUN1dzVNbjdnbHdYNGpvdjdIbkVz?=
 =?utf-8?B?S0l4dGVpNVJnZFNtM1h3UUJZbmVaZlhlSTRiMExCZUhWaU16RWFYUVZBbi9r?=
 =?utf-8?B?amV6YkdsV2ZRTDgzdktLbnNjT21PZ1RCQ1k3K1lrT2w3YjFEVEJPRVlvMFBj?=
 =?utf-8?B?NitOVVlSc0pRa29JRTcrNlRCajMxQ2w3TE1UNHlSRko4cWlQdDg4ZUgwSldO?=
 =?utf-8?B?dlQyR3RxMDJCM20wS3BJTnI2MUJTeWVVb083dVV3bWR0Z3Z2RnNjZ2Viby9Z?=
 =?utf-8?B?SHJKSjZjczJsVEFCSXRibVIzeWJBSFhIUWl4L3dkVEVpK01nNXBDbVlzMDcr?=
 =?utf-8?B?TU9LOVpUL2ZqcEVQWVpMaE9qeWpFQitxblNqemRvL21QK0svVEJrRGs4blk4?=
 =?utf-8?B?b2ZtWlFuNUk1RXRac2EzQkFxaC9qOGl5L0NvRi84a2RJaUdkbnQvL0paRHlr?=
 =?utf-8?B?Y3BpVXdvODd5MXdVckJYYm9QR2xHaTArSXRHVWlXcGZpTzU4OVozaWVIYWFL?=
 =?utf-8?B?b1l2Sm0xN2lCRXJVeEc1WTFsSCtjOHptSTB3TTkyVE5uNUtSdlpWMWJCK2gz?=
 =?utf-8?B?a3Y4ZSs2bk8xOXdFbld5Z3IzMGV0bnpFV29kZkh6SS9QanFxR2tybHJUM3hW?=
 =?utf-8?B?ZWRPK25TMjhLWnhvWFhCUnVLSUpScGU4UE5DaklFRTZnRXBHRnJsdzl0TzBK?=
 =?utf-8?B?SUxKVllkR3kzbTRQVC9YQlR1cUtEZjNNZXp5T2ZNeTF4c0NCK0lwWEZ2NnZv?=
 =?utf-8?B?T2Urak5qTzhTRGs0STZxRUs4bUV2QnhnNXEzVEx3Z053UXBMZWpQc2dPdDVk?=
 =?utf-8?B?bjlwdlFXQklBYklTMVpUOWZBNzZ4b3VtdGFma0hqOVB4VHRMcXA5UWlWckc0?=
 =?utf-8?B?NzAwRStaQjBIZnBVWlpXbnJMVGxFOU1Yc1dlbXg0NUJDN0p5SlVmWXUzT1dt?=
 =?utf-8?B?RDUvbmM3d0VySjFqQ3NxZmFGbnY5TEY4R2xBNnhvRXh3R3RWeWZyK3hMYUpy?=
 =?utf-8?B?VjR3b2s5TUNZL3luR2tHc0JaRW1CNHdPMGhOdXE3NXpuaysvRVpCWDF1djdv?=
 =?utf-8?B?NUFJNjZoYTFUTUl5NWJqOElremhxbEV3K0RuendrNndKTTljYkNnUCtReDZz?=
 =?utf-8?B?REQvNFhibHhML05JYk5tYzYvWFVkN0ZGcU1vYjJERjIvRVhnMWNXM1RPUzR1?=
 =?utf-8?B?blpGcHljcHZEZFg5b0lNK0RIMTh0a2w5S2E5N2F2bGlnQ25PM2VaTGlRMitu?=
 =?utf-8?Q?9M1xi97nxaw/lhvY=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bf8c5d-b1f2-43ca-b84b-08dede631c4b
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:10:39.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hn/28D4cayIC/dozkopBAuTeYXVpTFPY12rEmhjL8nD5vzL3RlKIfhI79UT8Tbo57FrQt/e1Z/JQ6gRK2GEiR3AG2YgsM4R9Ed5wlAPe5h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1254

From: Brett Zhou <brett_zhou@lecomputing.com>

This patch adds  for LECARC SoCs that pcie Controller
IP PCI Express DM Controller pum function

Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
---
Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>
---
 include/linux/pci_ids.h  | 1 +
 include/linux/pcie-dwc.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1c9d40e09107..1c4fd1631505 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -173,6 +173,7 @@
 #define PCI_VENDOR_ID_DYNALINK		0x0675
 #define PCI_DEVICE_ID_DYNALINK_IS64PH	0x1702
 
+#define PCI_VENDOR_ID_LECARC            0x0720
 #define PCI_VENDOR_ID_UBIQUITI		0x0777
 
 #define PCI_VENDOR_ID_BERKOM			0x0871
diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 8ff778e7aec0..1a31fe4db228 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -32,6 +32,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
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

