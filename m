Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE317331221;
	Thu,  9 Jul 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607108; cv=fail; b=Rrf1f4Gqhjcws4UfshsNElcp2GU8coARn0HfGoAYORCWsdDirdGtAn7rrZMLfMo6YRvS7VUwqlZtfEPto+sg0zkBr6Eh9hEg1HcxYNG7qOSC/j1n34gVs7+2hmWJf44w4Y0XiBrQs5BdlSYa0jIjqS71wTJF5EL47t02BFbiUxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607108; c=relaxed/simple;
	bh=UqTJH4TLIT9Z6hBBvc85UuN1/eAdAdTwvIRfX1e9rLE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1vQCUEJn9BzzD56LSVX7euY2WtIydIv2pQZTdnDf/beD40tZulwmv4QIERwfrO2l+glg8ytcfjTMcwlPXeqctn3zddH/L/Za3sE3MZAd0Jii90KuoxN2GlzgTCXPOQMSImWu6Ou48cEzuA05VI1DOcKmERhcVI8a/uG11tC1Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DMjv4r0f; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DMjv4r0f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/dUv8CQ6MrMIloemUng5VSG1y/qA10EL4aoMEspaplWsWrxO5gBogdomjLsarrV7+f8Qw1katZ7zhos+4WIu3IcFx2p+zoiEhs92KCfWn3R4Y3Jai9b99NAhEL3iOnr2xegN9kYzQkwTgjFyySjXd6gx9pHWQP1sUu6BO/GDi4QnrDXxLYlz7a11foNWopO9hQjRQD5AElbiZcxkGP3UNP0UZL60Brv6IX2Wv+0CkDTGmKExjeF2QchtrwlG/6lEpWdP6Fcrk2ZLkieB7aakhOKibf/bPosGCxA28x56FNfWNVkoiwXFBTcx2q6uWumjjfUnamfdMDHJF/goJO8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMh+GlH/ZbwdOkGvoPhRuwPxcEtbkdph9+8zXpmCmKM=;
 b=ciWroC0dWnMLxPvNoYpxfTGHOUxMDVaQ3xNJ+y+2qAuW8v63cxb0kOBKLAoE6UZy45Yoh2NQN1X9aEsh5Qi8FpzPGzjJ5gwlb55u4r79HDT4uXXn/tku2KLb7WLWcfl7GD3+ZkEWdtJLF2J+4NJSGdSpl+Zy43nFnYzsTPtcMP+C58S2QK3HMqCqDRjc1TBz06RJWrsORA7FZovw1PvTxXHzfh1ljy/k+flIfneeYTgzi19FFMFwQRR45dy3j3SXQcOpLxSCRivGnWx8joIbiVv5lCzLEbQJG8KeFcsEaVxq/XQC+HuqkmekUVN6hW4l+Tx93P5reOgp+t4Wyfd9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMh+GlH/ZbwdOkGvoPhRuwPxcEtbkdph9+8zXpmCmKM=;
 b=DMjv4r0fAry/Z6hzGPOm4A4whHw3REo20MY2Dr9AvN/AfeyMvqcxvpWqM3FY1c4Kbn6Ffhg0wXK1nOH3TGIZ+yTvUZh4VrfwGVKWr/KCiuUw9ggDUZ2Clh4TYU0kV72MrmbVYNKGnJu/oZbOXbCDEWx1GL2RNy5spCBwoGF+Y278x5MkasJ+s3sxhMHNEXrMXfuQYpdLufH6dqsXTz4juplLFiDnpbzb3vV68iFoCKiWJHr4V7y9HK79ZAfYk6oe00j00pQBYhCE9EvWg4rrLnBaRy1XIuIcHTPA0jchUk4qGrYs4YTZEykIXqlrtq9Gw8bepodu+nxHJ5Zuedg7BA==
