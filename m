Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6441611A;
	Mon,  6 Jul 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348802; cv=fail; b=Rs5Z0FrCiaV8DtH0LHfgdE0dEucihFsfJzRi7z9uq/3MxKQBYYNTWvyECuMTmng2KTKDHEUAxWiXp64WJX8yCIfqG/XrjSLRGxUmvOrPRAhythpqT2k5pv1YytKXFYpcn39q8jDLu2T7nTBjXmGxa6XKT8Y6nlB/E0OuOOVv0j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348802; c=relaxed/simple;
	bh=rJXl5MtVZgoZpt15rhJeH9YwSO/WyKvgIhBZ6RUCPz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbtX8F3d7UZLLzL1ptX+fJp0ym08TMWDC2nHZ/9p+842aJbIoQxXHxswOLWpW0zuDy52tnZ2wN9VeiJOIyd23TwnPSWt7oCoIwZoLtghqfKfpFhmstlHN3syAjxjDjUsMREDVzYIHUkzmUCH1oaPK4Fp8x/NGIxQlnU82ureCmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vJR4/6LQ; arc=fail smtp.client-ip=52.101.72.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vJR4/6LQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YATgFA4+fZdWAeYe67M63RvTpP12KQQsGQaFZGDFaszDn2E7eYEtpWT2I1J+NMWABZCyvBGmzSPTqY63oS3UT55bqtJZ4ivwzv7TP4XCkkLXJQxYe+6fmx1nR2sX4LThmaHKOsKq/gSvsDCaBJXqUxwxr045sgde3NTvmKGghYTQtnslz1MA3p1z9o5EM7fGoc7QH7qbYcUZud7JtaJXJGDTTauYxuHE7SBUCKjlhl4eVD2xLqe/tKll8abVnnxuCHKcCjeVpfghM1FVwwPPNnbz5EfKrQVi/V21Y2xiPczaVOb++XgyRr2Fu280m2uHcGMVJThwRSdE1oIjV1CdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiKUYZ8dYr6K06BUo6Loz8h3jn/PkZw8TrMhF0pemLQ=;
 b=CkG5uoSKgfkz+sVeSqj8z5SfwCUZdsNdO8Lu7vyrz+caQx/848lkpgYejnnhdobHwczsSBuFyvrO0vLkmmDh+rTZobJkrxNILyDOFHJTF+6TLy/ti3wc/gbk1njUqig0QA5nNq0IzDU+VxPQrY7xwxO2Bhh9CrBFXAOWq2+07dMd3s6BX2Y8uaQI1IAvU/UOLUT7jobqWQ8EF9Q4k6BFJf5tqHLOb4N5GPLgo9kSt0EeTgLbHMg292WLboJp12KOsIHNL5g1vd2UMU/eDDATToxwbDbG2SvrrmJbzpus+8/EFjWeE62Ki/Cb9mDGbEXWLYSEmqbBJwyMadt+/DZUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiKUYZ8dYr6K06BUo6Loz8h3jn/PkZw8TrMhF0pemLQ=;
 b=vJR4/6LQDrd+yeCLRGZI+BIHo0Wv6In0QNsyEogqQgahA4eT2orvk2H0eO3Q0U5m53vA7n5YFEwVT7NUkHqkN+dMdcxZly7r0mSr6Pb8Avf4DY1rcqW04a/aSF3phwDXUKAvNr5iTv0aEwiQfb8wQHQYaolirpUmFL9l5KoFsHvwoRfXZo6Fc+SbNyRokBYTF8f+0p4xv7qgnMlLbkx2zLGKXN6v+p9rA84rmVXOI9zK1HFGqw3tHvFmlrbryGrFWJgrEOfcHSQyNpGK7gDZK96PW3t9r7+qS3gRO/aP4hUsrGSV+hysBDYQpkz4Zngv7sEjxE0fTDwdYOBIi57bjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 14:39:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 6 Jul 2026
 14:39:57 +0000
