Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA7316193;
	Tue,  3 Feb 2026 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146702; cv=fail; b=kk8DLXyTHyMothAcs9WJCxWCUMNyRFKgS03iXceemekZvLNZakgq5aGXS1pbBspIG/uAUtoW6blvMzCWABY0eXuLP5tVXBAyyLrBeq8Ee9YArsJ14/H1xQl18inAMrbyn3iCv0AxN27KwJcsIzc2KRehRu64u+YKe82CF1E5Yq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146702; c=relaxed/simple;
	bh=0sLhtreSXGfaQ1Iql1EXO7j1OP9BpltJmC0fvEZv8YA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDpTKc+AWqGcVozQ2lHpLz0qViSu1JlRZ6cl+YMLaDJaySF8byFOpCG9mO8vb863VWllaGOtmRt99eitdQcGpJwYER4Ia9cuMTlXdl1NceFtF9JUcLlyqyWjBlgqTw2F0GTj2pqq0AKr/EIfoKjMZH1AwfK9ynmHXzKYiEHjpco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHrUwtNJ; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHrUwtNJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9P1EdOgoVrHG1dwqrP35p6IKZSua1P41DpKdCdYR0Giz5oIOqc8XD7i+b+8sbKLt8lQt2AbOMwKClEzuT5EXy+XUcd7eZX5AS32mzcBoLvoRKUBtdUEeyoYVaL9FYOMSYY4fFdNyX/+fIryR3WJYyJQLGgn2lpFr469yC+N2IBdyI6jWQMVK6LwmqUS02uQqeHvhvz4TwCwJYA0YC1ewi3hLKvJvNHDtQuCzFKtkFEjwC+Dt3a0Wc7ATbzuGYGVD4EzgDhJ2piDgWpBUtr1L1oURqFkeB9THY8mTskEF9Sm9rDmzeH9cjFd+mbYgAX8rLZP5yuHKjB6p85xABxZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjkQgDTbSrlJmqO2Va5Ve3LWTlQ5htiVkgADkgrjWvk=;
 b=t8OKP30QfCrx8nTXKnSkJnQKZHQziBJeVVAv0xA50HTfMf+U1oaWxAFG4Wdci516FHJZmog+j+2uW5H3oSstptbJBRm2PjWXZrtVb0epizSaCG6XQh42gypeXWGTh4kWdExmUl87lcih1QTMYpp9KGcZpdjJsFy+0b7GAFh1i9w+GqwmKGY4G27qP6R6lhTLut17SS/bmAXqMTadB5KMy6c8x3mwJNyVV8OsFc2ziRT0TlF67aEkDJYQH6x/sJjpFoeSj2IAR6i+Ptg6SyTVivzaDEgimaNozvOq8W+TerfV7mZNxtnfufTA8fsQSZEvhRcMAeIi/UkbTy8FoIeGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjkQgDTbSrlJmqO2Va5Ve3LWTlQ5htiVkgADkgrjWvk=;
 b=iHrUwtNJ0T29R+cjWvchZV9gEtZJ2OPY+qu0kZ53SHttJh9pkd5n/sNB2Llni+AyoPykVQLCSqPo5d3Qsz4vl9CiXexSWTXG+eyoZQJu3CLdglYZ7lSmH/NE9c4Cta26UrMEvvtsqHXWH2k2GYw+bDGlauTyWMzXiTYm1o3JoYfNrmDSlZ/JDjlnnleMD6+MZqafWfcrs+ITCR6i0vDQstsZHR2gAgvE5CdGmD9rog7PjCtD7oag6j3KQibh5IGiYIJ1wN37Epf7QclebsSSIRMcnMr/IMOyQVLJ4nvU9zpZBtxG4S5+z6DWifHynt4bU90fMqhGlGYJJBlp4+rkVA==
