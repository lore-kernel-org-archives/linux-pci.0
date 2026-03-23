Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F9B2D0C7E;
	Mon, 23 Mar 2026 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235772; cv=fail; b=gRtytXPnLW5gCUMHmJ1w6BJ5Uv1q5oPsNpx/ZGwe3wwh1APB8lp1DvZFDBJw7/19yGrOBr/Cd1wNMc/iXXtsJvqWR/p5g27zQI0g54nqUwLZrU0o7EusmFRlMQcMJ1GsU1b+yHWNsXeGohpPt5MHWTZh34doewZA0zbWC+NV5cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235772; c=relaxed/simple;
	bh=oK5aNPczH9hampVJVXa/X1nQLH4R1+K/btOcgzzwuug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVNGtmYAUjzyEyvl+gl5V0GpJc55twUr0Z2ncNicULX980sJjo1p+YJNKRuDK70Cja+iOhM0krYXCJOgbwYg6ePkCp77PLBunL0e7BKezhtAn1dvqB/95iyikWAl86ldjp5D5twBJfXYloWIpW2AH4lpH0D4398f2VsRCHiwarw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=s5YKLuBt; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="s5YKLuBt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYe5rrJ+GPJMSyrFY6DonPE6Fhk0zx1VluydUygsEB5xKiL6N4/QKUOfG+DTZoyTcWfqhEd281S1qVH5hLLefdXBr34Xe1PfaV28v/2H4A9nMvXbGU7+iFYOuBFD1teuxoZOaogGpe+zaFrrPVu7DwqGWH/EiAm69vapSuJdhuDghXcBlN2vPxghvK5D83GPwFWDVidMjaycnWImbLgsqiZN9qVE7Fsef9JY/Tnw3aYKOHPtdxuuyJzeyvzPim37sHFX6xfbYNXxIRtAvlSaw/aDx/pD1XlaeJQsJt7j+XR+43l1G2OacW3t3hLNDa9DDudJQUpoxKzD3+5XDmpLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbdLwShg/N0PqmxqrhlJuRm2kLPvQXzQ9FnDk+Ewkgk=;
 b=G8IMDMcbvI4FToAGOgOXiE6obg43c7RCtiPNp/HkH6hC2kfpIjNyT0T9dkw/fAuStuArpfQwfyTPa1mkrrdYnbRyty9lrJ+o+GcqPYSKZz810na/iemJRfNfo0EZwjh3PODTUcB5BwHZGI71gQK28TJhyhtmzH0W4wR0iFqwyxYpw9a6ACupiL1BYM1WuRCPirpWZVBTTt180So5UfyGOVkguoeGJcXxf53vlpybcBy9cbZZfj0gcARjZ8KfkaczYid5/dweHJQ+3f24Wv0agsEieCGdJfKeXJVt/kPlmFq50jv7iWX1jKpjqRyT4BldP920NgRfpdMMKwE97umg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbdLwShg/N0PqmxqrhlJuRm2kLPvQXzQ9FnDk+Ewkgk=;
 b=s5YKLuBtj9kjrN8TwIRTxAa51/qA1Z03Y7r/OV9Cjrye5IuaLjhCKX+HuvMNJFA+LakWfbAgYckJx99QfZsBM7N6eTGnkZ7UIXitV9w53dK5M5eYWBEoTAiRoqhBS7i6K28qHAdYaBTgwkaQah4wE8FWe8+OHiYmcIHKo6MXWWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2385.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 03:16:05 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:16:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v3 07/10] NTB: epf: Make db_valid_mask cover only real doorbell bits
