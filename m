Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730872;
	b=dpPQY1PLRn1M7UiMLj3AtbpXZJtHj95/6zREd+FwehQ+byisfScMhnNcYz4T05fjlF29
	 rFnX9C8UJE4rzF5QQcj3TfpmvNTmKeMkJEpTb2a5q0ebEkQ9jlh5IJrzt6yfLZFpAxLe4
	 kerqh579IIDp4TIINu6XXr3lIoA0gunkLFjbDLzgcF053B3kkJhpQqzQDJPTRA3O4ho7p
	 q2QSqjRpooiBa+NyAVrwfrSx5hTT9/aI2ot+830MGrX0botvvTE52E2ghiANTXSlkxKFm
	 dd7rK5oEg9wMCZKJaGh5VF9JzJzPZ1JU8zZHu4Z/+3d4qmlflw9kNVOGGbMh2EtTgMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730872;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eLwOyEUoznYzMegz5hrKAknUXh8gD9HnRwy3b5eWdc8=;
	b=DyJuiD58YOYbnWZJmbuC4uqk87wmOuAfI/OZv9ioqshUdHx7//GVFOrM+uanCEw9gwxI
	 R0tPMtpZimSzvfku3r94ALRXYMxt0rB6IPJiTVAFM8JUiB+9DL5DqIQcTrySnEI3jetY4
	 bnsv6CHwy5bE80flTkkv5PUDgwhIPB9utccFSx7CPAMUxIzMmgAIGqvezyvsYrVQ1TEYr
	 JFGhIF9saUgbzt7NVZJ2u0xo/LwkoPvVNwOBz/RKDfldSr1E6HDPzmjWa84a0xDtm/ont
	 wHa1Kv8FUtuEeFfOyc38uv5xLCFAMlbZnHamRh2rsPuekuAWuObC7rX5uxgrM10uiZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l0VtXR4X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.68
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D5606A32F;
	Tue,  3 Nov 2026 18:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C65D5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l0VtXR4X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXI5d3sL/5r0d2wEjRSSrXcCjx1TiIxMItStSE6GALLyQPJYcmdlL4LkU/h4SCy15ycwZww1KvsKAhfCpqQQN/NptHGrx6WDDRsbEToPf/FtQ7kK8waECpmTz/FuoMRlBD0EJQijx5Xe+JD8mKOCA40Y9Bvw6tH184CRly/fyZO1jf8DF2rWldheXob6iXikfv0/3setr/puqFzCUbDLrK+vrVLBw4kWwq0hV4/76P6pwQr+xa/1l1F95WjwlHJ3m7e9V1nCiGaE1SUNS7W59GyPZOrYkZeVlWfnCPu/+zRaZ/Fd3zWGzp36bs82jw8haZ8D5As8u3Q+nljPHU8+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLwOyEUoznYzMegz5hrKAknUXh8gD9HnRwy3b5eWdc8=;
 b=T72gICg6TPXt3w0bVdnS5BCxwtzaSpYLcEYlZZ6fLQZKGq3AKNN0bOHXScv7DvLXFbV+GBf3t+Sjwg9gWw5dl2/enxj7Hs2GLqf/fNAfEtWaQnKiDlEShv8jGXwRcAPhWVgGwCn4YxqrZ+0w0dnTcgRY/U5WER9OQoQKlbIxcgzh+8dnFiSiGBx9LQ7kTZQo0y87RDOImb+tF2n6cpiyYvdk1TwYxJ81msBRjAnAxGA2svoVFnRWScAlLMJOwu1LQqsozkZeabLhSEq7bnWb/EX/tSZpE+cBOKwInkRucGNQKefIl0cscttiKkDtxX6XABHPMVigoqS25JWUwRMjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLwOyEUoznYzMegz5hrKAknUXh8gD9HnRwy3b5eWdc8=;
 b=l0VtXR4X65vPyj6MPxOPOgvStOne5syGhquX568ZgtveMaPexKDU54+rISznoxr+JLjM4s9QwejEFZ3EVmfZi2nphSoKSkajkDzDQp7BbGQ85AECKhFQAjBeW5aNYPVGieFexDNnZjAOEcWGcmi0QicnKtNfpoAqGw0yvaNOMoYc/agtZFHRElmoX3soIfmT5TK6/coe8RkjjBvzcKAXv5bYbyG8vf+A7NN+S9u1TkOcp2RJGK/HFwDq+DAdHR40munjXdTFgo3Du/BzJjsswyh0+4D42bCWVh/d90fZGedsJGfAjwHMGEU5aYkWi/JTDnhpHBhSfug5JZhVYw8+hw==
