Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905213;
	b=OiRjAKYPMkSJcaAxDMn1Coisa140JJaq/0keWzdBlZeqM3j0z+rIfiCMBTDvBrmtwr9e
	 3YBozIXTfuBxMv8Uk1EpkU3SDwsOjmFOvEtb33vreUNQumP2R91tdYsfRuexK+1Q/X3xL
	 AK2cWuze10Q/FMoVOsh+kZx478tS4oWSO0SSrsupz6U+V+wiabHF8/TVpMkm29Jn0GIYr
	 v3h7gpIcNrq6YnaRcbC9SQDoTjFO1I1i++8gahobuI3iItbuqGH+heJ2vxJomUCGtwT2g
	 2fs8VVayfqUfDTuD7E8gGKcqKPl7/UzPk7FK41oEiymH9rOcZvT+d89eC5ltc3/ncjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905213;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5TuaZ9M01QYpKRMUH2pVNR2TkGC767TXNtwOeXOQ9xg=;
	b=FpoBGvZ1SZXbVoX9zus5J2SYhPJamjx3W30k6vRNPbzV+rtwtM4PSsSNZGB5tKeQiQjy
	 L2RabXljQ2BHxUTiGOSTCnEFBYjWY216jHFUFe+wEISMHCSb0EPltU3K5Uo2NZRTk44zh
	 utNUsdrn+VQ8g7or0ZBINoLJ1a1uiI//331iqq6JMSx8bgF4Fxe39h0GD8nWYYCHqTAYD
	 seYCMics1kpH85MTZoG51Qiu2EJU7vEpE6cQLUCcp228zC9n36wtqLhabv2Yb935NeLmK
	 U62QtSpdVKdTdpDMHdL8fd5fMF8+/7cokryZQkm4kzJDR0bUfknF88vyJcH70Zx0Lig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FtIBSfwB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE614606EE8A;
	Thu,  5 Nov 2026 19:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE614606EE8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FtIBSfwB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofwiSRVOtxutTuFIBakxtxxL4xuez6aIrC/GmJPoMG4ZluCXjFKH8rs4Los3vMJSPOmoHTMjLdYyMy1cgEwcSGVAGoH4k2dHjFzrT1o69zkpU8DhgFhfKVrKb/1FIux5IKvAdihApL96uJxA6Rsv8HYurT0JPIVpXlpBQgVM1PttA4qDYz6WBZEPYodgtIrUg4docC1Pd+5MiE38KbaqqDH4z0cUmrhJ2kaxdK4TCCmYzzRrCHmqNPt4ltkBB1IllHLZqqk8X1v0RaUFwP2656gNe2JeEDQYNV3/Mr/0sI0SX5rDy8dpwzKqJQWs0iJsVw/uaWxu/5Vo6jFI7HWZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TuaZ9M01QYpKRMUH2pVNR2TkGC767TXNtwOeXOQ9xg=;
 b=mjUMX7LWIhoynUaO2W8w80W1wIMlUFSUJkNREb7x/tFdTSDR6bflD0LAEpLRvv2zIMbgbBB+x5+roaQCrw1onEFgOQIFt6uuVyNrxCeuQ9kFqKsU5oj5JdIc74iovFJZRFJrs8F5ou4iLH97g3nueHUVhUiMcdgvcT9SxdfjHbxYAJg0Xh/AXyHQf5JqSK5YaC5Pf4KQKbtkDaXDnOYj5iqPAuBBVzJw6qeLyDEeArrkBjzP+NGjtgIXansc0JrV0/6Py4Gae4qvlY88FO3I71y/EO1nr46bvAZ05qZOJaKkQsj19RvilsQZjePtnVktSBVsLObjNzPibAN756x5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TuaZ9M01QYpKRMUH2pVNR2TkGC767TXNtwOeXOQ9xg=;
 b=FtIBSfwBV+ehPasJK4Cz3xdh24dSU7klNqf0kB72w5b8vAzl1CYlH7Yk7m7aiKRTS9ZqPeDXy/ZnRUKy/DPC3kQflEQKxoQpCXs6pMTk9Vd1XBuO2yFvUZ2Ch6S//7bvP012m2u1yp3c84Vg2LADHKFmqY8l5bqiyYPW/JPAjg1h+lnY+hwonUEkp8U6zuVbxlm4/PMeaVEoYBq6oOdHqo9eu8nIXuarOiKuFjMlMNksb+BJW2Gpx4RI5e4g67xgKN5qxFw2fXmTSWeWdsb7B33YrLD0+hd0QaXpWs5sUvVhcl2jW1w2Ht8/mCRSPFUQ35N8mRySMwmAssAoIiWBHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB733495.namprd12.prod.outlook.com
 (2603:10b6:408:423::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:57 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:57 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v17 14/19] PCI/CXL: Reject reset with unsafe function scope