From: Frank.Li@oss.nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: (subset) [PATCH V5 0/7]PCI: imx6: Integrate pwrctrl API and update device trees
Date: Mon,  6 Jul 2026 10:39:49 -0400
Message-ID: <178334878406.1327277.5900603241410809781.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dfd741-ff04-41e2-3763-08dedb6c732a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|23010399003|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ipja4WkJsV5ySM2ExCTD07S8UprX6OPDYePJa0ELeJtGckFP/+NlL+DdZxPW/rztg+j8Y5ZDOjEXW9iquzIrmE8DrxQwlO4a/slcZD54M68URTYK+eAibRv620EHZv9BgCvu6ereZ3tVnbX3UDua8OLYQOJrpiwD1P/XSlxLwkd2v3hs8YPuvmkNPdlhDk3yajzevsTPr8lug6+u0xHtiM9h8gObVLyUrXXnBvWsC/8CMfy1gyo6QMXxbzIvpwMyPEAqU1/pVpttw7UACPrOcmT8kpGkDHIu3J6blHRRd7MEJ2PWUgJFyLWeFYm+oMowohGQ9QaHEttx1YfUE8VcfE32uI2d8cCvKoFDYcu9VlH/+tjXbux4JHKd3/lOxTG2fSl0Ckc24C/o5u+ayR3Tdsi5TNC56mr0QZLEvCcrFFWARH0AB1SqSrysncplKYNUkQaVobq9cM/gOoJUHS7Lt3qvKBRJ7skEZATxsLg5jlgpoXS1Ba5QjmG9688rIGg93bc3qJWvHRhkGl9PkXshAqYlJDslzuYzDaEbuiZf869SIdkqnztPPl5nQ+7qoU8ooMXMGVqXrVaCFNxWSVKnF+bCn9/7ztuWvbIX67ExS7kphyZjgJi/uvo32vuBGB5j8cwLl/aktY9+o5/zx0cZh0xnZVpTXDXOmaVbnXv7GY8rT5y4ya6OYQC9hZOUuAGIjnPWrB+9mdvyzvlejF/WRA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(23010399003)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmdRQUoyS2dhWmJlL2xpU05oMm1EeWRrMG40ekphd1d1czR5VTFYOFJaNGFu?=
 =?utf-8?B?OEZ0T2FyM1pteXFtY2tzZDdHUkdtUTFKQ1FOeDNXZVh4SmN6aXFhOWdFZU1k?=
 =?utf-8?B?NHdLRVcyTGg1c3lvM3NHazlYY3Z0a05ORWpmay9uaEpPWVMrcVJSSksxZlpi?=
 =?utf-8?B?Q1crNXErd0hUQjc0NVpGYktNbDl4TGFPTUhHK21FMTI3RGpBTlJ0SnJWZ0RW?=
 =?utf-8?B?cEVmOHZkQmpKRlZodDlYSFJ0TTI3SFI1a1RDekxzRklRUFROU1NZOFAvNjRm?=
 =?utf-8?B?aVhxblZaS1FIeC9yTkZOWlg5SGxSbkRGcE5oMFh2dnBwWXVEQk1zQ3lhZDR1?=
 =?utf-8?B?ci9QWUJuWlJtTVF5cVRhcXdnRGhvSXV0eW1vY1hBeUlWYWQ5S1dNZ3ZNQW5N?=
 =?utf-8?B?VTc0U1V6UE5DcEFGWS9GM0p2cCtXUGcrb01QZU1NaUJ0M0NBc3gzS0tOSjkz?=
 =?utf-8?B?UlFweVB4RmcxaGlQVVowb0VMa1hySWpGUkxjMDY1NTJPcGVLSzlqbkgzRjV5?=
 =?utf-8?B?eWVXTk1pRWlpNkY2NUNJdUFEU1J4K0RKVmxaNUZEb1Q3ZFlpSllGZEV0TGxC?=
 =?utf-8?B?VW0rbWlLVHpWUml4MWltVkc2WVp1UllybEVzM0lYTjhzMk53MS9KeTR0TzI1?=
 =?utf-8?B?U0tnOXcvWXNSU1ZLVnFCT095UlI5R0dQckJ5T0dmT2p5VmpPNzRkTmdGNUVB?=
 =?utf-8?B?ZW94ZTJaV3hBaVZPdnJ4MTRheHB3Yk5oQUhsaStjZ1lVRk5MK3FOQlpmNzVz?=
 =?utf-8?B?eDVBb1lkMDhxSUdBekE0UWdWZlBWaGdCem8xY0VnS215S3Q2T2tHRlNiQi9I?=
 =?utf-8?B?QitpUFNjdWdvTHFMNjlPT3hlNVE2STBoZWpURUFUNTBPY3RzYUQxY0lYWks4?=
 =?utf-8?B?NnRBODBDOCt0cUhIUDJkMnlOTUxQWURiR3NNR2lBcGdjV242Ry9TcjB1YXpj?=
 =?utf-8?B?Qjc1Y0pYbkcwMjd2bm1LaTNMaFNyOHpZYnJva0hHUFBNd3FORTI3VkFaa2xT?=
 =?utf-8?B?WjFseEp2RXNsMDhvSHNjelFhUnQ0R3NBM2gxbVpETG9oYnpieVVxLy9FT2dV?=
 =?utf-8?B?SzRmeDN1Y3ZRMGc4UGZQMmxkZEd4MXM0RXEzV0o0NVIyOWx6U0VpQXJwZDJJ?=
 =?utf-8?B?MVlWaFBWajM2MmYrRGxEaTZSQkdVa0hyRlp4VEdtZVk0RFlBOU9WUmgrdVkr?=
 =?utf-8?B?OG5tSFAzRDlzTTdWRHNrYlJiZm1kNDVMTVdmbG5mWWdaSjRnTlpXb2NuMDlJ?=
 =?utf-8?B?YU5wS0QwbG9XbithSkl2V0pkZ25JQjV6cFNYR2ZTTUpzcWlnNTNoTFNwYW94?=
 =?utf-8?B?MHlkUnloQ1loMjhMK0luNVZ4UHJIeEJVOStrdzNZOFVRWnZYVEZOdytvckZV?=
 =?utf-8?B?ME8zNlFzL3oxQnlncXUzSUhKV3pJK2txa0ZmK2F0Yk4zbndUTEJ5UmdoRE5Y?=
 =?utf-8?B?UnI3aXY4aCtUNmcyRENtSWdKdU9IdDVSbG1SN0F1eTczVWUyeDIrVy85Y1Nt?=
 =?utf-8?B?VWFqMzlvbUpERzhDeXoxY2hQd0hQZ21SZWlremd2ZmhiaWpwVUt2VlpUOU5E?=
 =?utf-8?B?RVBiNDh5SjVJVDU0dDUyaUJBb09VTDk5M1dEdGFlVy91V2FxOFJjQjZTZFVS?=
 =?utf-8?B?b0xISW1JTWFWemRLUG1MWVhtZnk5TXdUeEU4ME94YkVDdnpBck9tVkpZVS9N?=
 =?utf-8?B?WE9CMDdiOHBZME5lNXppUXNoZGh6V2VnTDl5YS9HZEdCcmpzSUp4aTQxcHJM?=
 =?utf-8?B?WXZTZEFlUFVLMUhOaFo0N1ZBbGVFejFSb01FcTdVa2RIWEx0OVhRb08yYWpR?=
 =?utf-8?B?eEVrUzkzU290elEva1VQRlVlVlRHaUowYnR1T1czVGZBL0xtUFU2QWtHTkNX?=
 =?utf-8?B?TFJ6eVVyWnlzbzFaSHpRQXRBNE1TdVBsQWdBZXNEeFRPK2huTm16UDl4cXdG?=
 =?utf-8?B?Z3pOaUJwdy9uUFRwaC90cm1MR1BBZXhCanlSZ3lFZUg2NDdjeFJ4NWlXSGNK?=
 =?utf-8?B?SGl5Z1VGb0RwVnBwVXJwUCtvLzdBb0lUa0pJejBTRDNsclRLUnJlOEgrd09M?=
 =?utf-8?B?K1lDM2ErNWtyV0lEbnZSWnQzR3djZ1RpTFMvTjh2QnJHbU16b3ZVb1VEalJB?=
 =?utf-8?B?ZlYyQzZBeU1rZFFyTGlkNGVkeUE0amk4RkFFVmNiZDNCK0ducGxRVFAvcVpF?=
 =?utf-8?B?ZmZRNFA5Qk1aVGRkREZKWUVnbkJaK2cwVUk0UUxsUlRDRUFGRGVYb0tPZDFu?=
 =?utf-8?B?Wmt2YUxHYlRFcXpoMjQ5aXFRNTVzbW4yU0M3UVRlQ2gwZXhHbjhRaWIrTmFa?=
 =?utf-8?B?RlVvYWo1U1hsSUovMU1aMjRuaVk5Q0VDWjdUYUdTL1BoamJPZDdDdjY2ZTVO?=
 =?utf-8?Q?K4hxSMME9vBXqVDk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dfd741-ff04-41e2-3763-08dedb6c732a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 14:39:57.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7GrbTmNnQlHAG4DhJNKwmcQeo+Epy8bkfc9jQPk4gHWbXEZZzALRWR4Jk+AbhQtlbxK9QCVB9oh8W8Nfx3P0DbLVqMDADuhUZ3Ix5D+Y/4h0/XK+a6Zw0FZkPC8X39V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

