Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108793A4278;
	Thu, 21 May 2026 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397695; cv=fail; b=MzsytRk1IQMQqLCQS6CsavUBjC2i05xTMj/CS7PVtSuT3B0kX19HuM/qkCKoTpINHf7aI+rZnpIw46NhYMjKnqB5me5IfbMEu93IgqMfJBxXKRiKMGUYESO684xCYBQ0fW5CUr/TJv4/4t81dKfobylZTeWBxwy85mZyHvdgwjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397695; c=relaxed/simple;
	bh=rrqOueEEFbwEF4qOrtJ4lMSp39WLQfMzs0mCLfWsqVs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXwcB3LKj4i5DrPCpSZ/bllraUpdSGWLI8l4k3pXJ4v6OUbTIIto4wWSuS6Xy7Os0F5kbQwfqLYd3T6OrTEJefmGojvwmblT/xQmhdq0v7JIToOqhTCSYP/rqXpQvoZMZMBBky73O2NMhOrFhJUfOi/eSLmYRJUucwVSCa66XqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ulY8O7Fg; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ulY8O7Fg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7f5gxIXUUDyRMyUNe4NUbeH+mLHfrP6o6URhGRnY55ByItXCfGHHAacVSNuezWTYeCqz2Cx6TTY2ZM1uNaqZNhIhlQN4c6oTV8PE/WGoC3b0DonObGMBqpzZey8y7n1cMz6eTa9K6j3Wqt1DHxqs+rwPlBPJ711qUT2pTyR5QUPhgVzMDL8yN6WRA/JVQA68QAfjWLT75Ztpk6vZFYRFJGP1AWONlCJ8NxbIUknZvmDBLqdb5hGWbLDEdbDCdb824d8CsUu2ltkWDL6A8x9GfScOFz0OUHselSs9muNkne6XlRswsxvsw1xHTdLtyDJIB0Er3sw6iTdlCnanM1qSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtpFwJUPDryKzFEUVO8u7gwZlToW5gQCwC4mgsj82g4=;
 b=gPijItMNclunBCteWQksg3t0eV5O8aDF5+fhWSq0Zw4s1mWSUtkF0gSsxlTA6WkAgXY5CAmKeoMfIAr99Tf58mUy5FXPicn70kN1wOB1JdVJlXZtVrJjuoNGt/FiMi+vnsNY9bR3rBGC+fKwwYMXEUPIbJWEZwwdZ67YOXb+pPTYfkRVkTe7rvYeHbEJqUMIAjsel7JGkUDX0Qq7jaDhBRKhwuAkdnoKsU41LRkO0SkbdWKaOWJA5Qifunzztfu4LuRGHciuL500FOFpOvxYPYrsLlUn9goIvB1Fbkt/WqHN/zvFhSIu5jHb1zSg4IYitnr7ZmSBrbOQwxynW3VDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtpFwJUPDryKzFEUVO8u7gwZlToW5gQCwC4mgsj82g4=;
 b=ulY8O7Fgo6ptNlUsWCUHoo2PR0qtWKM4DhnWgnNzeh3N5qedvaCNs+JVDX3G7ono7KZhBOi7WTyulUzTco9CFZmXRhrYPkt/oPOCUGhi0VO7idgFUld//SUm1WUhQAsfmX4Zxu4iHpXe8e4a1/4gOPKIW+ZaEwzIH7Hnziv8H00b2/KmGgo377K7vKdIvQehZZ3gPoeSjUlOInTUGx9oPUElTi5mFE39UKdxxrcf827rqS2vBKblNdSVR9WqDcCR9a6q540KveZU3swc1KwfHBndai6kWi+25NgpHzjtsX/Q8KIANyzqmsiEBGwlQwE3HioZjcc0FP+fuLIi9lSMKA==
