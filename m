Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16186345CA1;
	Wed, 16 Sep 2026 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583907; cv=fail; b=AXOEpqd+OCTafiW7n4cQW1etSA/VcVQPnx1M0XA2iXv3hcobsHu+m4yvTP8Ke/Mzfp7BUGpGpJNXPwCq20/6zBdpDB4yFyFVbdzgOtjKakP5J9v7aw/t2F/5BvHfnkSBabl2AACrjpZ+qFtekIydjFyh//Pui3fA1erpdh+A5dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583907; c=relaxed/simple;
	bh=di8V0UnXENs3iHFI8Go+7UcPcrvy7YaZFNWVFyZRa/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTjnueRmqhsPIEp3BpQ+IQbDotlh6+giylrAcB1/Gq4QR9J6oUS9vyPBuKE2wlGl30MdHYrZ2kPvdQLiK71G3KzMqTZR3SlJsvB1TJpiI+Xiv21i3g+MjMGOLNSZY6AAwlLOaE29LrRVbm1yMHsNSlNdPuxSf3Mhu9Kv6NNW3WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jrc7J6/T; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jrc7J6/T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8Uf94WPf/87hWV5s9SrZs3O1sFmU7Ki2MOCvEHxMKndFGachaYGJAglOCg4Fq5vPwvkmcqF7RKhepCyI46rirQ2TePrnZpIk2epLEpYZNMKrvUuuyg5UBtFV039MaKZukdZg1NDhKf/mT8y02IhwMxyfXtvaWZc+yUSeALSAhrFQpckMYWQNwbtyCcLRCBx0ViP48aF5HJPxJVGX2SJSi86jaJ6S06GMa6P7kPap93SQo49BCJsWuSniBb43gqeFv17W+otldga0wK3FGRLbbLq36LRCxUcq1CgiVwJ9SVsHHAiqvnUS/+bM3PGhuNtzu/BTtsYjwog9TUhyG4trA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbPZFmvv8n4tuMdBBzzhmcgYMGqKp5NrPSs43eCSLp8=;
 b=QY361iqrDg3nfIeNtUHNKzPGeBnfQyR5R049P7O+JApNEx5pFc7lRF9NSePyQzW0Q1UiauXzdY3DOmzC7OmBTgfC6FprM3FqwJmFNRa4aASmHZ3xnDQPxiw2H3PFpP8HpKW1LfXLVQlKqUZ9uqcTyjRITXM1kD/CcLTKgwGw7vtkzzUqeSTXeojv7wz/xtOhkQXXa9Bjedk7Upprgtvohnpu9HJ3M85JQnW2uP29doc8Rhy+TqFS77Ei8I86gAFgtppvPO/P1kFQkWjGxwOGnS0jU9dgUGSa4Zo28DJYZWwIdHCKHw0q4++g9/DnZKkmR0Hnb/2LtEjajit4bwMFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbPZFmvv8n4tuMdBBzzhmcgYMGqKp5NrPSs43eCSLp8=;
 b=jrc7J6/TSETvfVgS3aVj2qiSAsvNRYLKlr+62pPby8+44KBG2SgSBQZF8Bf8/CI1iHBuOmAooDpmqAksYGWQiuUx6O+bGLiaza9KMfjaaWy4oGklBLXiqT2suZHgUfVYjm6w+wm28Bzx9WRbBikDLOUY5cxCPKt8/RcKkO9NCChvjXZVZhxeRjelTOmTZEYLMof46iw6VhTagXfIz/gGz+0RZGlrZHwM8Qrvw1Wbt1WYdSy1viPMM7lUxHHZj3bCREqX2MHizQFJLgxw/FwM1RMZs8ZciANvDeFhs8Op7VssL1trZfworL+KFjf6+ywBTBSZmaIPsEiEH+Kcguf4JA==
Received: from BN9PR03CA0382.namprd03.prod.outlook.com (2603:10b6:408:f7::27)
 by SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:37:50 +0000
