Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536A313E38;
	Mon, 13 Apr 2026 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063158; cv=fail; b=XJNsc1kI524DBa+F3+TvQNUOTrZ6YMuMCugGOkIrBMrxPDV3TNmWI0z/+Ig+r5N7MTUNj27YLj29G8+hIDk7s0kEUAE8dskQiNBQAS6DKMPcY/3nqWzE8Uu8yNepQ9OS56rxqUfzYBp8wtzHv01iFdX45JjYME5VRXIEZW3Qqp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063158; c=relaxed/simple;
	bh=IlVMJPElnNtvDmBUFHqRZh8Ac2XL5C8K7ZrYwnYyANA=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=KR6MVH2kFkXyo9+GcofiBQBP7zrwUIueEWLaEenPwL6MVe0QenMlp2eEKbjGCZhsfhAO1whvUO3tpC6pJQttvCc1UmIyvsHUN9Sd7ZpqanL3vzxvHoEJj9XhA7Q9qN0THrnIgaLrG3VSWlQYJroK7bHzK/Y00MJUJRPYA0rep9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dWnS6DH0; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dWnS6DH0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWFHHnnxWuKjQrCXrsxfx4dXDhjl/uIknNdKyMHUFUeZ2Lz2zKt4XGtH/Gv87tfkgzQ6ThD4Zm8pDEb1Yri9M51gUPd4vUq95UnQDmYov0dTS5PKiJE5k1N4tx2DdJ3k9sMZ85hrlVsR+80kYfT3tmXonnexD6ZPdJ6obemq3FnBP88fBGV4nJ9MNTjBhzlRd0DrLAnOQzf3U3aOQdnUEPqaYENhVD0u8h5bu6VwqShG13M00EwfHovkkNcJ10uzPMJRzYZFuXlf4/0Kd2l/V80kcqwQTZ8Z+BlOgR+SuvfAYJNFTjT7XOKVSg86VxMfgIous9E8dgbofX54OhqNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1hsr0aKQXaAOWXuNH5K/LC1P/5KFEMIUQ7NYWLUo6E=;
 b=jDrVnQBuneFd/XCUxE9mAnPQbcdAX+VHRGbfCF/i4Rp/wTzQl4zslYHZAMzIt5ywg3prXEcUXEvDmC0nQrPhLeKvkF7st2YBekesr0dLX1SQgGatejn6KvWChBtWAwkWXXX4BaagdGQLRC7cH7wH8MM5t/3CQGVqwj1UkmQ9WKNbh5Zi6O+dMKIyIT/U4X5S0kgPp5fs+pvahJT+td0n0oGm8e+iZbZNM58zwpbZMi4/xUPPN3B8WGFGPFKfGt2u5e7/W4ez2jvJOu3QQFNv21+hNwNBi6ofKvHGtqOU1+TPQLnpeS0p+IFO45MrVMhE4nR6fEZyNX5ZaqlfEyw+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1hsr0aKQXaAOWXuNH5K/LC1P/5KFEMIUQ7NYWLUo6E=;
 b=dWnS6DH0HDXRC1Ds0IWLcdky136J7Tzg95jaHVXLRhOkyTVME4bDPTxUqTopR3NIohBkDL/GGP/0iqCxMbvreyS7GiePYBLV5rrS7T3+EE4v456BhUgT61v64arkMsSWmFlxGyLt7hi8KkwZy3jr6YRBHn+YgMC7HvtAG32w4OSoijYir9KrjoSlnVQ224xMzBUMXlDy3LK3Egj2F775wx6Xsiyylb5Xl2MdaubHF/rlc3mUoG46g0UxMV/dofEPBlunZbAhhJ3UOU8ivnQm7OjB63hQaeCxKkfM0cbLR/79XJfeGkptJBhUTeiy7qCDxpCwvWYM43klSxJVpFjMKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Mon, 13 Apr
 2026 06:52:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 06:52:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 15:52:28 +0900
Message-Id: <DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <kjaju@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v3 1/1] rust: pci: add extended capability and SR-IOV
 support
