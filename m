Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87B415B7A;
	Wed, 30 Sep 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763609; cv=fail; b=Oi1umDHzgR24Pem2Vq6k+iy9bq89M6ZPQZYxt/Br8Y9CMsz7Z+lvkNVlZ9ZC2trTR8JEQPUgfJRzKJUUxA1dEW2f3GftEXjdDLeRw4TyHQobXIjsx2eFsGpE0Ru1xqSBQonhDpQCBMQ7G9O/SyDnkw8lobErfpvVpCIlQY+xvNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763609; c=relaxed/simple;
	bh=E5UxZzyRaBVcgsdnDMujsSN5XVymTstibWsm0I+AHnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xq/vwoZSePok77B3W2ntD20wyvN2jB0rT1TXYFost2tj/GChFMqQZPL5Y48OE9AeLhPke5rdjZqnGTUIy5FltuhswavfOvRzxnNuPnF1EBIJkrx58uFekdeUmxbszKFZ9RFlFNnop9eGVowy8pfC/v5lxxbEVrN+i3pa5Ljla7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bAxldmVo; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bAxldmVo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL2vqvEuVgQn/jsJ2DFPSN4f76WpbMKjuFNKO1PvVngGZVkSyrmrz+tMD+NUjfLMc25APpPLaqc92kogRiJInwLqe/dTKSv31bacaE4hHGqjsaKzP9UQgA3Z/8a66jsgsPW/tan794IFvX952ke5a1YOkdYBcBsH1vsR7jucI6kC1n1pgawf5clUuXFkDJfv6xCmVe+ERWX+L3sdJWwwuGEzRgIoERAbwOJxbzJZRWwIXHZ9+SW9hdYpdXGuIX4l6Jf38MUTF9jpzKM+/rzO3mp/xkaGdQBkDSp1ew7xGasyHRtn8XpsUh7zArx/0p6xhuEOvX0D87D6Hr3LrM+VsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnoIl3+Vppra40s7Ps2igGc9faorl6OCpBiV/kEermc=;
 b=j1lc2Le7dI+XCR3fbHckejFAW9mTj65RwGh5W/s1m8OuoRPKGckA7TeCwhoGd/HXX6Uiy8fC6LNEIHV1cT29Dn+l3eU695PbhVyTK9xewkyQmfxpdJEVQxUIDMFTqRwc8j2ifVa8Mk4P6d1U2JaPMOdqjpdxrHjsRTW6bdUH0cuTzUa9mhLPakSIjej5ldoS/t25CKXsngGNnEtBUHze4Me2PvoDqwxp/2/hLZsCaJtXaf6SD+d+lcb+eCsng5EhK3R+TCv7XSkAiEgwH3v7CRIuAOYLBECEnX7vyuV7DZYBF15LK4O0s/iWILyBszotyrwObYC4/dukqq1f1UmzDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnoIl3+Vppra40s7Ps2igGc9faorl6OCpBiV/kEermc=;
 b=bAxldmVof6TGenPYIeGQ/A9MgoRtVc7ee1DKYNbjnDDCRwRvV3KIpxtiRu7dd7LWHccznwoulfg2Q174+4JfQXua0watO4uMYUE4JmyET/Txuech6siMvfWWOH+Nle1dYX5jHik7ZB/AaUvNRhn/HY4y7eCYrioBSKnhZ+Yp4cgP5VwxZR1OfFZbxK6YJCojhNQ6ztAfZ3pnWXomHtDgy/6e62aLM3WxGmEkYHPlWOUun5DQUyAvsJ0aM+Q1aZSXzAN3kJ4Ba2XEHzEbCRRiHpCGLtQmIB0nE49D7kmGzE47rtZLaIrs56v0N3yqEqleR5qkN6qdSjvL4EWgPCKTmw==
Received: from BN9PR03CA0875.namprd03.prod.outlook.com (2603:10b6:408:13c::10)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 10:19:58 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::48) by BN9PR03CA0875.outlook.office365.com
 (2603:10b6:408:13c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 10:19:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:19:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:36 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:19:29 -0700
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
	<peter@colberg.org>, Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v3 04/10] rust: pci: add is_physfn(), to check for PFs
