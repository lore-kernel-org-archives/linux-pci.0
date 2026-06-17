Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6F3B9DAC;
	Wed, 17 Jun 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682734; cv=fail; b=IsrPAKae5QZOg0v4Nq8WpO4+u44F4QweKeMyaBrCeQ4f/IKxrexu8mke+omv6G1XiOjV7jD79ECzQ5pNS1tISfQoMuGIjpvcWnon3RCf4UKWZDLPxBTP6dPmhG5Xl2ayTWRKQkl4Z6DecPuuGoG32X1sU0ttmOIpq2hRDywaKVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682734; c=relaxed/simple;
	bh=cDtZ/DSdgTp2OiX9vFWh5f+LAM3cpW8BCphMTwGRaUE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exsCfYZTT2CZplKML/9XYeHj3dSW7vxWIvSTkfVESfXsmkLMv3oKw6w/xJnuIiDH297bIbF5j2vzElYd9M8HwVgMKk1CiPB76LR7qTF/Bpaf8XTULblGoNli/WCOimLCXJGpKHHDKKJJ6k1Hiq+vX/5/VnZCJw9vP6KbXYhDfwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZeEsQSCu; arc=fail smtp.client-ip=52.101.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZeEsQSCu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9tCHOJkd0rm1H2Oah3AeqLKLyJ/P42Ct5HkY5+5/iCrqffCcr+AfKkOD3XhKApoj4Pz+N368bo77z5dTDL6zs8fxcr07LMf2M1OW/yB2fbTnDyxyz2AttJe0RHfV3NZ09zX/WJlrXwpcls2bYHG8VvPKKN0WRC7cd3AGiP5sgHDDas/SqRzCOzlxpPzCuCjzk67vc/xTHbDO3eYaE0u8vljzIc9czmQqO7BwmVuauO6+QDsEyc5T8a/FoZxZoTXHJg6qeifS+nsx8PwJQvtUyhOsfYuo/G48pALTrzn7JqmTYJRlG6nHm/4qy1xHn/+NkvDjJ7tt+BK+0i39FZy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J86+vFTD/+CRZ5SBxVPbSowStezryvXV/p2IzxmBgU=;
 b=UrqTXqOCWIllYDO9y3bVP1aP48Qbyi4/KN1nL/YBeS47pq1Oy6aEM4gaFil02j1+GXv7BUMxdHUmN3ajj6wOjCnoBqHf2SSUu/bsv8noJ91HMfCfD3NMojppI/VXyFhG7L6XLwkFU75CvO23z0BL1s51z1hG5GWTrGt6Ge2qNaX1fNwLbXy+lShiJqZebo1zv6/pdfQWSo7gal3g96I1O7fUWNFLHFA1HqhG6J9uH60N9aDWzXthWD6t6e4xNGZZbCF1ZdwlsCr2S8xADsCSgqmDsccvF94/iH41vA2pqJo0v17w8NJ81XvZJxB6qGrNSKuegcWZ0aWdHSoGSJp4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J86+vFTD/+CRZ5SBxVPbSowStezryvXV/p2IzxmBgU=;
 b=ZeEsQSCuvsTXuKTx9zWRCqflc6zImIM3tLxTRElTehvrsHOn9+k/ZcKS7Oggu1pASK/rIg0M5Gx0q4RY2s5bplTQXpN0bAeu7VysBKO6HWTCiTxaws7trpY5855wDClD5NKmJJ4MN/Q5y4SCWv3Oju1flD5uh54Tw1hHViADTygC796gs2fUo5D/jLLUvGcv6qVEzfPuNNx6yizbuSEbKAT6U9Uz6n8ntM9thG2RPcLw3N4mkzvSKMmlCuVFkH3wdsLoKHL4vELM7SlJusLwnpWJp/CvcfGarFJkPAPAyW6CLeaQVlhPFwqd5+aYAyhTo7eTpybAs3C+WknPzzN3MA==
