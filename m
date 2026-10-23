Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770068;
	b=G8B8HGGzQvK6dW3AeKRIlojBiHwMMWMy7NheCotlIcXr/VsmeIbjUjOazQrUKFauhxAb
	 WxU9sdPHW3oOuAVjTGH+7ev6CAtfDBhUQai/XGqB3cDYqK4uu832X5vedWejl+f0a4lQp
	 nlp5EBPLYfj3e/o7H8NaoJ9+yA2KUPeLoS+JejgVDqlv5/a5Fj9a6B5zd55yMTAw/MLXX
	 VrF02VnTGNYsUtnwATghCbTDEnc4CBZktZQ+S72rUJc17dvZlUc809m206D1Yup0hV7yf
	 jzWjEo3bvrTOBcD9cDm+hN2A/0R2IpDzj7AWjH9ugNsFugOs0zLgZzfxt+i7XcWzlww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770068;
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
	bh=WE5LYdR9xmj0w1zxqcIWKfA8YAuzOMob61V6KgXDplw=;
	b=06QB2VIifK1H2EIgDzwzQm60S+9MN/h9AvqRniM5DP0xsVbjVEGOnqU/J89bxWGP88nq
	 dIXpKMRIzFlmAK7Px4w5mqsM4lhEsrfiZuiaohpE2ThM7Kh4kNA8fisW5CjxLrlJ+V16t
	 GG+A0jruLgd6xnJIQQi7pGXc3CeSl2XRW5hi4+nH5TG1cHArTAzOm7y3tCkNmzIoT3SVF
	 pkinoGk+OLj0xblZEEDXwJOrdHT6H85xysRsaWC0zvMy5EbUdAV3JNLKoy5+Kclx3wFRg
	 HQb2lvP/phAH4+0TMtJw6fSorVDdN8OXPM9JJTcX908w/wBY9srJo1MVgzvoe2rhX9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rEhCzlPe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378E606A323;
	Fri, 23 Oct 2026 15:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7378E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rEhCzlPe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx6sNVGdFD/ztZQ+QSAEsHCAn0V1CdgjIPTDIoo/ISJL3irZ7e8e/iGEWfeUzGp73Hn/ZpVam9TwRMBm6Ta0lzdiQTf4v/C8e2RBcPkIzAA6IMiivZxcLqSTSDWNzunC8TUoTENwYDe8ZmvS65SqKLzO0cqx4etqeMYRNrhIgP2KGM9oCJcVsMZ/yegAUw3W7EvTRxiRDqnXWAiBcAW2dM6h8RHFJ2aC4xpdOEFIYGN6VsWeFg8+0ZTCZ6YpdV9b6yYgQ+n6f/rI2UNIqYMSD19Q8CUqi5dIqD4e31GVag6OlJGfU0cStcIjaeexF+4VU7MNk314Y6h8HogZSojijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE5LYdR9xmj0w1zxqcIWKfA8YAuzOMob61V6KgXDplw=;
 b=JGtE62bpv6o+FfSjjLhBDZFptuPmItexet4TgTKHUC+JhrnkkT40wsNSuj7vANYUb1nMsIrddTyutvOnq2c8qMtw3f5weT3X7AA0b0kNlWKOCQWQ5ww+uUEmoxlW8AdL3TAZ5dovf8aRUG2T2dmL59PL24aCy2PD083qmO8Gx0ynWzk0uVbe1eZJmrDEBUoXyS3GncekpGjDKwePWnEQd2iMjyaiUJyvaNsIjqFkZRaEGOQcYC/UXM78dKo0UYpitAikxWDeDEykf8mL+o3UqVJB24Gets8WPBmsvXlgX3duSt7yaK933an7ndx50jvVZsG9AKjtB1G2u7upbXyitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE5LYdR9xmj0w1zxqcIWKfA8YAuzOMob61V6KgXDplw=;
 b=rEhCzlPeEbzr9//xeYRzu8Cx1LrVsn+5Ca4DTFiAZASA26nTQmIsp5Ceo+aRPM39Us9nIdkWqDfWvP37PjJ0K6agz8O4ptv8owRlV+hOSzPi3sg2AtKMl4S+UMvpuRtx9LQyyrYgiUtcFqlyohoUaC3bEoNGI0Hz++umGXBesR3dXoiwMRj1ZYQIt23+2iLUwCihF5nko3TmIlXJviLTjR+/ViDz+pBXe5nx/rlhF8YJtXmuXeCZQ/W6T1RNw/FI9w7X6j0qm8yAeG+xmD7m/IgxXmp8zzStjqoYEHgEfwM8LtDVqSPcDuruZ+ZhauzSzjrw7mi3fZQVRAbzVSe9Dw==
