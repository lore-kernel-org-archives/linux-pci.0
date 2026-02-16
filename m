Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012063.outbound.protection.outlook.com [52.103.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CE12D12EE;
	Mon, 16 Feb 2026 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771208852; cv=fail; b=ZGAlHxQOp03/WWMEO1HA3S9zPJw6fawaI/Wy3rNaZqYlNk7Mr3+px4BEhaZtvBwbPiuVVMsDKjNkLLtmTpi+DQZcvLoeS3LRq8QvOKt+AItPkZayIUwyXe9nMTC9CSYRcJuhZ0GlAg0JS2whID2+RwStA1YMjU0VfF+efV5xeA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771208852; c=relaxed/simple;
	bh=uHo9ofCC8KyH+aFADVPSFLC6NmUp6howgSQZfuyEVTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYIpCt4HcpIq5iKbn+Ny1LJqmty9XBlVZtgvTUFhgOqQX5KkxRuiqIDl0PUCkTWGqgk+XW+MZRpEObwBbn+JRI7XJcAZdjYNpqOSdI0fZyModcepLmW/wde5JsCdHdeOo2vuVihSNUg9q/nHkk9WlHAlziCRVggdaG8Ek9o32R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=RrqWRV61; arc=fail smtp.client-ip=52.103.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RrqWRV61"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irbGojOpEsqOsdvxveycGZk1o+GzRbqjPvS94P7mq/ttRl92/TJIKAoJbq4ruFb4wKTcWbvKGEZF9VqlgmuVovulHJ7TndKh3FVdqs5V5+Kkt11DuY9AM0V351AmkRArBy6p/ista227R7bwfxcaXsqMFXXiTnG12xUr6ZD8gv+57EJDzdyZ330tkQtfwTMUGt5FEw3JSSWzF0gUTKSsRCpeaNqnt+GuLOw7FyDRz1RqxGN1ifqgL2eUhVkyIruU2A2rwYZ7VHU98ib6wuHledCrnTuH4juOO4tvpzAtHP7hMP0IPjwXqSoqevNtkhoc54eZxV6jqZYAxp5rQImSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoZVRO8RHU3yCWP+9AMNDhmCI2OLewu7q+ZKnA3G1ZM=;
 b=Br/hQEOKhrG5wPFGUTZVemJN9JEPvKw6kDWrvLKCiBmOHOJQXJcO6W/0WP8LD1Zuu2dgRuSzGQ++rNBpsu8GaUW7zEWCDDgQnkhpTSlvLvy9EPffxba/Ssmk+KZHUKpRGB7n2n7d/KKqyve/ApvEhT4f5K776Ydt6fiCgCZRvo8Y20dRejUzw1/W6zSVi2naJZn61RsRzDO8ofk5Jiq7wAaRMmiOoeJacdgOuRIjH1pmY3EBeOdikd254k9keGSSxG9Zle+Zg/MmtBbRliua/s7kipPZnxoOantI38JULErVbbMFEvGvcLL+qEq+s8gDxx+S5w8G9/qs8jNww5uFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoZVRO8RHU3yCWP+9AMNDhmCI2OLewu7q+ZKnA3G1ZM=;
 b=RrqWRV61Y/44X01spUerc72IIaS+bYXZGTAOfrhmtgu0tGJXn9pUW4ZJDOqoiGoLqOSmHf3vHRNtjfOpu48lWW0SCxOzlJRNnp/ruf48hdprsehYXBoXXbbvXQUe5Zsq/P2FEs6aH5LDm2OhjozjV5sciOja+BZ4MRHaemliqQTvijx49vRjZQmFeBrRZj+VI8Rj3eZXknRzqFVCR3zbCf3mtOOf/F3QHWIzZ0Lq89KDHdWknoy6vaMrHIBE5xp8HmaANQwFjrSFA8PxWknrh0UhX71+0u4sj/CXs6vZfpkLuCP5hBPMQtsI8RE0Z4pZLvXEVCrfTrC/wwM99oRijg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5340.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 02:27:27 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 02:27:27 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v5 6/6] PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
