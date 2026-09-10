Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D983D1CC1;
	Thu, 10 Sep 2026 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024140; cv=fail; b=KbtXWsJ0m1tZuBuNI1wDvokEDrOF8UYf931UPVbIclGhczfOLDZ5iyiCl7iCRZdXPNMaiuLuDf1/4HDjNZAHfWqVsVoXkR3wdFaSjCFjju7FsjcyL4aNSMwRutbmP4ZiyNlRiDETw/Ugmcs7ne2sVKp2y8n+Yf9Ib+/3YZoc8E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024140; c=relaxed/simple;
	bh=OSbkoHVGWZBm3LVahASlNG7kjc+XIQK/YfwXo73oWOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KqjBF2+tqxjRTJcN2KZVePWEbzdEsYQlhuK0aOOeMxMNj4dakrpmiaMP4QnS9Fk1FqnzUUivd51AvHzDGxyXEZHghzMXs7RxuzmLvnkORY8T5HF9Ha1c62oVYBe+QtkKWXLv+9PC7+aoKFwa3QSo8losu6YTBNYCV7cc5+STZ9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZgIdu7dj; arc=fail smtp.client-ip=52.101.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZgIdu7dj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHtuXmrBzloRIdbArvpGok9Ungk4O1Ob/anWNSi5KYUa1QdXpsuBbtRC0sSg+l76Pf3wzK06No8PCqPx8PHBz7JMWf4tPEaf1mzOpTZFkS50CS9NcKIDksbbt6n5WUTN/AwJgNn6iTL7FVtv38BZhdTCEg76ZCPvHse2T3CPNBjkGT8+cFGq5isuzDw8ft97WnCzLrU1Fv6GT1wSLsFLslMdIScqhprUCmAwf/8odH+hV8BbgddipUR+knmbkesqxJnehRQPsXnt/R2MSn6Ewc/eQh1iilpMbpYZLdCmI8V4c8zPjLXHRzotOgoWYZfzXVlHGDaz1p5IqfDgA9Gn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJtKinkJRJRoI48bPrrxaBMNb35ba8m/hhkUfJZIy2E=;
 b=ysUWZ1+iAYsnEEJaCdgIHlKsGd1YIpZ3J3Ukl4xlVRrUOx1w3TwLoQjUOw8Yxifd9YADCVbW2aUNvWW80BzUK75PUR/ifRRTHh/bn0i7v2XWsOUxoEJTm1cNK/8yw0N3U+mv8LzB0Cuse9gg51yDK/H56+6ySTiYNl3xfTLI5leBmnkJbCNeJnDyFzJtbNibFwq/YFx/BJL0hXq/QxWEejjj73maSORH4Wnj8+/nDr1oV+Dn8rYS5QMEzJYw1wzFk6NrpTz/WrJXp2lkHIYMH7FtFFIl8m9+KjuPkj3Eb6zj0yomEcz1ZFOcUoL9/sBZ+MXtnhn3T0SHBpBmJ6zYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJtKinkJRJRoI48bPrrxaBMNb35ba8m/hhkUfJZIy2E=;
 b=ZgIdu7dj/LXHrk9YbZG5Arvdf94nTTCSJY7Y9b52mKizYdpUcqkeBOyBECU7Hz/CtO86ZIWYrz2x/g9TI9E4vrDVRWGWXLDUs1nP9b41etXtAQ41Eae6/9BvisZaf7PRHzGeEsezUxzKaJWiyKZ82xD5DSC65jXEzxIuj4a0x/9mdHuJ0eEfzY/+FZbOAHvK8Cc7i/+B1UcFXy8wap2iLEK4xnp5jWIQArAvnN/LSDuaoWaHZ67Zp45K4Q38z09aOVu+WMfYqMGbSvtavWujv7DgGKL2gLCJDbL/zNtkLRa5VoTj0xehpX4917HfsmAI6f+67AAfl67cjfxDaTDB1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:50 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:50 +0000
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
Subject: [PATCH v12 09/12] cxl: Restore CXL state after PCI reset
Date: Thu, 10 Sep 2026 07:08:05 +0000
Message-ID: <20260910070808.1444264-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:a03:331::28) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 23235f08-086d-4633-9a6f-08df0f0a5da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|6133799003|10067099003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	u0EjIYUWw8ag07b8oyLLrvtNv5rcA5AstxoHbA+R9KSCWBNglgtkwr8AI5c62hozoyXt/u7DMx9WRTWnmbf/7Sh6zbtAeTHYGIQAwyF/kD/Az/b4ZO6xeV7cd6+rPQvmpyVMHIwuxEAn6+7KLOGcGQ6NK798NPeYH8V23eJPcp6Vsy0dK6FTbVRowXipPdnx6f0brhvd/nc+TnwYYzd2xznto0npOpEAkxafN7qwQ9T45CJUR5TgHbbxDMXNQjYTvqZCKOuhdN/8CtheVmyJxp9k6q4k49ds0Ldn9Nl5xs7D0eJKQUwchDaEzoPIz1POSCyf6F1mUKvJg6e86hgcf9YPmcmotp8AaTraiV54TIqdRaXehJf7cRMtwqsXICd9phGlSmV7SQfI7AdDe5cm2Aziwv+BsU97MqNvyONXEMnAHg1Eaap1Xu/+2Z3vknRT2OL6uN182CRwVUxh2kDzwC2/anR3ZTEeG4rYMc7FyT1I48fTSEdKDQCY+ZxjiYIjmZGDuMGq3FvroUaVy4oYejUU7FGd6yD+s348lhzb5GSPMJlsNHG5h9V3lzEExl1iy0zsr4iYoGbvDzTr7RQgt35ENdvezEoTOX9d80brQFquV/YdQRx7JxG5srw8CauMaRIkjWXQSrRSL+mcVl6J7z6M4QQeZxc+DN9PM88/yVI5RmtHr8chd9rrS4GETPInJ2EL98p6nDyo8JEQWVGKYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L/3alCnmoWtjUbfOK76Ayy2bt1PuG1G88TAXvKLCLsaBX1Rpz1xGp260j/xH?=
 =?us-ascii?Q?xikyk1LdFzACmJngVNZuVOE+bRJhhN1cRjQXgfC/dbP1yrHJXS3mff+RGjOe?=
 =?us-ascii?Q?Nl30wgaA0+P8b5Z+qOQkmvsoDPE/YpEnj7I13G4oqo5kJuwSh/SUdAkPugYI?=
 =?us-ascii?Q?FgkT7or4W8GGsppDpeOYTbD1hekvq2RHXj/223cKOZNtcgIYVNWvccwwe3Bs?=
 =?us-ascii?Q?BYPNvCEGQFCISxsg88ExgNjEACCM64Uw0k2LpV18PUy5qMTGkJTeIweBXEo0?=
 =?us-ascii?Q?0F5rOhq0Bw8oCIkU2Vqsda0/lKo7NyFyjpliArH++nq67/V1c1ooKbcEBkZ2?=
 =?us-ascii?Q?S9jaL5MuAfFJ2BtBMtV0qgFRB/vN/KQ+CceQoLa+lfH0sWDdq7CcNHHDq9TD?=
 =?us-ascii?Q?7L1sY+vVEfKWYN41Y0nvKIY4k3ml1N/49lmiry+4YVj8pWGQovvC8YYGF8S0?=
 =?us-ascii?Q?M3Ju2thP6juYVL4UiTNzU6TqUf8x5KZ3LM1KLqzswcWaya+emDIPSZKejdhm?=
 =?us-ascii?Q?rJJDpBM1F0ofSxpf9xTuxERY4Dvux1fbiKUniHqcnO92HrnEfsucvfjE2wTD?=
 =?us-ascii?Q?niGbivpeYDHwD9EHZVYnSgI1GLRu0clKFudMnrJep57DdLm0w2Jx42ulWO9T?=
 =?us-ascii?Q?Ng7D4hpZwwd0T01Bo1cHfXsdDpqAoI8uCa1jEjOIY7zqTLFwrq0Mlpffn7Ky?=
 =?us-ascii?Q?vC1LBGFO6x6f42dvB5jpfPmroR1uUZKKB3+mke+x+K8Xzm9LqF+BxMMtdiJ0?=
 =?us-ascii?Q?7gFeO57gwknit1YonviaPUj1i+z7NuVj30pHPKdIWf0uOvrJ7uCA98NnDKN2?=
 =?us-ascii?Q?H5jGMru1mBKdFaoxnzootomehGl1NE/ZSKs5efNa0AUusvJOW0ZA7chEfNl9?=
 =?us-ascii?Q?EmUMkXtiTMONyo7tOjVTmqKaTdfvU1Xl4BE8za2lHbNkWlftgFAIF0Ez7tVP?=
 =?us-ascii?Q?HXV+kBB04zHyF+Y5z6yA30cAf5eaB/s2ZCwlAUPxNsHgiQL1zY0ObaeaYixq?=
 =?us-ascii?Q?zet7mEqHvGGnvBwHmfF0ocsxpDVwG+EECYgVgcp8N/PQA3xqYvqhUgO1DUif?=
 =?us-ascii?Q?xhG6meJmcdkr3JinPeN0uSt4w+4v+4pvOJ7LjgPpM8FEl/mNzCo1q9uKp18B?=
 =?us-ascii?Q?SioQDFxeXpFWqfN6KpH4EwxKF7lxbPouFxjj3XP53UY4s6p0B5zjRgGVO2yB?=
 =?us-ascii?Q?qaneMor5KEpT9T6XKloW4cNJ2oFIQMg4qo4j/GNqXGNqUO1VGLjA0+Dyb73Y?=
 =?us-ascii?Q?949j30vygv+QBZU0l3yh15Kz76IlP8zw4aHf1GikUs74vfh+r5lHkDMjOYKx?=
 =?us-ascii?Q?5vorqA1kjhH/Pk1kf+XoAYqaphe2Jg1irhvz+lzvmiHfpqlHLHc1vWzS1mNL?=
 =?us-ascii?Q?Uu1XoLDAeHkvvX4GzOKZ0e8Yt+z/0p4o3CZOVNhDc9/8mINYJoQe5BYh/dsf?=
 =?us-ascii?Q?rlK1Z+f2IU6iK5P3s7rXVYkCx4veMB7SkyKdDgCX/0ujflINVnMLZvB0I7gf?=
 =?us-ascii?Q?44uCjsS8AZlspDzdICGixJCphQOR0xDhELciFzDEQUX1vETeUikvOKJYQ6Cz?=
 =?us-ascii?Q?xv1AyU6cOra7aDZvs46pN7O7wVe0Huuaap2aZmdMtcqZ8OIo2B3YNmFgDDDN?=
 =?us-ascii?Q?XlW2yENkZaWMkFp9dcoHxlIxAnT8jIAm/SW0wIRtc4ECPsfhnLDmK9YhDgh3?=
 =?us-ascii?Q?gUlnIsV84OICUaYxWXyU3K53uHX8aTfzmwKaXqBSWdL8U4E+TZta2BwauSq/?=
 =?us-ascii?Q?kcXLHWAIZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23235f08-086d-4633-9a6f-08df0f0a5da3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:50.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32LzC/fIbEJ2D4Hzxgil7lDNIR3JOMXI7RzPe1aERrmNIQPsjYeF3JyvQj8X4OJYGQvBzbRhsjmdwcSiAe9L2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669

