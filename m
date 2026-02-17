Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471A1259CBD;
	Tue, 17 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361400; cv=fail; b=j9UZzPlTVkbP7ybmF+vf8ps94UTmDT/WMS+6pTlecI3Khr6e7URe/vAN3bOmVNLgH7OAztzgvamXhbffffN0gWQomQTABg5XA2pSt1LDIlZYMfdqpWOH0J5lKAk/3AL99dipBhzSPFM8/IB/zMdDNFVcTffyTtFfyCpJ+6Dcm6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361400; c=relaxed/simple;
	bh=ubbnnhPXIfPRsBEglCZxBk4l6d+zYdc3A9GkiIHfogg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxkz3ZEaw8rqlXvuxljlJXxVH/C2Fi7MRjJ7KTphYaf/HxrKAugJzu4eP5rFHMUfh3iHdWgwdQRvUw030C4hH44oW806zvzfTy0TkW+6pb1o4HgkbzYAy3VqMWNtaVCDewUjRAmc9wqSQbyJ+CC50eFtP98sOw3JPcA5Q7eN8To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=prVxL1Ql; arc=fail smtp.client-ip=52.101.48.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="prVxL1Ql"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUP1R+uae/bMbUw7HLlAjKTIjPQlPb5XJvXzY3LRh5gBAw+L7pUqbsraA0j7c3ZAR+LpZWtZJKuuyI/TynCPVgtlA4urKGDLCMa35V2pzm9K9BcElvqgm2gcK9pM5Xy8CG1ht2W8vqDhxu5cUqnrl5U4KgaIEyPQZCiX/J3eMxdBJrTmR0d/syEYL4nw1hH2f+ShWK+DHQEDj+aH3gA6tySFiIwnN6IF2Oa4OiKLk81Fu+oIlNqDEGKswuwd8De0i/yai94p+GbQTUgKqYBDgK8JpYcljduxMSwIFdFKTccGYnBq6h0T/o9IEOKUl+VXCn7wtDUq+q36Iix+YfJKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlBiRKaZ8SSuXBodxLOQpqwBMMwIS1MSqb/PlHGGNIw=;
 b=GDMUNqaBvgtz9N5L14/vvUsLOyBNKEYdAO33QfN3YSElI7v7FDBxbaS9C1afm9zdjbrKhX7o17YF0fOMBG6oKH7G+X+sCFTja+ypJLw5sod6vcN7wkKr1ZFB7h7+fG9LS3CF5x5DmZtW2ko4YLSnoLc4eKTYTT8ios9RN3ZCBzZUXJZUtf216erFv/bQaxPde0FTF1wSgWuUoxobjyqvQTv8io1WtC2HNa+5W4hFDoWD8xXdo/wXu8+FBSOtRY5YiIyRnnQkf351aPRbhDuOLWizZILRHYK53JPdgNWoHsmLmT7SHbqNx8fqU1vS0tZDDGSKQIwACsWQuYYdx9bRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlBiRKaZ8SSuXBodxLOQpqwBMMwIS1MSqb/PlHGGNIw=;
 b=prVxL1QlX8rw6I8Bu2XmSSieqLfSEjDhQ6gfHP6sMc12MZ6OP2O7j4baj37q/eVLXcO98p/VUNq93Z6LqYh3Zhv1QhUyjrYfc9dX2js67OuUTFuXCJ9V/Qy5Sjhvi56IxorDHx1fqKS+AkcpAOqnuE5wxABHM3oel4Scx03KZQHbRMIiZn10JILqHfzV9DQwiEoap+KRdBb7SC+HNCuWE+g/Wz2fIPNPrnBQtV/6cV34/AaDjWCm7P4ouEZPceJczM3f6ZLyfsqu7py4vcP3qA9GoFGJVPCgckoF6JPg7ma3YNCoJN+lwWflLs0hCR8f00r5gConRrQEzYBjiYE4gQ==
Received: from PH7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::23)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 20:49:49 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:510:326:cafe::78) by PH7P220CA0022.outlook.office365.com
 (2603:10b6:510:326::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Tue,
 17 Feb 2026 20:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 20:49:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 12:49:28 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 12:49:27 -0800
Received: from inno-thin-ubuntu.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 12:49:20 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <jgg@nvidia.com>, <gary@garyguo.net>,
	<joelagnelf@nvidia.com>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v3 1/1] rust: introduce abstractions for fwctl
