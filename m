Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380431;
	b=Z1uRvcikGLCv8MrUN9qsjWXoTs/KHfGi8PuOOVARHc1Fo7+UnfH72Amm3opuDn0jAAgX
	 eNeODfir0abjB5TwHIQ7mJKpw62O267DboBY6yU7pWQTpqR+TB7kK2a/HiGZbye6X8tPy
	 it2aUJq2aOZqitAVMSoZ8DvI9q0EHQRKTWP9G2s8bIt4reRR6cDcPf6QmJDn612OPEEHi
	 EEiUXxh9OGIjyzhW5jWPfdED1KI0LqF0dac9EN6I2gjGLWDotTS3EB5EHfZLBs61P3vF5
	 Dp00qMyqipYgqCIeCQ7ycdXJv+fsM8FBbkk2KAgB65Q25UTMLgGAuFp7a0roH9JkW9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380431;
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
	bh=W64qJDb+8rbCK/asvUYuFA8685TafdeX1kWjuw1/t5A=;
	b=uK3nbP6uXBnKnE/DB4HpmU1hLbdMBYL7CagMvrX7VYofQambKC3ZCyHtqEqvo1A7xF+M
	 QUx8gACSF5U1xR2++N4tj5WkhfEMqYPNLbFEdCjUc3sKqsclpKxQ/UTKHrsh4rsv4E10+
	 h/oRcLkP0bW6zVdVFJtyN1s041A5P82opK8NbvHx6LAMfqmyvwfq0vewLycuLuW7y+Ntu
	 XAqkeElcxQSK1SYsXm+G187WdQCKF6rYtXV4RUjyL6vhBeVqUSiOQGqvTryT2dZ0R5HSr
	 n3toQcOE5khq5i+/fAvkZ+QAQ4D2dxJLODh2UtMyIzDQtecxVQeB61xrMvyIUr/MFHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YJmD4iSQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.35
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27A60A2601;
	Fri, 30 Oct 2026 17:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF27A60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YJmD4iSQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSD8cpUHMO1pXM2thfpIjROaLwMUpPRyiCWbYUlI6UYranOvM10SBZIcQxruamlZd9+jDt+KIDggn0rp1QazhlyE5ia8dEyVe4d+xFlXc9XwXGtyuDlK8RJ1f9TMqYGDWdW9jg3cRKG3BgqJ2tDi9vtZvlsVXIxPiomCzpL0qNXe5e6f76t4nEyOm0vyOMC55xtU6nMdgg1Qc95UyiVIrySwTW4IjKPwSPF8UYdyMYcDyEcLBILbo+IA0JG1mNpJTRbMlAtCvIJ39J0ihKMOjoDqywmOB4VTgbTCxk2RgJfjw1CPYp2Ym3BYf1k8RLrrUfV1D9l7jGavsXoAZ8TrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W64qJDb+8rbCK/asvUYuFA8685TafdeX1kWjuw1/t5A=;
 b=hI74HDyvwipIp6NVMZyPmZnQh71+MHPB0UeaM60KaAaxEo5n9Q4ps+61Y9sG/sVvnODEeSl1MATIDbsphG9w71RffxgPy6pumHu8b8kS9cyA0dBkistZdfssMCfjRZj2/VgZ7sBmSn61nuT6vzDQLDGvOZzcu9rIcI6nT6oQHECEftv6dhLpByKb0Yrj7pDNJ+dByoC921THE7ILeY9nRv2seCbNQ42ejAsR5JV4hRxX3fwdKr0ZW/ohwC/gU0GQSKsLWZxUZLpEaY3jgQ4QvqV9ymSVO7bOmrL6zXMXsQkGJin6n5/2d6yRVBPRjog39IdgZlUNH1118TY4zRpwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W64qJDb+8rbCK/asvUYuFA8685TafdeX1kWjuw1/t5A=;
 b=YJmD4iSQYl+Rbmdc8Hg9bqCdb6mH28VM6qDKcKiC8l29Xrlwoa5BIbOLmspNJREcg6p9xvdF2V+bvN4/h7mREUmmwRelOxelzBk6axlhWNuwO4zWH9QQPwWGi7BBZMXhxHNc8LoxjlRZP+C+NFgQQkiPVwRU4ytNRdGrVBQ0v6iroUTwHX68LM55frmaT7UAuxLCYm5Q91X7Qv1E8TKxXM9o5jAhulc4RNF5BnXpJj7APGX38x5E68yfUVRdVZqW4FRv3y1bU4WKStX4qcTUDBuPRqyEVJ4Xn8dXQodl74FEOZk+TpylaI8jvDQ/+Jy9I3WKK+chIXLLNbJ1HQg6SA==
