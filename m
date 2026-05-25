Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD2E3A875B;
	Mon, 25 May 2026 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691950; cv=fail; b=kstnCHk7KdorkZp0cZAQoraD5F1Xwqf8dvgeL/LQbgBQtmW2tKEM2b1VHIFz67wI254GVmZVTyaqrSxKahJhifcw8312+t8dA2xxQgUfWhv2HZ+cd/mHpZ3Yi6+8N54hPzP5Ew3EOMvUAzcvKr08fCTu1u9SvXRjl0FOYaWFv8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691950; c=relaxed/simple;
	bh=5BffsxKjqdFvO2Ryw8ZTIFdWeZuJnjpvxwh7SjJX1zo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ArHNq2/EFqoAu816Z9YZlo/WISeHlUSkSfuHFQAV9YrE1sa8AziMMLf7p7XYes4LNPxx+RFzsNV2+64JM09QNGml/J9/tNaR2w71PxGiH1vi8aYqE1BRlsoiyELOVx9rHj+mmNR7W4Xee8VvtctIsSb94noEgyFarhcXcGNR6dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=v5a4jRSz; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v5a4jRSz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5EhpWJ680fBT187PFALG7TmixM888BBosspLqSgXVdTlLYLKQ8NLhl6b16lwt7LyuCW5mmF2U2J4/ZHenogGFSN1dmUB7JKHz0PAsDt++qPKt6F4cl9XXO7jtPQYzaZJZO+b8Fq58Y3oFpB33nDprMIYDBVKoPmJ8dlZL/1nx80u+ksfar6umQStfO8v4DYT+ob+siqYoLH3UYz0lmad7nMKYmhOg5h8bGvhzk41MnZnkIH4+RnI+U1UzLcBnY++fVVIFGFvQ9SkDIKGVEA6gqcCUAl0SobBDSO4WpUUAvbJ944fNRdPu4RFoJPqrsfwKecsyQ9YmTd6Bs7sonLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0Q2RfZPiBt2jPunRI4SNFZYdRLJbYJvtIoAP5jVzOU=;
 b=dWNhNhXkKpwqB6J7zrbMaHEppThLnBc5CJMNRZJhACoT/v/f7+lN7Ae0OMXbUDl+l36B2G/rKNVa5L7ABaZ1MTrzW4PflPMh7idSNJPks8wNhoAmix+QNSquPfKQsNnk1hDK1dqnq1hLQDgwiTaH+IFWX1v4N8n4+zRKjDFZftFw+/gpWoaErke8mAA38DZfTSvatMT+JBmPcMNRjY0w1ec3E1fjvI3SFjrNbGE/P/+o+XtncosA/zOq38r9EywG3R7V6EcEQFEMwlHjoJneW7tyLsHg5kzCz+5+emnH9iV9vhWEM3msryW3dq/+oVOsP9ZGw1Ul/fepNiW2YJ5Q5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0Q2RfZPiBt2jPunRI4SNFZYdRLJbYJvtIoAP5jVzOU=;
 b=v5a4jRSzlVk3fGRAwsUysCaiR9kConRG8Tx9EynJqpCgNazoSIk6hV8Cu8R/6a9X0q8pWsitcJhfCysCSHBmfjQ4sEBPxnGIWD9nlMsFy7XcjUxiCiGfCd/xXxSec9wjptf4WHnWk8IA6DEWnPorA2zsdLd8h4cZLrqZ1doaD+tzr8H/3IT4uFEZrYilOtazf2x9zpKQOammvF3+/oxGRv2S4ba1C0jHRf6wglZh8kDyWzQh7fZ+7HPvQf3rlyFTFiYZT4uRwF0ODMoDrWRPUZz4fCd1qBVrqGunJkrcAOAWY/z7yIFJd1bueVQJ7l0oF5vFoPJraB7LiM8E4mlDiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 06:52:22 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 06:52:22 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V2 0/2] PCI: imx6: Improve PERST# fallback logic
