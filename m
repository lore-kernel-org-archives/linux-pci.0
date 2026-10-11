Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE12EEE84;
	Sun, 11 Oct 2026 02:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684910; cv=fail; b=szMu0ma2KoZvddK8QwP6TmttL983dyhy0PLE9lLTAEXYIb8nBDQmZEaeXS8flNsEoPU+lOMNg6u/51uJ9OvBAAutV3hWE1yKhfVWUHVC3q+IOn2siASbp9cLd4GR9FVR8uZOKzXpqpTXhKIfHeSI300Lpn5StNe/qacy1Z05D4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684910; c=relaxed/simple;
	bh=Iehn7Tvxhr/nWuBfwFGK979xzvg9bKgw/+iR5PKlkkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzvLDAwxp/IuKqu64qNX7ykhrxBtBF38YhTDBgMzKefiijEM9iTRNSAxxc1l2jfRFDSSoG2UHGyNfVCtCtj77X7EcbluhoIqhpa5yKXqAMPbqKRZhwR/2w1ObSNI/6UOTJ2u1LOBBR4ilwZeLN1WgbLGQjxApBfbajubFjwGsYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nqDcamtW; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nqDcamtW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqupwPcM8gP305hM2Mauy9dBeF1IwMCOy8KbKEoFcDwqkLr6L29oTp2HmrYJuscQ5rNWeEdl+rWQ0GTSMYyKsLTe2n0pQrfNaCaQHLLMsIMFmyO/hhYHWWKyIuCxJLR4HIUYrMuoEabpKkifYwFtRhlQf0YKsbPJLZ/d6N/UMBIqNcIbrEXj/feaqRiB2+RRL5yTn00QHOiZGTm35U3TwdsYzUWpCaZh03AiVbjHWOHVG1IK2uqNUPF1Wip4TuNaZAioNGEpPvQyD7uq9KDRyj6r00sPVJZERM/QlJULljK7ROgagFDVBDNlOb4EWf0Hh+hr2JSRe2+SZvj10yxYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NulTqVXz+84440zY+tySFisExPE/yKlQbk6uSyr1ak4=;
 b=Wr3QZcLheoj63nFMzlji5COLbqnQz7TxJQqiY4Ic4eUotJ2JsW6gA0dvVZBoORsYIMOmlO8qJ/0EvEjfrWkC1TJCXcjY1ZxN2nDL1VhBo8vbH40Gtgp5MhzBXpTp1OEO7DkVshP3buZiA2aYkDlyrLEeTVAoQaxAqXjGO4HcUhzZFuzYRbn0u6vzsGVWcp5Bb5nQuCH8IPVxQkYmG0wxTgo21kNkT5mv9LNzVPqcckrAgztxfHAQLKiA41K+sNUcoZS4grq2b9LubrPdWej9S2bMuIIXsNWQxCjldl8nNLBfbgZGkARaxoWBfsoleNVu+yElD+YB1+kQWP35udevOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NulTqVXz+84440zY+tySFisExPE/yKlQbk6uSyr1ak4=;
 b=nqDcamtW2WdZygVkY1UPg21mJK+oYsrV5xBaGPs6mr0HMBP/VdQRajixFOQdBGzhq0L7I71meAxd0q3y7wgyQBXdEtFVxEoL+9ZzKE0TqWzRQyWpOzPe7a7DRvpVdrUFtR508zQ8ctaD6h+7cLqADTcfEyaOOYbYe7kMCxyq3Y4GUvYpUolE3dPLGGdNu6+dooMDDrCvsRW/h4LhaeEn0axHck7lffSbExcj+kaEayhT3+dBQE4uuZY34Gpbdtnk2xMGK7A7N9FImTNEFoej1mjwWQeXYXDipHVdyZYy0dEO10iH1uZtMv6ThO+RynvWJ1MHmue2MgNPhhkE2R0enA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:55 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:55 +0000
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
Subject: [PATCH v15 10/16] PCI/CXL: Add CXL Device Reset sequencing
Date: Sun, 11 Oct 2026 02:14:16 +0000
Message-ID: <20261011021422.3428136-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:510:174::15) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 152073b6-ea2b-4d0c-906c-08df273d7109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|3023799007|261009223027099003|921020|11063799006|5023799004|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	A0v9+t1fkQ8mkgJG5/MwNGm3kENNnTuzLh6osPVY7AcCbwByVnUkUZi4KAqJB6boR9I9V1bdiu/exT154m7VVDTq+mCr3CcyjgHht0v+d1umKB45iTvwx12w1LRU7Uko0JpAH3oLPAWUFX7dOdgdKWgls66cWEIH8Eco55yauvRs7bOD72vIBdLvaMU6JXLQh9hMzRbAbNUN4eibnpkWmtoSD6OziCEfWlMPUGIijeUuZj4rNT1B4jhBSh5A58X9r82wTjqfUQ/b9q5wvlPndSouv6HCuidIHphjLzaa6BPVsYXAr1V8sTT4By+XuOU1sjIkUpsCAY8UQlyx9vaFuIeO4COJXsY1CPnODNeGuROLNO7zh/GJAS63oUTm+ziOgiscewV6cktdLG0+8I25q6VwN/aaQs/qh3eCKxXcbrY5fW1F4cclRzGlY1WgxVpOT0mdaY46gYWu6p03NBJUvPbyuDWlZRRj14mntfrtZYMokamLKK5I5QdIj6aSk6bG7LmeObLxWmlqyfXPYpGqnBSgAB8oer585DBbCqbVuFWz5cEUea6/Qi6O4A/E1Ue+4kn0m59sVgvtoeAs3RkRCfyyXfjnOuG/2S/nKK/FrZwvYpvAyt6YiSQ9ZwuFHQGIhtRVYVgTW2s31ZHnyYjCBQJLGBstpRqbWslZWgD6Px1e5TywdSXb6hKz1Bmvv4BTJKA5J3exV/KoWGlaR7gy2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OK4mWRauWvZAji7Ds6euf5neRwz52awTmLQ6jiEYLZTRW9ncUt1WlCc6Eyb+?=
 =?us-ascii?Q?xy2u6BM/vhGOJlqBsTSyIv65A6//gz2DAiOTlXI9sFImk5J34HdhJH1tcRdT?=
 =?us-ascii?Q?PS0x3WESLfbY+nAHsEcSe41yiZ2HGJCFhXtg5s0wIUxkMPhZXisTtS9NpbML?=
 =?us-ascii?Q?/uXEgkwLfY/avggmoVJaMbpddx0IjxEcAKZWndQ7fYMHv+Eht3rcRfPP7Cs3?=
 =?us-ascii?Q?bzdqzjDkwM/lkbk3EdbnsWQezPg+zYeNyP/pCIGXFNDn82smdSnkWgRaUHpL?=
 =?us-ascii?Q?q5VY4J5Qh+xRGY3dpugzyn5fAJFjDfL848HCBKAfymw202hSirfep1cxaCpf?=
 =?us-ascii?Q?xyistlhxjfjwAUcWDtbLWK41L3e5bxcfwAy/Rkw8S0iGqv6XKLeVJhinvWGT?=
 =?us-ascii?Q?qkyDQVqb+WQfq064TxUx7Gfz6dliC5jyAKD6dhtGH4+bKVAT4g68fNk9sWKP?=
 =?us-ascii?Q?TeG4NPBXsN/Ch/4Ggk6R+P9B0gdwJFqkdrM9bCm0pdrhAk07zp90KL4mB4D1?=
 =?us-ascii?Q?s9MWs7t2uK5HCkHVaGGylea+bYk7kEm/ZN/Sd2o6JSGwBkIKdC0BbeMM/CBN?=
 =?us-ascii?Q?5gRtt6Q5TKVakgEz7f3v/FdduzUm++1GsCNQ9BAu6wh+v5oPbW6JHnJR9u2e?=
 =?us-ascii?Q?w1PXIXOmaS+KAVeVtqmPbx3U9bYkT7ozVLayF18wQOPE5wa/5wvLUwO2midU?=
 =?us-ascii?Q?YzijMPam3HjGNL6NLaBzHeE7TjejQV1As3qezrnX3aZgcvnJiCHsKYnZqFeS?=
 =?us-ascii?Q?WZQ4zE1IweRRoPESoXoHuYRtDRRw5BTzygnYmUlSyTpPG5QePA3Ds/RyfOTO?=
 =?us-ascii?Q?q5ossYAt2rYDkeesB4/GQzTDvxqn0IqHeFDci7bObwX8oj/VKZJf2/Gizzdc?=
 =?us-ascii?Q?02lEUgOnervmb9Z1YxF+5fk/rq0Apke+2u8HgOMEiI93iMTp3+GB66edWZ2f?=
 =?us-ascii?Q?3/PtjwASyhqJdaX1B56DV5Lp54nlk2Nf9o7EGNa+y5YKDQFP+XpPaxlDPCFo?=
 =?us-ascii?Q?0uMWnDP4xQpFkgiic0RB97U5M6w55ucc0Zx3fv9E1ULAzLddOE04Tw51/mmG?=
 =?us-ascii?Q?cfIyQV0m5rYvKanhoW/lAnUO/MTNZnRW5UcQ8c691wH+M7VvjDyZjUTIVyv+?=
 =?us-ascii?Q?HOLtUVHY2iEbSyS7Bbx6K8gR3mAlwDdR6pjTf2YaotXD6zw4nIPjgFAfpYk7?=
 =?us-ascii?Q?Cumncd2CzHjz6/0VamrrW12/8Ktmz9Y42P+gdyV5tLyQkufNdEZvDqNVMKFp?=
 =?us-ascii?Q?YeGJVcqJxTxDmwAgR24bPrJZk3Gh4lZDMlMU9Fxd55ykQpmhbkrDxZF19JfR?=
 =?us-ascii?Q?MMlpGz35PK7xNHGyvZkhQql5tDwX94J8Oq7lCPKBtfJoPI89V1B/MG4ONEpu?=
 =?us-ascii?Q?LIek8vdUWbIA+FaFrZddH1VBRy7tf9UkGWGoX9hplNIPiOt4HrF5oWcNzixE?=
 =?us-ascii?Q?l2xNNTf4awaGXx4MefTYwebdeFGlusqGdHbV9EmagcNGoVdsE8XZVfW64NBK?=
 =?us-ascii?Q?Bb5sD4tSfch9Y1pZyy2UblnR0ddrmimax9r2P2ULRRIyj0qWDzi1PDTFsnlC?=
 =?us-ascii?Q?VDQcMFt5QeAK5YIwyMwisomhOCLWu7xaTt5dCERCXSrFYbaA6GT/X8Dsm620?=
 =?us-ascii?Q?rbmWKaZlVQqZPHvV9ydm7NVrQ5TjrvzSWI5/81RaB32+gIuz9B/S3MqjPZ9g?=
 =?us-ascii?Q?t0jQhvAcxy9Yl3fHMZbjYJlu+6ssx7E29TFx+058mZ/x7MHFn7izrFd54EcU?=
 =?us-ascii?Q?iY7XSykhYg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152073b6-ea2b-4d0c-906c-08df273d7109
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:55.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1Y/6epRN8nCCanRIa84YMpMwDFVe4mw0DT6V8o9wWhuEwgQfnlWlM/MicW/63V6wE0sLVm4JfLIJ/17XyRBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
perform supported writeback, drain transactions, prepare the IOMMU,
initiate reset with Memory Clear enabled, and wait for completion.