Received: from DS0PR17CA0021.namprd17.prod.outlook.com (2603:10b6:8:191::16)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:34:15 +0000
Received: from CY8PEPF0000004F.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::a9) by DS0PR17CA0021.outlook.office365.com
 (2603:10b6:8:191::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:34:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF0000004F.mail.protection.outlook.com (10.167.247.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:34:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:53 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:52 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:33:51 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Joerg Roedel
	<joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <djbw@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 2/5] PCI/CXL: Probe the underlying bus reset in cxl_reset_bus_function()
Date: Tue, 3 Nov 2026 10:33:43 -0800
Message-ID: <6c09d2f78d4bb9db7f49fa14a6550f5176721121.1793729707.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793729707.git.nicolinc@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000004F:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 8baadc4a-3c07-4be7-a20d-08df39d9105f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|1800799024|376014|10067099003|22082099003|18002099003|261102123227099003|261009223027099003|56012099006|261028144727099003|11063799006|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	qtDT4dGfODlXXuT5crnU4nYc6ooC1Xzh5XCDH4+5IMoNSbOp9BLmVs9qeNo3fNq//ArqlTcpw+28qsYo0T1K7gw7sM93oAV9wZbFdjqqR4wv7dUfMFhtIYWlN5brv3aphL67F8WA7wkRMdr+pdl2ksYoNTAx+IfiuSqrHLFZ4MKhvpNctogqSOIWAJJtVKbL7dYEYY0cfWa0ZzaieoZzIWDWzjVMgNuTirQv1fU3MdZejL8gGkBgHivkn05y8NVk0XosCcqDMuIM416QmMpONcpBDSKVJXLQAlRO7iAqGbs20lVbVOmRUULCicGRZU2sXhK998NoL4WPuVTUIgHOiqtC9XcbxFgdzYI8SFL61tQMfpIpJcE2uPpkQtZlFX3YowdVw/c4WDtIC00cdCIPMOkkirMkZagMl1IftKIPLsYeYecilf6tfoOzkuDE2dcyx0QR5LjTERcn8nPfVS0GCvGLyJDQPwUKV80WtQAb/eYDJ+F5vyZ6vaJWuwPFizVf/1U0wWuEJdXzUWTP3npbFUgt8q3x2WuXCbyhuUBbygg3YB+EKojL8Guc+N4B8J2M36Kd1j0//vzidHCGPw6w+Vlm6bUXieodP+JOIi4JWhDsvmzt3J1FKq6Fk3MNetHxXuQZkD52Lbpbn4I4bcGaGS47aL9cSNhcmRUmqoYma1Yti6waJS20DDA/K0dumyB8mEi+MzlE09z8u4YYYVoVjA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(261102123227099003)(261009223027099003)(56012099006)(261028144727099003)(11063799006)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	trWgGEVJohIefi3sDyKmHRAGKIDDRIy7idvEzodh5swfyn33lrTjRiXGr+0AmKyvoLwEi+sAxrIqRoNHign4FfueUxhmNsCbqkrW+SnUj/rURuDNXRYqYXIA+ScN6DTLy5BkLxgNPqJY1MbNJpQawbuLHuk6+tLmxzvUHua05W5Q74xEYw6iw1I4Ceh4lpeI0dVVNEaGXBWN2zhW9EhJa+kUX2wu5Uvhp3q67NfQkkm8UL3wjt6xfzikmzRWXA/NXNwwmRhRjcoTLht7yYnZGt9JAwZ8F6kqOaUyLxA3bpcRm821wCihASOpFsx7SxMmVuF0r0G28G0RU/PDDGU2Lv0xglyyTsYuQYmTR9JtABalOQbYljOrg92gijRXDpOTBKusHN6upU1pZ+8sqMX/vs5BmSqIpsjUnUBqVDCZgBlHGMMOcYPvJf8RG8YQe6Wh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:34:15.4088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baadc4a-3c07-4be7-a20d-08df39d9105f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF0000004F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 38b680e7c3d60..e9b06b360850e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5075,13 +5075,21 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
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
@@ -5096,7 +5104,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 				      val);
 	}
 
-	rc = pci_reset_bus_function(dev, probe);
+	rc = pci_reset_bus_function(dev, PCI_RESET_DO_RESET);
 
 	if (reg != val)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
-- 
2.43.0

