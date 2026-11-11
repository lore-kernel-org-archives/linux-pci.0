Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436486;
	b=yvV79C5pgl7fW+FADrdW/bLOvD/S+d082jyMeE6B8iX2MmnljQcCKA0C0qBxeHtHWL9y
	 MolqT7uSQS0UsYIk966vr9WnDDRewt3L6iO76sdd5I62Ole/VH3PyT2zgfo44/oZi0oSo
	 Ak3bIau46YeA6hAd1BmFG8mNFPMYAGQcFzCfFllCuOv/4XEADf4qLOX2tNPC8LRpfLCpD
	 AMnKAUpc+jd0RR9fXK0wOVzcErFnYhLxQz1U1AFut9BJL/1CBQXHXnhts41LLmeedtbrj
	 z5j4cfZJEzsuCgWX0RV8rCxBzyHst00QQ/NhcfmVCnyEHW6MDxJ2+5hJvnODZV5bPXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436486;
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
	bh=DH+QGrmZszTdB+T3jN3p3N8aHc5Hdya0uxXkQdNj32Y=;
	b=cghLqt4VxrSVblBYW7DWTMVu6lop8FHPjD97ftlzK/INUKPnYQADJDH8sRj1fmLFEz3O
	 2fbYusjITdRCeR+z8zcevIOAWC6+HD0EF7AscWfkUr0g7/3Xf7OUFSZhjfKM53DnHqSA/
	 E6YG1TLplVsRcW1mA5SrZit4WPunaXum1GERN44X0a5Z/6Tz7EBrMPGdIHtVFDZUwkPzh
	 /PexMM2ZWw3x3PbjfS1Zn/NsK4h97j2jaM26KUWphjsQsPM9KxYeNBGXLuEjpfhO/SmmD
	 EN8Nz6byeraz0lpLAHCcRxYikqVnxyfI1phYa5R+mNAWhWj05N7Cs78v6vim8po0FCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y2CK08TI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.5
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F49606A333;
	Wed, 11 Nov 2026 22:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F49606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y2CK08TI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7cpmKAA2nlGDxMkaHFiN697r5g8Jr05n5BYNTOXNgpEQ6M6D3Rf4TdylwN7JZTIIKmInKWHIQScdyyDZA/+PukyvS/AbgaCIcPPa09o2giaAOCFDY30r+MRz4HMZaOYTnLvQ5aT9EO5zjm5ktmNIrIPOszIHqlYQVgld+e2MXBHoeZ3Tw5F+2J+1PDwp4k+J7wrQzEht9DZhE34YZ2Ue/SbzEEH3KG3YELl1LDJAmJltjFFwDjK88J85QPMbWQ3BNvPN7WqS/j3OfHOUB/KYRZjtSUtan+iHE3HyytI8y28V8mo+UXOVNe6ON5XpO5PT72Mk3nydgYBhvQbnRdEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH+QGrmZszTdB+T3jN3p3N8aHc5Hdya0uxXkQdNj32Y=;
 b=Kaxlo1CLe+l6eAeC7HOKSiyebWv6znnB0gW4jLAgLcJZyFIxoMffBC6NlaZ/xmS6GTJeY1eeQ4IgXCGIKh9/0PvY/xUqFG9e1AouBwr3CUQlzwlIKtzSj18IdommAIEVl9QEZ6E7Ifn57Q9bA8FWwrA4qcZ5xjm4450wBtl55s7JijGA8NGoeIJyU1QUypHYD7e9msVWDvjkO0Ud5GKmDv5v9ZieNuEzit5zGY74NXW3DY0ydmPZM/A9fG9GQTY70wfaLH9fkXCZQi/g9OjVI2mnUVjAuJz6qdp3vcHZt8FOVvnx6CAPOJWecYSeEV6GqUrXIfQUJTSVCUz9p6bOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH+QGrmZszTdB+T3jN3p3N8aHc5Hdya0uxXkQdNj32Y=;
 b=Y2CK08TIBG2caXuzA+cc+mkABKxhWXChS2giaAxE+oQm7083FK0ws03Xo1OsHXui3XidrtCHfabqrefHJP7Iqs8q3OkyTTDRHIkSCmR0tPcpfAd/DJfleHRpVKOAtHnVpH+iLgGP7zp0cx1en6S6nfSurN47lzNb3hIE3IJauxF6GXc0N2B3hnyj5W37fUjMSnLSXeH08DxjGe86wjOefbyJ5jzltH10fF+P7ltKKDqmNUE4umX/3yg/VrMFcwCE9hDS8YeJpKld/BHT3pRHDK1poNIoW/xVRdG2jzbn7XDQsr1CQKcHd6TtetwldfcuMTvo5h9Q1ckxFVoZnkL3SA==
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 22:34:33 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::47) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 22:34:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:13 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:34:10 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
	<apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v6 06/11] rust: pci: drop driver data before remove returns
