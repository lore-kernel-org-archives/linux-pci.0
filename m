Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4084EFFCD;
	Thu,  1 Oct 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846587; cv=fail; b=XAW7fO6Hu0pQXhXdhzlSIj39VHqBh5IzRO2uateEDoSwK+gDMR1EoSGo6B+M+91nH9CNlWbMuUDKAu5xKSQ2dwVf1TrH+Nhbx/kzHZFp1WhkZCE9E4XacJbodHSw/EAJr+vyfSqLD+sGcn+LmpkOyTM4wAB26e1MchsXmt2RIlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846587; c=relaxed/simple;
	bh=ZPaXTWC67c58GNz/CR9xO0jg3R39v8SPKy1LQPaF3pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emNYf/rG5z3epew50QrLq/0vgFMXeykDxE6sniXm8N2MaaJY3pjKp3ZxPWOG8ybPV0me8TCOR/SQhhPFu9gGPaFTgOjVELrfAKj6pE0jkF+3WkNqw3H+wBNqMJs8PsjmB/54CMX6rWMuDRi+KfQj5ByVK2F0LGlGGu/z5F1ijwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFItwE9Q; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFItwE9Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXZpd5QgYgkpw0sYGZUwyCrbvMo034a6pSRZyrgCidy109SEQBT013WHKoVAgQ4pzWxxoiCaQjppQ0i6EdYkwBa5AIfIQRnNSgNIbhCwsPiBzrqhJO+DCNIFYNOPYzF4c+qw2d8bd45+JnWJF9vpoMIgtyVTLppcL5lQgNYenzChrjK1+PYaIUvahOKHHVtKrqqpMwZFL0eBzR2n2zN0N48QoNeF+bHueK91j0NwwTfAFC1Kys+R1mJvkoh0GM2cDlMlEcch7jUd32sVRL48yp1G0XVXisUjbzFalTPkNfw9WnLRJISUSDlo+Ht0RY819Vp9xivGnpcpvSc1927ORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbpoPyvc1ht4HjLnoWCyQzlh8clbU6m5N11qbgDR47A=;
 b=tsQf5Gu/+rNEuZJs/k0n7PVt5+QOMGMBNCTzUTvDCS7BwldUYJG/VhVTUGqHZp+NoJzoix4qWeSJZZtEADo+EJRnp1hJ4uhKb8ABqP0PSAz/2jw/93u3ibOBtjSZ/SB5F5OONbUWQOCzxzN5qbH84YDy6eZ+YE5miw/Mi69Lf+BAId4Ai8lUOdL0jYkwSauk5WB5kaz71rXl1GrTe2urW2b/168q9aahyMn+cc3ncmsoZNF6KPgvhSWL+jwL3IQdOHpgMLdGhgFzGJv9TFsk3axCgSZeyD3IcMEfqYmDGiZXJcSJRwV58kIU94puWwPdKV4AONEPYeSr9TnLgF+DBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbpoPyvc1ht4HjLnoWCyQzlh8clbU6m5N11qbgDR47A=;
 b=UFItwE9QehuGxaeUv9flwqIT09gh8CC6oC2Yr1St77a1mXJ+pE9dWlsrKRGn6Ok55IZ1JVE/Y8icAEfDaaSqv217w4I0LdxO2nBoAIECRbl34BcqG+oe0tb6C+qiiKQKO2JWBM64LS9FXUGpLqGXiciUFvMveme3FZ1xTWf564nQ7d/i4dwNIiQEHjyOa7aecr+1LnoqheFDPsoZk/MdrEE5yb8jzVzzcxHQcvvHM/ObuQUtCpSj+3Q406TDdw/bKV1nYpdeqWcILbpSicoxyD/vsi7VZa/jcS1q12kWZtn5qisg11/sz105udG1M8Y1eCp/taWzV6FV66RWMcnXYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:22:57 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:22:57 +0000
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
Subject: [PATCH v14 09/16] cxl: Refresh cached PCI HDM decoder settings
Date: Thu,  1 Oct 2026 09:22:20 +0000
Message-ID: <20261001092227.3004747-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 0458d7d8-fa9f-4022-bf77-08df1f9d9497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|921020|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KRZeXXECuFJge3ea8bNHRrHySSRrKSN1DwoBDhQca4ORw4oPZCWjdTzgGet1VbKUEWa1jAGPi7rwdIK72WhtZ0guYgUt51D7EBKnC6KIHARlbkVWvvJaQjAYE3jUtL9JS+Fabl4COXYzSWUZqhVW98cQrQXK/9vFURMl5r0MNG0/HPslwqa1kz/oMyFIpYNVaKZ51SZBog2U75LDbgF/snbbU9Q1NAigrINzRG0Twt1IA1msLpB5PV0TETUHvN9ZMGV+Kl6ElzS7lKKhjtSf9uHZEfCyAe4n0JFnGLTERmDuEB9+LM1BbV4UtuBGWnZlbDO4/qZSq0wRbCyGpsutmVyu2n4aplF2/lsMQgqdTSG8bhZQGo3Ar9005EjloutMGEYl8Vjv5qbScThFpDqHPkadFJP0gQcqxlJ/uJaXXNM1/TfJSFb4rGdD7SZe6ZEZcv3GFxfctQIPTnS0jWTJx11kvxHeDpBCvOjmjicbZIsOFV49ptFyQIZ+qmYE2KDaMeSu2jpUuhgDcWkPmnlCvSgZCDerX+O/k43gW3evCLVd88g35YSff8LkcUX+UcI3pCJBxcNZ8VAT2zGJCzCOonaqxT7IOGxrbw7K43zgebwYV88WUb/H1Jr+CS+argJNNVAgx22kvc5qw3r9LKue0oPmumFcQ9RTKw8u2Om9JKMv4yUdKcoP+Si3h2yi6aKbg25eASQbdoDNMPA+YO39VA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(921020)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/wZ/bH2QagaB5kJMRWnnsDgZyFx73UhFZESvTi98WkuuzwoCtyOUmXvuhlHi?=
 =?us-ascii?Q?9zQKka0YLJ4+66XE4qdlmKvCMC/lwVsW01aVwF9Kml+JbLygPud4v/nLbpIA?=
 =?us-ascii?Q?GAiPr7w1df+W46DMnuJgEoWD5mvxJAo/6ZVRRG6++t5gAgOeuM36Q02Tl1Vr?=
 =?us-ascii?Q?StcVhR0e8xkElNmCKtub2HndFtMTx6cRdI91ll9XZNxFfmYkDQ7iEEMhtacw?=
 =?us-ascii?Q?tvDBiAESN5ifGvlIyRwdyXRq0WlK1R/zsUkLLVq910wBsJMkjGOr0ZXuaE5Z?=
 =?us-ascii?Q?g2y5Qbi0vvUQd69GZEzer4Yzjw+JYawJEk+Fh6FlmmqwCdkACDz+cC74c2DC?=
 =?us-ascii?Q?HJ2ICzi2vdaLBDgf0JTGHaEy6MJMCqNBANLtCwwc/X2ah/SR154MmPJXl5lW?=
 =?us-ascii?Q?O2wGJbz5SYoLlse04uO7TRSA7b9dmm02RuY1iH9BURGwHjAb/MxoXANMaiGj?=
 =?us-ascii?Q?x4jmzhQ742PSj70wELZSPbVvFoKEpqA3vyTfPkVu6B1s64ybOSFmrRLjBPvU?=
 =?us-ascii?Q?Tk3U1vrYoGYXQHfhu8/hX2y/hhMGk2Px/EP1nRUaSFy88VAI0m5eTEUb7/ns?=
 =?us-ascii?Q?z05nWjb3Kefgz8ChbVPhYEdPe/DTi1UI7z3Oi0bLx3PKv2MZ6kQ/6Sr0cYoz?=
 =?us-ascii?Q?wlQ1VP1uvQKHmRtY/sESbXzB9Q5KxDYGHOw+pGIp4iL7rpeyoNGpmQrQamqB?=
 =?us-ascii?Q?jvZRKTdL9EcvQcXwNDqF+946Xkw/Z0T123ITYB5TVx93YlQhaL6uIgkzs2Za?=
 =?us-ascii?Q?tnFHoOgvK3zeZmClWsKACB/tK7CUFD+ScYwE4xFTYLGCPRKOx1tzaUteq+j7?=
 =?us-ascii?Q?UOW1H2AS1vsZVrQ/yDXD9GhorCCFKTMVwwzjKgii6NkqLxZNwqrbAWvK3qpZ?=
 =?us-ascii?Q?mNKv/cFXk9AS+QCmZNvhzSgfgX+uvP4cha5dr/IPL2eaXSrsiDj4KbtnD55h?=
 =?us-ascii?Q?4pQSGlu/WwrH5D5ljFmYikNaW83qmFo6tzBQB1BnVs2qVVSVkdNF+HRJZGFn?=
 =?us-ascii?Q?ES3QbuoWDTgNMZeyDBugCUpb5e/w2Rsd5Elj3erRd3clfJKempwhEHT2tJRF?=
 =?us-ascii?Q?QF6WVXlLLvIQ0rCIomgLezwtVEGABOrPhSbTGVqA0aD9Y+WoQdBo1wl1iPX1?=
 =?us-ascii?Q?1Vqb6Sp5CBuafx+VVKVCSGCfaRtTiJmqsuSQYOyiNzLACi0O7G4S9j+Xlb2R?=
 =?us-ascii?Q?flusd6OM4v37Q76vgdB5f4V57GEE0gkUzYnWLCBuVGcTAUX0RBYdEP5GAxyG?=
 =?us-ascii?Q?qPKM0vKGdOByDuHs7jO2oVxiojZR98lzaHNjpE92gORaIK2F8izjn37uqlD9?=
 =?us-ascii?Q?oIp5BOmVCU2N3qIAw3eoOmZpk9/DbAydA0GEuzPtEMH4s65F+sp+4Ld+UJqM?=
 =?us-ascii?Q?zmpcUdF0+gy40IbDOCxT4l+/8+iT27GtUNeE7Uy4bkTIHkYfJLJYMP1bCkx4?=
 =?us-ascii?Q?Nsxyjd4RdDy1XHu5ultZL81fyoFtUFYAvfvtSdco+9VsQsEcz39WkjlVFGwK?=
 =?us-ascii?Q?7eu5Tace/67XYWCNvNEIPrdBEG/Skg6hZBorgs6MLFrJIchFDfoc5txHfSAc?=
 =?us-ascii?Q?ys4FeOFarBBG7ByYhocWFSzSL/xEorKbW07qftMBaXFUbMR/QaEkybX9rKU4?=
 =?us-ascii?Q?mgT/+8zfjFX5Wpk1zIYjdL5KGAPIkve6tV75XOIOLKuWiseyIXXYyOlApZXu?=
 =?us-ascii?Q?Mf6ak10Qu2e2Sbm5XA2Qxyg7BYwPzsgwtfg9Rjfg5AHSFPHS45u4O2gL1ely?=
 =?us-ascii?Q?J/GymoZHHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0458d7d8-fa9f-4022-bf77-08df1f9d9497
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:22:57.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOMC2UzpHM6tITfs7kuyZCo2tdRsuNCnKMjUETFZFizxCQd/bWiWmuDXLkuNynC0c0ieVNCs0g6LnCshulL2jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

