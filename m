Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794281858;
	b=LjqJdV8n4GRnCdk9L9On2Sj1fuBicTXt60CfQYalKbAGerVaQ8khtdfO4lGl50IuTS7n
	 INQF0OitCNqCsPmNJmfFldIPD2mhwN0zbMIfy2GikbmwbqXP8yPz7mg+r1Hw2lDsTfIzM
	 v07QEtYOqhM+9U9pL5JroQhAtQ/E3eS3oQPVG5nhN82FJoLILu9YrSS2aYhdkeN2Pauwr
	 9wnm3gdiWo1Q+sT/rIf2ZhX6j8++2dOKGJ9t9zlrRSWEUlUvZnFn9TNezwoEzz+YaB75E
	 rPlq5h6Ep6sFLeNxjHdO1RzrzyhGyVCp0QzDZJUjO6mHl8QGu+QYlltALLyMFy0fH4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281858;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VzU8CKpy2LzmClmN9l1jBEM9IOSWtQfaoYcXhqm56VQ=;
	b=rA27zWQl6izU1JAd5gRv1YDe7J26vUiThkt3HSS8tLbiSwVY5se9mxKkYwqgxsNFRjEL
	 jacC8dpz+JrXCDehS5FhFCnryT1BhTsmqH0PFcM5fZGgMB+3k87BfsyclBto7v7cfSJUG
	 tFzW0xMk2XslRJLOid7wwZJZXJ0fg3V8meWJ1M1exmHq4gVnwDdX1IwrMIV2aZOoqZBvn
	 0sTIxH2+KslQvqoojJrZ70NWVxyRnGvVmzYVwPldW/kS9pHDbFjQgj6cgqXpBhs+/1iMf
	 my3amC8p/uGraTLLClOCfWXlZ/mX6zPGueDrWbW8CzN7GO1seDtZHf/bLlQM25qW9Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VmxTcW2b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5160A2626;
	Tue, 10 Nov 2026 03:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21B5160A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VmxTcW2b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlcEHzSsaPunrRMIeDOErIBu6diJbTtKFDF8jVRyEufycrzq9xiyIXprYBrQRwUi2dq0z/F/0fe9xuRI1sof5vEMihpcTj+kizQQHgjO5m4hwDYDivhBCH8x7oqkBuf97VunDVMLUwsDw316q+kVSb0ZhtnfEyNY2tYe0iCihkWiRhGzd6szTTNp/BBDjfaPn5kuomgoA2zBWSieyNbPyPoA/xY0S8aTCeYkAANJ6mSTk+H4jFDXboAAEdsfB59ACWJK9r7hV4wIc6IjH/axJBleITJjWurmFGpYmyawZLGM51aA5VWrki2uKyaLLB/GKYlHz1OO+skWqKHb4/BcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzU8CKpy2LzmClmN9l1jBEM9IOSWtQfaoYcXhqm56VQ=;
 b=B7O7IXlQFHlxt2weR8jiGZ2aE9tjJ7zk45lm0PeoB6TGobtFZNtcgeDcbmhQGEwt64Ag5IM1zF2C+tQfI3iddhhJF1y3COAwLpLSmxwLt1XWitZDLm7XVWoFuJR8T/UsR4igt8WnCp7mWk1u5rmcVy8UtmKMrMCrDVc7GG5Ii4ZfzFkCOVQZ/QXCJe+TfQ+1FehZjsobLzHDJ5ert1H86bXbLnxpfTLVKmwJPnUDOUOoFhRTVT/Q0tqgqgR5pgW48RzG/oJBW9S2eo68UDn9UpnaK5OnXScIOuEDVchOE+U77nDWGQ5s674WkgafJWLPxtBNSzLKOtQDvHVNi2u7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzU8CKpy2LzmClmN9l1jBEM9IOSWtQfaoYcXhqm56VQ=;
 b=VmxTcW2bXmERIsXubl10vt6R/T9WHhqi1X/7r7Z8n0fEwVnmK4YyvxQdN95wgZgOt8SnM6lhuCZTTn7Ana1FHcqTqxtVj+F/imekWiH3HSdaYQ4iZ4Fgfih42G484grxNAlRf8zhaCouBQsnfn9EdGlZs0WuNHQZgIYEptMvKcJaADAWzc5Zut04u/dRLPKCuV44WsTdcylvbh31LPny2Wqibf9D+2S+EGVWcPsef2mFs6KRGfKDwC8j2ikkufGdXirzkacadkgO7WgQH05YXDdCO6awtk6+SHBk7YX6Xtmq1b3QFUlQvYN5n75GIROwhbJsUPqd1yHx9owhPRM4yg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 03:37:00 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 03:37:00 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
