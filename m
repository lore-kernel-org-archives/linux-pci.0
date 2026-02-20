Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BA22DFA5;
	Fri, 20 Feb 2026 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613379; cv=fail; b=QQLcgfKFcVr+DqDmW6D6YrLnMf0qSvdP0Mhr6i/VOXEBng3Cjg1B6doVf6wfP9V6Uz/SxyheVCv33rAP4c47PxthgR5+c97ACcpqkTAHgtBtADQI1DPmhRSNzlI5U1Dij3PKfB8IkdTkkNdv8FIuY7wAG9iY+Zd/i0PDdhPBAqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613379; c=relaxed/simple;
	bh=VwaNWUkO2EmPwxsPrhzb8k9d1XccC0xvTxh9CwT9KKE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV1yD62bdFOFV3h2XQFlYrkMuGl4caJfCg0gjlg1MLo+VpZ9FiwxjYM1/BgsWy/Me1AGbJzZGwkyM3YA42OwXp/BDTyKbFjQhMGj4EkOyxjU7qh7kpK1N3OPFN/49Gw0KGbwAdqBJkI6hdnL0PV1hRg6sBCxaVgkFp0eYNnuGTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tj5Ka/kh; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tj5Ka/kh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4WeE4c8czsh+RrzQ0HqRZjaiUolsWX9hktR6uFM+xhwkVBFXyUcKDC6TxZE+H3l5iNdXowIl2HeagYmcPIcO/kGJcA26SPGG0/Afv60eIylCXH8//JE2B7j7QamnzHVmAdI6N8TBFzxkp2yh46Nhv+u9Xv6uHdSq3/8MLul2zeW4i9cD246JYwCcJN3U2STp3MlpLGby+c5HdX2j3A59mBP8XHK09R1HKqHaZ7BAGqq8EpI6Ti1WIMVT9uFBJgzTf4nJvS+M6EnEVVz6PMjrxvkqQHKL65g3/VbSwZacHpacyNA26b0gIV/pboGY+RzeMHo90nHvVRZ6/wp6ArICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PsBxUqvCGuYsoU3vfsMLDsvc5Udr3Xx3REiZHFm8wo=;
 b=aJUWZ3GjBBJtk/yodJbU6fw52rx5oxbNg5O3EPRVM9RZK3PIPfDX98e1Mnsr/EUM/BVIDWc7w1Za9u21PPMLpVSTblFW2iiBXYl5zLxXSEy9OxvoU6KSSOqr+dbN/uvfH/mLIdiFmsqsMt0eW1ScsyQLFKPE67k/MWYt+f3WNlE393QJAaWp4cz1+YRbs0e/pddUjTjdmEj+hVp0pajzxVPwyIuNHsDjJObj5O3lzIEop7+f+N+0QRKcIsRyU3nOYy9+3Qsq+0PHc4t/3aIhfXeBxuefQQj74LMx8aBPyozjkzRV8Q7AxPEHeFsLUZsZ/EhuHU5VxmS5nUXaXHstLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PsBxUqvCGuYsoU3vfsMLDsvc5Udr3Xx3REiZHFm8wo=;
 b=Tj5Ka/kh0mkFPR7XAamRlPmfXiAgJ2z2p4SjzAJtjznlwy/UgV9hZ17xx9FVrGUy4XchNkhpcIlAxc+CWnMzcGBD0bi2E5AcSQRBYHYWvSJOveVeTxfsVIY8cM9kk3gQz5OuYZhYOOrTnlv/GULsuo819zAiQ+Xudyx9dl37xkiFCO7g5rJGUo6kcZurRq72LjuDQBDZ8zPvKfVU0uQmmeCMHs2yG3ogcvND7AdSW7SFdTK6BXRh6MYofzHXc3H25R0fV5oRbQUe3dWgOsE/lk1R+feDZp1gZICuWkeVk641Y3ty+ltFnyLpPpMRVLf8mKErM1gnEVNlCqoFOzn1YQ==
