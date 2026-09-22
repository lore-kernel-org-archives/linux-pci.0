Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1F528434;
	Tue, 22 Sep 2026 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066391; cv=fail; b=Zdgbo2AqcsNl+7fxOrMzjcjLIM60UJJLh+25B0OKUAfJhxwNkIMQw/yxLQpKBX4c8fu7Xi6Nt+j51+jzuE/XDAJff+XwV9t5q8C4rYKHDNwULuG1iavNPTq1IJVHHY0x1L692u/0pKKAHTzOdDRc1v1FFthhpFz+fOBIQEwLOyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066391; c=relaxed/simple;
	bh=n4zwa1gGy1O/ufYYRSkojdFQ9IxCQtV9qk7Ijxz1BTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxZYHPhajB3v0hxKwK6iPM8Yk1hirO4CMIJJ8XyEKTilS2I2qpKgbuSYglydO2iBYkeRUvS9jXXR3ayR/mB+rDAVoTH+hrRN6ooQUThJFXpKs36JMZjZerQsn1Fkq4RtXSV5LMfE5nw4u5pZ8s94/cXBcM6LcSU0APp2UkHbd3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tIHDHThx; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tIHDHThx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE/hd7yTLOLO5/5cOaRFijDqIP7E3wXhlM3QYqhS6Tu2EzLlGaOiMhWtzlfXydxyt7MEu33+q7JYpu0nO713rHIlsuBdaq7KLDsdBKOfaxfgWpZZ736sgxUkk8srvJxcY/8WHdGECnFHtqabLlvL0DjRnuL7FRit9F9IFB9VN0EIf7/XAZkYMkaZfcGJAeChhqlZi9VWRq+VYSOrzcqh9TDy/eTH2CoR/dUDB40KYM5pzGVBN8DHbZJHDaIZ6tx1reh50LFrfleGMexhPc8HagnK1NWJxDlan5X5m2RSG/BW09QwCd7oGpUpIRamAVOqOpB9xBYj0ybe1tQkm9tDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YoZJJZWJE8jAvXksdjvNEf+S0p9b+hM1ojalDspnz0=;
 b=XT6QjHQNgb+SevE6svSXtjnNwRlvK7i6KwgX8tfabJTB6zz5kq1g110CiSx0d31Ybz1PW4wBd5S7AthaogSLVhFYoy5tOXMtLp8Rh9wZUgoJNc3JRFvaET/vNiQUFtuE/CnJm9N88ppnKZgtTEsiwpowhDS9KH8YTpjGndNMXQWeTcV/3SH1fSpY8TG/AHIG+AG7+j8y2SreuydIKqhvaIWcgeHQu9qF2ENN1LaNGJo5I4+8BVfGjUeGHewTRsa2/hhj4a8KXs0Jpi4q9GrF17EDlqX6TxLGXkzhMeEhg9It9FDq9VTS3yxziM3GW6QHn2wVjibbTb1rrlxtztnfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YoZJJZWJE8jAvXksdjvNEf+S0p9b+hM1ojalDspnz0=;
 b=tIHDHThxU1OBjne4LeUz6bOid/CfHEjMfLq5VW+5DBXo/cJo2tHpBS0rkmdgxjiqzyYcPbG6zutDtAH0GxXU/WIEPxQSmCB+pWP9+1CHA7JdA29Svjs1YuPEaXmnTOnUSeG6qhfHajtU1q9idnPuuFMdhXrDcePfaWqA9+bhYkbCJ/rP+U/DvHPXjUxKOwz/WIXaLX68ODzsACcy8ym4ug3b+12xi5YImabfSXGAEUogl3++6tR4ExN+uadYJKjZz8Av4mIE37ZW+IH82U2zOULez5UkCxDwTKOLx2g1yIToMY+2ecl8SnooLzT8ShbDAsW/UoIIhPm9arlkUhXeCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:45 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:45 +0000
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
Subject: [PATCH v13 07/15] cxl: Share HDM decoder register unpacking
Date: Tue, 22 Sep 2026 08:39:16 +0000
Message-ID: <20260922083924.2451158-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 343fabec-5615-4e32-3ff2-08df18850dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QcVohekazl/YhOcVCkbt3RJ69fKpPRHzPmbeY49y93sgqfT3lLORBAvclO1xvlqoVVpgHwUr44SBE1uKW1ZAlFk76qkfezsyLR7EbBlUkLesvPoo4GvLt+oodDAiqYi7m4tqHxbQL7khPjqBnRahXRb/ongdR1rDr0YxUFK5nSIVoyP8emZjB7QPKnzPKFXu3IucOf7HiiTp4X12WzIa6Xhd0T2ObU7j/gdGQDMoDD9vyQY++06yTQqfaAxp0vFRZeqrmW+1Ehe+s+bchYoAXbU+aTBz9xgcy7tyS1Jdb/D9QgDuqE+sO+s1F4i9cnAU2uXz2yElQtyT9tVOHqkzJHBcDSo4XmKOi1KYV0JR9s6jZJONql4icMs8HhIyDZ7gh1+RIN9R7ALNFjXut6MknLyruBazlHk4MgevwRD8hsT15jM/54/gx4MqpvJLUshvkLlX7WruflgyMFdFDRz3A9y+y6CtRwOaxZrXtpzukX8o8/39ESK17oYrTbiL1jz7ot18sKcZLU7QgSCM+v/xec+gPuNl555tLtK/80c1Jaq5GinRDY7/z4OyRqQa8CjFNg886sgPheDYChXdw7QuV9BtPQAuBagH3d3emr1gO+xsQ6CTqZuyWshIB1lKaAVisHcPMYqIxOeF5nCjp89rqDJkRT99AQhPMuelbS4qEVLiU1qsirKfogf7aG8aDSUlL6Y2T4RV2OIYWMW1I+yoZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wauoXT6cO/xtz+4sagshG/EJ9NRPiiy/UG1fe9O+zbrinvVE6qHj9EmHcQG?=
 =?us-ascii?Q?7B1xlnfez1P6KeY1/vDzPIE/I8tDjrI8qs8iy7QeVi2tW33/Dg3YJciJbnhh?=
 =?us-ascii?Q?rM4tZw+MzfpCJZ1nRSI4EyPcZEobiKDrAkNd0rtcPc7h5zSdvl8zyyvfMuq8?=
 =?us-ascii?Q?DmobNxpJpi+x8mjEXjJ+rRprbdmqOOOE0zrxR8F1aQG8oO0lM4YMgsjOkAnR?=
 =?us-ascii?Q?oyWvTEnEmppiJN3oXOUFjHxhqZ+8KuO7k1T9fyGQAnJEJMSiJruOQexdLCDc?=
 =?us-ascii?Q?LoHMc8xz/VqEajHmroAzZrasAirD3XRGeaJqYNbehqYHeHlfl9XQZ6TcNAPF?=
 =?us-ascii?Q?QHQ/0q/Frbx5yZfETAEEpoZQk3gOuAWyPXVW7BNgVVaxBBt2uc/Fs3rCJS0J?=
 =?us-ascii?Q?2+zu3gUP12D6zgq/Jhq/eTXCd5w5cUNFh6Hyouwc+dbw/YlrQyY8ZIld78oC?=
 =?us-ascii?Q?cZ9fMs2DWjnIwqKgvOh2Gc8ZKq/PCOeEJiKCZg9GLRmshs9s4EuUwwPk7Yms?=
 =?us-ascii?Q?XMjQinPKW14aQvVy2eGsyBcWE8kuIrWCN1xN0J+zZl/NFEDcWA0WOxlcwjcX?=
 =?us-ascii?Q?/TUgYCxMCl78OUXqjvPaLnIk1nEqmAEDGE8fo1jTKAHgzxVgstlamRI+caXH?=
 =?us-ascii?Q?Pj/UPD1jmttSzcT3IwaTMWDXX7Z8+S/CobZmeeSFf7sAgyC+vMlIA5CZnCmy?=
 =?us-ascii?Q?6E5xTP5mkbiEaSbJ8sljvmOvusvZhfbwCirR/vUDqnWKuVq8vHgrXlpsd4WY?=
 =?us-ascii?Q?se8y5bGH4xa6AGkqdjeqvWE5zQL7MhH/oEdQnI8CGZa1rrcWabImJTLKbxy5?=
 =?us-ascii?Q?H7sEQuoXMCnjM1rpGVhGUM7pBHf1zbS5HHb7iGFnZDK/qWPuucD2a5MiK2To?=
 =?us-ascii?Q?cU47NQkoNdivm48x8q3CpKdtN5NlqeW9W1+yWNTUjvxjdpN90qazi1/9bU7i?=
 =?us-ascii?Q?u+6nR4QxpTBfxtwtC53WjwtEqKvYGs/A0Ypy+SQZBnGDHF0NfDEkpEe0gJCE?=
 =?us-ascii?Q?0qvODGxKaFmpGkaMN9cBdNnM/LRpnwSnDVtdzPjDiRqOqrwJ6FUESLgbO+Ib?=
 =?us-ascii?Q?7tf+FAF+HuJHdhZLj+AL5SlMz0LQM3T+/adOor+0o6zOMQQMCXXKYstbibbQ?=
 =?us-ascii?Q?Gdd4vYHMZ0MN0cVr3wKQvjmA1BYkf36zxgca8EU47ruGN3AuzqmkWdZVK+xj?=
 =?us-ascii?Q?3kRttMVelGtn8Y9HeeT/OzUpnyheOSRCsTfc1/0h3Vf3VCWXMkhDlN4YxLX7?=
 =?us-ascii?Q?rx8DPxgpz86TgjEoE38ByalHOWdpfUeUAbsBCdY0BodEpC4in80fGRKA1VvT?=
 =?us-ascii?Q?F2NzGr2I12Z96GcPcO/XAKFrEz2qsPJOPPkZ3l6u9WNE5yHlmeV4LUhaMohq?=
 =?us-ascii?Q?XUlbJK219dOIxlsBlXlKcwh2vswUuLOWWbBtd8K6KhegOOjP+3uqqEVQ8j9t?=
 =?us-ascii?Q?iAFkRLuC8Yk5gmq5IFkNAbUi2/p9h+T8YDn8IKqY5KzFD0Q3o5OslmFe2z28?=
 =?us-ascii?Q?UGHM6JW2vfnJ4us3rzSEFosTfKFEqjntXw2PYpmpDH5dSgN6KEPEV0OfA43h?=
 =?us-ascii?Q?3gr0RZXRQ6XJp00fcN2Ocbun2nfHJW1z8ZlQuixlQfQNtuIZg+BBMx28RIjV?=
 =?us-ascii?Q?xfTaUhARo8ZcOJ/OrcaUxGl3TIaYEwdVLptbg7Zw3xG+ouUQzjHLrZ39uoCK?=
 =?us-ascii?Q?Pcv8kL4cxfTgIo89q7nn5i4BOf1X9dvdWPojgEdQFEO2/D6O3pepmtPvrQYN?=
 =?us-ascii?Q?bKGj0O8mtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343fabec-5615-4e32-3ff2-08df18850dc0
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:45.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwVDVzw6xdL6Xuowkd5U2W5TsJJOtNDFEEdekok+osIgJcNM6IvVqEJ9QqBTZGsp+TSqJtYCKZIIYENYCUNfyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

