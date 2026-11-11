Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436493;
	b=duoq/vxxe4/5KZUcHGJUAPUnEOdrgwvisPvuOg1gMV0TcoxST0D2DEow5WhrhsoFAjl0
	 k/NHvrxqzLBWp3JYx02NCvfhd5lgyOhpD7ds20Q8pwgS4uoY2r9hJe9n1UtUBCEw+MkmW
	 q3jCovXIvdW8PrBHW/QALGHf2hd+e9r6d/lBQ7fTI1kMW8E+jfGD6Hg9qCLGYYiQOwmFs
	 fd2U0FpWjVk2xOk1ZwOsLgqW6q9FN1sUd6LiBRb3r/nXn4EqPMNDNkuQizPqa9MZEvRxU
	 0YVZX4d/I4K08Ia9Za8JNEZgiS3MJLzT8ttXO85A5UUCiW0oXkmsufbKRHpjx1PP+VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436493;
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
	bh=EVagLGKYjFtvyS0CQLxOCemdLUSoCDasy9UUynu205A=;
	b=Zd5m0yv631yKHQQnXaq3sVawLw0b74CrlN1OMwhu5tpN4sTMT3QRy9GI1dv9ngIhktm3
	 p7+Szg2DAkZjMnFpQGyJ7h17vks9bVuGDDsSEUBveGFxZHqvkwJ1Qn1nqMVgmajd4NQsm
	 e8r+lWOke3sffWcls5VjoSOyPyVqrRIAbjZbkO1j8YyY/9FwBud+wBmzhyssyUfUGDqcW
	 VlDQmPvFYvXqS14mlyWQEBmRMsrJ+jgp5waF170A4tD8SYXSnJkNC4485qCVwpbdDEsa3
	 OtInECjh4ur+d3v/wehIOtsF/k8U1idJY0gw49ukbYfSWvZ0UkqY2g344GuO9ijuPiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MNpfhzYO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.1
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3560A5BC2;
	Wed, 11 Nov 2026 22:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA3560A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MNpfhzYO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTbiYCJI5BECHfAPsOkbqwVhitvN/mAJ5ykn0yr6CqihSVB6kBfhX4siIg/BCgOR1NH9B0xBYlgB5bvjO+CSomyjUEOu9hLr/JFeIDxI5sB4fnM++VXBfTM8AP6L0v7BW6dR7+4ZbdCPbYLR7IK1hpjHwIce0FYeGCtipxv0o6kUs/TRVfvFAEjC8P0uzQ4Haj1/Cn6yaRjIF4PG4gq8L/A0+WuoOv+/EhdjtFgncfa84XWEl3rpdCkulZKld6QuQVvQuWsgBCxpMDvRsGoe3sxRk/f0q9tlR7ZQmTLgU7UpN5XVHvSg9HGMIIygj/BzgVr6QxneO699+bgeQ0NVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVagLGKYjFtvyS0CQLxOCemdLUSoCDasy9UUynu205A=;
 b=xRC2lZPcghkFr7YevJiU00xpAlqxK1UN0L7lFiM7BxivjSGdluD3NHMFgit85pUZu6i7HbkX44ZyAIlJ1WZHAA1eHwnYg4cInGvUmFhis+K5GpL6qR7Xr2y2uP4JGmoff1ZhmG3daF3AI4M5TOwQwnU9Bbaj+J6P/mVNuDnBd+1R0nyH//Xx2TMzRbv8kslMjEThSuEtGDFgWDGm06uTopeVeOycOAsvJWOVce4TQNj6KxGzZASd0iC3vb2+cCUKadSApWFTx4fIawawCFGaQ+ruCfrKdTmdlfmEgnBcKqVJwIfiBOufjZA2NFhkIeYFsEG/HJ4FS6HgomtPX4GXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVagLGKYjFtvyS0CQLxOCemdLUSoCDasy9UUynu205A=;
 b=MNpfhzYOT2ObKGOIT12CjdxXuXCnI/D/T1iY5CkNW/BTAG+UjhrAu3B1O8hHKYUvh2WooyGuKNXUUQge3PnJHn1hmS1jGlsnh53EuBlLs2UOUE7swF8054m8bFi9q9wKC0mIdn96pgN56m3+4/1HWwsmOT1fZPPcF0IJ0xxUBORsAUk9E1gB3O67lJlz3tV9LeI4QtiUWaQi0wg89QFUsWlpYe4dBYyghWodn6Z7HfwbcKzJKgmMOkJfs7SXOM2NyOHP5t2pvWOamOrgMoOPe2m+jtEVdxLcZJFP2ImEjMim08EM/ghkRRpi4PjnPuqXtjtZzemjreVUmBJbvvHTPA==
