Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E074FDA52;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623997; cv=fail; b=GDvV1uWAAevV1UZxL87hIVhGnxaXeJxc8bLJs8dEu9E9WGTen4FFa9UTBWC+k/XLHBUQd7u4xbQNW1x43ogSBtiPc/qmXQoc3JaDjcAnxpom1WM27xOOlZjfUHg/bSL6eNt/pXcvSMbSlJ8z5l3CN2HupR303yHV3wgD1TI00cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623997; c=relaxed/simple;
	bh=8ayUKjulANacyqI5ffjA2dpsR2NEu309/5ZIBI6wC1o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQp1bIwMbFM09JacuwkZ/Ex0MvMXWy1qRPT2PeXKmHSCurl+LvQRcfX0wEIkCYl94aAZ7K4rYrpxs+q6YYkKF5JP5Nmru/aMZVyUDnH27EC38igAsaTxfJBWx/gTuh7GixJ4kDghMpQUO3z9qdtKrj9akflPV3CUx0T0gwK167E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q4DURGEE; arc=fail smtp.client-ip=52.101.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q4DURGEE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GchWhO0wI76CFVIUT5WWiruGLknEXzZkRRPJRQtxK/0LoJRFXiHNTxkLefGLyNiNUKg1iOSoW32ydfxTB1RtLs2NIiYs6BiZRqlaI0FMVrKAO8U3x6GwAyiKNLCeL9sCSsU7UiBwCPfUqr/vvqTkaEJcI7DwGnHNaiuImE1jf0xGceJaFFB6w5lAx9FP4UAxks1fqwXtP9fpI87iP/VRvAp1bi8rr+BbwsXH75cFOD4ZnxiuM4vPFkfK5aJedEvEXFB47ZWS9k7uadsGt6AlzSJZDz3olG7ks0dZwrC+txzhIWpQRyN0PbWMoKz16qjLRYKm4i5FH+RdI2e89kIzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ2bSMDpjS8YwA2UnpqvcYFeZEvPxn0dH/nrCPFBf1s=;
 b=dg4DKVKErYWQHDHAUU5FsO9o1chcOD0/gTJghmf+06XeKnH2BMw4acPsmY1pX4njG01vbeKqCuF09AjvmTcxBcx2gDNODam/r6MAxmlr585oTSPABxq0DfMF7bFrrMcI/CXLnmP+X/M0VITXUz2t5TJOfE+pa1uSLLJsVPH2W3o1blPha2lh7wMIgxqNNdqGU/s7NOLMv38BnBwCFCBaAUO9RGNBaPUsv4csDpS1B60tyJ1yVt7xG1CC2NwfWsGeDIEEMZiNS9R1mXW2+5JQubxZBvEbhD/BZkbezoxfBCZIf1GfCF9VNpWHXiIbkq1x4NdTLAWojzHFZPxBI8N9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=colberg.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ2bSMDpjS8YwA2UnpqvcYFeZEvPxn0dH/nrCPFBf1s=;
 b=q4DURGEENNMeDkWrIrjjOLk09LfX2o6kK+YOti6jqIfv0bxNofQ0I/gNjhD1KErJjGmKCpsHj2/OOv2Li1HXzEK+GhBy3k/vpK3Mp350jW6IDW2W8BMJM0SKk7k45MYyb7B8n0gjMi3AXrt/vFUxS4RRsFxMafKeS6CabDgiBkWuSPlujqSExD6vfjnMfMF9rN327s9nW7WZY/ThunDoZib0BMl6NCYdQJP7h7gYtk8OdttwiWaV7DtXQGIrIpFaWRx//fJ4OUyMhrimQlR4bqaQ2RAcwuGbsQpFkYmXAp0jhSoW+lSiLw13SUJqeMmZ8ZVnBmp2CJgLkB6yJExM/g==
