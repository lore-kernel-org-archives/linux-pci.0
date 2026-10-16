Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3A542EFB;
	Fri, 16 Oct 2026 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167805; cv=fail; b=YR7B8p+SJFYKID7ZoaYsUq/opSlFN/VcxPOHyUP9ocFDNTxCBmgCsHYa1FIYUqluTyY0YqbZQAg8l0mMkH2VCNybhwYsPtEg1ZvVCEI3Y45t9lMoNLcT48wTZgIa1jwxdpoLzsZRTBa9ehjyUs0SO7uF03JPtjJt3EEDI0wqoHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167805; c=relaxed/simple;
	bh=kzlx96eoSiNNI0EcWoQsHXM0LucXUr2AI+BTZzZLlYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iL5TGeVPhK3x2Guw6xe2LjcfM6HFTfMSnyl9kD1EeTQ9nhx0sSfWJ24AeWFEk207BFRm4mYmBc/qmf2B/3EuyGwbfe1iQggeHacqCjECiOa4XnW12G/z6eN71TMavmBEqDW0fER7z8SzkBJ+CsqE+1rp473KKrdTQy8PuDVBrzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xt3yb6/w; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xt3yb6/w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4iMZwqIDjt3NaQH17uJ+n9m80Za49eybVQ2Y92fd7ILrXbuFqPBcm70DSWr25JXbMSv7Ozm4fV+B/7gxqYec46skBs2aU5rVzslliv5Z8PLThZIJBl2w4ThdYrEhXOxl+kMmRr8Ik5Y00sDGIl3/KvzzYYKgqBRF5Y8kD0/0Crnga7JMANo2LAkC9xcN4gf8Mlv5cOH52YMecln6jJc0TeOQBKgNrjl5VhGyE2qRMhBW6dInXckFWNRHKYbkmd30Owvb3mXexImPmXtFVbT2cWtCx182FgiRaqoXD8jhPMo2SlYTUlT8M3+ZveNkUS5R0P734q9spHMv/ctrPew3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvuGEIszXG6fyApND5uguLAlZ7nQn77vHttm2W1TvUU=;
 b=KYrHBreQ+M3j5S/SuTj/m04Dj6pN0KhNs1rLOytENZ4UOlgJrmFBKfeOeOtdcaIWHqk9mT6VKTdMjF5VkxjSfeUhZ71n1rPEpNd50IifoZX2z6308t3hl4H5MEWJPoPv8D9I0EfUq2BWMoz8MZ7ds137Jh4JX6yKTQaBbD/rWEnikpp2KL5i8a1VWxZPT0SYypqoI0NqJkzCs/1ijPIEwHyfq2971Ls6VAtNTGfxd3/Lb+zUoyGzWp3Zqrn0m1XD6DnkEGaOjYc7DOtqMadHm/e2gSigVqzFdAXoR7Md077dByQv2LSnGbyYArWprKW89d2KUIhCHUMlBo8cK0Susg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvuGEIszXG6fyApND5uguLAlZ7nQn77vHttm2W1TvUU=;
 b=Xt3yb6/wbqDCfwS1dNqg6xhWism/XPiBlhOkzjxEU1QUyzG5p38FWLJ3j9AIT2OKWwpSn7pR9mp4bWhXuq5fXK1yZuLH4VIRWD19WeY9zhbAyWLyIJpFSbHBbJP3vyg1mY4lT2bRXjl9WELtkR3znyYNP5wafxg0XTQIl87W2z73PFsEFkxsJd+tXCB1HILXk1cV7fNScIP5mNj/yWVA7TNuWKxmY4xekKUtSPJYOvEai014TRT/q9xOUtWde+Gh1m+2IsZXIB/jH9FTXZE2ESC1DFe58W1xW50mZQTcne0Ol3ATsRM8JUcUWPbgRlLcEae2lOFosK3swEKDavlaFQ==
Received: from DSZP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::17) by
 DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.15; Fri, 16 Oct 2026 16:23:10 +0000