Date: Mon, 16 Feb 2026 10:26:42 +0800
Message-ID:
 <SI2PR01MB439378762AC028FDF3B72519DC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260216022642.112923-7-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: ab83d8dc-6282-43e2-c9be-08de6d02ed3a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|461199028|41001999006|8060799015|19110799012|37102599003|15080799012|23021999003|12121999013|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qVWyRNXrgYf8bEurhKsSguqP1WE0Rs54fK1SCKuKX6FZnyuOmR1mUu6QjhTd?=
 =?us-ascii?Q?8CI3niAfWK70AjG1XNdiAXEVc7a813IsXWv3SB6cw+6WqwpDO6f3Wrbg2emu?=
 =?us-ascii?Q?zGYvdEvanW87qnVEp+HPYdyZB3vk3ecAlDVwGYjplU2nAEsP5MrJ0HaRERW5?=
 =?us-ascii?Q?wsjIUYXPutZtut5IOFBp1ok38XN6JQprKoPkWxlQCucrfiG0JiNid4DHYb5q?=
 =?us-ascii?Q?JCaWdHUQDDesvCQPu6SE6Pu3BgLPhqWaLC0KMyI5Yhxdpz/+F+z12muIqVwC?=
 =?us-ascii?Q?gibQvn2mbhr+K6wEfyqLfYzjA+SK1vehss+uaS74vzzYSoT0GRNXztrX9t8k?=
 =?us-ascii?Q?1c22vFF7OBoDM3U7OaSARul73d7x/szYjQvy+3ckBT/Ux+Q3NXJnIX1xgF5H?=
 =?us-ascii?Q?w7nGcn0xH8dQqrE8n36lz1H7wUj74nmV7YhKM36U8pf2PL+9cFXK8etPEh7I?=
 =?us-ascii?Q?4YnXUmDhOq9x1qGzPqlSyCG2LpMzHQeVDERNQ2W0TE8lt7TPnMo3kkvPVMf6?=
 =?us-ascii?Q?2nIW45gWmQT1BAAVwNBftnaqqAdkOL3LmUk+FgVKUPR7mouEJHQ3qSTEtxQp?=
 =?us-ascii?Q?pyfEVQa9ko2bt8ELqavC8Y4ax8M711gHf5CsnCmQ3EChtdixbGz7Pgc3dwDM?=
 =?us-ascii?Q?msN9kV1w6h+U3jN7lwMVtPTzZ+wbv40hBw40dXPQ94mbWC8mTQbC5indBqnM?=
 =?us-ascii?Q?EoLGdgf7Edl+DSPhPdjEFPiUUapAlSxZefCKZUZDBPeRWMfL8qpkOAEUX3SA?=
 =?us-ascii?Q?mMN5elhDQlWTXxNDOhN4TRhknSQRwgh7+D5MVe3ZM3vpgN7j8lTDLeyGkQ9V?=
 =?us-ascii?Q?Jvc6LylcQ/rSjGwn9hvPxtCGy7WHVA9x4bvF02G4/HPh91tBhB9x/u1H7sFA?=
 =?us-ascii?Q?OqHvOyvFPY8WXvG4ok+GVfMuyiRn/QATzPUsi8GCUs7h2E+av3SIlaLVE5Hq?=
 =?us-ascii?Q?6o/aMKLCIXouQpNtmp0meF6sOQ5vtaFdaxYotsDI4mJJIygPT4sK/lwHkKw2?=
 =?us-ascii?Q?Vn/HRl8Ui3hy8O5e9+IdWVEElpAMJyOjaUGUL5Y8UaMm3BW/GinEmcl9my5Y?=
 =?us-ascii?Q?qvMGFRyBk0vOoYTMD+S4arV0V9H7tOWdhRbqs5VlsLsDNXnEpRwEO4MG1QYq?=
 =?us-ascii?Q?rQf+C6dYV3o2erymIH+XVraNyThDFM1GFkPWJaL7xrSYMNAgGxi8sxXKfC2O?=
 =?us-ascii?Q?H41QbaHFR4rwalGhMOmUs+tDe84majucjTpc/JH7Tnde5XvVvu1ejnevrto4?=
 =?us-ascii?Q?0+Ike43WL7CV0EqP/GdND+fSSQOYQr5wqMTdH2yrgRL8jRmPAYLcYjsXQnK4?=
 =?us-ascii?Q?Jwg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yCyCa8xUebxS/5kuiFkSuVVlyCcgYqCMWCJAHnYPXGMJ0EwUglbrL90SmY3A?=
 =?us-ascii?Q?c58fKDf6UkJcFKiWGlTSSk6Y0xWQeXMy+0IWvD2wyuT9ZOK+KN1+ZtTI84hS?=
 =?us-ascii?Q?/UB5xzaUYMoqFBC/N9kZPBf2HbRXpw0dqR0yU7zrvclrssDo98fcTYoHXefd?=
 =?us-ascii?Q?pnNpy4vcxGTtpo6rzVJd1Roi23UhalL+dbqUwei10OtGplHC8JY0kZXBlQEO?=
 =?us-ascii?Q?hMye7DZRRwUnhsvts9sDk0jEcqsRC3k7lHVWGG9vLm+b4tZeN3I7W2Mm2OzH?=
 =?us-ascii?Q?jBDWQlCvioeLM8GMH6eJrwmLRZL9TxV/9xXOTmRFOmuwDoGxCoi5KPyX406D?=
 =?us-ascii?Q?4jcGVZa8jzJhFrXAG1CWZnRK14X9yHHxi/8Ty2yFHOuzfgoaJhE6yDY/DXLw?=
 =?us-ascii?Q?dYeCa4F6okxUhWqROO75RtDHqJklsI4moHVIgoUfvotXEzO4XKt7DijOTpko?=
 =?us-ascii?Q?0/C8kE2z+/b4aRFzPNR+waEUNeMjO4wviB+sE+iiG/VRUscYuOc3bgRXb4O2?=
 =?us-ascii?Q?iWahAAhYQwevysYNq5OcE2l6fWMG2GJHJNWIqCYaDf8TvRm/1tGoFuz+2r2d?=
 =?us-ascii?Q?L0IgNIRau6ddA9BySo5/NBaewG+5IeI1k45MkMgRnswsflsLEZSzU5a63NGm?=
 =?us-ascii?Q?e3sPEfUJxenKiqdKVRRmAVY6j+Z75ruWh59fuSE0pY3fYAeenXdVnSBUehKP?=
 =?us-ascii?Q?/sAu8LP4eIsuYYQ84iP6UScZVR7jm8Qll3voRtPSWf/e6UfrdJmts44Dd51R?=
 =?us-ascii?Q?rgJL5DVnER7m6iPLZcJ7zrKZksGrJGcNCcVjOc5C5gHYa/hcVW5LkOJmUSsB?=
 =?us-ascii?Q?1Hw160GS1iy1tIz0Qy5R5jyoEojq37Dch7ybLnQ4GffRzGgmIhQ0xhQnl+ar?=
 =?us-ascii?Q?QBOGB8TCERDGrqgNe1PC0dnPfFN2HTrz4wSZ/icy3ByGDdbbjN3MZkhnLxWd?=
 =?us-ascii?Q?QPYCM5NwqVUDdziJE9xL/5eIMtrQv1nPLF46UUFKYpxz1lCQbP651KuSSmbL?=
 =?us-ascii?Q?lhjQHJcGm+sgqZy937iD5+nEeJQ2Mu/FESHNSAKO/Jjjfy2nehvav9zV/8Gu?=
 =?us-ascii?Q?R/Og6rgSVoD2lv12yv8lGLlqdSHnwq0OtO9J+23h/qr+zciWRDwKlAjiPd5B?=
 =?us-ascii?Q?/JFTVdcS/qbd9H8soM5Kk0/uzmLn2GbCLVrBz7z3OqWVK9rBBCvkosVmlrin?=
 =?us-ascii?Q?Wq8NR9TNe9bdY09e18MFng0VUZZuh4IPls+Tz0ym4B0ALkxRefXFAMK37rhz?=
 =?us-ascii?Q?HUmQ7WDOvXexb6bWvvxFJKNASMDgEJxTv2kyvIPYL7bYVefD0IJEsrQ0iIMX?=
 =?us-ascii?Q?hRT82xjXBhV3O8im9NwdyB+ekZB3qqUC0vKsmuWrccOwS5i7DR4iqqOH6Sw2?=
 =?us-ascii?Q?JXlkzO1scTHiD9heOixCJPVR3JRJ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ab83d8dc-6282-43e2-c9be-08de6d02ed3a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 02:27:27.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5340

