Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CE4F7CA9;
	Mon, 28 Sep 2026 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624786; cv=fail; b=J1z+zIKJ6RtX6MoPixwWMRfD5JQamQF0EAZtPr+rqqR/vKAs9JkrXNK0A5KcjG9zB66C+SmbMChGGUrW7lwpTmSc00v8I0nhiTM2r7SSCRw1Te3t9tX1Eo4PReAp8bWZ+vJQp9o8F337/kED5DY1gcl0MO9yC6oGrSrMHNpztt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624786; c=relaxed/simple;
	bh=5XOJz+whO/vI9/S4UQ262LRqD34g1+YMi8Q//1PBC0E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ad3Q6UgcbDVmwx6cFUuEF88EJH8dHIGzvKhPRIsUOv1OyoCytCbgDxcKIOYondwu33XEe9tjDCBH0BaZMEwn6Jtf42dfWKiWncldrNVXn9oHpebg+/DD5efrjXXwOQNC3vPkxkbx5jfJ7jfDhNF8X3ssR19YQXqmPsoeVgWkPNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sy5EYv5Z; arc=fail smtp.client-ip=52.101.43.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sy5EYv5Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiqIxwp9kecXt6o4hTcgO8kuxlx4T7vj+MWHEUExUVlGL6WUt2kwMQuzRLmQ8VosRx6CRe/Jauj96YLwgaya98qnnmprdAnlSqoitn03Ply7GC+lVTMxgNh2O1HJ5iN0IGcuz2tVcGOsjRVRf5EiB9k8VijRlgO83dV3qg1iQSe3jdGBpiyx7ph8A3UP9AANeoNEWZJm3qlS/pPOiOalWfx9M3ZzIy2zz+d0gBk0266SA4PLb5fBerBCQhkf25jQuWfAqL2NDknOUtFupAUUU/eku24+zQmP/kJAvyL+Fx5nLIGsUIkgrjmH/eMt7B4nB06updKjsAQx9uV6BdTJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5WByeizj7y6OP1rkot2rSeesSocKS9siSXt2j/h7+M=;
 b=ylJWNnhAIPgc09Q8yF4QqWshJ/vzqtvpRuICC6RKQU0cx+nlvXKPDqYaLJEFLVyNGSRDpPrOcDr8AGHk6qv+bwTmetWzn+ZGmwqcTlLUSQAJPo1YBYFLFTm0DlMlntAojjPzi/iq1tPpOTpNLLbabTWnNSmifCFdwBaOxvcgJxCaFAMUxnl8NQxQKZH1DUk51PVL2G+xa13waFox7dTKiezx4ibqUpxSLLiceviIQiM/trEfsZjFfCjZBInMicHvUW7k0Lw8X+Lp7LVxmIa62fGeSkB0kl3qVxjpd0juF/ZtFspSUJRm5OZ90AYhn2rMqrNGt2Y5AzGIuvr2JHsiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5WByeizj7y6OP1rkot2rSeesSocKS9siSXt2j/h7+M=;
 b=sy5EYv5ZAVA1ILB8kN2eQLZUTlHBzD5ZC+aNv+cRRzKj5mQ0wsHchMgSdZrvZNjDAIsKGSKTtyc4hXapGBdme1hmHjh2gMT2RUGKlHAcly9CWlXnEZDvzgSgM0Jtnrwj5xbHg33Ss5Ili+pzPsV+pNAlnu9bBftAF6SMc43ZSHKmqPuN1fB3Ns5xGdGXb2nHP5sPJRu6n8H56g5PhvP4fF53cQLvQPOcmQ9jALSpTfC6bZ5Dba1Cst0btAAY1FOSzLgblCMMW9FSPSfVM5x2PszJHf32ry+f2OFZZH25rNfsKYcfAT4aY2y7ckR9nrwenvCeClK+cPNbBXDG6NaKxw==
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by CH2PR12MB9542.namprd12.prod.outlook.com (2603:10b6:610:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 19:46:17 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::1f) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.21 via Frontend Transport; Mon,
 28 Sep 2026 19:46:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 19:46:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 12:45:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 28 Sep 2026 12:45:54 -0700
