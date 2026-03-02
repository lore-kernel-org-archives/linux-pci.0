Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BC3AE1B8;
	Mon,  2 Mar 2026 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483920; cv=fail; b=ELLhNk777KpEdiyDqpdwUJSH9citgPtn6ysy8EQgaaytUSB+HgGIIPH4zOD630ybMCnnwu7pTP/azHQPXHTXj8idNHL0mjtLv+JSghZMntbipBHwgn8jiCA8w2QtkujXjGUkpjLYJdphXku2mBu2U3RJgyljFtKKOamifk7+DmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483920; c=relaxed/simple;
	bh=EmQimVqkWjc5/erub8zxWuFhlY11XGqR++eZPf52uHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CY3YtbZvY4ZiH0hmeE8+KhLg8rSRoS+rIBq7+BExVcza9wszswMSGH4kSd6HLEG9ADT8yXuxqDfYWeilS3lyfLqOoZvNN3S8AlrVh8LqNnEhm607etbQah/Yrz1Ont7HEkde14svnsSlzbM7dbIwKVi3JX0GjTR8W9HcLSKOrxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YsQF4ooR; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YsQF4ooR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aN03PUzgapLP6d0Xs+qSWcIEHan9AYD5wIpsHzquqwBKcUFSSPM112QHZ8bUwmDGlmZWFZ2LM/cPeWOHSYxoBVWLqnfFWO0+ci22lkwFzdZIHCbm+b0wUUPCoVnuBvJCOXt0BriCl8d9/mXDuCIg636eknnIFVIknmjWq9qdkCphvsMjXl7YT2pBoaEcHsOQGOv7c904Leh547GAAODM+FFkhGTKOfMVgZYxHC7g7RITPG0PDmNr4hiUn4cQS9nuX5LbFFVfvxXr7xE9t71Sl21kCBBT4RqX3xIco/H+UDvXO98Iq6Wc2TPmkQ+JyhpB1dgW0pI8TvVatUnG2jrUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiBPAeFIr7vbotZNEoS+zK1N8PrpNx5sJbzz7lyUVtw=;
 b=JsbqzTPAkG9QVINSBxqLbtd8yuTsViKfYf3G1HKrJi3eyLNrAu7u4fHMkGq0AK2Ao1RU/9300NSjjsUURGQQFfeQeekUA1xGL75N0P9AE829Ne0mODN9EngwYKRkB55vxuf/3IIMafq6NMUpB48J+rt467yQZq4q+IJbaQE783cHoAUiTb7jvQ7BayfflDQEjabBwZQ/TjFKx1rUhpuCOkDU3uW6YAiqvJZIE4cjN/ef9kbnTqaFz+gwHmFbdl8ZGiMWzB/UulPwsLhUN++0yFxvqFrbntJRNJNQmwlwUcmIK06zKglHVBIpfecaVvWiWv7Hj2VuRG9qy06tmTa3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiBPAeFIr7vbotZNEoS+zK1N8PrpNx5sJbzz7lyUVtw=;
 b=YsQF4ooRSlHgHAkS0vduVfd+YmkmQdxCuEJShUDgBkvi0nftBaEgeRPI5ij70dKa+12mh+Fuc8WhJlJkWRIauTzSMIjI2sUjeVrnttnjEcT6jG48BBhE7LFC8U4lYRm2vE2DHShJDWROITNzAwbnWRK+zZ/U3yt9ivti/HjI3Yc=
Received: from MN2PR19CA0045.namprd19.prod.outlook.com (2603:10b6:208:19b::22)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 20:38:34 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::36) by MN2PR19CA0045.outlook.office365.com
 (2603:10b6:208:19b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 20:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:38:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:38:33 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v16 09/10] cxl: Remove Endpoint AER correctable handler
