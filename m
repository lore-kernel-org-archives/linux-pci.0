Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120031;
	b=jQ5jFrPmzfSMnxl7QEgrv9R7MJV5FDhYigkxTmliSRB8F052Td666vrW+yz/CkKsQLPA
	 FGVL5h2GR1eQ8iOxzJfdIRm8l5QpM29dfe+rhsIvLCck51Oz4he1zp98QrQrpeUTTM6Sc
	 1+UOUVuadZ1j/a2pnAvGGGsbvfjaOp751BpU7wneONsgPmP+q7RBIZuMUcCKy3SFUGwLo
	 BS1eSpcQBLY/6BoloyrVosKaHzZHSZ2opzfJpWK/uteN5VW89AeqaBob8DDA81GH099nn
	 7ygGzeIJ7Y9H4Ph5Qgd395F6zeYNdfPlOs6iMu/dSWDhB9uFoqWvnRibBF0unMKRNWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120031;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EmUxJcNUvoh8hzcCzgRcBQZ0OYeb/ntg+3wNvGPRhLs=;
	b=U0Obo7CyFaKtj4g5B4LeGl7NlErarev1F7A8itDnKN8eZseH0q3a01nwirBbRYm5/IoH
	 pkliiV84/U7t10TG1OWB0XtGU7Q8IuMVWEyqYbQi/Ev18axQ9d+8wf8/PAMkVjBqhQJ8u
	 Z/F358uRqXBpVQSYtLSKRpOr/CUm65hG3xdAW3iVMzS8zKgZzlGYVEOmWJ83anQKfB1np
	 Pses2kwPw4b52mDBfO1lkvekUET0qxPVal53qOuEUh3lqabXSplqcB4cWRPM8QNL2fD4e
	 4mSqC/1c4xq58e4P0Ie2Ia16Ms+ssyG8rpSpEJek+sMCWGGwJkj5rFH9KzdjWGW0nPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hfbWRu1C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.15
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17EB606A332;
	Thu, 19 Nov 2026 20:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F17EB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hfbWRu1C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDjD3t0MRfvx2ALTsGVGMeKuYUccVhak7dGIbrrlMHXqGjEWuI34vrHVucwKxo1AMnpub3jcFbZ8F1TxbuutFMLZuLFJ/VMQTkuKPhp27BpLTG549NfCARyiFlcsQdy3USAQgQ611NdFOM3v6gkYx9i3vf6WqYLya6M/W60MF44D7fNpqcAldIQZqOHo2CbNNQWbEYOYOk6WMK2jdd2C+kfF+BE8Vnwy/4VNzQpspetyjBXUzWTeAvrDX6xy//Z/mlpO7QUerE6zUarm8KAdumudt+C+quLsE010bQiIbUyeYhteNeFwA2e7JMikOkXt69/QzR43zYX1SRrmIiD4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmUxJcNUvoh8hzcCzgRcBQZ0OYeb/ntg+3wNvGPRhLs=;
 b=r2DqOo/+PYEPWMQIxIm9nb7jBq0dDRkl6VXQlL/9YaVLNVroTitdEKn8YjMV7iAo68ceAYM1BvQb/uiVBXSQZY4IpzBI1Jd/n2DjLtFiBXBH1c4lvgmv1AsTBLtAFw+UfusKtLy512/Y6nMEHpD2GO8iK5ivPz0UYVO5ha4SIMMXN42GIx3tIUd/oRcoQgU7cmGTAUQV3qRj1FkppIEGQWyTcqFZe4eunaPzzXTBUfC7EPhpFf0SGFd0Bj8DFIQ1V9464FrtluHyoiY3Yhusa2zuJP7IB3AjQyUJPmCC/0PluSRRfhonFckbaRmBZ24/L8L/WQEDwrjAAncxQZuTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmUxJcNUvoh8hzcCzgRcBQZ0OYeb/ntg+3wNvGPRhLs=;
 b=hfbWRu1CWMP/C2eKylG8+/fs88v7rlcO9rqIb7OVdJZk7axW5DAJpGq+Jq+zk6SCAShGyN0gycOAHwFE5AWNQ9mrRXRfuwCZ7HfmWBibXFG+gNvzgrk53cXK0gVFnUgthsbeHoORLv4f4+ddpwVwzICZ5CRzXIIdwV7T7kMzE8Y=
Received: from CH0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:610:cc::10)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 20:27:03 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com (2603:10b6:610:cc::4)
 by CH0PR03CA0065.outlook.office365.com (2603:10b6:610:cc::10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13
 via Frontend Transport; Thu, 19 Nov 2026 20:27:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:27:03 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:27:01 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 18/44] dmaengine: sdxi: implement userspace context file operations