Received: from LV8PEPF00000068.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::7a) by BN9PR03CA0382.outlook.office365.com
 (2603:10b6:408:f7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 18:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 LV8PEPF00000068.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:37:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:37:11 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:37:02 -0700
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
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v5 07/27] vfio/pci: Honor -EPROBE_DEFER from CXL provider probe
Date: Thu, 17 Sep 2026 00:05:20 +0530
Message-ID: <20260916183540.3813685-8-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000068:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da68741-620c-480b-5b97-08df14219bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|7416014|36860700016|376014|11063799006|56012099006|3023799007|22082099003|18002099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	WI4l11Z1JeOWE9J9+Gt0rWNX2O71qgmDzP2ap48XhmLIsbzZKqRrYOLSjJ1JrhUzjuDSHMEUePCSeUtCzPHlqk45NuzTSstwGykTty5WOK6cTyaBhzgSucxr8u2XRbQgUfRM1kyPEtn7kLZvgMQDv3CAvFC/3MxZgnbKHVN87tcu2HinSOXj1ci5miPm8gUaXhD50zgq7R8Uqw5Q5wfWxvo65/CRmHlsyOpABBfyKb1rrOgWHr5O11HSHhUbpUEjTNK8DF9m3Zgw4Na/MKO2vKsVDWKKcbSdyTu3WpnAgUvK2Pd8RdZK+Aw56m44dDp/K2P4E/EDoIVRUWRTiVX3bBJICiuvGXaQkKKJ2MCPNwKz1jQwtufXDa6k6mqJlp8wTYijajIAkZpLyctq3/573suzb80++GKz6MT0GEm6zRSnEgKgQw3JK8JbhSzTTCXDnm75B/cd4RO9Z3wJvgww3IWv2+N1/QRambf7aysd3BiYnmg0+O6rO/QnYMUb9jijZl47PQGocE1uQksugD2+Tg3iNAIiHXTK/q3h+6i9z70qzTlgrwM2GmYHsYjL4nlTWW8UATbe1vq+poY7WbMuVH0M8xfvJrDf4+a9ShkotRNTeasIWx5XSEExM+x/WEALyRKOpuoYyZP15pxvhKAmD4k6R16ZmQ7zub9Mx+idpGzHuqHN6XP7vPXdNcEY3LJl70qBtfkfVUuqON2YH0wGZo1qAf/DEbAmwJ08q9vGyBQOsnA3F8kYxo8VV+sDJko4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(36860700016)(376014)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qZVkG2616mDv0OCqXInmIQnb97vGQ/KKzLbfODwyhcsRiTYBcXXnoRQf7C4avkx+M3lhPPcjMULFMt978hErWvcqj/ulBFaiPGEqjbKyYUCc0R7+TpKS0TPTHm+PKds8YxDR404DE5zmJrlKTPwIoCv1GEzUImE+5ygfGRDL3cpLpAgezZ47BF9dLueW9cdI4OS2bLU4wZw2xdbgoPv9sjNwAxLSJYQBeKoun7N0Y4pqxxqA6/owfOmhnGIxPMGsP/csz6yJlCGnx1wss4gkuKMp42jYJSzu2AvSvQZ6/kJKsivVudqHoclyOl3M27LYLk8SQKR928PKLMp9Ul1P1pI4sUDd7qKE+hqqtLDSieXmLcRgrHOvGQVkHXRJ4mKrQY4cSEV0lGNPcNNx8kWSIOc063y4jEsMiy77J9U0Uca8JEe0coKBCp6iV/vxlC2L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:37:48.8320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da68741-620c-480b-5b97-08df14219bca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000068.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

From: Manish Honap <mhonap@nvidia.com>

The CXL provider .init() can return -EPROBE_DEFER when the device is not
ready yet, for example when its CXL port has not enumerated. Handle that
return separately from other init failures and propagate it, so the bind
is retried later.

This keeps the deferred path distinct from the general failure path that
a following patch makes non-fatal: an -EPROBE_DEFER must retry, not fall
back to plain vfio-pci.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 9eede1e56ab5..a63a4f5228b8 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2262,6 +2262,15 @@ static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
 		return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
 
 	ret = ops->init(vdev);
+	/*
+	 * A provider that is not ready yet (for example its CXL port has not
+	 * enumerated) returns -EPROBE_DEFER. Propagate it so the bind retries
+	 * rather than falling back to plain vfio-pci.
+	 */
+	if (ret == -EPROBE_DEFER) {
+		vfio_pci_put_cxl_ops(ops);
+		return ret;
+	}
 	if (ret) {
 		vfio_pci_put_cxl_ops(ops);
 		return ret;
-- 
2.25.1

