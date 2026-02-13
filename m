Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F9257828;
	Fri, 13 Feb 2026 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955691; cv=fail; b=oGEbbCx7xx3dlJYKoRem1Vqj7sScTtUC00lC4mpIusikgxM2R32wa7U3c/a2Ix2vIGtt72J1iWIW0KO+chB1d0shyb6n8a/9D+SYFkgbIrBBHUCSHLEVsypP7tnwtcPphomvhc+KRtSwymAWvGBo7V6x3HvgZ0GsSjwCjHzxgvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955691; c=relaxed/simple;
	bh=xE8Q83yHNTmvq4CWDOHKTeH6bOHFqLYApsCRB+VaYjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jidxXiD+wZ+SPkDrkhbCRHfFw0KU6jw1I8WOykXrQu8fE1DVnAxZHjqGf5lJtKZcqA7LCB4eBf6TrDwO1lrG38Vij6SPicckkrbhK0Cff9V/xkkEpXPAyXcss31NCDGLRsPq9p2yxwAswi0jmb5f5SN9UHAtccF514Kxls/lBvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eCCSP2gJ; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eCCSP2gJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4kHzhsI5QVJnC08uyNoHFaNU0M9jYd/4kNLuVN68cSD5SGAClmoPWoTSN5Fxaq4hsOIxdwTJ1v9MjA8O/vPUS38c6RGEL45zWr+tEFxZUzXnlnbaU+GD1h6wrjcZ6zvctRTQ3U0P2mNtR19A8l1nDTupQoTp6N9dUFVFZ+2HOmU9nPsXyUgCiKslOCHb544Kt4NTHBjs5NCxheyWtMV0DRpEsb90UataHbxrSinchyfxg1tOiL5sRonMgvITTlQ69uQvzu0J8k8JLBtsWeQs707TUdPXnfxAJiGR/GapB1r9RRa+bsX+F012wGo1jw7C0s4U9nLEape8TXuCicBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+95R0i2WWJfcfpWyEuMjB3sWKWRO4FvgEoPb2B9MyU=;
 b=KNmU7wZZh8xLDSiAbApAfaKXNDLQOc+yIO218a6NpWCFRmuJGueOa3dXEU+o+DKgzOT/3V082WwnlyAHomsQ1E5ws92v9q6Jd/cTgpBa9sVkm469UqpzazMaGiOPnp0Fh/6aebHofgI492lUmkH6u5s3OQ/IT/HwR+JQaAB18bOEmI0Gcnm/rt+ZKNA/Bqau80dhYitowCnsHsuLqv3FAaqXnUfborn6Qcs8MT5sDbB3HFphNH5R9aa90afVm6hKBbkTcv3uHUldkYoSgPE2A9IbccBA9Hl+Piyc7S8/laoCMaXFWEmSnpzK9e4spA4eB1OPtFuXDnQgknixB6MBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+95R0i2WWJfcfpWyEuMjB3sWKWRO4FvgEoPb2B9MyU=;
 b=eCCSP2gJFcDP+ZOnGid81Yv/9rdVXwBO2nAuLmyWzBA7x1HI5/PcSc4tR0jdQMHdHPXeWafaOe3JJ9MDLHAEfJVvPy0ynqReywi5sLsNJDNNZKjE6PmIQWNpdojD7jAVD/vMs+Lspk0YqZ4M7PYp6+035nZjLoVocfFcZ7H6Hm/LW8LsHuMvaEgFr6hon1FAMS1hjR2fdP519056v0wZ2KZRRwsEfFbsJdHYfMnIj4aJx/OiZIp2ziBbmby0wG129xNJxsevocGvwHL2lmaVfiUG96TTTtVsUEkMpurogNSxkHAknpqHdooBZpNbHoF4p1fTkIMEunzZKAw4TiEzkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DBBPR04MB7929.eurprd04.prod.outlook.com
 (2603:10a6:10:1ec::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 04:08:06 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:08:06 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 03/12] PCI: dwc: Allow external allocation of pci_host_bridge