Received: from SJ0PR03CA0134.namprd03.prod.outlook.com (2603:10b6:a03:33c::19)
 by DS6PR12MB140904.namprd12.prod.outlook.com (2603:10b6:8:4f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 15:41:01 +0000
Received: from CO1PEPF00018860.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::45) by SJ0PR03CA0134.outlook.office365.com
 (2603:10b6:a03:33c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Fri,
 23 Oct 2026 15:41:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00018860.mail.protection.outlook.com (10.167.249.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 15:41:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:36 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:34 -0700
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
Subject: [PATCH v2 03/12] rust: pci: allow drivers to manage DMA ownership
Date: Fri, 23 Oct 2026 08:39:58 -0700
Message-ID: <20261023154009.2246627-4-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00018860:EE_|DS6PR12MB140904:EE_
X-MS-Office365-Filtering-Correlation-Id: 424304c6-555c-4f80-955a-08df311c0a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|261021121427099003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	T4h3fNZOLgbfLwZ+SPBROaUrpgfXCTi22YdPCL2Pwrh65IFm8jAsVXOre0e6h+rvcYPOuIDi3aScdcgQ1+/+Uhk+AcaSVNx8gKk6MofThIEV188Gx5nlLDzPyXwOKMZ55AmIDgNo9lj/WCItFdFZNjxGyzUns/xVjCudut4P0uD5lFuof8jTE1HPYhSCNHR7Wf6oxCp6E7tsy2t2DdM+hZCsT72VOVJ3UEYrUDLLnsgc4pPpHY0JpqBqRJRLntZSajE9YlKX564xTEUKTcZHcJbIJBAW4BBQwYPcfV1XqYh3vb4EiRkryiNfT4Gl4c3fvkTIMfqBfQLM/lUtdOiCBp1FKJ05iXuo1DSldRi+BkvuevqR4udhvGQ1EN9e/IUsVintuIlCaBsHeieF5XYBEkcql259uKbrf9oZj6X4KhGVJRq0nToVxCp2r/Ab+PljhiujErH88tLdTckCOMrN1fBAAtgRpTVyDHjZ6UwJ9N8pBqMBecJdAvuqmecN7iGsNrFlr14Ln2JIne9avim5neuVJsVRjSFJkMn4esTH+b+VwJji3X0FLm6XJt3SHXzn6YJ/OXCchZMWCAOPJEnYaBBogUS4Ml6uzEeOZRIebk/NUz4qssV8Po7m5Vz4n/SRNF2s0h2RXbj3OQrV/DAfbm4h4VZOEX2JqCrE17yKkbWHcxiR5+nDt74aZMhzwcU3s9YLMQJtyTDVEhIGDeui0Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(261021121427099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d7lepq/zECbr4FZrOIRPOTlR3OVgVtcGQuQZ7CU5Silf8RLkGUy3D8v7i6PXCdUrtJu0L1E4Ym07/0ByOllD7Rvyp/xZijNELjGyxRwV5pa6Ue6qTLvdkaOOcTOyzpwxe4s0LCyN+JL8Au4GwleXDWm2BOyVlJV7yE6lQRGED6l9WW6Eez0IR5uZiOAS4LYkLPwm+5XNCC9QVjgs2zhxvIX9oyyEvBqOt6fsI6re90sJUFO42Lex7ACC2Blb7WkZvXVxd7zDAhMavgzYwjjp2IIWdf2RKpp/mtriysES0555E03F853HgrmtSLqY4hJwrOeDM/yCrwVJ6bPzXnoQRu7U8ztC/F2pp7NW3V6lCuEYwA5Cqtg3PypUlGGJL6OhDpujwrXgXcos1d9Ltu9KcZvy9h0x0agJ1bkjW+Austsh776MIgdbz0RJqkEtFgfw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:00.6872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424304c6-555c-4f80-955a-08df311c0a0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018860.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB140904

From: Danilo Krummrich <dakr@kernel.org>

VFIO manages DMA ownership through the userspace IOMMU interface. Its
PCI variant drivers must opt out of the driver's default DMA domain.

Add Driver::DRIVER_MANAGED_DMA and pass it to the PCI core. Existing
Rust PCI drivers keep the default setting.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 10864ffda4e..a156927e23d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -108,6 +108,7 @@ unsafe fn register(
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*pdrv.get()).driver_managed_dma = T::DRIVER_MANAGED_DMA;
             #[cfg(CONFIG_PCI_IOV)]
             if T::HAS_SRIOV_ENABLE {
                 (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
@@ -345,6 +346,9 @@ pub trait Driver {
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
 
+    /// Whether the driver manages DMA ownership instead of using the default DMA domain.
+    const DRIVER_MANAGED_DMA: bool = false;
+
     /// PCI driver probe.
     ///
     /// Called when a new pci device is added or discovered. Implementers should
-- 
2.43.7

