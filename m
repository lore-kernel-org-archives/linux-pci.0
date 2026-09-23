Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430A57D235;
	Wed, 23 Sep 2026 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194365; cv=fail; b=dXOFkXJ0kYEJIy8p/fyeK+cyXJHFHOVgRZJgbgiNPhd8JFDKvVFXQ7lqy87XSuuPlRCbXfm6pUNI1Zct7azy+GNe1Kf+oBvtSwhJVjk/jwUugjfkRz1XUgt6aQ7A3NfSy7cUYABm8ITpu3L/6k/LtXvnGr9pjMXkazD/jlhpLnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194365; c=relaxed/simple;
	bh=PQ+HeVo104Zt17uk675XGVhbt7AVqoCrUPoMgNTESx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJb9WPG2ZhPDZ4kgTCkoX/93ydfQjF2qhBRX0kxvLINaDfclSdELI9bWz8LhFaXkfyx3TKrmSf5RLQ9BvJb21Zwkuyiv3FNsR/SeJ0+Nf2MKMPzKciwrXPc+jxKcXCYFPwQ0bN/bzg/AWop1gIah1uLrF/d01b52XWZWvUToqHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QOROB0pn; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QOROB0pn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omWjrhq1CeNHUWoWj8BI7Gvuh7ccHuZMhPS+ibdhmDnainOpNWGSuFy3shNkcyz8JkP5Jozd3ylpllef19jM+t07w4Mpn1iHbDjwo6B1/sbF3wOzBnfL0e8vZzZGcbEShLKPsKFbYLf1bM5rQj7fI2GPhiTf7LkAIf5xODkQmWEyPaiCdO1LIOK12C1r1bOo2IEYV7INYGyRbmEe89UdiJjxvpbB/R+Nn+9EM2BQPz28h/yBoHTYVvbd33pvRbuIqDZ+vUkoWx8wYE/qAINQpd4cIhZUqqrSkQf0pStNT+tqiEFZh+2hS+FlLEb+RYUY9GuOx2SRVaWAQ4RDuRpXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GohInIqirjYYa/duetd2rVvAUWin9LORinG9jEAHnng=;
 b=Km0IlXhP6pPkMNki5yqUzi5G5mDRc3Wx+WdNvaTjObxYi+VZC6wl8ln6wjOj4/34pCLARUQRloyG2Kd/l6SLNOXXIyiDFZxtt3khfVr9Kx2uJtDppfuAyC21lIKeHveApIYZz0zJLo4MjCtfsrgHtQtnY4ySvZqJGltdhx2cyD6tykq/IADWZ1A1Jlcih3Cs4AsLCCVlU6jcIVHyuaQVWRQ7ktrk9xVYBlq6D3JDl+wcf5BZ94+p1eUGELESnpRHdVAeYaDyLgayPEwm3IfjTumTP0WDuVkTh5nl/HaeD0rQZUI6NRvso1VaFZEPM7Xy4W+GbM/pIUkrNB/f4LeoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GohInIqirjYYa/duetd2rVvAUWin9LORinG9jEAHnng=;
 b=QOROB0pnSf9efjCsKPazJmd/2osZTpSPNJvllwLyw8B+1Y6RQAb1gCcEbZVSiBLMeZqBBCafTJc7/00b48kFP0fBhMkJum6diIUVYymgbtBaqT1fx8OtX5+l9bdCxPT+duGJ0+iZOfeyNcUc3Iww1P4haTxFyhpLDmxDk7Cz/YXW83lM9tBAQYOEvv9HzXv5ScUbTp4JaWdqMjqL2e6Jj0CQsu9Y5ej/yn5+Xj772p+1LHx93BqNDaTkbPZVaGhjFYpaf1YoM6dERCtaKN+50fjc3fvl58lVhQdp8mUoT85kJ5UQyIOtU1k3EyvpoUcTyRr9IpVaZhtvTWQ3kmsZoA==
Received: from MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 20:12:22 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::77) by MW4PR03CA0232.outlook.office365.com
 (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 20:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:53 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:11:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<vsethi@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v6 02/17] PCI/CXL: Probe the underlying bus reset in cxl_reset_bus_function()
