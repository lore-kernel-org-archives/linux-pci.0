Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83033120C;
	Thu,  9 Jul 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607169; cv=fail; b=Q3D07GKjzf8iCVDqYC/kQgysjEwcWJZi5QokOswTaQZ9B4gmp3sb8Sx7Zx1WHcR21X/731pV1LGachH2DO/DUAM7F7NfBkNe4O10376I169ZgY6/aPNsTmMoPPwkA//1Cv68BbKEvjhio+rUNQHlPUtiPnoyKS9zLDFc5QixWhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607169; c=relaxed/simple;
	bh=YBkv3V/F+iPjLDwoh6Ee6iFg/m/mfcFDikkEpzLvThM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4WBdFk7arR1vIohZxb8KVeunhPznrb8UzpImYSreIiLNeeRYJksqZQvtQcPpvUHuOS9vyT8mejiSSNs7w859u+xW/RBoJHq6LB02mcXO1Jup6EwI0vcw+/kb3mlDmg8fJKL0VHuDAmeP5oJvK6AewuFAEPTqsnQcs9b7ps8kAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h7U0NwG9; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h7U0NwG9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDhE0hkIgECX+RP4QernwuS5D1BmW7RxOg9IFiHz9Oq0rqhht1c+SIB7yLGAsNfeUhOZCJUDT29ugJat9WB36aGGaSWjwOargC4uz990Y0gmiZmC29gcjZ3c6N1tWLCwQKj6BgsQUYYYZBIZHnC8lrdkpaUdgIk0loy3DxcnDlh1XS8/cRTfcyRFmBeOBoXFyHprg9mFO2v3+myqnLeLDSmzgfpqaF2Cqbpo6rCTbOgcUQ1IFFGlE9YblCTXTpqEbNnfRTKpajtIXKXiAmMPO8iNoRrF3vSybTMVt1QUDni2VDQ2w6894Y3LmXZMPSASRYWYVgt+Bl6eFKvmuFprrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1aSIG6BHF0v0oADpSpcoBk0fZ3JDMCs+rMj3M5+8Ko=;
 b=QVSPXVB5awHD1BI3BR6q27BhgZ8lGjmEL+rp15UghLc5hU9p7McvxTnbLCOJkLg0CH1Jdc7X1UAVeaAadtjPnnoY527Vu18gNqMKZaxsF0q4YYOcq/z/ZBVbKtHf2lvs+hRe/5/IxlEguplJ17kbg1cyj6yfIbyDPtQPg/WNJazqnOSRZJif+AOklvHdItylEET0uYwapA/h5GiZixl+bLcpCdEDdQHaecP8xm5lboHCUEvqmuqIUysuG4Gcok/Du9qIuYzTVL9V5EhzUY1k73aAhheGJsvkILGi0k1Jr3gQFDefRRn5pdKCa80qYMtPDPzVx6hN8nQi40f2NkNQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1aSIG6BHF0v0oADpSpcoBk0fZ3JDMCs+rMj3M5+8Ko=;
 b=h7U0NwG9byvdWhlgwVRzZ33amqJE9UWt/x0Clqw8MCVauOzYJZf/SepWsB72k1Euc6VgwN1fRlTok5xkYEU/XZgHLK9goAmweh3J9x+jNlGhx2IDErIZV2guPZgu2Gekfe5aaXYSXdxJxqy8/4hrl0xKFkVGi4KgdDaGLdYDSHI1V7VbdasppOFGBzU2KXgZ6h+DBReavHQe+8GFlN0PhTHx1PRwtZ0FAq/QHUd1xniyS1oTEw8a2NsubXqWZDoVxh9APkyITPDBgI9OT7F7bLUZG4WnbcmptWajMtuXyo7oqKxWNIUeAgq9cqmlCi0cBTR7rjkq81Hz9ljVftd8XQ==
