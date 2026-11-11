Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794427557;
	b=avEYKYHUXTgTgb14v82Q9WFooxmDVXY2wA69RV3RGMa+4hEqa2wrlFj+mfT4zq09wn2h
	 Baph/zwqRm65Mej9/yyHDF+fdhwbdfu+8hQLlY+kUeX4raX9zOZasa2tqRo7l9hjv7vKy
	 ziko0siLFmgdbsqDQzyUNr2boyWYs7/+FbRaHGqgM/TuZUcxylFcnqFk6ghr/QooK1GEU
	 SyQVFh9Y5FSrMqRiC3+YMXOavlkLcxRf6+wdkWFy7AGv0Nd57qZvhCy9IKhUA+/Dmy8cb
	 Z6AnJhBT2jM/tz7fnFYzxLrGcY+SILWSb1vis/HxCkvzU5qvwJRijEil9jowFOa2keQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427557;
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
	bh=5NQnGuncnrD9ys5PP1+m/uYGCaFhFB/RDy4mHGOfoVA=;
	b=sKwyfFrdKe6nSCfutaN4GQV356QTbnAhPS8I2k8vn9hPHHVUqU+F9ryWuD27n0nIiif1
	 OriTlEwQPb1Jb/lvMDghzINtjLwZUXZ1U6/s9y3qRU6bE/yE6FGfPC6CXSIb5GvLDJoY2
	 pBa7ApOQ3HXY/LeBO52nm4qHAv+9dxFQlikpYM5LIMdH16cPEehSTb9XSJomiIv3RI/Sw
	 eiWazIumQabJVdovVueBn8uDjY0XXLXgCige8LjUYB9kpEOSmwZpANsoz+8qFaDr+zdcf
	 LG1QrGIH42r8M+Ra9ZNqJUd1XHDEThFh3IadrrZTCUiYJHm0FXPRixI2aDbRaFuSbGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PWHtxyR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.59
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3A606A321;
	Wed, 11 Nov 2026 20:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BB3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PWHtxyR3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJryyMXJX06w0sa71lM/ISAU55WN11TGTBhgW84pQHN41+5xTZ0cOazZdDjA9LCcP6s7Zwcvwx6M1JfIxzB67S/AMN3pTODkSpr2RvmX5QJvyh5AYMbulVi8nSTRHQC69PRs4LFj/lkrcUFatTuDRMSsjTHR/CqFGXJPm5v9gjnmJl+X96/JrUSQRl1d4aiNPE/nWxQXqlmHZJq5kLA5u6KJzXwI0oCEpprbQ+RwCK4QSFjwg1xzfkqL7zetocdnLSs7ofNHb2RhOcE+UIp7mDdpn/Nw8sva89OsXJz3vDETOhCrYDXNbLux+7VfH/4LfNtxPTu2gXNys12uSWTTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NQnGuncnrD9ys5PP1+m/uYGCaFhFB/RDy4mHGOfoVA=;
 b=ez9YONkHSPg9McojUXt7ZujVgr2uXjh4O+dD7Q7CRV+DO8LMi7iUaXHu3S6YUbiPfA7dNrj2TM1IBO1wv6CtSnjXSMOY0/ipsfBrQc3O13YQmbH0QmhDOzbRy0Xo7k3xYdYOREvlzi6ZM4g2VglVrNaFFIrSBqtYA98I7zJIvV/BYpYOS8r/fVpKTVoJdVFxx40d9jH6pB7G3PcGLt1y3eDnQDmotmZsAdWYgIvpisCFZ27IL6Z+yCnOM1hSThppA23q1EL2siE4e/z4AJM33RvynDGhQrMz9kxaYdQYkSmljtOF1gB4JSWDLbA/FEkUROmlf3KNFBjur5YnQRmFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NQnGuncnrD9ys5PP1+m/uYGCaFhFB/RDy4mHGOfoVA=;
 b=PWHtxyR38gQErv9pxST/8yv8Y2078IgniX41irXlidZC6H0OdlCHCWByuHx4TE/tcPoG/vG+ocA7MqiTLlLyRlsHZJrknOT9AcWc/Wz5stWbx1o1TpTJfSLllzPLg4wkgCDvzhbGoUrvzQCcQExpo6VbC04qCxsAGrBOaUzrHKDUCwoi0qmMVX74pUC6nXvlFcjGKqoibrtXLnpJGlYUxLuAtKLim28TV/bj10IOr8cdkiTJKL91QCCCSFhiDIUqyDiwHrwlO7MFW+EBTXuWBmbeLWYEdVk0vSbjG4qkQgyud6QGgQBMkTz3/O6DJ8NE6TRkVyqas6F4CnfTwveW+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LY0PR12MB427268.namprd12.prod.outlook.com (2603:10b6:408:3b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 20:05:53 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 20:05:53 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/1] rust: pci: add domain_nr() accessor