Received: from BN9PR03CA0443.namprd03.prod.outlook.com (2603:10b6:408:113::28)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:34:38 +0000
Received: from BN7PEPF0000009D.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::4b) by BN9PR03CA0443.outlook.office365.com
 (2603:10b6:408:113::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 22:34:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF0000009D.mail.protection.outlook.com (10.167.248.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:22 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:34:19 -0800
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
Subject: [PATCH v6 09/11] rust: pci: add SriovEnable::enable_all(), to enable all requested VFs
Date: Wed, 11 Nov 2026 14:33:34 -0800
Message-ID: <20261111223337.508989-10-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009D:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: d9976adf-b07b-426b-ce0a-08df4043f873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|11063799006|10067099003|56012099006|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261102123227099003|261028144727099003|261022113327099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ndWdGAXoAdQ8a1BBEGeQCAYFFTsnSizDknH7/nPwaspT7GG4tY2JTP+yC4YyhbQ2Bqcm3XEJWVlz76eYXhb5/7sfX7adhkJqN9z/pWYQkr0TR81/9ufEPXSmbqU50o+zn6wccObU1ZN9PRXcY14lzOjm0ovAQ3sZKrOt4F0kvcqznSGnW5M5waJk714hscV6RyKasO3RfDVtEQJ+qTcPinJMHtGpv7Dp/o5hipLvDnQInpR7ErN7s/Bkcom7CLwUlO2JgxOPR0FBfgHgywHZKOxeTqIXTHu/lreGEF62IQfAN1u7bJ9TkWA2DFuq6DwUz91qx3xTePEIpy7ds66taq1QowrRFB07LspIazU7WmeUC8/CsSUX1eGsNu7La8/niHlKC3Y8z0k/fYnql9M2/BOOBk96ZBx+2RqJCZBFjuHZbdHQPUedxlKD96WENcmHAo16E4fmjlbnSm6udgJKtMFP+Oaokr9MaOWu61Bw1lchRFujcP6S2mIl319lkXHI2CUMVS0HRm5d0jfVNNs3AeZp4HJdI0+HDd8j2dh09LCQVx/dvLziohsylMH5iwPbDoUVvuSMQkwg663guc0UFL+Z4AdPC1xejxPmGZEZGYNwcwbJsYacjqqiXGi8BsUu4HmCAN6xSlovp8ozyV/Fh8IoU4OqkU8JQgOhTM58Tk0nglw2RW2vh8GlkELhtocH9F9iQBPcKPoXP2D0JDY/AQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(10067099003)(56012099006)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022113327099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EKLVFTRXtyQU52I2JCDyDRfvW1K6mTLpn1a8BcTYRmub0QmEefGuqdZcqib3q1DG1ucQ+vxujnRngT0hDzPxvDFXDmuIgG0UScypHBPcAlHF5aK93PrhRqUTCBzA9zxzCjqh08goQXto97X+NXBVzNamujqM47wAd1EFIJGFtQECcN+Ij3bu4hISKoslMQghikR1MD6U8zSFdBfV90CMLK0NFyaVCkjr37pE6+dr9zAavLjbz8plc8NvF2DUsvyo4VjqLSy5c0cTTTfy6cFjYR7TmCumyda4w2OPO4hcnj2hfm5sdT05b9mkremNyGKoFruRBPhcEQA4SiNnvE9GvRH/0T2GWBBhVuRtzt2Feo1yOssDAEL86UjOv9+YEKEM6RxNjW6phFuV6wk9e5lAQhQD4UeBSZEUobfl3+YAkIDEL8omXWIJ690kP0cPxPvV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:38.3853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9976adf-b07b-426b-ce0a-08df4043f873
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

PF drivers typically enable all VFs that userspace requests through
sriov_numvfs. With the SriovEnable token this takes two steps:
enable() consumes the token, so the requested count has to be read
from it first:

	let num_vfs = token.num_vfs();
	token.enable(num_vfs)

Add enable_all() for this common case. It passes the requested number
of VFs to enable(), so callers do not need to handle the count.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci/iov.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index bda2bffffcda..a3d1c4c567f7 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -158,6 +158,20 @@ pub fn enable(self, num_vfs: NonZero<u16>) -> Result<SriovEnabled<'a>> {
             num_vfs,
         })
     }
+
+    /// Enables all VFs requested for this callback.
+    ///
+    /// This is equivalent to calling [`Self::enable()`] with [`Self::num_vfs()`].
+    ///
+    /// # Errors
+    ///
+    /// - [`ENODEV`]: the PF driver has not registered a [`VfRegistration`].
+    /// - Any error returned by `pci_enable_sriov()`.
+    #[inline]
+    pub fn enable_all(self) -> Result<SriovEnabled<'a>> {
+        let num_vfs = self.num_vfs;
+        self.enable(num_vfs)
+    }
 }
 
 /// Enabled VFs awaiting successful completion of `sriov_enable()`.
-- 
2.43.7

