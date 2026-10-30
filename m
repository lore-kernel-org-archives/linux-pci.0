Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380572;
	b=oNCS3NtGvNVMfP802i7r2GwmKJyzkc/3dN1PpjedIe305vNx4QEqtPVoQRCX6Q9xpZAh
	 uG7yEROlfIo5/3zOM10rYEji/xVt9KoPXVir7Qu+SdmegwclcNbwfhLLBzVTek3aGz8hy
	 le3Rh2kxLf1nav/TsKyljhZJChvmQW26Jp3C0oUKoK+wJYKEln79nOz+aecp+dK0x4MSa
	 azP+pHHvLTqzHhyrAfmYL5cPRTnr2zEwIoxV9NsoEsbdpi5uX7NbAZWOxu2hl1AS4bhUY
	 FQU+MXCl+T2zTLvhQtN0IxI7s3l/1JXlJaa9qqTEZyMp07odGbc8n90+bw6SPyPJuLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380572;
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
	bh=mcavXeRY2nYmH0aV3h96V7DkS4htvp2TKPnO95ELWLs=;
	b=o82OEiu5fp2G+tiZpM/yhas6vsFrstr/44nm4K9dnkiqghD5kMKcxkmWwMJSwB/q6qJ9
	 /B6yA1RNNJLN30wDVnPdgwluZFBpqqVc7Y+r6JwbGnoyyB3Ve8yiFaHMBNWj2DW4UBBlj
	 gCm5rSHN3v2RtsE64KXqJP3L9sSaqS4bnnkQifAekyuwn5X9nt3Su+97SQfpRieXfUEA/
	 gD+2v0sf9m+FKEr5mbwxXT/kzMdPwXRMnaBu4HrT/Pvo504xBnl6xcXEgzorQ2cCeXlVh
	 X6FnDFALwQQK6JBZKRBvVL13UrUEo586SsFyosnhzyo7Eq93Z9CRQVbiKX7E2Fjkfyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fagJ05Mw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.34
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC73606A321;
	Fri, 30 Oct 2026 17:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC73606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fagJ05Mw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT1lUmDiln5ywFKK1PQGqFYWQzwFJDD6Z+2ixwaus4p594jLJF77Ni9T5/jF+q/8XalM3i32Tx96iJoXuAniJ5ms3wH6m2rS2iBZIgFdDC4h8BNHbdSAtnNzcaCrDQhSQCS7sahjRiZ2ZsQSA4XIflFh7Ku1gfQxGpB1Fo/Zob9FL2hHcqrovw0TWvjKaiQiHGkctVS9N76bnVkZa6KMHl1P1HzB1UvgIkm6Rek6HN/OtjOaEizn8M2hu+N0/UYt0zk52KF1h8jnJz1aooX1FrSSM3vD7PrqVXjhJs7/y/+qcZaCn1ANiK0nsYLhcv4AmOzEfjmGAevOXwiwaZsjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcavXeRY2nYmH0aV3h96V7DkS4htvp2TKPnO95ELWLs=;
 b=B+1+CeV45lI2nOdwzBtU376mo5NNJ8yVrRHgaS0H14v0bQRA3GmAj51KJloGLVryr0NFD7tZOXCSFkqIHkImBDFlWPEGjy34h7GEHLwMEgqxiiAe6J06BtkTQTRgzEmp9FeNqZA2UzT3UFb9Vp1MdIPPKxvfwEZXveONSGeJyeUvWlLc8eRZHRqjrjmIyzUanl1/liY1lhm2mUzRybiiqibdDbkUjMxhlgsD59gKyBQWwoVDXZ+AI9aNy3DJSVrWUuhDoOw7KCPnDMxoB/0MAik4P5yUQaUSY+GE8vxOVcYv/Dn7VCwIBX7QeqJm0TCiADfYvhidWIroCx+dfoi0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcavXeRY2nYmH0aV3h96V7DkS4htvp2TKPnO95ELWLs=;
 b=fagJ05MwLE98BAoPlDIUQiTker2RTfKM9r/pdnWmm2mrXIRzV+LvcQLpdfYMsey73TWzSLGTLKtHjErVi1q9yUQ/oALoEVJApZ4Op6u6otkstH9rDbCadkGjkiRdjEE6xnMmATwyzQoWF9wpGHvVcrA8mCQ2GvAhtlJuql16nQTwCWKFkd4xm9jTblbMguyB8VTiFYMS7x9cC1dpYqw7L8jg2xwqMwo9XufMVJnZNPTiW/Vsrp4QgGt/C9IqdgkofjKSpfYnLiC9r+GgCjT7FBsQTNQiWy4on6VZ+ojlRDA1bt/9kSB782H7Hw1Kg8+30X25YdGDA5KbNfNJha9wvg==
