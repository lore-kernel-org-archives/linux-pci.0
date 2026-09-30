Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64496416859;
	Wed, 30 Sep 2026 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763594; cv=fail; b=mE7OVpZejrV7UUqPnWiM/nbAhigq4AHZUQ+l+oZDJo/kN/Mv+JgavyPseM+MZi266b1xkKNnrFLp83v9aAc6WkEIdbAVXu/76hn4SqHDAL+o0Sfnh9HSerV0Ak1z1Of7zRs09RBBjfr5qbDJG9pAZlsgYNhoJ1geWPf38uzVDIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763594; c=relaxed/simple;
	bh=Op6rrgZ7dQwsOp1BTnoAFOkVFO8WvRPxLt+Xm+hiIWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUa5Ar4UK5VyLgoLYUv+2e+bNLaQiwH4OTQaaGSDx3KPYsR/cYq9+qJF1IA8Ih4izeUpT0M2j1cvqZp1WGbFTxUASYXPLr2bkns7ru/iCgraZmcDoyBKZ7WY8xNndihxzMH/s0Zhv48kWaLpf2cmaR31mgFlK9Z6pzxp+BgfLgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PPua8yuY; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PPua8yuY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbektaeMty41RBDsaqNiz+E6LLLK8LOgewENprLmShwBeJPPSmUct5tN8FBA9g0JFtq1jQkJvTAkmEJTDXJOaq+ammdEiB2ubYw+nIfYTbkxYKy45nB6ydeIcOaX2zjE7m6R3lcGrbjgtnIivH6o/VlS5nvEE9bBL0/utSA6NSzQlUnjuejVLd6WYyjFBK93Z47wAOzQiuppbl4mMdSV42ZukY9KjG2O24kQJG9+dtBF+5DtKFvi6DRnOhShiYZuNPDlwf4rQojMEPUrkVLXb6g8hTT7UG21AAObEmZ4W3eav3EeY5B8MAFZC70tp1GOb+nJbnt/cjJTyULY2bpy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAAEYSrGnUosULBKROCJXlIPk58qT0cTHkeGgDP3kOY=;
 b=cqv+V1OZiUJAvgvdIlGaN+lmZ4CRyhqfjVYi3Vh23LuC8aGGbyN2bYn9d6RrHYCGgdV5cH2ZXirOZ18WtT2OJdHSHL3WsHC/Re/TiKHstNkCLeD8bpllomQ45697093aJYZKJCvGWb3X2nmlyHiJmMGKDR51BA8eVp53VzThR65ZOEuIXXRLS3QQ+ipH4xooSFUWPPepuj397QxYL94AUw9LbNNMR08D/mPEHjmSvw2mkRWs8Oqxbe2wz82DKb3DA2Tv2SghWAmd22jXS51jvzbpXdlyWqAslC/O0G9rs4QXtCZXfNsSxcwU/12QyzsbTN0WhCESxojlOOW57FVDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAAEYSrGnUosULBKROCJXlIPk58qT0cTHkeGgDP3kOY=;
 b=PPua8yuYn8K4I0KEcV4lB0eFFXidPimDJ/5GPaonCTiYcCZlCIAVdcNSijAz6HU8lR1nnCdgQRDPu/OwAg1cHQTxi7S4a7gWGRpaGhANyiLvi+ysVZCKRNAbER+nAHQlD8YJhScRAOoLKdvXPPf45EjHtmakNHXstWngoLxnqqJzTMqQT47PSvdrXidBrrXheczx3rFh3b9U0TOlfzwfY8z5IqZeeW2vFfFhtn/WfyLu2n3uhOHJ7pExcUDiqfCEjd2SCHZjTYYqRFzQz2du105uY52bnuNJzYEz+zDZVz5M+PfQNwzJ5Ot5cU59ufFXEFyNnlcJXmYcm/MNsmlGqQ==
