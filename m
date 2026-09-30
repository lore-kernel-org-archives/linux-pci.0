Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5634B826C;
	Wed, 30 Sep 2026 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765934; cv=fail; b=h4xQ7YcSsxMvgFu8pDsS2YrGPt4+1ukFRG8zb2C9Tp0a5bGHMyKLOCNmZStl3/5ZKCh/xOSqFA32xLTNXPTUCnbasOjenrmv+QNlLJGpGbTYNa6wMZuYG9BS9KhQgF5S61MOCWeHUpFvr3LM02UnaQSWmNJki8yHtKUoK8jqpyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765934; c=relaxed/simple;
	bh=1qZuGYJfkcLTyAp3pCPYHbIIr5dm8rB6AmEbynGHifU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTMtNsU6UzAukjYsdiFnQuKHDPleC3F3mV2+jac6bYOBzFD6l4egYSRDJWrRm01m8Nq81FvDXSphUFF3ZXuPFzp3Iq5gOJR4Qn3Mj0jaxYWYx9QQDrMj5DM2ebztPE1cApKqFfUZb0iIGnjRzG7/Fo+W+o9h2d1rViCAu5jRMzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KQCeekfb; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQCeekfb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVJhrjukIKovjeWDFfQJ8E8gZVI5oKdqc7UMrmEGMZaSgRhQUF3bSQhzfNbcFvtqOO3K1Udlne57hNcZtWCrslrN7b7j6ZU4ztItvrT3KfELA/jTodATPr1/KmB2MCHs8N1DX48/bD4KrbnkBSoBkKLYc3Y687Yogn+4KfW88AFGJFG+O2QDqlqqPHCqkiX6bitBlgG73FbFZfnb/woHUnXVEEA5ynXVp2GUWYTmfg7zJDWSjrqvwm1YkW8w/OrTIzqpW6m2sbhzDb5YvwwFF2up3pN3hl7Ww1Oa8QmqiRtNmRU+TTFywR1X2bCYK6R+UFStnaQ0eBT+K/BAa/Subg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjEOsC8rqRGR6uzjs6E3NIv2NiengaKEYjJW04115IQ=;
 b=vF7vAPdcjZbZ6cOIB2jErdnoOxsbx+opC/FyIvcEfXp5pMadPqoNPyiza1F2Y16FxHzy6Z8iI9S+w06HH/r0q2X8VWJ/5qlvmbPuPw4J5QO7+1NQhAzjwYBtFqJ4l0nZrf0FUzF4rrNWXvnWOYiyhSpWidar3HtZ1gQedD3HtFYxQDgXT+DAOn5gmBHBB4WdeqpTnjJckYrHsp40fyYP9qCOxvmmBQwQJ+6/gkkF8i7FVkzsSA7/GQ5CsUOZG2k0ehwvK6/bfk0D8XXdYCzXiZi2tg4AqvyfunTJCl9qQu7ueIS8czHrXEJ7JBsFpg6UCFY0RqjzS8s0P7lgi1zk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjEOsC8rqRGR6uzjs6E3NIv2NiengaKEYjJW04115IQ=;
 b=KQCeekfbB+pvtrLLXrcq6QSHBgmY50cNmD+YmrMTjKEYA1KdKC7QGnz0LAf6mMWcyYIDn9uHtEOX2OddLOrp0gLqUAHvAmSBZFKZTHwYj9aaMkjRi/NnIc3oNXEW/a9us7yB6g6sQ4ze51URKq9tpVqgCbFB567sqVh+Iuh/VCg0fFT7jts0LzO6wEaYFFlRtyjKA0stqgrKtnVCOkcUk27lketCFIVuHcuihH4UosBGnwjVWeXURnMSGiSiGWUBZa0acevQHlZSt9eY/wBtZrcDOs+ifa8qRSNoKDm8xj7uJcVDU4qSK5kDpZDo6czXctFxgIuyPdWD3Pe2dAxOsQ==