Received: from CH01EPF000BE94E.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::6b) by DSZP220CA0011.outlook.office365.com
 (2603:10b6:5:280::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:23:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94E.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:23:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:22:46 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:22:37 -0700
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
Subject: [PATCH v6 25/31] vfio/cxl: Exclude the HDM decoder registers from direct BAR access
Date: Fri, 16 Oct 2026 21:48:32 +0530
Message-ID: <20261016161839.2765592-26-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94E:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b7d5cc-5dcb-4f0d-b45f-08df2ba1c4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|18002099003|22082099003|10067099003|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	uOCa8O7WLfcJytOEUfq2mP1fHHYt6UnH21PwfOO95WvTZ4yPw5YjyC64n+LKiJyHm5dr54QpKXbnSdQpses9RIoEXPl7UEvo28wBFGTW4rI007dLjuwy2+XxIq0y1GgmvC6IG53sx30PphEDLgteOdahihjHnQKskGs1FT4BnO+KV+hQU+wVtJ9JC1Wudm4d2+Yo3MO6uMMZ3G+CKrGtdS72VmryIjYwlUrG+DiNj/97AWxKe6AxSt1aRTt8mAC9HA3SwUq9iLyBG/gIhbvTxsFIwzPbzKCVfYCkVd1KPaVGzpViPEoU212esB42dgDrvjOW0S9nEIPazLzOYjuCD6td4cXSwxl5U+r5DonoJ+vR5Okh/s+xxC6nypgul8+0DM27Gx18pwVqVLFwepB4w1SeEmlA/st0wSqTxeD7B8jvsmSJRZOcUQ3IWlFsYN1DO0vq6dXnVR2tMgjZwKgHcY3ythnAV+OO73Xf+i6VopA7UoniAm9kUd+WWsm9a4x6yIIHKpaUd6y25S2gkaQN9SeGvK3UDd/UkJKsabuf4Ip1ErF720xsDKsdToUgSJFjREgFSXqOJmLELSlkFbcYOh9qizTz6yfR+d3mYtLm0aBZWWBEbFT43XiJPxQajT84VDPyNx0ooQHh3YLNUxkDGLICA7S9yG9UDps2nBVgwz3aRBBNXYp8XB64guM9O+A6G1ylP1TI2Znqo+mnrXml92XmY/XUDuJaEeUZ0gJ/v8j3FSrKS7FTRPBf6OoQokx6
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(10067099003)(921020)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aintD0yG69kpYxw+SGNazxqfG8xKuzOk8aBPmMxECl/GzsOrsM8hLNWu5vOD6GWXL9VFacWg1bOoyS4ikbn6g52gamcta+JSzmclVnUD/UynmGOBZEoQLYmKMWgXEINA7PL0C/+i+HHxmkrGE3dRPJ22f3FabIBzo2jjlOfZstndO56+XOXXsN/4nztznsO7Do8kr+UXNwbriOhaMcbNDy678ur3C5KjcRuRAwky2phSZIJpSOEHEFs7ajr0DEUJQI2+CJO/p3Rt3smmJ69+jyHyMhTgWegzX1i0gNGZ0JNd19xltH7nEtY6Sxux51JXtPdhvKyaU9jctVEJOKN3ZOCA3uFPOR5JtHTSNxDK7+T8gGdC8cPQpZ3ru3Pi33l8Zjfw/Gx79YCQEQOy5SRyifD6Gb0sPcrCYHqdZoRgY7M3IFBqgrckEXpglrX5lN2R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:23:09.8913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b7d5cc-5dcb-4f0d-b45f-08df2ba1c4be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

From: Manish Honap <mhonap@nvidia.com>

The HDM decoder register block lives in the component BAR that vfio-pci
owns. The guest reads the decoder only through the trapped, read-only
decoder region; it must not reach the physical registers through the BAR
directly, and a write through the BAR could uncommit or move an unlocked
decoder that the host relies on.

Add the block to the generic excluded-range list with
VFIO_PCI_EXCLUDE_MMAP | VFIO_PCI_EXCLUDE_READ | VFIO_PCI_EXCLUDE_WRITE
similar to the MSI-X exclusion.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 4a8aaa765a98..68e898ee1985 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -614,6 +614,22 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	struct vfio_cxl_state *cxl = vdev->cxl;
 	int ret;
 
+	/*
+	 * Keep the HDM decoder block out of the guest's direct BAR access: the
+	 * guest reaches it only through the trapped decoder region, and a write
+	 * through the BAR could uncommit or move an unlocked decoder that the
+	 * host relies on. Exclude it from mmap, fill reads with -1 and drop
+	 * writes. The list is cleared on close, so re-add it per open.
+	 */
+	ret = vfio_pci_core_add_excluded_range(vdev, cxl->hdm->hdm_bar,
+					       cxl->hdm->hdm_offset,
+					       cxl->hdm_len,
+					       VFIO_PCI_EXCLUDE_MMAP |
+					       VFIO_PCI_EXCLUDE_READ |
+					       VFIO_PCI_EXCLUDE_WRITE);
+	if (ret)
+		return ret;
+
 	/*
 	 * vfio-pci-core frees all dynamic regions on close and on a failed
 	 * open, so register them here per open rather than at bind.
-- 
2.53.0