Received: from BN9PR03CA0428.namprd03.prod.outlook.com (2603:10b6:408:113::13)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 10:19:38 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::a5) by BN9PR03CA0428.outlook.office365.com
 (2603:10b6:408:113::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 10:19:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:19:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:20 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:19:12 -0700
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
	<alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>, Peter Colberg
	<peter@colberg.org>
Subject: [PATCH v3 02/10] rust: pci: add vtable attribute to pci::Driver trait
Date: Wed, 30 Sep 2026 13:18:43 +0300
Message-ID: <aa99201bf126e07b654f7cd5f35d0c3b5062b6bc.1790759932.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790705494.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb96692-2e4b-4e49-e1ae-08df1edc552c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|23010399003|36860700016|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	uATbVweReN6evchJLPbSI+qN7Ti+ES4iXuo2z4qEizcfwrGgORbeGhdDXz3vgauGx2huBkyFU8GQzwNT3wkupzBAChW3i3Tys7JMOTBZebqsCkW6fyU8sigJQK40fXS3E7RjGJHhEUBNT07XvrTGYiUsugFD8sS3QIwFXz2ira1gViMdqvzlUuDDWrdcalSyijjiOYFnYpt2FP36nIOeG1riQj4quVYaSK8gHXMr5A5E5KcEuI5GrbiENun0L6TIxM8pV+xxXvZlwNxSNnmHlpFxacZI/DUrBKM80umOVxIsgOKvRdPiF2jUg9m/RZMXmFWtcTxoJu2RVnmh11Fh+4ep31QoaakyJwb99QBuOQG7/FZ+OjS1rq1wzith5KrWeDkncsJtWtf6gvQHcZEIYj7yQ0X4LPObrHDY8Xv49tiFI2O7vrvmcORhyeEL0KBobZmQeV80B6XsoXfybu0y85GQuTdiBwuoAoFVvtn2LK4VFUz+zlNftDp70TPf8ZD2J6CAADbH3QL+7Lx14c4NMwUnBccrboOYx3SkBKliBVgW9JdtXxP0P4Sitom3hZfTQb1Ah1HUSvN4VtNhpLuseoJTUx4eXlyoA8s7R8ZALXpoynEujLHo+Jn/r+dfof1MXod9k+x4tYuOU8nR11dAyTpP7BPnqTd6Rd3vVG597fx1BZdTqn5K8IlNxNOE5mnEQr7MsaWDAxpCeagHnQFPAw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(23010399003)(36860700016)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LmPB2k7Fb7DQw7/HfJNG0IQ/ZVMkxf6BamKytLOEljS+4kgyh1lo6upvtgYrWci1W48s9Uqbg+3ZVFdm9GckCTq0PgZTENupglcPebW3N+Rfv4PWAE6EHEBtNe70DuEGRtMvaPdTarPRdEDhuNziNIb6fz/UgWHnynkNF8CZ5bfGaNfLI8S8XK9loyXRMAkQ7Gkohd0q/+IVoDCjA/KOMtWCt2ccosVtGDxVv/Gw0NH4Jz88SeKIwvFVHPWkViLAMPrTokTIIehNZYQpfvkaEPWGDlUxIoAy6iamgZ6S2iuCPutEDD1ZKh4tI7Gssc6n8MLR9yKV2weWmEs0xz1A5ytV6CDns1eZyA4p8bnUGf3/oJ7J896XBwfQef2SyJUeP1bGHYt0rH+V5w+KqScKS1Aq/fDAAxF3Px/OIHc++t7qtvNna/2sDY8AiOJZuPP/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:19:37.8771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb96692-2e4b-4e49-e1ae-08df1edc552c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396

From: Peter Colberg <peter@colberg.org>

Add the #[vtable] attribute to pci::Driver and its implementations to
support the optional sriov_enable() and sriov_disable() callbacks
introduced later in this series.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       | 1 +
 rust/kernel/pci.rs                    | 2 ++
 samples/rust/rust_dma.rs              | 1 +
 samples/rust/rust_driver_auxiliary.rs | 1 +
 samples/rust/rust_driver_pci.rs       | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index cf3534dd47d4..47a599c9ea4f 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -63,6 +63,7 @@ pub(crate) struct NovaCore<'bound> {
     ]
 );
 
+#[vtable]
 impl pci::Driver for NovaCoreDriver {
     type IdInfo = ();
     type Data<'bound> = NovaCore<'bound>;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index b11a1d32c5db..dcb0cdd0d426 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -274,6 +274,7 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
+/// #[vtable]
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     type Data<'bound> = Self;
@@ -289,6 +290,7 @@ macro_rules! pci_device_table {
 ///```
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
+#[vtable]
 pub trait Driver {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index ffb693544673..804d55a63005 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -69,6 +69,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
     type Data<'bound> = DmaSampleData<'bound>;
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 0bee16faecc6..6cff9bf8c80c 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -90,6 +90,7 @@ struct ParentData<'bound> {
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
     type Data<'bound> = ParentData<'bound>;
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 13b035a95756..50c8709739c6 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -139,6 +139,7 @@ fn config_space(pdev: &pci::Device<Bound>) {
     }
 }
 
+#[vtable]
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
     type Data<'bound> = SampleDriverData<'bound>;
-- 
2.53.0

