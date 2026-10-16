Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6A30C161;
	Fri, 16 Oct 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167592; cv=fail; b=iMLQUUI2mBVlHAjUHg+2n0wYCe7GsqgAP1h6FgmvrxS4vD3hFvXYERlO0/K03zQO+L5Mwwp/BM6LhP7JmHKDyWa1Dgwkc9iCXVeT2eljz8j/jXG0J499PfDBbVyks4LnAC+5kbm5PxsrgVgc0gx9UPYnm32A4N+2ktR/j2Pierk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167592; c=relaxed/simple;
	bh=am69YKTcUFnXm+AV/PVmrUsPkBvp1H2ZWbGgId9fsSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2K2UG9rav76IgQrFPy7t9SE4SsxgyzFJTsDiSpWC4jDs+L+HR2s6coeuY+Z0JJVabSuNhioTt6fFIKkoLFr4PSqF0FTmPGDzDrmhV1Jk5GUBixPClpbx21ci9Blt2clFDdrjmZgiMlt2D1a46QAmHggwrj+gyvTEvZAVZ9jL6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NjIkssgq; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NjIkssgq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGeg+CvAY2pmdBpjw9Db0cWBGah7AAPRkxQmfgPOsPuupxJ6ypZS4ikf3d6omMjDup9YSRVqnrbgNg2DVAS86qCSQxMD21qLoo5Z6seOFKZ8azldTO2+s0BEk/saI9lUK5Nmtc3tdMOfAK4yMfsDkaaydAZBFKqUMVcbtH6ZpUBP72Cn2JYxMvJDdbxhWknIDTn0LY2u9gBy4EyzOLY67EHjH9DBu7DwVhdtgX3yFxC7a/4u7tQermmQWUoslvkBD60XCWg/9SbmedjTfDTHaB3zu7Re7K0kfcN6ql5yDMP8Q/fCdb6WdXWpehmxDpcBKZyRrn7z0VKJOQ61X9GHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RNRzZQmxJ6azvT23EAp9EddohIuaC194tU77dBlHlw=;
 b=AJ59Hmjv32a2a7Aq1dcatsAO65H/SvEBhcKlajGdr3a9MZX9ksxqZJ2e7ttnjdrrjJSTJe0t37RTnFC1Faihysffxa8ZNbwl6v3bdbxliXhSK96r0tz26711v6JR632em9oPzrr8a1fmbdAZ1rTWKFhNTLW0dRQ4GEAX3f2VusU170zIJCxJmB4XGayYwQJzuqkvBu5JjrZ/JEGXbFMEY85xeK54I8X3UrE9CfODcFNl3jVxOX3DDxLhBoDOKg7TT/urEt9ssdMrDDL36AAFbH6FyviXFZ/WIGwNiBJ48Ma4n1M02nsZz+jcH2i/cICGxAFxG7VkJ3M6pi+AS3W+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RNRzZQmxJ6azvT23EAp9EddohIuaC194tU77dBlHlw=;
 b=NjIkssgq1uhporIqI26Df9SieQQLXudVN8wSvmErzNSFk3F9AGXB+A7FLv9rlJUznwOnBqpR6mjq8gLUlykZrNcnlmNpVszka0qT8OIzsKhK78x1xBxaB8eAqLSdccDvI0OnkiZCwH4r+bwrJwWkrSnfTUY8OY7gywXRBqCYIOywM3Zs4HPXgvOxqGMOIv+3ljEebjECA6fmHJeoQDXkcWcvXgoWKTDVYl1u9ww4a6T15zYi6lMnRQAJGcmyPO3T7uJvWzuIhrhtN10b42LypFOM5k4bTJp5vg9XhQwTFVMNnOBI/POIDM7HdUsWIPyKHjLejHSceqPsSfCP86SDeA==