Received: from CY5PR18CA0033.namprd18.prod.outlook.com (2603:10b6:930:13::16)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 10:58:31 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::a4) by CY5PR18CA0033.outlook.office365.com
 (2603:10b6:930:13::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 10:58:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:58:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:13 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:58:02 -0700
From: Zhi Wang <zhiw@nvidia.com>
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
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, Boqun Feng <boqun@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>, Jason Gunthorpe
	<jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	<dri-devel@lists.freedesktop.org>, Peter Colberg <peter@colberg.org>, "Simon
 Song" <xinmengs@nvidia.com>
Subject: [PATCH 1/7] rust: pci: add VFIO override device IDs
Date: Wed, 30 Sep 2026 13:57:43 +0300
Message-ID: <7375e4ff20dfa52a59bee0d420a87643f567c971.1790764573.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790764573.git.zhiw@nvidia.com>
References: <cover.1790764573.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1d39ff-0b10-4315-c968-08df1ee1c3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IrgpRAFikFvxAcUmnweSzj4kYeT2I5K73yV5UakK2vA7IsEjIq4kv1ACOzaGaLAa2Hs/pX5K4brJAQ0LW3fd9gH8TMp48+7Dkr4FnTeOqpdb5KlN/BLFSxYJgGkFrQwIDD1SCfgeh2ZTQgWqCfGs8bIME5+Am4YPLLK/bSHEPPueTMibsYFwTFE3zj5LF4J+kesxi8fqQhJKwZvil9DClsBAodbnn3gps9OcTU34ctBih80o9zDFpNvLiEprjm0KxnAh6XCX2QpnxbgheCbvrqubxLILe1Ws55dhueviVFv/5ppNkRNLODKYmbqct4GKVU0ecSeDAXU52idBBeA1Txlgc9IntaFgEvMnrV1Hj9Xmmg8VcTCXkR9OVl59ZiO1IjjqUROH/z12hlHtjpKj48OVJjsAbQOjCoUJ0cnOAdlmayMZFP1BPvhg7g1jxC7yind67jWqvrIpF8KvPPkD5ozbf/YkpinI41WhV5h+BGBE/U1CEesXgqnI3eOx6DxvKlDLhE8AWuqZF4EjSSW+3WSjvF7/mnXn0DJKf1+LWqO9DRJhyKna24hJBEICqOLhh+EULobuhAA0YEWp5nK5+kuMIoea7DWNMz72nWGFAI1qhnEEnygYHkjw9LxOUNtw7eNCqNkTae/4Be1agWkvvybKtJqWoaYvsQwCebtxuae+I4pOxijnQ7+ve7V2TDJyJrjm4zEo/hKwm3tX3kJ+jg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XDvpRxYNNL23XNBdZm3P+R5qr6Vmeob8C076Ih/Ljo/oHd5MjtrNdYXn4W6iz0xK5cENbxKzQFCZMae2qeIZUvon11fuUOJbpfmYoQdy5MTZGyh/kd33i7AlWHR2iO8bttrKfnGDF+j/oFm6awm1+tBysgd/4nVaJPkwwtJ7IfhqQureKKVC4fv/E5a67LCL3wsWL3JpGNL5sG5Fp8TdH0eErReqVWyiIjvC3RT4PvM10MDT7gj5hcCUaZUznb0lnI+8aV3bTxSJOox/bO3wUBkt8j6BixngkCP3v0fdYqyCwh+225Xzu/QRks3nbJmHUDkNQPv92KPiMB/RJfYYOtFiqVmeDDXJ/MT6ToEN3Osumhx4/lZRUZTNc8r5m1XyIzmlbFHyCxxapbYfv2BttU8hlFnTQP96D6XuYVg1ExeiL+dXvWozf1jFvuZZdLdT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:58:30.8872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1d39ff-0b10-4315-c968-08df1ee1c3b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817

From: Danilo Krummrich <dakr@kernel.org>

VFIO variant drivers need override-only IDs and VFIO-specific module
aliases so userspace can select them for PCI assignment.

Add a DeviceId constructor equivalent to PCI_DRIVER_OVERRIDE_DEVICE_VFIO,
matching a vendor and device without restricting the PCI class.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index d83492e06cee..10864ffda4ea 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -206,6 +206,13 @@ macro_rules! module_pci_driver {
 impl DeviceId {
     const PCI_ANY_ID: u32 = !0;
 
+    /// Equivalent to C's `PCI_DRIVER_OVERRIDE_DEVICE_VFIO` macro.
+    pub const fn from_id_vfio_override(vendor: Vendor, device: u32) -> Self {
+        let mut id = Self::from_id(vendor, device);
+        id.0.override_only = bindings::PCI_ID_F_VFIO_DRIVER_OVERRIDE;
+        id
+    }
+
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
     /// Create a new `pci::DeviceId` from a vendor and device ID.
-- 
2.53.0