Date: Thu,  5 Nov 2026 18:59:12 +0000
Message-ID: <20261105185917.2667656-15-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB733495:EE_
X-MS-Office365-Filtering-Correlation-Id: ec15c1a6-79da-4950-d566-08df3b6efc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|11063799006|56012099006|261021121427099003|261009223027099003|261022075727099003|261102123227099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wIGA+T9tC21ddzuZxYwwFk90CN3sBeimR5Bpa7p2PupsyGxiKZMB6CnIXtHQ/XAZYSW7pnYQQ8u42yj1H28LVkLgBXXsuQfRsv8IDNqbj6eVEAunT6dEuCoIin528+QGCfksUt0qY9TZZwNlMGAETR35xC6DEG66VUBP+4OTCImUWGl6N1LMA9gOeGvrrKptqogP5h69/k2faz4WNpqB7TBszkbiJLU9KGSSokAIx4dP5uHDwzdQ6NuRoEeiE0I7WNI+tzUhgai6CqwUpq/4mpYIYrPHoOTLNESSbDxdJ7K930BH0r04ZxJ5vx7FKRERFjtjdkSBlWPEeropwFzQorDjmWMJ6ci7xToCZN5gs3DCRLRiODCE/h3DVBeecYaw/rN77WE257PaUnD/roSzZ5fEEji/75S8t9JECkXWn5dJGUXd/uYtL3+iSG0k1hiB4X1mslo+pJSNVHQUSWzoVQOL6IckTSlOOcs7SJXLFZOA6cLtRRIy9Rh2hB0RqTuRhqpSuIK46qc0G96vsluxnhDRuE6YRfvLtOyEJhhSui7aFgsk/wkd05lsZ7yMrRG7wEbHG6+QcSnpD+yhz++gyyKvq6usZAbrAvTZdNkoOA3fa+5vdXl2rF4+OxOWwnlKdmTMIcBDoKyTr5A2cjQ6wFwYQAUz3OcoIGpE8vZwjXEbWvVYJ6dD3nfxYiCwe5nloBY2nq/YOCsG25atiDIXYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h8TCHFy3byXHO1cC42Rrk73a3h1TnbTUxwu6SyQue/qopr76hJ3RmdvA9MWI?=
 =?us-ascii?Q?OWTS9NjIGfEy3OfrfCCU8XvqrI7GXBUswI48osY8Dh+jLwCgUd+1eMs9+Iuq?=
 =?us-ascii?Q?LOOUL7wmaMYUBToL0s374bPkdz3AKqDPbz0t0xT+/FJPcnNspp7lnW737FWP?=
 =?us-ascii?Q?d/gNCGNAkTr3E9zJ9sPzBW2rHHSaJu+arD/KdYciV0eQ0SQbElnM6Wfr1PUT?=
 =?us-ascii?Q?IZOHJ5/Ozd0Ei90+xQ6Eh+uMHp/iAwAQMFShlzh0KlNpf5v1uKNDtawA55hI?=
 =?us-ascii?Q?403FWHfuR07V3gBvOl2Rx9wbgZ6Tx5ibl715vNTprYFgjBfU2/Cidf+Xb0hJ?=
 =?us-ascii?Q?YSEkTGZUt5AdrPWXU6VUErcc5zqiAHQpsFAyp+7c0BK/sL/4e8nLRH9x8VX+?=
 =?us-ascii?Q?xVRwKvfsqMB8yqBmfINPIvRscE9NF8YpyZsSnuqqjgvytCYF9bV0IXycK8Wg?=
 =?us-ascii?Q?UzG8WRUu5/UPjUs3xcqDuZhVwdAfn51PsaisdLPpL5cmt+bhLN2D53HcYegs?=
 =?us-ascii?Q?9G8GQ6Gl/LMKOr4jemswPnB5l30DdNANyrC0kXm11TfYHCt4DAGjnb/CKT/d?=
 =?us-ascii?Q?SxHZ++uxj6GFhsI9Iue7DJbpVoi6thBnuXI47qmmwM2BLBrTxpfRcRDizXJR?=
 =?us-ascii?Q?2u+rJxOAlyzBCCdse2cRI42pbcPOtOs8iG36wGZq0BAwHwI9U2MdNKo/f9gT?=
 =?us-ascii?Q?DY/9pxvaxnGKbzhPX0V6fG85D/s5sxHnnGApNCtm+wX4gJ5UvMki8jPAPxrS?=
 =?us-ascii?Q?9pMTCV/HkMf3xiZujdM3uMZgLphAQX0R3W95pPr0c15khXIBL4+51H8eOS6X?=
 =?us-ascii?Q?Ftv7i69/S57APecSx6xPe2OFAcMVr9mBBonohfLJ63gwomLjvBr0Gs5JGapD?=
 =?us-ascii?Q?s3dJHD+v+aZcukhUoXPnjT5ZknyYKcL4lOPS3rPlIH4Gnd85P1cDm27PAQ6I?=
 =?us-ascii?Q?VkN9dsT4UpPn0I7zns8K2iZdPWQl/I8WhYG4A4/I+j40CGeZ9VTmRAAjMjMU?=
 =?us-ascii?Q?9dEP3/OIE4d/qyGTV1m4E+Gfa85Ig8HXvFvIbqBtJzh6pxoadpbdgc3lxvWj?=
 =?us-ascii?Q?CZJGkQ1M0lBMgFt6g5iAb02+yX4jB7HB2eOUpSsO2Dvj9xHtYlZa/GsNadZ6?=
 =?us-ascii?Q?qL7orRQ7Ykq41KB8nwIEsxfg+/5DKes4aiHeFTkNPGwQo6y5a4ovrwdX7hp/?=
 =?us-ascii?Q?zfhP8AFDberg0QUqOcINJBEVwUfG9HTEnMzou0UfWX15iJrZwh12w2rU9hLu?=
 =?us-ascii?Q?mi1RnprrBVxW/ng4VLmw3i++9hO7wbb3PZohaFLnoACLGpcrdCGxMUTdmZUN?=
 =?us-ascii?Q?fO5o0g27SbsLY/ZpeSaPkzKKFU9aCWRKDeEdedjGUpLo6oO3vQuzEITGMg5P?=
 =?us-ascii?Q?A489td2+Ru/lcCRNoty4fk2uA6cRdwpInrNQKyOzg6r7O0lktThLG1Kfd9Pg?=
 =?us-ascii?Q?Ew1wkgj1XRZnx4Lf//85lBewzPB8aW399vwhZhWxfAEE84h4ntrcJA/XYULx?=
 =?us-ascii?Q?4JJBWIw2DCuzFLtHZIQL+rTElkE8Fbbie2WLEGkHj1G0NSSzEko6EDqi6X00?=
 =?us-ascii?Q?fY9M0OQQ+so4n0JxHUXInO66WK1WcTHDl/5nUl7hlM76mVkriMxmx6goQgIk?=
 =?us-ascii?Q?x4QEF8nMYdKiA2zHn2E7ef19rErj2afDb/NT65nVCbL6gd6uW0rUdsL590dx?=
 =?us-ascii?Q?SRmGDiURY4PS9xt81Gcwr1EeTNC4CZ+rPgD8VTTr37vsX+Vkn70oSAUjZw+9?=
 =?us-ascii?Q?3lY91uDXGw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec15c1a6-79da-4950-d566-08df3b6efc52
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:57.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBmO21Czld0tI1HdVnZhh497oCjcRGov7Zj65GRaNXoeZUWmysNEZStbAO4pXlWElDYRkYxdMTgNkggbO/iYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495