Factor HDM register parsing into cxl_hdm_unpack_decoder(). Validate local
values before publishing complete settings, including committed, locked,
and target-or-skip state.

Pass endpoint skip state to the DPA reservation helper instead of
updating live endpoint state, preserving its ownership.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h     |  4 ++
 drivers/cxl/core/hdm.c      | 74 +++++++++++++------------------------
 drivers/cxl/core/resource.c | 55 +++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3444479cbade..7e2723d1f87d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -142,6 +142,10 @@ extern struct cxl_rwsem cxl_rwsem;
 void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
 int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings);
 
+int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size,
+			   u64 target_or_skip_reg_val);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b3ddc02df65e..98268e8e15b2 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -932,8 +932,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
-	u64 size, base, skip, dpa_size, lo, hi;
-	bool committed;
+	struct cxl_decoder_settings settings;
+	u64 size, base, skip, dpa_size, lo, hi, target_or_skip_reg_val;
 	u32 remainder;
 	int i, rc;
 	u32 ctrl;
@@ -953,35 +953,34 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
 	size = (hi << 32) + lo;
-	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+	hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
+	target_or_skip_reg_val = (hi << 32) + lo;
+	rc = cxl_hdm_unpack_decoder(&settings, which, ctrl, base, size,
+				    target_or_skip_reg_val);
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
+			 port->id, cxld->id, ctrl, rc);
+		return rc;
+	}
+
 	cxld->commit = cxl_decoder_commit;
 	cxld->reset = cxl_decoder_reset;
