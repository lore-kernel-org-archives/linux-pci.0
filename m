Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021087.outbound.protection.outlook.com [40.107.74.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7393382C7;
	Thu, 19 Feb 2026 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488814; cv=fail; b=oz10gYlm1AbZqGih59v2SwCJ9tctN8BkBdUmvUuB21KPhXuv/SmvpLV5R1ZaPxGBmDNzE3zvDFr4cjdGPYhSsSgHNqnwuDVnaxI7UVT9NNMj1Z8+ZwSjj7lA3eV3WvnTAjhQxlfUkL9tI06uE5930799nJKYENrtDcaLpgZBSog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488814; c=relaxed/simple;
	bh=muglXp/rzpaKKYphs9Ms6c2Zq5omujuDgaUbbp3J0kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aFiNpVrBAkq8wh+wU6uxdgTLGNTJEJTsbjJf2VZuU1cn7oukoNhvSoA7Pcy82miIwXgIyw8oXALTY50a0hH2HW/bU5VCotCs2/XySnGd/rQniGuLcqwkLPY4ZTBdk73HQeP/m8rad28hKczx6gA52l5lW8g0S5GU9h0ufqy+dG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wBGHJ95l; arc=fail smtp.client-ip=40.107.74.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wBGHJ95l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5FRrny09oXy0Tssr1RAIGYN7R7dPOrbIjRfvtVGcr6j9TGCXloHcdbhbIb7uUBC14dunqps52GV4hKs9+P1Xs9eDTficzZqSt5zKcobXQws4mcdPV8SVukOX/z/iqSCtR9OpYCQeGjIdHzosHynlyl56yKxZeVdcJuQn7vNB2TbVNtMgFvp6wEgY9mtW43vFVW+yOeKKyFBG6irjEnXfqn8mU3ZBbbtwN5pgTHQ9GtZypj68/Hee2zj2yGabptMO+trr4jL+Rx4u3F0hPbB5BH4g7n3sa+J6u5/e1TQE3NHZEdLKDaf3V+gjPx787zZ3v6dytdocl6vcCVdb04Z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0/f4VlESTxqp1Y0jsHfkarYpwQbEzBAcMWXKavG7nw=;
 b=cLMMnXNancmtEp5VwlFG12qLAeXY0xMxWp42qJ5G+pU5IbLX+H121GLW24HuJ7oxwnm4KOvUwrKM7Fj6n09Pbjt9blz69oRhq98TzWz6q6ulS+HdwxGdO8lJFmzxVlXEG44cYltz3jF21BNmW+FQlWdDX6lM66f5n87qZNRQ4BaxICQhsEnuhrtQPNZbp7xDsDMae3Fx5iXM0tHoL1gIPnVGAI6y/wLauun0KWbLd14JFMWyXRmv2ctOOwV1qYzCSP2Jd3ISGTspn50LJ8FFhhRVhNZzQXLLOAbaJZUH8u+9+RQLqZtJUOO6Lc2ZrxZtrYh9aM324orTeonRDpvkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0/f4VlESTxqp1Y0jsHfkarYpwQbEzBAcMWXKavG7nw=;
 b=wBGHJ95lLaK14oSAVZVLF17/RZXyuU+bpGZ7fYV5aJ2lZjpM7qeeRZ98q+YYmJzeevGN4GAHexLvSgIEgy0xbYkvmvZx5vZrrynsJphvxqQUMz/6rBmdv0m6t4Cz0H9lOoOlkUka0kpHSYibM7nhbKD3zPVMXLZfAGFSMbzcsxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5862.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:13:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:13:26 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 6/7] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
