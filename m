Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AD44B0CAD;
	Thu, 24 Sep 2026 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276859; cv=fail; b=Qp+dxT8NB8EZNdqaF92saaAuvn3iMrBE3pxuZEbyM0a1zfLM0iywTNzdA1RrA3kZVeSIosBTrkfo2LgJ9uYZPkAzxBElYR+4grHc/wkMp5KVSg1zsabpvhWxtINJh+/yXkw0cqHO2eJqlr//yU2sB22JSNQZhgcy5yNR6hls4hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276859; c=relaxed/simple;
	bh=pyZXgEuijsareWbZI/CH3LHEdGlYVJWrJ79CxeSOPR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xn2ZWAfKwKbCQEmdr9tA+i0y7HHmA/vX8uwdUwuivNiJJbTUvnIudiqqIjYZPzIgKLtLChaHLQW2PNG24XkyF0sZ7qdwHhFJC8KeShU4Poblo/eTRAumnKIfPaRzTX7nAI42J9v/PXhkQw7KDsvXFpNLDMi8d6Lx2wFAJDAbkwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jpCbTFLf; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jpCbTFLf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr9REjZa4o7xrWr2UG6mke9fyIMSylWhCc9BKJtyxqvGdERYqdBnFLHtQ3+bIpgeCCvYKuHriVG+U7YyeOJ1alhLug8BFHk7fcRkLoMLl8xduaQQ1eFObr7Vw9CA6WWmLqWkLOVb0wd5412DRRXm51aWayHV+XfWUtSQym9VO9fuasdUzk8jk6uvOBmqlhGdTwcYPsXubYC0Rc2tHfzpis2cVernyQbBWD2dhS9YvIjfJMD6/BLm+3DJvJy8acHPjkxH+6WLdXf72ZQbXO2j/Gs4pIfPI+oJ5Je5oyUa6w+yiCgHg5TpKb8CL1Q/CoC2Mhfkzv3BHahpqEtNuf6BqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVN0IoAghKBaeJtRY3Cz7QPdZUxSy/hdNR8e1Iy2kPg=;
 b=K+ZBNvyUZV3pBUwAOBtmZdjb06K+LMK1tE7OSVmf72KtLREH6cZhJpySUDBS3+GPnEg9TTnl/uvtnE2hf1Wi92iq+TnseV+r56kiksZ0r/QjuzCSuuMRkm1qC88sPlMWwAUCK2Bd0e2cs0+7Ton0hkwF8zJGqPdoVvOGNaZU5tbpZ9TNrgLo6HYB13lp221wHmmQ3hWuB7y0+cDYQD/l2ShHqC7TgW2HvLgB9Lgd4ssYKxkdV7MGMh9Zgw2xwLzLwUsVP5ZdxKEVc7nP+Qj5tkB7z//OSV8v0+GW3TsR23lerWG+aKnU4YeRp/5Wff8+4zmyYD5PGrnZTi2CED/09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVN0IoAghKBaeJtRY3Cz7QPdZUxSy/hdNR8e1Iy2kPg=;
 b=jpCbTFLfVUtdV85va3dSmHXj+dtYxVJyKkTjDRbhdMlV+hd53UPE7wa4G1WAnV36w54os5EzuLZ7OnlWVj9mzj7q5QdHirnGBTysXr0bJafYj1wnhGcHWfRfHvl+tryYkqtIdhhhoUGJwSny1FzhL8UnbD/PejrP1ASi5tqE2r3IQl7vKeu942thzhCylxHEzPsWIuc3RhlC5JzwxbeBANob1iYh1oIFxIg2k7g1R3nU0i5cM12prrxWBRd+aoSu7eGHqGI/EGK447sl5ft2BJflfEfJ0m9mQcHCNPy2oO00V7O6Exm0DawWbVz9yoJR3NoLYuAFQQfFplWvmFwizw==
