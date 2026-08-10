Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D23DAAC6;
	Mon, 10 Aug 2026 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365811; cv=fail; b=QBIB5nxzhnMjaqAfBIB9TsPt5Y7n/0bfpGyiqmLqsgxNmC8yiMGCuxJzA1BZmVAoiYb0xztbTR+Hrd/ijFclx39k/0E2tZb9A3t5PePlBbd8jQFqN9pd20uHivx04m8lhgcBL93GkQYGsfo66FMG+KipAM3NVon+wq87BNdaFXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365811; c=relaxed/simple;
	bh=jbXKJNbXqTqm+ebq5snPRsXeBdyDnXm+2oIXlywbCbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qUh1ndO4FIBCxq/E2oAPHL0D6imYbPzvZUN3v6Xg9i2lK69MXtoSzjnjIbQvALuEN7vUyEGK3y8doVeyQcMliw7ZPiFkx5h2l2Txj+9kR/JffxUsOOiQtTrDgH4KocaHFruqRLO0/DjUzLV3w8lZj3oW1UdJSyjVB2V/z1zIJmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YHoQJfy5; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YHoQJfy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEtJIQ7yae4QdzOFhBzpTzjbpES/zEGiWf9izm1sEpBj1SbMqu5FYRrF5SU1kUQfw1e5HB8lM+E0QbUm1JqAtfaNWj0ATy0hpNvFpKCic5ZzWqsqSTT4z1P+auCPcsAWKsqpSPuU6kKqN8hrF/p5pbPEJBs9Bq0PqrUkrqeyuNd4avZnjldR2gc/bH3iPAPTcOY9aP541OyqswPx724gliqlwYRZk9ekoYgobpiJ3YS8i0x9wqp8zIkpcjzQjoji3nF5BCupB4FZePkcymGHeGku+Awe6WzWDIrTxISbsnA24Lm9Uz/3F2AdCybgUs2nQS3v6uwOyyq0XsmP7yD+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KLYefPFNJ+gFax5WtPRbZORPEl4NRPDSKQKNix9jiA=;
 b=kqUc4nmkc19lXNc+BoPy8WZ4we4YJj8U/wnvR3DjhMV4EHsq4cAFV7cbpeppOCKfm2+WIPctdw/yYzwzq0xl/Ue/pMaHtMLAoLJLP5i2LbpCmPtFD45AVIbXp4d71B0BfSlqNF98K/FDggnXlVngKpYl75ljQ7S6octNcEohoTcpT9PKf64//NsKDVGeIWJGnCrZxZuqi7i5W/iCNCso9uLFW97oaHCuwryldp++1C9dW9RLUhYX4m5ibDXCpHPn0oU4DXsKdSXb4zm0bbs4lnZYx+4RMFpBEfIVlXFhN6XRPnMhO0wCgwEKbrWmxPuZKy89kc4isSXmnFzdwN8WrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KLYefPFNJ+gFax5WtPRbZORPEl4NRPDSKQKNix9jiA=;
 b=YHoQJfy5DOVAKNRtxszrNSEhpEnRXY/deGZzmOYGtakidBOMX/TLTZM/WrMoZWqDo5+QJInT4Cu5xXJBwPAk4cpPsXNg/fwo62DoM5VZ19Hqxbv+OyaTd5iWgbT8srlhF3ZWkHxhANAQ8yTe+t+pxUFh0G6vifcF3CZcDtlKIgG9vdJBrP1dJP/904Wb8W7mn4041Y6Wp/ZgUlcZojktW4LVLBJAygCWQ488p5DqE3klVdXxkblNbSThmVm/HVZV5QXOcBQQ/pNjp0FbX1jGTOQeKZKeuWnn5eaH+icbRxwnafva5I7UGYpITQdPj5azNa+TB+EPv6O0mN0SfXW67Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:43:27 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:43:27 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH v9 1/3] PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()
