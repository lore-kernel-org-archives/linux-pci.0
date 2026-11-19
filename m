Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125102;
	b=ZJnw+vNbTAiyd8m0P60awISsFfou6gYzi0AJve0dBhiFXFEUSalaur7+Jkn5cli4nPMg
	 SaIe5QNGH6YrcAVYTGYEsLXZFKaLGClAayJk2PYcZ9STIQKShiNuDYf96x69iX0mAvL91
	 iMwY68keMCW20l5N38fVX0Ztmqo/5IndHmPnU1LNq37Cd4EIoY0EpzlKhOf09Sgo66fmB
	 9v0ArbhE+zMCW2Mip0HUE0GB4MmHpdpDsMlY40PlQHrIDMA6nLY0rYUs2YYKSUQcaXqf2
	 ZJg1puI5/OZZDgtSD3XTPIYGvV4zNvN+jyJTXDSojRf3DUtoE372MvR48OPJXxbnuUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125102;
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
	bh=OarszyckVqS7Kp7S7t6lpJFY1ygkpPYnPh9tTxa9wB8=;
	b=kOV2wSfQCkNs+owEAwBzbNlRKAt9+Tpevc9fG4tI3G2RikcmyRbyvpaz9pYmwTP+Tv4v
	 dJOFTbubie/i6M1zYMDqTecY6+svrMEsFH+OgakVBYKS9X0mcNs02fhwmGR7gmGHfsB/l
	 K8TVnOoIb94ILtYLVyZo35HRMds30G4squYC/BNPRCWvHVGVpLr5eDYdb5nA2f+DIwYS0
	 MUgPAEoQuFOOp0NIiARqyDJO7L2pPyk0mfLXziuR2RNnNatfm4ofJ/4CHmhi4oWoI+zOd
	 WgjGkEL9PwfqYK8r8HLOT3OBoetix0CraUyU1xadu3x4A35DhyvRqjVcCdXrF08lYTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g3z3KnlW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A560A2602;
	Thu, 19 Nov 2026 21:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76A560A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g3z3KnlW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nu4o9DlRJu6XTD3ANwyK09W/Z1eED4KnX09KFld2rFzltIsqpUO/KNrkjUyNqQL21W6BSVpXEZ5OOq61rKdaoXSxMX8yWgzoKDxIYReUbeHYDf02UIZ0O6CckLIqgvHcJFhgFJoIo0Y9WgoTHJUXjBluHHUEKxQ3Sv5T+7zy2En3/qObgC8SbI0WCzAhk2HUnWX69Sf6AWaUlvbFtGoLIdhdvr5T9+0rn7iaoCunkYaojf8tZG95XOIvKyj8UyPLC4mmDPw7i11rl6rfCXplAEhs9ySAi7jUFVvIfuKC7A92wVEUx8BMLPOGZ4Ujh82kDmN0NLEiqRJBrtWpserWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OarszyckVqS7Kp7S7t6lpJFY1ygkpPYnPh9tTxa9wB8=;
 b=usFZ6ooKOC/BeklxktyWWSJjMtupboCn06fTJj6gb2DI6Va1vHjCL4ue6zJZhEDUbYCdJep/hJHmgm7myXPj+ZpwnCZzh1vcS87QVDb6PI/KSycYqTtff6XgKnKHeik9UT4EDJqpmZulmteTg3ub/EwDxLwyA8XZUFVLaME3bH0KAqJU0FbGRqSi7ry4k4ZCPtVVRv0CSGdoJMpKsqSPfVy77SAkU4bZpbs0ORae1ypnoAKwygX/F1GbV9QzqSwER6MIvirNJQWmxb9FqW96V59NpWkBSr1sSKIC5xgiEgVWuHOCgwDL+6LFt95R3yGUMFTEBzoFDkRqbikeNs4Sig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OarszyckVqS7Kp7S7t6lpJFY1ygkpPYnPh9tTxa9wB8=;
 b=g3z3KnlWqkupUmqpCmMINgW44C9ITok6hyRLVpg8S2jaY+YoHogXj/BDsXNriNWdiWmsv6bg8G63J9fM4S1jzf+bFPCCzLKfYpZ/ALOig6blLOzSw+E9b3Ls9uOsyGZmQR8zburhYqHqyrSqCHJj/v0JloMI7XHpqAMQYv9VyPhtGsFcgj3stUs1JLIaAxpXyXv+LL1seQbcYy6n0nGr1PpNCjOFH49+bU5gu2+ZiHgNaPvqzgW5PY7IwHfGOfWAdrMvoxHPm8973GoE9EpqtASxhvDQ+yN3/zcDie3W9ZrntVBOUqq8zdgpWWECKEMACgkVhMOTozuLl09HMH0l+Q==