Date: Wed, 11 Nov 2026 12:05:49 -0800
Message-ID: <20261111200549.160806-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111200549.160806-1-jhubbard@nvidia.com>
References: <20261111200549.160806-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::28) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|LY0PR12MB427268:EE_
X-MS-Office365-Filtering-Correlation-Id: e18a709e-6fba-4f21-98a8-08df402f304f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|10070799003|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	8ElauMrHC9lDueUx7haggnwqONJSN9cwgeu0dCcq6XvdAI+Gi67GaXlW3NLzreFPw49diJ56RVX2Q40PtoESdd81yZsp9fGdEPfqCokCnTzQOh00OdaUpIaoP5GGNqdkSt0Zmi3kEvGvDGEkAj4eWc91eDHoYs6q1QzkN3rMtQ51WJySPntBBvWudmUyFSKwr9fucCrcQBbXxeUA8k1u2sKt0mkxK6VDy1fjKfSbTLq9jNbXnafNCglsAjGj5PLhx+Jt4y5PeNywsYKff4WrsuJ9R3IBTtvyZ6YHghcT90TzCJPKynSLH3HIGGVtsjEU8tBGq+kknADIjH8qgTSchTOLG+XdQ3Q5bl8Q0UjwW/XzPswEHP43ms94GIY3NJt9Ur5TdvottgT1LjoPJV12a+rQmwnWcYRUCyVfDlXMJ4aQrXqhHCXNXRor6GhPA45/bakAb3WXrv5vR1RCTdTwZL8C1A/TvKrZ7pbDqwiFhuEaCscbd2NtQdcqDZ5Trqa+M3zocsi93FDiDwzTSTgN4BQ8YgVNZ/CMhon9jJ93h5+L3Lwb0tJqKc0XrVZA3OvBAcnA4eRw5nsjUxNac3E3aLpnqCdM5IBG3HLXKfgqaVP2YKl/e3iY169r1xXeMbjUorRCvE8qBwKY4oYnICHdOYPcOMV6pkYLFoy12sXIkcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(10070799003)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZXBtRMdSsSL6IE/ghsDYWbqhPWcbd93RmDPKx6y6oJ9gybk1/E06KRxNvp9?=
 =?us-ascii?Q?d4otbfZs7ZalAeDjtLVLix4sjU9I7tlqhv/ko7jGoNC3zLkKN+HA7pLoKZsP?=
 =?us-ascii?Q?utq3aqw9m2evrcxrFr+e1uL+TTLwtboil2Tora7RhBKaOjftByD0nWlJcLBY?=
 =?us-ascii?Q?jPOmi30eicSQOHCKfAJC/eSxV919oUftvA3j9Ve/WuTadvEIsPC2fXoPl3zX?=
 =?us-ascii?Q?2ShjeKoxG8h64BpOYp/YJgaIU4OH5kEBrNcWYylTLHHatgI4RiaKrPjoc1HW?=
 =?us-ascii?Q?GYvnFP+0aOgk1T0EDy8OjPHf8EYjUECtUTn5Dy+RKGtjLfLPidRUeZBzZkM7?=
 =?us-ascii?Q?o/PzqIWWL0aFrXfcUyC1WUGrBOKjxLotEqjzYhdTsC07+BrudHZpnBmfCXfp?=
 =?us-ascii?Q?XO02jn4QZ7yiE8YbAEr9coVXbG5CMHLuFzwkt3mab+AVZbF9m/ohYu7dwNTU?=
 =?us-ascii?Q?yVF1POrn2THqtTqsW4AYFm0s53ry0eHyh1fYKmBfSFuPZ8AuddezRh1i8rdF?=
 =?us-ascii?Q?hW2WPsV31CWJhmkq1XQCGHjM+eQFIVHwRBD/6J9v8VMneuAjOtjbIHqvCQgQ?=
 =?us-ascii?Q?y34uvlkDfc4JmeFKLZN2V8hqIkURA0zef7ZxVJVTQPgIxq2NuL6FKRfycGzd?=
 =?us-ascii?Q?mdazNi12h6br2YS6tToYfqSVIU1YrZ48I4oFSZMrgtaUszSpQMsN+sDD1HLM?=
 =?us-ascii?Q?ly1lDpBvEb0TbopRgQEEv+NT7GpTuldEK98Ic9A1TalXV81CP6DaoVshAxB8?=
 =?us-ascii?Q?ZDteb7p/yZX9uQt939O3fwZxJAwdnUWf68yvaZfhfcUlWUbmrZOAcsfF+7Dx?=
 =?us-ascii?Q?F0flLyHmSSKYKQYNbrfpiNkhHX614oI8d+mErqLV/cI/dJB/HEKYWR5VDDKf?=
 =?us-ascii?Q?bDsgXgG4BcEdZJLD6cS4B1nqOWU2X3/aNMtTNf1uWn23KTbQIOcu9lYUHPKQ?=
 =?us-ascii?Q?OiY42+upO4rbK0WfBJBc89rKTEoAv44mFnQvrjhsUS9Z0VzbwAojJmjUCcuc?=
 =?us-ascii?Q?SSmURaLU01YIxN8o1pAYLG4DIdoPbPD6mI6gn2CZhXbLVjkeuBuZF/slm00W?=
 =?us-ascii?Q?18BYscToCm0QtO36xdj6AVTGtcWuIRQ637/cfdHje5q2Ddneu1Bn+Gwn+pWU?=
 =?us-ascii?Q?NyjguI1HyJQUXAxUDH8r6HR7efLerCKtt7tSx4w7lXujjRAD1MSrpS4LHqAq?=
 =?us-ascii?Q?SLsSF2EhHLSA+8Ycp/qD4AhDdSWzASDvTQaSSA7NAmD0jdGWCrIsaMFu7Wxt?=
 =?us-ascii?Q?/ECt3tfIm7WJggGeessvU7FJOolU014FBsu7MA0cDMlA+P9jGZkMxplloSrW?=
 =?us-ascii?Q?pZBcxNpkt5JV2Icvui2jK9T377E1t/aLgoTMVSblyRfIWF8vDsO50y4RxIOK?=
 =?us-ascii?Q?Nf+eR1xiKFAidqXNUrIYnw0JWvBGXQkcSWCxaJL+FoPzXxyu76k648gRzIcf?=
 =?us-ascii?Q?48XfrwYzzeOOlAB6hcyPfkEKXUSggsXmeWMQSin/gnSm8wXsWze+s1Qboqny?=
 =?us-ascii?Q?2tbgza8som7NltrDtR4gRSHDBCkVrJ/ugEV7BXz/UmEnYxAzKkgZnUAo/Lcn?=
 =?us-ascii?Q?qT3fi6S9MFdGcS3k6fNyfqX+yCTg2mIUC8bWwY3DFyJll5C+haeE87x8AO3y?=
 =?us-ascii?Q?Bs40f7zdiM2T+p0JE+mwtLQWdjW4I/hOtkAcn2u+6Yr8GFlySH7gFjxTjEQk?=
 =?us-ascii?Q?oLz5gEoVqc+p61mu2LFKwHOw+sSd+kLoVnh6CB6utrP9rJnmFPd0wbcRL0Ed?=
 =?us-ascii?Q?mI+M9l3WYDee2k2ALzbIqSKP5/50J0Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18a709e-6fba-4f21-98a8-08df402f304f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 20:05:52.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0Na1KFRtfCZCuOlAQmQMlpaUcqLUOq9JGcGSInABMxWooTpcrXys02zDtFazMekRX9n++GgASH7B6k25v30Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB427268