Received: from DS1PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:23e::17)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:13:20 +0000
Received: from DS2PEPF00006E20.namprd05.prod.outlook.com
 (2603:10b6:8:23e:cafe::46) by DS1PR06CA0016.outlook.office365.com
 (2603:10b6:8:23e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Fri,
 30 Oct 2026 17:13:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00006E20.mail.protection.outlook.com (10.167.23.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:13:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:12:58 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:12:55 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
	<apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v5 3/9] rust: pci: add is_virtfn(), to check for VFs
Date: Fri, 30 Oct 2026 10:12:21 -0700
Message-ID: <20261030171230.196717-4-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261030171230.196717-1-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E20:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbb2006-bc95-401b-16a0-08df36a91910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	PUUwpMqmZQbPdedI9oVd8ERRFlKOUmde3pEy0FqqKaHYo2m0zKdGrM1mrq0/FHtXL20d0vwK1qZNGOvbiFSooq0jzuNjSTFEvmkiaF7Ivr42qv8nOedPv9pl20/HEnojgAIOoFfLOiAz9SaCU6EzFH+G2w8TMBN/+l5QhlSR2oGgoqLa6KoU+osvMKu+maZb5AMW9v/bahWoZA6wcYWPwNgEcW3VlhAnCvR81JU6s/CqYXG81MzfnCHjh1tlf8P+sytLmMskLkkY1AuaV1B37XNi5tTAPoGadb5DRv89mL+Qvb6Q8YPmWrSUdl5rrcYRWpKMg+vIpO/2KWom8BSxSt4J0ZKzOihc1PgJVhyVcqq8yFjbknZlc7+jAQm1B3uWWTb0cozkq1w4reFSEDk+RaVlu9U6cI2Wjsk+3Bpj4VmRteAn8Hb0A/n3LesvBt/SL6JFYuNIZPFHevtEU2fHiFo+lh6cYP8P8YVEqB1eReGPf+k+1pZhdBoUux8itB4o1ELrGB+I6k9Xnd7v7MjcCNGZNvhF6eSZcrN9arlNTyfAF0OD/H5wlSqT3tggTx+ojzU5V2Il8RKaoe5KVjrUaFqaKmPEmTb+VhpeKldC67YhmAK/ZctrSTmqG4s4ZayMmH6LRPbrg1Xuw420wtv50pp6Umy5U6ylMvzy3mV71QZNvsS6hKibQpWfiMbrA1o/+4nr+OWSrRlKc5qFbkMCiQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VZ81P/8wVXBtBy2piF7kQT9GC5bCnaguV7FC3Ql02rp58gnjVjs6ojWm6Hi+hpLLEEl08uRctIcA4T6ilndXHNTDB1f/4cpO+s1IQ1dFPI3KsTmuHocDG0LZbLY9ukSMD1MRxZ6j9YXWSPWzYLUhX8LQZqN8XYs3cWi5SdReBghn/KfA/jK/PTkoEareWgNY1Fr8CaW1ie+zdzrdjCwO7A0Ky06z6wnHORpLN/yQbtvPVdYjnsOlZG/2CnJn/1ZmgfG1mqp+M2QheLX0PCt1PTd0CaJGXz+cHyuFwo3glBm84O1kROmTrukhjFCsIrKcfp/m6+kNNUgPNX/wnU0acUypwUBmFw/8kAfY7wyf7gx/SYuwhBUxsWTW2xA+wEQPBKE/nX65ZOmGyXGhL0FTW7QHDlFPUaDLmwH8CgRi7s6G8RLgQqTf7YNF8KbnDrDB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:13:20.6769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbb2006-bc95-401b-16a0-08df36a91910
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E20.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733

From: John Hubbard <jhubbard@nvidia.com>

Add a method to check if a PCI device is a Virtual Function (VF) created
through Single Root I/O Virtualization (SR-IOV).

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c60edd01b70..9e1d02588af 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -363,6 +363,13 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
 }
 
 impl Device {
+    /// Returns `true` if this device is a Virtual Function (VF).
+    #[inline]
+    pub fn is_virtfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_virtfn() != 0 }
+    }
+
     /// Returns the PCI vendor ID as [`Vendor`].
     ///
     /// # Examples
-- 
2.43.7