References: <20260409185254.3869808-1-zhiw@nvidia.com>
 <20260409185254.3869808-2-zhiw@nvidia.com>
In-Reply-To: <20260409185254.3869808-2-zhiw@nvidia.com>
X-ClientProxiedBy: TY4P301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: efce0085-39fc-4e78-c75d-08de99293c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D3Cc+FVUQ9Ha3ZNuBdeasVmXumt8P2tnKqOUSsuJ2WmekdL1+VaykQSR2mqIFEixx9W2wZwNlPD93qijX8u1EiIOU6uZvPQmMgeClyDxxwEz5AnuFzU2cL9JOMaXJ8FheiiWUid929x+qRIAFYdseDDvy10TASvV9B8wfx3DVMizHzy6pGpMMxqQSfOh7ZUBBsAyeYIdUfcOSEQkkYPgoczARlArsJy1T+/+KgyegwnzFEFmvVnEAJ4oQIX7Jh/Km8WrDVJffT1E5y//ITyC8wEC0lHScoqZ69X2IQVwjr9+AqAt5MCWGYbjrMthK6C3hu+PbM+9S78ex7LMbXkSSlzBIZMDJ8XHHvbhczmayyK7kAN+XQxf2UohR9qJIqWq0riJGkxvvx1vSd1A+QcQhziUiGgHxOWjjzgSbAf8cr7QQGRfc9cAwaO2AejBjwWMqDgt0L+Xvojyss3c5vUBLEdAI2ziIQzlTsBJIi8drkn+AAevG5ixumX/+SkX1gu1xRglBM+zSuTyRuMlE3jQCDj/d0YL1YHOu1TGkO6ZtpR3zvACw92PVa3bpqHIuGCd/0xDQl8FtNok6xrvstujid2B+TVhzZaBI5nLcFb+kJNzr4uN2zzb5Tj4CaxglFA5BJ8eEjrLj7c9Zd7KR81pNctt/e15474kgzKLsipQCBBll/7w+88uayCj4f19+O6cX//0hcS1wpvI3zTpGruN5iRfvmu67fOQzbODZDuOVAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3IzSXVuRVJ1R0xYM1prMnFMTkxwdWNqUlZFV0d4b3M1NDNFMzRpd0d5d0Zy?=
 =?utf-8?B?dWdKeFNHUkFRdjFOK3BncEUvd3I0T2FYWkkvYm11SUJ4MXlaQks5Z2d1UGN3?=
 =?utf-8?B?L05FK09HWEthZ3ZNZnFac1Qva215R3NOckxjbE1USG1tQjMrMVFzRTN4VENR?=
 =?utf-8?B?MlVGLy9ySzBPUTg5bDltOTZNL0ZIWEVKVVBFS2QzL0t5dlFzQTAxamVDTWJJ?=
 =?utf-8?B?a2Y1NDFZSzB0cWE5elEwaHBTZ1JpSDRhNHY2UjN0Zmt2QzZTKzNBdDl5VEtP?=
 =?utf-8?B?QkNCamR4S0hvWmVkcitwdngrS2kxeSt4ZjRjNW5RZ2djWDBpaWV3eG0wcThm?=
 =?utf-8?B?aUIxQXhTYjhQelp3NFJyejMydkhKaGhSVEczWGRKVmViTDIxdXZaWGhwVmhO?=
 =?utf-8?B?VUlFYXlVZ240cC9tL1oyaDd4TWlhYkM5WW8wbzl4enBkREFQWGxFd1ZIZzMy?=
 =?utf-8?B?UkVORThkT0xoVmpML2tMUy9XeG94QnZ0R21YQ2tKZVBlS1JicENOd1U4Sis0?=
 =?utf-8?B?emxBOEo5V1dFRm1BVWVSZUNGM21RWFRSNVF3Z0c0MVR5S2xYdWxweEIwNSsz?=
 =?utf-8?B?emZvaXg2d1hTQTI1aitZSHZnbHkwMllWVkZsZDh0WFgrRGIyT3o0MkIyTWV3?=
 =?utf-8?B?KzB5b2V1ZGVSWEI1QUx2LzdoZDFaWlJ2MS9nUWJlZU5OdG55M3dSR2FpelhM?=
 =?utf-8?B?Q3NpQmtXYzkvaDZYTVJlNVBOSnRUU2hTRlRDVC83MkQ1aUlIR21OVmNndUhC?=
 =?utf-8?B?aU5xQWdIRVlTSTU3cjdyRUlJRU5OMW9yNXRPNkptZ2dzK3AzK1NMREFSMEhS?=
 =?utf-8?B?Sk5Ia0hOcUdQK3pFbUVCUS9vUjdDWm5hNkpQT1lCRTlQaU12Z3lweFJOc0M0?=
 =?utf-8?B?R3NzUzl6L0VUZ0I2bm1EcGNNdmhvZGhVVGR3TllwVGJrZDBiSHg0ZVJON1VB?=
 =?utf-8?B?YXFFamNOUmJFWnJ6azNOUi9hYzJHdktzZzZ1cGZSbTUraUFGdWU4TnM1bWZ2?=
 =?utf-8?B?YU9tL00reUJmN2h5MTFLY3VXWmE3TlNPVXh5aUFtNlhOYUdmWG5yaG15SDFN?=
 =?utf-8?B?bC9hbEJCUmlOdVZTZ0tEd05xd29PdXhvdWkzSzNia0gxNHNqNHFUM3JJS2hu?=
 =?utf-8?B?a2VPa2phT2Zjc2x6bzQrajZFLzlvdkpEV2dGM3psTUljL2UrL2xDNUZubWJr?=
 =?utf-8?B?dGNpcTZRbjNSZjM4REtURmlURURaNzJvN3FKMGlsVWxKNTltUHVGRFNZdklh?=
 =?utf-8?B?NGJQYmc5czhvOU55T1B3b1BwSS9pVmZ0M2hFeWdITStEZ0k2bFp0M25LOENI?=
 =?utf-8?B?aDRocjBka2VScXRuYlVuR2JUMUhBS2lpcE5zZjN1MWZFVVpnWWU5d2hzUFRp?=
 =?utf-8?B?OWFPVitMb3NiOENKTjRjdGEzM1UvTjVKWTFiN29pQ3FrdnRNRXBPVkgyRDAv?=
 =?utf-8?B?WURrSDZQMjA0c2NqSHBYaFkyRWtOT0tPS1k3N1BVWklmQXZBRFhScDUwazk3?=
 =?utf-8?B?Z3dyN0dXbXFCSStYaERQeHNydUliZ05WUEt6WEpMazFnVU1VTk1mUkdNQStE?=
 =?utf-8?B?anI3akxWaE9lMVg0RVlHeGE5cHZYRVV6RHNzTU5FZHNCSGRDbGZtN2NBNHVQ?=
 =?utf-8?B?V0tFc1BWbWdtTE12RHNnTjV4Kzg0VC8xeTNHSTJ1ci9vRklrMEJCNVE0WXVh?=
 =?utf-8?B?b09iZVVManlXSW1hbTcycGpDTmx2S0Z5cVVIS3NyTDdEZDBidWs1Vm9iUG1v?=
 =?utf-8?B?OWFCYXp1TjRESlVvU09VSU5HODVtaEM4SCtSNE10UytpK3VtSVRzQVV1WGsx?=
 =?utf-8?B?YVVXYWE3N09pZFhjdWJrV1lXY0RVT2ZSdHA4U1dMdXpFNDdWTkhpbjFWckZs?=
 =?utf-8?B?V0pCZDJrWlc4YWpEQm02c1B2WHdCZWsvZ3FyeTNZMnUzOEozdllkRUZWVy82?=
 =?utf-8?B?SjlqSEYxRUlHaUF2cEcrdVhNOXFwb3JkSHE2RWVpbHJwQURzSDlWVUJwekRk?=
 =?utf-8?B?QnJIWlBTZXVCVEZnemJKd0UzdHlpTDFmRjRHK1VnTk5iTFovL2lqaTNzSDVz?=
 =?utf-8?B?VGZnZm01cGZ1M3IxS1FvR3kxeFpYbFJZRHlpc3V2ZkJCK3BkN1hSSmpJd211?=
 =?utf-8?B?MS9RUE1HSGQ3Njl5UEF2S3ZWSW5ITUZYbzBOZVRCaW50WFdMSk1SdFBUYmFl?=
 =?utf-8?B?WWRIMmlXekZiOU8rcXo5WHJUcmVGZHJiN2dZQzNkcUJUOEluVDJIQWZtU2NJ?=
 =?utf-8?B?ZU9SeVVXd1dqcklBc1Q3Q2hvejJra2gwZ0lBaWNvaGZLejBTbmtyZnEzczk3?=
 =?utf-8?B?aWorUG9UZDE2eXlBUmREU0MrM3hmWmUrV0RuTW5zaTBXUnQ4UDJ6YjBRTlM5?=
 =?utf-8?Q?NZFJ79upSi0blIFlD5DsEnajvOycxIdnQ4PUmtxiYIceZ?=
