Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B31DD0EF;
	Mon, 26 Jan 2026 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769464841; cv=fail; b=fKI9IcenqaTD2BF5gBGDq/IIEBdw928rGZ62RB41QA/ZfjMB1zTpYK47mdjM+3+tthyqANh8quMkBr8CK/ZQhjqT+lc5ymaTtOtU1PTmw8KOPVZa+cGpba2reCCLzE8kiy87hJRTrRYw3HLiMfutF6lqtdi8E1NYCN9p4Mt4wHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769464841; c=relaxed/simple;
	bh=g4k1M+6HkXvCQcDmHoc4I8h6Y+qFSvFA3iTyh9iz0f4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJueYcNjVPzN5QxqYrxxokQh2n64YlOSH/fm91TOcDZXYkfzPwzXmu2tKnt/B8oDgaUNa/DIhrg0HVNfnVgh6e5RAZjP5id/vtNuCwq3REEkzgfd8brx8+fNM/HSxdlx4y7pygmNrbgwLZfAManDL6OIJXtCOyHU6VNiKhUdx6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sRccVPtY; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sRccVPtY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtWeLZx61FwI952UJ3vMriSctO+lJoGttEOvtikDVoL+NYOd653KLomliCcVX/jnWAkY2b2z5tt2WOkXZAVA3LZzW97uxqvnrJlTvCV14SStyppE5Oy/nlWZA6GQpu6eaKSZ248AKFz95AdB8kSOhQ1BFCGFumHETrgInC5DJM+qimwQQHvQFUP+UbubwaSGQAGoy6+TsNYcFjBRcN4NHuCUzg997u1u5E5oSI33GQdVwjpl52z5K2yKCjiMrAGrQ2yvbLM6gwVOmasTCrX/rBNo7pUjnH3HB8wKMhy7PKyJO5TJWsufJnn3iYUuWMk2sxcG6/IQYwDfLeNZJ72XpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxwttvAtnYSETT57qcf3CBapjKIpqcCF4d4f+2fj4Y4=;
 b=qZrNYM+u4znB+Fo7Y/BGhBlgibBeCRhIdc8rqbE/D+TDAyPYYl7DO043WaRzA5DoanmJuIMJL8NjdZLbzGuWrmdWb1HkdzXi2Ya0tiA6CzS1HUyuU+Bey1HEWZ7HvcG3ZKgEL+WIb7XseWssuTLh5GBhTuEzqCrx+B4Pqe8docCwmRVwWbK4pj1PLv266qPeCygxWRejGm/WZshGwNpmECKNoFQiVrg43+uoDoKwQE9+nZ/5056gF/Pos+aEzLCzya+iVUpD6ugfhbsERat3CfPNTecKhXFmEMIeD3PlnDwRrgQ1oZoSbE0AjxsE0VArrq0+mDc1j6xSdG+hsi79kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxwttvAtnYSETT57qcf3CBapjKIpqcCF4d4f+2fj4Y4=;
 b=sRccVPtYmV46jtwZYBEtpB1v7RIFaMNjQDELHoeVCgisG06Io6GZ5MHO2MOF6TDtqJLJIvEHVNX6LOBieXeFq6zLUN87S5R76D77cbAP0enhKksthhnkuNkYqAkqCzmirStTyNrNFn6eskQYz4Ucfv3tvgJ9WJO9tIKVes0y6SlWP2Qq+G2SLhC1oKW5UIhiQ/F8NYrUxVRZV47OgZrBADAq3DfgzMV28ZSal14A5SInjnLb5zUfNut6y6y6d37N/EHd7OoHJFArSBZ/DjkThujhCC6kfL/WEGbnSnBhSQYvgdBvflGTJg0PUhgF9RuJUmFIo7L/AysQOItLy8QisA==