Received: from LV3P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::9)
 by CH4PR12MB720178.namprd12.prod.outlook.com (2603:10b6:610:50e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 19:33:08 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::a1) by LV3P220CA0006.outlook.office365.com
 (2603:10b6:408:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 19:33:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 19:33:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 12:32:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 28 Sep 2026 12:32:41 -0700
Received: from inno-dell (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 12:32:35 -0700
Date: Mon, 28 Sep 2026 22:32:32 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Peter Colberg <peter@colberg.org>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
	<acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<jgg@nvidia.com>, <alex@shazbot.org>, Peter Colberg <pcolberg@redhat.com>
Subject: Re: [PATCH v2 1/8] rust: pci: add {enable,disable}_sriov(), to
 control SR-IOV capability
Message-ID: <20260928223232.41e93123@inno-dell>
In-Reply-To: <arbc5IsuFxvtJnVj@colberg.org>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
	<20260924190556.1620886-2-zhiw@nvidia.com>
	<arbc5IsuFxvtJnVj@colberg.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|CH4PR12MB720178:EE_
X-MS-Office365-Filtering-Correlation-Id: 820a62f2-d996-4b22-1725-08df1d975295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|23010399003|4143699003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	MMefleUqCzOlkgOFqhMlw79a2bMCOTuleaitrhqz7XH/W4FFInZiN/Xwkm8kAeKX8XQEdTTYzbKkCYulw11grl88h7gliocSaysDv819WvZvP+LPOANHnXvLKGuas3xW/GuOEwQS1yLuKUndvCAK74Hr+cnQJifyxqA/FEfuOQ5ExHhREmc2pBklHzuo4cLWWgctgllM7FI9+u1zjZJd84fhY/vDy0aLULgbRcg1XmuagsImwLwq5oFuPppATKMZbgI+3KrJ2HWSDXuDYj56LBec+T9aliN0sbtPd5ObUGRvFQrGH21EumQY49HTSb9LU9fBpPZmLklT+IVj61KlOHZPgYj5DkHt+C5cmC3av8+f+8an7vp/zAjNg3VYmMdGLWsKzzM27CgFLY5LEtPzLtgOWzSVglqGc6NQgXTV1P0DyL1FaWCMpkSjSnCXrSB2VbQ22K5hqpYIwYM8jWQtAnSshclhPuR0PO8qy7ULWB9zf07562ipbXx8WYYgXMWzlCpE/UsERF+pS9Bslv1rOq7lDzItRORzDuyOOX4g7MsCqugaItEI7mc5u4/ZK89aMb1OHZ+ks5nHEF25C36ctpzRYBkzvtGndQqAJ4mMxOALYcKJPs5f9qAYBUwWHNVMAhswW47V4Gvm6bsKsr6T0xMr555iFozuSMFObZu+YxJxb4/Y6kep+/CK/iQ67NzTQ4PaRyP7NL3pfYmWRhPHtQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(23010399003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EbJcO8h9NOvlwo5bwb2QhaXjEnv3qoZGltyv2ip22haDXDH73+HtSgK8/mWyrSciKqVL3z75r6PbgYob9dpkPn8zdHlz8Nkczh+BQxpb0LDjIr0mxDaZe5TnVOV0Y/jl2HVwaqNPTmWHhRuKWgKrkCH0FAAs6nIf+TSbAJ4ULC3hp7rFTYaI7IklkdSudVif2+fGJZAMevpQk+DhKcDp9NaduNIugHmhyAWhYBTtZtMBTcfAoyUmWu7ON9WvjxPNWrRQMQcBkPOaqirCGc1by+urbZn3/6eFRly389eb9F+TIoRlyqp4Fn7ucfAixrxMDwkHIWUIyoqEWcFNz18zgBiuJXfIKX18feEj+WaeNMM3lZRFn6wu8G3JGMWNdHWGLG43cwiSdTgFRcacLmhN98D7NnmNxvQ2bUtZ1OJxp1WGifGy5nv0FanONsZOlle8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 19:33:07.0805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 820a62f2-d996-4b22-1725-08df1d975295
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB720178

On Fri, 25 Sep 2026 16:43:16 -0400
Peter Colberg <peter@colberg.org> wrote:

> Hi Zhi,
> 
> On Thu, Sep 24, 2026 at 10:05:48PM +0300, Zhi Wang wrote:
> > From: Peter Colberg <pcolberg@redhat.com>  
> 
> Thank you for updating the series and apologies for the silence.
> 
> As part of the next revision, could you please update my email address
> in all patches, which has changed (for kernel contributions only):
> 
> From: Peter Colberg <peter@colberg.org>
> 

Sure!

> Thanks,
> Peter
> 
> > 
> > Add methods to enable and disable the Single Root I/O Virtualization
> > (SR-IOV) capability for a PCI device. The wrapped C methods take
> > care of validating whether the device is a Physical Function (PF),
> > whether SR-IOV is currently disabled (or enabled), and whether the
> > number of requested VFs does not exceed the total number of
> > supported VFs.
> > 
> > Synchronously disable SR-IOV in the Rust PCI remove callback before
> > unbinding the PF driver. This ensures that when a Virtual
> > Function (VF) is bound to a driver, the corresponding Physical
> > Function (PF) is bound to a driver, too, which is a prerequisite
> > for exposing a safe Rust API that allows a VF driver to obtain the
> > PF device for a VF device and subsequently access the private data
> > of the PF driver.
> > 
> > Suggested-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > ---
> >  rust/kernel/pci.rs | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 3ec897709e89..e6dac919f02d 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -133,6 +133,10 @@ extern "C" fn remove_callback(pdev: *mut
> > bindings::pci_dev) { // INVARIANT: `pdev` is valid for the duration
> > of `remove_callback()`. let pdev = unsafe {
> > &*pdev.cast::<Device<device::CoreInternal<'_>>>() }; 
> > +        // Keep PF data installed until all VF remove callbacks
> > have completed.
> > +        #[cfg(CONFIG_PCI_IOV)]
> > +        pdev.disable_sriov();
> > +
> >          // SAFETY: `remove_callback` is only ever called after a
> > successful call to // `probe_callback`, hence it's guaranteed that
> > `Device::set_drvdata()` has been called // and stored a
> > `Pin<KBox<T::Data<'_>>>`. @@ -472,6 +476,38 @@ pub fn
> > set_master(&self) { // SAFETY: `self.as_raw` is guaranteed to be a
> > pointer to a valid `struct pci_dev`. unsafe {
> > bindings::pci_set_master(self.as_raw()) }; }
> > +
> > +    /// Enable the Single Root I/O Virtualization (SR-IOV)
> > capability for this device,
> > +    /// where `nr_virtfn` is number of Virtual Functions (VF) to
> > enable.
> > +    #[cfg(CONFIG_PCI_IOV)]
> > +    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {
> > +        // SAFETY:
> > +        // `self.as_raw` returns a valid pointer to a `struct
> > pci_dev`.
> > +        //
> > +        // `pci_enable_sriov()` checks that the enable operation
> > is valid:
> > +        // - the device is a Physical Function (PF),
> > +        // - SR-IOV is currently disabled, and
> > +        // - `nr_virtfn` does not exceed the total number of
> > supported VFs.
> > +        //
> > +        // The Core device context inherits from the Bound device
> > context,
> > +        // which guarantees that the PF device is bound to a
> > driver.
> > +        to_result(unsafe {
> > bindings::pci_enable_sriov(self.as_raw(), nr_virtfn) })
> > +    }
> > +
> > +    /// Disable the Single Root I/O Virtualization (SR-IOV)
> > capability for this device.
> > +    #[cfg(CONFIG_PCI_IOV)]
> > +    pub fn disable_sriov(&self) {
> > +        // SAFETY:
> > +        // `self.as_raw` returns a valid pointer to a `struct
> > pci_dev`.
> > +        //
> > +        // `pci_disable_sriov()` checks that the disable operation
> > is valid:
> > +        // - the device is a Physical Function (PF), and
> > +        // - SR-IOV is currently enabled.
> > +        //
> > +        // The Core device context inherits from the Bound device
> > context,
> > +        // which guarantees that the PF device is bound to a
> > driver.
> > +        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
> > +    }
> >  }
> >  
> >  // SAFETY: `pci::Device` is a transparent wrapper of `struct
> > pci_dev`. -- 
> > 2.53.0
> >   