Date: Tue, 17 Feb 2026 22:49:06 +0200
Message-ID: <20260217204909.211793-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217204909.211793-1-zhiw@nvidia.com>
References: <20260217204909.211793-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a73de9-5233-459a-1990-08de6e661769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3o4OEVSdVVhTlFaOEtXNzBqc3JiME5lUURNMDVYL25SWlI1UlNITGtSZmZX?=
 =?utf-8?B?dUp6bVY4cUdxMVd1elVWemZXV2p1aWIxREpRa0FHVUd6SjMvMFhWK0NYRUxx?=
 =?utf-8?B?TjRpUTN3aVpvMXlvNlcvZXUvdDNadVc0dW8raEtRNHVDdnE3bzBRb1lWc1ht?=
 =?utf-8?B?ME91bW9rY3lPWkF6SGJxUVUxdXpVcDdwUFpvWG9UUngwZnBKSmlEMmtqVHFw?=
 =?utf-8?B?YXVjZjlPVDhCWVFoZTI0QVZiUkFCcHFvcnNWdXRjdDltbG9tWTNlNUgxQ3h4?=
 =?utf-8?B?UlNpQmhyR2YwbFRJWXdBZFptUnJHT1dPMU12S2FBamtnSUZ4VkxXZHFPaEZp?=
 =?utf-8?B?YUFIaGdTVHYxY1UzNE03SU9rOHNHbjN4VktmQmg5WFVVRysyYTltSkxVdGFn?=
 =?utf-8?B?dEp6Q0FMZmduT3B6bFgyZXJBZ0Vmbmo1RVlYdEVYNjhsd0pMMXFqdS9SL1dV?=
 =?utf-8?B?U0NRdXRZa0xHNU84NEg1T0gvUEJ4bmZBZ1E5OWViSEFBNVEyQXhmZFlBUVd1?=
 =?utf-8?B?djlsdHFSZmVKd1FHZmlJeVNMVkNZZzNpVU9ySVdnNHBmcEI2OXhaR1FkamZ4?=
 =?utf-8?B?dG03MnRrd1FkWWZkWTBzaDFOdERNc1lBUEhvdjN3UHJ2bzY4Q05EdDVMZDNE?=
 =?utf-8?B?YUduaFR2V1FDTnpGeitWWmNzMVBiM2tRWDBiUDloaFJxQlNzRTNKU3hzRXF3?=
 =?utf-8?B?NDdCSWRJUkp4YjcvZnlmTFZXV1JsMjFlQjlUcm43RkxWVHVmbkZPMk0yU0ZO?=
 =?utf-8?B?NEM3cDM2NGFrTzM1dHNNazA1VTZtaWdzQkQzaTFPOG4rMkxDY042SGtKLytj?=
 =?utf-8?B?RXR6QTFrTG5BNW1rdW40QTErNmd1UkJZdEM0LzYxMTlOVWdFc29oU0VEbzl5?=
 =?utf-8?B?YkI2clZxaDFwQ3BaaVNYSG13R1kxZDRhVkFmWkZFRm9ucG0yZERqWXFINnVv?=
 =?utf-8?B?bE0ySTFadzNYc1F1cnNmelVPYXcrMXZvTkdaWHpGbVh6TjdMREM3cnIzYjIz?=
 =?utf-8?B?MUFSQmZVRlgvczRsOXZNRUhJT0NXdkVjZU5PUUs1eHhiTDFqYjUyZkNKV1p3?=
 =?utf-8?B?Q2xIMmNUV2tsejU5OVYxRWJ1VkplVGVHNy9JemVnVS9wdGZXQ2JwbkZtVTRK?=
 =?utf-8?B?U21WN3NUb0pOQ2R1WXNMbGJyRElvaVBXdTRZV1Bhc2dlZjNyc0N2WXpFSUtY?=
 =?utf-8?B?S1VBRXJHWkFGZzJoU1A2MGVyMWNVZ0g0YTQxUVJ1cGVNMTkvblE1a1ZnQ0xj?=
 =?utf-8?B?WFVkZUZpTTJkSFZrMCtwYzJXVVFTS3BEdENnWFVndXJHb1VTb0xncHRaQXo4?=
 =?utf-8?B?SzN6eGkzNXF1Y0VRV1VwZnRKK2RtVkFLb05yeFpIVkMvY2FNNzNudWRkNjdS?=
 =?utf-8?B?UWNUUjh3ZFFlNGJldUhnT1ZxLzVuSnRUMDFqRUU1L0V5VXVEa1lXREl6c3RJ?=
 =?utf-8?B?YmpmNjdUa3hVNndWOEVGNWptdTRFMktQakVmYjN4SGJJZnNpWllnUTJHeHJT?=
 =?utf-8?B?b09sK0hRWDloZjZzZjAvKzdkbTgwYlppc3RNREhFdEFLMnM0c0dRVjltd2cr?=
 =?utf-8?B?UjhSOVZXSjhBaE9LaTZFbHNtNkFZcHlkVW1pbGxERWluc2lJTVVkZ2dsUWFP?=
 =?utf-8?B?d29oNEVvT1QvVEprMkEwVXFlUlM4Rkhrak1pYWtkOElrUkl6QzhBSWE4WWlN?=
 =?utf-8?B?ZWt0aS9QQnI0MlJEblBEc2dWMU5MOC8zbjVCaE1XQS9FWUtMNDB6UkFFZ3Uz?=
 =?utf-8?B?dTBYenFtRHprQUk4YVBOYnZsUWR3T0hETkpxQ0xGYlBjOThlbEtlV01zOFJk?=
 =?utf-8?B?ejdPQXh5d2pBRnJockY0SkJGWmhrYlNLYnNIOFJXY2Y3cUkrMEF5bW9yV0xw?=
 =?utf-8?B?SnJVWnh1STk5UkNKbXd6YmxzZFJYdFJKMEozZG9XKzZLSmV3R0ppNzB6eHZM?=
 =?utf-8?B?OWcydUZpTVZqMjJFUUxMNnFNUFRwM1VNUUxUZ1F3SXBPdTZ3WlJRQkZxZlNG?=
 =?utf-8?B?VkUzYzBSbXVCRE9CY29KTUlZQUg4M1J5MnhPKzdjTmJaS3pNMTVNdmdCN1h6?=
 =?utf-8?B?aEppUndTY0QrQklqYUJ5VWRsNGs3djIyMTB6dGRSTU9VRjBJQk1sWmFqOVRn?=
 =?utf-8?B?bnRKVmFzM1VUaVBqOExJZTd5U2w2b2JxZHR5ZkdpaHRNeFFnL1dLK29Uc0Ja?=
 =?utf-8?B?c2ZaczUrT1JzUmgveGcxRHdIeGZ5d0ljd05HblFWQ2FDeVNJK05IK3gyL2lo?=
 =?utf-8?B?Z0QzdmxzUENHM01veFp4bldtREpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gLAJ7Gi9QVOWsDxWZCVq4dRhSOVHBBZ3X7PgkdniOkpXbKoOiarfikYWyuewLVWsD10Q7+he3P8jlOKeQhSIO7pfuxgtvuqRjYoQnwq+akwoDbvDj2hTzhmHRD6P8YL/iDhPMZ/ZEQDuHyY6zw70wLlDAzTWeCZpJlr01DuV+KAFulZ8HBvnCC2w5SSkjBFSNRc1Sdj9LYRuswCkf6vv0ae3LQ/5YZmJxjo/Lkj4CNWxkDSQXI0UZDSQltct8v/OeEd/fjt0DbeVLvi0OlqsY8dhYZ6Zz3J5++uQZuTfcT3KiHACrfI99+SNAQ7zSsz+HqVpCi8NWF6t2LQvkCF+O+KgIZ0jCtNTg8PcWbGtmO+qPgK7IIm1+GjJWpb6uUsgK5gIq5vF73mhLokhTEH9TLxsfGP4fQrHeENQhrT+2TinY+5sHHtGVL0eLtDXDYgY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 20:49:49.0029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a73de9-5233-459a-1990-08de6e661769
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