Date: Mon, 23 Mar 2026 12:15:41 +0900
Message-ID: <20260323031544.2598111-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::10) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2deae8-4f1f-41e1-fa22-08de888a8555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	S3OLTL3GiqSswTYicNBpFlWsKi1Q8oNaZHDD8gzv+ZGOj0GVqUAM7m+d/KcQrg4fV6S44zJ7/3BFz1sUdbdt3Fza1v58u9SIbmC3LJfFwAb7qjgAYl61Bwn9oCz2dYeMBiUebrYgfiF8mWLa4YBKgIHAsFexr8ylX7gzkg7qH4quOCx+lAp3FI67/E8h//aDRVR/XCqLQJJlOnraWbZRQPu9RKGW+qin+ma7I8zpmEpB0/dwGN4p3BVbx2WoeCDHp8U3smSkTmRx2IDJgPkjxZ3AxEzhh1YtRQPYOrs0uE6PLMAj5Pi1pO5ifhcCETWku/2pOKxBmJNgeUqeDmWEk7QA00QuWsTdCw0EM0fDxuGeRFlBtbhIYJNF4cKYuCesYVIiXOsqnah9atLpntY8OAJ2wgGdqTfF11CCWDzvH6Zu5y82YyIctGzZBKWGkEd0rFAnwVcSjp8Bf5D02Y95CEd2nHH+rccekxg8nsdPZzuOwM4B3tvcCk4YO/jsU5Zl+sjf1x2P3HpS7fuRxJh7HWDx/Ga+pqKh2AWittXnNQKTloeO5LzAQFUkb+4mucQrtRyRQ86lURDzylTt50DW7i9YsDhGFXttv8B9wBbPNRkqrhq/e3sKcgnWTiKeckmKQ+pWcgQxH9dcXzcI81bmbrJL+79yx2WyOPFRMKHVNx0KS0vsxjyYA4AmoSXXTuQIEekXvcwaXZNoD2+STcyuGMeHLQPNF/blHQXykDEZSMLR24PzzzUYPpQuD9lUbT6KVZANTVKVG8LgD812CrdWOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDdkMleKa+Gnz6c65O7LUEyBwAUL91wp6qEW375/NYEeyijfMqBDn2YSXe8R?=
 =?us-ascii?Q?fbvCw42XGcBpNz21/NJrjWQDesKIpJ4B6QScnRRwy2iNMCBBYIkKdkhV2oWX?=
 =?us-ascii?Q?P31wYfacXJTskbjFeLGY4OWkUZnw73HE5wedhYbb4F7H6IbT47d/XBtsmmsD?=
 =?us-ascii?Q?iz31QbKhTfcGtr2ndbJmDkLinNZGgKUxP+KCooYqcXGvYxAmSNw1fYpbIVbQ?=
 =?us-ascii?Q?jmlg7u5II4ovkaJFbEw/VkxLEfF0ZFE9eWokBlbbtgEUJPZ2HdSmw70Ie4/e?=
 =?us-ascii?Q?0dLtxRRKWzeCXG2V6HeZ2n541bezQ+OmO8JzNiBa1dz4uiElobxp+DJ6GHOa?=
 =?us-ascii?Q?ErV9BC2ASyGYIGTTyTz3NLRlnxAGwOUj7Gah8BPqkfDlsTFLFkqk4AE7oP3N?=
 =?us-ascii?Q?1ZGQzSdk+K3YdRe3vmFmq85gpSM9C5kQmi2hS/eVGusrtT+2+MWnS3qT8b6B?=
 =?us-ascii?Q?LF+otFbacpEKqqP+AvpZgZjaVThllBwJvg8z+bHr7VqVbxrUqOvfu+aHpNLN?=
 =?us-ascii?Q?skgS55ac/a/FNjlUlvItux5yzmwu6MOE/a8gXAX5SJLX91VtF4EH3KomfunX?=
 =?us-ascii?Q?nnEJDm9fTm0TNZ2vTN8TmvqtvhUOK4Sw9ayzJlAV71x919I9ufDXE2ANbSNa?=
 =?us-ascii?Q?tOLtfT99BnjGrWnxtvoH4v811+iTQcKP2nHYj6pIH/9bi3+jZxuyVIL+EWqA?=
 =?us-ascii?Q?HEtzr0PMJfewUv69PwSYxXu1TL/9kNpSbrk/q12+A02eju0v4Gv/h3VRzfxX?=
 =?us-ascii?Q?/jO7RAp+RYCMt5CcziXfv3Gv5d1/g2Xj3ageLY488PE2sqX0GvXe0AqYLl8T?=
 =?us-ascii?Q?AYQ4cHZ+zvQBLr3CcJcHiub/way2QVtonQFMOEgBk2pl3nO8BkKCOASY3mEq?=
 =?us-ascii?Q?7tkcLmdBbNAMIOn3WJ77c+p2utGLL22pzTYQk8vLTldO7t1SxSkfXPhEYWOL?=
 =?us-ascii?Q?H5DsihF4rWXJ33ysz6E6GbJQ6AJfyd3QEBKxtF2+ZiGNWh0YBjBEFpdpVmY8?=
 =?us-ascii?Q?fDQP7AtkNq80XJ2njk4ScoNNgfyCgnVLPr+CqcjU4gafCxPUZPf9WwZOELli?=
 =?us-ascii?Q?JPv1q6FUXcSCkWB9kCOHI7LNCL+4wpSCrXnwUpjcfqCSkfWDybxYVnHTTtNd?=
 =?us-ascii?Q?XXH+jr9Kv2hvFsDCcaXk9eApR22C7/U5i15+yeHMUa2H+HCZwS8eHvSq6G/E?=
 =?us-ascii?Q?SJUPkl4KQaJGnbr6HLBOuQ18HrcvjLCirXLvBOzcyRqKS4DjoLJOhDbCBV4d?=
 =?us-ascii?Q?HEzOdXGdpb/fkI89rl7HOHjOZL1UPn5dWu+ySJyy2L2ORfknO2gQk282rjZP?=
 =?us-ascii?Q?kALJDKa6c3zKMP3Ye/iez95xFWUkW7U6elxILahuqGPpByhmUeOT4+O3xgO2?=
 =?us-ascii?Q?n7Md+kxIE/9Rv6mTqxh2OXp8IhHxHNBsrZtVA8VHIIKepy/nZlRAIyv8yTxa?=
 =?us-ascii?Q?XehbMG8prTqMn985gFv98bMjNpERyUBQtKVGZs4VnSLQ4L5vDJ0XRgO5KYl8?=
 =?us-ascii?Q?tKH/SRnAEZPCeBoy6CgCHfSzrYsruSQ72NtPSrabdExAkvbmTtjWuk2ma7FN?=
 =?us-ascii?Q?5dfUGkl8ak08rxJfongJ3SQc891LF6ynseZYFEby+jquj6CJnEU44tEkGWtr?=
 =?us-ascii?Q?RpHmvBuc8kQlQhDdUJJXMx2lPMsYTKsQgxmDLH3MIcQS6m508Jtrlc6sPUEn?=
 =?us-ascii?Q?nJ2fAB8Sgrk01/efiui7X+KDZHZrauI5TuN9iTT6kVfBSAQmxZhpxVObvdzc?=
 =?us-ascii?Q?KKnxg/Qy/YXjx8hDN6O0Vs22AxBMgIjgZWxkME7i1RgB26Y8ascQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2deae8-4f1f-41e1-fa22-08de888a8555
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:16:05.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKk8qD2EkVTBWLbMoWLB7+LOmpXpdcZfnt8iEUmI3VBRmVvcFKYV2TND6DybIuyaRwScCvG8pWNH6nnGtz5w1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2385

ndev->db_count includes an unused doorbell slot due to the legacy extra
offset in the peer doorbell path. db_valid_mask must cover only the real
doorbell bits and exclude the unused slot.

Set db_valid_mask to BIT_ULL(db_count - 1) - 1.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index bce7130fec39..07dc97d3270b 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -580,7 +580,17 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		return ret;
 	}
 
-	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+	if (ndev->db_count < NTB_EPF_MIN_DB_COUNT) {
+		dev_err(dev, "db_count %u is less than %u\n", ndev->db_count,
+			NTB_EPF_MIN_DB_COUNT);
+		return -EINVAL;
+	}
+
+	/*
+	 * ndev->db_count includes an extra skipped slot due to the legacy
+	 * doorbell layout, hence -1.
+	 */
+	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
 
-- 
2.51.0

