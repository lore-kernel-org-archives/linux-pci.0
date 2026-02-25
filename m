Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139583B8D4A;
	Wed, 25 Feb 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026723; cv=fail; b=mqMJdjedEDc8JKKXVxKfUN5QktZELCuMt678XDdImRR6VmpNRN1OMRePsuHbwJAK5kT2z0LP5gp6GNE/ITXu3sonhujkWDEQbLRqmuU0IVx4ZfQYOGKW2FyLvWHCe+eXymgTmP++5ClrJ8HyX1AwIh6NvV95rZuOTo7h8VM/D/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026723; c=relaxed/simple;
	bh=gWYDnggoJ6Sw/m2mTiAPMhbPapxYTh76Qkyg+qtd/P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEPxliDruZJ6stonOTWwIDYOPg2aEQd3E4aZ7iUDmQGwnMQ+OK81t1IjAwq5fl5jXUT6CGPYspS0a6q/kLiP82Csef3AO+cGsbGbF+uHh3nzru1f0D+ZTXpVAPXAO/i4Z2a7if8K6RjtnBlesBByrAEgXaXsRAm7ILhxUqII7G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHRzZuQN; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHRzZuQN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDTQCVccGhJgGKVKqm9ZSRYysEn4RiRn/kkp++YktNHnE5roMup9PrEpZ/HdQhnWJdQ5sqZKJ6+qDHDsG3V8wH4uCwi5RPp+qVtHeBGkqf+9D9hJfewXoqVGeoFfkkAXx8KeCuXOBxttH8MARwQT2Zuv7WMaxtzzqFEC/9MgBI6iWrcO+l2yGyTca13mlBrJaPKCBj4L7u2X+vt+nL3V+T1AH9a+nc+GZEn74oONh4ET1/tvzWxtQuvjFP3tAx/sbY4vjW16q/ATwWwy4G2FIDyXZqJ22XZC+m54UiTajZ0zyqq31lkJETrCBSPu60SXRYG8m0AmSUvFscOpQcplzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrIf5bMxaUVHxclsyOD1Ci+26vhRkxTO/n2qDolVqL4=;
 b=lBBXOIsc/GIGw/0XOXZigdlhjwdQp+eakaTsF+Xooi9dLEp1deC5cImUUWd1eZXLFxx+G5KjfuWA4Grhii14aMhxmql5jvfiZroFdT2rb6z0Xzd7A8QUFCiKQFlDuFr4Ac/2TUurWJbeA4mR/FXLRh3RV5CDjJm+QyPsgureTby6koyV1fT/CNlk9OIjOfhz4Py4eCPWxNgs72/HKTF74yj6VI08anRt0xfu2zRpuNzPKTcBKwMW31H17jg8iGhzi/Ia9A7jWrkuWHWDuscQ7dBUK79OcOwrbBULmUWz3UlvPfSEL89bzUyJ5HtChxfMtPYJItDV3PLIvo0AbcoPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrIf5bMxaUVHxclsyOD1Ci+26vhRkxTO/n2qDolVqL4=;
 b=iHRzZuQNLR06uEJkubUUYwlOXRiYf6QCqWTnl2EUBUKwyAF5HS45nV7vnck9Jr/UkM09d8Ye0JSTjBVTvZuu2pxXcwOQekW1wuhY47FA2wRx4K0X+TOt1Hb8PmkVnnTFtIEAoD2II+dKiPpx03WKRXrACtHG51MjcuwIAl5VSHXM3/I587TrHgn1sK/MSYwU8o41ZGRguzpJhjCGc8IbmJgw30T4auqeEwViMiSdg3mV4bw74rJgEeBwfWIUUBN0B5gCqx0R+xS+/uNmaDC0r2b3I4+CGG3uJeej5DqPffkq791x/e09Iqih09Guu9nw76r6re94CwcBhU8aFYeMfA==
Received: from CH2PR20CA0021.namprd20.prod.outlook.com (2603:10b6:610:58::31)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 13:38:36 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::28) by CH2PR20CA0021.outlook.office365.com
 (2603:10b6:610:58::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Wed,
 25 Feb 2026 13:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:38:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 05:38:22 -0800
Received: from vidyas-server.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Feb 2026 05:38:17 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <dave.jiang@intel.com>,
	<Jonathan.Cameron@huawei.com>, <raphael.norwitz@nutanix.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <smadhavan@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V2] PCI: Hide SBR from reset_methods if masked by CXL
