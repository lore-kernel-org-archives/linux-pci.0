Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC9330B3F;
	Tue, 23 Jun 2026 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185108; cv=fail; b=NMjCOUsxyKtTtnYxuCFeIHG8SYahqTND3wepMXP61tYXMTNRgNVZbaWNz5jX3b26mlF3cKxohn0pDrYw/slSEAJ0uTkhZSfu6j4vrhQv9EUtIIqHwl2AdoM5zRxPJPV6vSNRsYS7jJZ/h8+MH3tNBAjwxGPvP/m9503CoHGTlzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185108; c=relaxed/simple;
	bh=TpgmYTHUKA8+4TfIxSf807HC3XU5Os0OGkCvm3hViqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAmqrfxAzd1tWVQin4UPxnJuO7byM6DuHFg1o/qB6WGLzpZrSP/oT6rKpLyrEKSXGxgdyF/gD9cOaZ3s0b4ZpSqA4qwl+6GV9nxRSu2np38Iu6mOEZrQ5HC/SACwqYKEf+5jzZa/EJI77BCY6LQ1JwqdoJWUckaogCtfgKOcS5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oiDCsSOK; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oiDCsSOK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z45d2eJt6yTbkff6XMdBtOJ/esKuCgIpGs3Pv69dOtixG60o5z/Vvj3ZHX/rclD7bo0Re0W/Z1JKtyjPE99MGGFzH133qPBPlwh3oPq9STm6+NMPMiCV5nfFw/Jejl9Rga8ULN8/bjIjFfXQcLWyIQvf6MOqHntcVdcbRI4UmnhmKf8twmJ7VHRxoZrWb8sr7nWh7WsLCOKlca84JWkMw/wjoVZb3AMFa1oFc3jS3sx75wmqYp0l2PktNZwf1vEfWtYuJUqR7uiClw6zvtqYqW52k214BKwKDi/p/Uqg0Mg5nB2WA8/cIo5KA1wq2VW2vRGZfrzs8xGea9NTNv+OuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37/m7fPAQKE3S0HFT8bhQzuKCaxRXF+KuroF8f7wr1o=;
 b=dG2nDFmsiajN32AWl9MesjbwtCu28Xo9SHEN+gT8XfLdSvzmEh0i48pwCtSreTxKoS7N8KdoouuvgTPBuXv0vUa7cYcTJoZ9vSgMC6r+bM+4qoJxh32DzE1RroT4+zxE/G0OHBE0oMXBJ/4z3VZ2Ve9fNpOfa59eEETx31YfVjOx+Aau6i2RkbavT2oiL2twi/HK5EwrOS1MfsJX39gJ/sVlj45pRDCc8612m3ntNdeSwe8Se7VcgFywCITE0lLWR0Kbg7sruc1BjYmKlrONc6+c8a7+8L7OlkOBG+pir7LWNbL/rO/iJHB2hwsf8TYXko+2G7QDwohqsgyvBy2yQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37/m7fPAQKE3S0HFT8bhQzuKCaxRXF+KuroF8f7wr1o=;
 b=oiDCsSOKTnuMeIQ8iaT3kPcsAWaNzPZuIjvuc+Yz2oVkA/CFKZXUoBSkqS86Jagw+vvU/vNs/ijWBxvN6hkv6MLuQXrPsD7uuwufsWWI3LZtBzp2phut5PJ8bUFjf4q41/dMIl/m0cB7vi91OH14lJ/iu95WhDVuCpgi7ZPxTOcePDigawLCVGwzYSsiLWeaMmhjl9DOZW4BiKAJjwrFEg8XktZQEg1Vn/eVciR9pP6V3l414BY9nkLSpM3zqRnMfSkHp52004VLXzXzgar5DfGd/EYkTG0GYL7RL+Wuy97OtyswwJeO6RUd/XnfKKwZl8Qu8SOM0vGwbRPtCWi8QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:25:02 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:02 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v7 02/11] cxl: Cache decoder settings on PCI devices
