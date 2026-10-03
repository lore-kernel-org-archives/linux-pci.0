Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5B34027B;
	Sat,  3 Oct 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791047553; cv=fail; b=CK58NGyC6hz6e/A0o5Xe+MevlmtTMsHj/kCUdppO+ZNAmhhXMq+Pw1F1fECeihErUPShJG1m7gT7zdiEN+ALJ5KhmI1D3kBC4VTEFf44MC67Z9QafCvoh84WEn+cPt5dI2KR8qZUBtyt+pz2zE6VdnJaz4YmtFRiEfmrlRlreG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791047553; c=relaxed/simple;
	bh=zJVv752fQ5r199FtiaptiF4gXUZZePSutvrw4zoW8z0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjRf0AJYosyBiSwEUcVUZCglOf8L1oGrSY7qnBSrIob7t/RIJ5BSNMmeUS9xpJf5Az2iHoc2tklumVw98iwwLgvTrCjuziogf3UMYB/nBOkdSx4Iui8TJN4cKZT/219VjFScRM19lYZuN9xt0DXKIWo41GgoymgyrNtgd082HFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h30Umcax; arc=fail smtp.client-ip=52.101.193.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h30Umcax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gapxy5djH2TfSn4TzSLTAZyig/7YeX0Trs4YLZGzhO7y2mcQ43MVkRAaXqzfmTYjv0JL/DvJddUP1fbd52V4Q2IqUlX4RToZ8VVnEGOdWZZLllllESxiN2kjohj/w00qKux+uKoi1GOlZp+lOef0cdvKCf37FegyjGer3mU9pMehn28q1PDGvpU6Gzpdtk0KuBBqYEw9/uxorWxnj/Lkgrvm4/9Jw+i9RKW7hKDXYoxsIeqsMOsFaAUDsdI8ZoOoHGbbdh0JNDoBr9BXsJD/ZlaBgI/gIDtvaxJWBG2OAfALOgbdH+Biq8vVL0Oipvcif0QNQHikSTA2r67AAvprtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRstl6Qkcwx+k9ZKJpdkE+XTlUwtrH/m1sJHVjaeeb8=;
 b=icbnucZo7Ef797Vk/5Rkc8F+JrNwQYgsvFFCh5GIV3519vR6+1V76/pdxkZWUF7GW8ECxfjlktZFyBJr1NXzsRWKRTj7tvAKqKMHLsoGnoFZoeXNSQaGf0t2I/L5qATVdkyf/2actZmoODtY4coK3kI48tCu4/XwX2sG6KeLLXPbdLKCSXPHQ70figYZPjvOlLRjZNU9U58BgrbKDnaiNzZNpsFzHjQs0HZMzjThkVlXjXuQZ7C8I04o70epxUp+MjuZiLo2ItaIVY7WCagpf/zoFPZ5t6C4uFwQHLZtDokANrkovewb8EkKNgB7tdFotuda3ma/CjVoGO2ymQ2rBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRstl6Qkcwx+k9ZKJpdkE+XTlUwtrH/m1sJHVjaeeb8=;
 b=h30UmcaxHbvbPdVLkEGNXwhfW/aeJuGSv+kDJYP38CphAlzZKMzhjosUcVgB4dQprvr+smn5Xfuw/gKZqwHGOi5jhirRD0cX4uYeJSZ4EFc4VsLFIpm4oPZSUKHZQQ0ZazoNYvKpo6I1pEv5Ebz1nmUuRxsKbdPBU4bv+6IsQ3WA3eXzbGhrexEQOUiHCtB0S0fegVGdm5wArxGLnmIcgP7cvWD1Ytaj0hMiCj7zi9dtt6uI77fKa5Sbq719QzjUTYZRvYvkokGEaq+q8TUyy9IyEjTybYVKffWrivebdumQXgCn5DQu+9iE4c4Y4XDh7Sj8b/jGqZKT2zGtiqy6UQ==
