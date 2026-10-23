Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770074;
	b=PUnqWUFMzkuVNFt9sw6eAtqiigKfUyzATxteTPNWg7tXxM+lib2jcQuFNKcpXaTvecIq
	 xZUKtPbr4ik27vOx66WSSKDW5Z09z+Gn8wNqVSBu5svHEttR8+Bcs+VbE0MdWYNo6DY95
	 iOgW1R0ZF8/YZARz+GJ6X7NUjPYX5tynkFad0J/v1iCvs8emCRWodCVQTOA/TXOXVzW6Y
	 Rq3qK/e0iZQssMaHBCIiGdWttP3xns5ej+836GX9e9OboYEFFtzB+nkVLQsl039dzoKXi
	 CsweI0iWYm9bYmPrLOoG+BB/52kmN8Axw8ENDRvByuGnZzZjOGRIg5z3SsxvTs8K9eQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770074;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	bh=vm3sGoOFmhNIaRBlVeFnpDCB0pFr0NNDM5GFjwzkHFA=;
	b=KmKSL0KeKL+iGORhrZEiXZDaXLRwlKPu/KqN/Ko7XYAk4cfKWU461ndCZ6omatR/ouMi
	 aLDbhxy+bQl5eSxyBQNOVhTwFe9pqNijQo8WoMrH6QyjaSvmjrmBuxxn6Ut9OS8mqSrIC
	 LK599mMuGtno7GRTvXJdQ75rhZ6aOkWR84EgKR7hh+BGIZabENV8TafLKk1Ls7o3OHESd
	 epAX8pd6jnrhZjIETO2DPHkGoyu5mg7B6vOtNJRwLyDjwxe7zdxj2gT/s+sUi0pDTlo+K
	 vEsehUfUJhtA94IiUHmeOhvYEhCf0hjXof6ldpAc4tx6CwqzrFRpljnurxscZFA6Jnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hz1mCZA9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.7
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457C606A31E;
	Fri, 23 Oct 2026 15:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1457C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hz1mCZA9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ2EqvAR0IhVUVjT5FTHV4ry3wrY11b/CpJxEPEtco135G2hMd8OYtmz297cUKoSKzbi9JP+kH+hvhsMDSCplYo0b+ZMqtWS9yBYujg5tNii/HRseIUJ3OkLsk814hZTPE/dey5mR8VEQZ5YAtlvsRroS86BVQxTG1N0EvN5k1rVy8buBK8qjgjGsopkCT5rODsxWMHDwCYCPX9qETAZpZbuhuvbFRZfP/HMjhy6pShOStHYnBi2w/3wHB2q+DKg9hkm/utckV+aSqS3mDff8Mf2q8SQY4M/KtrPRbmL//ZxSuoJhg2uyrfSbUn/rUkOPc/zQFJUvWcJ/GAGqLz6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm3sGoOFmhNIaRBlVeFnpDCB0pFr0NNDM5GFjwzkHFA=;
 b=eIJzDaXsDNjgDhqcLeH4UyB4UjiKAOQgfssecRIh9oExzCm4kqf+39m1pJfb82zxTr4WMCvMgzhyFi0p34RDwWf8Ajjo/qZmt7BdHL+/VbYBWNKOxzXlljn8yw3Yaar8tQMudUyJMqTSeKDb8iVxkYi9pq50sNzyGaH4kVEyJkv1nmzfMWLrvUc7Kw+7Nm5bOGhaILp6Tl5gLjqVEe5+MmKupy++PPcoSaXF6jZtg3KkmAyxR9SVGH0xoBWMNcEoBt/pdRcMVXoIcrcjyh1HZmABfGuc0FeLwLpOWDPiiNRENJzykvBwIM9QnDC1Vf8baW6pZJ45xhmY1QH61lNQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm3sGoOFmhNIaRBlVeFnpDCB0pFr0NNDM5GFjwzkHFA=;
 b=Hz1mCZA9wVpB+P8hLRsfBW3fP48lt4r7PUF6f0l5t84Us4xbiZlCwssu6DRJA7Tngz3Yl2Okr8Qr2A1sIZLdZ2ej6c49ug3KNeuS79obzYGYI5eBCdJx/WhcZt2jQ6pnWmwKvyUUHgnGLEBuqpHeTzy4pjOhquj1nlCoFiP8wyymbRI6rABevVbK8mJIG4qIrlk1VBHRtFMY9jIwEsEmSYuhTFvI39yzLuLeQwgTV1W/a2qO7ig4huM/h/Ds+405mG+sT0CA7i1heOluItnN80aABklJRfpqQ7IdITIjJCn2TxkwA0dCuKBPyd6U5LBqCaTXg49D3XFZOr8TFOg2Kg==