Date: Thu, 19 Nov 2026 14:22:54 -0600
Message-ID: <20261119202321.1734355-19-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dedefd4-55c5-402c-538e-08df467b7908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|7416014|1800799024|22082099003|18002099003|6133799003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|261009220027099003|11063799006|56012099006|261021123027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261022105027099003|261021121427099003|261022113327099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BdQ8eHPKvxewtHUGhJ6kiks4lSySNv/l3I+2wBPv9V9vnGCNk47TJlA+AAUL2OydOOrzPQ3v3buuDpYp9IT44WVTT8gCfrAkkDy+Wvp1HoepPh19MzNmpsJrcM71LtbnvQ9lCMED345Zw3SxYJkrrblwNDogYLzG7oqSG0tlvH6uc9vslDKDxRLp2p/Xj7d6GF0cA+AZMjFpoRmtlvLRhqvgguUguilCHONApe/bEEqG5v1m314uUwD9up5FR8jsEuxBtnr6SzIyxGY/AYL7bsJ2CUsANHfCg7d35ucfe8G8gXr02Sk4jo8shgEnQRRpE2tuA6BfoBvnP6aRs9PE3jVawHZ9z8k/dCH9tre+b/y1NJf91FgRt29YbL0o0u40AjarDj5F3suLDrpG5lNYXRD+jMeuhM4AsDmrDtqVqiD/yjw76iBtbVADOmVrEp4yrQuPXjnYDUPMiBvc9T91PZKZSrWb62Xi/8P2aI3DI+PLmBHwnnkeaFXKFRHaKjq+1ycDjKXj8NUp/p/Hx83Ytg15/T3JhNWv80BEYnHuHJte93+AKX795bGf8OaOJr2asBfYcVzmuNYheCmztxdNEWnfoND0gIs6n7ZpdcvVazLw7eXbzt73hEpt7pCCktFFI1BmoWgWafOMU7KicQ2OJR6g0x1Vqw4FwGva5vlBWliErSf10pumhBqfvOMSJC//iKN48+4oCjUNpHnvxCoD7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009220027099003)(11063799006)(56012099006)(261021123027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261022113327099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JUtXcgNNAS/nAgOZu1LjPX9DYvvJ3W+LrcMPWehXSUyKZtVU4dZlnAcEMKCRoRXaE0r/h/eiNJEVpotNNDEztURJ+35cFUufTS2LpQksOiiwiyQpJpcalOJw/31l/fDEBL30G9FcsAs5hYZU/fxixdb1BvmzC/o315Ar/FW0nVvEf0Sya7mBw7Nc/zhGZ97fgm39pQCLi51CZSe9QAsVrAo8f6+Pjy1UOzY7oG7lOSysLYqdJ7vLKyUFM7zszakrw5S1U8pF+BMICQTxzudCh5ZtNx+ZfxsqV71TaHIQl8HXI2Kcx2TWqsDTDzLYWlu4nVIk7DoguD7QC63wezjRI6v5EMVb1vCc+SDRNMbX0jazgLWO8JLshADcFvqnxHZ4kcv7oi6b29SO2R1jPkMWUhtZZWmzuuuac39x8UcijSKdYloiX2CgN7Aad2iaOK7/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:27:03.4950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dedefd4-55c5-402c-538e-08df467b7908
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730

Implement user-space context creation, same-mm context fds, quiesce,
eventfd binding, poll, and token-validated doorbell mappings. Let PCI
perform the final BAR remap checking against doorbell resource bounds.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/context.c |  45 ++++-
 drivers/dma/sdxi/context.h |   4 +
 drivers/dma/sdxi/device.c  |   3 +
 drivers/dma/sdxi/ioctl.c   | 396 ++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/pci.c     |  27 +++
 drivers/dma/sdxi/sdxi.h    |   8 +
 6 files changed, 475 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index a4976f2b5e53..cdaa0f654429 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -15,8 +15,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/errno.h>
+#include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/iommu.h>
+#include <linux/mm.h>
 #include <linux/overflow.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
@@ -73,6 +75,8 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 	ida_destroy(&cxt->akey_ida);
 	mutex_destroy(&cxt->akey_lock);
 	mutex_destroy(&cxt->cleanup_lock);
+	if (cxt->mapping_inode)
+		iput(cxt->mapping_inode);
 	kfree(cxt->ring_state);
 	kfree(cxt);
 	put_device(&sdxi->chardev);