Received: from BN0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:e7::25)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 22:00:36 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:e7:cafe::32) by BN0PR03CA0050.outlook.office365.com
 (2603:10b6:408:e7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 22:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 22:00:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 14:00:12 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 14:00:11 -0800
Received: from inno-vm-xubuntu (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 14:00:05 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [RFC 1/2] pci: Add fallible I/O methods to ConfigSpace
Date: Mon, 26 Jan 2026 23:59:56 +0200
Message-ID: <20260126215957.541180-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126215957.541180-1-zhiw@nvidia.com>
References: <20260126215957.541180-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 18651b63-48fb-4ca9-e9db-08de5d2654d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9KoqzpP4czZ8fLhBISKJ6D1nE5XIzn9pomlhB6K1tsEPoaJBWEs/RSPcfYcq?=
 =?us-ascii?Q?3ayvdj2b/ALB9Dh8E1vts7SWe8ME1fZ7dnHiSeeDkICAWXc9jhyioOgrDGe4?=
 =?us-ascii?Q?dZR9V+FXrIEAkHiW6Ccvvcfq0Fc986gEja/JsdEeRPjVCxx3MoDLkboWnQV/?=
 =?us-ascii?Q?1iDE7rQq9IcFfB2VsU6CMrAGiB/601aftn5av9MaOrkP0aWMPLAeufUoLP2Z?=
 =?us-ascii?Q?26wDvIvctgSOkTbZ95QIVJjkxX1JyHejCkikp+BUC96Sr65VB9o6jKE5YD/n?=
 =?us-ascii?Q?PjzKDxJrY7jkNWi+HyDYKjAWEiWhlv9W0neTeS8vKod9vDcsN9UCy38FnYc+?=
 =?us-ascii?Q?/ypPpfHB8jSpGKa6SDvfA+F3BwKF3z9B6SbJzLt/HP2VMcylNzGvEoV1ZUHk?=
 =?us-ascii?Q?gZ71D2n/RLFebofkh+aWmVsFpcounTBQMohmVd/tsFCfAuTnqYdKKAEDTei5?=
 =?us-ascii?Q?lZ7hoOrlqYmkEhm/uBLnlX66qjtCpgI1CMOEDsQdYxav0VBGRSxlPsnqGnCt?=
 =?us-ascii?Q?axf3BneadZjVTcgPMoBpLYRjMsTatffEhKowkBz78L2dnxU9bYzGK7w8NHZO?=
 =?us-ascii?Q?Bv0JQ+8K8rZqzOeCE8qecGvnhm7SLOgCorHqpWBQyq/eQgSO6FYlYCLL1roj?=
 =?us-ascii?Q?1I3YESqqygzvBKi0WSfFjQ9S1/Rr2mJiadRzYOO+NWSlSSz8B6WR/73flbk5?=
 =?us-ascii?Q?fG3jzfP41CNTRp2g5+EFhUPGvIc2b7OmliJGB9TjiGv+UH4LG3EByuYVOfyL?=
 =?us-ascii?Q?rkn6IxxXMAYTKOXNKl53xgUaA2jFJGqlqznLIuu96OhDn/MWuA4R0qT98eZq?=
 =?us-ascii?Q?+PF707UF8UbuQ2meoLK+OAt5mvq37jZbE03RIoT4xSuPpTYMqKUxL/TsScEq?=
 =?us-ascii?Q?gPoLtZ3adEB2E+JsHTYkC+gnbvhONO9FynTb96+pdcLSYcs43CYRXEgWiXtC?=
 =?us-ascii?Q?Iwq0zc4k214hU12V0vYORKKpUB21FLqS7vxIOImHPuHJFw1neKC4hMxRx9Rr?=
 =?us-ascii?Q?4SSkdWgp7iS52SdiDxHC3mlIcF9deJwty93S9ajBjOgKy2b9P3m8DESYWPk7?=
 =?us-ascii?Q?3emq9eaxFCzYZM3KIGHWZthMJxb0clrYic9O2G8M3K95rrcm5iV7XpcrA1uj?=
 =?us-ascii?Q?TaOxiqqDcxC4eyPTjI1k5cmO4dQOa8XDsPmxFc8+TQcdWhauwkDwrR2MH7Aj?=
 =?us-ascii?Q?1ZylNVn+p8OHkNHyHnvOdrU6baWZULUYYePp9kt9foudu25d1Wa/7MaDvXE2?=
 =?us-ascii?Q?9D1JmHmXxmF4HyqHBlWtPWyV1xK4FZEYUWHXW1SoYjeu/twxpIydkmmbDCtO?=
 =?us-ascii?Q?zEOeNvbXxCGjlAAdk1rQMBzwzWFFfIlIpFtfpVSB09YnbdJwwWIewSSAlDS4?=
 =?us-ascii?Q?1XQBZgeIoUmfp5oiRFIVSGACuLl1Nm+1Uv+JIPHSfJZ+/8qvofcilyh50UPu?=
 =?us-ascii?Q?LrT7H51RToPDnAmEUf6SMNklL+XcwAGa2sjHJmDa86sxp5t1Wyilq8fh7uIQ?=
 =?us-ascii?Q?VyyPjdfn48bFrOrKkQJD6lInfRQUUsCBaHwRyrcRVi3U5ra/AKEbfrFyBnNq?=
 =?us-ascii?Q?DGgyJTkXBVZMXvPY+vsw4RepjT2Qxf3TqHOl38MTGACuEszoGiB8GxOnym0U?=
 =?us-ascii?Q?bu7CafcHxWvx5XP1rkftm/SRlHH9DY1AQMDgvDGS3Q4eP/CepPJLVdCyrAUW?=
 =?us-ascii?Q?zhFGUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 22:00:34.4965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18651b63-48fb-4ca9-e9db-08de5d2654d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474

Rust PCI drivers might need to access device configuration space with
runtime bound check. The existing ConfigSpace abstraction only provides
infallible methods (read8/16/32) that use compile-time bounds checking via
io_addr_assert, which cannot handle dynamic offsets.

Add fallible I/O methods to ConfigSpace.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci/io.rs | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 026e7a3b69bd..9fc9af0f9bfc 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -112,6 +112,17 @@ macro_rules! call_config_read {
         let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
         val
     }};
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        // SAFETY: By the type invariant `$self.pdev` is a valid address.
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        if ret != 0 {
+            Err(EIO)
+        } else {
+            Ok(val)
+        }
+    }};
 }
 
 /// Internal helper macros used to invoke C PCI configuration space write functions.