Received: from SJ2P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::15)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 9 Jul
 2026 14:25:51 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::3a) by SJ2P220CA0011.outlook.office365.com
 (2603:10b6:a03:5da::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 14:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 14:25:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 9 Jul
 2026 07:25:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Jul 2026 07:25:45 -0700
Received: from inno-dell (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Jul 2026 07:25:38 -0700
Date: Thu, 9 Jul 2026 17:25:34 +0300
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
Message-ID: <20260709172534.6fb3dfd2@inno-dell>
In-Reply-To: <DJT9O4W3W1E2.159ZIBHJLKXF5@nvidia.com>
References: <20260701062622.3499033-1-zhiw@nvidia.com>
	<20260701062622.3499033-3-zhiw@nvidia.com>
	<DJT8V05POUOC.1F5BQDTMHCTLF@nvidia.com>
	<DJT9O4W3W1E2.159ZIBHJLKXF5@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bacb752-9458-4620-ad5b-08deddc5fa8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|22082099003|18002099003|6133799003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	eMVamUldWrt+CGfBKCSYdYPK4rzhbTdZJUIZ+zh73hD3BlpFSJWchhLblyreLF0hP9tocAE1okX2+P+xmxGmJ5dype0+PsMeQUFVEThZ1leHJEWxeKgHo84/osMm6GrM5pJEB87Aet8gzEe9ucriXIB7iMkTChb5MH3boERw2IFhmka/0OU77ii54TowEX3G0bnA/0XVKIUlwjVbYcpA26TvQTqrRRdzJypHF09rCYRD0gjK2I+Frpu4HPxvmXoG9+rHYmcA3oGg0UxCCK/SrqGgow2NdXtoxANCk/olJbmBhPkQn/jkoz3w5ecJ6fq3oLkyDpIFspS7tPVnylqAkAj6em1yXTrcLe+OKOdbHuH5qii/02tZKOof+1yXLADyD61pPa25o476MXMfwiYEKZw8BDACwCVHGij72GYlDvSRnij/cBDFkcposFmuKe7t0ukzK4tC31DQssH2FGaPUuR1y86Di1+GPyzhdx1yjXptFrTnIzGlHIcso0ScVycyX14aKG4RkRpkX+Un/4VCzTAOIoR6496IUwa+jiwhQFwZ9rBFGQEmizvSfHe4ml1ZYifZqprnVfz1Ts7Sgshg07XPbRZBl5HLcGynHIfO8MP9D0y8/PUkhFtZAjmA6CHxmwOPpXAy7AC+4GMYBHmYhfQ2CfjfsEfyzP69XLifaFQy4Nu2mEHa+56i/t8I8F7dkH8CRykDQ+39G8cfypO6zw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UKHeRvaIT3oPzv2+7kUZQmn5CsICsFe4J9U4YBl05iZt0rSC/rsMHWdBdUfCnMuuJvvm3DCJhgSSbX1JuNLG9j6bPxNtNG2rCjl7kUOD+fND5VAC3YrPyH1r2Rz3nX9uI5b0SENEZktSoIutT+jxlwBDkXjfLC7pHNeaPLQJUFr33iTUE4iS9Ps/G+AIksjpEuSqmk/W24KcUPVjdJVQWampg/Sbc5AgxYp0+l4jffc5HERVMkvwvSMhN04ifmCKIkyf3W+FUzyKiILSY0sBtFNoH2hvDga35alqIBteRj8H/ySV9cnlV3vAOYo+gXhXKv6wv8KdTDAPA8RYBbTPVd50KvJW1ewp4UineYaU2yQEJ5cs8COdexTZMLHjgZm+f5npFUDVbBeWXuCKvn5/ONp4SPA4UHpYNOePK3hGyxPGerY4GDZgwY3BT3adHUUe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:25:51.4748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bacb752-9458-4620-ad5b-08deddc5fa8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769

On Wed, 08 Jul 2026 23:41:20 +0900
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
> Sorry, need to take my tag back. :( Build is failing if
> `CONFIG_PCI_IOV` is not set:
> 
>     error[E0425]: cannot find function `pci_sriov_get_totalvfs` in
> crate `bindings` --> ../rust/kernel/pci.rs:458:44  
>         |
>     458 |         let total_vfs = unsafe {
> bindings::pci_sriov_get_totalvfs(self.as_raw()) }; |
>                           ^^^^^^^^^^^^^^^^^^^^^^ not found in
> `bindings`
> 
> Looks like you need to add a helper in `rust/helpers/pci.c` as the
> inline C function used when `CONFIG_PCI_IOV` is not set can not be
> invoked by Rust.

Add it in v4. 