Received: from BN9PR03CA0938.namprd03.prod.outlook.com (2603:10b6:408:108::13)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 14:24:59 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::97) by BN9PR03CA0938.outlook.office365.com
 (2603:10b6:408:108::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 14:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 14:24:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 07:24:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Jul 2026 07:24:38 -0700
Received: from inno-dell (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Jul 2026 07:24:32 -0700
Date: Thu, 9 Jul 2026 17:24:27 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: <dakr@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
	<apopple@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<zhiwang@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, David Laight
	<david.laight.linux@gmail.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] rust: pci: add sriov_get_totalvfs() helper
Message-ID: <20260709172427.5e9fa20a@inno-dell>
In-Reply-To: <DJT92JKN4D9E.24W84LFKXLWDK@nvidia.com>
References: <20260701062622.3499033-1-zhiw@nvidia.com>
	<20260701062622.3499033-3-zhiw@nvidia.com>
	<DJT8V05POUOC.1F5BQDTMHCTLF@nvidia.com>
	<DJT92JKN4D9E.24W84LFKXLWDK@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: c05fbc6b-41ce-43e8-6f5f-08deddc5db48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006|13003099007|6133799003;
X-Microsoft-Antispam-Message-Info:
	dl2CPjkKnQNc/DLa7hXAmrKcA/MgCFtdxliZTJk1XXAG68astnHO1H/eoFthrmaFCt9R1tjEKJyLSaatrsDbbBRKtJT7qgCrKvPw+D+DuN/6HIo11bL30g8pVPuDDh7dV5nE86+3nrxIfWBFOjLbtreYjj8ir+KK/oJYc7OJQQmxEd9pX7131M6ku4UnqNMfvP6KGSyNgfOjo7tIS0Uq7GqHvQRnZXSRLqcnYUpHsbhfSojsMqdf3a4dgyntoI+W/7G9TXEgaUB9z9jN3/0orBmQ49b3UR7X6u+t+PHo/OUkYFYvJVHw2DYj0InuWq6SfpON/1yZlT7q2MDLlQVcRa7j3cp9aJZVXLIfHvNi41bFPh117PVX9XaJ/yiLnWvdXKYH6FaERAUhzDp+ysdTdI8EhHvWYsneADnPk7M87fPTu2KiK8wDdvUUee2eMsHQQXnXbXDxDcVBdJlQbl9ND6CCItmQZ+1dX9aNchhm5O2P3HmkXHvkfalNMQ7Z8RJ5FovhqwlVe00Tw8APQExQepwH5nL9cgBcEZPg+YrBMfn0jmf6rcXTeFibLnx6UI6rHCjA3ENd34F1ixHdhVHCACi9tfabIoq7smF+pj9CfbdAV1QdNkkeMPT6+PJY79ciRtDLpQQJpOZdqXWPYw4PO371vGZUqDQgJrDRJ+Kurq7zWz2IMmOD2rAqq1mAMrP5XsPGczv6WsSbu4C46Z9Vew==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(13003099007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B9i7Xxv8tL3nFvN4SJ5PiGUAinZGCBiiyqD3eHtORYuyAJm25FIfG8a8oCbWDZ1od6AbIizy/qsPw/56oSA3mLW5oJzMhZX9Qs6tmjB3O0fP7HmpFScikHEMazkb37mlnGZM9nZ3eCj8/qLRDtrazEeIOzt/9e9aS8VAB7ke4sbGLx9UfSiUVz/vccNAEWYOxdTbzGu5FRf9Gg9sAOrqwIbDQJZ4DDPqIrOX1VtrmHw/MObL8rnsW/Ul6WYAq6u3dkPYUDzZji3FQgrd30aJ/O7Kk+hFmK6VGRWXn3qMiIdHAU5LJfWwX5tVV2f8V78sBI/CLmkNL7B0R3cT5LTM358IdYjpDTvWRz/LnrhN7FjkIfP7DmRyKHcleAKznpEnlF4CHzfGyJra/H7ux1tuIi8lVh59IYaLYW5muJIryLF46PzTIxa1S7myK2fODueF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:24:58.8636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05fbc6b-41ce-43e8-6f5f-08deddc5db48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218

On Wed, 08 Jul 2026 23:13:08 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Wed Jul 8, 2026 at 11:03 PM JST, Alexandre Courbot wrote:
> > On Wed Jul 1, 2026 at 3:26 PM JST, Zhi Wang wrote:
> >> Expose pci_sriov_get_totalvfs() to Rust PCI drivers so they can
> >> query how many SR-IOV VFs a device supports.
> >>
> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: David Laight <david.laight.linux@gmail.com>
> >> Cc: Gary Guo <gary@garyguo.net>
> >> Cc: linux-pci@vger.kernel.org
> >> Link:
> >> https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com> ---
> >>  rust/kernel/pci.rs | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> >> index 5071cae6543f..21c51981c02e 100644
> >> --- a/rust/kernel/pci.rs
> >> +++ b/rust/kernel/pci.rs
> >> @@ -450,6 +450,17 @@ pub fn pci_class(&self) -> Class {
> >>          // SAFETY: `self.as_raw` is a valid pointer to a `struct
> >> pci_dev`. Class::from_raw(unsafe { (*self.as_raw()).class })
> >>      }
> >> +
> >> +    /// Returns the total number of VFs, or 0 if SR-IOV is not
> >> available.
> >> +    #[inline]
> >> +    pub fn sriov_get_totalvfs(&self) -> u16 {
> >> +        // SAFETY: `self.as_raw()` is a valid pointer to a
> >> `struct pci_dev`.
> >> +        let total_vfs = unsafe {
> >> bindings::pci_sriov_get_totalvfs(self.as_raw()) }; +
> >> +        // CAST: The C helper returns `unsigned int`, but the
> >> value originates
> >> +        // from TotalVFs/driver_max_VFs, so this cast cannot
> >> truncate.
> >
> > nit: "from TotalVFs/driver_max_VFs (which are defined as `u16`),
> > ..."
> >
> > With that,
> >
> > Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> ... with an additional item for thought: in a previous revision [1], I
> had raised the question of making the return type
> `Option<NonZero<u16>>`, as I think it better encodes "0 if SR-IOV is
> not available" - callers are then forced to consider the dichotomy of
> the result, and not interpret a particular value as having a special
> meaning.
> 
> OTOH, for all practical purposes 0 VFs also seems to be strictly
> equivalent to "SR-IOV is not available", so please take this as a
> nit to consider, not a blocker.
> 
> [1]
> https://lore.kernel.org/rust-for-linux/DETDILPA1GFY.27WND0TEC5352@nvidia.com/

Nice advice. I will address it in v4. :)