Date: Wed, 11 Nov 2026 14:33:31 -0800
Message-ID: <20261111223337.508989-7-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 71eb0a1f-d9a0-42ec-b491-08df4043f519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|10067099003|5023799004|11063799006|56012099006|261022105027099003|261026140227099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Y52RtpHoNWK1MeSyiX936SLLWmXeZesoi2aIVnu1E1q9xRuiuYyxRYN9+k3CfyggR0K7B/WSwgdhnxG22yv+WZv8KVDdbWP8ZsrYCp2ITrrhYWpgUWEHzbWDEkdfeTfP37qeZ1v09iHG6L+DjuaIFWO0xAKg8FXnXdJWhLnIKMXt3pF5rQy8tMjOpnSyN3kt/7EYu6jV5R9kveynUHgnPhPNI8TYtVCpLIevrrNlW4a8FKvvcGQq8nmbjmymkO5tk6FIy5JlGI1WyUaRR+LSGSmt6AjjvD4zKlYc10nROoeOsO6AeQ7AHCXJDtW9LIimQ7+nEaaF+0fVWDHIvpeUC1qrEjaVaeMjuyP93XN+jhPiZJJIWQ/VlzbS846rabea3in+WuLYeBLe5uTxMYnJKCG1Ju4RSS95d7W3m6jk8vP3kspXMb278NGqQ7cyfXHh5H3pRSR1oKOd0v4hGDH5HVRomq7jFpcOSd6cLFYf4ygTHaLyN7YnOZ72j82bCjP3b+oOwre8aYJBTAVSl/FDrUkA1q0jQznPlW+F6kJ8WL9Ssa+Ta/K4pZA+0I5znGH7UL+EXHQ9WLvTCcKoTjXxZICrJaWw3rhDnDKLeZofWd1WFz+Ize/n8q8iplZ93Blkg4lU5/aKFl1Q9LGThtwfBlot30SluTa0000J2W1RX7BgNM6+Mh7KDQU1cO0v8kFp1wPutuCS8lMJih78vlmaJg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3d+wACvGeBePouImMTgPH/Yn4yx8ZJI7B9lQCrW6ZgFFvnwLOGXloEW/NzgRG0MJ/7101vfC8KIszOSIrh35sSq9507P+qf0YMps73cQC2/FhhyhhVaTmVHwokInCWwL5qgmOXCTilL76G7r7NmUQzn9YLTmGxSHV4I9c0e2eR2O1A2yPLNerlf1X7gKREY6+MW+QJDd88oBXTUWrxSL7IZLiNg6IAO+6/mPOx+MraxVAh5nFXXDN7i9QfKtQ4onwSYwdwRqJUPBVHmcLJT8W5JCbK4hrrZRRWd7NlfxyiWtRQttXahnTaTN/3fWRSk0B8aBT2G95Ol+kcfLypvxDzblKEuJxe28cKSddqHY8/qaa6jrdORrrlm1C/KqCU4JAcmLSN5fcFsepAV3xlzTIwPobU9u+TybBicpjNRM3xBh8VBhDwozz7Ai8I0LT0lu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:32.7508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eb0a1f-d9a0-42ec-b491-08df4043f519
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847

From: Zhi Wang <zhiw@nvidia.com>

A Rust PCI driver's private data is currently dropped by
driver::Registration::post_unbind_callback(). The driver core calls it
from device_unbind_cleanup(), after the PCI bus remove callback,
pci_device_remove(), has returned.

VF drivers will store a vfio::pci::Registration in their private data,
which calls vfio_pci_core_register_device() when created and
vfio_pci_core_unregister_device() when destroyed.

vfio_pci_core_unregister_device() expects to be called from
pci_device_remove(), and hence can't be deferred beyond it. This also
makes it incompatible with devres, i.e. a
devm_vfio_pci_core_register_device() helper wouldn't work either, since
devres_release_all() also runs from device_unbind_cleanup().

Hence, drop the private data in pci::Adapter::remove_callback(), so it
is dropped before pci_device_remove() returns.

This is a special case for VFIO-PCI. In general, a driver's private
data must not rely on being dropped from the bus remove callback; any
point after the driver's remove callback and before devres_release_all()
in device_unbind_cleanup() is sufficient.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 9e31b9bb4d0d..75d764975a4e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -149,6 +149,19 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(pdev, data);
+
+        // SAFETY: The driver's unbind callback has returned, and no callbacks retain a borrow.
+        let data = unsafe { pdev.as_ref().drvdata_obtain::<T::Data<'_>>() };
+
+        // Drop the private data here, ahead of `driver::Registration::post_unbind_callback()`,
+        // which would otherwise drop it after `pci_device_remove()` returns. `drvdata_obtain()`
+        // has cleared the driver data pointer, so that callback finds nothing left to drop.
+        //
+        // This is a special case for VFIO-PCI: `vfio_pci_core_unregister_device()` must be
+        // called from `pci_device_remove()`. In general, private data must not rely on being
+        // dropped from the bus remove callback; any point after the driver's remove callback and
+        // before `devres_release_all()` in `device_unbind_cleanup()` is sufficient.
+        drop(data);
     }
 }
 
-- 
2.43.7