Date: Mon, 25 May 2026 14:54:41 +0800
Message-Id: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb1685f-064c-4bcf-7448-08deba2a2b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|921020|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	zPJJcdTeMD8G55BJGWRG0Cpfk8FyS8N8jnIX9yig8COqqfonlKdSviu1H5KTg3RGByH1113kEgXxYwSbTLbvikb/k2PY461qd/rhz216i+ANWpurWDniu0cF2znGRAg0fA4C8tBALhovfm9Ws6tZRkx5eBSIMlIELmpeBW0VucQ2TKR/dWCxCNVsT9JFytYBQh2/da9do7FINNWK8rcoDHFcCXR4w1yxLn6P8xkt9P7xOdemRNEUr8dEdrc1H+su6gNODKOnQ45lHkOY8zVy9D5t8Ruh14D37d/vncrcqmLgAi/IBP+cVzXywfOU52Y5nMgwwLidxIjxx7K78eZ1KbtcubFLpT0nblwC5WXPIDGrZRHoEd5zfzwNLrBRYLN2R9KYaDyx4bKy9QtlhfdOUMht9i8JLM88M35POd9a0IxcanxidvELUiPgELTNx/644UCCEnwwTXoiPMm1IQnvj4qqraI3exVkOlkW8zhxf/BDN4LhW6mjdyrQc9D2z04/WpcD1f8mviInJjJQpRtR6Y44yMwEEYzZLwjyM/EQh+LnuxUzKXLXlbiJify6ZC6c8RpfPPPjP96Aai2IO5U2CA05hY14Li45bapywGIlrXVd33TdfT06oaL5F4nV2jGZiA3ndx0vruSq0wNJCw3/vc77wFtsD/2GZNSuA81o1UO3veK3ES9RP2GOKZTk0wzIiLPg1peb0v3Rv6bXZekC0GHo6wmHEHk+NV15U/WMSKg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(921020)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OpWBQVlEYyTRVYZTW6WU4fMKcXM0kBcRxjNveppC0Gl+79x1jBNSHiOa9blF?=
 =?us-ascii?Q?Hcbw30/YQkqbQKwUt2UpR6PHQox2f5BWRwsoL5fV0qpwvUFGlT9LYkoaZl93?=
 =?us-ascii?Q?VZFeeXFkx/1Yekbix2ny8YsOjNfDUDEkX8GiAjYDHuBiAUhI8MLOsO/y6bFP?=
 =?us-ascii?Q?y00OIP2kjpj2TGV2A4Glm+ovSgPxwg9V0/FkTQeWUizLcOkUodPHSRGrS0V4?=
 =?us-ascii?Q?ZpyJ87RdFxqDk3c51NM6hBS+iHbMxjCOfUQVir+OIywjI+cZrxwLOOYj7+xo?=
 =?us-ascii?Q?lIbh/bVbRcnf+Y+QuVfSfkcSoOg/6aKcAV27+AN5De35EE4XOAIyCRJVLXbU?=
 =?us-ascii?Q?O+wCCqDjW58Jv28m0Hb6bcgi/3TqkjGG6QbQOrFtnESOP2CHj02OOVhuWd5f?=
 =?us-ascii?Q?LBh9VXg+xU6Ze2ZPs/GjUSFe3tUs/oMnhhT35sb+dpU+TaBMqhayIZgkqCcP?=
 =?us-ascii?Q?fKjYjQ1oo9MxxLW1eyuzVOeqdLY3yoaIyeFIbMlb9CvyNjA/4oXuIF+7atf3?=
 =?us-ascii?Q?BuzY4UJorTfWs1YsoZvYPIJ/IUbhOZiAFQr9oWG3KpndAYK78k5HQipeW9Wy?=
 =?us-ascii?Q?Ja9IsRPxZ2xlt2UnJYLyFadBdUeXn6pF6sKjja10VUFj8yiGGGZkQB8xmkQG?=
 =?us-ascii?Q?gW6gIN8xe27g9XLsAERsHsqu/A9U+6EHA4wofzSflaqliEkCbdwGdLS4FUOD?=
 =?us-ascii?Q?SHvXzVc29PAmJu9ZNnWqeu2E8zJM0TBtDZR+Mu73UChiRw5HdPc+Xhu24ExV?=
 =?us-ascii?Q?FnQob2tpunLjVW4jVK6YIz6TC/aKYNslG/JmS2esgcPrVXQK6uLgtD2rv7ma?=
 =?us-ascii?Q?VyBrbWBV+87i3xO8SBj1HzTUwpcHDuCyQOX72yt3N5D7zzDeqb5HGHGNTt6F?=
 =?us-ascii?Q?PhFKDAjKfW56XW0NAV7PTWBZHIrP/KDh7riOhFDQ2XNXuq/ZxjXNR+pkx9Fg?=
 =?us-ascii?Q?4mxHGnoRWZMRntkLfip+T4938/bgoTu9wby4lM+JF7B8S2VmrJ0Mhy+g1SKE?=
 =?us-ascii?Q?hK9gLyx+QPx5jVKs7XvCAfSjEyR3dXqIozmytaqNmdyUgZMBnLEsFZF4liyn?=
 =?us-ascii?Q?V6mdojid5kLHoSgkGZTAnNc0S+5ywCfCFOJ7Fv6schAEnWSLb2OfJDXntoUI?=
 =?us-ascii?Q?E2CajXejqUfq4f2rPPAAOYIn6+OWZ3sQRRffM2DF1GncKAFC/+b5mJBo2NB7?=
 =?us-ascii?Q?IllTcuX7Iw/7YnkWGKgGXWKYKbbUooa47qIDjXaZHFg8GQfE8QzP3tWyvEkL?=
 =?us-ascii?Q?2LpeG1xxx5kV0yyBbOkMfQ6ya3zHOcctNleEbw/qCCJBq+ulQW1RKVQ4UA2X?=
 =?us-ascii?Q?IGajpm2dhDxfKFKwHlWtNP49W+FCKkXDm1H6EMKYSPVvMY/JMtvuRUpRQs0s?=
 =?us-ascii?Q?sp5C/b8/x1cHIrTHeCdwFbdaWUkCnrow0B/bTOEuHkR9SV9oHaNfOZ7Q2VuG?=
 =?us-ascii?Q?AxD9C4OQFWu5J3Pu87GYQZXc2cDivi/uSAAnVHOzxWHFh/Cb9apU3GOMfn4I?=
 =?us-ascii?Q?kSZYxqCVvdpf6a2KrTcAM2VYOphhYdcwxRGF7Kd/Jm6QtimUJeGZhgXUXBXN?=
 =?us-ascii?Q?xDkZv/vzHLGidnT/AyWK1xmkfrd3kcg/mAqVJVlSryKEjoItkng9Jqf3xtHf?=
 =?us-ascii?Q?Vr/gopsFpYcHJxiFvbng4DDJwU/YUYLk/FxO/XSo8jNbU+MnjWwgHQQPxTKV?=
 =?us-ascii?Q?OsNEfalFr03S9k6WY7oMII477cyZy6QcIom18smQ+U4SBXL2ar0j9cS7/30G?=
 =?us-ascii?Q?+BO7m4n+Mt+m/H69jlT1MVX5GTek4kRmZ/TImt1lbrP//0a+U755?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb1685f-064c-4bcf-7448-08deba2a2b7c
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:52:22.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6dlgTDub2LZIHUBgt4Q12RHIreJWQa/5lhSWHz0KusEfsVlpJUUoUx5rrcJxIskvuvNiWMSwHiQ8Ecyi0AAq+6gCx5UkMxbgTNDZNN6KRzA5su2kpLlpUQXuH3nfdEi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

From: Sherry Sun <sherry.sun@nxp.com>

The pci_host_common_parse_port() shouldn't decide whether to fall back
to the legacy RC-level binding by checking for "reset-gpios/reset-gpio"
properties on the RC node and returning -ENODEV. That's a policy
decision belongs to the caller, not this common helper.

This patch set improves the PERST# (PCIe reset) GPIO fallback logic
across the generic PCI host bridge helper and the i.MX6 PCIe driver.

---
Changes in V2:
1. Improved the commit messages as Richard suggested.
2. Collected Reviewed-by tags.
---
Sherry Sun (2):
  PCI: host-generic: Simplify return value handling in
    pci_host_common_parse_port(s)
  PCI: imx6: Add imx_pcie_perst_found() to inspect the parsed result

 drivers/pci/controller/dwc/pci-imx6.c    | 25 +++++++++++++-------
 drivers/pci/controller/pci-host-common.c | 29 ++++--------------------
 2 files changed, 22 insertions(+), 32 deletions(-)


base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
-- 
2.37.1