Date: Fri, 13 Feb 2026 12:08:43 +0800
Message-Id: <20260213040852.3340547-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260213040852.3340547-1-sherry.sun@nxp.com>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DBBPR04MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: f600322b-908e-42f5-049b-08de6ab57deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mExc/OC6eyX5QIX8/ot7XTuUcuKsBafiOnWBvez5trp2YgTzmWCKUIVTNd/O?=
 =?us-ascii?Q?vsAtMvW2RpeJZftxiprbDNHLjXb9wAX4qxYBSuY16BiUbaJ6kdc4jxUJm/i4?=
 =?us-ascii?Q?GczysHM+XP+M/dPDXkqlOdebk3kuvSyeIUdBnj8legM/WJnjN/2fi9BV4167?=
 =?us-ascii?Q?AoQYIv/ZX1eNN3CCCaFjPynAs+TFV8dVpgQVy0qfXHxBpg4DJcgeECAnyR7u?=
 =?us-ascii?Q?K+G+dognIprK+7a01Ao6FMusgZkQATrXwx+4RvhNBzjMyzPt22sIRJ27qLgw?=
 =?us-ascii?Q?+w5DGOFGe8fXUmDSeAaqMTiN/cWWkmx8wf3FoTIdZ/6FjopUh4HqOb5/I/e4?=
 =?us-ascii?Q?f60VLz9DXNMz8YkQjWsX5JKXyM6ZO/u53C42kkcsk0rxiKeZPCzThhGMosHS?=
 =?us-ascii?Q?0uaxlbi6yEoULFMGnseGJz5r9Zu3E6deIoZkIc5lS3Gs0geQODVYidZl33lk?=
 =?us-ascii?Q?xq9oRwMNM1otPo7FCWf0c/oeLpAw13VIEjaK5HcU2BkSJ3zrpYvdoQz3G6JN?=
 =?us-ascii?Q?EITGr05sBc41pfw+vbY8tcwAF3+CyXvttl5tJW+EeSIpaQku4VsYNB0CN3MC?=
 =?us-ascii?Q?sQOvmIWws84iYWbFMckDTzvNwXpiLE02ZLvjjv0vMTVmzHBSR7oNzjwQn7cv?=
 =?us-ascii?Q?Gtg6gu/kVydculSyN5BvKyXT9uEnPLuA1y/NJeUlbllY4J7cLZM526763emo?=
 =?us-ascii?Q?oyjTCnU8sCoR5AXOjNIZcDjQa0mcqTPjZ0fdaLfDpe4q1/OFKKQXRVBkb54a?=
 =?us-ascii?Q?Ukvd6RhYL4IKV1rXommpp7f1j9ReMQlvqAeQe4DVs+/N6MNTpPdfXXQeTI0t?=
 =?us-ascii?Q?dzfkKNMG+iWuCdf9pzt8tkHWhG/Pe3b+uImXgV7X8/glah+kiF/2lw9UR/Sk?=
 =?us-ascii?Q?BgwjrOsuetvzLxGD98D29490b0/SQPstmnPeBVJW940l0aTpFhntYFqc+6pd?=
 =?us-ascii?Q?Dat6KmAVPtu4ykvJAJSY2KoDD7H3gVxQ6tak/M1bQgTD3N9CFHrbkRP6Mk4n?=
 =?us-ascii?Q?OgQlZMnDhvPMcRGCysCP9+qLKyJmI/hm8QeLHtAHgblsmo0/MGK7jYcOGifO?=
 =?us-ascii?Q?q6w6bywAnCLiGscU5FmR7GuvvW+ixKz9/LUw+pfr9XKFPX6UMUpBwg8BFiVd?=
 =?us-ascii?Q?M5LNfuNf3drkN0DUgrkRMCch4+xcbQ8ve4A66sOaNDHYsn6/DZnwBI2tljcZ?=
 =?us-ascii?Q?MkJYk66sP5ngzXdLSOamGjqU+nGJBEZy9hBKdsvv1sKIMMUpydZJOc0du90G?=
 =?us-ascii?Q?/J1cy3Hl6Z0+9B04eKfh8peYGvCNw4uog5+WUa/VsQUckl+30AViBosOzMiv?=
 =?us-ascii?Q?9tkIv5uZZQGzxASyjccYEoTk9I8uUo1XCWuSXZx9hUqK8DegRQl5t8xiua7f?=
 =?us-ascii?Q?9FDzNIQcAA9l2i7Isj6+6w1vdorgtyjEfhgTV7lV3wCqF0R/orchN9T1hTkf?=
 =?us-ascii?Q?bNKK+7H4V+wg8HbinkZ6o+s8rjdRmJtbriJClZrdoxKxa5s1LkZFLWdr/8I8?=
 =?us-ascii?Q?eG2LPVWw6X9vEB+AJTAwHMVH4ErttuWBARSuftEyEsqGHJ4v5eRvF5GPiC0G?=
 =?us-ascii?Q?2K4qAO22XVEf5m2dJ+kE1MVj/M5CYBUwfssm0+Gka3MufbW802gkt+BYND38?=
 =?us-ascii?Q?rd6KGp+3uU/SDeOSu4b2RNsZOlJgU/jC8lEF1yz18+cr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ge3nlijjMxYWhc2m7vnVRLMRmJmoeQyYlhVtL8od1/i0e3I6eogcphOZDK2e?=
 =?us-ascii?Q?+VwTxe/3xJ2s9167A4Rx+qU3UUHTlYWaOpfdJHU5JvoKCb47/V5SYSEdUTfq?=
 =?us-ascii?Q?GmpsO7ObIitxuE1GatHCNNNe7P982TJbLc1x+DUHfZos+u/54in6xFhdc4ws?=
 =?us-ascii?Q?2G9CdN2qRz0M7mPepvsqa7pYf1FH4fyy4obEjf0C5hR5ywPnfcySnuAXKdvN?=
 =?us-ascii?Q?Z+8fdcG6ZoKbto7gQlAttJab43sFeTzHdn1TiujiEtiCZ8Ak2Tjzf8EIvKGF?=
 =?us-ascii?Q?I5w+7mahoypBUzz1lb6W30cthGKwaB/AKDzMbHAhrfzGmllVM9yiBYo79f1l?=
 =?us-ascii?Q?1/KxBw6e7LeifcbsYTx39WCFX8/6CHxi/Cs7A8uotfWRp09XUgNb0Vu7e0x5?=
 =?us-ascii?Q?tRl3oh6QdHnBadcw8BjQf+6P6/dKU2U3y/w/Yzsz+n5oIYQ5Ax7NxUjVRqJG?=
 =?us-ascii?Q?6mawkM4iJHKalwjedciRl1K7Efs2YlLlPTW0SA3PfrAV+ABeWtGoaWg+KpRz?=
 =?us-ascii?Q?HKswur1k5XIDNeysWsQhiLNO4ATPJVy/DifUdJ7LNxRS7tI6RMIz/1MCuHvW?=
 =?us-ascii?Q?vGFsoYyT374WQPjsOeYza+F9UVsCLg8EFCoVK6dmRwz0ZPh/GppyVlliseUd?=
 =?us-ascii?Q?m+9zz2j7wM6LhLqZNnF5H4ron76u2iXJF+6axKA5SNZAB6NNWM7N2YH+OSP5?=
 =?us-ascii?Q?veWaW+tHfMW7as6E9B18d1hkBn51O20pUuho6BFZv2s0Jn+uYuAq7ea6bcon?=
 =?us-ascii?Q?Si3l1HCIh7hGC0mGUY19sfKp2iPvIq3hEYneMFIF8VKGo423a4VlshvFjWNc?=
 =?us-ascii?Q?Tp1l5suXGokjS79MPau8CboPqwELJ7im5qsbe0CTtr3dhYwjajwX67+Hrmzd?=
 =?us-ascii?Q?JupxFYMvywnIyp274wOyI8Km2chSG9/u1qUzUnXqKY3kGqWhRj6K7mTvlR6c?=
 =?us-ascii?Q?JO4juK1lThRybSE/ki6RlR8tQ8cieNbpr7oAZqo6TnnbkbeJc2t0vC8hSQxp?=
 =?us-ascii?Q?gsVES4AU7fNPlVvmcXiak83BHkrB3oisFA1QBFWyKnAONIrtKxdwDKODEskj?=
 =?us-ascii?Q?Ex8lcij524VYKmCIsERYdSdbaTdRJR/8y+DGUvbtqrDBELXJxu1QjNrjGhXR?=
 =?us-ascii?Q?I1tR6dbmVa/09zpRMZlGSLIV0DgTY6jePN3rTgmvqLFmM2eZME6VQn2A35tt?=
 =?us-ascii?Q?SExoK4yiyY/4AIXQQYD4eP7v09+qQEvT2Al/EVsS5XRGNt8vweSTNQe5/iMp?=
 =?us-ascii?Q?G130fuZi2aLCuyuYDxIuwQn+oA7S3QnBCR4EPTEPQipjnjmf5c9fb7wcRVsa?=
 =?us-ascii?Q?Az474LKwA4HKCMnrsVs8DNg1m6522/TW4GnZVdi1xFzweM99CGxTemg83+Zz?=
 =?us-ascii?Q?gE9jioBsVpGK+3Oq0QSH6zycEtbkLD4rD0g260vHiK6W3tylZnRIdy7Qbqoc?=
 =?us-ascii?Q?BtLwZEFJBiPWyPbPEfe2QVuGd3Va6Rm9Q5tkIlIbkeluavbJbGRxDCfOMaob?=
 =?us-ascii?Q?yslxRKHBwI4jgLggz7QO5wpL5PjTWOc3/SZ1OxlMjnBmSpz+CPK6DNoHXmmK?=
 =?us-ascii?Q?UmEMvZRRaJRcNzj0J5miba72BXjPFORvcBQY+oEhFl3bldf2UDOSYjO6pcCf?=
 =?us-ascii?Q?ZpQuEvmnhx6Ab21sx8FEZcbHqllUzPCpiCzw9GGyv7nVwtF4Ht8sbYffOEUw?=
 =?us-ascii?Q?5Wd6C3ZgGbti6Igw1485bvgtws3GJbNwvCL3CSRm+3sNNHJZktAnkgiukLDt?=
 =?us-ascii?Q?N/J8dtfJfg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f600322b-908e-42f5-049b-08de6ab57deb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:08:06.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJ1+xaZVK0DyVVhEUMU532dQziZoVk9lPxkD0EyVL4cEsu3ZtuTD6XnvfnCKGvEd4KBoyF5xYmKqJ1alWiBJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

Currently, dw_pcie_host_init() always allocates a new pci_host_bridge
structure internally using devm_pci_alloc_host_bridge(). This prevents
drivers from pre-allocating the bridge structure when needed.

Modify dw_pcie_host_init() to check if pp->bridge is already set. If
set, use the pre-allocated bridge instead of allocating a new one. This
maintains backward compatibility with existing drivers that don't set
pp->bridge, while allowing new drivers to pre-allocate when needed.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6ae6189e9b8a..c2de9830e1e9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -575,11 +575,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	raw_spin_lock_init(&pp->lock);
 
-	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return -ENOMEM;
+	if (!pp->bridge) {
+		bridge = devm_pci_alloc_host_bridge(dev, 0);
+		if (!bridge)
+			return -ENOMEM;
 
-	pp->bridge = bridge;
+		pp->bridge = bridge;
+	} else {
+		bridge = pp->bridge;
+	}
 
 	ret = dw_pcie_host_get_resources(pp);
 	if (ret)
-- 
2.37.1