Received: from PH8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:510:2d2::18)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 18:49:33 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::32) by PH8PR15CA0012.outlook.office365.com
 (2603:10b6:510:2d2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.17 via Frontend Transport; Fri,
 20 Feb 2026 18:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 18:49:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 10:49:14 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 10:49:14 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 10:49:11 -0800
Date: Fri, 20 Feb 2026 10:49:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <dan.j.williams@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
Message-ID: <aZispVftDE/6u+Xy@nvidia.com>
References: <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com>
 <20260219143737.GG723117@nvidia.com>
 <aZc//6kvH3Eqfwfe@nvidia.com>
 <20260219174139.GI723117@nvidia.com>
 <aZfoqETxb31jp/Pk@nvidia.com>
 <20260220125044.GK723117@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260220125044.GK723117@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 247a4844-3ab7-4fad-ea0d-08de70b0c996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S664xDXtqi5MuuSVUTHkDloMbBcOy55t/4frUgyYqrbJO2H2jAugiZZwq/7g?=
 =?us-ascii?Q?xskBG+qjhFNyJIEDLEfwu2lRE4ZXUTq27EYJ/30bADEiOKIjsuXetJPMpheM?=
 =?us-ascii?Q?HmzZo/NeCKIocB6tfDNH+Z/CQ+C4mKa2jvMHXIaorIbKStq9gW+0lUgh2/kT?=
 =?us-ascii?Q?5irO1OSH54qY4+MALEDmEZAEUpvZgFQE65JVunKQ401MQw2hoAE5kXwXxKVq?=
 =?us-ascii?Q?4ZKPWOUjt/Cm5KcB3jW7U8X7JRXdmnwaibIu+i3gjy1H8l2z2W5Go6G4HqWb?=
 =?us-ascii?Q?Cu5z7OlfvWxC2hHcqNl1Z83e1ehBcV56vtv6DwBmNoSHZDDPZ28IDRz+aVmB?=
 =?us-ascii?Q?11MxHHNzklJpD74tRTR6pEqnUluqfHirn2X6SNnGZ13g7mJU87Q7Q6S4IwZw?=
 =?us-ascii?Q?y7NbKz1dd6snXKCYRLu2PSOEbPCf3nsaZAfUuQ6prgORa0r0AprgE1VGFg5j?=
 =?us-ascii?Q?yY7ADmddkPN/UdCS4z7BrMaLC3JGc+cpXjH89F3ZXE7OTdWla5ojBGHlSVdQ?=
 =?us-ascii?Q?7EPj+hhbilnSQzz6QJGHohCnG1CV+XRJB4pFH6ZJiO05mWdlRBvD/mQzEwVl?=
 =?us-ascii?Q?f4FnjcHO+2/RVyMToUnJ+oUQ01bzfaWsZIwBjW4fxgg2IiIM4eEihAwvuFVr?=
 =?us-ascii?Q?mNSeCXDREwwFnJK7uG6/+5VN/vjInq8LiDeGPyXrXonW7nR+mZ+ie6jdmP1z?=
 =?us-ascii?Q?8kEO8Vi7EwGDvnN7hoHntIFSUQ9DPe5yZJ+EQC/it2Bd+qWcQ6SiHz51BoD1?=
 =?us-ascii?Q?9eY3GrAbVDCeYHVN00sR6Wok8CBnM1k4cWXCB0+iQdhicbMo4elczkaZyxI5?=
 =?us-ascii?Q?DCFxK5+PphtvFDpfWySnSRgWqIaPz/doa0VyIn+PZZsZteHyXxCD6kErmbZ+?=
 =?us-ascii?Q?ubysvlSzAD1YKJ7KETlicNy7IEkKtX6EvnteJTf4p38oCOWlXl9cWSIPCEPP?=
 =?us-ascii?Q?KehlsuFfrOXlKCKldsA5352SQbb8qPPu04uACuj64bfdUkbo+Zl588Tk/KoW?=
 =?us-ascii?Q?N53JwomM+dzlK6/IhVlkDtX16A8vPACZxV6Cry/TO8NXu9hifS6l2KlvV+N3?=
 =?us-ascii?Q?++/8KexNbD6wTRrd5JnkA1joVKKeXiwlb7U67jTTmWuYr6K8ye0x0jxpAoqk?=
 =?us-ascii?Q?pZRGt6jJ/Vrpqoftnuv7+ZJGoOGRrH8aCxkOAqYdb762MlCBJjhKEzWVH3B4?=
 =?us-ascii?Q?ngQ6n1LVcXt9Ms3rO6hnM6VlBX5jjSaUTBqq9Fr+MSN5ZPBdQCmv0wD0o2/N?=
 =?us-ascii?Q?aN03JwRRlRdEnPcpxEsen/NTpP/Jj+9aojSwm1TAN6UmI1++mNPWJ/X3c3Xh?=
 =?us-ascii?Q?ClU+P5veLADN5jcdU440nNfsjA2y2yz3jBW59rO7mj3Lu+0AFyHJvYfvyD5h?=
 =?us-ascii?Q?HyTxwXwMMlbaoh8HxesLr6nkxieWIwpwgpAWZqdKwW0UrrB5H8ySVydwChWn?=
 =?us-ascii?Q?ACGAbohJlypExsejrsle3MLLdVajv3VHKTWQjOSJgkW+wfdMgq+GAey47ytN?=
 =?us-ascii?Q?sb/EWaeswufbMuutPGaY5+nXRHgZUCNsbWhjJ9uJp1F5Y+H6i/LGRsW+GFFK?=
 =?us-ascii?Q?7tVfFmFSnQ6U+OrT+DQElS1KK9P5dCk0wJWJJx1HgD4JzYmy8Ajp6XbRn7JY?=
 =?us-ascii?Q?Aqk52vmlzeSQrfYYJknC21csvIctynYCu/RCLGMhRkKDyjBVKZmvjOltnWoI?=
 =?us-ascii?Q?Ke918A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5eBJLSaFc78f2QT9QENVIDMy6MQtmiAjyA74+ONRyOHUMmDRHBO+sfvprliV5/Mv1s7Q8kkU/wm/PJMqYuS2DaLgU0nmdLQD/yw1lsapzJm9z9V16Zm/X+/5tj6y4vuR6xRVMGRU/Hn3Ui2smLVev7t/BgwniHSWDUJhnnU6XPhuKw1LuvFuXgaqhT6IN3wPP/QPCCE0FRCjlYXCP/87XrY5amAGcl8UxluqifKyH4QOmu96ZfcYXQ7h1NWtK/myJAj0ij6DdIGgph8To8/yjDsKwITMpH82zC5xzcyH4HhPJpb2RNNMsQtbZEwHQu9YlKvBka9sNbzTfib+VJ4M/ZjITJ5QnFFv54Yawpsv4KqiUcwOzND/7yQQVNqR1zPchJ+Fo/qqSDBYZ8LqqJlCJ5RittkTU9NGifeqc/sYA7rwqdOgbtx77BKyXUC27PeB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 18:49:33.0412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247a4844-3ab7-4fad-ea0d-08de70b0c996
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

On Fri, Feb 20, 2026 at 08:50:44AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 19, 2026 at 08:52:56PM -0800, Nicolin Chen wrote:
> The next suggestion is to park the device in a real DMA domain with an
> actual page table and DMA API hooked up. Now interrupts will work and
> the domain is empty so there is no translation. The issue here is the
> domain doesn't block ATS. We could fix this with some "disable ATS"
> domain flag.
> 
> In either case when the driver is bound and requests that the DMA API
> start working if the user requested IDENTITY then it has to be
> switched away from the parked domain to IDENTITY.

Thanks for elaborating. This seems very orthogonal to the issue
that driver_managed_dma skips iommu_device_use_default_domain().
(And I see you discussion with Robin.)

Regarding the empty-DMA domain, I have an idea of accommodating
ARM cases with an IOMMU_DOMAIN_MSI_ONLY, which is essentially a
paging domain that only allows IOMMU_COOKIE_DMA_MSI but blocks
everything else.

> A final thought would be to change around the driver managed DMA
> mechanism a bit to allow drivers to indicate they use IRQs but not
> DMA, then the bind step could switch from a BLOCKED domain to an empty
> DMA API domain to allow MSI to work.

Yes, "driver_managed_dma" is so unclear in pcieport case, since
its driver doesn't really manage DMA...

A separate flag could be clear. And the IOMMU layer might do an
AND operation between driver_uses_msi(?) flag and another IOMMU
device-level flag msi_behind_iommu?

Thank you
Nicolin
