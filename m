Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2F5304C0;
	Tue, 22 Sep 2026 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066410; cv=fail; b=Gv5vpNKr3WFxNnf6WV5AViRykqm4XMad9Lki+JSaPLfZ8PMeGgQhBp/LFzugC4eJrMfsuSErClqbdKMEBCqmp1QIP3uDP0V+IvK1NFhP2hiJZW/zuQE+EHMzR6AzInTTAKjz0BDe6SG4GM9Nwl8mVHqBX8y2T4+dGPf9gEzNkeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066410; c=relaxed/simple;
	bh=JsHbeMM0suXQMqq1yAX+NN7NJfpREiPsJXJz8xo3aow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ctlDWZxKqfTWGMTtBq1/tyZ4LUUcMNtslHd5ICB0308L1Ae19XWZUsKCdMJucJCzKTdvP7/Hc+dyF0K1NMFw611gqWuTSvH7Lh5rahD1xKtVBDErfQ9Hy1v0m4P5XXpeHziOjf0EJviIpoEPbcVH8wDgVtOY+HpdeSu3sVq4Z/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVXGbz2z; arc=fail smtp.client-ip=52.101.193.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVXGbz2z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFDO2CNqIov28igo7CNyWuRc4xfAr80raP4t8RMHKg9xHUDF18dPmSomU5qiOel5c6ilf59TxNly9f/yPEwHXMeENLy3vg+ATuffmNrgATQeZiam+WP1RdrRb2fAesQ/Iq5pZ4UMh+fAihvzwWvyHJI7cSVdEtY12tHfvdr5o8KYR2wrSZn7a3Y1CfdIISKIb2bW8y5EN44dNufNYb82IVk2/PeVGi8zhJuuUMqtno4fFHowC/u58VwqByi6DtTcHmVNVKR2utrgyUtX0j2FZ7zRww9FjqwCjFAqeF2HsNWBt7W+ApNEIXA2F66AjXA8koAQzWGt6WrgZET845NfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3C97hiOFDRlbK/6K91guJqlUvQTv2h97iio+cYMoOI=;
 b=uyMLwNWD8d2N+k3+CkQnBmyMpb5mGSCeNXxusBDVG43W1S9cAT7xVk8H+DeTrg4PBRoNob0GlwAkCgecUwL6Vn/EDG32WVn1Zcza5Xe0rIDJesG5B5T4XkwY2ySFV0iRJ0Z9n3Jyh/qNrzSNz22oaQI5m+xzLjLuqqovJei2SVreUViz1Tw04gwnXJD+5VxgePDYt9X/Wh46UfwpNPSH8cAOzcYqecKZ6GlNW6q9Q+bLMPy4FWVJ8pZS3FkOAT+yoncnaUlPfDClMJW3aThCtzkTn7/NiWhLlVRQta1JpdLqGrFsWViu+7+iobqWYSOYWBAKCO1ykXVa5ZDmS9LC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3C97hiOFDRlbK/6K91guJqlUvQTv2h97iio+cYMoOI=;
 b=UVXGbz2zISuhK5wdhZ8qKXNO4X2PBlynCWe2k23NEBt9xJL449EQq8/CqrihA7ew1dt/Jh961tTaaxZuD1OVFzqs+ST1Tb/SH92z3spC3sIqRmAaBgao3EnQphOuIz9I6nwXda1plYA9/9q5tKudwwq4LMowdNKiIwqVBUxdn1mDzlIIXxSnnOVL1nP0DKArmhcGbcluoBh4QVhb+tXqBxhn7iRFjMMlqTWADZF16thik1y4yDiwIGFjqKR0xyQJ9L+NWXyA2uWDjppoMZiGzJ0MegnmLTr2mxYbuv/OcYLcbg392hm3bgP4+h7dakj3UR+Fp5e19ffmvQyTSeB+bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA1PR12MB7320.namprd12.prod.outlook.com
 (2603:10b6:806:2b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 08:40:04 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:40:04 +0000
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
Subject: [PATCH v13 15/15] PCI/CXL: Restore CXL state after CXL bus reset
Date: Tue, 22 Sep 2026 08:39:24 +0000
Message-ID: <20260922083924.2451158-16-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:303:83::28) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 3990ca75-dadf-4664-caae-08df1885193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|10067099003|921020|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LEcvhzxUm3Z0ikYhb/j16xwn37vKqr9z8D+d+JgvstbGdI+XBmMiflhd3nUrDdGmu7H+/fmx50bpE5RFQZV9dk0XK4+Sn9z1lKEZWIsV/pDpzxklMqDs6W+9Y0n4uq8zEZafy7oVLhkm6n1ktegR8hofREARi3j5wZ9HPkQtQ87RrC0o6iIxL7VHSR7QTo85jejE5zvfPML2IeaxvFLUSgwntaf5jhcq38B4xiv7hBSsDusmQbhlI67SV195H9+p7Aa5x70anGulEZTyYX5JsNpJmXqghC8xHrwsEUwu5j8jsjZU8n8n+0Eq3YW5mUTf+OKLKit0hnS4OhlWt6beQchlvhD+85ZGk1XT+swSd1/zn/vj0XiucvdljxJr07zqHtrbj1N3D0CJyk9SNYRR/m+m2F4bNP2eEC2S4NyXT+E1Ja/ssaBpS3OZyJPx+djAOaZdxDGIM/2ae7R17yFytpEz6WvQEEGnEXWeF1eU4VVV8nhLlERO/rRmxDQq/39Ig3EHlpy/A3CNd6ZDY6niP94la9Ndu20L1z1OM+yqerJRba1JE8qx5r37rF4N4/CBlV0WeBG3vDBeWoyyWlve8MhCiEUhB2jZLcSd7AEa2OfuzAL/3ZYhqh0iH4XIGpF4+IVE8GBa8M0QBS1XNO97Nfm9DLw3x6y6VJCu3TskRM2yCNDIC4XgCVWM2wa9rBFtKPhaO09uIYyZiOypLx4T+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(10067099003)(921020)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DRqrA6mlgVMy1u6CQjZV+JBfNUQONSn2+vkWqviCSP3SOz59P2Gp9+Y4kbGv?=
 =?us-ascii?Q?Ih1QiFfeHySDMIG7qXZwMPCep6zwN77uCLXww3qOohYXHz6efpWEZgthVkZR?=
 =?us-ascii?Q?nM6WywWr+Yjyk9AAUyoWdcUnp/lf66CqL5mIMnXUvnO5QmjeS2CLBE94MRWw?=
 =?us-ascii?Q?fJrXXDnPyR+sHc3WwRMla8J1gz9XZuGYoW2X6S0F9ezaM4Fps0D+WYeyRBOF?=
 =?us-ascii?Q?VgK6PHkT2DJaJiVEu5uReJshdyUkSYKSRfBExNdQdSqz74wLI2wV/bO6YCky?=
 =?us-ascii?Q?j+CccL1bAO71Fs0M+zt4VXb1fxs4eJk3Asnl2WqlnDTqsrAhsGCBdTQcsaSo?=
 =?us-ascii?Q?WCVOHD1p7q6jwSR2NXCcSX6stauAOhXepIJYAbnaSwpea1i4ZiXNgwd8+GHL?=
 =?us-ascii?Q?Tpodi8z6FMgB2fKdKBtcLWMedA756o4U1Xkqvhw6+arFFhu77DuWPTsJtDys?=
 =?us-ascii?Q?OTTeMTNe7lEPT0mqN1fv6tedCTNv99OkgJTDPTgFJhndzDA77Gf8FeJbkMIE?=
 =?us-ascii?Q?w75LBbFaxLazJS1cxFC6KkT6tBwEHsqYiYDM596KFUUVp4Q7yLyWKAdjLrqG?=
 =?us-ascii?Q?xx+bciqEfR6+xq4Wn9yoiHUZvOqvca906j6FOYt5Ean7jUFNm8kkmllysLAI?=
 =?us-ascii?Q?9P3lWvRNQm5mhCoxJ+Rqzd+plMCf46IM0E/0Lb5/EtA8IdgnzCzztmdfGpH2?=
 =?us-ascii?Q?pgm4mp57J8ROWch2Fe0P2jkVM6GQmdrK/y07USdrSJRyPsaFfJ9pYydb4Iru?=
 =?us-ascii?Q?5RRAUucfPOEYwPpkQvfgfXVZId1igFqY+dtDrj2jrbTUkHC1pJj+OZLM0ERX?=
 =?us-ascii?Q?vpCxNam4YIV55O61IT4bkaUVtDdxYiTzj1G3JvG/MfymbkMLf4wwLnqCqmvn?=
 =?us-ascii?Q?cF/gmSyF7y81s7HMFUHMxpYDQinH4MeWXQGfimp3KAvfPP7+EA103Nigszn7?=
 =?us-ascii?Q?X/h4ziic5ITmxlVk13nqI35jwHcde+lDjdtB3C4M+EmLflAFUyhXWfz3PNdM?=
 =?us-ascii?Q?mH/ENY4iI/sq0BjuYVnydNkXqc5IwxgZlxAoN2BYQnnuZ1dIN0vOH6Fb6JxY?=
 =?us-ascii?Q?8pT6nDu1lxHxb3E616kqd/KRa4CdpgBxtGP4bo4koMYTGtx4DIuEHZM9rNsH?=
 =?us-ascii?Q?KCNiZk4uTIhHhrctXJITOqUQ+SaVJd+cWT+HSQeEdKFbru9mV72a73KgTp0U?=
 =?us-ascii?Q?NHk4kFmS0W7nRe1bmyR4+f33ZxKV4ZC7URPNJ122ihjgCrqBxBkJw+Q5qawt?=
 =?us-ascii?Q?RBuagQEpL4mvx3f6Vd/ZJzQ0z5Euy2WUpS+HP1fxUMAegcqRVg1FOkM9iya/?=
 =?us-ascii?Q?GowMWv+zWs5yL+YgE5k/Q8glZsKFbZ2VJJJ06huOr5XsqM0F2+Lpfm7tkhVr?=
 =?us-ascii?Q?XfjE8DYufb9ZXRwq0N0KjnKJ/8HI260/CwoasljVWnA3Jc4m4FOVjLTSf6k8?=
 =?us-ascii?Q?y8VFTPf6369ngh0yANO+HUaYd+4mYZ5/9sgNFJUnUO5TdyNU2tlkLCP70LcI?=
 =?us-ascii?Q?EKHYMQDGHVPSBEtmTglZ26Jtv5CxjlkgwQTEQx1aa9/arG1WtEet1t/GMpwU?=
 =?us-ascii?Q?gMZWnuxtV/cX6PXLey+rwilpBBVOc8O00Flqpf7/akAyrosCLZEkKYDQj9jU?=
 =?us-ascii?Q?FJfu0M/DEoOXqSX2kK0mNsBFjJ88XqaOdCItxnqbR0Ab6PQ4B+3rW8Y/RqcK?=
 =?us-ascii?Q?6j4XpCwk+tDbThvs9552ni5ex4KZYFIvrrMAW5khUSqPQhGCI9dgDfqz5R+Y?=
 =?us-ascii?Q?WSBzkcV8pA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3990ca75-dadf-4664-caae-08df1885193f
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:40:04.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4bhTtjUNjP57O4chy0BsIQpsqQlBOpADOtxA0Lq+jz7zEeAt2KpMPFa3kzD3Y71Yx4nln2lW6uHaNCX8T82Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320

CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
control state. Restore the cached state after a successful cxl_bus reset
while IOMMU exclusion remains active.

Restore PCI configuration first so HDM MMIO is accessible, and preserve a
disabled state if restoration fails.

Tested-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 23 +++++++++++++++++++++--
 drivers/pci/pci.c           |  8 ++++++++
 include/cxl/cxl.h           | 17 +++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 6bf503e498e1..0af0f96d5526 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -601,12 +601,12 @@ static int cxl_restore_hdm_decoder(struct pci_dev *pdev, void __iomem *hdm,
 	return 0;
 }
 
-static int cxl_snapshot_hdm(struct pci_dev *pdev,
-			    struct cxl_hdm_info **snapshot)
+int cxl_snapshot_hdm(struct pci_dev *pdev, struct cxl_hdm_info **snapshot)
 {
 	struct cxl_hdm_info *info;
 	size_t size;
 
+	device_lock_assert(&pdev->dev);
 	guard(rwsem_read)(&cxl_rwsem.dpa);
 	info = pdev->hdm;
 	if (!info)
@@ -762,6 +762,25 @@ static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
 	return rc;
 }
 
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot)
+{
+	u16 command;
+	int rc;
+
+	device_lock_assert(&pdev->dev);
+	guard(rwsem_write)(&cxl_rwsem.region);
+
+	cxl_restore_pci_state_for_hdm_restore(pdev, &command);
+	rc = cxl_restore_state(pdev, snapshot);
+	if (rc) {
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	return cxl_reset_save_restored_state(pdev, command);
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dc57a202c91f..6928c99aa785 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5015,6 +5015,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
+	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
 	struct pci_dev *bridge;
 	u16 dvsec, reg, val;
 	int rc;
@@ -5037,6 +5038,10 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
+	rc = cxl_snapshot_hdm(dev, &snapshot);
+	if (rc && rc != -ENXIO)
+		return rc;
+
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
@@ -5057,6 +5062,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	if (!rc && snapshot)
+		rc = cxl_restore_state_after_pci_reset(dev, snapshot);
+
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index a07dbf7463c0..2ff5bb117942 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -202,6 +202,9 @@ struct cxl_register_map {
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+int cxl_snapshot_hdm(struct pci_dev *pdev, struct cxl_hdm_info **snapshot);
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
@@ -212,6 +215,20 @@ static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 {
 }
 
+static inline int cxl_snapshot_hdm(struct pci_dev *pdev,
+				   struct cxl_hdm_info **snapshot)
+{
+	*snapshot = NULL;
+	return -ENXIO;
+}
+
+static inline int
+cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				  struct cxl_hdm_info *snapshot)
+{
+	return 0;
+}
+
 static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
-- 
2.43.0

