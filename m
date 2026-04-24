Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C012D9EFB;
	Fri, 24 Apr 2026 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776998789; cv=fail; b=Njp1uVWVVM/PWQSLx6MQA/4DuhfP0/mC2PJqyOrpsvwzAKPIqTMAQuwNGVuHlf9REA2qOvCJHSYkLraGkEsyl3HzuzTiN0VyYGi3dgRymhHCqWh1DKR3nl9OK9XH1QujqSR8zRCeYe9aJvTuQy7FAby0R6ugLDqEdlf6OQ7h/I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776998789; c=relaxed/simple;
	bh=7JDs/wa0pz5/+Fr1Oq2xrt9R5UjBZfa6+wtWr00276U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8VbY30tkmkHbx3qP4c3R/huMeT1FhVP8XdleGa8RPso0qyxvpswBy6amQf2LRSlpM4fV7tJRGk0d4HlmYrvy2aMebNFDb1EC673S3xzvfeUAxpOJvcJmw9KWoPPOcEr1LE00QVM70tvGGO6CJYk3iTYzZrWJ2TScAZcME1iKXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LVMiSJ8V; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVMiSJ8V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk0MXOcRlODoFZgcenAfCooBZEy6Ohx239PivCC4v5UnyyCbj17kGTANtPzQofmQ36dfBN9W2q/SWsM3+Y7dZRfwzrFqdbgwYS8PyKT6w4LOAyDGsx1bEjmDyWoSFgt7ph9liw6w+8fAA1xBaYqkPWCkApMopM23PPiAc+wfayBkXktkkUXko9HJ6U+yBtv3vnV6YMOS1rhazGsxz8EfO+hLHQsfEvSmceoqpM1QZWWTst5hqmWiGnbXb6LbE53Z0yjpUeLDin9xV8uvgJhlQkQOBXFDoCipvARGqmEUafZV/SWFinThQoiS7bX+v8VwwbUATmGJCwbF/ipkwNHnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anMF1as23eA7xtsnfMdN2TEy44noTjSIt/GIIQtoOkI=;
 b=js96qHkgYydiKSbGISPc0lhzFHPzmkiDoa48/R1KqiTPtGP2h3PG6G1170Nvm+ldjLocTmyw4rl/S/9XButw7U9VxFhZZBqqylp7EKLjOuT8it+UCGutCDHLfYo4jKjeAGwy/QOBDKv51pdCg+Wo2chTOTVAhF77EJypvUSWfBJtxYI2Y6FPdVYhFfdjUgeM4a2SQT/egpikWnyKxltT2ZHKYVAVeBs6fomx/jU1g7IZKG1ODqXpye2WwQ0IoYyHpslxZJ4iGNNpzQA4Qt1ytfEckoM43iaP4aEfErByX8PEym1gE/1DFS+KRHvK3ODXUaFfTXF7soRiKVQGTG78ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anMF1as23eA7xtsnfMdN2TEy44noTjSIt/GIIQtoOkI=;
 b=LVMiSJ8VqmPE+T5m/OcpkA9IaoFiBjIWaCiOrkR88HY3PIHjNHCMrysl+lrgqFumi0KSdrXQd22ogFMlLC9We8ZUehAqYBsRuetFiHXyiaPw+w5f/8Ir5MGQ1nbvz8lc3kXA2/1AT/3O33/ekrHd6F3NiGA3iCuWDQ9fHKHMHfYjyzMRtT+qO0Y6dG13U2sWxr9VjInBBDH0+mpsamswpPgwaVlw3kOhEUpe0H4oGIaQqXZ6kDkQtAF9t3bBdyZ5sy7xESnWcO3G0BN6YxuA7VXcUdoDLq5me2JUW3v3WKb1jHm+S1S+LYvOhWjooNC8NFORXIEfpzVgI61OV8sUuQ==
