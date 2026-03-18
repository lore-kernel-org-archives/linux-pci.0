Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340CB14D719;
	Wed, 18 Mar 2026 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865019; cv=fail; b=CdozYZ8PjQLg0csT2SIzmBQisK6BcIegcpy4nDcB2dc/P8l+pz870vA40fStg0ZySv6R5o7V+coGSRGV8NgelY/ZkT5rsqTXVe4u7ukRVqeo0WCkYVYZpNzg4YN5ydwPD+y2l1E18ge0oX2/3/g43IPJ7TkMWASdD0pMeq50hHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865019; c=relaxed/simple;
	bh=quheXBtCsLcwh3jUdDI4cHc55lqKtx2xZE3C8UOF8AI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU9jicu4SWJF89Ei956yo1liiI41KRPqHP021zHKK4RYaAn6a12REjLD3ovt1KhiEZXcQGw7Ij2y79pkzUPXdc/ArbOwLAvCj+qRda9Xqh5DnuIwv3jxpGAVsonIMqHqkmnZOo59i/vifJctUq9VUZ7N651w71WQjlMxWxHB6eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IdiEHfK9; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IdiEHfK9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mH63NaR85gt0x0j5GRYz8Q+ikIvCvVJsjVVXZ4Lwl659nvtM7moDigaysEwYWVbqQoJydv8icnAR9FJ4hDYNWF6ABNI8htSOZiW+8VPZs7srEVUTHVnsg+qwDe8sgIEvXHuybj+klok6G/EAIWUixUBwlrFFHBJ2mPPx0Db8AZFvEXUOnwCcgyfjupLHR0vEeWq76f89omp04m8Tvgl+nimtpVkKSwPgRRVjRb9J+2ShYNENKBHfjcuWfXGfrvT9Nb6X4sUFHhqdA7I7I1ytGv4yyuJ9KZVB5woaFLnLhi4wRP9+eW0JkK9MNKk/XkQU5QfH3djd5IBBN1FOR/vV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTg4GOyvgLOUc2Y0czVWhfuNoX5uHag9t34RNRrwO9k=;
 b=x7N6nu/i0QdbsQT2E7v8IgYnYJBQhWbV9jV6ueCovdaRuRz2X46K93lDK4Jv47eduH07H1JFtG7iM9vqKBzRz4LaYhBmyunQKZLxXlcndQSNIsjWVfomyamP7Yk9v3aTOd94rVclnWJjewv/CCHJBMYwPbuki27d6eewnFmnxhkbLBgU2kVrd8oaeeBB2lSjw0ENrAgh4VIh9+WGV3tJlRswp6wsnfGqHgH0IbcfdfX5iFv1M2TqKsdXncm7hmUIFzXZ2pp0AVnYCpfnF6m/v+hE3x+SyWuOsniRBtpWBsfjzCTSU8Y+5evC0n8y692QbjM/5xK6FKWV7sv/FjTlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTg4GOyvgLOUc2Y0czVWhfuNoX5uHag9t34RNRrwO9k=;
 b=IdiEHfK9Axey6szwvcsUbCwvMO5yuPgH2l5JGttOxB72DBjvLDDEwLFdW5k3oBmYbWeeL/4U8iV7+4chdTfe4Bde/8UufMwGZlUk2USiR4HuLAXZp45DKcZmRedbwCWFM1GFFZFnleUklHClbd4lDpSsRqc+sJJw+3rGhHgzdiRdHpd0C+2KA0Rc+PYAausYDvXeOra4QNpafQW8xWcDzgID3U2FiZufWcAfeHPd3jeC1/+vLiUqfaB21SK4oxR+Ad/g00VajUGTOZZABgG/F1zd9oThuWROWtr+NC78tqSWTgU0jRb6V4I2/oSjxY1pzkTnyyR8n20tziMj9Jg8Jg==
Received: from BYAPR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:c0::33)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 20:16:53 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::32) by BYAPR05CA0020.outlook.office365.com
 (2603:10b6:a03:c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 20:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 20:16:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:16:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:16:32 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 13:16:30 -0700
Date: Wed, 18 Mar 2026 13:16:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 1/7] iommu: Do not call pci_dev_reset_iommu_done()
 unless reset succeeds