@@ -388,9 +392,9 @@ static int sdxi_publish_cxt(struct sdxi_cxt *cxt,
 	u8 l1_idx;
 	int err;
 
-	if (WARN_ONCE(cxt->id > cxt->sdxi->max_cxtid,
+	if (WARN_ONCE(cxt->id > READ_ONCE(cxt->sdxi->max_cxtid),
 		      "can't install cxt with id %u (limit %u)",
-		      cxt->id, cxt->sdxi->max_cxtid))
+		      cxt->id, READ_ONCE(cxt->sdxi->max_cxtid)))
 		return -EINVAL;
 
 	err = configure_cxt_ctl(cxt->cxt_ctl, ctl_cfg);
@@ -415,7 +419,7 @@ static int sdxi_publish_cxt(struct sdxi_cxt *cxt,
 		.akey_sz     = akey_table_order(cxt->akey_table),
 		.akey_ptr    = cxt->akey_table_dma,
 		.cxt_pasid   = cxt->pasid,
-		.max_buffer  = cxt->sdxi->max_buffer,
+		.max_buffer  = READ_ONCE(cxt->sdxi->max_buffer),
 		.opb_000_enb = cxt->opb_000_enb,
 	};
 
@@ -734,6 +738,8 @@ static void sdxi_cxt_force_exit(struct sdxi_cxt *cxt)
 	mutex_lock(&cxt->cleanup_lock);
 	cxt->cleanup_stopping = true;
 	mutex_unlock(&cxt->cleanup_lock);
+	if (cxt->mapping_inode)
+		unmap_mapping_range(cxt->mapping_inode->i_mapping, 0, 0, 1);
 	cancel_delayed_work_sync(&cxt->cleanup_work);
 
 	mutex_lock(&cxt->cleanup_lock);
@@ -754,6 +760,16 @@ static void sdxi_cxt_force_exit(struct sdxi_cxt *cxt)
 	sdxi_cxt_put(cxt);
 }
 
+void sdxi_cxt_abort(struct sdxi_cxt *cxt)
+{
+	if (!cxt || !sdxi_cxt_exit(cxt))
+		return;
+
+	/* Normal release retained the context; fence DMA before forcing it. */
+	sdxi_dev_fail(cxt->sdxi);
+	sdxi_cxt_force_exit(cxt);
+}
+
 static int sdxi_cxt_doorbell_offset(const struct sdxi_cxt *cxt,
 				    size_t *offset);
 static int sdxi_cxt_set_kernel_doorbell(struct sdxi_cxt *cxt);