Received: from DS7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::8) by
 IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:13:43 +0000
Received: from CY5PEPF00000E75.namprd02.prod.outlook.com
 (2603:10b6:8:2e:cafe::a5) by DS7P222CA0016.outlook.office365.com
 (2603:10b6:8:2e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 17:13:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY5PEPF00000E75.mail.protection.outlook.com (10.167.247.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:13:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:13:19 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:13:15 -0700
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
Subject: [PATCH v5 8/9] rust: pci: add SR-IOV enable and disable callbacks
Date: Fri, 30 Oct 2026 10:12:26 -0700
Message-ID: <20261030171230.196717-9-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E75:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 852ab2d6-8c28-4433-47ce-08df36a92682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|11063799006|5023799004|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261022113327099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	YTs0lBUpvHF51dOf3wij91lY7jJxpE1M0xznUDJXXctAFcxcfgr/bN+9B1SVv87SeINOtBtc8gfrgh0IDLSNdF9JErwX0LIFjILBWYSFrM7ubmAeYOWHsptURXZS9o0Ke+VY2n32BpSnh45j15416WugyMLdQCkBZOAnCc09hEcKuT6dZxqN6o1CekRcmBJQ26RUUXTBZQTLU6VyHBMAkz6P0IIMjo89capU0srMx87Gj7ZCtUHUVoqS5yIihzyiN+yxnB2Nkgy5xaFR4uTT7IEWg8pL/Gv0RBAhDxY7FI/5DUEIqroniTYlMGumr+U1abpW/a8J8OOZ+PFT/RFBNMGj5jzR9vuMUtyTK5HUCfgy4u/frpzPsUtTnYShnahcj0oxW5b3AogKRELzcpgIB1xicGZR5ReteVz44kfWhnmeTfAQJ6TsiFI4c8q0tC7mju+TR2DKCqQymJdWZjdUJYF4W5ZrQ6D/K8BT4H2hSn8LJiS9JT97PupIffniac5ocZ7q//gcUzsYQOr/Kxul0tG28HSSAwxbyQiZMXJWFrMjklvxmZy5kZtWHiDfxnrl1c5TY1M0NiT5pnOdfL5E6GhgP3EVr5d8SSNL/+lKGSn1rOaSUAzE/mgrH4pxQ7gPRrq5Afzn9vZcxtSCv44mgjiTbvNI3ZYAddQGPONBBQHotrlxOiXAd0GeBXSINlBMp080sscuwwxxyOuZ5c3K7Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(11063799006)(5023799004)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022113327099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZYMqZ+nDg0ZDpPhXWfJqLlvvBsoXMfxMGWgheO8mUDJuXGgK2N5gTW3zeFbJzD6jN9oLrI1Br9IljuMhIhszvfQVPtc7VvWgSNNj6V9pa5UXeT5Kv1Qa9ZZRkm2gLiMTCdK2TT8m0HMAqcsKmrwl2ucfZuq8rRojBwEGBanfqFoInYyJ15VyXQCfw0CipK8c4ToiNvlSowa4fL/7FrbJfd7V3tK8jO65pH09p6duZc/2PlET9KH9AcBzBAB/95zmJP4Wfuq9bVTlqx0HIiVnEVpmD+xS37+aDnux5Ugtj6gx+VNXI3bGG8SIDf5yYusH7zyBFQh/13+td/7i/PX8USIlsKKNZSwe+KYsapn7EqLt8gelc2acf0jT+2RnBG0apsmyetS2uTtIAwXigi9Saj2uQTkWfakr/qWR3rMyd0+dDdpyzLQaRXA9eIFbBhDK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:13:43.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852ab2d6-8c28-4433-47ce-08df36a92682
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279

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
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs     | 91 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/pci/iov.rs | 51 +++++++++++++++++++----
 2 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 3a768477014..5de784373ec 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -96,12 +96,22 @@ unsafe fn register(
         name: &'static CStr,
         module: &'static ThisModule,
     ) -> Result {
+        #[cfg(CONFIG_PCI_IOV)]
+        build_assert!(
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
+            #[cfg(CONFIG_PCI_IOV)]
+            if T::HAS_SRIOV_ENABLE {
+                (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
+            }
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -350,6 +360,87 @@ fn probe<'bound>(
     fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
+
+    /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
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
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_enable<'a>(
+        dev: &'a Device<device::Core<'_>>,
+        data: Pin<&Self::Data<'a>>,
+        token: SriovEnable<'a>,
+    ) -> Result<SriovEnabled<'a>> {
+        let _ = (dev, data, token);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Disables all VFs of a PF in response to a userspace request.
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
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_disable<'a>(
+        dev: &'a Device<device::Core<'_>>,
+        data: Pin<&Self::Data<'a>>,
+        token: SriovDisable<'a>,
+    ) -> Result {
+        let _ = (dev, data, token);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// The PCI device representation.
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 197b0c2bb0f..2af9f4c20b8 100644
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
@@ -65,7 +72,7 @@ pub(crate) fn disable_sriov(&self) {
     }
 }
 
-/// Permission to enable VFs during a driver's `sriov_enable()` callback.
+/// Permission to enable VFs during a driver's [`Driver::sriov_enable()`] callback.
 ///
 /// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
 /// to another thread, and its lifetime is restricted to the callback. Enabling VFs consumes it.
@@ -95,7 +102,7 @@ pub fn num_vfs(&self) -> u16 {
     ///
     /// VF drivers can probe before this method returns, so the PF resources they access must
     /// already be initialized. The returned guard disables the VFs if subsequent setup fails.
-    /// Return it from `sriov_enable()` to leave the VFs enabled on callback success.
+    /// Return it from [`Driver::sriov_enable()`] to leave the VFs enabled on callback success.
     pub fn enable(self, num_vfs: u16) -> Result<SriovEnabled<'a>> {
         if num_vfs == 0 || num_vfs > self.num_vfs {
             return Err(EINVAL);
@@ -115,7 +122,7 @@ pub fn enable(self, num_vfs: u16) -> Result<SriovEnabled<'a>> {
     }
 }
 
-/// Enabled VFs awaiting successful completion of `sriov_enable()`.
+/// Enabled VFs awaiting successful completion of [`Driver::sriov_enable()`].
 pub struct SriovEnabled<'a> {
     pdev: &'a Device<device::CoreInternal<'a>>,
     num_vfs: u16,
@@ -123,7 +130,6 @@ pub struct SriovEnabled<'a> {
 
 impl SriovEnabled<'_> {
     #[inline]
-    #[expect(dead_code)]
     fn disarm(self) -> u16 {
         ManuallyDrop::new(self).num_vfs
     }
@@ -135,7 +141,7 @@ fn drop(&mut self) {
     }
 }
 
-/// Permission to disable VFs during a driver's `sriov_disable()` callback.
+/// Permission to disable VFs during a driver's [`Driver::sriov_disable()`] callback.
 ///
 /// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
 /// to another thread, and its lifetime is restricted to the callback. Dropping the token does
@@ -154,6 +160,37 @@ pub fn disable(self) {
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
+                if pdev.num_vf() != 0 {
+                    return Err(EBUSY);
+                }
+                Ok(0)
+            } else {
+                let num_vfs = u16::try_from(nr_virtfn).map_err(|_| EINVAL)?;
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

