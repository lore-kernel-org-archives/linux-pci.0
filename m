Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E844471C;
	Thu, 13 Aug 2026 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614040; cv=fail; b=VsrAYEisGInXXK8cDC+BxKyAtfXKpresub90llTn9dEeESXAcbH9MkhwkfWDbx6RQFMO6ONG/L4KsiJZ7CeYy7W0IAIhiz+vHOlDs4o8sZQK9H0/eIU1VnGgANeSTKnmWVkuiLOZUaqcxuX8dKNcAvUHM/9efqudLMOx/BVCWgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614040; c=relaxed/simple;
	bh=nYlutzOuAPzg3ApQ6jhlDNiDhDYfd+QM8jz9FndV2Mo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQQ3bcmLUJAEP4HUOvHaGrH28VJmGiRD/fqzW4Rh8HNPundTwIcwp1a9a6AJceW21VWllb7jUaOsojCuSyk1xMt0DBf2FHa7DLooUyt9NN8oAK/6F5yFjA09k7LdTpJ6FAhf/iDP6L5qzShncEFfDhcR94ha7CiOA7IG94CBtBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d12uZSEa; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d12uZSEa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybWP7Ra1oW0cmbZIy8vhmsa17diKzvl1fFRQUzfGyjuioF8vFN/iozoKOh0Pd/uEGbWLFJTNxMFapY4+iBT2HTGuiNR2/xwlQ6vsv5v2D6XdyMXy2yjX4HBQa1XOKt6U+WFChYImwIWscF/ysNdiSJUKT2Z4WFwruGwE6o1TeRK95GcpjeF/Fio7biGSs4IZVZ3sAiszKVNXr9VX3gP9DzeNCObIfNAlfnI5Rb7LWU8IF1me3GFRiLD7T2IsbWosEWzp5Sivp7cv4Mfe5En3XtmaQTEstY1wyGLhKIJERA7JP3SeRKqeljX7IXQXedYoSlE3AcO+g6+zq7EwJxge3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SUXukbgJdWeTaK3H6ECd1tr2WOd6mgpWhi4vyVT9aM=;
 b=y9dFH0vYoZUy7GkJDF2D+BuU7DV5mpwoIo/YK/QXQ7UoGawVgoIxoFGR3OKhPEHvy2/ukQeAtrIVgAosvk6/Gzy1x/P9qQf/S0p4eLDEHWlXMK4Q2Dm9UkKKyW2+H4DqFmysZ23IlBj3Y0avQzYJ3JH+83i/7E0xgrwZIz34FIuygySK+Hn3yGB4lCQwLYz6LxrgBkTpBVBHFIZkN8XwZhW4mClUSh6gLjnI7Y0C1jPLEmr7m5zwqsVIChhclG45YMkAvy906oywQbXUnvxd/FZG6WS6c1RLoyq65T+8woLRrB2ZJo4FRLsg7fECyJvVqY+3obyx4cXWcFB8DmPzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SUXukbgJdWeTaK3H6ECd1tr2WOd6mgpWhi4vyVT9aM=;
 b=d12uZSEalCLSN86PDcmadNtXierewy/i5jCSnnNnMizY0suZga0BVdDMiRfl6Svk4wDHnG5mW2X2ih+1VsBPMeFAtXjKlApn758XGbaJma4ifLROcTp+G0rzG47jg6vAl4vQ+3nOOcjS7qhlz2zM5LumsaQ3YzxVqMK0bgT4FQqsBHantTKkMC7xZNCUfKjoBhs01uIi/s5g89ltVHTB1QrquWr+83yM008bcug8vJeoZvxXS2X39Z70G/HEdcC/2u27yO69T0VyVDhMLLlXor8jJ4JoyDPfOpclUziO3Bx+meZS7BqH2fd7PP8KSVoeDq/q5WOc7zetck60hbje3A==
