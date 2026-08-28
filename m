Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A7D21767D;
	Fri, 28 Aug 2026 03:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889443; cv=fail; b=Y8hoz7f6vl0UKhBYbX22MnbADfHDRZpwGF/OwtXtwYJErkYhgmTWRBqYXFTj+DEH6yRaQH+qP1/YPpNwqZ0oTN15xzGkQQ1uwXnvsdSL150LkUWFqb7/JZC9IRDVFmzGL2Wp/xmFVTsWSADAObWshQqJgmuxD2gUBeb5jRn4Iyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889443; c=relaxed/simple;
	bh=oPs5NNxOCr3K23Vrxh5DXp3Z5zc+xhbBpdISzRwPLFg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwCWa0NYJshg0Q976qbPgD5CFoHZyLqaTAXsxVkxxWTLieK9DG6fMiumQsyMnn+S2NddKRu53WtJDj0LFASqBEwMqLq+rlfUQhZGGpueXQkx4Oxu9bRl8AoOsQJN7OgIpZPh92RNvk0fSEuvG+mmgjCFVpVbIhbPIXzYcbeSHcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tn3wDKWr; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tn3wDKWr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grveuuk8LB1Z3hoEuS4R0bZjyUEbGdoNkYc32IvkRBXoCRF6zWZMyxJkiYTlecOBJlqxA4M4EHnDQ0beB0t3OyuUMZaobLhsM/OSASkHb3h7IFjZxPBRtfUZYBvnNxmZeMVQiT2iU5OxOHWvxWQBUoX1DHUauKBY3kTkMK4VmEI94JYPq/3fcSzNk8IXCTlrICoa4tRbXaOQzfxgqE9i6BGRTOzJErdaFn63tWrorXUF5MDb158AE3yGJaDnUO9LsfbWjVcBu7aUWgAqOjlCY+cVoZc/p121dynjTZtd/Tw9QjsOG+N5J70K2tleH85yONpwbxb8AQTJphrkb61HQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgmZxYGhw/jia8ZpNwUIE3+mEU0hh0oaj1XdRz+Pyrk=;
 b=uKL9ZccUE2BmRQ2WMOudk1fuRSqMYzgbO+DdSy/iEZKKav8Ps0JfmqjO46hJnNCwENb5GZf3Qx7KkRzsFWd1Mk0lRV56wpyWir3ZW2OBd5vbO3CgrExBY/9CMulEqkdNReyRFBCEXzdWZv+aBktb1VFInmbwYXIDdhkns/CtSqMLc1HyIVVloJ2Zz1LTzMKxvKfp2uJYWofkNWqCRsa/lZHMOJuad5qkfYgkEeoTX0+B/Uy4VGBH/zIWLN69gTtVLmRJr+l4NeYwZgVOeoRVM9Bv3Odbuq13C3LBnIBZu5xZK6v51j8vmz4z2DKrnpCgqwk9x9sxZNmLhPWaXqwLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgmZxYGhw/jia8ZpNwUIE3+mEU0hh0oaj1XdRz+Pyrk=;
 b=Tn3wDKWrIzwQZPIDd9C+2FCctDWC3PhxAAJWrMJDsn7H/rcN9f27GCLetbe88dPulmDjQ/6r2m9BIdXMkGsssI4INqf6jFAeDcMNqxrOtuTeSp4Knp3bBIOUNJJGqLA2ZBu9lWfI+XbhcClEIb77nDJRXJ98uxO2JsijOowgO9NSp5EBlqfHjlFmt9NYP2Aae/hMHZYQY1a4WPOgolvKE4M6LEqgmbIwIcdChyT285gsYiu2h5LSEo28lQKnFcxz07e6TlswoEMupj1vwFlIRcL3DjNpPBsi1D6ME+l+G/g6rbs/Eq+k1Oz7fxFktcxx9pXI4jyf0YSVukVFn2mVSg==
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 03:57:18 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::5d) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 03:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 03:57:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 20:57:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 20:57:04 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Thu, 27 Aug 2026 20:57:02 -0700
Date: Thu, 27 Aug 2026 20:57:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 03/18] PCI: Propagate FLR return values to callers
Message-ID: <apEHDsoW3rJPRZoX@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <b00acbe0755fa5999491368eaac26a78d522e2ed.1783044582.git.nicolinc@nvidia.com>
 <178786269177.3808739.6763094519382046767.b4-review@b4>
 <apCpkJaysSLVY4mr@nvidia.com>
 <20260828000251.GB3922654@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828000251.GB3922654@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 9305e744-f68d-452b-2efa-08df04b87497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|7416014|1800799024|36860700016|10067099003|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jaza50bO5gPVYu4SWqGMYtJq4kxPp66eOSlidTpaH5lQ3FYWEVFrRPr/GhG+BdpI/pAXHxg+Q6cuJTCD4d+beZW7mhOEwSWVAf+Jcynjkq8dt0wsjd/dNhSu8XsE2hE9tjTeubMBZOs291MBlA+pxm5Pnjxh+M6PTi3hdlDpgpjJCzhE2RTjA1X70rBEnFifxBurcFV/vEfBpjtFjzqMDeieItndFJQTHFhCgjU/Gdi8p1Dyppwag1HBGSCT++Jc+nkfm85I8cMoPQPDz6nWNtDfTlNpfTBYM99ijV4Syp7xi/tsjkCKupdsag8ARYRiSVpx2eel6S0uDfRAtPuYe1VWF/zg9H1Jf2ADzB8+lMzpN0Jdprv/js1sG53HhPWhCWhlghuYP2YeqMk1EGdTezgeYLS7uh6w72F6FFfipUaRrZ7eoxZkgMhpNBIPAc+ddCHUF5eC+LtoyIu9o8JFj1FMdInspLcIAcZg1FLVkBrlKk+K3nTOGIHiy8qr30sR2QZC6jf8/0mnG4LCP0A0yTfO+KZNHTxGankXG0BQCa7k/nK6Ifrqt/CMb9v1+WiIqKCUqY4hSVHXe/5mdGB1SPjWD0IQFRezMdd1L/sxemTnGdUaJqNbXtPp7VIWXH5o64O7Jb8joOHrVtmzQTpvcZm/r+jU+gar808dPz+OVvFacr0EeTQGkxDEL2gnHPz60NsWBSuBR1OU+FlnZRHp/w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(1800799024)(36860700016)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fhp0sMNwcPFSt3FfBdokuSU1CJ1DyALAs7axm2mmlmoKl86KpqMkcJm1OEWqrp/HOgSd7NRFqnNHjV5MinmOLoTAnjWqtjLmy1H7BFMIcwNtYDy6MlhTyK5TVlk3vun3t/hMkWGHU8IczMMrhzwx8DVvvqCFn0jX6LdGalYmV2JJa8nPpX2MmOKqN1RwZFASDw643BDcf3MJbfrbO5DWZC1geMhXNA2nJsMov3L13kAxm7JemZIIifwzwOvHhRAV+YSjoIdrYK4O90iChfSyL4CZitC99lPSXuR8RwA3mfmpmzuLXAr5zfRsNdC1ZvB6XNqcmnZwDqSIhYlIfuvAuJ5mvGINK57E6MozWT6UfrdEmOkbBjmPRe0doxRtrKyRZ8Ba06TdqpcZvmBKZBeLG5zzmQKtaiNUpA1hhfjuHY2n8JTvjxJcH3MMGPuZXctJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:57:18.5046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9305e744-f68d-452b-2efa-08df04b87497
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220

