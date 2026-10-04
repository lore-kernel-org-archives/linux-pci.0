Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862223F871B;
	Sun,  4 Oct 2026 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115711; cv=fail; b=YMBRWSfKhSxcswwxB4zeK/LIw1SEliQbKtTcLZDu3sO1/RQP27+LFVVQKdrUtn9m/7OJ3CFteSe4Oa/FP6XG99T7DQGVwgZY4iMmi1Qdz2fqJQaQxYee4wXhP0xrLc8YVVSXzessNMvi9HZn9oC2mfj7jlGmszD0HXCTnzMIt3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115711; c=relaxed/simple;
	bh=N3t6SUj5UbpB41Udx8TV54lz3k740k1bargw25ZzGSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbOW7m4U/6WVb95LSkseWALG0S+fBC9aDxcNAPOl2A+SUOCRAh3jqnQ11/dbq3VggwgXY/iZbz5Zwk6ScwZi7co7E3iMiUHY/YbxaPLyEMQd8qkJNv22K0MAQgtMiuprqtYomQHyS2nW9JGpGGVbr90AJUHCvm5kHlNRlu0gyyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t1XzHv4x; arc=fail smtp.client-ip=52.101.46.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t1XzHv4x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRUmCmTTX6tz/KPNBFiNidPISKJBPL64Mft3ff7tSd07MLTK5kqCGPNmoWMcXtq+P2ZWXnB+9YhyF2RN5Fb+VuREtwB+Hsw1oYqVRRcTEOAX+/dksIL+USBIhFI/wY/3Zb65D5R0FMi0c4dArp44jCRjOk+Oa1IIHu/OjUiPCig3ouc9GH7jaIB9G9EQzHRagUzFD5QY/E/X0BuIenbiYENKTn3APH6Nvh/5zM+bVb2nqyy2/EaFp2p7D9OhrlPP4Edn5sQdkLR8ywa0CGinHP7G4nGvf/StBlgQ57vRbPuug4T9aWiuyS8ru0qWJ+nP1O2rMdv6WXV2PpO8ZxIIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JQPQJ0H04ybccFs6jT8JESbw+wrpuRD2BlGCdRFHmM=;
 b=AlbsUGLWJY/sVIi4bKqfj3HESu9PwviXc4hPD4+colEPuJryjtmx+BE3GUpPdsWy+6W545Wxe1Hs9rCkRdmWCtLiJiJpUWTenro6gkM8EHeJCRTE5cU3Ogkms/Xb3dTeG7vSwCV3RghWqNI9Zwkfb3wxiIS2ho76KYyC1QDKQjTw7ZIQChwtoio1uGW31mOWCkwfCUc6rrAsC5/AQyJREJbFiMuhep+6htFdBIXNBBmm5OJCy8orfif8t0dP4jW36EjWN5ESbs25n/v5BkPMfamXbroUilOiILo+BH7C+MlunL7MB5+7hyJEkEkEFKml8GF5OiFGFXT2T5oSqbnRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JQPQJ0H04ybccFs6jT8JESbw+wrpuRD2BlGCdRFHmM=;
 b=t1XzHv4xenCkK+6lHwLOganh9ecUXa+GiPhRZfdsLGlJ4QcjGHyk8Kb7wiad9RCACA3rpj2+AoBnJbHxtQbLcS+LJeBwN7NP5GPWa8qZQbjVI4Qz+GUmHSK/mZPjTKi1zSOHTmpCKdaBr7xfmjjRAADI+iA4gHl6RDGm9sW/HxHh6XDpMSXVs5o50JgMAk9B4qY6iDNzjNwMfg6bhssUApFXpbGpemPPWqTlp7mYAFjlhDPWxVBV7fmRuCrO17jOi0Qoy4v8/1aXQetTlqNnO8VqmiquGtI8MygumDI/ZuHLyLvIMLXex8lxMaSJYHkvS5HV2zy6bUb62tJValWg9A==
Received: from BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 4 Oct
 2026 12:08:25 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::91) by BN0PR03CA0047.outlook.office365.com
 (2603:10b6:408:e7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 12:08:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:09 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:08:02 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <jgg@nvidia.com>,
	<alex@shazbot.org>, Peter Colberg <peter@colberg.org>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v4 4/9] rust: pci: add num_vf(), to return number of VFs