@@ -827,7 +843,7 @@ static void sdxi_cxt_id_dtor(const struct sdxi_cxt_id *cxt_id)
 
 static struct sdxi_cxt_id sdxi_cxt_id_ctor(struct sdxi_dev *sdxi)
 {
-	struct xa_limit limit = XA_LIMIT(1, sdxi->max_cxtid);
+	struct xa_limit limit = XA_LIMIT(1, READ_ONCE(sdxi->max_cxtid));
 	u32 index;
 
 	return (struct sdxi_cxt_id) {
@@ -1059,6 +1075,8 @@ int sdxi_cxt_exit(struct sdxi_cxt *cxt)
 	mutex_lock(&cxt->cleanup_lock);
 	cxt->cleanup_stopping = true;
 	mutex_unlock(&cxt->cleanup_lock);
+	if (cxt->mapping_inode)
+		unmap_mapping_range(cxt->mapping_inode->i_mapping, 0, 0, 1);
 	cancel_delayed_work_sync(&cxt->cleanup_work);
 
 	mutex_lock(&cxt->cleanup_lock);
@@ -1220,6 +1238,25 @@ void sdxi_cxt_vma_open(struct sdxi_cxt *cxt)
 	mutex_unlock(&cxt->cleanup_lock);
 }
 
+int sdxi_cxt_vma_acquire(struct sdxi_cxt *cxt)
+{
+	int ret = 0;
+
+	if (!cxt)
+		return -EINVAL;
+
+	mutex_lock(&cxt->cleanup_lock);
+	if (cxt->fatal || cxt->cleanup_stopping || cxt->resources_released) {
+		ret = -ENODEV;
+	} else {
+		sdxi_cxt_get(cxt);
+		cxt->vma_refs++;
+	}
+	mutex_unlock(&cxt->cleanup_lock);
+
+	return ret;
+}
+
 void sdxi_cxt_vma_close(struct sdxi_cxt *cxt)
 {
 	if (!cxt)
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 03cb5634fa09..c245c7ee7841 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -33,6 +33,7 @@ struct sdxi_akey_table {
 };
 
 struct eventfd_ctx;
+struct inode;
 struct sdxi_process;
 
 /* For encoding the akey table size in CXT_L1_ENT's akey_sz. */
@@ -79,6 +80,7 @@ struct sdxi_cxt {
 
 	struct sdxi_ring_state *ring_state;
 	struct sdxi_process *process;
+	struct inode *mapping_inode;
 
 	spinlock_t intr_lock;		/* eventfd and interrupt state */
 	struct eventfd_ctx *intr_eventfd;
@@ -100,6 +102,7 @@ struct sdxi_cxt *sdxi_ucxt_new(struct sdxi_dev *sdxi, u32 ring_entries,
  * the caller must not reuse it.
  */
 int sdxi_cxt_exit(struct sdxi_cxt *cxt);
+void sdxi_cxt_abort(struct sdxi_cxt *cxt);
 void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
 void sdxi_cxt_get(struct sdxi_cxt *cxt);
 void sdxi_cxt_put(struct sdxi_cxt *cxt);
@@ -113,6 +116,7 @@ void sdxi_cxt_kill_stopped(struct sdxi_cxt *cxt);
 void sdxi_cxt_release_user_handle(struct sdxi_cxt *cxt);
 int sdxi_cxt_notify_mm_release(struct sdxi_cxt *cxt);
 void sdxi_cxt_vma_open(struct sdxi_cxt *cxt);
+int sdxi_cxt_vma_acquire(struct sdxi_cxt *cxt);
 void sdxi_cxt_vma_close(struct sdxi_cxt *cxt);
 
 enum sdxi_submit_flags {
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index b5960619d511..7ebecae3c541 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -391,6 +391,9 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	sdxi->db_stride *= 1U << FIELD_GET(SDXI_MMIO_CAP0_DB_STRIDE, cap0);
 	if (sdxi->db_stride > sdxi->db_size)
 		return -ENODEV;
+	sdxi->max_ring_entries = SZ_1K;
+	sdxi->max_ring_entries <<=
+		FIELD_GET(SDXI_MMIO_CAP0_MAX_DS_RING_SZ, cap0);
 
 	cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1);
 	sdxi->op_grp_cap = FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1);
diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index b25f8bc273c8..70dcde916c82 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -8,17 +8,28 @@
 #include <linux/cdev.h>
 #include <linux/bitfield.h>
 #include <linux/capability.h>
+#include <linux/cleanup.h>
 #include <linux/compat.h>
+#include <linux/anon_inodes.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
+#include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/poll.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/sdxi.h>
 
+#include "admin.h"
+#include "context.h"
+#include "intr.h"
 #include "ioctl.h"
 #include "mmio.h"
 #include "process.h"
@@ -29,6 +40,29 @@
 static dev_t sdxi_devt;
 static struct class *sdxi_class;
 static DEFINE_IDA(sdxi_minor_ida);
+static const struct file_operations sdxi_cxt_fops;
+
+static void sdxi_cxt_vma_open_cb(struct vm_area_struct *vma)
+{
+	sdxi_cxt_vma_open(vma->vm_private_data);
+}
+
+static void sdxi_cxt_vma_close_cb(struct vm_area_struct *vma)
+{
+	sdxi_cxt_vma_close(vma->vm_private_data);
+}
+
+static const struct vm_operations_struct sdxi_cxt_vm_ops = {
+	.open = sdxi_cxt_vma_open_cb,
+	.close = sdxi_cxt_vma_close_cb,
+};
+
+static void sdxi_cxt_vma_attach(struct vm_area_struct *vma,
+				struct sdxi_cxt *cxt)
+{
+	vma->vm_ops = &sdxi_cxt_vm_ops;
+	vma->vm_private_data = cxt;
+}
 
 static int sdxi_file_check_owner(const struct sdxi_process *process)
 {
@@ -60,7 +94,9 @@ static int sdxi_ioctl_get_uapi_info(struct file *file, struct sdxi_file *sf,
 		.cap_words = SDXI_UAPI_CAP_WORDS,
 		.caps = {
 			SDXI_UAPI_CAP_DEV_INFO |
-			SDXI_UAPI_CAP_DEV_ATTR_MGMT,
+			SDXI_UAPI_CAP_DEV_ATTR_MGMT |
+			SDXI_UAPI_CAP_CXT_CREATE |
+			SDXI_UAPI_CAP_CXT_EVENTFD,
 		},
 	};
 
@@ -205,6 +241,13 @@ static int sdxi_dev_attr_write(struct sdxi_dev *sdxi,
 	register_value &= ~desc->mask;
 	register_value |= (value << shift) & desc->mask;
 	sdxi_write64(sdxi, desc->reg, register_value);
+	if (desc == &sdxi_dev_attrs[SDXI_DEV_ATTR_MAX_BUFFER]) {
+		WRITE_ONCE(sdxi->max_buffer, (u8)value);
+		dma_set_max_seg_size(sdxi->dev,
+				     min((u64)SZ_2M << value, (u64)U32_MAX));
+	} else if (desc == &sdxi_dev_attrs[SDXI_DEV_ATTR_MAX_CXT]) {
+		WRITE_ONCE(sdxi->max_cxtid, (u16)value);
+	}
 	mutex_unlock(&sdxi->reg_lock);
 	return 0;
 }
@@ -264,6 +307,248 @@ static int sdxi_ioctl_set_dev_attr(struct file *file, struct sdxi_file *sf,
 	return sdxi_dev_attr_read(sf->process->sdxi, desc, &args->val);
 }
 
+static bool sdxi_u32_array_zero(const u32 *values, size_t count)
+{
+	size_t i;
+
+	for (i = 0; i < count; i++)
+		if (values[i])
+			return false;
+
+	return true;
+}
+
+static int sdxi_user_op_groups(struct sdxi_dev *sdxi, u32 requested,
+			       u32 *applied)
+{
+	u32 available;
+	u32 allowed;
+
+	available = FIELD_GET(SDXI_MMIO_CTL2_OPB_000_AVL,
+			      sdxi_read64(sdxi, SDXI_MMIO_CTL2));
+	allowed = available & SDXI_OPB_000_INTR;
+
+	if (!requested)
+		requested = allowed;
+	if (requested & SDXI_OPB_000_ADMIN)
+		return -EPERM;
+	if (requested & ~available)
+		return -EINVAL;
+	if (requested & ~allowed)
+		return -EOPNOTSUPP;
+
+	*applied = requested;
+	return 0;
+}
+
+static int sdxi_ioctl_create_cxt(struct file *file, struct sdxi_file *sf,
+				 void *data)
+{
+	struct sdxi_create_cxt_args *args = data;
+	struct sdxi_process *process = sf->process;
+	struct iommu_sva *unbind_sva = NULL;
+	struct sdxi_file *cxt_sf = NULL;
+	struct sdxi_cxt *cxt = NULL;
+	struct file *cxt_file;
+	u32 unbind_pasid = 0;
+	u32 ring_entries;
+	u32 op_groups;
+	size_t ring_bytes;
+	bool bound = false;
+	u16 akey_flags;
+	int cxt_fd;
+	int ret;
+
+	if (args->argsz < sizeof(*args) || args->flags)
+		return -EINVAL;
+	if (process->sdxi->db_stride < PAGE_SIZE ||
+	    !IS_ALIGNED(process->sdxi->db_stride, PAGE_SIZE))
+		return -EOPNOTSUPP;
+
+	ret = sdxi_user_op_groups(process->sdxi, args->opb_000_enb,
+				  &op_groups);
+	if (ret)
+		return ret;
+
+	ring_entries = args->ds_ring_entries ?: SZ_1K;
+	if (ring_entries < SZ_1K ||
+	    ring_entries > process->sdxi->max_ring_entries)
+		return -EINVAL;
+	if (check_mul_overflow((size_t)ring_entries,
+			       sizeof(struct sdxi_desc), &ring_bytes))
+		return -EOVERFLOW;
+
+	if (!args->ds_ring_base || !args->write_index_base ||
+	    !args->cxt_sts_base)
+		return -EINVAL;
+	if (!IS_ALIGNED(args->ds_ring_base,
+			BIT_ULL(DESC_RING_BASE_PTR_SHIFT)) ||
+	    !IS_ALIGNED(args->write_index_base,
+			BIT_ULL(WRT_INDEX_PTR_SHIFT)) ||
+	    !IS_ALIGNED(args->cxt_sts_base,
+			BIT_ULL(CXT_STATUS_PTR_SHIFT)))
+		return -EINVAL;
+	if (!access_ok(u64_to_user_ptr(args->ds_ring_base), ring_bytes) ||
+	    !access_ok(u64_to_user_ptr(args->write_index_base),
+		       sizeof(__le64)) ||
+	    !access_ok(u64_to_user_ptr(args->cxt_sts_base),
+		       sizeof(struct sdxi_cxt_sts)))
+		return -EFAULT;
+
+	if (clear_user(u64_to_user_ptr(args->write_index_base),
+		       sizeof(__le64)) ||
+	    clear_user(u64_to_user_ptr(args->cxt_sts_base),
+		       sizeof(struct sdxi_cxt_sts)))
+		return -EFAULT;
+
+	mutex_lock(&process->mutex);
+	if (process->cxt) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (!process->sva) {
+		ret = sdxi_process_bind(process);
+		if (ret)
+			goto out_unlock;
+		bound = true;
+	}
+	if (!FIELD_FIT(SDXI_AKEY_ENT_PASID, process->pasid)) {
+		ret = -ERANGE;
+		goto out_unbind;
+	}
+
+	cxt = sdxi_ucxt_new(process->sdxi, ring_entries,
+			    args->ds_ring_base, args->write_index_base,
+			    args->cxt_sts_base, process->pasid, op_groups);
+	if (!cxt) {
+		ret = -ENOMEM;
+		goto out_unbind;
+	}
+
+	/* Subsequent failure cleanup now owns the context and SVA lifetime. */
+	cxt->process = process;
+	process->cxt = cxt;
+	sdxi_process_get(process);
+
+	akey_flags = SDXI_AKEY_ENT_VL | SDXI_AKEY_ENT_PV;
+	cxt->akey_table->entry[1] = (struct sdxi_akey_ent) {
+		.intr_num = cpu_to_le16(akey_flags),
+		.pasid = cpu_to_le32(FIELD_PREP(SDXI_AKEY_ENT_PASID,
+						process->pasid)),
+	};
+	dma_wmb();
+
+	if (op_groups & SDXI_OPB_000_INTR) {
+		ret = sdxi_cxt_init_intr(cxt);
+		if (ret)
+			goto out_exit_cxt;
+	}
+
+	ret = sdxi_adm_start_cxt(cxt);
+	if (ret)
+		goto out_exit_cxt;
+
+	cxt_sf = kzalloc_obj(*cxt_sf, GFP_KERNEL);
+	if (!cxt_sf) {
+		ret = -ENOMEM;
+		goto out_exit_cxt;
+	}
+
+	cxt_sf->type = SDXI_FILE_CONTEXT;
+	cxt_sf->process = process;
+	cxt_sf->cxt = cxt;
+
+	cxt_fd = get_unused_fd_flags(O_CLOEXEC);
+	if (cxt_fd < 0) {
+		ret = cxt_fd;
+		goto out_exit_cxt;
+	}
+
+	cxt_file = anon_inode_create_getfile("sdxi-context", &sdxi_cxt_fops,
+					     cxt_sf, O_RDWR, NULL);
+	if (IS_ERR(cxt_file)) {
+		put_unused_fd(cxt_fd);
+		ret = PTR_ERR(cxt_file);
+		goto out_exit_cxt;
+	}
+	cxt->mapping_inode = file_inode(cxt_file);
+	ihold(cxt->mapping_inode);
+
+	sdxi_process_get(process);
+	sdxi_cxt_get(cxt);
+	fd_install(cxt_fd, cxt_file);
+
+	*args = (typeof(*args)) {
+		.argsz = sizeof(*args),
+		.opb_000_enb = op_groups,
+		.pasid = process->pasid,
+		.ds_ring_entries = ring_entries,
+		.ds_ring_base = args->ds_ring_base,
+		.cxt_sts_base = args->cxt_sts_base,
+		.write_index_base = args->write_index_base,
+		.doorbell_mmap_base =
+			sdxi_mmap_token(SDXI_MMAP_TYPE_DOORBELL, cxt->id,
+					cxt->mmap_gen),
+		.cxt_fd = cxt_fd,
+	};
+	mutex_unlock(&process->mutex);
+	return 0;
+
+out_exit_cxt:
+	mutex_unlock(&process->mutex);
+	sdxi_cxt_abort(cxt);
+	kfree(cxt_sf);
+	return ret;
+out_unbind:
+	if (bound)
+		unbind_sva = sdxi_process_detach_sva_locked(process,
+							    &unbind_pasid);
+out_unlock:
+	mutex_unlock(&process->mutex);
+	if (unbind_sva)
+		sdxi_process_unbind_sva(process, unbind_sva, unbind_pasid);
+	kfree(cxt_sf);
+	return ret;
+}
+
+static int sdxi_ioctl_cxt_eventfd(struct file *file, struct sdxi_file *sf,
+				  void *data)
+{
+	struct sdxi_cxt_eventfd_args *args = data;
+	int ret;
+
+	if (args->argsz < sizeof(*args) || args->flags || args->rsvd0 ||
+	    !sdxi_u32_array_zero(args->rsvd1, ARRAY_SIZE(args->rsvd1)))
+		return -EINVAL;
+	if (!sf->cxt)
+		return -ENODEV;
+
+	ret = sdxi_cxt_set_intr_fd(sf->cxt, args->eventfd,
+				   &args->intr_akey, &args->intr_num);
+	if (!ret)
+		args->argsz = sizeof(*args);
+	return ret;
+}
+
+static int sdxi_ioctl_quiesce_cxt(struct file *file, struct sdxi_file *sf,
+				  void *data)
+{
+	struct sdxi_quiesce_cxt_args *args = data;
+	int ret;
+
+	if (args->argsz < sizeof(*args) || args->flags)
+		return -EINVAL;
+	if (!sf->cxt)
+		return -ENODEV;
+
+	ret = sdxi_cxt_quiesce(sf->cxt, args->timeout_ms,
+			       &args->cst_flags);
+	if (!ret)
+		args->argsz = sizeof(*args);
+	return ret;
+}
+
 #define SDXI_IOCTL_DEF(_nr, _cmd, _func, _files, _access)	\
 	[_nr] = {						\
 		.cmd = (_cmd),					\
@@ -290,9 +575,9 @@ static const struct sdxi_ioctl_desc sdxi_ioctls[] = {
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
 	SDXI_IOCTL_DEF(0x07, SDXI_SET_RKEYS, sdxi_ioctl_unsupported,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
-	SDXI_IOCTL_DEF(0x08, SDXI_CREATE_CXT, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x08, SDXI_CREATE_CXT, sdxi_ioctl_create_cxt,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_PUBLIC_DEVICE),
-	SDXI_IOCTL_DEF(0x09, SDXI_CXT_EVENTFD, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x09, SDXI_CXT_EVENTFD, sdxi_ioctl_cxt_eventfd,
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
 	SDXI_IOCTL_DEF(0x0a, SDXI_GET_AKEY_LIST, sdxi_ioctl_unsupported,
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
@@ -304,7 +589,7 @@ static const struct sdxi_ioctl_desc sdxi_ioctls[] = {
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_PUBLIC_DEVICE),
 	SDXI_IOCTL_DEF(0x0e, SDXI_ADMIN_VENDOR, sdxi_ioctl_unsupported,
 		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_VENDOR_HANDLER),
-	SDXI_IOCTL_DEF(0x0f, SDXI_QUIESCE_CXT, sdxi_ioctl_unsupported,
+	SDXI_IOCTL_DEF(0x0f, SDXI_QUIESCE_CXT, sdxi_ioctl_quiesce_cxt,
 		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
 };
 
@@ -431,6 +716,95 @@ static long sdxi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
+static int sdxi_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct sdxi_file *sf = file->private_data;
+	struct sdxi_cxt *cxt;
+	struct sdxi_dev *sdxi;
+	u64 allowed_mask;
+	u64 token;
+	u64 type;
+	u32 generation;
+	int ret;
+
+	if (!sf || sf->type != SDXI_FILE_CONTEXT || !sf->process)
+		return -EINVAL;
+
+	ret = sdxi_file_check_owner(sf->process);
+	if (ret)
+		return ret;
+
+	sdxi = sf->process->sdxi;
+	guard(rwsem_read)(&sdxi->state_lock);
+	if (!sdxi->online)
+		return -ENODEV;
+
+	cxt = sf->cxt;
+	if (!cxt || !cxt->id)
+		return -EINVAL;
+	if (sdxi_cxt_is_fatal(cxt) || READ_ONCE(cxt->resources_released))
+		return -ENODEV;
+
+	token = (u64)vma->vm_pgoff << PAGE_SHIFT;
+	allowed_mask = SDXI_MMAP_TYPE_MASK | SDXI_MMAP_CXT_ID_MASK |
+		       SDXI_MMAP_GEN_MASK;
+	if (token & ~allowed_mask)
+		return -EINVAL;
+
+	type = token & SDXI_MMAP_TYPE_MASK;
+	generation = cxt->mmap_gen &
+		     (SDXI_MMAP_GEN_MASK >> SDXI_MMAP_GEN_SHIFT);
+	if (type != SDXI_MMAP_TYPE_DOORBELL ||
+	    sdxi_mmap_token_cxt_id(token) != cxt->id ||
+	    sdxi_mmap_token_gen(token) != generation)
+		return -EINVAL;
+
+	if (vma->vm_end - vma->vm_start != cxt->sdxi->db_stride)
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_WRITE) || vma->vm_flags & VM_EXEC)
+		return -EPERM;
+	if (!cxt->sdxi->bus_ops->mmap_doorbell)
+		return -EOPNOTSUPP;
+	ret = sdxi_cxt_vma_acquire(cxt);
+	if (ret)
+		return ret;
+
+	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND |
+		     VM_DONTDUMP | VM_PFNMAP);
+	vm_flags_clear(vma, VM_MAYEXEC);
+	vma->vm_pgoff = 0;
+	ret = cxt->sdxi->bus_ops->mmap_doorbell(cxt->sdxi, cxt, vma);
+	if (!ret)
+		sdxi_cxt_vma_attach(vma, cxt);
+	else
+		sdxi_cxt_vma_close(cxt);
+	return ret;
+}
+
+static __poll_t sdxi_cxt_poll(struct file *file, poll_table *wait)
+{
+	struct sdxi_file *sf = file->private_data;
+	struct sdxi_cxt *cxt;
+	__poll_t mask = 0;
+
+	if (!sf || sf->type != SDXI_FILE_CONTEXT || !sf->process)
+		return EPOLLERR;
+	if (sdxi_file_check_owner(sf->process))
+		return EPOLLERR;
+
+	cxt = sf->cxt;
+	if (!cxt)
+		return EPOLLERR | EPOLLHUP;
+
+	poll_wait(file, &cxt->poll_wq, wait);
+	if (sdxi_cxt_is_fatal(cxt))
+		mask |= EPOLLERR;
+	if (READ_ONCE(cxt->resources_released))
+		mask |= EPOLLHUP;
+
+	return mask;
+}
+
 static int sdxi_open(struct inode *inode, struct file *file)
 {
 	struct sdxi_dev *sdxi;
@@ -470,6 +844,11 @@ static int sdxi_release(struct inode *inode, struct file *file)
 	if (!sf)
 		return 0;
 
+	if (sf->type == SDXI_FILE_CONTEXT && sf->cxt) {
+		sdxi_cxt_release_user_handle(sf->cxt);
+		sdxi_cxt_put(sf->cxt);
+		sf->cxt = NULL;
+	}
 	sdxi_process_put(sf->process);
 	kfree(sf);
 	file->private_data = NULL;
@@ -484,6 +863,15 @@ static const struct file_operations sdxi_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 };
 
+static const struct file_operations sdxi_cxt_fops = {
+	.owner = THIS_MODULE,
+	.release = sdxi_release,
+	.unlocked_ioctl = sdxi_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.mmap = sdxi_mmap,
+	.poll = sdxi_cxt_poll,
+};
+
 int sdxi_chardev_init(void)
 {
 	int ret;
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index eca55c8d65f8..010ed2c6ad74 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -11,9 +11,12 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iomap.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 
+#include "context.h"
 #include "mmio.h"
 #include "sdxi.h"
 
@@ -129,12 +132,36 @@ static void sdxi_pci_force_quiesce(struct sdxi_dev *sdxi)
 		dev_err(&pdev->dev, "pending PCI transactions did not drain\n");
 }
 
+static int sdxi_pci_mmap_doorbell(struct sdxi_dev *sdxi,
+				  struct sdxi_cxt *cxt,
+				  struct vm_area_struct *vma)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+	resource_size_t offset;
+	resource_size_t address;
+
+	if (check_mul_overflow((resource_size_t)cxt->id,
+			       (resource_size_t)sdxi->db_stride, &offset))
+		return -EOVERFLOW;
+	if (offset > pci_resource_len(pdev, SDXI_PCI_BAR_DOORBELL) ||
+	    sdxi->db_stride >
+	    pci_resource_len(pdev, SDXI_PCI_BAR_DOORBELL) - offset)
+		return -EINVAL;
+
+	address = pci_resource_start(pdev, SDXI_PCI_BAR_DOORBELL) + offset;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return io_remap_pfn_range(vma, vma->vm_start, address >> PAGE_SHIFT,
+				  sdxi->db_stride, vma->vm_page_prot);
+}
+
 static const struct sdxi_bus_ops sdxi_pci_ops = {
 	.owner = THIS_MODULE,
 	.init = sdxi_pci_init,
 	.reset = sdxi_pci_reset,
 	.get_irq = sdxi_pci_get_irq,
 	.force_quiesce = sdxi_pci_force_quiesce,
+	.mmap_doorbell = sdxi_pci_mmap_doorbell,
 };
 
 static int sdxi_pci_probe(struct pci_dev *pdev,
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 03a85a1575e7..0f7a63d6fc4b 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -47,7 +47,9 @@ enum {
 };
 
 struct sdxi_dev;
+struct sdxi_cxt;
 struct module;
+struct vm_area_struct;
 
 /**
  * struct sdxi_bus_ops - Bus-specific methods for SDXI devices.
@@ -74,6 +76,11 @@ struct sdxi_bus_ops {
 	 *                  device recovery fails.
 	 */
 	void (*force_quiesce)(struct sdxi_dev *sdxi);
+	/**
+	 * @mmap_doorbell: Map one context's doorbell region.
+	 */
+	int (*mmap_doorbell)(struct sdxi_dev *sdxi, struct sdxi_cxt *cxt,
+			     struct vm_area_struct *vma);
 };
 
 struct sdxi_dev {
@@ -86,6 +93,7 @@ struct sdxi_dev {
 
 	/* hardware capabilities (from cap0 & cap1) */
 	u32 db_stride;			/* doorbell stride in bytes */
+	u64 max_ring_entries;
 	u16 max_cxtid;			/* Maximum context ID allowed. */
 	u8 max_buffer;			/* Configured log2 buffer size minus 21. */
 	u32 op_grp_cap;			/* supported operation group cap */
-- 
2.56.1