X-MS-Exchange-AntiSpam-MessageData-1: CnhKEbCTo8TZIQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efce0085-39fc-4e78-c75d-08de99293c1b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 06:52:31.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYAJGmzqPBblpD48VBgP2H6Yx1UWE3B9OgAe1omEjWkRARdsee5hmoGn3/vHQlns/e0W1P4/z0Qrf/Arj1a6bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700

Hi Zhi,

On Fri Apr 10, 2026 at 3:52 AM JST, Zhi Wang wrote:
<snip>
> +/// An extended PCI capability that implements [`Io`].
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::pci::{
> +///     self,
> +///     ExtSriovCapability, //
> +/// };
> +/// use kernel::io::Io;
> +///
> +/// fn probe_sriov(pdev: &pci::Device<kernel::device::Core>) -> Result<(=
), kernel::error::Error> {
> +///     let config =3D pdev.config_space_extended()?;
> +///     let sriov =3D ExtSriovCapability::find(&config)?;
> +///
> +///     let total_vfs =3D kernel::io_read!(&sriov, .total_vfs);
> +///     let vf_offset =3D kernel::io_read!(&sriov, .vf_offset);
> +///     let bar0 =3D kernel::io_read!(&sriov, .vf_bar[0]);
> +///     kernel::io_write!(&sriov, .num_vfs, 4u16);
> +///     let bar0_64 =3D sriov.read_vf_bar64(0)?;
> +///
> +///     Ok(())
> +/// }
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// `ptr` is within the device's extended configuration space at a valid
> +/// capability. For sized `T`, the region is at least `size_of::<T>()` b=
ytes.
> +pub struct ExtCapability<'a, T: ?Sized + KnownSize =3D Region<0>> {
> +    config: &'a ConfigSpace<'a, Extended>,
> +    ptr: *mut T,
> +}