Date: Thu, 19 Feb 2026 17:13:17 +0900
Message-ID: <20260219081318.4156901-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219081318.4156901-1-den@valinux.co.jp>
References: <20260219081318.4156901-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 78abe31a-9f72-42d9-3215-08de6f8ec208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lvuj/Vnok/8pBiNTT7JNKNNOA/HBd610mmQLYjnjLAC52wnbr8FlmUECfE3m?=
 =?us-ascii?Q?4aJkzF8iCW7nrz/lZQczRtwPIETWIPx/UzPcKBlPop1F5AVbIOvlywQbPZWN?=
 =?us-ascii?Q?Ttvref4ygeTc+KnpnmYh0/iumWBqKdtZ1WGnebaDnFb1QXIZTQyn6aSlHofH?=
 =?us-ascii?Q?BQwf7e+1uXlVGRNwoPzErERPHEUr2c8h8AV+THHEMuFpcvwBVh+hocvRwsrq?=
 =?us-ascii?Q?j9KnN1QuA4kK4Dmb6UM7vB1AEu/QBbTO2uzOIxbd+iAUC4qPwOUjH1G4ZNC4?=
 =?us-ascii?Q?08GEv9yckDZxaK7I4SD2h8tTlTtPaiobkRmvKgzxH3+YDkQUUZPa7KFIWh7w?=
 =?us-ascii?Q?qj9wHRAoa/kEGgQVDnsx6DCVd+087f0PYBJvstraTxmKxzN3eZDYezZwN71h?=
 =?us-ascii?Q?HAwN+pkD6O3dJlaT2gk17zqEUFBsibAnPi5d2IZjSz47tvDiZDfDLVNnKAUs?=
 =?us-ascii?Q?ReBNh8g7aqF3CovsBBC5IpGbidnpd6Pi42HVzb69+4Jhgw1Toj71PDgBOtqd?=
 =?us-ascii?Q?4OTWWJLk3uvw7+mBPRvso/foZR9j9+aGX3VzwhCmGLe4HBcLKalej1W0b2GW?=
 =?us-ascii?Q?TfIxVJM9Mm2tbcqug9xrZrOkk63BVsJ/3nmSDtKKhEpEZKTogmjOgGOjtLhM?=
 =?us-ascii?Q?1HIVvH5jsAeN74LHZov+fejZZbyK/fJsi9b01BIY6WPepamSVDppSz62LVRV?=
 =?us-ascii?Q?tSpY2+nUkGt63m/LGrQ4Zm9++JDIBDnnARrNi4oiIRNMnYSkNn1w7W/3CukV?=
 =?us-ascii?Q?+xaHhxSeg3qDqZvy6GqG4wO8cP2hRTtPkE/QCSVeVmtpk44hd+dumBfXkNzt?=
 =?us-ascii?Q?AE4sd4VHTvfJs90qAVGwSpVIfovoGCDKRV9oJc4UUQ2WSbGBwXYCwGcYy2Sm?=
 =?us-ascii?Q?pI4XVQu1B5quqUDd/lhSk6jSZOlmwWsJZVjX/ONO72sqG71jG3icMuEM0T5l?=
 =?us-ascii?Q?AIQPiyOEBmBv0zVM5Vuoj7p4fubn9p6pm/6LKQ3ZDeFoqia7hR8jxaa2L+6F?=
 =?us-ascii?Q?UZiCxCwzsYYkRawvRklasoh+/BKuNyKAXc1r38s9WoDxbtjrpodwGa07xMBC?=
 =?us-ascii?Q?eZbqV04ETXm8D1Ht0/dWNshAz3WZAni9BZ98PaXpzs1yNRGTJdPbFuF4p85n?=
 =?us-ascii?Q?Xz2vpVrYuVLOunDEMUAnOvQOJirx4N3XYJizoxQyWBo4wQVljxjgbDDkykkL?=
 =?us-ascii?Q?36D/mOONG4pfgW0lvdGhTbrt7V/174mlzrF1GzcGq7KKrceoCm2/GHe6CfJH?=
 =?us-ascii?Q?wm/Bf6hxt+Y3VGWuC9yb7ry2HuIFDteyhFuLii9vlRVBqTBt37LNl2kE1UNV?=
 =?us-ascii?Q?IJpjoI3hL5gJD0lE8bIg8dBCYbnvti+Q6FE1qLmPR5U72okrprfHP3J6MtKO?=
 =?us-ascii?Q?CEohUOK36iN9KQ3FTSZinBXYraaOwQI75uYYCycqdALAsUKDzU+quxmm+XMV?=
 =?us-ascii?Q?6ECavi3ujATYNcMv3nsieizLu2F8u20xEXRoOgqUMzegVPxdCHUZxbzEtuES?=
 =?us-ascii?Q?sdn9gzPNRGvYZFCv9sgrrptezSd2Hv45PkrpA0dzj2iJXEL2H3BJfQuzV3mL?=
 =?us-ascii?Q?H+xlOS0BMfQJcnBMylfsVtgUh58dxuCNxjSfkmSB+V4KeasLu7Z7Z6y8Wh2p?=
 =?us-ascii?Q?CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qiiqqlNTgVoT5Y33ds29NOL0oqiRvF+zKB1PDb2EQj+se6Wi2Z2KXsOkQpeV?=
 =?us-ascii?Q?nckA10zxLWcyLb9ttDZvmjqVEsHGtJXyjfnT1KBViDuabYNfdNMSNWd/AoM9?=
 =?us-ascii?Q?t62SejCwkjejzs2IaKCvtN7Rbkru7FL29L0hV15duyZC3lkkDs9NIWNhFQ1M?=
 =?us-ascii?Q?LVCjsd7YwHvzHF3sWFJwQgqc7ebtFfG6Ql7AcpzY3456cq1KDZIxbvtLuYCV?=
 =?us-ascii?Q?1O3EEXXEJUeQp5Hlln9lah6mpaFrf/0YCDzeIX8qCab+yfFp7RjxZTJDn27V?=
 =?us-ascii?Q?zbKceD+G3/axHCxSG8CGl5xbBXRFuik0QDh46v6tyibwghJUT25jma1DKjAi?=
 =?us-ascii?Q?0icn27plRzqrOqsZ5TrVoDcRVn2xpv8YNyEXfnAVPo21C9joPiYP3vjYfaC/?=
 =?us-ascii?Q?29cIenstEzGhRHn7zHp1n+wWh1uq+pf8o6ZfkjXLwDSmUHwrpLpnX8sVnVWk?=
 =?us-ascii?Q?kp9PgMrUm3+6eio3yXC6tGx4Jib9omQa8G/E7L2CYAdlX57Aytl6WwhmevTu?=
 =?us-ascii?Q?QR1utNp9qrxo8jd1mNl3UtbtTaCPV2iYo6PQoVsokq338TXFlsqwzzf6U7Yh?=
 =?us-ascii?Q?lRqfauxH1tvkeO6fhZftjeBeYVKXFN3a88Mm2oJ2Ps+XPqQ05YZGR1gDws8U?=
 =?us-ascii?Q?rYgutVNRTghIkPg1QXOVopUHIaz/kCm8CODF4VsWyBaXsjQXxJIjUB5O5Cl7?=
 =?us-ascii?Q?dyjI5OG+mKnqBO/urK6IF2+GnycBUGpZvKi0eZXf+FAgmDBTCvMu/+V9SyKq?=
 =?us-ascii?Q?CyaeedAK6IMCrv8weIOoJOGrWE9pTIGpJketHt+7vkCMkT4wu1Keskt0qNEb?=
 =?us-ascii?Q?FaDgYdbxCLFHhtzLcGcfD9r17NZmGLCxYabHPYgDz9HFrv6G+MjYIqDmjyod?=
 =?us-ascii?Q?n3ncgHrLr/wowm9u2c2QHwwruMGriVTHEu52ABsR7mirkC4d2MjsjUAlfsqY?=
 =?us-ascii?Q?baLSgFheSlD/kDU/I7eY1/uTlXsn0AQOSZ6vpJ9gOOtq4AQEfc9Uoyg3Jhec?=
 =?us-ascii?Q?YcKOOKLiaoTAIZyMsj2ymANPXGpReMqJV4aHp/WuvLjwx5YW1L4UED/C7yV6?=
 =?us-ascii?Q?BOTqgS1FhlEJPvvhImz5nQioUYJGamBLPVu1H+Grtq0qyMFtvPHXLkDGgb7D?=
 =?us-ascii?Q?z5Wun1rutpJR+8zAn0+OzSAjA2aTGJsJcdK5yf3CeHf8ttS9LNyc+jqEen+u?=
 =?us-ascii?Q?eCt9PpcIYlyuGIrRCGddiNcAJakFJkHvow5NwKnEnN/JI5qL3iOs4kUDmJE1?=
 =?us-ascii?Q?DWaUcE6ShklG8tLM2pdulA8MllUpxvzUw/+PzXEOSro7SLutXDkpMEx3mER8?=
 =?us-ascii?Q?77WDuobwUEHMLG59gCTje/l56RFERDNrNm4QY51Ozwrr9bvDCc8TBmDKoZib?=
 =?us-ascii?Q?0F0q84KVW6ITw5ZdkB+24ttm9GHM2Lck9GnyhvMdgruaYcsDwX6T4LF4NK8v?=
 =?us-ascii?Q?hHcnTUjJ6NembHJotwL6k5Tz5uOyUp099+eHAeeHTndHI+GyJSD75mBUkHjW?=
 =?us-ascii?Q?f59fE07xM4zdeIUV8c0IBfgh/WK2WdD8hzRARVSBDb/wUNKu4jGBZcPgaAq2?=
 =?us-ascii?Q?aPSLPSa1e+EidtRWbFBJ2J4znnlUqN2bKrW4bVnV5zmwxtc6B6AIkmZL/JuH?=
 =?us-ascii?Q?wiv3fscx6ftybwnf4Tvt5VtLGLZXES0UJfhcm4IrPvC5kH+rxF4c8INwFGHj?=
 =?us-ascii?Q?bVWyvH8ptpEmUScD3hTD6ugmvrZoYFkZOuLg8ealjIXmFwn84GxVzwJuxeMf?=
 =?us-ascii?Q?9PRmD/EBb5ZzcF8b6lAkHt6iRcF46V4JbR/tzKjELY20zAXDJlGq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 78abe31a-9f72-42d9-3215-08de6f8ec208
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:13:26.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQW4PFKOsUwz7LZ98l0R0jip6iVVwi4EcV9b3FmorfwBfzPw9n4wiH8lQTYG6Nbrh0Yvjqlh6z+O0l8ttkc8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5862