Observe the 100 ms post-reset quiet period before polling Status2, and
treat an all-ones read as not ready. Treat Control2 command bits as
transient state, restore cache policy on exit, preserve the primary error,
and abort when IOMMU preparation fails.

Reuse Device DVSEC discovery from cache initialization and keep the
reset entry point declaration private to PCI core.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=04f8f84816d724f8b47f4d47a77916ac37c63a49
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/cxl.c             | 249 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h             |   5 +
 include/uapi/linux/pci_regs.h |  14 ++
 3 files changed, 267 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 471b57391593..9eb13adf0daa 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -3,13 +3,17 @@
 /*
  * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
  * memory device at enumeration, so it can be restored after a reset without
- * a CXL driver. HDM register formats and programming live in drivers/cxl.
+ * a CXL driver, and implement CXL Device Reset. HDM register formats and
+ * programming live in drivers/cxl.
  */
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -221,3 +225,246 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 {
 	cxl_hdm_cache_release(&pdev->hdm);
 }
+
+/*
+ * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
+ * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
+ * initiating CXL Reset, then limits software to CXL Status2 access until
+ * reset completion, timeout, or error.
+ */
+#define CXL_RESET_RRS_WAIT_MS 100
+#define CXL_RESET_STATUS_POLL_MS 20
+#define CXL_RESET_MAX_WAIT_MS 20000
+static const u32 cxl_reset_timeout_ms[] = {
+	10, 100, 1000, 10000, 100000,
+};
+
+#define CXL_CACHE_WBI_TIMEOUT_US 100000
+#define CXL_CACHE_WBI_POLL_US 100
+
+#define CXL_RESET_CTRL2_CMD_MASK \
+	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
+
+static int cxl_reset_update_ctrl2_no_replay(struct pci_dev *pdev, int dvsec,
+					    u16 set, u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl2))
+		return -ENODEV;
+
+	/*
+	 * INIT_CACHE_WBI and INIT_CXL_RST are commands. Do not replay a command
+	 * that remains set in the value read back while updating persistent
+	 * Control2 state.
+	 */
+	ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
+	ctrl2 &= ~clear;
+	ctrl2 |= set;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
+{
+	unsigned long deadline;
+	u16 status2;
+	int rc;
+
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+					      PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		return rc;
+
+	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
+	while (time_before(jiffies, deadline)) {
+		usleep_range(CXL_CACHE_WBI_POLL_US,
+			     CXL_CACHE_WBI_POLL_US * 2);
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (PCI_POSSIBLE_ERROR(status2))
+			return -ENODEV;
+		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
+			return 0;
+	}
+
+	/* Do not miss completion concurrent with the polling deadline. */
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+				  &status2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(status2))
+		return -ENODEV;
+	if (status2 & PCI_DVSEC_CXL_CACHE_INV)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+					      PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return rc;
+
+	return cxl_reset_wait_cache_wbi(pdev, dvsec);
+}
+
+static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
+					  u16 saved_ctrl2)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+					      saved_ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING,
+					      PCI_DVSEC_CXL_DISABLE_CACHING);
+	if (rc)
+		pci_err(pdev, "failed to restore CXL cache policy: %d\n", rc);
+
+	return rc;
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	unsigned long deadline;
+	u32 timeout_ms;
+	u16 status2;
+	int idx, rc;
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
+		pci_warn(pdev,
+			 "unknown CXL reset timeout encoding %d; using %u ms\n",
+			 idx, CXL_RESET_MAX_WAIT_MS);
+		idx = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
+	}
+
+	/* Allow one retry after the mandatory 100 ms quiet period. */
+	timeout_ms = clamp_t(u32, cxl_reset_timeout_ms[idx],
+			     CXL_RESET_RRS_WAIT_MS + CXL_RESET_STATUS_POLL_MS,
+			     CXL_RESET_MAX_WAIT_MS);
+	msleep(CXL_RESET_RRS_WAIT_MS);
+	deadline = jiffies + msecs_to_jiffies(timeout_ms -
+					      CXL_RESET_RRS_WAIT_MS);
+
+	for (;;) {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (status2 != U16_MAX) {
+			if (status2 & PCI_DVSEC_CXL_RST_ERR)
+				return -EIO;
+			if (status2 & PCI_DVSEC_CXL_RST_DONE)
+				return 0;
+		}
+
+		if (time_after_eq(jiffies, deadline))
+			return -ETIMEDOUT;
+
+		msleep(CXL_RESET_STATUS_POLL_MS);
+	}
+}
+
+static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
+{
+	if (initiate)
+		return cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+						      PCI_DVSEC_CXL_INIT_CXL_RST |
+						      PCI_DVSEC_CXL_RST_MEM_CLR_EN,
+						      0);
+
+	return cxl_reset_update_ctrl2_no_replay(pdev, dvsec, 0,
+					      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
+}
+
+static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc, rc2;
+
+	if (!pci_wait_for_pending_transaction(pdev)) {
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+		return -ETIMEDOUT;
+	}
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	rc = cxl_clear_memory(pdev, dvsec, true);
+	if (!rc)
+		rc = cxl_reset_wait_done(pdev, dvsec, cap);
+
+	/* Always clear Memory Clear; successful cleanup must not hide reset failure. */
+	rc2 = cxl_clear_memory(pdev, dvsec, false);
+	if (rc2)
+		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
+	rc = rc ?: rc2;
+
+	pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
+
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	u16 saved_ctrl2;
+	int rc, rc2;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
+		return -ENODEV;
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (!rc)
+		rc = __cxl_reset_execute(pdev, dvsec, cap);
+	/* Restore cache policy after any attempt to disable caching. */
+	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
+	return rc ?: rc2;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	u16 dvsec, cap, ctrl;
+	int rc;
+
+	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
+	if (rc)
+		return rc;
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -ENODEV;
+	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
+	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec, cap);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9e218f236e66..743e65abd758 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -733,9 +733,14 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
+static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	return -ENOTTY;
+}
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..7224857c7b30 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,8 +1352,22 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR				_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.43.0