Date: Tue, 23 Jun 2026 03:24:44 +0000
Message-ID: <20260623032453.3404772-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9079ff-6bdd-4bb6-bf98-08ded0d7031b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|11063799006|56012099006|22082099003|3023799007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	G87PYiHLIvHmfObRVhEO08si3CSRd6Zfv/5+CLFDCJodZR4Zu1zN9o/ZEpc4ANzLQ3gtTYirRYHUvr1PTXexrJPPmtLMzeVyHF1qP1wX/vmS5E5AwZ3B7gPflNws0tr8pmdZmV1DDGV7s8eNncrb5db2Id/i6L3UOcfF/ZbwZnF+Dcms73b7UYyX1zoGmiSOFkAbc8SUdqi0DM3/EFyhIfopFGfJuBNKR+cD+Hvxx+usa3peiXAgXXxIdZemcJ3+hbYwT81msefQXz2Ka7ixDjOaV0P001GeKEI0v904uG4EK79woyYmSxp7W7zwfRdnNSUbpZIPclHLsazkMl/C38zcaxfD0dlXy7wXATBd/A8PxjqUkAefyF8q+j5dXznwhPJNjM54ENWUNZSvLJENV+UF+khTjUyq5Z7VsKLy8i9R0cqm1ic0xny9IKnQq8x4HSryZVQefnQIzEdSs5a54R8wZvxBweqMrUbsZrrkxmr/iTznMPwGP9eY8ZbPIFHI4iGe8ObaFG3qwqmmoU06yXoRje/tc3je6++xgEhNBeIO5raWnK32RHfx3gEM1zbzvI2KaWZD42mCDaeTXVFAYMklXRZUi5o28UGvjtrLEMnXkESR5yLh4iNVOA7B7fgel4TgltPJYAqWdCfH7pJXr8vqweRmB09unTau9oWHcKoz0y3nuRd/oYgXKcNncUK6jnAUFXpvMUTsA/b5wqp0jw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(3023799007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XPy1XCNcZI5E53qqHuh49obz5sfRdQUaSqaBgJe1YyXC9G3txGz8+mugWzRQ?=
 =?us-ascii?Q?HQC+GGtc6XSd1O3GzOYXvthNl3fH9wuAErsDniP5KrE2h0HeLU3n6HUhFNRs?=
 =?us-ascii?Q?3VAEmNbV//BETw+iw3NM5pULensOxFbHPTx/QviDufSFk7M0R5l2Edyk4Ong?=
 =?us-ascii?Q?Z5am9Z7//kft0e62P1OY5CYHl0lR4kHs8ZU/0OAgRUY2ri6qjUurVKqePkj4?=
 =?us-ascii?Q?7KJn2KR4xZV0MtlzVafEbOODzsgR2oXPX1bi0q0fB4qcWw/wnXBY3YCtKpIR?=
 =?us-ascii?Q?qUBoMY7Q+CJohrRgwB4OHN2l06jzpUN6sYPBHjsey74YV71CXq4Nyo9WzeZB?=
 =?us-ascii?Q?upr8/6n3Ckb8hlknahce+SFSCfO3gZa7IUi10yRc1gH4Ybk3VUmUtXcUkrw8?=
 =?us-ascii?Q?lVl+beKOL6eArPxp7gmanWnbce1V8RJaJrUr2kfURG2AfWRrzuWM7DWSl0cg?=
 =?us-ascii?Q?705C6ZcsK1LGpGZEU7ofWzJpmsuuw5Jpq4YnQEiSAn/LIu/JzpVrLeqSQb1p?=
 =?us-ascii?Q?1Q2/zpz8332P3Au5AtKVlIeRnEleq/MDQnJAay1ODoU32RdqT+TyAkQf6FeX?=
 =?us-ascii?Q?zKdJxnjoqcshZxYSu/smvEqS2BuSILSoEX4L6XpLqNLI3jG89tCPx1r5UETC?=
 =?us-ascii?Q?WmhkBJMSnvfR3/mzPu2XY1UsA/phFt9jy3w6I5/Yum0Jyg93gk0fgp9GMV/b?=
 =?us-ascii?Q?49ykZQS6Ho9p06/9MjF4D0hoYkYbFJuKpAovOvhyO/NNXDbFD6rSy7TL+grz?=
 =?us-ascii?Q?dGyJpwpF/5N/zgn/mdY3qrw5M6P0pKCPpvq8Cxt4JikT6uFnLxehBpaCjt12?=
 =?us-ascii?Q?kBXtdzoIyNUE3OIOhZxXkQ0n3XkYztgLVrEBxMHbpwbC6GR2e87jFJ/17TaJ?=
 =?us-ascii?Q?xsElySvZSw+iH0JvqFz8+rjseZwK6BeaKhBJ3iZxDyPD9xGPYDHPnZZdhNOf?=
 =?us-ascii?Q?P5sjWEw4+LONVCiJGsOCgZMWKslOH4fzbbcDBH2KnxT+nKnambjdtVlc6ue4?=
 =?us-ascii?Q?desbVmSyaqRUrZyQ3lEU6uSuNifq1mPzxbrgpDnJryvxTUp/q6V0GOnSmEYy?=
 =?us-ascii?Q?mE3f/xwx/9sa9NCn36J0xq183xp5Ug+WzZ0ji3BhcJsiorGuZh1HzknuwGzr?=
 =?us-ascii?Q?bSlu3R8yZrz4n5fsIll8T0h6zDcDedMhaobkTU+Ix3nMhYZYTjTBGXpkdtpe?=
 =?us-ascii?Q?CUm8G0eB78CLtjoEyxNpNr4X9Fk2bsQQxjiJ7IKgACVRPQAdAnIq6Q/RjZbD?=
 =?us-ascii?Q?LwsoJyltg0napk3EQPfn51uZTEMBCGseY4uiWKmfivdfKUB12ToISZiK9hOm?=
 =?us-ascii?Q?Y7rzTnOKiuo7Ww0C1THvzeLfG7DxlqlgLL8qx0B5KPDR5s7YJVkuIH6tjxWb?=
 =?us-ascii?Q?FEICdzbd0piPFotVgaIfF8dI2bvJeY4B+U/h/axq1BL0MOEa56DG5BLNaOuN?=
 =?us-ascii?Q?UZCSZPCsGNA4vhFBgZtrNrGhzdp6mO/1ltYJs/M+YAuVzinPvYBvFYCBjkt3?=
 =?us-ascii?Q?NCiypde8d862kz4NisJJbO+FTEZ4HlwlSrd+pljTbVk2cqYcKSfmAemHnKQt?=
 =?us-ascii?Q?cM7+O8tBokqftUslnYv/e4d3dZkDs8nAGW0H/6Dxn0euQhIuSGWXuI2Mabho?=
 =?us-ascii?Q?qLUSkxshdk1lvF18mBmzea4Xtc8tuGFgfb/NX3A9JRj1+kCMWP6QsceMl3Vg?=
 =?us-ascii?Q?VHz0K8QBbNNu3Yb7sogHi8HnebNFlwzLT918VknFQUf2J4nS9s22W2f9RI9Q?=
 =?us-ascii?Q?UPVNtzUS3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9079ff-6bdd-4bb6-bf98-08ded0d7031b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:02.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHieAnCpiUeSV3oMIDTSwG25QSwNnFJxfhrBryWvEyF7hrVdLMZvQPXp7dkE/Q3ykRo+6XtINRNkre0IDFzaiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

Cache CXL core's HDM decoder settings in pci_dev->hdm as decoders are
enumerated, committed, or reset. PCI reset paths can use this snapshot to
restore HDM programming without walking CXL topology during reset recovery.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c | 81 +++++++++++++++++++++++++++++++++++++++++-
 include/cxl/cxl.h      | 12 +++++++
 include/linux/pci.h    |  6 ++++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index fa978c297546..83cda63f76a5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -84,6 +84,76 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
+static void clear_hdm_info(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	WRITE_ONCE(pdev->hdm, NULL);
+}
+
+static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
+{
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev;
+	struct device *uport;
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		uport = cxlmd->dev.parent;
+	} else {
+		uport = port->uport_dev;
+	}
+
+	if (!dev_is_pci(uport))
+		return 0;
+
+	pdev = to_pci_dev(uport);
+	info = devm_kzalloc(&pdev->dev,
+			    struct_size(info, settings, cxlhdm->decoder_count),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->decoder_count = cxlhdm->decoder_count;
+	WRITE_ONCE(pdev->hdm, info);
+
+	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);
+}
+
+static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
+				     struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev;
+	struct device *uport;
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		uport = cxlmd->dev.parent;
+	} else {
+		uport = port->uport_dev;
+	}
+
+	if (!dev_is_pci(uport))
+		return;
+
+	pdev = to_pci_dev(uport);
+	info = READ_ONCE(pdev->hdm);
+	if (!info || cxld->id >= info->decoder_count)
+		return;
+
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		info->settings[cxld->id] = cxld->settings;
+	else
+		info->settings[cxld->id] = (struct cxl_decoder_settings) {
+			.id = cxld->id,
+		};
+}
+
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -747,6 +817,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		return rc;
 	}
 	port->commit_end++;
+	cxl_hdm_info_set_decoder(cxlhdm, cxld);
 
 	return 0;
 }
@@ -819,6 +890,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_info_set_decoder(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -989,6 +1061,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
+		cxld->targets = target_list.value;
 		for (i = 0; i < cxld->interleave_ways; i++)
 			cxld->target_map[i] = target_list.target_id[i];
 
@@ -1062,11 +1135,16 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
 	int i;
 	u64 dpa_base = 0;
+	int rc;
 
 	cxl_settle_decoders(cxlhdm);
 
+	rc = devm_cxl_pci_setup_hdm_info(cxlhdm);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
@@ -1101,6 +1179,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		cxl_hdm_info_set_decoder(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 93d4eba6947a..cc933379f67b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -121,6 +121,18 @@ struct cxl_regs {
 	);
 };
 
+/**
+ * struct cxl_hdm_info - PCI device HDM decoder programming cache
+ * @decoder_count: number of decoder settings entries
+ * @regs: mapped CXL component registers for this HDM decoder block
+ * @settings: cached per-decoder programming state
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	struct cxl_component_regs regs;
+	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
+};
+
 int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 
 struct cxl_reg_map {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..7db2daf8597c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -334,6 +334,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_HDM
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -563,6 +566,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_HDM
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

