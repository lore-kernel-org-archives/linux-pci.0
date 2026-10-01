Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748BB51474F;
	Thu,  1 Oct 2026 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846604; cv=fail; b=KIZVm/rLk6swEIaise8CtIWewODPdTFBhwar5ZDC49gfs2Zet8fEVNzH1asSWQA47fb/uZZxs6vdIuZ7stR7rsXssE5xrQj9txx8tIko/90ZswDhhHgYS52og2lDpz+aVSe0febkv8fLy4L6ZlPiS2n1MPZ7ZWxJURrjacXahFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846604; c=relaxed/simple;
	bh=OJm7nGKG5aulv5UxiwsnQT5XxWLksdukQcbaVuUWTtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jERpiO+HlE/d8trM4/sp61durfOZRkraR3w0C93hkXIQA96sA+tR4JjrPaVb5VdgvsBP1taSQYesGyGub8g/1mY6SPNiIfGTZHGlVwzt73yn40nebPjhxCC/VAoxWGwXT9RiLNpC0bkyr3HqNsidVfE1wYXIV16o/TGQqZR81vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gapPbNs2; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gapPbNs2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdWd76LQuaA3vpYY0AHNf6yKE4ivA+JkAuT7koOY5vNFkdRGHpnJUAMAKdf0cKrXH+633eze4ydCf6pdpxXFkYdTIBkYWm0JHtvnBvxQoh3w6ACmuzK+M+2+oBihG/v0XKYZL6uMzs367q45NUgiE2YD7+K9z7IStO1YpP5K3dYtTcjl1ybLw5UO/fAUe1LFJkATamdd6gZyW5g+wh573eiSl2f/sHaHJTH0KSfTSHWug4mBvcFFx9EpdRgLlknNDT/aaypR3frT46LBAmw5TFSSeBbBVuF9kXJqrNQBIrstR3Us/UPwgszH8sMaJMCNAgIBpMhrVS3AKWbIz8ROZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnlT1IiM8EAgbf5chIPKugA3EOojrTKJHOYe2Povhro=;
 b=Sv9aa2LWhbEbpG+a59m0WQknnx9ssGc27OE9tpct/YOE3UunnxlHQ8gte4zeGWgAVEps1FXx9vcBkSyG0ME+gpLrFnJxX0GPNKFUPA3PRwv3u32ptDn7h2n2019zK+x82EXN6yAY7U9jy9kAdLllSBJbALsGzBAFNHG39/94cxmtFzfBSAO9vtPImmq4XVT7vTsRl9rp+C7WlHhuyo4YriCCocHAVFfOND7O/w7NqP3c99SuKwbgbcQEtg90Gi8kYES0tqFiLuSSdGgNvSPQb+YRZpIMXlbRhYpZxBaZbxqZeeUd+efIsDRbVCdgSpegrxKVjITwPMadJ5gJX1GgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnlT1IiM8EAgbf5chIPKugA3EOojrTKJHOYe2Povhro=;
 b=gapPbNs2hoBAsHngUZdKo+dE6qLRqTjXk833UBBT012H3ZU09ZCeGbyI0qeGWr5FDFty2DAu1t7q1s22p8oMchVCeW9ki6dfdhv2VTW4cIZ2ZwEVGRLxxq5Ng2sniNkcGc7pgguxYbF/66Uoe7ZWKPttdlIB7vLxpfgB/e9kOh4kn2w9IwhMEimAepzBCKfTw4T8scDHLcdDCZGqXdKXLhalEzBqNQAHCFvxlKojqf4mPc/SvWJrkSMM5yXeArdXc209E2iRhgNcWzHIMB+ZFO1vmBNhkzK5Dfegc55iqXnK7VduFAyHp26ncfdfqOQyxWhqPB5OmFJ75CgrIkIm4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:23:17 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:23:17 +0000
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
Subject: [PATCH v14 16/16] PCI/CXL: Restore CXL state after CXL bus reset
Date: Thu,  1 Oct 2026 09:22:27 +0000
Message-ID: <20261001092227.3004747-17-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::15) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: c846fa87-84c7-41ca-2232-08df1f9da090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	69C0J6K0hBmq94WFOJT0VH9jkxxwTwFduUU8RS6aNxDeX3fj3MfPatLjfhJqF1TOy3Eeblr/aF9lULsD9ie5Rrot7fBfEigERALgGR+5VAUkSnRmAHMU/Yw4S5IBrBKiGv5XH+QA80nJRleLDoo5rkMNAIZ0eJuayUTw/GMZ+dT0FaQ+d4fgXVPYkpPMkMoPGMlpXx4KBdvdu+/wwdnUdn3FZgiyFCn/rquFI8OtB6AH9MqlZ5qujC066ZZthhgo47fOeFOGVBehnjee9twdixwzHkoqRqFLu7dfLbJ6y4wrF+YERFUuBGYcxqLOY43myC26r/748x6CUEcKNed50t1+T7epPZ/piMydd4Bibk8lpNWf3BMnzRRfSw+17MAITVo4sNGL5QNBOHLXZg2OTmEns+A6w9Kl99tzaFNYAGctD/xAW/L382MpPndyJUtLxd+qXeLG8RDtaA2QJmWqPzHfFsS10bDZXgB3/maMMbZd6avVVuwb09XQWOTujBv3ggG/vGezCRNT2PH7PaZM+Aynu4bY6lX4bbe74MnTHY3H2qUl+oLFf3EKjZRtLE7hb67DXjLVZGRYLf27R9EeYO6UwsEMrMByfywrn8tBFsUaLva+hvF9oIh85fzm58U2QcEbnQEIGBfksWHnXlLDFBHAu4E+9yOzQuatHYEA2qrDDA+d66DVdkGBZmK6UBEH61o7NMEZbHEGXdHdNOSmpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Y4Xz1hYjksR8bsjYEnkA1CxZKQ12iHj+6cFJ1CejxyMy4N+4uSSvcXm49Z+?=
 =?us-ascii?Q?/PAWFQziVdLCCRHCI7SjcN75u0HVWdGA73zC2tVwgz/vyif5Dq+/iBtdruKz?=
 =?us-ascii?Q?6fTb8uVx4VhFWXpiCvTwbOQ9Nwb+vVY3G5eFZvbZyG+S2dgUj7/V1oBjivLJ?=
 =?us-ascii?Q?HzFv9r3Y+/cThv1PF7ARrhOjIImvZYFVTK5lnU36M0bOIL++ixKb4hDwPD4k?=
 =?us-ascii?Q?EDaG8MUNoXSCmoiNvXeu4LqQFz+zmjJZDPDWtWS3arvtF8bNNjXbg9JdvkFC?=
 =?us-ascii?Q?SxH5bh0akCAK3o0TRZN15d0M9QPLgw7nFW9Gc+pugTzbjePRUECsL7/drRy4?=
 =?us-ascii?Q?tAzgKYMOdATdnALYIDg4uk7h464ggnKP0ZZLB3XFAyxa67SauTBg7Yb//0jb?=
 =?us-ascii?Q?BcSxr6kGbCIXgNJPAjbFBwIYDxEwpZOqbSaVLj5hGa/otOVFDhdgAcKlbo6F?=
 =?us-ascii?Q?3Lo51i3b9WjmViwG3vMEX1Q3swGcXF02JbVOgyE71umbB1NsggR4OKetmsGq?=
 =?us-ascii?Q?G3sBfX5h07UreB496m3tqRI4yd2MX6ARO31mSJ/vROwpmEYw/lLQ3xqt0/ip?=
 =?us-ascii?Q?6uR2VCU+TszYybIhniFZJquoF2gUHQ1D6ojoTfkUPe/rzznIDqukD8bC9SSb?=
 =?us-ascii?Q?MPGD9vvDUpg4XxF2Wb9sgFicYbVy/+g0gssmTHTfR8CJTfPR+Jou9D9IrP45?=
 =?us-ascii?Q?7BbdrJw53WnwmW+H45harXCCzUKK1QHO3wm4x6kg+rL0zrthTZjmA2WYpX7e?=
 =?us-ascii?Q?S9/7DiRSyc/gUW5big505DJ9hZ2jgss7NbVaWtVuLBQeBMkOlWQQ49kYOKrw?=
 =?us-ascii?Q?XH/mUZNn7CI4LzawztWKfnAdglCBqXziPmtb5j56OL6W9Kw2dIhGy+wixqJ7?=
 =?us-ascii?Q?DihFKDP1ohWaB+5hTzb/ZKOFcm4mMr4PM5T5SDKD8/yEXMvPOrN5a2egY0SN?=
 =?us-ascii?Q?GvJ4hpK4Xn2nwBh67G2DyfgfNj78Wu6l9D8I0+DGB7nCspgua3B8DfrumLl5?=
 =?us-ascii?Q?MZqaAYmLZhpCjYWVWFo8uy2yA1behTpRVKJlGLQ15VRUME3SdbI+yqh0UpSu?=
 =?us-ascii?Q?giC5ufoVV1ItiCvK8PEvytFbl6dc33sDYXXBNbaIe4Y/3pXQKV0WZZuHgACs?=
 =?us-ascii?Q?fOitNik8QndBB0BQ/LZu3OB7kr0vWgNkdvIjd9DfCGZ8acTzKCHYfv9abY3E?=
 =?us-ascii?Q?fyjgQ8T/mshLprNjK65b4GuiKDzhVCGEVhPtxIbq7XCHCTxVJGVd/qwC4FTS?=
 =?us-ascii?Q?HvfmqqqnLt9yCXD/26WhZJRKKkgVT/Trx1tQWdeBFSpkf/kL3CZF880j4I20?=
 =?us-ascii?Q?ZYKPWrcmkXVZsRMjWq6kvDiyY5tymdHoE0DusJzbGNfgXx+G3efpXkVDO7Ah?=
 =?us-ascii?Q?6d2lmSiZhG8737FuXue5a41+5U2qBkkp4gfS395QfwnCkbyHm8eJdI5ha7DU?=
 =?us-ascii?Q?sjoDa9w11FwFZJE+bXkc9S/M1gWaXqBe0Wmps4p7RcpUogLWcB2uS1nvH5fo?=
 =?us-ascii?Q?hBmWuzCz5xfP/9gYq8Im6WWNkrY4qi+bE99XOO22gZ7I3OmeRy2mo2iKxFlv?=
 =?us-ascii?Q?UGdBU9s4BKp5Zz7gk4M/eAQcAftUC/bjHYAssUY8kfo31yHxmw3WEd80788L?=
 =?us-ascii?Q?LS/mw4VdLB2s4595t0rrNff+AMM/2XaiY9fUXWjkT1iNLnhvpLXojdzW+RmG?=
 =?us-ascii?Q?z6nAyn2KitV5eOqcxF4MwobeZFeNNzrZyBdym55JlSy5OPsHAPOx/DoKQouT?=
 =?us-ascii?Q?BhYYkRF9vg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c846fa87-84c7-41ca-2232-08df1f9da090
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:23:17.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE9DUTWyx6McFJvgoMsP7PBm4WfRsVL1v4W8trWI/sOyPMv4DZr8g7ZybmbStHmakAmvNn5oMw6P0az9NXsF0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

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
index efbab341b30f..3422139ae3ab 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -625,12 +625,12 @@ static int cxl_restore_hdm_decoder(struct pci_dev *pdev, void __iomem *hdm,
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
@@ -798,6 +798,25 @@ static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
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
index 9904eaed5af1..b83cfaed618f 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -207,6 +207,9 @@ struct cxl_register_map {
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+int cxl_snapshot_hdm(struct pci_dev *pdev, struct cxl_hdm_info **snapshot);
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
@@ -217,6 +220,20 @@ static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
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