Date: Wed, 30 Sep 2026 13:18:45 +0300
Message-ID: <d40371fcc6467b38bb5727e7292dc34f54bdc7fe.1790759932.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 2761602c-e79c-4a7c-9c56-08df1edc5fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|23010399003|1800799024|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VK6Wi/TLiS+A/QPIm230OZfwE/dRbU/+/2v9cdPB9nqga71Hecy/n2PPUS5bF+aAGcyBcpZevCC2Rl8eBw7ZYvHQL5BwabGtK2qdLj0pRq5U//2dyjPW8vdV5jhLcZfZr3eid6tvkQb1PJ+povCxbKd0BJdQQrfiTE+dEifzkIb2Vu2VOvV2iDLlKUkiIiQhSmD7fDBR1WpXxxzfnE0Vscd6TDYZ9ziR0tCsY4ltH/vSVJdN4kvXjTBvBd3I/XQfKlBy/iKuyfzYLVunf//wC/xIVu6meWr2pf8oZtONjbthPytr+nipPjCii/r8s/XkHr5RSN4Wi0xj5xYS1C35Qrug4ji+KPWE/jhqb4tBtDMWhVNTEeDd4ISCzic0yM2KIokEDd7Pqe1upNDic6Q8Yd4cEQdq3bkSiHNQINwJHiBYQ8ZKFL9Qj/f0Kfg+TEYbGWhz9VD2+CA0ULrjBS7ee6lC/iwtd3yvllqweKK8adKE2h7S+uu6Jzg/8VN/AHiM4LQsrti5eDX+etmXqFK3tTzQN1GTF7pap/azGCzZd7wPm8cptYBaBEXBr73fV7SdOMYtpLTgyDnb9Gmnp4Cmhi6yDaXvJvjlZccdMS+me5nv6X0CKYdGyA1ktUi4J7vQLIsnc/9hHt9YclYFEv05zmV32+c1whzMeL6I1wvsmB/ru6FP5rO0Z0jCaURVInHc
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wyIrtWQ6c1y+U7CzKhKycxh/86AIWMV4J++U3sqOTeqd7mRDghcyFGiI26tElVPMohJQFxxsoQrIX/JpamHRjLa4r3FoB5r5ox+LA5ONkzEtqxWSSCy//8VCk/rhvZVSRCw9JzrAlbRuZJOptI5kJq6hRS9h5MncHN42l2DEs4hA8pqtcJQUXnp2yBus80dCl3Cw+K1DdOKnlKJqtDF+/N6B7n4MzxMTl7Tzwy3TscSnU+kcHuVC3svJibtjgXfR4n7hlMJETDHcCFRcXwigZCKKtuLEHPOzdEGUaaEJgbRO/qCZ8vwZykbzEP/C0edYfCBBB4KahEg6VAHYZe4lPu7vDOZ99nB2nNWYunCo/yaZcfQMsq1IO3ikNWsTpF9T5lzbaErvqq/UxYADwRoOYjnDcXeFStrRC8XcoxwD1OvTkRo4sbEVD7bn8vwLfEAG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:19:55.7512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2761602c-e79c-4a7c-9c56-08df1edc5fd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577

From: Peter Colberg <peter@colberg.org>

Add an internal method to check if a PCI device is a Physical Function
(PF). The SR-IOV implementation uses this role check to validate
configuration requests.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci/iov.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 272ed677f145..a4a23a9ea77a 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -12,6 +12,14 @@
 };
 
 impl Device {
+    /// Returns `true` if this device is a Physical Function (PF).
+    #[inline]
+    #[expect(dead_code)]
+    pub(crate) fn is_physfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_physfn() != 0 }
+    }
+
     /// Returns `true` if this device is a Virtual Function (VF).
     #[inline]
     pub fn is_virtfn(&self) -> bool {
-- 
2.53.0