Date: Wed, 23 Sep 2026 13:11:21 -0700
Message-ID: <a05695c1dcb0682425bad7b8387cd24ad71e2d9d.1790188510.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 95044287-51ab-4ea6-a223-08df19aefa18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	r4kQjJUfcwdcvApxlrCvdgaAhdbVSy5Y4a/PPyHGSFTL7vNmt1s0BFl31H6dHw7pVHDecsUSUgBvQWXH9rObCZGiITQrLeHYvoAnBKZecRTieJFz9b4cNNXzTVOyeW/GnDPhuee7sx3QStqVZrkH5qAE0khN5ealVxupDmg87JgKIRYO/ikq8WUjonMZRZLPxUlSip3WrS+6kgIbA5MQFV6dnUAon9lLA5qrqqiX1Wkggah2aGetm3F//YbHKToD//aujhBfjrrYWqAI4Zx1Y0zXA3V4cHFHMDzsTXpOUNIFIDu7Um68rzy0ShoW+yPk8eq3HIyLzQ8H4UEz3xIgdUv1eCiNEQwFPXob6M2Hl9pepZjLz1nexd1SDtx2UU+fIZjBMuyUDcYEmKk9+ndLPzh/sXH8wBsnT0YWEMJMhBpU2+gdlN34V0wiaGjjCUpUm8lr7zwJKEmn5YOorUErTHOuwe1KH1ZJEttrf1SSYb2CR7fjidHFmcqPnB+p9PP7vVmz1uKus8xGdPAfHY77UkyM9Fl4za/UZcKXd6AjMsKEQWdnAUjefTF8OFdOGV9G6rDfvIy3HZRpTfDD6RtL8s2tObo1an6RrCSxTUDFkz4WolC7U/UIEZAIq4EWX0rOVVib74E3zUhKzMiv/79iTIe78la3K6nVh2oDl/BZmVmmckKbcf4fWPVDBRNEJDhd
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DSZJO0cEFib6zJkz2Xsosiga6+6Bzq6K/8u3nyxt2gXeXYpkoHS7bMz600r55kznc7gdUWo4EQ7bLDSNBHvpynulf/1e/O41Oym4tJFiefnZo7uQWhNDRQOLcvz209117V0HQpMwJp7Pzd+JKT0587JTY9BLeUu1gvdVB6IgoRZ0YpANbKuxDprPtQbnBQTR1cdjMH8wK2OObXQhQAqqPJwEwaxAOWjE/e49CI4HJ/B6PDny55yxC7KDncjCXGJ2n4LmnHkxJ+Z3360Vr/uWcd07ZZ4OPLIecn3wPxu2lNShyvmEmD/WWgsGUGxCpurj/WxaEhalscE5sr6VA0/pWspAwdG2uXpxmnJ2NSCNUjqRVJWzlpAOPmPQIHuwVTtIGjdWPLIUeYHgT2VcZ4VxAjdvilW+1lbqKdisQbIEW696oTEcn0kJIgfWpaj1f9JF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:21.9730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95044287-51ab-4ea6-a223-08df19aefa18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756

cxl_reset_bus_function() reports "supported" to a probe after checking only
that the upstream bridge carries a CXL port DVSEC. The underlying bus reset
can still be unavailable, e.g. on a bus shared with other devices, so both
the reset_methods[] array and the reset_method sysfs node end up listing a
"cxl_bus" that is guaranteed to fail with -ENOTTY when it is attempted.

Probe the underlying pci_dev_reset_slot_function() and then, if it is not
applicable, pci_parent_bus_reset(). These are the same two checks that the
actual reset runs, so a shared-bus CXL device no longer advertises a method
that can never succeed.

Probing via pci_reset_bus_function() would not work: its cxl_sbr_masked()
check rejects every CXL port with a masked SBR, while the do-reset path in
this function unmasks the SBR before resetting. Such a port would wrongly
probe as unsupported.

Move the port control register read above the probe branch as well, so that
probe runs the same checks. That read asserts no reset, and a failure means
the device cannot be reset this way, which is a probe-time answer.

Also pass an explicit PCI_RESET_DO_RESET at the do-reset call site, since
probe is always false at that point.

Fixes: 53c49b6e6dd2e ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1eba412b7e0de..a6e0ecfd207a7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5029,13 +5029,21 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (!dvsec)
 		return -ENOTTY;
 
-	if (probe)
-		return 0;
-
 	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
 	if (rc)
 		return -ENOTTY;
 
+	/*
+	 * Do not probe via pci_reset_bus_function(), which would reject a
+	 * masked SBR that the do-reset path below unmasks before resetting.
+	 */
+	if (probe) {
+		rc = pci_dev_reset_slot_function(dev, PCI_RESET_PROBE);
+		if (rc != -ENOTTY)
+			return rc;
+		return pci_parent_bus_reset(dev, PCI_RESET_PROBE);
+	}
+
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
@@ -5050,7 +5058,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 				      val);
 	}
 
-	rc = pci_reset_bus_function(dev, probe);
+	rc = pci_reset_bus_function(dev, PCI_RESET_DO_RESET);
 
 	if (reg != val)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
-- 
2.43.0