The per-device PCI reset interface must not reset sibling functions.
Reject cxl_reset and cxl_bus for VFs, multifunction devices, and PFs with
enabled VFs.

Suggested-by: Alex Williamson <alwilliamson@nvidia.com>
Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>

---
Changes in v17:
- Move the function-scope checks ahead of the CXL DVSEC lookups, so a VF
  returns -ENOTTY without config reads during reset-method probing
  (Joshua)
  https://lore.kernel.org/linux-cxl/20261105143611.31563-1-machaujo@amazon.de/
---
 drivers/pci/cxl.c | 3 +++
 drivers/pci/pci.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index af8ec8db20f1..c07266ab0133 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -501,6 +501,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	u16 dvsec, cap, ctrl;
 	int rc;
 
+	if (pdev->is_virtfn || pdev->multifunction || pci_num_vf(pdev))
+		return -ENOTTY;
+
 	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
 	if (rc)
 		return rc;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..aef976d0c850 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5018,6 +5018,13 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	u16 dvsec, reg, val;
 	int rc;
 
+	/*
+	 * Reject VFs and multifunction devices before walking the bridge's
+	 * capabilities: every VF behind the same bridge would repeat the walk.
+	 */
+	if (dev->is_virtfn || dev->multifunction || pci_num_vf(dev))
+		return -ENOTTY;
+
 	bridge = pci_upstream_bridge(dev);
 	if (!bridge)
 		return -ENOTTY;
-- 
2.43.0