Introduce safe wrappers around `struct fwctl_device` and
`struct fwctl_uctx`, allowing rust drivers to register fwctl devices and
implement their control and RPC logic in safe rust.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/fwctl/Kconfig           |  12 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/fwctl.c            |  17 ++
 rust/helpers/helpers.c          |   3 +-
 rust/kernel/fwctl.rs            | 449 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 483 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/fwctl.c
 create mode 100644 rust/kernel/fwctl.rs

diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index b5583b12a011..ce42c0f52d6d 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -9,6 +9,18 @@ menuconfig FWCTL
 	  fit neatly into an existing subsystem.
 
 if FWCTL
+
+config RUST_FWCTL_ABSTRACTIONS
+	bool "Rust fwctl abstractions"
+	depends on RUST
+	help
+	  This enables the Rust abstractions for the fwctl device firmware
+	  access framework. It provides safe wrappers around struct fwctl_device
+	  and struct fwctl_uctx, allowing Rust drivers to register fwctl devices
+	  and implement their control and RPC logic in safe Rust.
+
+	  If unsure, say N.
+
 config FWCTL_MLX5
 	tristate "mlx5 ConnectX control fwctl driver"
 	depends on MLX5_CORE
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 083cc44aa952..c0a7248989f7 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -56,6 +56,7 @@
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/firmware.h>
+#include <linux/fwctl.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
diff --git a/rust/helpers/fwctl.c b/rust/helpers/fwctl.c
new file mode 100644
index 000000000000..c7eecd4336a7
--- /dev/null
+++ b/rust/helpers/fwctl.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/fwctl.h>
+
+#if IS_ENABLED(CONFIG_RUST_FWCTL_ABSTRACTIONS)
+
+__rust_helper struct fwctl_device *rust_helper_fwctl_get(struct fwctl_device *fwctl)
+{
+	return fwctl_get(fwctl);
+}
+
+__rust_helper void rust_helper_fwctl_put(struct fwctl_device *fwctl)
+{
+	fwctl_put(fwctl);
+}
+
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a3c42e51f00a..38fbae6880a0 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -30,8 +30,9 @@
 #include "dma.c"
 #include "drm.c"
 #include "err.c"