Early PCI discovery creates the HDM cache, while later CXL enumeration and
decoder operations provide updated programming state.

Refresh the PCI snapshot when decoders are enumerated, committed, or reset
so reset recovery need not walk the CXL topology. Ignore updates when no
cache exists and reject decoder-count mismatches.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      | 22 ++++++++++++++++
 include/linux/pci.h    |  6 +++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b6a8fe83d336..d6b3afbffa3e 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -753,6 +753,44 @@ static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
 	}
 }
 
+static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
+				    struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = cxlhdm->port;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_decoder_settings *settings;
+	struct cxl_hdm_info *info;
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(port);
+
+	if (!pdev || !hdm)
+		return;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info)
+		return;
+	if (cxld->config.id < 0 || cxld->config.id >= info->decoder_count) {
+		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
+			 cxld->config.id, info->decoder_count);
+		return;
+	}
+
+	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	settings = &info->settings[cxld->config.id];
+
+	/*
+	 * A disabled decoder's software object may retain its old range and
+	 * target state. Leave only the decoder id in the cached settings so stale
+	 * state is not restored as an enabled decode.
+	 */
+	*settings = (struct cxl_decoder_settings) {
+		.config.id = cxld->config.id,
+	};
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE)
+		cxl_decoder_snapshot(cxld, settings);
+}
+
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
@@ -804,6 +842,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 	port->commit_end++;
 	cxld->config.flags |= CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	return 0;
 }
