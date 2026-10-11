Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1CF2F8E95;
	Sun, 11 Oct 2026 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684914; cv=fail; b=l8wzpiXdQBqxd/mjCZxbO0MtIQYT9smJbLlajb7vw/aHELsHIreganboO3DQS5ocdt4X9VCWdM+7xTKOfpPkDpZVF4gV8AVH9VqnJENdYuwMHiQoQr7SryDl0StXnWeG0wtMpBasXYUCR+tAdqa63W7OHg4jKkexVddcf06kzKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684914; c=relaxed/simple;
	bh=N230U1BeWpJo0QIvF10Gcmk9cEuOyJEDMBZrk+J67VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Axzb2QF4kW5xS4LsRrWS/OnAAeCsPlgfAiRZqIDrPUFe+/hjHWJuFao6tAphW2RC/cmeyrXUC7j34AW6Ym7sIrZm4qsmYNxwa+jrif8gvulA7D9JRAFSkTssvlI4A2XTsyCf3af5tywe7ox1aRCRkldG/NBI9ONvjTYj6/sw7fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ms+Go4xM; arc=fail smtp.client-ip=52.101.52.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ms+Go4xM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAomktNrvVrGXF1f+MhX5MeBc8/0237dJ2lBwuYoPvjRTqH/VlP7cdOwlOc79/fBYxzjsAOoaEFV9AafjLqfI+PgHJ/FURZiG7H3dVZ3O11/AodROe7mYi7wz6rycvDfClyOlM1mzLazUp+O0ObYQRTd9PUvUY0YlpR8kEwBHQvw+1IjtpvIlX+y+9oFn4hJO9wIl0sFZc3nonNMWv0b/WvB9ihtjUe/6j/FvyTjp1mFnNACbEZkoXhsFAcH0WiWdtKRFTX0V6FQcA0pMOmv8ux+p7Rx+X374iS/S1+Khc1vNHPsbv2KnYV2Aqwhj/sDb03IMqXb4aLDOA3fHUVAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7PyyjXbvFg01REBd3xvOXJy/r73KiVuznwSSQrMJbE=;
 b=AENzOGEY75l1Iqp5DRM6ETAT342AXDLQKAz4B4SdcvC0zddFTXPcsOjloXpOeNoCco3gtXNB4aANfz0LESC3mfNBK/UmG1pM2E965lAVvX1+JzYZ6y0wNLJALuwVgdpc50DHansBR/9Ue88hQadiMfjTZKoPJcNhgZt58e7HQuQ3V7smdYA65owyaM7RJFQjt4nejPBLPki1fwPs8xaakRWNM7IOg/wgExbFb2z1n68i4ILIKT/Sb6aC4aMrQKan9ffBUhqPCV6sVcg+dIYK59ao+9MBHSZztfTNXOew5gYKM/Kt7j+jbkfu0w7JX1mG0hISPpSJ0pPbLbwE77Z7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7PyyjXbvFg01REBd3xvOXJy/r73KiVuznwSSQrMJbE=;
 b=ms+Go4xMZ0J69OvtQdWcgr59Uu8v9C7Fyl5oeFn921kjgJsx/rlRaEcYUnQno0mfB2v52vE540eGH1rVdAuwGO4AieKwUMm1LzcxheYCW6riuvkXGEE8UKiRyaMPDptzpPlRBQFa/LltCzOIQuuRqbOCrbDrh5LCb2HvcgZjJKINgrwJc6Q+DpqgPgstQGkkxRs+r95jWoRZlG/abWm4ZQ20jfXpvKfv4IoNrpkvCbwRKPv1aYW5LZpAoxkMRxsBp7rZ1a4wekEUxkNI8ZZVaLXx/jwjdKD79ox8x8qLpze+Qw1YOevZi9dPWm9enUdZgsMozURoVBkhYYBLfrlohg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:15:00 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:15:00 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v15 12/16] PCI/CXL: Reject reset with unsafe function scope