pci-epf-test advertises the doorbell target to the RC as a BAR number
and an offset, and the RC rings the doorbell with a single DWORD MMIO
write.

Some doorbell backends may report that the doorbell target is already
exposed via a platform-owned fixed BAR (db_msg[0].bar/offset). In that
case, reuse the pre-exposed window and do not reprogram the BAR with
pci_epc_set_bar().

Also honor db_msg[0].irq_flags when requesting the doorbell IRQ, and
only restore the original BAR mapping on disable if pci-epf-test
programmed it.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v8:
  - Drop the extra size_add() doorbell-offset check, which is generally
    unneeded when pci_epf_align_inbound_addr() runs. This fixes
    BAR_RESERVED cases where epf->bar[bar].size can be 0.

 drivers/pci/endpoint/functions/pci-epf-test.c | 84 +++++++++++++------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 684f018ea242..4fc53edbceed 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -92,6 +92,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	bool			db_bar_programmed;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -731,7 +732,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 {
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_doorbell_msg *db;
 	struct pci_epc *epc = epf->epc;
+	unsigned long irq_flags;
 	struct msi_msg *msg;
 	enum pci_barno bar;
 	size_t offset;
@@ -741,13 +744,28 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (ret)
 		goto set_status_err;
 
-	msg = &epf->db_msg[0].msg;
-	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
-	if (bar < BAR_0)
-		goto err_doorbell_cleanup;
+	db = &epf->db_msg[0];
+	msg = &db->msg;
+	epf_test->db_bar_programmed = false;
+
+	if (db->bar != NO_BAR) {
+		/*
+		 * The doorbell target is already exposed via a platform-owned
+		 * fixed BAR
+		 */
+		bar = db->bar;
+		offset = db->offset;
+	} else {
+		bar = pci_epc_get_next_free_bar(epf_test->epc_features,
+						epf_test->test_reg_bar + 1);
+		if (bar < BAR_0)
+			goto err_doorbell_cleanup;
+	}
+
+	irq_flags = epf->db_msg[0].irq_flags | IRQF_ONESHOT;
 
 	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
-				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
+				   pci_epf_test_doorbell_handler, irq_flags,
 				   "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
@@ -759,22 +777,30 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
 
-	msg = &epf->db_msg[0].msg;
-	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
-					 &epf_test->db_bar.phys_addr, &offset);
+	if (db->bar == NO_BAR) {
+		ret = pci_epf_align_inbound_addr(epf, bar,
+						 ((u64)msg->address_hi << 32) |
+						 msg->address_lo,
+						 &epf_test->db_bar.phys_addr,
+						 &offset);
 
-	if (ret)
-		goto err_free_irq;
+		if (ret)
+			goto err_free_irq;
+	}
 
 	reg->doorbell_offset = cpu_to_le32(offset);
 