Received: from BN9P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::28)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 09:40:31 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::27) by BN9P222CA0023.outlook.office365.com
 (2603:10b6:408:10c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:40:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:40:13 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:40:03 -0700
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
Subject: [PATCH v4 19/27] vfio/cxl: Keep the HDM decoder block off the direct BAR mapping
Date: Thu, 13 Aug 2026 15:06:23 +0530
Message-ID: <20260813093631.2288172-20-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 76aa5285-9e79-4b2e-c690-08def91ee9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|7416014|376014|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	pbHJJaIDGNIKT5EQMQtWP0IK+O2bbkj337g9pC6fLUpwGEF6hbwd1m2JRneLKc2EYzjEfEUJBuBW7Qnw4VA5YCrMRHaA4dj4lWKG5Hc42ZhbmaN9nsBz7JqNKKD8ihDZWvwYmDBMz12rmw2JjsBOPkOkFtjNHjzWmdWQ7Y+EeaJPGgDXa6uAWs5g+KFjYhKe/54vWpvi1Jgc4/99ys7RmRpWljHW52lHJ/nui+x3SYl7bGJidVRoP3+azvyfxhuTquCppQwTVdx6B4HmY5lNgcgK5bqbAoU09WO/fNhvqMjdYD7rybDmOmBuQS82h3383fY+AgtbrDt1K3xM1p1QlDZHuD0WJ+5JKNQ6xEDFmHAZhD/oVVU6ZX/3HMx+fshagjq7lqZ2ppHWT3kgwVI2hFHSg1mSakS3tK+rvl+Gy9LdfoUhwgvuHkNjgwDKA9uylFXckjW3HdZuuEG112+aWJ7q1ocjC9QlTTjAzF87LwWNy2+ByEOTdd+MabI2Gz8XVJ9sYb++8a48mcLzcLErTlZLEAyYNwSZIscO3gTCvYX3F+O7uqUCOWODI7QHsVPV2uS2ekiPvPIrHZwJlglJy/MwFZjXXgp8cgNxqd0AJOv2SVS2tmRKzmIaY4BFDHwu/k98oGtn7GXrM/nFSjp4UmFmdZ7FZlTPswuQbAuBkMGKfJpYIk4tjAfMdFLOeoKrEQYcD1i+xny997acqgWA1/TW7QDv27GT6Yt3PR+Nb13mDCVUVQA/NgEV4EXiwOVp
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(7416014)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sHgP1buHzNwVkboliG6bqYUYDhWtJPG5vk7sfamL7H7odXqHVdJd4diKAw3271mj4JCR1+h9GXYoj+ycPlnyYKAcIw3RGXl2J9kbmx4bcp5+Y6GOwZ0/1J3wHGbNQ2NtDtduSs1oU7G8J+1mW8fP17Cq7dgTHMV1CRM+sUDEj5uVpf+a+Dy9klwzGIm+6tBsyVpDCspcji3Mt0CAW3UoKghUPy7aidxCaIqezxecJstqXCidp1ZuGB+hbkVieEs7bwEpGomr2vwlnRV0jwNYQ/GmqrnWNv7ITF/+MeH59P/VhhzDt5vaSIQNtIQ+nB9erR2ayeCljul95WWLe5RlGtN0NUxS0+wmfrc/ocXIAU4/db9W0xR/Iyv7a95stMKCdnNY3sFXbeaixxo0/BBuVZQ8oFftHvD78vNibo8Iwmcc6Fz8f27qHQkEQw0J4XQe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:40:29.7427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76aa5285-9e79-4b2e-c690-08def91ee9c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

From: Manish Honap <mhonap@nvidia.com>

vfio-cxl owns the whole component BAR and serves the HDM decoder block
through a trapped region that runs the commit FSM against a shadow. Left
directly mmappable, the same block would let userspace reach the physical
decoder and move the host physical window. Exclude it from the BAR mmap so
the trap is the only path to it.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 07047646edde..f91f6eb8b8fb 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -339,6 +339,14 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 
 	cxl->hdm_len = pdev->hdm->hdm_size;
 
+	/*
+	 * The HDM decoder block is served from the trapped component-register
+	 * region. Keep it out of the guest's direct BAR mapping so the physical
+	 * decoder, which governs host memory decode, cannot be reprogrammed.
+	 */
+	vfio_pci_core_set_mmap_exclude(vdev, pdev->hdm->hdm_bar,
+				       pdev->hdm->hdm_offset, cxl->hdm_len);
+
 	ret = cxl_set_capacity(&cxl->cxlds, hdm_size);
 	if (ret)
 		return ret;
-- 
2.25.1

