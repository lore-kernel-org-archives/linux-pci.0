Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29763BFAD4;
	Wed, 30 Sep 2026 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763701; cv=fail; b=tmWuhXEwhv9zjdt5vJI002O7bxdn2ERGxx1pweRi0gkeOOZFYOlZzaWlfDfQdNM5p7LxUfOdq8vtxrXJRDkgRZ+NVFSh4M26pYtGm892HdjmXuEBR/jfB50rNl8ugT7U3ayGIm3FggzpbkR8Ax6gXpvU3jDLB2/Dr/cnvblbLuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763701; c=relaxed/simple;
	bh=nD3Hyb+8Uq8uq0W4sFw2zoy0Z9ZLkGCre+bB5ddAfno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWwJuMsF4kiMeIYfloxGPrLBmz0iIehzGYKh7iS1yCKquyLNwZx9hr0GdBHXeVuFlChaIioHq5687n1uYhoBYNTdaW2XvRU0GWcVqOnWKqYY6zrh4GcX7yxV0Bry1EFDUuBhM2HRa3mOPoGdTY5OICIkGejaSEFK+5vXAEW3Lvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GtC5vryN; arc=fail smtp.client-ip=52.101.56.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GtC5vryN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVBq59NZKqZ1MVPmF7sTTzXE6OkLYNLx5lNHysrtx56EjstSvHc7YgFkaL4QHNXOTQfMv2Foha8VUDE6DDNZmF8Q+Ig2RiOhluwPXJXTtOX7IE7mRA66ZKp5nsmbL4JsEiRwRFg6hc5skMzohVwD1tvjLHoEZKWbgF42z/Ze5PMClEFeBfqz5RkpYvGJaAfyLOZzhLMUf6aAmFaFH00hQDqTV9dAjWp16ABoscSgrpPiHIvDQS4Y0g059IyQW/b1ISTkyG9Frdnus7CWRZRJUVVqpJLPa807/xHtCIIh3LIJ1MPXWUqI9EhCoO+k3K0yoomUOqMrkO8/7fh8ZZhJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWrcTGDeINLsGwlJwWhQm17QrmWby2vx8MBBqUgEQws=;
 b=tz2RjO1LTdQAToYSlpE4YIIvdwz4YCHnzHvvTyy62atI5RDOFf8qxwSMiUADdNP/t96aK1H4syFqauIcQDjh8ZU4SxLi9Ugdm+f9WubDIF78AnjpdetFYagAaRm1WSSA4EBEwdyw8W4VQWqBoTwkSe2Ft1fWkUKmW99ficvTNHWlz3WJ/4RMtFYNqJ8lguapBrWhxbDsBZ8UHC+TVpPjZCanWvszgYtp1pHh7Ky3VygD8epLf1N5spP6DkApFUdquy6k3ddftnIMKVH2bgy8bLnAa+s2uEcBF8DKvIftaEPVBcifC6j4ElnOM6klqKAOjIE9uITLCJbSnAdh81ViKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWrcTGDeINLsGwlJwWhQm17QrmWby2vx8MBBqUgEQws=;
 b=GtC5vryNpdECAmn/HOjgc30gxLAPfyBW7DMpZks+FyF1dFqXxlFmu8hpX5iuMMbAk8HnZLB4tQBoV1qJfo3jHTdFhxtI34qVmyT4AqH0BMRvOfuIoXFawzd83I3efdG/4lO+UwxuCqNfEXDXdXsVqUAUT0k3rxgGyfDFwcVH5jpCZFyhkjMnbodda/Gr4YCF7YbFqoHa18OiuWZaUI6yP0Jv8XYNmtKjysmdvVWy07ctSXbDquk4oXlZY+XmMlXZQVF8H493uddkgSUbNwM101cX+fNk1RuB8oCMgm3TwvzL3jMdP5mttYWoJOti1MfC+7RXSjySpyb1CMTTrSzASg==
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 10:21:30 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::d) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 30 Sep 2026 10:21:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 10:21:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:21:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:21:13 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:19:37 -0700
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
Subject: [PATCH v3 05/10] rust: pci: add num_vf(), to return number of VFs
Date: Wed, 30 Sep 2026 13:18:46 +0300
Message-ID: <c65da1c1437da6a543720b1e04e977a665ae2de7.1790759932.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: f683ac0e-5caa-4b33-65fe-08df1edc9760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700016|376014|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7px215HE4/957ibHke6OYJO/uhvcd5tcIVK3i3i3ZF5QYXN4Vs2knZmruz9e9nZC9KO84sF7XNv6g0shjO0zOJC45gJFXaI9hp54ypdr1qfM7OqNhWpfaXlc8XrqzYhjkVv/vnKfyPFXAriK0iAWklg8GhiJU/xHGYiE4OMEb0BstgbZBJkTiIUBMHMqdzUabbvjXhzmOURSSQumsHS6eoSgzqDCTLNihl7u4slGq7yB49ULjM8JUfqR3lgY9e2AFe1aqgXOktXS3ysCxDi2BPdwPKqvu0SsLB1Mq6YiTPUx/9yPAiqM7dBjrUFeD8XoydkgGkFaV3EM9gap6SJWO4i7VwkOf7ZgnoetL7L8Ze5EbUJ15MILKxmSr4u5rvrejk6TNdiFWwKQQgkSYU2z4r+WqPzjTXOZF46WIx1GCQlBfhbj2rY79fnlDMsNRuaMYXV/aDafJh5bVacVAKQVZ3LUNzMVAFZMDn47znAPsyb2RbbWjwsf3xV0dX3OGo2PHfFY3Y+D0Ij8sBb77K5wqKI4p3ueDGA1IC2iuqtv1L5Rnp/9foPzlZucdHeHYZ1lMbtP24rJ5ut4uH2vap7FoE7jXXFyC2hp14qrD9TSNE9ZL4dR6VYQXJBp2O3gIX/rHxoOOZVWV7qj58KxW9GN/yl7utS47lHpZUvxbFdLpClCgcdhItGFd/2ge0M3/FcKKyrfwgjhvYm1csLAMNo3kA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SYC8LyI0ns9oWB//otnpJBz0XkF7kR8U7v8tOJmQ/fKbooOhKTw2RF+OO22AyIL2PjrkiARqE/8G5UO1WPay7scCbD6ujoShAhTAvIxtYaQc2APBMszifEOoHfz1ow+2jsvo3DBYEkrJ+mirGK4ROhX/TNIf2X8obSv7jBXU9pTk1Zk4iwH7pifpJFB3CeNfXkWsANvi0s6bmGShTyrt9XBzVFgtLreslQup3GbrSB6dhvT/9GJ9KAglfz7K+a5Qav4t2O6fJHautDRRrEKpwxuhKHqSuQHZmIIVUQ0CfBnbweGip4Eb4bAKkduxpjbllOPXvsC3Oc4h2B4f9fmr+fSZHA0HEmFcI5MI0oTbgGb9pg5hBMZM/XhFAUHupssRRJUcCLrfOPeSss2Cx4cOUoq4Q8NNmJLWTz2a3USpS7fYpHhoJA+QnxaHXSh6HnP/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:21:29.0849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f683ac0e-5caa-4b33-65fe-08df1edc9760
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

From: Peter Colberg <peter@colberg.org>

Add a method to return the number of Virtual Functions (VF) enabled for
a Physical Function (PF).

Expose the query in the PCI core callback context.

Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci/iov.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index a4a23a9ea77a..4f611d5d0b89 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -28,6 +28,14 @@ pub fn is_virtfn(&self) -> bool {
     }
 }
 
+impl Device<device::Core<'_>> {
+    /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
+    pub fn num_vf(&self) -> i32 {
+        // SAFETY: `self.as_raw()` is valid and this call runs in the PCI core callback context.
+        unsafe { bindings::pci_num_vf(self.as_raw()) }
+    }
+}
+
 impl Device<device::CoreInternal<'_>> {
     /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
     /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
-- 
2.53.0