Message-ID: <absIHQIDAicBEwm0@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <21fa71d59c8ab787c0f3d8cf3e9fc725330fd0d5.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB5276706AE4E0BBE86F0F6E158C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276706AE4E0BBE86F0F6E158C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 254c09fc-710d-460a-9ec5-08de852b4b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/qK+tzBcvY4vqP1sRdJAlUVASPYJlgZdxQooyehwb3pwhgoG2rIM6QeAxGx/v87Efbc64cCd+G2WLejFZ6uICCSLg5lYLGZKum4L/s0Y5VJiEU+QSJNQp/lt4A6olBE5e4qfohhg+dsT85PvQDwkSRuSXriAR2HFpiEorDb9437ACWqtI1mgYqmLrjSflJpF/3s4BRitBNcaxQWy2He01eXelfR4VFVzXr/FvCs6ae9cOiaWAULIA69JRRvC8apCqJ64Fzhwa8HARdvCLFdwp8wyeWk8JqTAzj2AjAhvEVGW8AzhmuAKWAU4IqoO5rJ/bmRy+wtQxtt/3rytECT+eQG2pVdvcBDXlrsHCaFOxH9pUw8Yk0kCiPXSqALR3bKnmiZgfSwCswMHwVH9Mj/IyEhb4XKsX5RGdR+EeUXz9G23wRLme45JyYKa4oM3nz1KHHsxFlmmOI2VHB3yyuNHimzrAA2ubjly9oNHdmzSQLXQ6q/PGBC+IRG3pn9dOUkNyn9wW8lVEaXpRiHFLM8vXmXpWqXwqL7cefgpAPBs3BWA3VHeS4D1XAmE7Gb5AWZookDTf/KPn40lTy4svTmUo9VOPez4LW3G1wZDGzLzwmabX1KUC9QZImiUU0vk/GeLcBnaJxtqB7jjLJaA39q79FhevFKlvNTcyaASExcgwSZIst/pmPGTW0IjNwO4QDSCOvgWTw+3dDdNnu5IPUkSvc/7U/fNdJhd/widZ6BtONmn27QISlN1HFIZtxwI048tjRtQzTd2PJn3zug1te+xhQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0jFR8pTO5QeICnQJF2YR2vC5gE1akA2ExTolKEZPquUrVNG8g4rZbS8c69BEBdr5Ze2eLx/f97QAopWxPS3tgfCWaQlGmggJdiRD1dqPCZap67pu8WJRv+yhZjUjoApfmy+aokmxVH2zW2IK4Q4dCTCdNBSsSdcD3OXzg8G9xnRNMm7DXIiYgORUHOK8IBfsBO8csk544ThHfawdWgVdgk0jxqOxq8JxGN3/WTyYHDQJwij3rak6C6KwOmrlXk4PkfSLoGzyluV0g6IaNw8jo9Dokl6yxfSC2wmE1oxJR5Jd3JPdxpisLaDqgyyW42rb4MdiF/0GUN4axcYDSIEghhjgfHwnjNcwPTA4QB19LSRVZAroyUvyaLlkGN5Wz6YUJpJIsA57mfs2VTHaKHIudW2la8Fa8BdtmfsLpIDWdRMw4OqQAF+74Ue2NE/Hhh7J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 20:16:53.0951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 254c09fc-710d-460a-9ec5-08de852b4b95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142

On Wed, Mar 18, 2026 at 07:21:53AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, March 18, 2026 3:16 AM
> > 
> > @@ -977,7 +978,15 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool
> > probe)
> >  		ret = -ENOTTY;
> >  	}
> > 
> > -	pci_dev_reset_iommu_done(dev);
> > +	/*
> > +	 * The reset might be invoked to recover a serious error. E.g. when
> > the
> > +	 * ATC failed to invalidate its stale entries, which can result in data
> > +	 * corruption. Thus, do not unblock ATS until a successful reset.
> > +	 */
> > +	if (!ret || !pci_ats_supported(dev))
> > +		pci_dev_reset_iommu_done(dev);
> > +	else
> > +		pci_warn(dev, "Reset failed. Blocking ATS to protect
> > memory\n");
> >  	return ret;
> 
> let's pass the reset status to pci_dev_reset_iommu_done() then
> put above detail inside. 

Yea, that's cleaner. I will make a change:
@@ -4014,7 +4014,7 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
  * Note that, although unlikely, there is a risk that re-attaching domains might
  * fail due to some unexpected happening like OOM.
  */
-void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, bool reset_succeeds)
 {
        struct iommu_group *group = pdev->dev.iommu_group;
        const struct iommu_ops *ops;
@@ -4025,6 +4025,11 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
                return;
        ops = dev_iommu_ops(&pdev->dev);

+       if (!reset_succeeds) {
+               pci_err(pdev, "Reset failed. Blocking ATS to protect memory\n");
+               return;
+       }
+
        guard(mutex)(&group->mutex);

        /* pci_dev_reset_iommu_prepare() was bypassed for the device */


Thanks
Nicolin
