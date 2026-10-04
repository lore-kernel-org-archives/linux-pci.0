Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AD3F8891;
	Sun,  4 Oct 2026 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094639; cv=fail; b=qeDXM+KvxTJfeRRamJWZu/mrD7Ge77PoQ/4xL554O0VD7NepnP2cXTS95yFDcUTdVIuVaTJsrh8lyEiZMdNvX2M8EDUPh2WXpNip0fKHPOFnHv432eEWLw1Hn9YdKFQwSdO3R3EKeDDliuDga3maGHIc2fC7gJVy7Z3DG3PzMBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094639; c=relaxed/simple;
	bh=C72z/wSP1VIK91BXCzsi11k2vFngJUMz9J/KMOSREqI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCocKD57RZ+yIiFATfbdKuFl3BJS6LJh8zfGAq1AEyutgI3TdZlo3n08NS8R5NzmgpkxnijPMLhI8dWKAZ/6BoI9JLL7bOUg4RFKm1cc8ulaDHrLjRD3HxmT3KXhLewgR+2KR3Y8sdwEyC7Q6S9s63y3woA309TXgI567PZ/OLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQmBlTV6; arc=fail smtp.client-ip=52.101.62.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQmBlTV6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH2W7vYJQPcbpGF+IWtvXZZRIPAF3Wzk1Troe2UKyfZDpw8XlfB060kyRf4oh10bttYzSywIN8zH/lJ1zfVq2XC0n8Fll03oWv59+ZqdobmqcFDOgNzTc0z1cHo7n0BnX+cqrF5cZ593CsGQGzLWbpoZ+tUmYYFxuuLQ5XOcHXdubMXEfyWCIjTPeldW2B16RvBbSSx9UzLegYvps+/Bbai/lYWoCGPB3oKBrweyWKg5z2qhw9Glw+Sw91hFMt3AKHFylw683wiZfRSJ+RnpxVplH1LhCaGhFCpGWdQS4+UuXf2IigQtvhwrj8mQzZojh+jxyMfFN/S8lRyVogR6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoTWEpCWwHsKilZzOBCgb+dRVxlbtiJGg93nXjTj8K8=;
 b=RFLvM4DBdAW24oi7Lp/ptXQOPPhkW9yw1KPdft/olUwzXG292M2jIDqLCG7OGZCvFMi0q/OEE3DO41rai/OLjQBKf6hbs5zHb+8nKtsrMYapEuwZxz4oJ5daJJHPDhz/ITU/Fqd1afqm/JPxm2XEof85uLTdmA4MTPlnBnYG9kaqDrlHwBEkc8bPBUAsT7lA6uQw2zMSiZz1W/MTCVOGYl6rihd1cdR8ju7cZOydm/2oOAdzvPRAw3GjQ+EQbHCkpmKk+ppqPaZMYfl1X3tkm1K1pwZw6BiwpW4v66ld1oNsLlfc/Pr91Io2OrA1CpkJN0nzDrjMA8/N5PBFfY/Lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoTWEpCWwHsKilZzOBCgb+dRVxlbtiJGg93nXjTj8K8=;
 b=PQmBlTV6hF3DUZO2EeIudy3tVtfxnIr3gC7B0r/F46HFPMOLKljzTKzwXyICINODGFbKFFZkXWgkTwKw7+E0+ar3pY+cG0I6Tvtdr5jhxGj0RPWRemebPq8OvAv0WV1pphXNvlNUqeIj2FT7TMhjLm/RsbdPwcDZUNG/ENVXxeRvlxNrRahQsaxfYSwHn2MJOtxJHFGYpzR0so73cpwpbpiRjZn0O2H1Br31H7lWhL7B9vpWAJ5/vP3yNzQ6eCgYyJCw052Wm8uqckRe4nnghAvSHCcjZy6jQNEO01ToNEpAv8KgfzzMYGZAL96u3bqaLRFj1bAFzd3G80St5NZkgw==
Received: from PH8PR02CA0026.namprd02.prod.outlook.com (2603:10b6:510:2da::22)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sun, 4 Oct
 2026 06:17:05 +0000
