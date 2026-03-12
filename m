Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206511DF970;
	Thu, 12 Mar 2026 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316498; cv=fail; b=QZx5Q7PkbobBJn1gkdr6Sc7DfcpQ2P5yX43sM2/3kR5Vph20pmj7gIt/R91rCGdpNcV887iH59Z3TTuiVScX7k/x5qc5jdZzAJgDBFChHpxOtq3M7MEVv7txZTpDvc1it7L8Pka/i80Q4RkZZ8YDHnmn0udrIH/9fw/riGeKrhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316498; c=relaxed/simple;
	bh=9++IcCJrGLupp3VAu23tk+2qHTTLEivS1LtlQfGHI3w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bNbgAA6T1sWN6kdndPiiplfltSMC6G5qtItul3LyKEv+Uvta9F2HkJ+RaNJfGT4yNtGgBKRjkMjh94ve/jlttAX9pv6X10kQLf3rUD8GZgLoAzDFRUpIrods53lAoVBoWXyEqutw4IuMBgx1DyVNMun4tuEmbF2epQDBO6r4FFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZ4i5SS4; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZ4i5SS4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTytoucd/o3TvjD5tIQ11YGTCclTuzEW3VSp5/AJK8RBoyvhhmRc0zkLN6F03/PPg1zibrdf/tQ1NDWY4F+A93GivIQstNrUP+NhU0h8VR/u6BKLKaDmm0i6lcwrTDVP5J2gGChc8mswk0wwbJT+OTQ6ON7tywHHL+mFqpaLHOUloCXiZN5Wz49ctIUhrYA3a5W8VcwBdAJrhI+V0wLkg0dGbVOQRYd+GMqm0VNkn8n+pneHcH2wlGztZda0F4ZDUF4c/UO0uRTwSLj9x2ifVy5+0SFtuZ5tP7vjGxpFuyGE98MIizm8tvh+YfVgZ4UdaQQ3bFkbeHdhUQcD+BdO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a2zUSN5hh1WC8j0o42TOtYywryl3ESRx4HUWVB+HGM=;
 b=Cb41yAHsu8xDiYGgWTNzVe7DaepKc9MvDc9qjHOSY+WYQxrrewlOtkOaKjFPx9jlBnROd6VweIi1y6U1DtvOqpvQAkJ7InjNdRZTnntoYOVAQMEyWDLg2K8YhQeGaObO2bllc3qu6B+9cxhB0YBorGQO7uQJrQ9lt3gcPmgUFx7ilZqcjZur55gotwzI04IZxGTI6ZlHXiV3EZ11AUEWcP2tn59vOqW2Aagi5ET/0iQkjJSO/j08e6TS2CRupQi3sCcdvE1MP0HcuOex8iN3DS7pLbdkgZyGGmrCTXtWDG4hK01VKypnAwqAnMdHtF7kl7Aq7G6y9vJ31mpcuT3gTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a2zUSN5hh1WC8j0o42TOtYywryl3ESRx4HUWVB+HGM=;
 b=CZ4i5SS4XjgWdzCYbbMDi/470HESR9jPcmTyFZKnydXUhckmTOQ57SMIcdWQLjsIHoObbK96u+J4S9ZO5fBxE5NYx9IC41Eajm/sN5Fte4cdySCzMgq/lYm9ABf2JWsMQwPOgEhw1rV26Qm/tjjI7vJuQkEmpf94xGUr9Ro2vWX7Lpmq5xlGP74QvGNyIovOvSQa8VUqy/sfJRlTG80FBoGHGigKHhGpu4qT5ULlgw8Gb1ZJx+zxeToLOSuQcbAOXo0W4SKBM/kJJ80hmKnNSL9KYld7j5HKUa0hGZLAUpduU1Vfgptu2rGPRbn9gaoJEjVKl/zzOJ3BjOBOFp/bvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 11:54:50 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 11:54:50 +0000
From: Richard Cheng <icheng@nvidia.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kristinc@nvidia.com,
	newtonl@nvidia.com,
	kaihengf@nvidia.com,
	tdave@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] PCI: use pr_warn_once for ACS parameter parse failure