Received: from BN0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:408:ec::21)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 21:51:34 +0000
Received: from BL4PEPF000003F4.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::17) by BN0PR04CA0106.outlook.office365.com
 (2603:10b6:408:ec::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 21:51:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL4PEPF000003F4.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:09 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:07 -0800
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
Subject: [PATCH v3 2/9] rust: pci: expose the VF index within its PF
Date: Thu, 19 Nov 2026 13:50:37 -0800
Message-ID: <20261119215046.2892839-3-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119215046.2892839-1-xinmengs@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PEPF000003F4:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 5542f6a7-3831-48db-28f4-08df46874729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|23010399003|82310400026|18002099003|22082099003|261009223027099003|6133799003|11063799006|261026140227099003|56012099006|261022105027099003|261021121427099003|10067099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	wxpjbISd7W2ROJpey5XV+4TPYH0rQr7biWarvTT9ApC0oL21SCDSKAIIoC6pnufix18a9haGfucV3feFAO8/dEe8bwiC8ATqPSZYtiuLCUQ0jzh2kafXCWqaBobfq7nGndKjvr14psGsZC0dzSv4AqGPeXM+y+3lj4Jx/SqyOwZcCRr8WMjCcja0IOIuN+GDxv6zZQ9Khqr/mnYUEq6orfBezIg+OeziBElENzgMCTCDlDGOnb15Oi00qP7B0lHwKP57DScw/GOVRqMwptT2RAXfgaO3hjZhIgXIHofHHpuHMy9wrPlhigs3p4QT6c3rLCr1maET4UAOVRKAjEuhZwUgqJwHsQv3RY2sHp1hF4Qh2t4rwk5f1yDKewJoXKXU+YTKxLFRL5VYMdFjLKDwqFNLoBQRf7rF4EJqcKUci2zydqQMqpzbCpGXLnppEydw+rGeIoiRujC2QApjiMLtTargEK4tQoczXw9W7CUCD606UNTjpBbPTC9N+grfElqjeDi98EICP9yPl6JQaJtxqZKCEc16+QtBrOXNvSZmW7OY8c7DZuRKSi83jiTtfizt0Fl8kODGW3rufL1aT7HEBwa13taMs8duj/17RWxs5yqMZZrTDezm365TcAHfZ6i5DbAJaRCZrlxupxwUeb+N4BYckAbzTmk+MSCX5X3GIVkpZPMt3v2N6Iqdon41fyC5j1ulZ6VT1xvt39VAHjRFzQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(23010399003)(82310400026)(18002099003)(22082099003)(261009223027099003)(6133799003)(11063799006)(261026140227099003)(56012099006)(261022105027099003)(261021121427099003)(10067099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gjl5WhAtHbuh0gaarXJ5TgaE9Z1yJFkX/89dnva8dHIX4glyDVH7x0+5uGjbT905a/tOMuWzHDZmSf/ZKX0agWYRcJqVKD4NNb4BbG8Z/4Fo9PhFgPU/LfXA2AlBbPbz7WO9QR2wOjXuZipEozj9PtB17iSnjffSvjnRXmQAxomF0HFJeH6wbkY3vEP0pH4Q+jVjlik/86eWgZX2V0zDIqJ0OGa5aNANC62Fc+U/c0O/9N/yWcX8U7ZPxMQ28NfLAIL2z5+x8/HzGqepTXbr5B+ayNEKyc5XmDjJgGetJVAUmzd6U+5pTCUF4dPe9imtOxaCXzGyEw04xGuTrEefQ8HlQak7rkMcqfnyqBS9zMF1TT7yC6QJrO/Kam919BX6qI6zCCmcuO4G3ngFnBA6PkJMDDGv9gSlHhpN2WISWePGHUz0rUmn4Gj37JjWWki2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:33.6935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5542f6a7-3831-48db-28f4-08df46874729
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003F4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118

From: Danilo Krummrich <dakr@kernel.org>

Nova identifies a vGPU instance by the VF's index within its PF. Expose
pci_iov_vf_id() through Device::vf_id() so a Rust VF driver can obtain
that index, with an error for devices that are not VFs.

Because enabling or disabling SR-IOV can update the PF's VF offset and
stride, from which the index is computed, restrict vf_id() to bound
devices, Device<device::Bound>.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Suggested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/helpers/pci.c     |  5 +++++
 rust/kernel/pci/iov.rs | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index 57c28ddeeb9b..1e677ebfe0d4 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -41,6 +41,11 @@ __rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
 }
 
 #ifndef CONFIG_PCI_IOV
+__rust_helper int rust_helper_pci_iov_vf_id(struct pci_dev *pdev)
+{
+	return pci_iov_vf_id(pdev);
+}
+
 __rust_helper int rust_helper_pci_enable_sriov(struct pci_dev *pdev,
 					       int nr_virtfn)
 {
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index d0db9d4a0f9b..5bb1340c9150 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -379,6 +379,17 @@ unsafe impl<F: ForLt> Send for VfRegistration<'_, F> where for<'a> F::Of<'a>: Se
 unsafe impl<F: ForLt> Sync for VfRegistration<'_, F> where for<'a> F::Of<'a>: Send + Sync {}
 
 impl Device<device::Bound> {
+    /// Return the zero-based VF index within its PF, or an error for a non-VF device.
+    ///
+    /// Returns [`ENOSYS`] when `CONFIG_PCI_IOV` is disabled.
+    #[inline]
+    pub fn vf_id(&self) -> Result<u16> {
+        // SAFETY: `self.as_raw()` points to a live PCI device; the helper checks VF membership.
+        let id = unsafe { bindings::pci_iov_vf_id(self.as_raw()) };
+        to_result(id)?;
+        Ok(id.try_into()?)
+    }
+
     /// Internal helper: reads the `vf_registration_data_rust` pointer from the
     /// PF, checks the `TypeId`, and returns a pinned reference.
     ///
-- 
2.43.7