Received: from YT4PR01CA0468.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d6::10)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:07:29 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:b01:d6:cafe::93) by YT4PR01CA0468.outlook.office365.com
 (2603:10b6:b01:d6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 19:07:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:07:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:07:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:07:01 -0700
Received: from inno-dell.home (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Thu, 24
 Sep 2026 12:06:52 -0700
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
	<alex@shazbot.org>, Peter Colberg <pcolberg@redhat.com>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v2 5/8] rust: pci: add num_vf(), to return number of VFs
Date: Thu, 24 Sep 2026 22:05:52 +0300
Message-ID: <20260924190556.1620886-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924190556.1620886-1-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8e0614-4abc-41cd-5597-08df1a6f1380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QIJGsvkA7QMrmePI65KYi78ktZTOzHPi5H7+NpfVsxUuJWNRLmDDi8BMOiGzAkghH5QIELQlHWOa13oPIzzXCI8P3+1hUVawpBj0yIbdFsSI2hs7+vqOhNqPCy6JjSZXvGWEBv1FdGmMFhQYbuWt8e6mTt0KE3ybpH4+VI6Dj/dzqc23Dgxcxh5nOKYdk6p96f7bEyWQWeyS9d9jrDGKYXZqOTzvuDPLqrUQ4jbYhig/2voZRE+0ZJT1yi4GkMftLFlxAuDdqJPrDK6uHFvobwWl0kO0pGDGyRjitcN0F41pXukf4SvmPdh7qk7NqfND6QMWEU+PvoU3eCodHDjV2jjk28DqsvshztthlH7tYAMbvYcNuSPVAsv4At8xap0JmKWydr17kw4ePTvvV+OxusFx4wj09X2p4t2+04AGrGPAd7T49Krk8NfWLe9jtLrQzXOnrMhOZEBqHrWky6pU07fxGSaeklwJA/r2HHRwNk5SF0CYoyKoDDVdaDCgsbVtbvJTqHcYlI0zqlbyoTELQ5Wf3eFG61RCeG312oja9/VbVQgMw8AOGdj4tIFTAtyNMnV1rPbs/6hRPTt6jCSGwqfi/VHtbGiUsHj1KdLEZS+s/wT8I4ENrbjcRVoJYq1OgzuUnh4ux/Dawuyy/xRKOMaEdwWR96+KJR4vgZ/VKKb+jz6uCvTEdhSNeGf1oAMf64TlWJp8z4OoV38MzKl5iQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kfFL/q+67Fu0zZH+CrIMZRa/A2a3lld/6QUmoa92EEzOyGtkZpAgW3xwPG+jdoCETQv0LB7SRlee+/pepXgKBfyhhgCqhpXKAM3BTda1tYtGhORJQacQFhcuC4U7V3pxfN+EfELl5vW+bo8wh41lwodcx6MP37ia/L1/57xqsrFkbv29rCv/QSncWQ2ZPly7PROhtcdHstqAKyO6qua0Tcqc0z+DM3oh/ee/WbHIkq05xPq329IZ7aEUPvsQ6Xe7PaUC9jyoL1yj068muKXGuRRpEpbm/CpRSpDFqID4sJ0KNpHAejzk0Trasdvk6JEi8IBsnhxE9mw44xV5C37cyPq0X5S3PIUv5iHugvfESe7DjZTzqkpUQjnXcygzYal6iqn6FvnUwloVGdX24MIcq/ufW85g0Fo5ZCLHmia1KBeQ9XpVOze/3lY4BeqD5jTe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:07:27.8872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8e0614-4abc-41cd-5597-08df1a6f1380
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

From: Peter Colberg <pcolberg@redhat.com>

Add a method to return the number of Virtual Functions (VF) enabled for
a Physical Function (PF).

Signed-off-by: Peter Colberg <pcolberg@redhat.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index ca009775bd61..db0554f14afc 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -449,6 +449,14 @@ pub(crate) fn is_virtfn(&self) -> bool {
         unsafe { (*self.as_raw()).is_virtfn() != 0 }
     }
 
+    /// Returns the number of Virtual Functions (VF) enabled for a Physical Function (PF).
+    #[cfg(CONFIG_PCI_IOV)]
+    #[expect(dead_code)]
+    pub(crate) fn num_vf(&self) -> i32 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { bindings::pci_num_vf(self.as_raw()) }
+    }
+
     /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
-- 
2.53.0