Received: from MN2PR14CA0015.namprd14.prod.outlook.com (2603:10b6:208:23e::20)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 07:52:10 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::99) by MN2PR14CA0015.outlook.office365.com
 (2603:10b6:208:23e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 07:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 07:52:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 00:51:58 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 17 Jun 2026 00:51:57 -0700
Received: from inno-dell (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Jun 2026 00:51:51 -0700
Date: Wed, 17 Jun 2026 10:51:48 +0300
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
	<zhiwang@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/9] rust: pci: expose sriov_get_totalvfs() helper
Message-ID: <20260617105148.4bb2f367@inno-dell>
In-Reply-To: <DJ16B4EDPXO4.1S6ARLURYLTK@nvidia.com>
References: <20260604114339.1565660-1-zhiw@nvidia.com>
	<20260604114339.1565660-2-zhiw@nvidia.com>
	<DJ16B4EDPXO4.1S6ARLURYLTK@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a05e34-22d1-477a-6333-08decc4555ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9MqDJ5UMMWT3QizOFSjcUd7qPkhSyZ0GUC+SuB/kvMN+ORUYvOkZUOlH6cQsnl8Oetd1hQFcEfwNDEJ1Okxif6SKYwAOjncJ8eUmZ9Ca7cdUmcZuOlZEWidSRiHlxktGOt5B0qjVdDjIgZLl2ygxgiywnxzMFQmV/yuxg4OGyo6LQgP3Ef26XutXVcDx2m62uCX64UUcNdEBM8WhM2RGnx4HVQmHQUme9gzNsRQt6iBcxGLjNJq405kDhpXq5ZPGG0uJiyYAIbn+QGnIF5YP2V8Dzw5ks096hdJFiQv8v3CRr9hIrTR8GNwPRZF4GcWjI1HlAbSEMhYmTqB9SrlkaRRW7mWtMIc+OG8oVe7S1bkKUuIf862J+2Z58ZwjJSkbH5AsQLo4XJAr56bM+J3MX6AHZEE3AH1ORCgmWkRjo4lHvILXGiRc1TFYibKFKn/IXDNIWSI/F7OpZMIRnjzILaEpQUPE2PgG+IjWSbp4B9nYpQUYg6STLLH243Cy6hkemVo7gqAcFc3tsdDBBpYeidE2FZS+Glq8OgKDwy2pQDqaPtDS1zPD8hydmCgIktmHrddjuyQL6RAHTlCr7w0B2MlC3HmbJSSCc67RF3nJfZaNqW/PfFnY9ZsH4zblXgZPG+XvL/PkePj1/4GCAGH07Ow/lGWOMkxd67TRa5rabOJgFecDYdFg8zPahNj+IxM2QkSKnBkdYVTU48CTO03fdiMrcNj5YH6Ft8i9M4NgEHykf7HGXz6PB78eonNXgkgJ
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zZ+bGB1kIdFJ33k0sPsAAJVU0AVHIceII9i4yWweE+6kqDDNj3XAc/g7rpcxy3+TkVgYu2BywQbyWLLxs/QODIGd85z+y1VghSh1idKBwXPNJL+XaJ/b/tSiirVPeIrGQK/PfW5AcNJDz0vYrRnVFb8Bu+steteq5XEWHbb7FZ2aNqXv/uI08QHih2JUKT+GDNKwJaZ2A+KLU7I4XZmUEaUbUrkVXhRzeUDVpdMVkOTlIvAjEk1IbWuFJJidpZtdkih0NVU7rSi4p79Y7hba0C1c8UJqnhLxeU/YSf2OOzIprbZVJkP9WlpK7WRHDwVayfje6tYKu6dpZZjqmSIzHzCGEhPclCkKczhAzzMpGQBEWWo5VN/6S1Hg4ysePVVNvP2yDM1VuKJhzA7NeHG+4Gki5g+xBwemhDtNUOIcZt/MvtJ7KvdzF/VmFipTTnXF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:52:09.7381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a05e34-22d1-477a-6333-08decc4555ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456

On Fri, 05 Jun 2026 23:08:38 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Thu Jun 4, 2026 at 8:43 PM JST, Zhi Wang wrote:
> > Add a wrapper for the `pci_sriov_get_totalvfs()` helper, allowing
> > drivers to query the number of total SR-IOV virtual functions a PCI
> > device supports.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > ---
> >  rust/kernel/pci.rs | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 5071cae6543f..d04e5f6841f2 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -450,6 +450,18 @@ pub fn pci_class(&self) -> Class {
> >          // SAFETY: `self.as_raw` is a valid pointer to a `struct
> > pci_dev`. Class::from_raw(unsafe { (*self.as_raw()).class })
> >      }
> > +
> > +    /// Returns total number of VFs, or `Err(ENODEV)` if none
> > available.
> > +    pub fn sriov_get_totalvfs(&self) -> Result<i32> {
> 
> I mentioned it in a previous review [1], but I think there is an
> opportunity to improve the C API (and by transition the Rust one) by
> making it return a `u16`, which is the type the number of total VFs is
> ultimately stored in anyway.
> 
> IIRC there is also no need to even update any caller, just changing
> the prototype of `pci_sriov_get_totalvfs` would be enough as callers
> ultimately compare the return value against u16s. So if anything it
> would make the C API more sound.
> 
> [1] https://lore.kernel.org/all/DETDILPA1GFY.27WND0TEC5352@nvidia.com/
> 
> > +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct
> > pci_dev`.
> > +        let vfs = unsafe {
> > bindings::pci_sriov_get_totalvfs(self.as_raw()) }; +
> > +        if vfs == 0 {
> > +            return Err(ENODEV);
> > +        }
> 
> Having 0 VFs does not necessarily look like an error - it's quite a
> valid answer to the question "how many VFs do we have?" which this
> method tries to answer. In patch 7 you even do `unwrap_or(0)` on the
> result of this method. So unless there is a good reason to treat this
> as an error, maybe we can just return a `u16` here.

I will add it in the next re-spin. Sorry that I missed it. 