Cc: Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] rust: pci: add domain_nr() accessor
Date: Mon,  9 Nov 2026 19:36:53 -0800
Message-ID: <20261110033655.148487-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110033655.148487-1-jhubbard@nvidia.com>
References: <20261110033655.148487-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: e3975605-a176-449e-43ef-08df3edbe0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|6133799003|10067099003|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261009223027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	JMIPdoSpEDttqKIP+PcWmo4OmKqoo3CULgdHSt+YLCX/5Zg6tID0RJM/qYRA8ulLAn8EJP3zEqF6CjO3Dj5F+LK3UOPNTQsqgYNw2vvERsEg+YnOQJnxIBxZu0Xi/+sRGNnehEsvG9bRbRE9ctH4L1lVELTgvxe/0ZwndVkk+eYtzXn4UxsAmGy5T0BToEsNlBt5SivV8a8aZZqwC0RtzMTv6Oj6CqORlsim0DarYeph1vFqyptkv9MWV0xZgAMTBuoIQYjGCrxBYerRLTCs6PqGluGEZtjNUQ2SdtOMlnxytpggvSSpQqMMyLZg/MW2kdnNMPoiFdHtyP1b8oaYDGpFIDjLQlS4ewXzSdgKGuTyX6qdmX9oMna1h17gsljcykd+VjhE3rBsozwjmtIYRPSiVk+LCFN8TO2Zo1PJ5VAEDN7gx5EEj1edBstaSjSu1/AlZZdP25v5ZrpACnLzLL0sD50/KK2mfZbt1Nz4nkiwPvem3MoJVUgPrixDwRhncPaWvmHZuay/tHV5nvAXKxZCM1bqtDVLP37HO0Uw8LPRMMU1UYyiV3lr7nrYmwJTjfOmykrZ0IcizDjh+MXT8U7+lmEIzxQx1Hh54ZsDpVWtIVEGwSo8+6RcP3RBM8Cdzp7u4vihgsF7dU26cWnj557QBDX4TNY8pSA8iPUHPAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261009223027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Eo8EHt2qZ97WdmjM+mM3rkx90XNqgljhtK9hUym3AcSaKQ7ZQIwXmUuSzmG?=
 =?us-ascii?Q?nZcCXgIy42Gj7aIKKFE0lCvGOj8WIocqSxr555m1APfXjsk9lsBD6qT2Xwzf?=
 =?us-ascii?Q?RK/UjvJtNa00DlhbI5P/HsKQyyB280FARkFuQFhiM2GX34eLgp/Sg3wGZi4A?=
 =?us-ascii?Q?KD0sqazJ512H6Va4t0G975AS2mjqIWvcqZhByNiq8U+e6C3OO5zzzmvvAWdh?=
 =?us-ascii?Q?P9JGMIF9tM5JSp/tpAJchDe1oNpc0c4zamgz0G8jRX+23H3qvWK1wF5LaIj8?=
 =?us-ascii?Q?JiuCtWGtDf/ib/Hm+xJ6JkXeLDCn1a63sGHUdH7n1D5XEmYKp66XvYoTbIFV?=
 =?us-ascii?Q?4XiffNNkTbVAuy0xjQ0YvYLkVDe8FwchqPRJWmp3U0ZPKA8koYJNVFGKlIgW?=
 =?us-ascii?Q?9Pg4dODYQTRhxb8DtGvWtOPtTOfx7zgcEAleGfwtjHaMRBXG4LqUtZ3owHz8?=
 =?us-ascii?Q?0vMx0l4i/uzR9zcc6BIB/467LGR1YnMT3EV8HAGe8HstAlc5Mo4q9ONux8Em?=
 =?us-ascii?Q?aiadosburcrNNqbI7putow6bLO/WHD7dFzfy60E54+Pbjak3R0BzDduhKQL+?=
 =?us-ascii?Q?9EQn87Oda+MJwJlV92dcmlCrEN0ueI+AQC/1xkYFIT90Ggh/JkFKh15OrUWL?=
 =?us-ascii?Q?1/VJo5Raxs+QtWZP3h5xIYS7mEVGbv2Y22xDOxs07xijk2VAEX14DTooXXxX?=
 =?us-ascii?Q?eartiW2ZOZNx/rilbDhjc+8g367sh+vJ6XsblkcKw5gwUuio3aSRhyXgvpGn?=
 =?us-ascii?Q?Zgc8mAAgG6vdoi5h3eobAA68r7p5JN015Lm21Js73odJFLmWgdYv95W1t7g5?=
 =?us-ascii?Q?h3+b2rijfYMQKqwZK5t6+15f5+qUxAykluqwmWW4s7TIBZ7IAne/PgL+BLai?=
 =?us-ascii?Q?awGJxR8bqrRzawVvd99YpAdfBynQDLmGTOKRDRNjjXFo+KyrrH+Bvvy6ccLZ?=
 =?us-ascii?Q?ij/XTLL/AreEPeIEUWIfKKghjmU2UCcmLhnoRD0fmIwpqBceAom/IschUCK7?=
 =?us-ascii?Q?dpDf80cdNZRPYH4HXUufmgP027Y5VKb1hRLbxws8cjs6+RkMMr373Nr6ybIs?=
 =?us-ascii?Q?TYuJOvwClu+VjPmZTF0aiZUelJhrmHZtI7RlLF1vFjIgGYgpa/ay5adp5Cwx?=
 =?us-ascii?Q?0Qc7Vyp5p+/3hNrWsdqwCkSchN5UhaA4h7GogYuchPNAAHsDI+Zps6PNsDru?=
 =?us-ascii?Q?CTusbFaEnNDVSuAlA24+ygd1BtvOvVifBoRU337qNIGbDUXrfQBbe7wHOqYK?=
 =?us-ascii?Q?Jd22rjhOitDxRxWB5y5j8Hm5PbdXyin2tGi+e+0cSXfcA0cjFCHGmO4IYre5?=
 =?us-ascii?Q?EVnCsFnCCxQznJ63PuDVOhaZLCcyydDBBYgPCq6FRxxKZM9gXZRdrbnF+pHL?=
 =?us-ascii?Q?k7w3vR4d1OoCwX4X8u3zhSXwft42QnSDSirva71GdPCRO4qLoTww4MgRzZq6?=
 =?us-ascii?Q?oBuynnpmBSTGl7R5PBVEdEsAe6fydU/uHWLuRNMCQB0cO6pLohViGmDCE2s2?=
 =?us-ascii?Q?rW7hX27ZNxFBZaa51GYsKicsm3drjlwxFK4RP01IUp6CJAuyTeH5lpurpXSn?=
 =?us-ascii?Q?Vz4VhNbVaETdnEu7tkp9XnjkgBHcNhC5VDzRbRxeESEcSEZEb4w47EGBW0Yj?=
 =?us-ascii?Q?GovvtPAQvXv/gXvyTW8r/YbEI5tdKo9ruRrgesOeV8rD6U3578E6YNG1nxOq?=
 =?us-ascii?Q?PkxMTI/fntgWPvSQ1q09DPQIzC3nX91jJFUPc13PtN6iCmRnpPJ3ApgSecIa?=
 =?us-ascii?Q?BUSBYvbCtQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3975605-a176-449e-43ef-08df3edbe0ff
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 03:37:00.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yp9xiojyAbr0ge3OExAnD+zTtqfa2SoZStV+2gG9ur5AdYVWEDUR9bNV/ltsDuyyNYU56MeWmFB34DWJn0D86A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

