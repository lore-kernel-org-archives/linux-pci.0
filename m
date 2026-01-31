Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020130.outbound.protection.outlook.com [52.101.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032CD199230;
	Sat, 31 Jan 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866627; cv=fail; b=AwHvuQ6at//aEgWQ3LVmKVmYMdnpiTIhI31nGNxAVa4JBtVyeeoqRfFf9wUCyFvQ7QEr3V8hOKg4zq5gxofwU6X3tWkovutsqmy+7nfmIaHodChGR6xx6vQzV/Bw/a0TGBLBUn/gLd99HKXAJDPFgzLkHujO4v7s7zKzBYxTP08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866627; c=relaxed/simple;
	bh=5FaUJtvQJZ5vZ7VEucjGszVNlqcEL3+eumSMSvKe9wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3HtGqjMACcbhqxmyDcLLwe/KU9J1cCUTvjHhPZ9dcV24rOEx0jIBKse0ojX0ABSSR9OIWeF2qclchJfWG3iCLdqCXtFSEhqBzTYLt6Siwl7IFcni+FGGAs2nPV+l+e6/QUCQWer+s/vpLxExcaJ4YHqk0jZNwEHyBmLF3Mi4Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wpLo9iFp; arc=fail smtp.client-ip=52.101.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wpLo9iFp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmCAfl9TS6l3YegyMH9TeFqTwHOe4hXUxgaAw6rC1iDKPJPLMYqC4GwQO8WnDkFwnT1PyjXniaHGmicq3ridTC1X02aFLxzCeUHS9W35D/BvWUPwh22o6rm9zc4ss+UnVlIDEYx0aWsKkYnrUI9U2Gn9RWBw0whxnVZvFgXFc5KbwVNLcUAT7ut1aJJyJf9H8SQYhFVEfH+G70ePEDLEKEov8Z3EdM82mfbznPrfp9Z9Y33g+2i4KWXdw4US10XkQia/774gb2BgcAn40dxn1xkUUgjyyRCjaXlBS5gFrpa9vflc094gxPawvHBkc88gud4B6aZUpgOxRLn9CEKOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0DJP6vTv0QYOKMrncI8q8Xbf3uzkb5sa1uQLq96KeY=;
 b=j/GCPTEJptfLjOQPmrLVb87B2kjbgZQZ4/fcuZ3HFmCyg6S2re8yADXyh/tVTH9mXJOiNnoB/ZKbUIZIiorjzhXYx1nN4wtDr34PCoZyiBEffTsv72bkNTBIBOEhq2K8drzeup7IhRVgzld4jyo8f372K8vfvhyABaXhpgLP1neqLG3OC8yxcWH4ECUSCM1a0g5E8ZHwrXuMiQz42AKLQydkeyEoOnBLY1H5+ocQbp2gCD+rMag46OAOYB3gkyAercfbbE17zIO6LiUhCJH1SYT2wQ0+UBrTV+AWGV4zCZ0O1QR95zl46ZeLIOtGk06h7nsJXs8w87uS65c/7z30oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0DJP6vTv0QYOKMrncI8q8Xbf3uzkb5sa1uQLq96KeY=;
 b=wpLo9iFpvUc5OvadTzfQnqC1hetkRSLz+T0wirQFSEqsaM29GehU4Tuc7AxYamEGMpEX+Dhv3/JOOUDmvNjNc5kyIWVRnERJzVoPlG0tdZbeInBeMXBVZlMoi+8FrjXZPbsz1Y09DUcTdGolnxFCe6iqZY7htLo3xoWEXZTnV4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5003.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Sat, 31 Jan
 2026 13:37:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Sat, 31 Jan 2026
 13:37:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	cassel@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: dwc: ep: Return after clearing BAR-match inbound mapping
Date: Sat, 31 Jan 2026 22:36:53 +0900
Message-ID: <20260131133655.218018-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131133655.218018-1-den@valinux.co.jp>
References: <20260131133655.218018-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d250073-29ee-4b6d-bac1-08de60cdd13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmLBWYzcopm+HQlzg7Mc/Nd4gN+f8NpUrINhKIVW5PBGApBPDl4+wTWKyKIj?=
 =?us-ascii?Q?oJbBvYiGeaajenM0wAx9U+OTmH8Bxgfz2wXYMB9xhBc/+Rg5blqHTaqQ5EDC?=
 =?us-ascii?Q?ZN/D6sePRepkkj7ju7G2yPDeih8PpctCpRUDI9dOnJSOHl28mz66+w4A0klB?=
 =?us-ascii?Q?/MVwqTK1OM48TsH1SkHPTbtkysjd4Ru/aOBmDVgBK316iJAwRLH8MiO93v2o?=
 =?us-ascii?Q?JVl7bGe3DuUKCh1KShUVxYCJRtLhsS3061H2hVynamZztXsJkyxbrq4AZXCl?=
 =?us-ascii?Q?seZNj9S9PArORQuhMyURZqI4a8hI0EcFaFvsnOyYij53qpG3n1PtHmMtxJfw?=
 =?us-ascii?Q?8hBPLEzUPEeDDRwo/lSEJh/pAmhrbH0YcHENGCCStrPGn+6vMETH6OqJ/qYj?=
 =?us-ascii?Q?uMHLaSqW3Xo8TKLKVrpdzxFl1iRZL6btDC4F9BoKgaypFAwiUW3CYGx6EKum?=
 =?us-ascii?Q?8NhTg+xdYG8YM7pvtJp01QRGD7Sbf9ogodRzUmWmwt/Qd5eK61R4RlQE6IE7?=
 =?us-ascii?Q?7w453Ed0CjqaaxH0DzoU9kP0A9aDer0s5lZVonEg17Z7rDpcbIWsD5CCEnLP?=
 =?us-ascii?Q?XLB+lgE1QSQiLeMHP2xoF3CEw/3R15LlOruad4NPB6kTFSb4009ZcvxNapbC?=
 =?us-ascii?Q?IlRxl+w61d+XMdqLEFf3JM50ylf3MrogYgsUzXhTOkuqEDhroT+iBxfpnQXZ?=
 =?us-ascii?Q?uZB3/tFCoX8zFRxxN/uWpU14XRX6i1RlEjEbvqffJqvVNcuAqzRhBuFvtIVD?=
 =?us-ascii?Q?YvFY3pQ+05WMDqco4PSXqmDc6ZSJJG9ozNizo1vcHc7KgCNPcU+ywOtMVQh3?=
 =?us-ascii?Q?aJ7rIlXFFV5kIjT3kwqxvis4hwW3VYErNJoEU2WjjYuFxuCXyw1HVNxK1dVe?=
 =?us-ascii?Q?kkLOOIV2Z3GN4XgN9xtmuDkE3XPTeesIAdihuqtAc+Wvc9DMts3krlcKLFfi?=
 =?us-ascii?Q?fAH6wzywszL7Bdx+3wHCL8zlU7qgPaW9CT6wOBVsFbYCBxXSXV52p5XcvY9N?=
 =?us-ascii?Q?a9FCBoU+KLa7pvAAlBrtdGZyru6kuoAWAmaiKolSjvkkng2wsy9wUDOXSzRp?=
 =?us-ascii?Q?VngnxvvR4L6X2hb9ujzmFxOZAvyi05xFO0vDOIrpgjeMgUYFO7/zK8ap6YkG?=
 =?us-ascii?Q?6HxbbJIYzGoc92vCavSMuExcnTVysEaBtYoiMBSGZ3THZlXpL7jouPUR6Ut+?=
 =?us-ascii?Q?Q4e4YjReXE2beLcKjqJzULu7n5UpFSiSCc9Qa5qkkHUPDQAc7RN5JpmCHeUk?=
 =?us-ascii?Q?8EeaTKr6R6+9slB4h3kA1kCggF4EmUWRC52LILQFh1WFU/VO3oteYyLJuOw3?=
 =?us-ascii?Q?jXi59ljmO0pLOM7kmFqU3h74cw+I3G0imTYiq/DOuUz6BzMVCWH9ETZFHiLH?=
 =?us-ascii?Q?VIFtlBVIJUnVCrg9t+9A9EsbwR1K0VhMak9YM5khroGzorRn0dTP6KlK8WQk?=
 =?us-ascii?Q?UkNfUcn+lvwUtRUUWkFW7oIhFw4rtJ1xxXl1NfQXHqfepuUUvkY52nzxLlKb?=
 =?us-ascii?Q?G1XuseOz+eJkwuwc6aPP8296Mms2Hu9dFIS81x9VSZJ1NCmKPzFlgktmxlR5?=
 =?us-ascii?Q?GKAoIffv5Jo29SZ+2Izj2eq3roSA6SAILLyNVGrtp5N6tgA/YTCD4TyvWCTW?=
 =?us-ascii?Q?BHCqygsWAcsaUIuzXHmqI0w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Izhn8MEh1/cMHzB9FWut7vtBdpAERWwJqNt4xVICHYbwdWKFdLRg5zQrDRW2?=
 =?us-ascii?Q?3WJXQWZF5fw0frNVKvUGHIifKl40YMfquZjnN4EbJWcPuGooDvmPOVmEUII2?=
 =?us-ascii?Q?AchoLELu5ExulwvD01Seb1mQvZ9UwkwJXpTZ8RCgWY+CUIBkaiFeZCDUwq6v?=
 =?us-ascii?Q?rwUj+GIgPxjG1YOMGnGixWk+R5NZ9vinCdtHoNP9bVvdz2n39JtMcfTr+Uh0?=
 =?us-ascii?Q?CQIgH5YJ5VBaz2wvdFux3bIfEKl6md0ao+iUbdGbl5BnyP1qhchYRXa5hSDm?=
 =?us-ascii?Q?rzT4NR9QV0ZBZlIK+Bpc5kSrdx5iHBCYc/Dzo2VN/z30p9hlF59x5mJgpXsF?=
 =?us-ascii?Q?oiEpqCnJ4FanAXPG4d2Q2pTqpJNU0tjpuwXDRMfSDCVG//xeftX17+FQN4aL?=
 =?us-ascii?Q?gmdIW0HdzBnvSW6gkD2TDXmnUehM+SD+rVMKfHlb9qo45zA6l/RpBTobV7UO?=
 =?us-ascii?Q?nSzUGCrZBsl2kpDGJeWmXoWaQ20uNFz0eEYBgW4tN68CRwWW1vRmwM4L9S29?=
 =?us-ascii?Q?X1f4ROyfCz1vMRyjLw+KyEPoLmqK7ERSutgII915E8pWbGZezIG8tCe6L7/Y?=
 =?us-ascii?Q?ST5Sx8qw9b41VxildGublkw2XSh08CWKubgiybCnpvGVq9FF/r2ojAaeO6kG?=
 =?us-ascii?Q?3zdglZ6+9re1VOS3TZ80aT8dsz8aywRswlaVulV1870bFF5KPu2gLHxWWJgW?=
 =?us-ascii?Q?3RZ+2lnFKeZhrKBKWYNTFHG8aIZj0/9hCMdBE/Io+hRtEBUCaN35IQMJNeab?=
 =?us-ascii?Q?//qGR1zFgUQK3Do18lSjZE5HeStRES47+YRE1O/0Lkhb9hAVRa/894GNXkDp?=
 =?us-ascii?Q?UO6Ph1jpTu98p6soxh6RIRKKyt3kxpZnAoVshIZZ4bgA690nr9hGLHWEhbs/?=
 =?us-ascii?Q?xQtILKZc7eZ/nHcNYu8wS9qJhBIbOB8VhqdUnpXWd8xjI037yj7+nAQhTivc?=
 =?us-ascii?Q?D1sav3JFuj4PtfxpprC3SaMn3NP5WosSJjz1RYgD3Ippe2ajBe5NL2DbjKCK?=
 =?us-ascii?Q?MI0pqiOyf8NvVvkdNuaZubbO3arR/k36hlQ/Qb9rG/8zZ7B+YbyT/Gkj1YQM?=
 =?us-ascii?Q?9L7IlXzitst9PcT1A5SREdtHvY1lFkLyM94SJqi/ixDwFE7JtrGjWBZCWZuA?=
 =?us-ascii?Q?wBoJt4gw1qo9EFq8E+aAH+rkpiy2Unmn3BI6LJJgDIDPKv/Xcnb0RWSoo+kv?=
 =?us-ascii?Q?utA2rrVltVOS7hypnN3PKxFkXzPbAviOm9X0i6prUxjGB1B9vPOTzRsQhYhH?=
 =?us-ascii?Q?zm3+Ap6kFTUjZy5QfAfUZTKjDx8Yyg6ihmLw95XdGvCe4Vq/8OLhGU3pyU0j?=
 =?us-ascii?Q?mKiHzTUcNqzs6YMhtgZMJ9EsYjklJHcaDBPsUBnzXu05TgRTlUKvQETMwVXR?=
 =?us-ascii?Q?WbvkyjHQ26OsItxKMMWT0eqNRLljl1jgVDK8tAwp9MqhCXH/ziuCgPOEK/CC?=
 =?us-ascii?Q?q1lQ/XQ9Zr58OeONgb3ucyUJpYuyJoDSz4sGfyowPN7ZiAGYaXMD5XbOUh9a?=
 =?us-ascii?Q?ozH8fsAoFKFac43CmwpDMd6+yVZbEvyiD3HLT2VtSA+zVVnXxhdVfLK04mta?=
 =?us-ascii?Q?FKJBoKsRV+ByxV4UjT1fTyIOgsHQqC6ZEy+PbXOKD+sjXYSTaKqW2DqYRTIw?=
 =?us-ascii?Q?QRXlhp+qoakRDMH2LHHN0I3lHsTn8vS56y/2k/wf/bhzoXywc4/XUOrvGXDa?=
 =?us-ascii?Q?pF8suoR79EbRSJD4CAvK88PAny9oqniWMxvg5EPyIlMB5TO2OtuxebbmOy+F?=
 =?us-ascii?Q?uebCv+edEZBlAWDXQLYbLYtZAvMdl7+dDsuoGQFFOWhQVIfj/8Uj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d250073-29ee-4b6d-bac1-08de60cdd13d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 13:37:02.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUSmwaGfQb8Bw8SNfHksFBAiGFYy0KuxQJrIBDk1bPb0qMK9QG3OmSM3WVC4MWz9Rzy+YY7wmLfbKdMH4KF1MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5003

dw_pcie_ep_clear_ib_maps() first checks whether the inbound mapping for
a BAR is in BAR Match Mode (tracked via ep_func->bar_to_atu[bar]). Once
found, the iATU region is disabled and the bookkeeping is cleared.

BAR Match Mode and Address Match Mode mappings are mutually exclusive
for a given BAR, so there is nothing left for the Address Match Mode
teardown path to do after the BAR Match Mode mapping has been removed.

Return early after clearing the BAR Match Mode mapping to avoid running
the Address Match Mode teardown path. This makes the helper's intention
explicit and helps detect incorrect use of pci_epc_set_bar().

Link: https://lore.kernel.org/all/aXtrW7viGZfMNZur@ryzen/
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..0ca05943a1e5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -165,6 +165,7 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci
 		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 		clear_bit(atu_index, ep->ib_window_map);
 		ep_func->bar_to_atu[bar] = 0;
+		return;
 	}
 
 	/* Tear down all Address Match Mode mappings, if any. */
-- 
2.51.0