Received: from inno-dell (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 12:45:47 -0700
Date: Mon, 28 Sep 2026 22:45:45 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
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
Message-ID: <20260928224545.78fcea51@inno-dell>
In-Reply-To: <DLQ8UW9ONGHB.NBCSFW530R38@kernel.org>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
	<20260924190556.1620886-2-zhiw@nvidia.com>
	<DLQ8UW9ONGHB.NBCSFW530R38@kernel.org>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|CH2PR12MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: d9227a6e-275c-41d7-e160-08df1d99298f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fN3t1N9D/rrYi7wt7J7qx1c14k8DgIaYCeQTaS+wXM5Ej+Jx6Pw3FZZeT9zzd4Qd0F0nF5wTgC2xQ0N50mg8LlhxXleZxywIhyGOufVnler+ewcdF+Bvy7JmJ/vDPP7qwQil9FNMBeijsyHslMCxp20bhXNQVrr3PaNGk7SCISKMdQDu88rlKqPW7RXOhTMpa/yA0xk6bUjSuBmfyQge6Pp/J7/pX5sd7v35GpzmEJfDJq9uloWMYfgWcMtyJ84gHdrauHV8Q/9bTrL0F5BqStkOyHo7PJPoIR1xWQaErVg1TqM4kYQN4y07Q9G7ulPqOZIa4SM3oDT6kQZIvtcgQK+LIQOXirRFds2B9Aq+e9rtWgyoYAJBn6Pe/XNXQPYUJ8miJn2BuELgsTNlZNVlmVSE0vAQ5I9GjmQWwtNgL2dSesg3VgfpH4Qu0nz3OGYLkvCzuTx/HxA6qJLXeCbt+d0ftJ6eCpYLmRfCN56ebeMp6lsl0W+V+7kdYyqtwzyzqknzlxiz+NSgOzpm745bOH27ItJJHuY6pHR4m41+tFlRot7YgrRvhS9eXOyeIdsKoC1J9Nj9Hv5OHyPp7pnHwEPJhZMGn2Bw3PB7nv9CPHiyrce3VpzdmSwzwJMKstYOBM3TyN48k82kM+Xo44GbTu27D6A/o6n8bnkUMGMDba/8TKIbLoAVwr11a9wt5FjaTW9+6zWkCAj6HP4i9BIQcw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TgOUx8wu78LCmwNByhwMlDz7Ji0wutGxbhASCYDMmMB6KlF5R1HK0IxHgRVi8t59ZQWz9FuPWgHZ17rgl8I7HTZKiYStz+b4nYz+wQvBpU0R781ij2UCYxAtyCGdTKbY2QwlB+3GQkKoISAv6kCZQuGvrIqbHyMVwxAk9UQXcp2UDv9HkKMDYCf61NYfZF4lRfGBnXSLHpGkKr8KEUc9/ffi4P7d2HzTkgMxvDOXq4ri51SYzdMSMiy730mH/IcaCGAT23rOfMpiRdIACrpZUa7qxJ4vOoS1LalXRdI2+mU/qNYvcBcrx/1Xy2rs9U6X0NItkQhGZLi5+Ytc9P1sdbLALutOM8xqVJj+ZoHtDzmxQLAVxNwOACSE4bdZyTv2EJLfa1mvRNyiaxeVflySr2YAnhs4EPeK6sir5U80TJBrR2cgfuFOJhnc/I/CE3aO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 19:46:17.2526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9227a6e-275c-41d7-e160-08df1d99298f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9542

On Sun, 27 Sep 2026 18:37:06 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Thu Sep 24, 2026 at 9:05 PM CEST, Zhi Wang wrote:
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
> 
> I don't think we need this? The VfRegistration should guard against
> this already.
> 

Nice catch. This was already handled in the VfRegistration.

> > +
> >          // SAFETY: `remove_callback` is only ever called after a
> > successful call to // `probe_callback`, hence it's guaranteed that
> > `Device::set_drvdata()` has been called // and stored a
> > `Pin<KBox<T::Data<'_>>>`. @@ -472,6 +476,38 @@ pub fn
> > set_master(&self) { // SAFETY: `self.as_raw` is guaranteed to be a
> > pointer to a valid `struct pci_dev`. unsafe {
> > bindings::pci_set_master(self.as_raw()) }; }
> > +

snip

> >  }  
> 
> I think we do not need to expose those as functions on Device<Core>.
> We should only need to call those from the sriov_configure() callback
> and should otherwise be covered by the VfRegistration.
> 
> Hence, I suggest to expose those methods via a token type, which also
> helps to use an RAII patterns for cleanup rather than manual
> enable/disable calls:
> 

I see. With this, if something unexpected happens during the
sriov_enable callback in driver setup, the sriov_disable can be
automatically called then. Let me slightly change this patch to expose
the functions in Device<CoreInternal> and add a new patch for the below
idea.

Z.

> Instead of a single sriov_configure() callback that covers both
> cases, we can have two callbacks.
> 
> 	fn sriov_enable<'bound>(
> 	    dev: &'bound Device<device::Core<'_>>,
> 	    data: Pin<&'bound Self::Data<'bound>>,
> 	    token: SriovEnable<'_>,
> 	) -> Result<SriovEnabled<'_>>;
> 
> and
> 
> 	fn sriov_disable<'bound>(
> 	    dev: &'a Device<device::Core<'_>>,
> 	    data: Pin<&'bound Self::Data<'bound>>,
> 	    token: SriovDisable<'_>,
> 	) -> Result;
> 
> Note the return type on sriov_enable(), which is obtained from
> token.enable(). It can serve as guard and automatically disable again
> of sriov_enable() fails subsequently and returns an error. If it
> successfully returns SriovEnabled, the PCI core can just discard it.
> The structs could look like this:
> 
> 	pub struct SriovEnable<'a> {
> 	    dev: &'a Device<device::CoreInternal<'a>>,
> 	    num_vfs: u32,
> 	}
> 	
> 	impl<'a> SriovEnable<'a> {
> 	    pub fn num_vfs(&self) -> u32 {
> 	        self.num_vfs
> 	    }
> 	
> 	    pub fn enable(self, num_vfs: u32) ->
> Result<SriovEnabled<'a>> { let ret = unsafe {
> 	            bindings::pci_enable_sriov(self.dev.as_raw(),
> num_vfs) };
> 	        to_result(ret)?;
> 	
> 	        Ok(SriovEnabled { dev: self.dev, num_vfs })
> 	    }
> 	}
> 
> And the destructor of SriovEnabled could be:
> 
> 	impl Drop for SriovEnabled<'_> {
> 	    fn drop(&mut self) {
> 	        unsafe {
> bindings::pci_disable_sriov(self.dev.as_raw()) } }
> 	}
> 
> We could still have the helpers on Device<CoreInternal> so you can
> use them safely in the guard types.

Got it.