Date: Sun, 11 Oct 2026 02:14:18 +0000
Message-ID: <20261011021422.3428136-13-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::24) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f37e5b-2a3b-4092-0ace-08df273d73eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	193Wt7Ln5KIYofQ14qxMTrjHROREDUM9tzZYaqD7fBwrKj8IpXtMbx5CWSfAzP86OeZ0YMVZXKHBzEQWRSE/ZeP2HrrbX8nsI8yGvCiKv+vdgyHzRqNTyQkeoqprSnXDL5LPmdcMt9ClJ9+Zv9B3cQfA/P/g5rW1zYMdi3hTe/p0F/+rBUQ4KxjrHeNG7aPhFdeMV9s8p/7q32E7Y0CmjA1/kk6zj1IU8rDLW645CFUXkxGgR1Ap7jzRpokwLO48B00f1rW0dXSuoZzdKOxr3iBL5mZWyTs0AtfLMcwvi4oSapaW+eWnKY/i36AZd6Vq7H4ULfOMVcuy6+k6SoVSuSm18VZqdeBs9sYEaot78PR3zAH0k3AUaeLT8E9DMqlWEcz2Z3/Fpqt2nypcXj6qFC9p0TXwBE+mWRnh/JpQTsHw8ZQcTabZoNxwqEfR7AebRQWSKnS3cB0YJGIZrMVTXD974mUTPBlnF83jzCms+K3k0EX0RZWGs7cUPXQsow6Y/xZ51k36b5y9G4IeCP0dNX28YBBRQQ3Lmn1f7HgFCRf0sp+yT+9t1XDnYmOFrIX1vkXMIn6f9tgNgyeeCjh2tGbBlBCGrL6WUJJWG7drAkdYEne2UyGty/+13TO02VSbBgGWJnNUGEqhDciS87uiRgqLaz3QJdLpn27MNgRsg41Q28DCG+3xKMwIZ6e3v1ElZJtMedS7K4gN/weu94yNEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ZTvENz1UPK1PGbCkGf5eWULbjo64DPdhB8r/qIuaQtl6yCHrySf8/DWB09A?=
 =?us-ascii?Q?lJ5YWiL5wu/j85dObLLHlfxEUgqqOyo4d9yneOhKwGYhR8xhqgTE476B4yYy?=
 =?us-ascii?Q?rxWaz8/6CNf4wXSMu7u/VqqfyfI6O8teNgxyIqV+QkMCVuqis+5UChlxzk+c?=
 =?us-ascii?Q?fW2uUrXa9KNKlhRrXQrdiWEYtT1KP4w1cYwzuzWm6hphwlieSjqiglN5Jnfn?=
 =?us-ascii?Q?6ObS/U0V0F848ztCJdMubfV0wN7TcpH9OHeEA9eGJ9sI/OFa073vhR4TOeN9?=
 =?us-ascii?Q?1HR83jfeGQMRVY5xxCOwpXDeDMDkfNP1VPIz54EEPTzSbsTRMbBKfKPg3u61?=
 =?us-ascii?Q?r46LOSzerp6ltUXyQsQqJDjUoyn+Z1eQUL3MDbgw/yiKAPm6PelVP2/9nY+j?=
 =?us-ascii?Q?dDgldWuyzqzSKWW7TGRZLXeafy+xjKe6rKm+PLbuZws9MgRfDRlskoo72u7I?=
 =?us-ascii?Q?idAYQ4ePOdh99qVrTVwinUOu6badzT/2w0y19SqmM28oB3vukqs3FetlgXpr?=
 =?us-ascii?Q?QrYCvvEFhBOGBkB9r852I1vByJt6kjdkPcjQNnrzEOBHoUu3/Pd2hbxygdOq?=
 =?us-ascii?Q?0SVG/hQM+9DNvyytB8xKj8EGYZ0iPMVsFcaUW1ECMKanRCdTaWOdM8MFTbtF?=
 =?us-ascii?Q?j/qBFZjOg/WN5FNSgGQxPtK7XUW+55L8Yw8FwGS2wAvpzQsqzjSLY4vaIi1D?=
 =?us-ascii?Q?tSk9cggBGR+24h1y/D5r3umN3buFkKoV3frlJYXaZOWkdSGL7Cekg37gl0rc?=
 =?us-ascii?Q?5mWKKqFiN+negBeu8yHJ47TrISa4p1OvFQFqxhngaNiHRw7/TkTxmPU9lpo/?=
 =?us-ascii?Q?8QbJvLtkpYUUgfHz1cLC47NRqBcoDr/lkfN/50a455inU44Wov6kgTDvaN5A?=
 =?us-ascii?Q?8i3EGeH3sOUlGd1iaq6PAUEWLCA313k323Ao2/k3YwAq6o2nQRIUzQIXsp2/?=
 =?us-ascii?Q?IIY69SoSSJe6yFIDVo6DaiY9w0Jm4E5gXpnfHXFl+6u8Yu6sl3yQ65haBG6m?=
 =?us-ascii?Q?B8NcPjKyiRuFtlT8PoJqYIGPwNP3QTXxgsxq6yyifWzmOzzuV5XVYYsr2wYj?=
 =?us-ascii?Q?zARterV1S1XgZ/t9NpXFDCkuGQDh674kzAyWIl/Auj4fRgVfE/HMouV1sHSf?=
 =?us-ascii?Q?fBKDf8K6pAPGKW6n0/cFggvcD4jRg2cgItAOI8rL1y15SXk0SDGYoz6bFwYH?=
 =?us-ascii?Q?/zbwfXKbzqO88TFQUgPpsv4wprIt3X915STAHvqVa4o6Q0pBVWghy+/McKiD?=
 =?us-ascii?Q?EJsS/fXIhsrmIYos2l7ivHnE+3sghVAXkLHzIDsIItsa5sDDxc1toIxEb6am?=
 =?us-ascii?Q?UiO4YXT5+mxyTVL+KRhRaquTBpgnZRDnnotBIvHwe0wMDKVabUIeQXmSZVc+?=
 =?us-ascii?Q?E2qK3xNl6rAzLKhzJuuJYpuopGVeCQWk/5vAv0bTHgs1eQC9qPgBcM1boc3p?=
 =?us-ascii?Q?L2wZMVbUpMmFHHmL525d+ZY3vLpv+RYYslVbYKpNaPV2KrK2/clAfv0w/My9?=
 =?us-ascii?Q?+qYvgrnRIQVxNKhAG4GC9FwYE4r1TI1/nAZkqnpyd0gIaxdQNqgmYYwnjj0/?=
 =?us-ascii?Q?kyOCSC6l5D4EM+fCG7GJIE7XUFqGOrikHo3THjwhP0xmDIBaZDgEawlGCAS+?=
 =?us-ascii?Q?F+WGlJ8bZaZwZt8qA3h99ggQxc9hvmoAZELHLkvlTYQoZ3LkMQK2ZeH8AFJ6?=
 =?us-ascii?Q?na628F34UxMyGaGXRdiyed6B8ONbREX6YhKF8b++ZbIOYK/xcQq3txogYc8K?=
 =?us-ascii?Q?9CQ+VbrchA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f37e5b-2a3b-4092-0ace-08df273d73eb
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:15:00.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmthPmuWNQKJluvONoHT0k1BmUq5lqUQ3ttrAwxUOkC4+Dvz0yjXBITLJ7fR8yS9i+p/Tt5TP0r7WCcSY7Js5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

The per-device PCI reset interface must not reset sibling functions.
Reject cxl_reset and cxl_bus for multifunction devices and PFs with
enabled VFs.

Suggested-by: Alex Williamson <alwilliamson@nvidia.com>
Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/cxl.c | 3 +++
 drivers/pci/pci.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 3da8b316857f..eccdb57945fe 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -496,6 +496,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
 		return -ENOTTY;
 
+	if (pdev->multifunction || pci_num_vf(pdev))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..fe611340f5ab 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (!dvsec)
 		return -ENOTTY;
 
+	if (dev->multifunction || pci_num_vf(dev))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