Date: Sun, 4 Oct 2026 15:07:25 +0300
Message-ID: <20261004120732.1045629-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004120732.1045629-1-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f23678-c2c6-481f-5e22-08df22103152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|36860700016|1800799024|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9hCNc6hIjwRGehPBAZQ2kwow6EHnj6rVozg5fkQPRWvEp4PvrtZMsHVKhFjIFNYHuF5WyupoO+CSR2a0AXy7GgI0Pv/V4gg+39hxHR2wRnvOMuatZe0LUdyADJrRgRlliy9A1/mb4TQUdG60GYloAu2ZeR6we+k1xJyC6n7cxjoyEw+JMM91EXNcH8iT/6dhj2U1iyh1FriVy9VJA/PtvB6Xz1PXeveqweb+Nd6S/7zYVgeMDWSbNGPCUB33QNihmm+7JAgHR9CyOqFucUVIbXZ4x3XcUGK2tQDax73g1DWAaXk93RfLOm6PveGujwR0oHtlZadm2jAMeBfroB+yaSDr2dILSuikwVqZDJqQcDRJYogamA2/VoA+dbAM5YOKfb2m0p1xuoQEuBJ/WhhcIQ7qfOhLLhPiHQaKUHRz+z7Qpe0XElLE0iKreXvsIWkJCypUbvFmSMahKaEW/fkdIRA405YBnEJyyBRn5Cdj84QKDNzFGH6426LAh7vF8KpfPHS3VpOBggtCfOKNmg+MrylhDGL3X1+7alFsHTdaV/iw7V8e8UnVGr5p6I8JawqeIMeSyRsQ/A5blyzOHLX7/dfE3O3rIa3167PgoiJEoOBqzM1em/7MBT4NZr1NFLWLtOuDg/coHWO40BrAwPm7KR6LHBMWQA0RdSh7xjsg1otnFL2k3ATqUm4fKRrFwXY7hH6GbLFGX87dcaZ40DoS7A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YKD/iSwxKKW4WJNQ0qGz0PJl9dYPDv+rA7V28Be8OtVnd64oJqb7j6vqRE5rl8W+iziUll2l4JYBlihsy+peX4zexVxmlrdOpWDagoIxotjGtaXieICeDy7iW9zBXS/TE3GDNv9O9QluZXC8gQwvEOH6/aNU8Lao1QuLX6nVaOW77xtthpRSWVGylVVkYgyod2uvy001jOtUlpdnBI0+sGbJ1JKLH1tTbFAPVe3XsH9nuZM5qDPmDpJurIgmPLcgF48gIUGjI5xCvjgO9UXKSQhpfz1AqeSZS7hfRSHdlLjxvy+1qwQPthVl2AVcqzqlOh0LV4E/2j68fw4OAfnUE1+SW1mOcYKXwb7w3/F5lEGz++l44gObOvxjEW42K3rhBDrx8TsTO0eC+5BCtrGmWH+PLjaaIqdhTLXPzWBvMO8EXyUMpdO3elJYxwrLbWjz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:25.0201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f23678-c2c6-481f-5e22-08df22103152
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

From: Peter Colberg <peter@colberg.org>

Add a method to return the number of Virtual Functions (VF) enabled for
a Physical Function (PF).

Expose the query in the PCI core callback context and return u16,
matching the type of the VF count stored by the PCI core.

Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci/iov.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 616ac40b8bcd..4ed6ba658e81 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -20,6 +20,16 @@ pub fn is_virtfn(&self) -> bool {
     }
 }
 
+impl Device<device::Core<'_>> {
+    /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
+    pub fn num_vf(&self) -> u16 {
+        // SAFETY: `self.as_raw()` is valid and this call runs in the PCI core callback context.
+        unsafe { bindings::pci_num_vf(self.as_raw()) }
+            .try_into()
+            .expect("pdev->sriov->num_VFs is u16")
+    }
+}
+
 impl Device<device::CoreInternal<'_>> {
     /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
     /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
-- 
2.53.0

