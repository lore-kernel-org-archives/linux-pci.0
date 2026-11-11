Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436492;
	b=1+JkMOsRDUqXrdLAlWFr8rKLeBFz4OmnkXCs6RbTSOI6geGZUY/oQ3f70l6vO7gH/GGx
	 6hQ4H8j+okHWu3IbIQxOhf/jJTTidngoyy25HVVMqisXzd/o70zGt6nJrdTUz8k+qqc8c
	 r08+kXoATWu2B9cALpimoq68V549rBpwtN9lOX7Byz2r3e48BArYRPGrg7/P+GRZbffPy
	 5ugXCRWaaSyLGG9nx2WhgtzTw9JLYf/Msawo0NK7wQumWAAyuqDL2A9GxrMH6cgacYrVg
	 3rKd6LlGU/Wk2Iz9bP9xP+pVHF3+vgw9BKC+EViKw8+rOac1pAn8tMVB0L3IHOu04Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436492;
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
	bh=lPbhCzTlquTNvA7jn6z4swnRqjpaTL5WmXoNUX/jxWY=;
	b=OaKJYApKQDkdb3ie9exmRUstoyhCMe9oE8BvlIHHDGBakr+8eTfFitkwj+aCDSZ9Cbtg
	 sp3ul3NnNn06FqwVJOr46eq7OSMyrVuhMyPNwLAaYROvlqvcXIBko2Vg4db/adUTuDB2d
	 FwP5riKvw0FO7sVZLfGtAdHjEWD2lRXR7Pyk04Ijtr86xyIG00K0IQBWxzmFZHUxzUJG6
	 RuIWymqHzWmFGH2DfZh0k4m/z3gjbEJaH93Lv+8AuVtt3G85CDDLpHXPpOLgxsuJB68RF
	 1r8VCfO3UjNZGDW71OABYwaaXx4FQ9rTvHUJ0s2kLnTpDuknN6k3RE58KHJJQ6Ko7ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gXZiuz8i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.23
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E104606A89C;
	Wed, 11 Nov 2026 22:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E104606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gXZiuz8i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHnRf3KwWs3SGK+5pRBl7u2+Z/HBR61AdsFNUhsrsOT2aWPWRBHGPweKuVNH/LlEL9hpxbut/SPGTsAwvuaF2Sc3Cyq+5NtyRZQKmpeghZ2br2Y88SlNiJ9um27n3lgcXdg4XsilnOz29eHG282Jg3dDkxzXbFvuJ6SBMqikoncKXYu0vd5X8wRvG3AkLxrT0aukYevvUp0Jbwiq9nKxFdFzw7L6gxLIEKZqycY7zm1Thzh5P9fOpcH7dAZ5ZmbHyNr6pJzt7MDS+6xUQi5F0nq6w7oi8C2D5uk3/KsWmtA5rNEjMqMvwBCZKtuZI4SRwPbaNDNyOkA0KSCTAExnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPbhCzTlquTNvA7jn6z4swnRqjpaTL5WmXoNUX/jxWY=;
 b=iLe6NxZ50ggp91bpsBDAz39otHZLqKA+oRZr+qO0aLGG19zb189Bq8yqzPC6nOKy42TLtyLK414AWIkPSaXOOJoWdFLfGmm9oKq6aqM7nWRUEkU5F146L4/EG6mASg4f35hb+lO3A8BKa9Aq+Lpk69449m/rpLJHnfnN5HEC31/29VYWOYkAglnRf7Y+TIe44P/AL6tzRlxUARqryfpaAh1nJwrkq2znl+YTdjhgqnKFBuWnYNARsgNsM/03G38KPBMDAlL+7p4n2m1m9R8QY9/foAELp6p9vTq0mlU5RAi7XbO1u/EGRaU5xMV4Rb9biTvkaIOlcKtrJc+jwU8Cdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPbhCzTlquTNvA7jn6z4swnRqjpaTL5WmXoNUX/jxWY=;
 b=gXZiuz8iOWthoNiVx9cTDARnRCLXiWULI/ta447JcgYN6yIeGN2VtSz07Cv0QGqu+NezzkdGscA0OPW8ygbfb8zGgRZEShSiTvlNOPdv5AwvSmRfNzoV2O7M/mR46Wn8D84eOullZSQbkjyNWXzt2w7JHIiJoPBQI05uYkVks36sHEFFLSE4MFdfqFfg5PtqmGa/+gybWURdqY9UAPwgSoIFpq8daLuNSwubTYO1eY5Agq1tde056N9J3bN3nGASn/YrPO5H+5bCooX0sNzfr/6tfFyTQaXF8UeB62iHo0+Yhzk4memuRMWfgRtr2U5+PP5GF6VuJgbuLcr+C6ymZg==