Received: from CY8PEPF00000050.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::67) by PH8PR02CA0026.outlook.office365.com
 (2603:10b6:510:2da::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 06:17:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY8PEPF00000050.mail.protection.outlook.com (10.167.247.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 06:17:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 3 Oct
 2026 23:16:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 3 Oct 2026 23:16:54 -0700
Received: from inno-x280 (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sat, 3 Oct 2026 23:16:47 -0700
Date: Sun, 4 Oct 2026 08:16:44 +0200
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
Subject: Re: [PATCH v3 08/10] rust: pci: add SR-IOV enable and disable
 tokens
Message-ID: <20261004081644.06bd130e@inno-x280>
In-Reply-To: <DLSPXUPSF0TC.3PC9F8RTDV1IL@kernel.org>
References: <cover.1790705494.git.zhiw@nvidia.com>
	<9b092d339961f744c7ded1e4f21911b66c80ecb4.1790759932.git.zhiw@nvidia.com>
	<DLSPXUPSF0TC.3PC9F8RTDV1IL@kernel.org>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF00000050:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: c51ab882-4e2f-4754-be88-08df21df1c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|36860700016|82310400026|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2Akl4aD/6XWRBp7GU8UbRAXSqb4jfYdpf4fRf53lTnMekUtk4Uzv2TlJ1THxQgcY0EkhoU6VaKTCEPQDeS7rH3B5J9oD9Z+G8/czMvLnE8LOBJBrMb6AfuigHi2FuDcHLgvmikSphm3VCu7jhT3I2/3eeK1GiZhN8oXsIOLCvslga5yINl+MYpwJv7S+mFWUC4pJLcNCiWynPQBZR5V8PhQIom4Y6KkicOOe7GFlz5Wsw1Vhv/kcAGUaoYzyf+06YxrhBnQgrAhM1D9KU1hahYRTM1vWMieiP4Gd7VVDcTAKZVB+F/gMHcwVl3FlHm4dh56+8iGNCR2sKMhWLK5NrYNQDLGpkCZxUeS3UbYRYeIFAY5ZEihBtv4XLlpSpU5zvE8BYDGYl+JPKLr7GetuwMe7UnRRNmz+CLw/fiQSifTSp3lK/sjnvBv7RL6SU86wFQ+nKtBy5aEU1tyEcNc4fUa1hZIP1o+Re8pX3K3gLRpEBnyYcn2wYzBppBDadRWIsTPyehEhTM6NZL7JmKI3oFMBggJZTz/Umn3w0GoIetfaK8NaMvlAx/XuJJ3OHC0Cv6CUFIjOokhlrXuZ35WEfvut+3OgELIoi/hC19FCgz71Scco+m7Ms57SE0COQ15JCKMr/vUBvf1FCtrF70rmR3e8HOYW+G6+2EHQXpkA3c/ml7LKUmSyhq0vNrp5EERQm62GNRxjfrP+noYeEMoD0A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h7VKgzAAust1np29z8+mo350t8Kt6TS7SYpRN+VPlR7lUp+6qjqUZpM1oqTnbqntewjOipDt5qj4DaNeC1H9EpOMjWy9CNJ9q09CsN5wH42BYHYkCf8f2hujWUj3/orKlKyoIKT3e1veRB/D8+5DdPTo37rRilE1TjkknlZXfXN68PwR7Vibafa7p8mMNUt6sIMo6Igp9XqDVGx+AQbaOJiAeQyZgwoeATQGqytT6iSg7QO5R6oYIKVvGJgLne421S8hQQlUbxgPW78X3ZcK9Ubbs0Yn+rx8aTDMbhJX0NL8lhCSLWs3faSNKNrlDftW3b1rh5lPTczm3480Vu++nxPn7QVdAdZm8lcQFWRxm4JpnS3u9Q98E9xW8yDmZ0ZZrtOd6dIf/QWvHoRhPrh1idTbOTVFcR00iXu8uzlhtPEbRbAcYK31BL8qJmkBIDcM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 06:17:04.8350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51ab882-4e2f-4754-be88-08df21df1c7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000050.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975

On Wed, 30 Sep 2026 16:25:36 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:
> > +pub struct SriovEnable<'callback> {
> 

snip

> > +/// Enabled VFs awaiting successful completion of `sriov_enable()`.
> > +pub struct SriovEnabled<'callback> {
> > +    pdev: Option<&'callback
> > Device<device::CoreInternal<'callback>>>,
> 
> This doesn't need to be an Option.
> 

I realize that with ManullayDrop, I don't need Option to be used as the
Guard now. Thanks!

> > +    num_vfs: c_int,
> > +}
> > +
> > +impl SriovEnabled<'_> {
> > +    #[expect(dead_code)]
> > +    fn disarm(mut self) -> c_int {
> > +        self.pdev = None;
> > +        self.num_vfs
> 
> Instead of the Option dance, you can use ManuallyDrop to prevent the
> destructor from running.
> 
> > +    }
> > +}
> > +
> > +impl Drop for SriovEnabled<'_> {
> > +    fn drop(&mut self) {
> > +        if let Some(pdev) = self.pdev.take() {
> > +            pdev.disable_sriov();
> > +        }
> > +    }
> > +}