Date: Thu, 12 Mar 2026 19:54:41 +0800
Message-Id: <20260312115441.8168-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:820:d::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: bbff9232-6967-4b65-6352-08de802e29ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UfvsKG0vdy7HPVUKW1iSWv8takO/UZL63GNbPCQ38yXj6RsaEzVGsGLU1Ax7tGKFqFcQMk5FszNxvBdnUaYTnP1k2lxcQW/ZLlAXmFDJGg7fuN9RkiwumP/cdidrdt3kRnVYqZWkBv24YBHEXC5/8rJW1iePz+52oitF0oNRPH24ImDaAUT/NbnYwwl0hTB7+MfnfNlUnOqrdnGXFlKRPZjaAxMsGIynHZ+bYR7q29aIbIdASrCRrc2y8qU/vdKQdspPiQkkdfTXbHDVLxFhmdstlA5qxvEjiqOOM1srWkrGfwKWNVkeNSXkymSLo7REpEWz62Rc2VG80Xq2/WtgxeJsCkUJkc+CmFtEAKk6IdiJ3cSbWAsBbv2jvmIW+76jBpao1T1C67A/JNDeQGj7Dw536ZTTFal/vYfGvk8R7Q8CqofTUru3jtHeSnRu70P4Zr0VzOKPmi7vfCp0Cc0DwZs7al4WW9yVGW5r6xfSiNfdo/dBa1cXw+G1T3e8jyUPW3KDExqCyljA9eHVjgfvo1KP3C5CxsCwqBZ2QzSqtB4xKtoJ2Y5yyZ2aO64HAIAjtTs9ICjqpsgt0UQ0xzq2bFW7sKrV1RQ8bCm6iyIGhf1MerMhXsNbLLcapuYg6eSMWxIYqt31WTIrmeHWi+L3vig0GBtQsF8eVAhCO9gfYyzi4C7Nk1avNcCt78DoV5Qn+dYvdXtby2p/xZRKox3A2xkP8PVnHoWuIM/lvR9ArtA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+sONPvC2yLaKDHrLBIPRXI2K1QVsKpjLJNlfnM9RI+Q9kkz4Z2xYKS329Yw?=
 =?us-ascii?Q?hwns6Q1meeQjXGutuofaa9uUEWMeMX9N1F6lissAvzWAu/Wf9j1akanFRl6K?=
 =?us-ascii?Q?F0zpiKNv2rV/4rNexsIv1bnNOfnycMxP3Wwu1NHgyvQDtppFhsCiwGT7TJGE?=
 =?us-ascii?Q?j2MLXEwnQ+RnPVGDAyzuiOg2ii4g0qR0JiXxb3tLARmNb8PCUQQC3w0k4SNN?=
 =?us-ascii?Q?mdBDTo15cq/VZ6UghABDI7c2uKNBd4H/VK6FkVpRNFsRrEAm9KFoQnfbJfan?=
 =?us-ascii?Q?pAqBfHWfVmWRDSGWVBUMhKtSmyyjie8bqJc9hL+rKdHJe1eFVzVR5GtdHMWv?=
 =?us-ascii?Q?Yehsyzzc5muLR4DD3PomF/Jo7o3DJMkb0GhB8L7an0jPFyw6v3ndk9OKSdvD?=
 =?us-ascii?Q?zDT9PPCyOe5hMGpELw3kmfrFzw+KlA0DB6dxYmQu2LT1ilAIoDOE4Ajn1nOd?=
 =?us-ascii?Q?Pa/7th4/+OrRwDOk4tyV3WZsH2DW6Go9ZKLYubsCIyZdFWJfCEPRXxXRJ1fe?=
 =?us-ascii?Q?1/VCLJFLdpQwBquTFGtL4eBx0JUK1br4bx81Q2kYyBmN7RmT1PoLOhaGS0P+?=
 =?us-ascii?Q?+sFYU9g0/9Dbi49BiT4FwLowkPq9TXx4z12zNA/9sfJg6b0EQzlqLm6EKQVV?=
 =?us-ascii?Q?ZzCpH+RMNKY0rIBpF9lOZ38kOjNqhwhGKON5zIsbDVXZTJULNYVLZNghZxcJ?=
 =?us-ascii?Q?lvUzHpMHiLHpv7ktPqaXQjlPHi3TVOnjg9WbcSXKhGpRgfncFMdzAptSJp1a?=
 =?us-ascii?Q?5xNrDCz04oKPmrgESWL5PvcrPn+pkdp4fCMhpVtgcxWltUHMB1eC0HTFsvC3?=
 =?us-ascii?Q?GYSpxZBBNKkBuodK6AJ3Oh5xhe9jDTbsqXZBMgrmkgYlubn4eh1WA+w8phH1?=
 =?us-ascii?Q?wIQqUdoBqa9+jI1TUNcmYpQX7AZLGSjeZsjZQ+iurY0YMAWFNRE2KwRHfzDN?=
 =?us-ascii?Q?fo0vDMhNF7Lbeyj83owUc/XCB4dZqjb65AU0MvWxL4Td266E3tC0peczRmEx?=
 =?us-ascii?Q?J7mR4TzRb1XgRo3bPnlpzluhqzpdJH/S7GEM9VmYpAZ1GcsW3aqIkeE5rIcl?=
 =?us-ascii?Q?738ZAXUoAwnXQQCulLpusE1WUyaPcx3vC2KSuyyyytuuKr/lKn1HolPfjoz/?=
 =?us-ascii?Q?NGuk18qo/3w0NeDiN4pZnMuypMlzhFB/FwWi6D5kkApR8NDeUFuqoeBOwPZb?=
 =?us-ascii?Q?3/eekkdMHHxwpvjy9PG0wDqayS5u9P2VVCLIQ1FO5WPwT0dArLk5SsVfPoyZ?=
 =?us-ascii?Q?kF680CudE4ktM55s0rxoqrrcl12IZaW1C1sN9KWnSiGR1/DAjKOXPSZ7egBX?=
 =?us-ascii?Q?wA2JTvnjaoSPastPIdplTwwIHJpYtY48GPTaAm0mVQ/F17FOjdsE8QrA6isu?=
 =?us-ascii?Q?ifSJBhWCftRtXTr+fHu/zN5KRTnd/GyIYazZuRyg0v/5DvKU7uuREVJZkeQ8?=
 =?us-ascii?Q?LZ/jTloA0+KS/Di0fgYhW4jcoiWn6mo6uS5F3/OOj9ST5lS66QeEabWC2FL0?=
 =?us-ascii?Q?QQWU58UuMKkab26gAEKt8x20tZOKQsYBtak0IbyDOSEOEmzResLnUh+2jOzd?=
 =?us-ascii?Q?qDfrCeCGRwC2JGG1wwW6+9hBgpTAioQ5jNbF/KE1HxGQec3ruVMBnhsD9KER?=
 =?us-ascii?Q?mOkMPGErekwYoxLlDWyHwg8KZjmwnmosUf14lmeR8ii6eKbYrXji5W7vLrgG?=
 =?us-ascii?Q?7NSCfMpWFiaEqxF/SfQ39APEazzEbYFidqKkvclA6zswit/imtkx4dma5S3x?=
 =?us-ascii?Q?h+ZT+GH5Vg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbff9232-6967-4b65-6352-08de802e29ef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:54:50.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hb59IukZvGnnLSPWA0P7A9Em/Q1Gj8iVW7pPu/IVE/IumkI57PdAnaIKD0w09R5/cVGPaVAWrYymAZiyBoqkqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122

When the ACS command line parameter cannot be parsed, the kernel skips
applying the requested ACS override. This indicates an invalid boot
parameter and should not be logged at informational level.

Use pr_warn_once() so the message is surfaced as a warning while still
avoiding repeated log spam during device enumeration.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
Acked-by: Tushar Dave <tdave@nvidia.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..4e3b051c0f5f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -953,7 +953,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 
 		ret = pci_dev_str_match(dev, p, &p);
 		if (ret < 0) {
-			pr_info_once("PCI: Can't parse ACS command line parameter\n");
+			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
 			break;
 		} else if (ret == 1) {
 			/* Found a match */
-- 
2.51.0