-
-	if (!committed)
-		size = 0;
-	if (base == U64_MAX || size == U64_MAX) {
-		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
-			 port->id, cxld->id);
-		return -ENXIO;
-	}
+	cxld->config = settings.config;
+	size = range_len(&cxld->hpa_range);
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->hpa_range = (struct range) {
-		.start = base,
-		.end = base + size - 1,
-	};
+	if (!cxled && cxld->interleave_ways > 8) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid target count: %d\n",
+			 port->id, cxld->id, cxld->interleave_ways);
+		return -ENXIO;
+	}
 
 	/* decoders are enabled if committed */
-	if (committed) {
-		cxld->flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-		else
-			cxld->target_type = CXL_DECODER_DEVMEM;
-
+	if (cxld->flags & CXL_DECODER_F_ENABLE) {
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1015,38 +1014,19 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
-	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->interleave_ways);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->interleave_granularity);
-	if (rc) {
-		dev_warn(&port->dev,
-			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
-		return rc;
-	}
-
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
-		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
-		target_list.value = (hi << 32) + lo;
+		target_list.value = settings.target_or_skip_reg_val;
 		for (i = 0; i < cxld->interleave_ways; i++)
 			cxld->target_map[i] = target_list.target_id[i];
 
 		return 0;
 	}
 