Received: from BN9PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:fb::34)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:34:40 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::22) by BN9PR03CA0059.outlook.office365.com
 (2603:10b6:408:fb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 22:34:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:25 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:34:22 -0800
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
Subject: [PATCH v6 10/11] rust: pci: add SR-IOV enable and disable callbacks
Date: Wed, 11 Nov 2026 14:33:35 -0800
Message-ID: <20261111223337.508989-11-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: b6498282-c92a-4b00-56d7-08df4043f934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|18002099003|6133799003|22082099003|13003099007|5023799004|11063799006|10067099003|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261022113327099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	WidWqF8m5ZJwSg07quszhshYT9e5HIXffvz37XS/4DZ+YYxLnFMGUGxdgOVQlHILswrchHin8HPxcLgXItIf4AJZrt1bIZ/pmzplmALHZ4t9w1oE+DN35Afwdj1lNHVQny/1Fp4uXln7iFR5OJUW4f76EoxUsEKE6jsgiT0QJVnjGKN7DnYAGR07YLIvBH8sZjhpQk71eDlF3yU92vCuk0vX4k2Dfd9O4IGUbh+Ezd3hACcCnhWzbCC2TpIWnyVom+7zWbrRgLQcKC/PzJ8Un30Qrn30HcKEApm7Eq1LwPJ2BpLigqcGsJLFBOSRp1TasCVplpH67msqkM5yo7v8gmC3OWV5HD/yQlCMPurzJgvS7IQPGSKdMt+yssSj2KgNzu9lu7OFM7c0rSVkE8qe8zBiZw+PbtesfAQOKN82409waOxSFIqF5pNk5zKIULMFMJnWTu2zCWk7fPIc0nriI6XsaE65x+Zpx1+1VN3v+gFHZ5fOEFNo1HQrXX/zUTzEAPX5+GoljpboMH4cKuJD/QzIcCJPAcE2dob5VqJWhhWunm8WnLTeUem1d2vrY5bnAOzbLkBtWj5WOoVucfkPf0q4TWg8b7tSD9E6ToB2Xc7sjCMeMLoqHtd1krH9zsNoKDcsaqqGtsDzwc9+WDEgTslJ/C8JpvR+gHoJxTl82rjGpJvjWliE0PrBbZvEZaOvPVVY1eRo2yMOLbN41Vk2NA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(18002099003)(6133799003)(22082099003)(13003099007)(5023799004)(11063799006)(10067099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261022113327099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TexvfQDqohYbCj8LNngJKNvE13uguAo8fIGjKYupPzrf3MUGZhDaGAFeQ4WnL7/bp9634ZLI9tgRtvrP3H2mYW6A5iZm2Mp9OER6ejsVPGHmd2igpqG7ntFHY6bs3wahkL2DZRH9wWffOXJ5Qj5XP1S7oj9o8L85ApIYRTSFRTYG1S07+oSWotFs9+c3CBdIsteDB3rAcleOh5p9Y3buAKKaHRGeCe7cDnVxt2D475fI08qarWFcMiNlqHXYdxSgVpsCCPp1An3upYkzsZzHmp5/NwMA9JoisfpRaWvg2SCKUB9e+qqlLF8d3rvYjHlmtv/c9cH61NuzKLmJnKIXRc6K51WwfHMpLIc2nQTBRmgXAew3IIbKZPuXRyTGn3Dp1RAWE2ct2hezBVcJyqFjCRZxs1ACFITGUuVvqINqVqCnJweeN4XCsZsM1KvfbWor
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:39.6468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6498282-c92a-4b00-56d7-08df4043f934
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479

From: Peter Colberg <peter@colberg.org>

Allow Rust PCI drivers to configure SR-IOV through sriov_numvfs.
Split the C configure callback into sriov_enable() and sriov_disable(),
passing pinned driver data and a token for the requested operation.
Require drivers to implement both callbacks together.

Return the enabled guard's VF count on success and disarm its rollback.
On a disable request, verify that the driver has removed all VFs before
reporting success. VfRegistration handles VF removal during PF teardown;
these callbacks only handle explicit configuration requests.

The PCI core invokes sriov_configure only through the PF-only
sriov_numvfs sysfs attribute, so no extra PF role check is needed.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs     | 87 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/pci/iov.rs | 55 ++++++++++++++++++++++----
 2 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 077fa80e7425..4887052d31b1 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -94,12 +94,20 @@ unsafe fn register(
         name: &'static CStr,
         module: &'static ThisModule,
     ) -> Result {
+        const_assert!(
+            T::HAS_SRIOV_ENABLE == T::HAS_SRIOV_DISABLE,
+            "PCI drivers must implement both sriov_enable and sriov_disable"
+        );
+
         // SAFETY: It's safe to set the fields of `struct pci_driver` on initialization.
         unsafe {
             (*pdrv.get()).name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            if T::HAS_SRIOV_ENABLE {
+                (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
+            }
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -355,6 +363,85 @@ fn probe<'bound>(
     fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
+
+    /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
+    ///
+    /// This callback is only invoked when `CONFIG_PCI_IOV` is enabled.
+    ///
+    /// Called when userspace writes a nonzero VF count to `sriov_numvfs`. The token carries the
+    /// requested count and permission to enable VFs on this PF. Return the guard obtained from
+    /// [`SriovEnable::enable()`] after completing setup; dropping it rolls back the enable.
+    ///
+    /// The PF must own a [`VfRegistration`] before enabling VFs. That registration disables
+    /// SR-IOV when the driver data is destroyed, while resources needed by VF drivers remain live.
+    /// Implement this callback and [`Self::sriov_disable()`] together, or implement neither.
+    ///
+    /// See [PCI Express I/O Virtualization].
+    ///
+    /// [PCI Express I/O Virtualization]: https://docs.kernel.org/PCI/pci-iov-howto.html
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{
+    /// #     device::Core,
+    /// #     pci,
+    /// #     prelude::*, //
+    /// # };
+    /// # struct Data;
+    /// fn sriov_enable<'a>(
+    ///     _dev: &'a pci::Device<Core<'_>>,
+    ///     _data: Pin<&Data>,
+    ///     token: pci::SriovEnable<'a>,
+    /// ) -> Result<pci::SriovEnabled<'a>> {
+    ///     let num_vfs = token.num_vfs();
+    ///     let enabled = token.enable(num_vfs)?;
+    ///     // Complete any additional setup before returning the guard.
+    ///     Ok(enabled)
+    /// }
+    /// ```
+    #[optional]
+    fn sriov_enable<'a>(
+        _dev: &'a Device<device::Core<'_>>,
+        _data: Pin<&Self::Data<'a>>,
+        _token: SriovEnable<'a>,
+    ) -> Result<SriovEnabled<'a>>;
+
+    /// Disables all VFs of a PF in response to a userspace request.
+    ///
+    /// This callback is only invoked when `CONFIG_PCI_IOV` is enabled.
+    ///
+    /// Called when userspace writes zero to `sriov_numvfs`. Call [`SriovDisable::disable()`]
+    /// while resources used by VF drivers are still available. Returning an error before calling
+    /// it leaves the VFs enabled. Returning success requires that all VFs have been disabled.
+    ///
+    /// This callback is not invoked during PF unbind; [`VfRegistration`] owns that teardown.
+    /// Implement this callback and [`Self::sriov_enable()`] together, or implement neither.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{
+    /// #     device::Core,
+    /// #     pci,
+    /// #     prelude::*, //
+    /// # };
+    /// # struct Data;
+    /// fn sriov_disable<'a>(
+    ///     _dev: &'a pci::Device<Core<'_>>,
+    ///     _data: Pin<&Data>,
+    ///     token: pci::SriovDisable<'a>,
+    /// ) -> Result {
+    ///     token.disable();
+    ///     Ok(())
+    /// }
+    /// ```
+    #[optional]
+    fn sriov_disable<'a>(
+        _dev: &'a Device<device::Core<'_>>,
+        _data: Pin<&Self::Data<'a>>,
+        _token: SriovDisable<'a>,
+    ) -> Result;
 }
 
 /// The PCI device representation.
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index a3d1c4c567f7..21c034c34758 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -2,12 +2,19 @@
 
 //! Abstractions for PCI Single Root I/O Virtualization (SR-IOV) drivers.
 
-use super::Device;
+use super::{
+    Adapter,
+    Device,
+    Driver, //
+};
 
 use crate::{
     bindings,
     device,
-    error::to_result,
+    error::{
+        from_result,
+        to_result, //
+    },
     prelude::*,
     types::{
         CovariantForLt,
@@ -103,7 +110,7 @@ pub(crate) fn disable_sriov(&self) {
     }
 }
 
-/// Permission to enable VFs during a driver's `sriov_enable()` callback.
+/// Permission to enable VFs during a driver's [`Driver::sriov_enable()`] callback.
 ///
 /// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
 /// to another thread, and its lifetime is restricted to the callback. Enabling VFs consumes it.
@@ -133,7 +140,7 @@ pub fn num_vfs(&self) -> NonZero<u16> {
     ///
     /// VF drivers can probe before this method returns, so the PF resources they access must
     /// already be initialized. The returned guard disables the VFs if subsequent setup fails.
-    /// Return it from `sriov_enable()` to leave the VFs enabled on callback success.
+    /// Return it from [`Driver::sriov_enable()`] to leave the VFs enabled on callback success.
     ///
     /// # Errors
     ///
@@ -174,7 +181,7 @@ pub fn enable_all(self) -> Result<SriovEnabled<'a>> {
     }
 }
 
-/// Enabled VFs awaiting successful completion of `sriov_enable()`.
+/// Enabled VFs awaiting successful completion of [`Driver::sriov_enable()`].
 pub struct SriovEnabled<'a> {
     pdev: &'a Device<device::CoreInternal<'a>>,
     num_vfs: u16,
@@ -182,7 +189,6 @@ pub struct SriovEnabled<'a> {
 
 impl SriovEnabled<'_> {
     #[inline]
-    #[expect(dead_code)]
     fn disarm(self) -> u16 {
         ManuallyDrop::new(self).num_vfs
     }
@@ -194,7 +200,7 @@ fn drop(&mut self) {
     }
 }
 
-/// Permission to disable VFs during a driver's `sriov_disable()` callback.
+/// Permission to disable VFs during a driver's [`Driver::sriov_disable()`] callback.
 ///
 /// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
 /// to another thread, and its lifetime is restricted to the callback. Dropping the token does
@@ -213,6 +219,41 @@ pub fn disable(self) {
     }
 }
 
+impl<T: Driver> Adapter<T> {
+    pub(super) extern "C" fn sriov_configure_callback(
+        pdev: *mut bindings::pci_dev,
+        nr_virtfn: c_int,
+    ) -> c_int {
+        // SAFETY: The PCI core calls this through the PF-only `sriov_numvfs` sysfs attribute,
+        // with a valid `struct pci_dev` and while holding the device lock.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `sriov_configure_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+
+        // SAFETY: `sriov_configure` is called only after a successful probe and before unbind, so
+        // the stored pointer has type `T::Data<'_>` and remains valid throughout this callback.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+
+        from_result(|| {
+            if nr_virtfn == 0 {
+                T::sriov_disable(pdev, data, SriovDisable { pdev })?;
+                // The driver may return `Ok` without calling `SriovDisable::disable()`, since
+                // dropping the token does not disable the VFs. Do not report success while VFs
+                // remain enabled.
+                if pdev.num_vf() != 0 {
+                    return Err(EBUSY);
+                }
+                Ok(0)
+            } else {
+                let num_vfs =
+                    NonZero::new(u16::try_from(nr_virtfn).map_err(|_| EINVAL)?).ok_or(EINVAL)?;
+                let enabled = T::sriov_enable(pdev, data, SriovEnable { pdev, num_vfs })?;
+                Ok(enabled.disarm().into())
+            }
+        })
+    }
+}
+
 /// Wrapper for VF registration data stored inside a [`VfRegistration`].
 ///
 /// Stores a [`TypeId`] header (derived from `F`) followed by the pinned data,
-- 
2.43.7

