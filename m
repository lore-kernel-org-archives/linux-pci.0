Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830E51E444;
	Tue, 22 Sep 2026 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066387; cv=fail; b=NQp1GrGH8pmg/SRBR6V1pcgZ78Wp5TX9eNpUV3JzuMt0NNDOM+3PyjT9m3dtXHcS5YNJ4n1jDb8X5D5yxSjxwJklqs22fiQXZjGKVkMZE0ofgu57uWRieo+vMf57w/+ulyEgLyM2Vg8ezAO9ZiR1V7s+0lHfNyPNpR0j26FBdXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066387; c=relaxed/simple;
	bh=vkjWTjHBmLVAbFoZokXH6JDqSD5u/70DzCVi2cGgGfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ET4s3ZizWkkSqTJL3Wl296lqB6RcHvWdNsS4i5Gvq+K7LkXkm+e8/O/qo+VZ0kFieGA7WwvKhPDEUhU0jc+jGYNfchP+PFgDkcw9wqQ4UcrOHO109tBoHX8c2rmz4PxCiwmWm0VfwQIScnZdrkuVHAiTcZan/koOxu6RMEAZSVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YTTC4JQD; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YTTC4JQD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiUyP3lBvoUi7pYtxbHXKl13BoMVTB2WDZJHGYkrwS1BgNyXQirxgsYuHMvlRcVW9Cy/hZJovBnfE99cMVuIlocCzHthaAprh1gJ9Inqw+9TO4Y3Omenmt9SQtSb6V385OSrdWwcxBvCaMThUWSGTGMJ6MssV02e78gB9lpnN3g8BPnFuWo/hhonkanwDum0Dh6TPbRDTKPLdZB2uR2hNc2vQWd/A3u9UasPvWQHtPlioK/D5YxMDpHElkloHeIccAy3oJJgBdHji2P2ZdqwTbKRlPk3SfrFX8kyQO1nI86pHt1+CraXO8Q7aYJnbXtwN8CSvF70UBd15Di9tb8S5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVeVjxPfPw+jDsZrUyE0CfnZTVVQlb8dIx0qHQLGrZ4=;
 b=YoQ829UHEWgCc3/Z/97fPoKiErGpYnHprOkFj5kAT+XCV0VG2BeiaGGeQf6aM/4kJrqTJ5IlX7mVoTCKYkhYgbxftVvirVWKbYvi0tn47kzoaWFXD+WevCZwb0fJo2SPLXcMaAkh4Ompx+tibTr1QqOO7y4dkdmW9JiLhMFEWEMh53MvQYFZJ/3IM7/v/A12pQQWk5SH4srXx+ORcC2kj714EyRaJUbW5312SnmL58mgLXZ2pVEOcnj6fVubkw+z9mRpxsF7sJf7oJ8olPRolYwhNn+2aUjVMTi8AugE9VsjxHAL4pAjdAr3pIRM6YuiScPp43aoT7Yag+X9eZMTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVeVjxPfPw+jDsZrUyE0CfnZTVVQlb8dIx0qHQLGrZ4=;
 b=YTTC4JQD03Iozmx6C7NYicysCUgyu0hE44oyE6ielwvD2GZ2BOiQEgCGnTDo3ohQ9l8CD7yR2qUiFYloq8ZUoYyG3oQb+GjST76tLaDgErwvH8xKETleqpy0Q6PSUNQ7/RtqzVEfJbF0Az7eyRFaxC8tlMtW2k6y938c+9aeaaIgC+0R4JbRWAZbZy7KIBE8vJOwOFH+ad2hsBFeLdLHmDxVFQWMYsfQ77HAwij6FQdNwf6DjPqjkVEqsITdH32tiw66MB2aVfjlV+5DY7IwkxB1/1Anb1y0KV6WV4b5Xm1wmbLR6DAdwjiujlQdYnE7F8jlycjDVzNNVqRMWLysPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:40 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:40 +0000
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
Subject: [PATCH v13 05/15] cxl: Introduce reusable HDM decoder settings
Date: Tue, 22 Sep 2026 08:39:14 +0000
Message-ID: <20260922083924.2451158-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b07eede-f8db-4614-0a9d-08df18850b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	coZmjVy4SlL/fLVo1aIQ1DSPFhO6Qnyjo0KvCszrhSQVI5Um5pUGS30I6Iz8jIAlPyYj2vxjBrifr9ANiJ4UqlunpsnO0FRPsHm+3U6XtMAKpGrCPBIrq6nHz1O/mO7wZE21OEgh/6csGdoBextubM6RdLd/sPCOJphaQ7RzIWnYecvAZrXAfA+xpJCFTcvcZ8ZwHqBWLfhDrSfEoBNHAWogq7REBa3vdM/J+Ozx9snyD9LwseWx43aTeqJhQYrJ2dXJp0GYUqMK67HVIH8FdMWNbNMuZQFunTBs+dkphAhHsueSh7WeSuYc97kTuBScEedQKQviKJRHyFXgdQ7st8cSSQIe+N/9vvg3PEAcd+gt/aybucb5ZkmQpaPhKFq8eZMKR7eAXL1EONb5/S3z6TPc8xiiSIpVexgY5AOrbP/uC/gB1c/0z8McPzzCfZKNksPR0ONTPK1lx+O+l/AhvAkAA1S9tqj7qNE5jL5WuzKkUuMQ41DC5eXMYXlJriWxMIvV2h4+yNXsxMgV6NzaNhVgxvCkep5LWPqKOS4V2RMQS67eMYjxu1cV3/LEwKoBP3GMX1UTyfKnqFjwO0GyHu46NuleujaPQzNqhWaVnAGJt+2z/jSOn2eJrUyL3OGwCJZU1bUxiXyOgyWDoWag76TeoEHT+S3yAlYitamoRGQJSTbuDBuRrWSvtjSYTxVaozK2+kTXIQPMClAjzgb8qg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xIUBATeIDf3tbZwQcBVHcNJHrexq8C4/sDWZMPky09SlALXiDDtWOlrFU7qt?=
 =?us-ascii?Q?b6ScJ2Sfy7U7x6HaRnkPzl4Ln0rDehvhy1xySHKJ5hS03tqLGqScFRqPlCd1?=
 =?us-ascii?Q?DeGYnm0EOglMjKIEhTwXx3X3zRk9kkuPxG5ntdxipPK5aExH4FnL5HfaDK33?=
 =?us-ascii?Q?xFTjvInFKSJExEhRcK4fPbDILnEnpD6LvmDo6Io/jXgZ7GMMWhanoYcFbLdo?=
 =?us-ascii?Q?bQ3pSD1WbQ9yI0GMc6HkHlsK8GKnIp/vtnu6b9YMIrxHspsNxykb5WX5+eZW?=
 =?us-ascii?Q?RMGHB0/YwewlLsBtRZ7Cbp/ccnRiZpWRTJsHWkBotL0ADtYtnDE8/r9M2t9d?=
 =?us-ascii?Q?CRhItkBXp9yPt4sx6fjCOJmdR2jRR2Ni5MmB2OHHYwzMVn0dr+1IuOsEfBtn?=
 =?us-ascii?Q?oivPfWAodp4kH99TaxM0F7472PBoDlRBFT8hmu6iqOV5bWW3MiSu1cFWkiU1?=
 =?us-ascii?Q?TpqSLxkk+EPdOLYwdsy32z12E5UK4GV86QLB/XIo8PdMzs8uEDPsiFWaX9nU?=
 =?us-ascii?Q?hd2W99aCl1pHWfFpuZXweLEa+90IsmVRO6S+wNPIocd2BBqnaZzTioolLDD7?=
 =?us-ascii?Q?PaCG+rBtzLtv8MTSBgpP9yIPopLEy5Y2gvx0GfEku0+eXpMg8zjNfMQpxcuJ?=
 =?us-ascii?Q?MVwH7USYfpm3M51R6Md9YamhhJYXhdy/z00DxrAXuVtRydVXuzYImlb5Xa7/?=
 =?us-ascii?Q?Dmfx4Vv5qTLSXxsj1iFeraBEpfYCSbNnUOeCTP5FqvLxsXGrZ2EHGUiqJxuX?=
 =?us-ascii?Q?aGnZNxQKf2eSWNV48Mgdolkn944u6UqMp4e/2Ajgz7vA3dgzLNsa5tCpbn9+?=
 =?us-ascii?Q?8SsSE8R1Uhiw6v5f4rzPDfwoktQNNT924/tkvZsSC3hJKhlLcs1r64I/Ueu0?=
 =?us-ascii?Q?bSshxKtORKytgH+BvZsiP0wCvPGW/+34WFWz1ao9NkHVXUBUZBjQrDd/85Ze?=
 =?us-ascii?Q?dQp/IcR/C7H8/LDQP7MBThBSDxS7iDMca154bROPyFqfmJ6Rn/UbV8H9mvdc?=
 =?us-ascii?Q?3OE8zzDG2f0YE8RVUOiAGuLvRW+C4ADl87JykkFPidQv9tLicGmpfIbL1lzb?=
 =?us-ascii?Q?zELU2gkT/0+MtAf3mCoB9FIXuqeDRBf2Wwt4Q2lTerN4ehVD1r7JRbnvOeYZ?=
 =?us-ascii?Q?TSszOro5H33p/eBow5XqF195wWmxSreiW6B3wQ68y3wUx0TY8o8YymrhzWTG?=
 =?us-ascii?Q?wmbNiiF++JmbfAKZm/zmWUqvrGHzAZTEAbglCn/5Eo4yVuS+br2AWCUVOIDF?=
 =?us-ascii?Q?NwSdCA8ligm5hn2B7kxIdGjEPBOd0DyTYMUtZ9gS+HnozO+kCbpK8/mim/mC?=
 =?us-ascii?Q?+8Yc/anC8YvdazLfI3WrUMHpRSFgy4FN3aDlofxO7ghhBcMymdbvAs8ibL/5?=
 =?us-ascii?Q?wFNlg0LKEDV1yCARyS6lOrqsjmgJURRcMt8uJmgFF54v1UXYph/Wcj0LDAyr?=
 =?us-ascii?Q?88j695rD0C2qx6IZ6ZEImF2pavPp+L5N/tGv+UIHCxu/ceql2VfthFyLRlFT?=
 =?us-ascii?Q?ydztTgzFPpH1cvdaXn11aKArbdcuMEcHGBfU9JZnVf4//gQH1NvXpx7cMPqo?=
 =?us-ascii?Q?TLWySHs/FfREhaGj2Ezlz7kq4G0HwRip0eijNGzkyHgMH8kI8VEx/L2ZZlHO?=
 =?us-ascii?Q?Y0ZFdEFGQ7guHZe7AXxHFGdc0+6b5tAJP7Slb3SGnjSA8S5BNba4yyfmmfD3?=
 =?us-ascii?Q?Lq59upHhqPCsbGirvZ5K84a5RvK8qUryihOgxerVIeNo4xKE2jGepMMSI8DO?=
 =?us-ascii?Q?FGWxJ0JjFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b07eede-f8db-4614-0a9d-08df18850b18
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:40.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMjYOzUXrOlbSTCSZQCJIaJ6wCSpGNWa8j/09mXy8OYNn+8hHLEpzyTey6qa3QlnGo7znaOxuANq8AE98lcVjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