The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
isolation. On devices that support the PCI_ACS_ECAP capability, the
controls are required to be enabled properly:
- ACS I/O Request Blocking needs to be enabled to avoid unintended
  upstream I/O requests.
- ACS DSP and USP Memory Target Access Control needs to be set with
  Request Redirect or Request Blocking to ensure the Downstream and
  Upstream Port memory resource ranges are not accessed by upstream
  memory requests.
- ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
  areas that lies within a Switch's Upstream Port memory apertures but not
  within any Downstream Port memory apertures get redirected.

To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
support, pci_acs_enabled() skips checking for the capability.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c34780a5f886..50400f646539 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3560,6 +3560,53 @@ void pci_configure_ari(struct pci_dev *dev)
 	}
 }
 
+static bool pci_dev_has_memory_bars(struct pci_dev *pdev)
+{
+	int i;
+
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM)
+			return true;
+	}
+
+	return false;
+}
+
+static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
+{
+	/*
+	 * For ACS DSP/USP Memory Target Access Control, either Request
+	 * Redirect or Request Blocking must be enabled to enforce isolation.
+	 * According to PCIe spec 7.0, the DSP Memory Target Access is
+	 * applicable to both Root Ports and Switch Downstream Ports that have
+	 * applicable Memory BAR space to protect. So if the device does not
+	 * have a Memory BAR, it skips the check.
+	 */
+	if (pci_dev_has_memory_bars(pdev) &&
+	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
+	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
+		return false;
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
+		/*
+		 * The USP Memory Target Access is only applicable to
+		 * downstream ports that have applicable Memory BAR space in
+		 * the Switch Upstream Port to protect.
+		 */
+		if (pci_dev_has_memory_bars(pci_upstream_bridge(pdev)) &&
+		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
+		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
+			return false;
+
+		/* PCI_ACS_URRC is applicable to Downstream Ports only. */
+		if (!(ctrl & PCI_ACS_URRC))
+			return false;
+	}
+
+	/* PCI_ACS_IB is applicable to both Root and Downstream Ports. */
+	return !!(ctrl & PCI_ACS_IB);
+}
+
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	int pos;
@@ -3577,6 +3624,19 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	if (acs_flags & PCI_ACS_ECAP &&
+	    pdev->acs_capabilities & PCI_ACS_ECAP) {
+		if (!pci_acs_ecap_enabled(pdev, ctrl))
+			return false;
+		/*
+		 * The check for the required controls in PCI_ACS_ECAP has
+		 * passed. Clear the ECAP flag and continue to check the
+		 * basic ACS controls.
+		 */
+		acs_flags &= ~PCI_ACS_ECAP;
+	}
+
 	return (ctrl & acs_flags) == acs_flags;
 }
 
@@ -3635,6 +3695,8 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	case PCI_EXP_TYPE_DOWNSTREAM:
 	case PCI_EXP_TYPE_ROOT_PORT:
+		/* PCI_ACS_ECAP applies to Root and Downstream Ports only */
+		acs_flags |= PCI_ACS_ECAP;
 		return pci_acs_flags_enabled(pdev, acs_flags);
 	/*
 	 * PCIe 3.0, 6.12.1.2 specifies ACS capabilities that should be
-- 
2.51.0