Received: from MN0P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::21)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 15:41:10 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::50) by MN0P222CA0014.outlook.office365.com
 (2603:10b6:208:531::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 15:41:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 15:41:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:43 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:41 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v2 06/12] rust: pci: add a bind callback after installing driver data
Date: Fri, 23 Oct 2026 08:40:01 -0700
Message-ID: <20261023154009.2246627-7-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023154009.2246627-1-xinmengs@nvidia.com>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea463dd-0929-41d0-1d27-08df311c0f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261021121427099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wUJZtH9yiRq3DwI9OkoZnGAI0jaUIXyhfw5miIPx7aw4KkkYbluvS+UA1igOYP3ochCCNUzP4tWVKXCn8R3AgVTOTlCw239kuSDirkzK6bEowgkar0Q0RegDt5zqe2GzdkzoexAWdfJXqZLNItBqTva/sbxpFpSGOuxk5hqyTm/QmWCgoc3dCoj4f+CI+zbu8tm24dkJlMPNgxKhM3ir5C1sWCmXLaaLWWkG0xVA3VWGP75ZKGYUYKxYxlgms/FFVKtp0vBWnzLZFbFncOeb1l3c4mmX+Sg5oiEe/tEXYwLSIpdR6MVTtYquigTF1bYkcaI8B5i2HJanFpb5TdVqB6Tr4C6Qq+14uuWLdBLbU8ioYyolMbnq2et0gx1tvkocfh/7qF9fXkhAYmrTRgMn+iBGZV/EGwIAOl6e8vKXYQNnSm1rw1lV2PB38woUAVwbUa6q9Mr1OhXIxRU1RfYnIPl4tjTvtIUB71N7ea2AXLn61BlmO81PvjTcrwrgHgLaQfpISvA/jisgrPa1bZfQH2+0HlyZOU1waF6UpEx5tVtxAgjmpwne9fbGbliv939i8kUPVCB3CWpCU1wx4ctLeSLRH9brhZGz8lQ9yLcfZIJ9b4WOYQ37LI+v7kpnJEVIbF9mjg42m68K/Y2ed6L9CwwdrO60a38s8yLPrSqbtNwG7qZBTGvU4+jN9ovAtv9S/kKKSh/yAl+HD27vJgfUOQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NuErgbWUF5O6ON3PPPewZgWLegZjJkOQGsUkDS57wrtxoYpKSlr9/Pdo94tvF27t24vYGa7wHMtRTnMq8hCnu2G48aOSusUh6H1eCNKcfuvvNUjL6xqCfpAxSXdDEGcB+Dixwe28gnGYQqYNYIq6MtNQ9fLBeiUhSMyP7jF7CgvYn6MZZVVftWU1SidNd0qW9PH/udZ4BDZRmlCs/hQtFJEvWV10MlX5yH7wqzS7MZaPxiJvj4biEWyw3QkgnZlbBsUqvUsoIthKY8vxLMvMluDAICrzOGJ0L5OENnRo+Q/wjN2bmw99VSWE4JpswnLC0/8Q6gEwlcpW+LxWTVL5XfaWPhsKA7+GpVCYJTU80518UBwth1bwob5JiKgUmkmkMS5Lqwn1CuOHJDSuoVra/i1nkO8EprbiIsIHIJMmJROt70KtLQ4XoH5+EFaVePB4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:09.9126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea463dd-0929-41d0-1d27-08df311c0f9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444

VFIO PCI variant drivers will use bind() to register their VFIO devices
after PCI driver data is installed.

Adding bind() to pci::Driver lets VFIO variants reuse the PCI adapter's
probe and remove paths. A following patch removes the duplicate
vfio::pci::Adapter.

Suggested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index adc7e92d44e..1951b3c8a5c 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -154,6 +154,13 @@ extern "C" fn probe_callback(
             let data = T::probe(pdev, info);
 
             pdev.as_ref().set_drvdata(data)?;
+            // SAFETY: `set_drvdata` installed the pinned `T::Data` above.
+            let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+            if let Err(error) = T::bind(pdev, data) {
+                // SAFETY: Failed bind leaves no callbacks borrowing the installed data.
+                drop(unsafe { pdev.as_ref().drvdata_obtain::<T::Data<'_>>() });
+                return Err(error);
+            }
             Ok(0)
         })
     }
@@ -416,6 +423,15 @@ fn probe<'bound>(
         id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
+    /// Complete probe after the pinned driver data has been installed.
+    ///
+    /// Called with the PCI device lock held. On error, the data is dropped without calling
+    /// [`Self::unbind`]. Any callbacks started here must be stopped before returning an error.
+    fn bind<'bound>(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) -> Result {
+        let _ = (dev, this);
+        Ok(())
+    }
+
     /// PCI driver unbind.
     ///
     /// Called when a [`Device`] is unbound from its bound [`Driver`]. Implementing this callback
-- 
2.43.7