-	if (!committed)
+	if (!(cxld->flags & CXL_DECODER_F_ENABLE))
 		return 0;
 
 	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
@@ -1056,9 +1036,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			port->id, cxld->id, size, cxld->interleave_ways);
 		return -ENXIO;
 	}
-	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
-	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
-	skip = (hi << 32) + lo;
+	skip = settings.target_or_skip_reg_val;
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 1b4742622054..7eea2bc38d94 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -109,3 +109,58 @@ int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
 	return cxld_await_commit(hdm, settings->config.id);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
+
+int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
+			   u32 ctrl, u64 base, u64 size,
+			   u64 target_or_skip_reg_val)
+{
+	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+	enum cxl_decoder_type target_type;
+	int interleave_granularity;
+	int interleave_ways;
+	unsigned long flags = 0;
+	struct range hpa_range;
+	int rc;
+
+	if (!committed)
+		size = 0;
+	if (base == U64_MAX || size == U64_MAX ||
+	    (size && base > U64_MAX - (size - 1)))
+		return -ENXIO;
+
+	hpa_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+	target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
+		      CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM;
+	if (committed) {
+		flags |= CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			flags |= CXL_DECODER_F_LOCK;
+	}
+
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &interleave_ways);
+	if (rc)
+		return rc;
+	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
+				&interleave_granularity);
+	if (rc)
+		return rc;
+
+	*settings = (struct cxl_decoder_settings) {
+		.config = {
+			.id = id,
+			.hpa_range = hpa_range,
+			.interleave_ways = interleave_ways,
+			.interleave_granularity = interleave_granularity,
+			.target_type = target_type,
+			.flags = flags,
+		},
+		.target_or_skip_reg_val = target_or_skip_reg_val,
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
-- 
2.43.0