The nova-core driver has to send the GPU's PCI location to the GPU's
firmware as one word that holds the domain, the bus and the device
number.

The PCI abstraction has dev_id(), which packs the bus, the device and
the function into one value. It has no accessor that reports the domain.

Add an accessor for the domain number.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/helpers/pci.c |  5 +++++
 rust/kernel/pci.rs | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index a8540f90b13c..a1e033531419 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -7,6 +7,11 @@ __rust_helper u16 rust_helper_pci_dev_id(struct pci_dev *dev)
 	return PCI_DEVID(dev->bus->number, dev->devfn);
 }
 
+__rust_helper int rust_helper_pci_domain_nr(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+
 __rust_helper resource_size_t
 rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
 {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 769d01d23429..60e0d8518266 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -408,6 +408,22 @@ pub fn dev_id(&self) -> u16 {
         unsafe { bindings::pci_dev_id(self.as_raw()) }
     }
 
+    /// Returns the PCI domain number of the bus that this device is on.
+    #[inline]
+    pub fn domain_nr(&self) -> u32 {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`, which holds a reference to the `struct pci_bus` that its `bus` field
+        // points to.
+        let domain_nr = unsafe { bindings::pci_domain_nr((*self.as_raw()).bus) };
+
+        debug_assert!(domain_nr >= 0);
+
+        // CAST: `pci_domain_nr()` returns an `int`, but a registered bus never has a negative
+        // domain. A negative value here is a kernel bug rather than a condition for a caller to
+        // handle.
+        domain_nr as u32
+    }
+
     /// Returns the PCI subsystem vendor ID.
     #[inline]
     pub fn subsystem_vendor_id(&self) -> u16 {
-- 
2.56.1