Received: from CH2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:59::22)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 19:24:51 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::69) by CH2PR03CA0012.outlook.office365.com
 (2603:10b6:610:59::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 19:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 19:24:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 11:24:28 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 11:24:27 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 11:24:26 -0800
Date: Tue, 3 Feb 2026 11:24:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <dan.j.williams@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "will@kernel.org" <will@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <aYJLadHbJ5ynBrLH@Asurada-Nvidia>
References: <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <0472f0f6-2f13-459e-857d-d5003f2f0ac4@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0472f0f6-2f13-459e-857d-d5003f2f0ac4@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: c38b9ca7-939e-4a54-2645-08de6359e6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KkobBARj3k+3yD8QDuQ7ajX5qUyjTmTZIeW1+c5H9G9+PXOfTIFg74pcCBfy?=
 =?us-ascii?Q?DknhMGRMch+vqJNxGsiMSLF9AGEEwhJ7hCuNSAoXnksDlJw/d8Q3cOvtcMu+?=
 =?us-ascii?Q?J6/dR9jF5npbdk+DJMPUJ8ZrRQwN/3MpSQKG1IgUuuidLoNiUPeRqgAtyWtz?=
 =?us-ascii?Q?ZrpfwjiVkw0lXLYbLZns0ONF/wkTas/JqIVt1axkc8uPQTOxRv55uZRw+oAE?=
 =?us-ascii?Q?6zDdF1CHhcIfPTt/yrJflIriCxeKRHnnGPAq1C8PH5Fn/HulyIGFAGC9n/Hp?=
 =?us-ascii?Q?3m358xC97dedj2+kTNGP9RThbxclxFIQTJtmbevgKdRTqgPM3EkulN1ennqM?=
 =?us-ascii?Q?mcgHPfsA5aZb/pI3ztMFo29Hox6qPTVRWW9UAuHCUFlCOS67LHwDLFjYENmW?=
 =?us-ascii?Q?Gnd+gDuyujGQoL8ECDdzSzdqOaserIWVo8sFDdcTcZCIPcrKaGeHmv2UVE00?=
 =?us-ascii?Q?5YNrqFWbcLUuPQrPQqATKTn1ePHI/NK1BX0SMquKvzot/LRtKhNV1u2k1+7c?=
 =?us-ascii?Q?JL6hICtro4z+WGNd2bRupSX19Ouv68A7uXrWIDezU+7jC4O0NHPa8stJu/gU?=
 =?us-ascii?Q?yq097sNHqLpCWA/4rp2VsRHnjhaZpbDEJfDlv2EUpy9FFY9poWFUYp21snZf?=
 =?us-ascii?Q?gv7o/PlZ/bBf7UWySlMrZnZtmTUCOMQPk45WLfvi4znAF4XI4JX4u6n6RgzR?=
 =?us-ascii?Q?VxQHTTC53tsalaIa4HTFZ4/Svdswua4H6gMktdqciunwOQsi3NE3CMQb3USg?=
 =?us-ascii?Q?vCZ6aGS5rAc/CLH/N2jdW4j/haFWsWAi+h1SjhxCwytg5wdlVmQpvlZQXGPF?=
 =?us-ascii?Q?KfVAvOrkI892AEcMK6pDgXaOul/Ae47WFoZbajnWVrJa5AsFLvLOmFFxts4L?=
 =?us-ascii?Q?RGPr3U+p9TUuyDKlhPijAKQdQRbKXzfgDLnlkT/8JJWImrluhGb0arFlWjrD?=
 =?us-ascii?Q?R679fbno2vzlu9Q6eqCHguO7Kuk7kNHGLm9FRM8R66zpnpsPUPPuB8VLWRNW?=
 =?us-ascii?Q?ztpLM0A5SaCzDkoZs8NF7kXVk2gW0D/et0TuPbRwLElyj59p2d6dWjEobiTr?=
 =?us-ascii?Q?+Ckc67SBU89ucBhBWWXEZ/C0WioGRAa3+AiBfqHgiS+aQKm0iDlfViupKHfE?=
 =?us-ascii?Q?DhuZZkWD6oeZUM/ktEnVktT9q3cFVN8k6TGLVFmqqHGaLAoTFenFNfaqAv3c?=
 =?us-ascii?Q?UgJhDB80DI3dNHCoZ8ENy946fVi8rzRmfOFwhya01qNfIPCh0tBeGiNuh7jO?=
 =?us-ascii?Q?77HaziHh0h6Jzh+ufL5+BDd/MMyhAUTj6jtnXEG9b7ddTcvqN4RjtI1TvyFH?=
 =?us-ascii?Q?Oqm9k7J8iOa3DHvFXFq8JEaIz1hPvJvfG62WbAiKqh0JWbae5rGRaFXH+27I?=
 =?us-ascii?Q?fCMRLJeMRr4CioQ0fhp7Ahk1zgzLoTANp9Or2kauZUB5swOHOuERdNo14BcL?=
 =?us-ascii?Q?Rh1BBNkDuYPazXGmIkvknErBZiAaloVCXclSSycOoZn0JNpl4vpp0sLACijT?=
 =?us-ascii?Q?LY31/nxRXI5/l1noXuCc2KKJNbOa15rvqkVUg8arcOrVAY6DCCTQul9b7VfZ?=
 =?us-ascii?Q?PH76jDHneWQ4lLYC7PRwPI3fXOEQ6zxhKCL/uzbBm80jma8z97Oyohsa5Svu?=
 =?us-ascii?Q?Ok8WE0O5QcRPqO0l3ZoFL8iSCY6inamW9cGEfz24kBMWR/WdfIkmENnTMntS?=
 =?us-ascii?Q?S5I2ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gJiz4pWh5QKwVbvRDRCqY0udoPNHXsaC4lAgIO92ADiaIj0YkV50qY+yUQfNO0WZtVJRn54kk9/NjNzZXp+60AZk3saNGC6Imu6r07mW7GtF4obY/DEkNQI2f3aD42yhd2Shl82c8sgmI8D62/S8TqCbxCUznkiLzvUx04ppkbfNXejidhiGXNQBWm5SskRKKtUleyK1KyyR41PZPIIzMlazAJ7MY9nVAPN+pkSQa6hYgTsXWQi5lmUvqatPlVPVUF++jAQhqiy8PZwSZQ/bnN0oDrV/gN7z2mTKF3UsWTKwC6XTb+Wn5x2MIvjvsDzLhrMvcF1Z3YsY8wLRP/9j/b4fylmBfL/KCgWrkzJ5Sm3QNPY8meRtBl+Z9VSyuwNMRQODQtsQvv/TEg17dRsPlE9LoUlhmjeO9KKeiKJmbQTd1gYYw1b1wQHs5LSRtZNO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 19:24:50.5640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c38b9ca7-939e-4a54-2645-08de6359e6b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

On Tue, Feb 03, 2026 at 06:59:35PM +0000, Robin Murphy wrote:
> On 2026-02-03 5:55 pm, Jason Gunthorpe wrote:
> > On Tue, Feb 03, 2026 at 09:45:17AM -0800, Nicolin Chen wrote:
> > > Btw, attaching to IOMMU_DOMAIN_BLOCKED/group->blocking_domain is not
> > > allowed in general if require_direct=true. I assume this case can be
> > > an exception since there's no point in allowing a device that has no
> > > driver yet to access any reserved region?
> 
> No, the point of RMRs in general is that the device can be assumed to
> already be accessing them, and that access must be preserved, regardless of
> whether an OS driver may or may not take over the device later.

I see. Thanks for the input.

> In fact RMRs
> with the "Remapping Permitted" flag are only strictly needed *until* an OS
> driver has taken control over whatever it was that firmware left them doing.

Yes. I see that doesn't set require_direct.

Nicolin