Received: from MN2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:208:234::30)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 16:19:39 +0000
Received: from BN7PEPF000000A6.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::a4) by MN2PR16CA0061.outlook.office365.com
 (2603:10b6:208:234::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 16:19:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A6.mail.protection.outlook.com (10.167.245.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:19:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:19:13 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:19:04 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v6 01/31] cxl/regs: Split the BAR block request and ioremap helpers
Date: Fri, 16 Oct 2026 21:48:08 +0530
Message-ID: <20261016161839.2765592-2-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A6:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: e13a7b98-56a9-4d39-ae48-08df2ba1472f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|22082099003|10067099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	x7c8Tsz2RraqqfIoJLWjPC5W72B3RHPqCUCdZiybfWzJO9Fg3P5vPD1ktsMXSfGt52Zy0zP6FonSMYP0otaQXQrtin2iPik8oMHEUiRnLbi6ij5LaL3vSLJcmSHkuqjnW2t0OvBgZ0srG/t2L7xWtPVWsfFyrEFsKJeDwABOzjkPv5N+5OVuLd06n2kCpSIpMyUW1l+pjo5E6uF15oQWhOIBW0VFexddlAVzb0KeSaHyXdRuMcvC+TB1LQ55YGBrfBbZHXAN+KUj0dTfssxrJa05vHPxxtdY1hXBG9ROQsF0ijpoBQLPlAXjmr64Nm+UNwBrr8KY+FDBF7eg+585q6UYHo5T3IycXz2JOXRzn+qZN8t7oo8L/Ov2xlK5CNuMXbKjmtgfUHfJ529euVACZ7Ezdh9HarHmzUbdFGPEK679UQN4qYkojrFVYIAbMObX6uDW4Oc+X3/IAR/97NfLYS42YA7GLv8F2HQJd9HcTurmI3q2VUeuATv8R3mCzc3acacZ1bCv6oJgHMfY/2vc5yTKF4inqPBKvdKWHqCbBwrXoDwBXTjylknEo80napgjWtIfgLDV4CH5LAx+V/FmgyBf5zkfn+BV9ckoleGz26qfOlVyetfvSy+MAra8MHy6xmQNfF9Me5g05hV7V8qxa4GQZTg79vP/wOjaAO0owQm44SISKFEKVwPdgyUHQyg+d8tSFigdn66DaJl+4eqNaNzyCuHCWPJhTPYwJR/5QOh87uxCDREpDWHwZyyZ5qNc
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(22082099003)(10067099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HowUvtEJ7i9vE6Gwmh2q/+X6FJnW61lf2wXfQr2n46ZsS6GgxhRrA5UBO8sPtweOhy7Nf9T8CHcCIhtTM5kwUEBKeMAjFC9Gk2oCEyzBWUhriPuz4Di7H+1Si60mxo1v9Qitr3TWhNHbk31WWj1ZSzWoBPl6HL7D3aWdpI7Ut2mltmaBW2reJoqhoKgld5JBuiWgV12kj4ODVUkvGieCm60NEQqUPdWa1/L50jzlLt5RNd4XCfZ/3ivkJuvV3liXhWtvzyCnTDvnhRGr0t2th5dBNTsEAzmelrkceievdHmQIFpxwqU34iFMPXXTG6X9FG1wxrar5cB+GjkPMcHjWrY01oT1jNhhkDGJEskh+U6DF6j2vj0ijx8P9qZIa+GeHoAe2Bww0+LVOi+/J+tzuZ9G+obCpUExdOx7uUGZFGW17gYVyqIi1urOHGRXlO4B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:19:39.2031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13a7b98-56a9-4d39-ae48-08df2ba1472f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915

From: Manish Honap <mhonap@nvidia.com>

devm_cxl_iomap_block() claims a register block with
devm_request_mem_region() and then maps it with devm_ioremap().

A driver that already owns the parent BAR needs to skip the sub-block
request while still mapping it, so the request and the map must be
callable independently.

Split them into devm_cxl_request_block() and devm_cxl_ioremap_block().
devm_cxl_iomap_block() keeps calling both in turn, so there is no
functional change.

Assisted-by: LLM
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/regs.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index ba1f942d20e1..9235520b2f4e 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -177,6 +177,20 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, "CXL");
 
+static struct resource *devm_cxl_request_block(struct device *dev,
+					       resource_size_t addr,
+					       resource_size_t length)
+{
+	return devm_request_mem_region(dev, addr, length, dev_name(dev));
+}
+
+static void __iomem *devm_cxl_ioremap_block(struct device *dev,
+					    resource_size_t addr,
+					    resource_size_t length)
+{
+	return devm_ioremap(dev, addr, length);
+}
+
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length)
 {
@@ -186,7 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 	if (WARN_ON_ONCE(addr == CXL_RESOURCE_NONE))
 		return NULL;
 
-	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
+	res = devm_cxl_request_block(dev, addr, length);
 	if (!res) {
 		resource_size_t end = addr + length - 1;
 
@@ -194,7 +208,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 		return NULL;
 	}
 
-	ret_val = devm_ioremap(dev, addr, length);
+	ret_val = devm_cxl_ioremap_block(dev, addr, length);
 	if (!ret_val)
 		dev_err(dev, "Failed to map region %pr\n", res);
 
-- 
2.53.0