After CXL reset, restore PCI config state enough to reach HDM MMIO,
restore cached global and per-decoder HDM state, restore the cached
CXL.cache and CXL.mem enable bits, and then run the normal PCI restore
callbacks.

If reset clears a previously locked decoder, restore and commit its
programming before reapplying the cached lock. Leave a locked committed
decoder unchanged when that state survives reset.

Keep the target IOMMU reset block active until CXL state restore completes
so Bus Master Enable cannot reopen DMA before decoder state is valid.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 411 ++++++++++++++++++++++++++++++++++--
 1 file changed, 396 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index ac0284fec51e..e1d09f9042fa 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -83,6 +84,26 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
+static int cxld_await_uncommit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int setup_hw_decoder(void __iomem *hdm,
 			    struct cxl_decoder_settings *settings)
 {
@@ -272,6 +293,31 @@ static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
 	return hdm;
 }
 
+static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
+						 int bar,
+						 resource_size_t offset,
+						 resource_size_t size)
+{
+	resource_size_t hdm_start, bar_len;
+	void __iomem *hdm;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
+		return ERR_PTR(-EINVAL);
+
+	bar_len = pci_resource_len(pdev, bar);
+	if (!bar_len || offset > bar_len || size > bar_len - offset)
+		return ERR_PTR(-ENODEV);
+
+	hdm_start = pci_resource_start(pdev, bar) + offset;
+	hdm = ioremap(hdm_start, size);
+	if (!hdm) {
+		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
 static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
 					   void __iomem *hdm, int id)
 {
@@ -284,6 +330,40 @@ static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
 	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
 }
 
+static int cxl_hdm_enable_mem(struct pci_dev *pdev, u16 *command,
+			      bool *restore_command)
+{
+	int rc;
+
+	*restore_command = false;
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, command);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (*command & PCI_COMMAND_MEMORY)
+		return 0;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND,
+				   *command | PCI_COMMAND_MEMORY);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	*restore_command = true;
+	return 0;
+}
+
+static int cxl_hdm_restore_command(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
 static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
 				    struct cxl_hdm_decoder_state *state,
 				    struct cxl_decoder_settings *settings,
@@ -496,6 +576,269 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
 	if (rc && rc != -ENOTTY && rc != -ENODEV)
 		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
 }