Date: Wed, 25 Feb 2026 19:08:01 +0530
Message-ID: <20260225133801.30231-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260220195259.2397847-1-vidyas@nvidia.com>
References: <20260220195259.2397847-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd51464-a2bc-46a5-4b1e-08de74732d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	2OnjpZWTbXI7G6QiitJ+oEHalpys1CVzgt92A+DbdEnsL/hBsGzz2UZDTZeFytI+Jo3qwRJ3TPvJeWAfEgGGoref8eqaFlVAIf7AbJWjoA82O2WVOZvWaoayFqZ6zBygYLWnyFG+rZHnz60RjnO6sqTVjBz4Nh6Oe+96jVzdPkg7ez6WHtZc3Xy5cz+0S+kwhKJHGl3k0LeUVcz+XnF97oB2j0RC3fRa/8P2ip9btqAJn+Rie7mmKmCVpxExp8Jkx8OFFoujdxy6YnekqS0U7Im+cFGdFJYd5cS2FzdNWA5I199Z2/Z1KO2+yHkglnezANtobiJNflphgaGCqJksWmk5DDLIHknX7fN74QsN1dBgl1OVB9W1U0h6xptBGto7qXddn5jif4kL9/EibhN6E2ojDAuZfyDe73GUpCsE4gSoIvdWFnHA+dtfjse6SUA5yUTPf6fF3C0ydKVD/4e0cq0EAijoUMV6v/bcAzpmwkP27Z30Kt7Cu6S2pkvAiXk/u4HeqRVD0bQTe4DsNXfI2wbr7wsQ8WttDHEfUyY4E6RCYnpDfJUX1/RwxNYX8/SNGTOJbCyqBo7+ai2gMt8bO5k36DmGuvEEiXyIFHtoDg/KwkMuVnw5MXVaR2maW7jHTGFnPB5W9F0RLBFs3c+q75+WpWNoXMrYvwqkISRe264pw3NBOf3yoZ/jt2dRP6KLCcgEkdyur6T1v9d/txfu2IGsAEFcYHyiw0Cdmq4+ajjslxevN580zJH+T53KTWTAxGACJYZoBH+/BJjwwXPEIEq+GsPUBFSQw5u1DOe4Eyua0cBpLA/eODZ5n1HiExW6sWNRhE6noAKHHN7L5+wgCw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dKupTwN1XRJcz20LR2h3dbHZqehqeOSJWE8Last2MDEPmEsce/VerjhZ3bo+KT2zwoJmbhY2kpnPfyMEUHClnYdjdXW++xImsU5i6LfaB+vfZW9vUh4d9FlKX3VR+62ES0su4kQFn5xI4lMQzTF2pEKoe8IE0d1YvHOdKKC4uVnL68hR2fM/FRb4JuziZcDm0dYcRUxVM7bXNHTSx/jCcdoYULVP1XuYYNpR8WX2QJtSQIF47JpJJT+BdE2UPkytZ8vKemJt26ML56Qz6AWlwwrk3q+9AlXUIT01sMUxoxAfMkawX4XhWCJdLhBQq4qofFz0tC2whOAxJDzB4gOLAuvTg0OPs3F+ZUGKD8Dn9VWBc6Ratyvm1aWUroiMYiBeI+6OngDC2ZN1TtIgm5Rw5DW6QUxj+hWLz2/SNeeCtOjLOvpExTj65q9TVC32F8uu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:38:35.8552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd51464-a2bc-46a5-4b1e-08de74732d1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604

The CXL specification (e.g., CXL r3.1 v1.0, sec 8.1.5.2) defines
the "Unmask SBR" bit in the Port Control Extensions Register.
When this bit is 0 (default), asserting the Secondary Bus Reset (SBR) bit
in the Bridge Control register has no effect on the downstream bus.

Currently, the Linux PCI core checks this condition in
pci_reset_bus_function(). If SBR is masked, it returns -ENOTTY during the
execution of the reset. However, during the probe phase (when probe=true),
the function currently returns 0. This 0 return value incorrectly signals
to the PCI subsystem that SBR is a viable reset method for the device.

As a result, 'bus' is listed in the device's
/sys/bus/pci/devices/.../reset_methods attribute, even though the hardware
is incapable of performing it. If a user attempts to write bus to reset
method or triggers a reset that falls back to SBR, the operation fails
with: "bash: echo: write error: Inappropriate ioctl for device" error.

This patch modifies pci_reset_bus_function() to return -ENOTTY immediately
if cxl_sbr_masked() is true, regardless of the probe argument. This
ensures that 'bus' is not advertised in reset_methods when the hardware
prevents it, improving clarity for users and aligning the sysfs capability
report with actual hardware behavior.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
v2:
* Before deciding to hide 'bus' reset method, add an extra check to make sure
  that the link is indeed operating in the CXL mode and not in PCIe mode as
  the spec clearly says that a '0' in 'Unmask SBR' doesn't have any effect if
  the link is not operating in the CXL mode.

 drivers/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f3244630bfd0..a176566ba56f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4915,12 +4915,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	 * If "dev" is below a CXL port that has SBR control masked, SBR
 	 * won't do anything, so return error.
 	 */
-	if (bridge && cxl_sbr_masked(bridge)) {
-		if (probe)
-			return 0;
-
+	if (bridge && bridge->is_cxl && cxl_sbr_masked(bridge))
 		return -ENOTTY;
-	}
 
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
-- 
2.25.1