From: Frank Li <Frank.Li@nxp.com>


On Wed, 01 Jul 2026 18:52:27 +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> This series integrates the PCI pwrctrl framework into the pci-imx6
> driver and updates i.MX EVK board device trees to support it.
> 
> Patches 2-8 update device trees for i.MX EVK boards which maintained
> by NXP to move power supply properties from the PCIe controller node
> to the Root Port child node, which is required for pwrctrl framework.
> Affected boards:
> - i.MX6Q/DL SABRESD
> - i.MX6SX SDB
> - i.MX8MM EVK
> - i.MX8MP EVK
> - i.MX8MQ EVK
> - i.MX8DXL/QM/QXP EVK
> - i.MX95 15x15/19x19 EVK
> 
> [...]

Applied, thanks!

[3/7] arm64: dts: imx8mm-evk: Add power supply property to Root Port node
      commit: 66738404bd0ab5b515d32bf4bd64f2cbe91a4b4d
[4/7] arm64: dts: imx8mp-evk: Add power supply properties to Root Port node
      commit: 6320522f617d020b0e65cabb4cc4b35518fc8222
[5/7] arm64: dts: imx8mq-evk: Add power supply properties to Root Port node
      commit: 919519e84ea2aaf9ccab968e0aa9d97586bd9ab8
[6/7] arm64: dts: imx8dxl/qm/qxp: Add power supply properties to Root Port node
      commit: c4dad11102b34dfcb8facb29b0270f8fd71206d3
[7/7] arm64: dts: imx95: Move power supply properties to Root Port node
      commit: d61fa5049fcfd3a9d048038acf6c0d5993baee12

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