@@ -140,6 +151,16 @@ macro_rules! call_config_write {
         // Return value from C function is ignored in infallible accessors.
         let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
     };
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
+        // SAFETY: By the type invariant `$self.pdev` is a valid address.
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+        if ret != 0 {
+            Err(EIO)
+        } else {
+            Ok(())
+        }
+    }};
 }
 
 // PCI configuration space supports 8, 16, and 32-bit accesses.
@@ -162,9 +183,7 @@ fn maxsize(&self) -> usize {
         self.pdev.cfg_size().into_raw()
     }
 
-    // PCI configuration space does not support fallible operations.
-    // The default implementations from the Io trait are not used.
-
+    // Infallible methods with compile-time bounds checking
     define_read!(infallible, read8, call_config_read(pci_read_config_byte) -> u8);
     define_read!(infallible, read16, call_config_read(pci_read_config_word) -> u16);
     define_read!(infallible, read32, call_config_read(pci_read_config_dword) -> u32);
@@ -172,6 +191,15 @@ fn maxsize(&self) -> usize {
     define_write!(infallible, write8, call_config_write(pci_write_config_byte) <- u8);
     define_write!(infallible, write16, call_config_write(pci_write_config_word) <- u16);
     define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
+
+    // Fallible methods with runtime bounds checking
+    define_read!(fallible, try_read8, call_config_read(pci_read_config_byte) -> u8);
+    define_read!(fallible, try_read16, call_config_read(pci_read_config_word) -> u16);
+    define_read!(fallible, try_read32, call_config_read(pci_read_config_dword) -> u32);
+
+    define_write!(fallible, try_write8, call_config_write(pci_write_config_byte) <- u8);
+    define_write!(fallible, try_write16, call_config_write(pci_write_config_word) <- u16);
+    define_write!(fallible, try_write32, call_config_write(pci_write_config_dword) <- u32);
 }
 
 /// Marker trait indicating ConfigSpace has a known size at compile time.
-- 
2.51.0