Received: from CYZPR05CA0006.namprd05.prod.outlook.com (2603:10b6:930:89::10)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 21:08:01 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:930:89:cafe::4a) by CYZPR05CA0006.outlook.office365.com
 (2603:10b6:930:89::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via Frontend Transport; Thu, 21
 May 2026 21:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 21:08:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 14:07:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 14:07:37 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 14:07:36 -0700
Date: Thu, 21 May 2026 14:07:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: Re: [PATCH v6 1/3] PCI: Add pci_ats_required() for CXL.cache capable
 devices
Message-ID: <ag90FlOaljwa0qqU@Asurada-Nvidia>
References: <05044d2113e20d81f96677ba53605311662b6b10.1779392420.git.nicolinc@nvidia.com>
 <20260521205723.GA184317@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521205723.GA184317@bhelgaas>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 686685da-7467-4663-d957-08deb77d0af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|11063799006|6133799003|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	xOsD/y5SpGcYKV1NNka3piNktbA2nnZY9RYh58GIixK0EJYxHM0BXv2WtJxRR3vDEUHlLPKr5o/VzWLtaqLXYElc/6awarcJZQEHQUv+7MF/Wo06aO9qm10+NHNVp47D0yRlLtcOJj1wSJK8KWtTWvh97PDsvEVUZLh+u7KNReV3ugedQ1RodpxpKcgbnavzl6MqWz0bCfvPyQyCHEgzjOpV9xxtM9sEaPVb1JERiOm7Qu1litGntZnzPBJkt+WoT+PX7mbZfr4qJz8Go7pCPKrK3ak1xbTLK+19GUMXXcJGeO2k/7VVzEOvzuxi+92W+abDE3xtuII1cTCiJZ6kk42QmimiyGwCR5CEcSIOmpt9EAMYnP2fqHzHo0wNKglukubmE/yMFkt4fU6pyV4os4iWLwHeS9TWCvCpW+hY0NSBie40Oy2vflg3jIiuH+n/ITwlfrJYFcQ8fxf2/wV51Yi4jjoxyww+OE7ae9RPttDrtabhs5DibSs7aX+N9dyuquFWTji+tkQgikfwTrm8zZfIhGwOj1NcOP7PuMDuKquE/ec48/60NwXDPyVVuasVog6m3KHaEdFYyFg2RMO1iXTiZ/8Elp8BTH0ojJQKYIoSstryKpIzc6X/5/bdHLivRZTtg3Q7Rznl4L7BmOQKNbv0RhPrgHy4ucZnfreoj5HZnx+66to7t6aw96SYrupLaEh3NnUZHOwfApkp6xD+lQVXLmxVV7SqOQdKq4FSs0s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dhT9Hh5/C7X6LgTcl0NIBT64i0Cb1627TCPKfSHIJVazG/qFCJkUPt5gcQMtD+LaeZM8+EzOHfZkZbmTrUr4K8TLedJ1KxPBn4qDUACBxFHOI/JCITSjVS2C+vO5s5VloC6KaB3LixJXWKz0ONlL+gmn6wdWoNmgK5pH9rWOiBOSyvlUacxFvDI2tunVTEty5BFleWC1EQK0+DY2QYH+9d3coP6qFR87yKPDCpj3MCYT5B0hOJJXXTLr2wbdzHTQ0AQmEY2uYFyzC5Ut5W2xHVhwZh+ExUxZxQhdr8hUT7170f9XDN1hd/hXt24iacL+H+oCf+QtcZ89H3CjuuV6eJAZRubjmhOnbMwFWOMIjzhvsvmf0FX8MMf3qZlUsBcNol+/0Me3nsOJqJJvwNH7NcixMzzxLnOibAIyOo+McEal9Tuq+I/KLqBxaTpPjEqt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:08:01.3997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686685da-7467-4663-d957-08deb77d0af1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671

On Thu, May 21, 2026 at 03:57:23PM -0500, Bjorn Helgaas wrote:
> On Thu, May 21, 2026 at 01:34:20PM -0700, Nicolin Chen wrote:
> > +bool pci_ats_required(struct pci_dev *pdev)
> > +{
> > +	if (!pci_ats_supported(pdev))
> > +		return false;
> > +
> > +	/* A VF inherits its PF's requirement for ATS function */
> > +	if (pdev->is_virtfn)
> > +		pdev = pci_physfn(pdev);
> > +
> > +	return pci_cxl_ats_required(pdev);
> 
> I acked this before I saw this sashiko feedback, which looks like a
> legit issue to me:
> 
>   Will this VF inheritance logic ever be reached?
> 
>   According to the PCIe SR-IOV specification (section 9.3.3.1), VFs do
>   not implement the ATS Extended Capability, which means pdev->ats_cap
>   is always 0 for VFs.
> 
>   Because of this, pci_ats_supported(pdev) will unconditionally return
>   false for any VF. This causes the function to return false before it
>   can ever reach the pdev->is_virtfn check.
> 
>   Could this prevent VFs from correctly enabling the ATS always on
>   feature and leave them unable to access host memory without
>   triggering IOMMU faults?
> 
> (From https://sashiko.dev/#/patchset/cover.1779304390.git.nicolinc%40nvidia.com)
>
> I withdraw my ack for now until we figure out if it's a real issue.

I did a bit of research here.

The existing pci_enable_ats() checks:

	if (!pci_ats_supported(dev))
		return -EINVAL;

at the top, prior to:

	if (dev->is_virtfn) {
		pdev = pci_physfn(dev);
		if (pdev->ats_stu != ps)
			return -EINVAL;

So, VF must *support* ATS (its ats_cap must be !0) so as to turn
on ATS, instead of relying on the PF's ats_cap.

IOW, Sashiko's comment "which means pdev->ats_cap is always 0 for
VFs" is wrong.

So, I kept the same order in this new pci_ats_required().

FWIW, I also did an inverted version and asked Sashiko to review:
====================================================================
> @@ -205,6 +205,52 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
[ ... ]
> +bool pci_ats_required(struct pci_dev *pdev)
> +{
> +	/* A VF inherits its PF's requirement for ATS function */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +        if (!pci_ats_supported(pdev))
> +                return false;

This isn't a bug, but it looks like these two lines are indented with spaces
instead of tabs.
Also, since pdev is reassigned to pci_physfn(pdev) before checking ATS
support, does this incorrectly check the ATS capability of the PF rather than
the VF?
If a VF has its ATS support explicitly disabled (for example, via PCIe quirks
that set vf->ats_cap = 0), this check might bypass the VF's specific
properties and incorrectly return true based on the PF's capabilities.
Consequently, if a caller attempts to enable ATS on the VF by calling
pci_enable_ats(), it will fail because pci_enable_ats() correctly checks
pci_ats_supported() against the VF.
Would it be better to evaluate pci_ats_supported() on the original pdev
before reassigning it to the PF?
====================================================================

What would you like me to do, Bjorn?

Nicolin
