Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021133.outbound.protection.outlook.com [40.107.74.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA339B94A;
	Mon, 16 Mar 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669771; cv=fail; b=UOclHKitMoeZsbKk3BQZrKkJItLPt4RXm8LG9eC6yMxqqA5B4FkgB/PKDXWQqeK4UK0nCcW3Fgn6ZeLnW0jY/9VFueqlueybf9lhKmN08KzIToVl+7M+G82j+mXWwkp1LMH9aJ1IUwtqBmCFV8EbJcmXRKZ5zRl4YF6dCkjj1Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669771; c=relaxed/simple;
	bh=VGrc37XkAEjwDxPCQl7nL85b7d7r1x2axkdKR865eVI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Uw03Svw9NLp8B7dn9Y8UbYBc6/mb8LvegsS0dDlJdhqRo67VaGQQMNufLeTZG50tIG3kRCXXzUyhTDWNX4BhurmfqGTIb4q5y3POu8CQzKcyFUaUo/hHcSum2/4ee+rUZKIFJ17inrA54YEfYRP08WFJ7RE5YvQ/Eh6DMu0f9ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=A4/WIKKn; arc=fail smtp.client-ip=40.107.74.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="A4/WIKKn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUI7W52itOFjnc9PfN7g5Hhr7+nIZf5m7Ak8zKVVrB7jPy0ULWHme9yDD6HK5NbKy3gB4mHg1ADcUUfSfM+J5AlZodS7QnNW4AZMYtWeKYI8bbWnJisUIeov6Hy1s2C5ANEs54Tes5gBwQkEzevwKaEs1wsUEZwhHncrjeqsm+CsiRgOGldAu4Nu4kQngFxLQHpP+u34GBqYJOuZ3bw4Rs5PM+YfAtvYcFhlRvlPb3gZbvyb35etyT6j7eqP5tv27oAV6K+NT11fXghsmlkYss/0Y8qYgxYv8+ysVViXvr276caHpj4MBbg2oZO3i0saFfgYnp91u+YwxdQqjVRlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLhZCDiswJT/U+3c9hPeFEybExyPE2Y64MlCRkZ1gN8=;
 b=QGnYQtcy9p35/63ZGXlVk0C7LMXlJPYVzhnY6odQHbbLO5kbII2CJCVh0cMi0UIQRXgVjFoOUX3c+zJJ1psVepzUMJQVYiblXN3aN7Wucl3V+3n00JiEHHnmf+2A1XxQQuJctRRGEaRlk1LaW7Fm40YpQpBVQpCT/gqk+tJkZmxOGRTqsROwABofWPTDmexzYrWF9bzIauwf5+4XATCRuFqiWO/DRtJZia6NcXziK02cFEKIEPa5+7taVO2s3DaFrTrFuC2P+mPkbSAeDsIbEE2ZODXb66JGx/Xw0soL/42e1PEL+QSVfLc419FiE3DP1E3ra1EAA5LIpFlnDZq6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLhZCDiswJT/U+3c9hPeFEybExyPE2Y64MlCRkZ1gN8=;
 b=A4/WIKKnmXNmy14xf9mlCydJTnoH6B+EkO7rm2vbV0JqN8ZDIHr3C8K2LJt1ER8v4oqtq4et2HIxGe0lJ1p8p6hjbMYlZbsQeXtbX1O2uNkxu5VSSib6FMQXXlel8oEK+sX/ppZUVnkcwOUZEcQv3fE6CNeBKQCayFHNgbpHC00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2942.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:309::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 14:02:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 14:02:45 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when subrange setup fails
Date: Mon, 16 Mar 2026 23:02:25 +0900
Message-ID: <20260316140225.1481658-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2942:EE_
X-MS-Office365-Filtering-Correlation-Id: 653b0a8c-1cd6-43bc-8aa7-08de8364b327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1Y4QNUqZL1T7MCGRf6WQlp3Ey+1r26xOeZgUe/oK/GDBuLysec4g3xmNJZCSJFVyNM95F5Q0h2htoX8d3PKLdFMd6jsLlsHjjNplaj31VWpsXBFTvZqyU1C+Go+RhIkV68FXYMMZx7JC54BzDl9J7fqYgjujC/8oxwHtoZPaIsxyn+XYNuzRXp4gZAw7lJoK2di1eX3vxvSK1GGxGOQlDA6XmSP6y8l3ErsGnhpoYngLi3jZDu+9R2BQSf442hXnFQPo2nuCC4jjUjiBGdJPC3vnNz85M4MzyqHSKYgN3jRcpO/d7Uv0uyFLkMtSahiBUnTg2fol5JVom4DJEyYc2uQtBgQsUaBQcIoV04WsISNsJ8O0HLmXGU294gkPs2QjsQcr4RYj2YVrerhaC00nM44+KU0+8Rrcnv+SFuZBTod8ivoju8EgYe/CxHn8B9HudMVt+41hv9zETbcAzdmB+Ftc2t7PPmGJxJA02ctsUe8lt3+IIyGbW+00bUu29Bue2Jxb5YPN7lOuOjMf37RJlPpEcp/TVSEfc3SW9bx3kNKl96/nsEwPBz5WOmXw2dJa94OZCLtHrCgaBQksg8khztiWMmitQEkjByxqsQ4ScMpUVbjIcueH5dMJ3mBINjU4Rfhat5qFcEHF0UN+ecA6EY8RQXNKEnVM0g4TrVCHzQhoTTa9bzvkyi3CncM8rpbD7LPBrEadv3KK5J48FJNP8cM+eax3rM5QAUPt6abBY+j3gpPHi3eBKm5M0v8ze3UR3hQ6N1cJTe/YScqH8CxqDGDTIoA6cFbd7tV8I+5EaV8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxX1mHl9/cLcRy6lz6KrgaCX9oK0Fdgn3rftjXOXCd332+WUBiTIMgyY1DqK?=
 =?us-ascii?Q?a/zqDe/l+hNfXc/cfAifBrgGv+oi8SaZJtFdWMn4ESScQAJ4pH+Ffu5Hhxlw?=
 =?us-ascii?Q?0kX0UJ0p6BL7wVBIOVJrUOg36vF+49iuQKrDWg39OX6hn5XYsDXIUAB5U8YW?=
 =?us-ascii?Q?Pdcerscnq9QPy8+kHInIPukqI7UMFPMQFN6ctDWOj5mZXLpedAztEWrMX86l?=
 =?us-ascii?Q?/aEifUzu3dofC0cMFucx18dQFfRVl5Yjk9AmDEMVKddvcXUMExK+SVxx4BxM?=
 =?us-ascii?Q?2qy28/0cy1THwYi+uFddEIcs5HpzzAujaSm8cXR1det15YsSmYR2nMb/y35U?=
 =?us-ascii?Q?L0Hnr8rOJijp2PgXd6kf9Oo0RWm/h77s19YrFxnPI1ZlPwyxZ813XvCJ+GYf?=
 =?us-ascii?Q?wu5cZIzQDR4bZ0UT7kq+Zysgy85VY0W5xG+Pw+mC1oyHUBrpCAJZQ/jlh9hl?=
 =?us-ascii?Q?kVBd8vGs5qexn6dP6WOxrsyODj8jKJ+vjxGgZB/PgbWsgeZHvss+vTxavmh3?=
 =?us-ascii?Q?/FXSrTf5qsHAoYv5IlgXxDAb6dKc/b15POjgnsFvzqVu3X7cwokBoiuxmATy?=
 =?us-ascii?Q?b5+f0VqTwO6XjYzWm+1PWXNRgluWBtdXY2VAsiOxeEyw8pfLiLTNHKtq9x87?=
 =?us-ascii?Q?zfsF0bFD5js6U8F2+u0lLfuaqbQ4TStksiWG1M99ztvr5zC2tw6OTfAIj53j?=
 =?us-ascii?Q?ch4mnMnEZSBBU83O4ss241KGaRCq0OeDvNo1/P/oqacJEVUtz/AABqMsNk7S?=
 =?us-ascii?Q?cgiXXq8QXS90H4L0a21XuHlZt4LHKeNUtvZGI4rfSNMx3q20RB+Vn92rogPq?=
 =?us-ascii?Q?tVYKa+y7C44nn72uq0jXgwy1/qsYmzwyJV5ZL3+EQO5DdhUkrhXsLwUkDXfF?=
 =?us-ascii?Q?WwbrLel+930J/6+YwPw8kXXcVGFxm+2SwklGlHTxwB5M1IYJwVgUpx280eug?=
 =?us-ascii?Q?FR4tCeu0OspISQBM4jQVxRvIQ4967u8Y6tfy3ut9YBnPsG72An+UW/3zWShj?=
 =?us-ascii?Q?kgnpkW50AqmwPXeST1ogye1FyVWBPdpZ7PrxZxxQgI92xh0rOgITQXZ77yLX?=
 =?us-ascii?Q?XlIaxeJqt7ttA+IouFOAMPP4u8zntqAYLcaltQOiqwI8GBRFkBO8MO7AVTUe?=
 =?us-ascii?Q?DCbdmL8JmNH+QJs+1Ft4HIBwP6VK38XWRAkoGg38SNe1LShjkdleuDMwRAH+?=
 =?us-ascii?Q?hEx5Ti6h5Wf+0YEK2q9ne4zJ4YTYOwbULt63D4Zc6opi/SIa7xFbyGL6NCER?=
 =?us-ascii?Q?n0rKWA2Pi6XliOq1u0Rb4tS7mWj4JyreqTpZWVRhGsUHE5Y2+WLScB35BUhV?=
 =?us-ascii?Q?bz5yVld3jVbwfjrPCFQdBREAp5kQ4xwOadx6EwMNxut4nhN1Oj1TzNfDQ9s0?=
 =?us-ascii?Q?0GhmeRANJ2OJUDml/tg47uEF+iflzrxBn88PtFUSgtKy+F+mzpnK/0eyXCnF?=
 =?us-ascii?Q?svct26MzwhxfSchTW8cvHemwJGq1CZZwLKpxLgv+bYGQKQOEVf5lNySgQz+V?=
 =?us-ascii?Q?oY35TSQf7N1oi7nHDDu/xF0nKuBUkjlrkuBII6TOkgxbsJgz7ONh6HtxHM27?=
 =?us-ascii?Q?HyGgGQZM9PmjDJjX0WhjDBwjHOITeVSl/fOZQeH/Oop8mPDyRnP2PBVqsGMK?=
 =?us-ascii?Q?PsT3hExDb5Y9p/IB9T3w8LBVDppK8LsmrJ1FXNYa6lYLUMO/OjkEMaiSYq5H?=
 =?us-ascii?Q?pHKyMaTByf1wK1bZHhL3Ntker2fqcgu5oEw9WTfZTpCNE/q0iX5JF9kaM2zM?=
 =?us-ascii?Q?Jo18gi0ocdY76O5XlDtkfpQ3+YYDGkeF7A2JYGtfPet8u9IZbIT/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 653b0a8c-1cd6-43bc-8aa7-08de8364b327
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:02:45.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3DKxvLsWTeK7loyVLAZjnvIHuOAiHkSyWmMlkjS1bABPJRyVl83+6FeXf2GVmWZCCYfYfg8jVU6LS3MFrA86g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2942

When the BAR subrange mapping test on DWC-based platforms fails due to
insufficient free inbound iATU regions,
pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
not restore the original BAR mapping. This causes subsequent test runs
to become confusing, since the failure may leave room for the next
subrange mapping test to pass.

Fix this by restoring the original BAR mapping when preparation of the
subrange mapping fails, so that no side effect remains regardless of the
test success or failure.

Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
Reported-by: Christian Bruel <christian.bruel@foss.st.com>
Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 14e61ebe1f11..f44c36f5cac5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
 	bar->submap = submap;
 	bar->num_submap = nsub;
 
 	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
 	if (ret) {
 		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
 		bar->submap = old_submap;
 		bar->num_submap = old_nsub;
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
+		if (ret)
+			dev_warn(&epf->dev,
+				 "failed to restore the original BAR mapping: %d\n",
+				 ret);
+
 		kfree(submap);
 		goto err;
 	}
 	kfree(old_submap);
 
 	/*
 	 * Fill deterministic signatures into the physical regions that
 	 * each BAR subrange maps to. RC verifies these to ensure the
-- 
2.51.0