The nova-core driver has to send the GPU's PCI location to the GPU's
firmware as one word that holds the domain, the bus and the device
number.

The PCI abstraction has dev_id(), which packs the bus, the device and
the function into one value. It has no accessor that reports the domain.

Add an accessor for the domain number.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/helpers/pci.c |  5 +++++
 rust/kernel/pci.rs | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index a8540f90b13c..49f2c089d236 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -7,6 +7,11 @@ __rust_helper u16 rust_helper_pci_dev_id(struct pci_dev *dev)
 	return PCI_DEVID(dev->bus->number, dev->devfn);
 }
 
+__rust_helper int rust_helper_pci_domain_nr(struct pci_dev *dev)
+{
+	return pci_domain_nr(dev->bus);
+}
+
 __rust_helper resource_size_t
 rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
 {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 769d01d23429..57718e48208d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -408,6 +408,20 @@ pub fn dev_id(&self) -> u16 {
         unsafe { bindings::pci_dev_id(self.as_raw()) }
     }
 
+    /// Returns the PCI domain number of the bus that this device is on.
+    #[inline]
+    pub fn domain_nr(&self) -> u32 {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        let domain_nr = unsafe { bindings::pci_domain_nr(self.as_raw()) };
+
+        // CAST: `pci_domain_nr()` returns an `int`, but a registered bus never has a negative
+        // domain, because `pci_register_host_bridge()` fails when the domain allocation fails.
+        // A negative value here is a kernel bug rather than a condition for a caller to handle.
+        debug_assert!(domain_nr >= 0);
+        domain_nr as u32
+    }
+
     /// Returns the PCI subsystem vendor ID.
     #[inline]
     pub fn subsystem_vendor_id(&self) -> u16 {
-- 
2.56.0