Received: from SJ0PR13CA0160.namprd13.prod.outlook.com (2603:10b6:a03:2c7::15)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sat, 3 Oct
 2026 17:12:26 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::84) by SJ0PR13CA0160.outlook.office365.com
 (2603:10b6:a03:2c7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Sat, 3
 Oct 2026 17:12:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sat, 3 Oct 2026 17:12:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 3 Oct
 2026 10:12:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 3 Oct 2026 10:12:19 -0700
Received: from inno-x280 (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sat, 3 Oct 2026 10:12:13 -0700
Date: Sat, 3 Oct 2026 19:12:10 +0200
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
	<jgg@nvidia.com>, <alex@shazbot.org>, Peter Colberg <peter@colberg.org>
Subject: Re: [PATCH v3 05/10] rust: pci: add num_vf(), to return number of
 VFs
Message-ID: <20261003191210.7150c343@inno-x280>
In-Reply-To: <DLSLUPDXOA11.VWE3XT1CRSRQ@kernel.org>
References: <cover.1790705494.git.zhiw@nvidia.com>
	<c65da1c1437da6a543720b1e04e977a665ae2de7.1790759932.git.zhiw@nvidia.com>
	<DLSLUPDXOA11.VWE3XT1CRSRQ@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: a10c4bef-4250-4d18-0057-08df21717f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	mz5uBRx4pAaZWdTafPJ02F67fztyiF/WOY+Wn/fD6fJhXL0Hnckbg9yvnZnE5oPt4BbcibRZmo5jqkSBUw6hYVkiXiK/glCQ8C5/o54COiYnqsub+a74bPaQGlz7WVuI+lSFhumPGclz10lw8AsWgWcffBYS2lndxHXdamGqzaEgPK1VLSeJkI45+QjdLOJS/m4TZhFXwuhxuNNbCreDUOjJz7pJrw2bUX1ugjjZtUw0r+fMiaCVtuMDIXJVUEMF0BCXYcgvwUJGaje+dg30qG61EWIDFCPeej70MOtSJNqdqNZax0CXInp3PiNZKSLJorMp3Rv3oFb8JLK++LoB73mLBxu8CFWB3Q7lcNj1Eu7a+i0MyedJG/Gv/qwOi28TdAfVlRNTOikfTSeb/Co3Vi0aUZlP6WMQLJ5lyhz51ujv0wTLt5sK9aRgRvPS6h4qssA4WzJ0l6qHTG3CXqT+MM24JLWCFKNVl4BZ4yGYr3V0UMXNprZ7gXYm66Uf4WgqEhGW5rVZkhtmnyAvHbBSaFg8P7AE79zZ5iyqXvEHC0ipfziUNENeqc6Pwu/6+E4np4bqEgKZd+O+lnbwgSTfA3mqXDGyEBfVqzIQXcNoyayH196YRGShF5KJ33AfdMVlRr66pTu1MQG8wqjynQVk3aSxcXwAAEcuqL0flY+udIb7lx+T1A5N7tT/QuvUqSQnfUGB/YEVuqedT//YyJx2GQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aJslkcd9xo2vXSUz0uJZLzXslP8Gur1/i5SmEDWmq2T8jFtNkJxiWTp6E1Ip0nb5C21ii7P0DwTePhaba/RCAqWsLJwbjUIRKvt3CJxxOZlskk/RZ/iXUTQ8e7Cxoy3xycORhOIeBbNd4Ukm/amQsQT3x5tf/p4lnVb2HsfJm2JLa1oofZQIU8GwwzrlHhu7jTXhXBE2v2pIkO2HnMvkDmLsDz8dffuv3+AEAGMT1tIRlM5Xwb7FeoAcVlY7GAIZ7u/ZadzfBGVPN95jZf1LYDWOeqFL5VZfJzHVwmTIku27jibFbop+SG+191ek2oh63GclWDXlPVArEd5cVmCuIp6IT3tmobrMS9Nvc6AQcQFMXIEeUqQSnm2CMD8j53EJ7URWXzqzPgk2jrVSw4BFGILMMazhqJCgc/uI7gNkNCbDt/zo+s8izOW4htbK47eK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:12:25.9327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10c4bef-4250-4d18-0057-08df21717f3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF

On Wed, 30 Sep 2026 13:13:25 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:
> > +impl Device<device::Core<'_>> {
> > +    /// Returns the number of Virtual Functions (VF) enabled for a
> > Physical Function (PF).
> > +    pub fn num_vf(&self) -> i32 {
> 
> For the reasons mentioned in patch 1, I'd make this return u16.
> 
> I suggest to do the converstion with
> .try_into().expect("pdev->sriov->num_VFs is u16").
> 

Got it. Will fix that in the next respin.

> > +        // SAFETY: `self.as_raw()` is valid and this call runs in
> > the PCI core callback context.
> > +        unsafe { bindings::pci_num_vf(self.as_raw()) }
> > +    }
> > +}