Received: from SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 24 Apr
 2026 02:46:23 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::10) by SJ0PR03CA0275.outlook.office365.com
 (2603:10b6:a03:39e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Fri,
 24 Apr 2026 02:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 02:46:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 19:46:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 19:46:05 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Apr 2026 19:46:04 -0700
Date: Thu, 23 Apr 2026 19:46:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, "Mostafa
 Saleh" <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v3 02/11] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
Message-ID: <aerZa3aQBMCwzzT8@Asurada-Nvidia>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <bf99f11ac9a42b5552ec3367d02840366459ae7b.1776381841.git.nicolinc@nvidia.com>
 <c8c8b482-3781-4d33-9aea-866467d15b69@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8c8b482-3781-4d33-9aea-866467d15b69@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ace0a23-37dc-42b2-4a62-08dea1abac25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	w8WJZQa27c4RLKR+KvrMBZ3ElzaRgjE811EjHt/oQYoD7WBedLOLfxYP+W3RtQZWStsfBNF9XkwTKLJ709hM4t60FhkEh1IpbA1IXNx/4N9qx2ucoYMSXrWLZSLjuke0SbbLiIuKvCoKesgWvf1Y2pCajX8oZoDzYb1MCH4pae0bOflMcbhwPdNUxi3g0sME9It5gkkSw4HdxtkdTK9qTARU2A4TSq3csZ9PSBctwpoLbtwKc8Wfkp/oVwgoWzCu/ZeI1A/S4UC3V1WBEEGuPyMgFVj91uCB0BhBHB+SxKDH59rKxVCT1soAYnRwauAKrv1WVgi0xigw4TGshtPt3kf2+uY17nz1AHWd0bKxHMjeaJdeZQ4G8ZzSBNHZNCeOsZBlo7+2L2O5XxSVnJus3tHp8BWgE0p4rA7gZOuEWC4szyJH+ER0Pny2p4QSjI8Ocj+l6rejc3F79RwMdHzVaFxFpxf10hxYjq4TT4zNg98i6Q3Y+mW4WnRI1xCh7rSeMxy4Tn3uZbYioUvm7vr+V8Nf95g4t1F+Gw7V/NcEf+8ktbwBDqWMfpT7bDrqGKpN9bTsi0Ik/RUNz/hr6aBONYqjbZYeWCfexs1aMqem476FegaWJHTi1u/yJcCAUnfH3EiwnNy5dI6bSRIV1fd/tJn2tMuAK5bbxFsfaYNUdPReuDY3cUjmTS4pMF0t31vUVy0Vvm+WXSkAwFrgtTM0PwanOV/fwnAhIVNE59kGg5BfMp3sqRiaBUVgAjm11ptwgMCxJ0mXgPzfFbWUJZE2Jw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AxpgwnUuc/6BlISJ5EccKGp9tl0whl94UtwzGOGy9aU4yqOnwX6GuVL5KH+xVU+2v073sUqOc4S2EfVvtkAexWz8agBEdpLdGf4azTwCs2ZGfxaYFYRnr3A7tgdVxNHU07Uo63E1lHCFmOJn5SklN/Gh737fPeGvAuR9BaEY7lRUWRploMncxjmKLezfPvifSYp0J+7zdeSfgXlg/Zjii3VjGfiXtgZCgwCzeaGiPoBzxqGbjZDxzDSwiyvRs6gBfy2Znx3+D22G91AVk6KnSl7h8kyMH49kK3yw7ol6ZS0Vi11fx6aRk0FpAoRD1oRyOSpbcyyNxlO2LID4NumNALkoHSCbUHpev1jvxtu3KZ4QUitVuFEIhCJk+qGE4kiBEo/I69KZwn0gcWaybfh+ebxLtN85NubXP2XEf58WmhAXifszD2+5kWjieEgBZqyP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 02:46:23.1468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ace0a23-37dc-42b2-4a62-08dea1abac25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702

On Fri, Apr 24, 2026 at 10:38:09AM +0800, Baolu Lu wrote:
> On 4/17/26 07:28, Nicolin Chen wrote:
> > @@ -4083,6 +4093,18 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
> >   	if (WARN_ON(!group->blocking_domain))
> >   		return;
> > +	/*
> > +	 * A reset failure implies that the device might be unreliable. E.g. its
> > +	 * device cache might retain stale entries, which potentially results in
> > +	 * memory corruption. Thus, do not unblock the device until a successful
> > +	 * reset.
> > +	 */
> > +	if (!reset_succeeds) {
> > +		pci_err(pdev,
> > +			"Reset failed. Keep it blocked to protect memory\n");
> > +		return;
> > +	}
> 
> Nit: pci_dev_reset_iommu_done() does nothing if reset_succeeds is false.
> Would it be better to handle this in the caller instead? Something like:
> 
> 	if (reset_succeeds)
> 		pci_dev_reset_iommu_done(dev);
> 
> ?

It would also need a print and some duplicated comments. Actually,
that would be my v2, which Kevin suggested this against:
https://lore.kernel.org/all/BN9PR11MB5276706AE4E0BBE86F0F6E158C4EA@BN9PR11MB5276.namprd11.prod.outlook.com/

Though I don't have a strong personal reference here, I do see this
version slightly cleaner than doing in the callers.

Thanks
Nicolin