+static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
+				    int id)
+{
+	u32 ctrl;
+	int rc;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -EIO;
+
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			pci_dbg(pdev,
+				"CXL HDM decoder %d retained locked committed state\n",
+				id);
+			return -EBUSY;
+		}
+
+		pci_err(pdev, "CXL HDM decoder %d is locked and uncommitted\n",
+			id);
+		return -EIO;
+	}
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	rc = cxld_await_uncommit(hdm, id);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n",
+			id, rc);
+
+	return rc;
+}
+
+static void cxl_restore_hdm_decoder_state(struct cxl_hdm_decoder_state *state,
+					  void __iomem *hdm, int id)
+{
+	u32 ctrl = state->ctrl;
+
+	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
+		  CXL_HDM_DECODER0_CTRL_COMMITTED |
+		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR |
+		  CXL_HDM_DECODER0_CTRL_LOCK);
+
+	writel(state->base_high, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(state->base_low, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(state->size_high, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(state->size_low, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	writel(state->target_high, hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(state->target_low, hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+static int cxl_restore_dvsec_ctrl(struct pci_dev *pdev, u16 saved_ctrl)
+{
+	u16 mask = PCI_DVSEC_CXL_CACHE_ENABLE |
+		   PCI_DVSEC_CXL_MEM_ENABLE;
+	u16 ctrl;
+	int dvsec;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	ctrl = (ctrl & ~mask) | (saved_ctrl & mask);
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
+				   struct cxl_hdm_decoder_state *state,
+				   struct cxl_decoder_settings *settings,
+				   void __iomem *hdm)
+{
+	u32 ctrl;
+	int rc;
+
+	rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id);
+	if (rc == -EBUSY)
+		return 0;
+	if (rc)
+		return rc;
+
+	cxl_restore_hdm_decoder_state(state, hdm, settings->id);
+
+	if (!(settings->flags & CXL_DECODER_F_ENABLE))
+		return 0;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		rc = cxl_commit_start(hdm, settings);
+	if (!rc)
+		rc = cxl_commit_wait(hdm, settings);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
+			settings->id, rc);
+	else if (settings->flags & CXL_DECODER_F_LOCK) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->id));
+		ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
+		writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->id));
+
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->id));
+		if (PCI_POSSIBLE_ERROR(ctrl) ||
+		    !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK)) {
+			pci_err(pdev,
+				"CXL HDM decoder %d failed to restore lock\n",
+				settings->id);
+			return -EIO;
+		}
+	}
+
+	return rc;
+}
+
+static struct cxl_hdm_info *cxl_snapshot_hdm(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *snap;
+	struct cxl_hdm_info *info;
+	size_t state_sz;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	info = pdev->hdm;
+	if (!info)
+		return NULL;
+	if (info->decoder_count < 0 ||
+	    info->decoder_count > CXL_HDM_DECODER_MAX_COUNT ||
+	    (info->decoder_count && !info->decoder_state))
+		return ERR_PTR(-EINVAL);
+
+	state_sz = array_size(info->decoder_count, sizeof(*info->decoder_state));
+	snap = kzalloc(size_add(sizeof(*snap), state_sz), GFP_KERNEL);
+	if (!snap)
+		return ERR_PTR(-ENOMEM);
+
+	*snap = *info;
+	snap->decoder_state = (void *)(snap + 1);
+	memcpy(snap->decoder_state, info->decoder_state, state_sz);
+
+	return snap;
+}
+
+static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
+						  u16 *command)
+{
+	u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
+
+	pdev->saved_config_space[PCI_COMMAND / 4] &= ~PCI_COMMAND_MASTER;
+	pdev->saved_config_space[PCI_COMMAND / 4] |= PCI_COMMAND_INTX_DISABLE;
+	pci_restore_state(pdev);
+	pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
+	*command = saved_config & 0xffff;
+}
+
+static int cxl_restore_state(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *snap = cxl_snapshot_hdm(pdev);
+	bool restore_command = false;
+	void __iomem *hdm;
+	int first_rc = 0;
+	u16 command;
+	int rc;
+
+	if (!snap)
+		return 0;
+	if (IS_ERR(snap))
+		return PTR_ERR(snap);
+
+	rc = cxl_hdm_enable_mem(pdev, &command, &restore_command);
+	if (rc) {
+		kfree(snap);
+		return rc;
+	}
+
+	hdm = cxl_pci_hdm_ioremap_current(pdev, snap->hdm_bar,
+					  snap->hdm_offset, snap->hdm_size);
+	if (IS_ERR(hdm)) {
+		first_rc = PTR_ERR(hdm);
+	} else {
+		/*
+		 * Restore global HDM control before per-decoder commit. PCI
+		 * config memory decoding is enabled for MMIO access, but bus
+		 * mastering remains disabled until HDM restore completes.
+		 */
+		writel(snap->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+		for (int i = 0; i < snap->decoder_count; i++) {
+			rc = cxl_restore_hdm_decoder(pdev,
+						     &snap->decoder_state[i],
+						     &snap->settings[i], hdm);
+			if (rc && !first_rc)
+				first_rc = rc;
+		}
+
+		/* Flush posted HDM writes before PCI_COMMAND can restore BME. */
+		readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+		iounmap(hdm);
+	}
+
+	if (!first_rc && snap->dvsec_ctrl_valid) {
+		rc = cxl_restore_dvsec_ctrl(pdev, snap->dvsec_ctrl);
+		if (rc)
+			first_rc = rc;
+	}
+
+	if (restore_command) {
+		rc = cxl_hdm_restore_command(pdev, command);
+		if (rc && !first_rc)
+			first_rc = rc;
+	}
+
+	kfree(snap);
+	return first_rc;
+}
+
+static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	if (rc) {
+		pci_warn(pdev, "failed to keep device disabled after CXL reset restore failure: %d\n",
+			 pcibios_err_to_errno(rc));
+		return;
+	}
+
+	rc = pci_save_state(pdev);
+	if (rc)
+		pci_warn(pdev, "failed to save disabled state after CXL reset restore failure: %d\n",
+			 rc);
+}
+
+static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = cxl_hdm_restore_command(pdev, command);
+	if (rc) {
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	rc = pci_save_state(pdev);
+	if (rc) {
+		pci_warn(pdev, "failed to save restored state after CXL reset: %d\n",
+			 rc);
+		cxl_reset_save_disabled_state(pdev);
+	}
+
+	return rc;
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
@@ -523,6 +866,34 @@ struct cxl_hdm_range_context {
 	struct list_head ranges;
 };
 
+static void cxl_pci_target_reset_done(struct pci_dev *pdev,
+				      bool *target_prepared)
+{
+	if (!*target_prepared)
+		return;
+
+	pci_dev_reset_iommu_done(pdev);
+	*target_prepared = false;
+}
+
+static int cxl_pci_target_reset_prepare(struct pci_dev *pdev,
+					bool *target_prepared)
+{
+	int rc;
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	*target_prepared = true;
+	return 0;
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
@@ -934,26 +1305,21 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 	} while (true);
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_execute(struct pci_dev *pdev, bool *target_prepared,
+			     bool *reset_initiated, int dvsec, u16 cap)
 {
-	bool target_prepared = false;
 	int rc, rc2;
 
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (rc)
 		return rc;
 
-	if (!pci_wait_for_pending_transaction(pdev))
-		pci_err(pdev, "timed out waiting for pending transactions\n");
-
-	rc = pci_dev_reset_iommu_prepare(pdev);
-	if (rc)
-		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
-	else
-		target_prepared = true;
-
-	if (!rc)
+	rc = cxl_pci_target_reset_prepare(pdev, target_prepared);
+	if (!rc) {
 		rc = cxl_reset_initiate(pdev, dvsec);
+		if (!rc)
+			*reset_initiated = true;
+	}
 	if (!rc)
 		rc = cxl_reset_wait_done(pdev, dvsec, cap);
 
@@ -963,14 +1329,14 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 	else if (rc2)
 		rc = rc2;
 
-	if (target_prepared)
-		pci_dev_reset_iommu_done(pdev);
 	return rc;
 }
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	struct cxl_hdm_range_context range_ctx;
+	bool target_prepared = false;
+	bool reset_initiated = false;
 	int dvsec;
 	int rc;
 	u16 cap;
@@ -993,9 +1359,24 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	scoped_guard(rwsem_write, &cxl_rwsem.region) {
 		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
 		if (!rc)
-			rc = cxl_reset_execute(pdev, dvsec, cap);
+			rc = cxl_reset_execute(pdev, &target_prepared,
+					       &reset_initiated, dvsec, cap);
+		if (!rc) {
+			u16 command;
+
+			cxl_restore_pci_state_for_hdm_restore(pdev, &command);
+			rc = cxl_restore_state(pdev);
+			if (rc)
+				cxl_reset_save_disabled_state(pdev);
+			else
+				rc = cxl_reset_save_restored_state(pdev,
+								   command);
+		} else if (reset_initiated) {
+			cxl_reset_save_disabled_state(pdev);
+		}
 		cxl_hdm_range_context_destroy(&range_ctx);
 	}
 
+	cxl_pci_target_reset_done(pdev, &target_prepared);
 	return rc;
 }
-- 
2.43.0