This strongly looks like this is reinventing `io::View`. :) Even the
internals look similar. Can you check whether `io::View` can replace
this type? This would remove all the macro business and impl blocks and
simplify this patch considerably.

> +
> +impl<T: ?Sized + KnownSize> Io for ExtCapability<'_, T> {
> +    type Type =3D T;
> +
> +    #[inline]
> +    fn as_ptr(&self) -> *mut T {
> +        self.ptr
> +    }
> +}
> +
> +macro_rules! impl_ext_cap_io_capable {
> +    ($ty:ty) =3D> {
> +        impl<T: ?Sized + KnownSize> IoCapable<$ty> for ExtCapability<'_,=
 T> {
> +            #[inline]
> +            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
> +                // SAFETY: The caller guarantees `address` is within bou=
nds of
> +                // this capability, which is within the config space.
> +                unsafe { self.config.io_read(address) }
> +            }
> +
> +            #[inline]
> +            unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
> +                // SAFETY: The caller guarantees `address` is within bou=
nds of
> +                // this capability, which is within the config space.
> +                unsafe { self.config.io_write(value, address) }
> +            }
> +        }
> +    };
> +}
> +
> +impl_ext_cap_io_capable!(u8);
> +impl_ext_cap_io_capable!(u16);
> +impl_ext_cap_io_capable!(u32);
> +
> +impl<'a> ExtCapability<'a> {
> +    /// Base offset of this capability in configuration space.
> +    #[inline]
> +    pub fn offset(&self) -> usize {
> +        self.ptr.addr()
> +    }
> +
> +    /// Size of this capability region in bytes.
> +    #[inline]
> +    pub fn size(&self) -> usize {
> +        KnownSize::size(self.ptr)
> +    }
> +
> +    /// Cast to a typed capability, checking that the region is large en=
ough.
> +    pub fn cast_sized<U>(self) -> Result<ExtCapability<'a, U>> {

This allows for any cast, including invalid ones, as long as `U` fits.
While not unsafe, this is still incorrect - I don't see any reason to
make this public, which could be a way to mitigate this.

> +        if self.size() < core::mem::size_of::<U>() {
> +            return Err(EINVAL);
> +        }
> +
> +        // INVARIANT: `self` already satisfies the invariant (ptr is wit=
hin extended config
> +        // space at a valid capability), and the size check above guaran=
tees the region is at
> +        // least `size_of::<U>()` bytes.
> +        Ok(ExtCapability {
> +            config: self.config,
> +            ptr: core::ptr::without_provenance_mut(self.offset()),
> +        })
> +    }
> +}
> +
> +impl ConfigSpace<'_, Extended> {
> +    /// Finds an extended capability by ID, returning an untyped [`ExtCa=
pability`].
> +    pub fn find_ext_capability(&self, cap: ExtCapId) -> Result<ExtCapabi=
lity<'_>> {
> +        let offset =3D usize::from(
> +            // SAFETY: `self.pdev` is valid by the type invariant of `Co=
nfigSpace`.
> +            unsafe {
> +                bindings::pci_find_ext_capability(self.pdev.as_raw(), i3=
2::from(cap.as_raw()))
> +            },
> +        );
> +
> +        if offset =3D=3D 0 {
> +            return Err(ENODEV);
> +        }
> +
> +        Ok(self.make_ext_capability(offset))
> +    }
> +
> +    /// Finds the next extended capability with `cap` after `start`.
> +    pub fn find_next_ext_capability(&self, start: u16, cap: ExtCapId) ->=
 Result<ExtCapability<'_>> {

This `start` offset can be anything and potentially lead to invalid
results being returned (I don't know what the C binding does, but
assuming the worst for safety).

Listing capabilities should be done through an iterator as it provides
all their benefits to users. I understand we also want a `find` API to
look for a specific capability and that an iterator is not needed for
this, but if we end up providing a way to list them, it should be
through an iterator.

In any case, this method seems to be unused, so you can safely drop it
for now.

> +        let offset =3D usize::from(
> +            // SAFETY: `self.pdev` is valid by the type invariant of `Co=
nfigSpace`.
> +            unsafe {
> +                bindings::pci_find_next_ext_capability(
> +                    self.pdev.as_raw(),
> +                    start,
> +                    i32::from(cap.as_raw()),
> +                )
> +            },
> +        );
> +
> +        if offset =3D=3D 0 {
> +            return Err(ENODEV);
> +        }
> +
> +        Ok(self.make_ext_capability(offset))
> +    }
> +
> +    fn make_ext_capability(&self, offset: usize) -> ExtCapability<'_> {
> +        let size =3D self.calculate_ext_cap_size(offset);
> +
> +        let ptr =3D core::ptr::slice_from_raw_parts_mut::<u8>(
> +            core::ptr::without_provenance_mut(offset),
> +            size,
> +            // CAST: `Region<0>` is a DST like `[u8]`, so this pointer c=
ast preserves metadata.
> +        ) as *mut Region<0>;
> +
> +        // INVARIANT: `offset` was returned by `pci_find_ext_capability`=
 /

This method cannot make assumptions about the origin of its arguments
without being `unsafe`, as its correct behavior depends on the goodwill
of the caller. Given that we will drop `find_next_ext_capability`, the
code can be rolled into `find_ext_capability` which is now the only user.

> +        // `pci_find_next_ext_capability`, which guarantees it points to=
 a valid capability
> +        // within the extended configuration space. `size` is bounded by=
 the next capability
> +        // offset or the end of the configuration space.
> +        ExtCapability { config: self, ptr }
> +    }
> +
> +    fn calculate_ext_cap_size(&self, offset: usize) -> usize {

This method lacks documentation.

> +        let header =3D self.try_read32(offset).unwrap_or(0);
> +        // SAFETY: Pure bit manipulation, no preconditions.
> +        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), alw=
ays fits in `usize`.
> +        let next_ptr =3D unsafe { bindings::pci_ext_cap_next(header) } a=
s usize;
> +
> +        if next_ptr > offset {
> +            next_ptr - offset
> +        } else {
> +            KnownSize::size(self.as_ptr()) - offset
> +        }
> +    }
> +}
> +
> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offse=
t).
> +#[repr(C)]
> +pub struct ExtSriovRegs {
> +    /// Extended capability header.
> +    pub header: u32,
> +    /// SR-IOV capabilities.
> +    pub cap: u32,
> +    /// SR-IOV control.
> +    pub ctrl: u16,
> +    /// SR-IOV status.
> +    pub status: u16,
> +    /// Initial VFs.
> +    pub initial_vfs: u16,
> +    /// Total VFs.
> +    pub total_vfs: u16,
> +    /// Number of VFs.
> +    pub num_vfs: u16,
> +    /// Function dependency link.
> +    pub func_dep_link: u16,
> +    /// First VF offset.
> +    pub vf_offset: u16,
> +    /// VF stride.
> +    pub vf_stride: u16,
> +    _reserved: u16,
> +    /// VF device ID.
> +    pub vf_device_id: u16,
> +    /// Supported page sizes.
> +    pub supported_page_sizes: u32,
> +    /// System page size.
> +    pub system_page_size: u32,
> +    /// VF BARs (BAR0=E2=80=93BAR5).
> +    pub vf_bar: [u32; 6],
> +    /// VF migration state array offset.
> +    pub migration_state: u32,
> +}
> +
> +/// SR-IOV capability. See [`ExtCapability`] for usage.
> +pub type ExtSriovCapability<'a> =3D ExtCapability<'a, ExtSriovRegs>;
> +
> +impl ExtCapability<'_, ExtSriovRegs> {
> +    /// Find the SR-IOV capability, or `ENODEV` if not present.
> +    #[inline]
> +    pub fn find<'a>(
> +        config: &'a ConfigSpace<'_, Extended>,
> +    ) -> Result<ExtCapability<'a, ExtSriovRegs>> {
> +        config.find_ext_capability(ExtCapId::Sriov)?.cast_sized()
> +    }

This method looks like it belongs to `ConfigSpace`, and should be
generic. Something like

  impl<'a> ConfigSpace<'a, Extended> {
    pub fn find_ext_capability::<C: ExtCapability>(&self)=20
      -> Result<io::View<...>>
  }

If we use `io::View` to return capabilities, we can recycle the
`ExtCapability` name for a trait that provides the information required
for `find_ext_capability` to work properly, like the associated constant
for the capability ID. In this patch, it would be implemented on
`ExtSriovRegs`, providing the projection of the view through `C`.

This also opens the way for a `find_capability` method that handles
normal capabilities and is available to both variants of `ConfigSpace`.
I am not saying this needs to be done in this patch though.

> +
> +    /// Reads a 64-bit VF BAR from two consecutive 32-bit slots.
> +    #[inline]
> +    pub fn read_vf_bar64(&self, bar_index: usize) -> Result<u64> {
> +        if bar_index >=3D 5 {

Why is this value hardcoded? If this is correct, let's make it a
constant with an informative name (and possibly a comment justifying its
value).

> +            return Err(EINVAL);
> +        }
> +        let low =3D crate::io_read!(self, .vf_bar[bar_index]?);
> +        let high =3D crate::io_read!(self, .vf_bar[bar_index + 1]?);

Don't we want to check whether the bar in question is actually a 64-bit BAR=
?

I wonder whether this also doesn't call for an iterator-based solution
returning an enum with the properly-sized BAR.