-	epf_test->db_bar.barno = bar;
-	epf_test->db_bar.size = epf->bar[bar].size;
-	epf_test->db_bar.flags = epf->bar[bar].flags;
+	if (db->bar == NO_BAR) {
+		epf_test->db_bar.barno = bar;
+		epf_test->db_bar.size = epf->bar[bar].size;
+		epf_test->db_bar.flags = epf->bar[bar].flags;
 
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
-	if (ret)
-		goto err_free_irq;
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+		if (ret)
+			goto err_free_irq;
+
+		epf_test->db_bar_programmed = true;
+	}
 
 	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
@@ -804,17 +830,21 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 	free_irq(epf->db_msg[0].virq, epf_test);
 	pci_epf_test_doorbell_cleanup(epf_test);
 
-	/*
-	 * The doorbell feature temporarily overrides the inbound translation
-	 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
-	 * it calls set_bar() twice without ever calling clear_bar(), as
-	 * calling clear_bar() would clear the BAR's PCI address assigned by
-	 * the host. Thus, when disabling the doorbell, restore the inbound
-	 * translation to point to the memory allocated for the BAR.
-	 */
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
-	if (ret)
-		goto set_status_err;
+	if (epf_test->db_bar_programmed) {
+		/*
+		 * The doorbell feature temporarily overrides the inbound translation
+		 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
+		 * it calls set_bar() twice without ever calling clear_bar(), as
+		 * calling clear_bar() would clear the BAR's PCI address assigned by
+		 * the host. Thus, when disabling the doorbell, restore the inbound
+		 * translation to point to the memory allocated for the BAR.
+		 */
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+		if (ret)
+			goto set_status_err;
+
+		epf_test->db_bar_programmed = false;
+	}
 
 	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
-- 
2.51.0