Date: Mon, 2 Mar 2026 14:36:47 -0600
Message-ID: <20260302203648.2886956-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302203648.2886956-1-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 53aa7b68-605c-4872-9e8e-08de789bac63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	475ek6giqii/hogjqODJ6XFjOeVX6h4wkwnDES4NGZazFdL9b6J0xGGMZCoIpOvIcGlUDFUqvlyCYsD6yiR/304WvN0Z6m0AHZyqzNMRSsQTwXefR3gYt0fKNMq22a+16+vKmMnlWzZyE0ZVhNbriZDPgETGIsqXmVdxki8AT4VsApSrRwtlftXmvMc0RwJrmLA8oF0Ki8dus283v3zBPsocpomm6cXUJwgBeTle2S9K36i1bw23NakP/i5oeQMNTGylQ+0I+PLXTdY4iQEHjg7wzKrU6oacDRnvvHLm0hIWetwHC26IMMIJ29+IfB0sak6Vvx5yH6aIMcTGsCVw7btC4n6whOiTVxYjnJKUdOefsZNZhDAYBrfEKgvv99qfOdvopmicSv9QdsL43BE6dHHIuub9BNyVya3ZLd5wLlBJWxFEFby+ih18J6zQFjlrsMOKdVfD1WF77ulQET0r/VDHy1EyL2PlAv1QCBOiBqa1UuL9InvpBz7MsX6myOKSOLrbwGK+1fq+SZYHrGhILppcGJlhlCt2ou0ob1DiZ7MaWn1C6Jl5Z1yMeZxpxDnu8bGAh6IcPCFbDGMp9XFnz7UJtz7enfe23lsokU4pIqh3rNMWwaT/4vqfIbsduzHMkjF4uBLtM55YdJTQwIi46mPhbvOKCkpLbdAPYewV29Ns4Rmb2hiUFQ0T29+tyhXdqjaNi20+O+IC1VCHH5LnnRhwPK1T7K4LUrL95LcuWm8tGJpfeQYqE1dCqszC37VLdDNvzY+IMIDWBT7qCdFkFYgGCZOSWSyhfxBrCOU0ZryyuNTCqVsTml8VgkXjSlxePfVUCVNlOC5F5bZ4cdQm2bFAE4NL8w0LmKWGuk8batE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d3s6I9ZUVb/rb2aHcPGocFdHNNf18mluhd5t3W+UdXdA+iKgTyvXYSRmL8N1tAU7CSSnEvgTdfy1bRuO7Chwj0qZZJtzR2s/QF4T/UW+RzG2Y/6u5Uc/WxYlzvE/ktp4WIXKXC3Ju+/bLNGeRf8r/5G3ltLyfl39uXGXoUO+lGzbUprfKIXQbMI/eT4FJQcceBZ+v6ddI1D6fZmb77fDMgRa2k0UGUT2vtCFqoJTFK6VEuvaltePlSwuTpiXegKAp1gmO+VEa+zOfEK8Sr3q2mYRSCLW0P9lL9+heSDqBqGJbkzUCKWjFRlJdsqby4szHgUlABNYqSf+ZW6swfde2nFZjAN0Ojqzps7bs0bAUNQx/pPUs9KeL5wp6jmNm0+zEIjYc121UtT3aI87mia0Z3nemPX6oolqNHzNcz9RNNQsO1NZBkuEOq51sj9d6oev
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:38:34.0212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aa7b68-605c-4872-9e8e-08de789bac63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

CXL drivers dont require a correctable PCI AER handler. Correctable AER
errors reported by CXL devices are logged and cleared in the AER driver.
This makes the correctable AER handler callback in the CXL driver
unnecessary.

Remove cxl_cor_error_detected() and drop the .cor_error_detected callback
from the CXL PCI error handlers.

This consolidates correctable error reporting under the CXL RAS infrastructure
and avoids redundant or conflicting logging with the AER driver.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v15->v16:
- None

Changes in v14->v15:
- Remove cxl_pci_cor_error_detected(). Is not needed. AER is logged
  in the AER driver. (Dan)
- Update commit message (Terry)

Changes in v13->v14:
- New commit
- Change cxl_cor_error_detected() parameter to &pdev->dev device from
  memdev device. (Terry)
- Updated commit message (Terry)
---
 drivers/cxl/core/ras.c | 23 -----------------------
 drivers/cxl/cxlpci.h   |  2 --
 drivers/cxl/pci.c      |  1 -
 3 files changed, 26 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 884e40c66638..d6112b812c82 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -370,29 +370,6 @@ cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	return PCI_ERS_RESULT_PANIC;
 }
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlds->cxlmd->dev;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
-
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(pdev);
-
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
-				   cxlmd->endpoint->regs.ras);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
-
 static bool cxl_uncor_aer_present(struct pci_dev *pdev)
 {
 	struct aer_capability_regs aer_regs;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 86029d96d6bb..184a95e96ea9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -78,13 +78,11 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-void cxl_cor_error_detected(struct pci_dev *pdev);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 					pci_channel_state_t error);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
-static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 						      pci_channel_state_t state)
 {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b57f4727af53..77a2ee57222b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1055,7 +1055,6 @@ static const struct pci_error_handlers pci_error_handlers = {
 	.error_detected	= cxl_pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
-- 
2.34.1