@@ -876,6 +915,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1086,6 +1126,23 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	int i;
 	u64 dpa_base = 0;
 
+	if (is_cxl_endpoint(port) && hdm) {
+		struct pci_dev *pdev __free(pci_dev_put) =
+			cxl_port_get_uport_pci_dev(port);
+
+		if (pdev) {
+			guard(rwsem_read)(&cxl_rwsem.dpa);
+
+			if (pdev->hdm &&
+			    pdev->hdm->decoder_count != cxlhdm->decoder_count) {
+				pci_warn(pdev,
+					 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
+					 pdev->hdm->decoder_count, cxlhdm->decoder_count);
+				return -ENXIO;
+			}
+		}
+	}
+
 	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
@@ -1124,6 +1181,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		cxl_hdm_refresh_decoder(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 67c81be47fbb..e200c5c56b92 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -82,6 +82,28 @@ struct cxl_decoder_settings {
 	u64 target_or_skip_reg_val;
 };
 
+/**
+ * struct cxl_hdm_info - cached CXL HDM state for a PCI device
+ * @decoder_count: number of entries in @settings
+ * @hdm_bar: PCI BAR containing the HDM decoder capability
+ * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
+ * @hdm_size: size of the HDM decoder register block
+ * @global_ctrl: HDM decoder global control register
+ * @dvsec_ctrl: CXL DVSEC control register
+ * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
+ * @settings: per-decoder programming state
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	int hdm_bar;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	u32 global_ctrl;
+	u16 dvsec_ctrl;
+	bool dvsec_ctrl_valid;
+	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
+};
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..7bb37fcb556d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_RESET
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -566,6 +569,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_RESET
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