Date: Mon, 10 Aug 2026 15:43:13 +0300
Message-Id: <20260810124315.433448-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810124315.433448-1-vladimir.oltean@nxp.com>
References: <20260810124315.433448-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::6) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 026d44b2-4521-441d-7405-08def6dcf960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|19092799006|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AKHJnxq2kYDsCihXUZDF3u5R3OgJcbldVFvUUoJUD4e2W3pJRGZy8ZWyFJeCcmCN5HNRPi997wD/FdchUC6/rqQ5IMTFp1SUigjNi+2RldkDBy+nsq6RkCr+vsyNdKQn12+lXvr2nMD1wyttvEdR3iZy/7oB26kbJ2WtCmCjaGDzu0SCwtaMVNZ1ksDeArO2tJoW+QiF4NFwUTadJaO4mcy57MBOrsHr+XqlkZfvkDFQoanHa3UN1S7lvm7FyV6roO40ittIypTjMzu3CM8BgB27AOLhLfZ8BtUbV1ZRKrXZVgvd5HB7pT7qv4idkNHnUlWjAjjVAeSBQ8GXsqSpWVcT9QSExL/a+yMs+xEj/AP6Qo61RZMypgGUO97b+aKNQorW6s3UI2J18LurUFMaTme9kIcw/iTFdH03DmzakqS9X2zomQy6dGowWDOhoB/o+hB4dYY8b2k411MmzdC2BHtGegI+0bXb5CivHApbK5tzZprzrBSuKp7CvERpeZBSGFJC9u9Vlb8afeUQkkPpsuiU2EOdGcVCYdox8uVIUYjglkRgxhAG/2ZLbszfg5nCnxItM7VG5G8cbLqYcvIFfa3plI827IWeusMQFdbRiA0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(19092799006)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0ZleTRrY1hYMnFXZnBlMWd2cWNCS1BxRDdyWVVsd08wSTdzMnhGRkJsV29T?=
 =?utf-8?B?RmxlaHdPdGt4UmNFZ2ZpSVY1aUdmNW1mcC9GcTE4WnVkSDRreW9SbnpGM1Jw?=
 =?utf-8?B?Q1ZxWXppSno2MjhIVWZ0NzZZVHNjM2dieTFFbkx6T0NhaU5qRzdBRWNNaHFE?=
 =?utf-8?B?N3hCcjJvb05aMkdSVElLazFDNkhnc2xUNU5RODdKTG5OSkpEaEJIL1IxRmtU?=
 =?utf-8?B?OVJjdlRVRjZldlVoQk9xQUExYlgwdjc1RGRoK0dKV0toZHowQmptb1NoK0NP?=
 =?utf-8?B?UzhXU0l4elNvK1hwa04xcHlxMGRYTFFKNnVpQlVSZm5uQnJYS1JVTFIrY0lN?=
 =?utf-8?B?UUVMdzlqUzR2QjJCSmFyMmZWcEhEamt4RzhES3l3VzN2NVNKYXpESXNTVnMy?=
 =?utf-8?B?RE9lR2g4NG5vYys0UFlickxqeXdEWUVwaUtqa1QwRzFqandhR1VqVisvdmxY?=
 =?utf-8?B?RTZzOFFnTWpKODhnNzVLbVIxQlZjK2w0Rk1xMklvTjVWTUVOTzcyQW1Oak16?=
 =?utf-8?B?TnZZVVdPRllmcjlwVTd1UXVpdEEraXhUM1lFdE85cXRIaW9jNmsrNDlyQWpn?=
 =?utf-8?B?aUxCblhjWndMM2F4YUM4MTdvTU8yVERMZk45YWJadjJSOGRXeGpFTHp6bzV0?=
 =?utf-8?B?dFZ1eU12Z296Vmo2d3lwdXZUUndmalZRc3RnK0hmb0N0QjFHNy85Ky9aUVlv?=
 =?utf-8?B?SFd3QmYxanp1ZUpNWHAvS2xrUk9Qa2xqWGhmVXJBbXIwdDhKdzlwV2dnUTk2?=
 =?utf-8?B?VnpnMlhyRDNkQkpOOG1hLzNlcHN1ejZ4d0JzSndNMHptNkZGbHJBMUFxY0R1?=
 =?utf-8?B?eWxwT25SUDZyMzgrK2E3RExLc1ZLMnZRaU44MVFCSlRyUHI0emVuN0xTSDRG?=
 =?utf-8?B?QzNBY25IaGJ2ZVFsU3FNcU5Ga0dBNFNFQ3AvQzMxZ0RWekJXZ1VOSXRnbDZP?=
 =?utf-8?B?YWZMd3JtdEJMNWhqOXlNaTRNb3JQNGdFT3RQTm53dUM5b3RaSjdZWlRQcStM?=
 =?utf-8?B?NWNwTk5sVFplcFNtMHdIaWcwSm5yeGJZbXVIcWZGeENWSUZQRDJnMVNSK1NC?=
 =?utf-8?B?Rkw5WkxFQk5GWGdQZnNXTkt5bHZVMEpWR0lpc1I2NmppWEZ4b3hzZ0NYeEtu?=
 =?utf-8?B?WXgyVW1TUWVkQnJJM3ZVZjRXRGkyeXNERHBEeG9kUHpHRnNKRE9FbE9NL0NW?=
 =?utf-8?B?dEx3SW1DamhKSGlxbmxBSDh3eWJibUJGaktoeVhudWpYUERZRDRmaDBBUExm?=
 =?utf-8?B?WEd5bU1PdnRYUzd5ZXVNWTRLRk1CbGRkN0xWOXlWemFId2p4VjRIZFFKRVJN?=
 =?utf-8?B?R3ZJVk1jT1A4cDdNQy9tc083M1lOWXhWS0RmM3QvaXdqWnh0eVlRbkl2eEtn?=
 =?utf-8?B?Y3RPY2F0QUpuVVh4K3dTaVlWbjRKUWR3QUV5NXpzaE1ISVFiM0F2cUtmQ2I0?=
 =?utf-8?B?NmlIOEJSdmkxQ0dKT21oWldXRWRQNUhvMkxnNzJldkhtUDQ3cmdyWHVFekho?=
 =?utf-8?B?ZmhaNEtsQlUrcVhtZlVERnpTTXhIUXFES3hTMHk5Rkw3Skh6RUZrTUFYK2h1?=
 =?utf-8?B?Q0hEQkk4U08rM1dVdlpna1I5Q3VmZldWWlNmRWRKcUx4d2xIclRSVVp0UHds?=
 =?utf-8?B?RHkyWTk0ckF4WWE3UXE0dVFiQk5yZ1FxcURzaHIxNXNXUFhEUy9SNzVkbkJr?=
 =?utf-8?B?YmoveEw1ZDBvWml2N3J6WUJKR0ZSSmNmREhBMThyVWQ0UHp1ODVlOC9sYlZw?=
 =?utf-8?B?OHVQR3lZVENadFNpcGhwcGZMMlU2U0pqRXE1c1VqemdJelR0ZklzMUxFcVlx?=
 =?utf-8?B?djZpdWR5a2luQ2ZLU3NNbnN1UGNMZW45RFp2NjZNdlRnYkNUU0ZhZTFkMnpP?=
 =?utf-8?B?VDlxUGhCNi9SN2c0MG40enZiZjdBUkd5b1VIUnVnR3dkTit1eHV0aVhwdHdZ?=
 =?utf-8?B?eEJ2Nk1SRDhwOTk3NjhXWE9sWFNGemViZnJpSnU5cTFkSEpFQ2t6QndYYjY3?=
 =?utf-8?B?eWRPUDMzZnN4cm1sb08wd09HazNQKy80K256MlFrbzY0cFdNemdMcGNSQVJv?=
 =?utf-8?B?YWtUYlYrOUUyMDJ4bUl4Y1A1UEowNjhHRGYrN1lRNHNVVWlseUF5djZjMm5I?=
 =?utf-8?B?Z09kN0k2VGhocmY3RHlLUElqTGZnUW5mYTFPNW9MTTJVMkJoVWYxL3BsZ3Yw?=
 =?utf-8?B?djJTdVFyS1FCSkhsWkdBUks4R1B5MkhUWG1DVEJMR2ZXcHpHaGZySU1acWtw?=
 =?utf-8?B?ekxIWEZLMG9pU1V6cDE1TTl1SnJPNXVFTzY4UFk1MWtEOWEwMkM2R05UMTd3?=
 =?utf-8?B?Q0U1ZnowNkRGNENUZkxBYTZ1bGtVNlZkY3RRYXc5TEVwWmVZdFB3UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026d44b2-4521-441d-7405-08def6dcf960
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:43:27.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bk0F6j8LHKtylw71kmAc1h9tTquA3EyvBUwxO1GkfOBj8MH17fpxk9asvQdZD9a9HYenvRFa6uoMc0BMj3OUFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861

The blamed commit functionally changed the error path of
cdns_pcie_host_probe(), now cdns_plat_pcie_probe().

When the old code path executed "goto err_get_sync", the PCIe controller
probe function propagated the pm_runtime_get_sync() error code. The new
code doesn't, and returns 0.

Similarly for the "goto err_init" previously triggered by
cdns_pcie_host_init() errors, and now triggered by
cdns_pcie_host_setup() and cdns_pcie_ep_setup() errors. These are not
propagated and will result in probing success, which is incorrect.

Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manikandan K Pillai <mpillai@cadence.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Tom Joseph <tjoseph@cadence.com>

v8->v9: add Bjorn's Acked-by, expand CC list
v7->v8: patch is new, issue was flagged by Sashiko
https://sashiko.dev/#/patchset/20260430110652.558622-1-vladimir.oltean@nxp.com
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index a1ea24fc3b63..8aed8b4c3e11 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -126,7 +126,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	while (phy_count--)
 		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
 
-	return 0;
+	return ret;
 }
 
 static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
-- 
2.34.1