On Thu, Aug 27, 2026 at 09:02:51PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 27, 2026 at 02:18:08PM -0700, Nicolin Chen wrote:
> > On Thu, Aug 27, 2026 at 05:31:31PM -0300, Jason Gunthorpe wrote:
> > > > [ ... 24 lines skipped ... ]
> > > > Since these quirks have always returned success, escalating
> > > > would be a new and harmful behavior: the next method is typically the plain
> > > > "flr" method, which would re-run the same FLR without the extra steps the
> > > > quirk wraps around its pcie_flr() call. Add quirk_flr_err() converting that
> > > > -ENOTTY to -ETIMEDOUT, so the cascade still stops at the quirk as before.
> > > > The early "not applicable" -ENOTTY returns are left intact, and they still
> > > > ask the caller to try the next method.
> > > 
> > > This seems like a very suspect AI conclusion to me.
> > > 
> > > I think I'd drop this patch
> > > 
> > > > Convert it at the quirk level rather than in pcie_flr() or pci_dev_wait(),
> > > > because those also serve the native "flr"/"af_flr"/"pm" methods, where the
> > > > -ENOTTY on timeout is deliberate per commit 91295d79d658 ("PCI: Handle FLR
> > > > failure and allow other reset types"): a timed-out native FLR escalates to
> > > > a stronger reset (e.g. bus reset), which skips no workaround there and may
> > > > recover the device. Converting in the core would also change the value seen
> > > > by every direct pcie_flr() caller.
> > > > 
> > > > This is not a bug fix, since these functions have always returned success
> > > > and the propagated values are only consumed by incoming work.
> > > 
> > > In what way? The quirks flows always succeed and it can keep always
> > > succeeding. If anyone finds this problematic they can properly
> > > propogate the error.
> > > 
> > > Squashing the error just for quirks makes little sense.
> > 
> > PATCH-5 forwards the return values to pci_dev_reset_iommu_done(),
> > so IOMMU can keep a device blocked on a nonzero result. Dropping
> > this patch would leave the three VF quirks here always reporting
> > success, reopening the stale-ATC issue this series is fixing for
> > them.
> 
> Sure its fine,

Hmm, that paragraph was a justification for having this patch. But
given the context here, I assume you replied "sure" to my question:
   "Or do you think it's okay?"

> I bet this HW doesn't even have ATC and if it does
> someone can properly fix the quirk and test it that way if they ever
> hit a problem.

OK. I can drop it, since we don't want to fix any return result in
the PCI reset layer.

Thanks
Nicolin