Represent HDM programming state with struct cxl_decoder_settings and pass
it to the commit helpers. Keep endpoint skip and switch targets at their
call sites, place flags with the programming state, and leave runtime
region ownership outside the snapshot.

Separate commit initiation from completion waiting so reset restoration
can reuse register programming without changing normal DPA-lock policy.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h     |  5 ++-
 drivers/cxl/core/hdm.c      | 40 +++++++++++++++++++---
 drivers/cxl/core/resource.c | 67 ++++++++++++++++++-------------------
 include/cxl/cxl.h           | 27 +++++++++++----
 4 files changed, 90 insertions(+), 49 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 9c6d4b99f787..3444479cbade 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -139,9 +139,8 @@ struct cxl_rwsem {
 
 extern struct cxl_rwsem cxl_rwsem;
 
-int cxld_await_commit(void __iomem *hdm, int id);
-void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt);
-void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm);
+void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
+int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings);
 
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 008f04f0ca25..b3ddc02df65e 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -702,7 +702,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
+static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
 	int ways = cxlsd->cxld.interleave_ways;
@@ -724,11 +724,41 @@ void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
+/*
+ * Endpoint skip and switch targets have different owners. Keep that state with
+ * its owning type and flatten it only into a transient register-programming
+ * snapshot.
+ */
+static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
+				 struct cxl_decoder_settings *settings)
+{
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
+	*settings = (struct cxl_decoder_settings) {
+		.config = cxld->config,
+	};
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+		u64 targets;
+
+		cxlsd_set_targets(cxlsd, &targets);
+		settings->target_or_skip_reg_val = targets;
+	} else {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		settings->target_or_skip_reg_val = cxled->skip;
+	}
+}
+
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_decoder_settings settings;
 	int id = cxld->id, rc;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