-#include "irq.c"
 #include "fs.c"
+#include "fwctl.c"
+#include "irq.c"
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
diff --git a/rust/kernel/fwctl.rs b/rust/kernel/fwctl.rs
new file mode 100644
index 000000000000..38bb6f9ebca5
--- /dev/null
+++ b/rust/kernel/fwctl.rs
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+//! Abstractions for the fwctl subsystem.
+//!
+//! C header: [`include/linux/fwctl.h`]
+
+use crate::{
+    bindings,
+    container_of,
+    device,
+    devres::Devres,
+    prelude::*,
+    sync::aref::{
+        ARef,
+        AlwaysRefCounted, //
+    },
+    types::Opaque, //
+};
+use core::{
+    marker::PhantomData,
+    ptr::NonNull,
+    slice, //
+};
+
+/// Represents a fwctl device type.
+///
+/// Corresponds to the C `enum fwctl_device_type`.
+#[repr(u32)]
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum DeviceType {
+    /// Mellanox ConnectX (mlx5) device.
+    Mlx5 = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_MLX5,
+    /// CXL (Compute Express Link) device.
+    Cxl = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_CXL,
+    /// AMD/Pensando PDS device.
+    Pds = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_PDS,
+}
+
+impl From<DeviceType> for u32 {
+    fn from(device_type: DeviceType) -> Self {
+        device_type as u32
+    }
+}
+
+/// Scope of access for an RPC request.
+///
+/// Corresponds to the C `enum fwctl_rpc_scope`.
+#[repr(u32)]
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum RpcScope {
+    /// Read/write access to device configuration.
+    Configuration = bindings::fwctl_rpc_scope_FWCTL_RPC_CONFIGURATION,
+    /// Read-only access to debug information.
+    DebugReadOnly = bindings::fwctl_rpc_scope_FWCTL_RPC_DEBUG_READ_ONLY,
+    /// Write access to lockdown-compatible debug information.
+    DebugWrite = bindings::fwctl_rpc_scope_FWCTL_RPC_DEBUG_WRITE,
+    /// Full read/write access to all debug information (requires `CAP_SYS_RAWIO`).
+    DebugWriteFull = bindings::fwctl_rpc_scope_FWCTL_RPC_DEBUG_WRITE_FULL,
+}
+
+impl TryFrom<u32> for RpcScope {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self, Error> {
+        match value {
+            v if v == Self::Configuration as u32 => Ok(Self::Configuration),
+            v if v == Self::DebugReadOnly as u32 => Ok(Self::DebugReadOnly),
+            v if v == Self::DebugWrite as u32 => Ok(Self::DebugWrite),
+            v if v == Self::DebugWriteFull as u32 => Ok(Self::DebugWriteFull),
+            _ => Err(ENOTSUPP),
+        }
+    }
+}
+
+/// Response from a [`Operations::fw_rpc`] call.
+pub enum FwRpcResponse {
+    /// Reuse the input buffer as the output, with the given output length.
+    InPlace(usize),
+    /// Return a newly allocated buffer as the output.
+    NewBuffer(KVec<u8>),
+}
+
+/// Trait implemented by each Rust driver that integrates with the fwctl subsystem.
+///
+/// The implementing type **is** the per-FD user context: one instance is
+/// created for each `open()` call and dropped when the FD is closed.
+///
+/// Each implementation corresponds to a specific device type and provides the
+/// vtable used by the core `fwctl` layer to manage per-FD user contexts and
+/// handle RPC requests.
+pub trait Operations: Sized {
+    /// Driver data embedded alongside the `fwctl_device` allocation.
+    type DeviceData;
+
+    /// fwctl device type identifier.
+    const DEVICE_TYPE: DeviceType;
+
+    /// Called when a new user context is opened.
+    ///
+    /// Returns a [`PinInit`] initializer for `Self`. The instance is dropped
+    /// automatically when the FD is closed (after [`close`](Self::close)).
+    fn open(device: &Device<Self>) -> Result<impl PinInit<Self, Error>, Error>;
+
+    /// Called when the user context is closed.
+    ///
+    /// The driver may perform additional cleanup here that requires access
+    /// to the owning [`Device`]. `Self` is dropped automatically after this
+    /// returns.
+    fn close(_this: Pin<&mut Self>, _device: &Device<Self>) {}
+
+    /// Return device information to userspace.
+    ///
+    /// The default implementation returns no device-specific data.
+    fn info(_this: &Self, _device: &Device<Self>) -> Result<KVec<u8>, Error> {
+        Ok(KVec::new())
+    }
+
+    /// Handle a userspace RPC request.
+    fn fw_rpc(
+        this: &Self,
+        device: &Device<Self>,
+        scope: RpcScope,
+        rpc_in: &mut [u8],
+    ) -> Result<FwRpcResponse, Error>;
+}
+
+/// A fwctl device with embedded driver data.
+///
+/// `#[repr(C)]` with the `fwctl_device` at offset 0, matching the C
+/// `fwctl_alloc_device()` layout convention.
+///
+/// # Invariants
+///
+/// The `fwctl_device` portion is initialised by the C subsystem during
+/// [`Device::new()`]. The `data` field is initialised in-place via
+/// [`PinInit`] before the struct is exposed.
+#[repr(C)]
+pub struct Device<T: Operations> {
+    dev: Opaque<bindings::fwctl_device>,
+    data: T::DeviceData,
+}
+
+impl<T: Operations> Device<T> {
+    /// Allocate a new fwctl device with embedded driver data.
+    ///
+    /// Returns an [`ARef`] that can be passed to [`Registration::new()`]
+    /// to make the device visible to userspace. The caller may inspect or
+    /// configure the device between allocation and registration.
+    pub fn new(
+        parent: &device::Device<device::Bound>,
+        data: impl PinInit<T::DeviceData, Error>,
+    ) -> Result<ARef<Self>> {
+        let ops = core::ptr::from_ref::<bindings::fwctl_ops>(&VTable::<T>::VTABLE).cast_mut();
+
+        // SAFETY: `_fwctl_alloc_device` allocates `size` bytes via kzalloc and
+        // initialises the embedded fwctl_device. `ops` points to a static vtable
+        // that outlives the device. `parent` is bound.
+        let raw = unsafe {
+            bindings::_fwctl_alloc_device(parent.as_raw(), ops, core::mem::size_of::<Self>())
+        };
+
+        if raw.is_null() {
+            return Err(ENOMEM);
+        }
+
+        // CAST: Device<T> is repr(C) with fwctl_device at offset 0.
+        let this = raw as *mut Self;
+
+        // SAFETY: `data` field is within the kzalloc'd allocation, uninitialised.
+        let data_ptr = unsafe { core::ptr::addr_of_mut!((*this).data) };
+        unsafe { data.__pinned_init(data_ptr) }.inspect_err(|_| {
+            // SAFETY: Init failed; release the allocation.
+            unsafe { bindings::fwctl_put(raw) };
+        })?;
+
+        // SAFETY: `_fwctl_alloc_device` returned a valid pointer with refcount 1
+        // and DeviceData is fully initialised.
+        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(raw as *mut Self)) })
+    }
+
+    /// Returns a reference to the embedded driver data.
+    pub fn data(&self) -> &T::DeviceData {
+        &self.data
+    }
+
+    fn as_raw(&self) -> *mut bindings::fwctl_device {
+        self.dev.get()
+    }
+
+    /// # Safety
+    ///
+    /// `ptr` must point to a valid `fwctl_device` embedded in a `Device<T>`.
+    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_device) -> &'a Self {
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the parent device.
+    ///
+    /// The parent is guaranteed to be bound while any fwctl callback is
+    /// running (ensured by the `registration_lock` read lock on the ioctl
+    /// path and by `Devres` on the teardown path).
+    pub fn parent(&self) -> &device::Device<device::Bound> {
+        // SAFETY: fwctl_device always has a valid parent.
+        let parent_dev = unsafe { (*self.as_raw()).dev.parent };
+        let dev: &device::Device = unsafe { device::Device::from_raw(parent_dev) };
+        // SAFETY: The parent is guaranteed to be bound while fwctl ops are active.
+        unsafe { dev.as_bound() }
+    }
+}
+
+impl<T: Operations> AsRef<device::Device> for Device<T> {
+    fn as_ref(&self) -> &device::Device {
+        // SAFETY: self.as_raw() is a valid fwctl_device.
+        let dev = unsafe { core::ptr::addr_of_mut!((*self.as_raw()).dev) };
+        // SAFETY: dev points to a valid struct device.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+// SAFETY: `fwctl_get` increments the refcount of a valid fwctl_device.
+// `fwctl_put` decrements it and frees the device when it reaches zero.
+unsafe impl<T: Operations> AlwaysRefCounted for Device<T> {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::fwctl_get(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::fwctl_put(obj.cast().as_ptr()) };
+    }
+}
+
+/// A registered fwctl device.
+///
+/// Must live inside a [`Devres`] to guarantee that [`fwctl_unregister`] runs
+/// before the parent driver unbinds. `Devres` prevents the `Registration`
+/// from being moved to a context that could outlive the parent device.
+///
+/// On drop the device is unregistered (all user contexts are closed and
+/// `ops` is set to `NULL`) and the [`ARef`] is released.
+///
+/// [`fwctl_unregister`]: srctree/drivers/fwctl/main.c
+pub struct Registration<T: Operations> {
+    dev: ARef<Device<T>>,
+}
+
+impl<T: Operations> Registration<T> {
+    /// Register a previously allocated fwctl device.
+    pub fn new<'a>(
+        parent: &'a device::Device<device::Bound>,
+        dev: &'a Device<T>,
+    ) -> impl PinInit<Devres<Self>, Error> + 'a {
+        pin_init::pin_init_scope(move || {
+            // SAFETY: `dev` is a valid fwctl_device backed by an ARef.
+            let ret = unsafe { bindings::fwctl_register(dev.as_raw()) };
+            if ret != 0 {
+                return Err(Error::from_errno(ret));
+            }
+
+            Ok(Devres::new(parent, Self { dev: dev.into() }))
+        })
+    }
+}
+
+impl<T: Operations> Drop for Registration<T> {
+    fn drop(&mut self) {
+        // SAFETY: `Registration` lives inside a `Devres`, which guarantees
+        // that drop runs while the parent device is still bound.
+        unsafe { bindings::fwctl_unregister(self.dev.as_raw()) };
+        // ARef<Device<T>> is dropped after this, calling fwctl_put.
+    }
+}
+
+// SAFETY: `Registration` can be sent between threads; the underlying
+// fwctl_device uses internal locking.
+unsafe impl<T: Operations> Send for Registration<T> {}
+
+// SAFETY: `Registration` provides no mutable access; the underlying
+// fwctl_device is protected by internal locking.
+unsafe impl<T: Operations> Sync for Registration<T> {}
+
+/// Internal per-FD user context wrapping `struct fwctl_uctx` and `T`.
+///
+/// Not exposed to drivers — they work with `&T` / `Pin<&mut T>` directly.
+#[repr(C)]
+#[pin_data]
+struct UserCtx<T: Operations> {
+    #[pin]
+    fwctl_uctx: Opaque<bindings::fwctl_uctx>,
+    #[pin]
+    uctx: T,
+}
+
+impl<T: Operations> UserCtx<T> {
+    /// # Safety
+    ///
+    /// `ptr` must point to a `fwctl_uctx` embedded in a live `UserCtx<T>`.
+    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_uctx) -> &'a Self {
+        unsafe { &*container_of!(Opaque::cast_from(ptr), Self, fwctl_uctx) }
+    }
+
+    /// # Safety
+    ///
+    /// `ptr` must point to a `fwctl_uctx` embedded in a live `UserCtx<T>`.
+    /// The caller must ensure exclusive access to the `UserCtx<T>`.
+    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::fwctl_uctx) -> &'a mut Self {
+        unsafe { &mut *container_of!(Opaque::cast_from(ptr), Self, fwctl_uctx).cast_mut() }
+    }
+
+    /// Returns a reference to the fwctl [`Device`] that owns this context.
+    fn device(&self) -> &Device<T> {
+        // SAFETY: fwctl_uctx.fwctl is set by the subsystem and always valid.
+        let raw_fwctl = unsafe { (*self.fwctl_uctx.get()).fwctl };
+        // SAFETY: The fwctl_device is embedded in a Device<T>.
+        unsafe { Device::from_raw(raw_fwctl) }
+    }
+}
+
+/// Static vtable mapping Rust trait methods to C callbacks.
+pub struct VTable<T: Operations>(PhantomData<T>);
+
+impl<T: Operations> VTable<T> {
+    /// The fwctl operations vtable for this driver type.
+    pub const VTABLE: bindings::fwctl_ops = bindings::fwctl_ops {
+        device_type: T::DEVICE_TYPE as u32,
+        uctx_size: core::mem::size_of::<UserCtx<T>>(),
+        open_uctx: Some(Self::open_uctx_callback),
+        close_uctx: Some(Self::close_uctx_callback),
+        info: Some(Self::info_callback),
+        fw_rpc: Some(Self::fw_rpc_callback),
+    };
+
+    /// # Safety
+    ///
+    /// `uctx` must be a valid `fwctl_uctx` embedded in a `UserCtx<T>` with
+    /// sufficient allocated space for the uctx field.
+    unsafe extern "C" fn open_uctx_callback(uctx: *mut bindings::fwctl_uctx) -> ffi::c_int {
+        // SAFETY: `fwctl_uctx.fwctl` is set by the subsystem before calling open.
+        let raw_fwctl = unsafe { (*uctx).fwctl };
+        // SAFETY: `raw_fwctl` points to a valid fwctl_device embedded in a Device<T>.
+        let device = unsafe { Device::<T>::from_raw(raw_fwctl) };
+
+        let initializer = match T::open(device) {
+            Ok(init) => init,
+            Err(e) => return e.to_errno(),
+        };
+
+        let uctx_offset = core::mem::offset_of!(UserCtx<T>, uctx);
+        // SAFETY: The C side allocated space for the entire UserCtx<T>.
+        let uctx_ptr: *mut T = unsafe { uctx.cast::<u8>().add(uctx_offset).cast() };
+
+        // SAFETY: uctx_ptr points to uninitialised, properly aligned memory.
+        match unsafe { initializer.__pinned_init(uctx_ptr.cast()) } {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// # Safety
+    ///
+    /// `uctx` must point to a fully initialised `UserCtx<T>`.
+    unsafe extern "C" fn close_uctx_callback(uctx: *mut bindings::fwctl_uctx) {
+        // SAFETY: `fwctl_uctx.fwctl` is set by the subsystem and always valid.
+        let device = unsafe { Device::<T>::from_raw((*uctx).fwctl) };
+
+        // SAFETY: uctx is a valid pointer promised by C side.
+        let ctx = unsafe { UserCtx::<T>::from_raw_mut(uctx) };
+
+        {
+            // SAFETY: driver uctx is pinned in place by the C allocation.
+            let pinned = unsafe { Pin::new_unchecked(&mut ctx.uctx) };
+            T::close(pinned, device);
+        }
+
+        // SAFETY: After close returns, no further callbacks will access UserCtx.
+        // Drop T before the C side kfree's the allocation.
+        unsafe { core::ptr::drop_in_place(&mut ctx.uctx) };
+    }
+
+    /// # Safety
+    ///
+    /// `uctx` must point to a fully initialised `UserCtx<T>`.
+    /// `length` must be a valid pointer.
+    unsafe extern "C" fn info_callback(
+        uctx: *mut bindings::fwctl_uctx,
+        length: *mut usize,
+    ) -> *mut ffi::c_void {
+        // SAFETY: uctx is a valid pointer promised by C side.
+        let ctx = unsafe { UserCtx::<T>::from_raw(uctx) };
+        let device = ctx.device();
+
+        match T::info(&ctx.uctx, device) {
+            Ok(kvec) if kvec.is_empty() => {
+                // SAFETY: `length` is a valid out-parameter.
+                unsafe { *length = 0 };
+                // Return NULL for empty data; kfree(NULL) is safe.
+                core::ptr::null_mut()
+            }
+            Ok(kvec) => {
+                let (ptr, len, _cap) = kvec.into_raw_parts();
+                // SAFETY: `length` is a valid out-parameter.
+                unsafe { *length = len };
+                ptr.cast::<ffi::c_void>()
+            }
+            Err(e) => Error::to_ptr(e),
+        }
+    }
+
+    /// # Safety
+    ///
+    /// `uctx` must point to a fully initialised `UserCtx<T>`.
+    /// `rpc_in` must be valid for `in_len` bytes. `out_len` must be valid.
+    unsafe extern "C" fn fw_rpc_callback(
+        uctx: *mut bindings::fwctl_uctx,
+        scope: u32,
+        rpc_in: *mut ffi::c_void,
+        in_len: usize,
+        out_len: *mut usize,
+    ) -> *mut ffi::c_void {
+        let scope = match RpcScope::try_from(scope) {
+            Ok(s) => s,
+            Err(e) => return Error::to_ptr(e),
+        };
+
+        // SAFETY: `uctx` is fully initialised; shared access is sufficient.
+        let ctx = unsafe { UserCtx::<T>::from_raw(uctx) };
+        let device = ctx.device();
+
+        // SAFETY: `rpc_in` / `in_len` are guaranteed valid by the fwctl subsystem.
+        let rpc_in_slice: &mut [u8] =
+            unsafe { slice::from_raw_parts_mut(rpc_in.cast::<u8>(), in_len) };
+
+        match T::fw_rpc(&ctx.uctx, device, scope, rpc_in_slice) {
+            Ok(FwRpcResponse::InPlace(len)) => {
+                // SAFETY: `out_len` is valid.
+                unsafe { *out_len = len };
+                rpc_in
+            }
+            Ok(FwRpcResponse::NewBuffer(kvec)) => {
+                let (ptr, len, _cap) = kvec.into_raw_parts();
+                // SAFETY: `out_len` is valid.
+                unsafe { *out_len = len };
+                ptr.cast::<ffi::c_void>()
+            }
+            Err(e) => Error::to_ptr(e),
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3da92f18f4ee..d658720276f2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -97,6 +97,8 @@
 pub mod firmware;
 pub mod fmt;
 pub mod fs;
+#[cfg(CONFIG_RUST_FWCTL_ABSTRACTIONS)]
+pub mod fwctl;
 #[cfg(CONFIG_I2C = "y")]
 pub mod i2c;
 pub mod id_pool;
-- 
2.43.0