@@ -761,10 +791,12 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
-	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
-		setup_hw_decoder(cxld, hdm);
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		cxl_decoder_snapshot(cxld, &settings);
+		cxl_commit_start(hdm, &settings);
+	}
 
-	rc = cxld_await_commit(hdm, cxld->id);
+	rc = cxl_commit_wait(hdm, &settings);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 68d40f745acc..ea0d855e5549 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -13,7 +13,7 @@ struct cxl_rwsem cxl_rwsem = {
 	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
 };
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
 {
 	u16 eig;
 	u8 eiw;
@@ -22,12 +22,12 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	 * Input validation ensures these warns never fire, but otherwise
 	 * suppress unititalized variable usage warnings.
 	 */
-	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
+	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n", config->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
+	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
 		      "invalid interleave_granularity: %d\n",
-		      cxld->interleave_granularity))
+		      config->interleave_granularity))
 		return;
 
 	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
@@ -35,10 +35,10 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
 }
 
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_type(struct cxl_decoder_config *config, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
-			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
+			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
@@ -48,7 +48,7 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
  * clock skew and other marginal behavior
  */
 #define COMMIT_TIMEOUT_MS 20
-int cxld_await_commit(void __iomem *hdm, int id)
+static int cxld_await_commit(void __iomem *hdm, int id)
 {
 	u32 ctrl;
 	int i;
@@ -68,43 +68,40 @@ int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
-void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+static void setup_hw_decoder(void __iomem *hdm,
+			     struct cxl_decoder_settings *settings)
 {
-	int id = cxld->id;
+	struct cxl_decoder_config *config = &settings->config;
+	int id = config->id;
+	u64 target_or_skip_reg_val;
 	u64 base, size;
 	u32 ctrl;
 
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	cxld_set_interleave(config, &ctrl);
+	cxld_set_type(config, &ctrl);
+	base = config->hpa_range.start;
+	size = range_len(&config->hpa_range);
+	target_or_skip_reg_val = settings->target_or_skip_reg_val;
 
 	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
 	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	/* Target-list and endpoint-skip registers alias the same slot. */
+	writel(upper_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(target_or_skip_reg_val), hdm + CXL_HDM_DECODER0_TL_LOW(id));
 
-	if (is_switch_decoder(&cxld->dev)) {
-		struct cxl_switch_decoder *cxlsd =
-			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
-		u64 targets;
-
-		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
-	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
 
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
-	}
+void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
+{
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	setup_hw_decoder(hdm, settings);
+}
 
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
+{
+	return cxld_await_commit(hdm, settings->config.id);
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 69941f7fdb76..1acdf537e4e9 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -42,8 +42,8 @@ enum cxl_decoder_type {
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
- * @region: currently assigned region for this decoder
  * @flags: memory type capabilities and locking
+ * @region: currently assigned region for this decoder
  * @target_map: cached copy of hardware port-id list, available at init
  *              before all @dport objects have been instantiated. While
  *              dport id is 8bit, CFMWS interleave targets are 32bits.
@@ -52,18 +52,31 @@ enum cxl_decoder_type {
 */
 struct cxl_decoder {
 	struct device dev;
-	int id;
-	struct range hpa_range;
-	int interleave_ways;
-	int interleave_granularity;
-	enum cxl_decoder_type target_type;
+
+	struct_group_tagged(cxl_decoder_config, config,
+		int id;
+		struct range hpa_range;
+		int interleave_ways;
+		int interleave_granularity;
+		enum cxl_decoder_type target_type;
+		unsigned long flags;
+	);
 	struct cxl_region *region;
-	unsigned long flags;
 	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
 	int (*commit)(struct cxl_decoder *cxld);
 	void (*reset)(struct cxl_decoder *cxld);
 };
 
+/**
+ * struct cxl_decoder_settings - CXL HDM decoder programming snapshot
+ * @config: common decoder configuration
+ * @target_or_skip_reg_val: switch target list or endpoint skip register value
+ */
+struct cxl_decoder_settings {
+	struct cxl_decoder_config config;
+	u64 target_or_skip_reg_val;
+};
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
-- 
2.43.0

