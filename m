Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEB397E77;
	Thu,  9 Apr 2026 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774756; cv=fail; b=VToO9wkUBxsnFmnPdZbxXGWnXH5FyM0+hWX51nI6ukjAaW6wrRbKcPhS2+ew5zvHUCNAef+KYZwfc/Apkhyy532H/g3+ip05hI+wBTumBKlW8tm+HOa5qMkOLVEtGr2132FUTK8/uJl6MD8QxqSsQMHMim66pF/nLIX6Lka8tp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774756; c=relaxed/simple;
	bh=C+3jx847XZjRzyWwWbaRWSfapBlQjPyL++w9iwptLFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFm6CyrQwcYykKPZ/e1Sd173yc2htJzFqgMX6K281TMes2BUjbwPdC4PBT7wn0RCZzD2rLR57FBRjwaAf9qTKtJgpiD5txtJd+vAdArDplp7NkYisTlIUAP53v3zqWXHZ3+NFWL3TyKPv33TkSEUt8q1nmONvf7uecVxDeKwUAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FhWGRA0v; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FhWGRA0v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zC8Asoegxc5Pvsxlv8FLeturxjSn+2b3hIp+Tsk5/w8B/SZ4OVaocDWNkU03iu7caG7OMMOl6sKvPnk0MuborXFoyp9uf7qv0GzldY0HE5Di9S/cBn8TqthoZCDYlo8ogCjp6uLMwbgerl/9E7bsp/CwbMGQin78nIUOkgaR9zZozJOxgmg3FLzpuXlIRlSkJFWWbASDVNGYNpMhWUrZs888u2xvb+152P/Mc6skuDQ/vfkBhcoyFXajdSmUssv2VPBWuGaY3FghFb2CJEstTx8+x5iYc0Pb2plt/cn2bSQnD6o7KCDgRfkO2fXVOrw/y4ueCMm8awADwk2ynarNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me/OIO/1PANziuyvM33f8krzkyLdR1a4WHdYNDlGjpo=;
 b=QvJS/Nvn3c58qr+SUIZnVMIt8IEYCl8hXdSKkH2lKlh1xoYrEXbq11xCeONblwaMSctJi5dSBtvAT8mVjxKHQZft5xGIRvEVbpmnXpSUx5OmWIddj/LIQHeUMS20+OrxveRpmG3exWQDHI+K0LrSUf9Md2C+U+33id24yJTMwc8gBKMk/Zxnfwf83bLwpehB1kyefPYbJHC+dFa7xROW3e0E3h2PjrvQg01QRGsE++ZCB5MYGOvazvH65CiEAKAkG6SRnS68VH4qpaBmq8XvvmRP4+bReD1u3Hqp8ShthS6Svrd8U8gjGFyb52KeLC+HILr2C53HXMkMfOkkAg3Rig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me/OIO/1PANziuyvM33f8krzkyLdR1a4WHdYNDlGjpo=;
 b=FhWGRA0veLqhQJPxddfh28Ig+wDAe8CNkV0usJH+6Np+G6Pk3WvmhbHuYXjueeC4fXQ5kLfGptki3PVYkxAy7/wIVjaIPTilNwc41QaAwGcIRXzxaiPuZqQ2YFfX9Kp04xt8osBkjplSzMIe/NtzZPZ2qugfC5nKPN7egTlMMQC90+b6Ro350lw8iN9f6YADu6GlkPK0ptZYTAM9Tt5nD6B3i0jcgYSEZDRAoo93lWu+fs+1MqNCqcjNwfX6Byo6+t05/fT4n7D61RkPEksk6M2Hh8PUfMarQkqTelNuIBnCyn4Ht0Rlu8zP2hxSG895sbsWEx7RQumwX32i6OKlYA==
Received: from CH2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:610:51::31)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 22:45:47 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::cb) by CH2PR15CA0021.outlook.office365.com
 (2603:10b6:610:51::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Thu,
 9 Apr 2026 22:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 22:45:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 15:45:28 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 15:45:28 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 15:45:27 -0700
Date: Thu, 9 Apr 2026 15:45:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "miko.lenczewski@arm.com"
	<miko.lenczewski@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Vikram Sethi
	<vsethi@nvidia.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <adgsBgXYy68GmxAf@Asurada-Nvidia>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A6B1B103C4B0201458348C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A6B1B103C4B0201458348C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 8540e8b5-2729-43e7-cd57-08de9689be31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9Ga+IriFArx4Lg+yse3Bjq5Di0Axc0aEJRwwmR+FDgUjUhgeOnuZWQftJ8LGBcVS4KqASSwjKmd0drqn1ZSaBxAMSiN3K7XVoFuhlgGoWcrGResfr2kzCHicxRIYV50h+LH+U4rqzFCkcGayXNFh7K3AoajWIWkAUAWj+gQ9alww4kElh835I8EPmL29FgA/divgqUwY5f+fM0qPZyDqb94g0lLsemgrPjPswYp99/i8QQWe/h+86FmgZhqRzGKS4W3NsBtLYtKJfKk+1p9w0pOVzCLVC4b5PyuyWXxXaYhbA4CnrQgYNWqMN9317Gu+IPuXtNKq1TUI6y47qPBBDeDQHpZsyPRi+ojqr8/yC0+tdY31SvLxJKY0wRprPfATG3Roo+Y+YRrhWFFOPSxDwjppCKinsCkvpwNM69Wfqg5Af/D75jx8litSN03nzDiO2tF3f4BkOyr29ZA4TBg83RUINvyUvHwwzhRXwEnzUCM1YjM5us1fK49in5T0mkUf4eoboqiNSHeGdba8u7FLRzLMGHrCd7043+bihkDTpwrFH4SLYH4uSsQhRMpN3zVCnMgaxsvlyV2h81RFt26kTjeGg00b/Sk3gHkj0Mf+eEv46ahXil5y1TQf7OibTOCZR78uqtqtL3ummFnHGsGRdUhbDCCT1LOKLRQMbJfHZg6E2/Rsi5q60AoYFwAJMtn+Dqw0HNhXPuQFYyuArCRJBou6M0HldHXPGYQjOnb94IUfWamBz4UAB2PTgKb4uBuriK8I+QPQ5OHTiyWZgeY5Uw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+a99R+uzYKM4IVbwR89RVnLaRC5fNalNpBJpm/WVptFBREsaKk4OmAm3RGzd3JAuFu6BqVGkNgPjihjsn2Zy9GDJdsuvx50CXejJh9HaqT7+UB+czuSpFrIlGAcBrJMR48GSXNGUL3mEtBTh9I6NAMPb5ycDMXW+5v3YP8zu3HrJZiSsDLD2uVo2Nql7giDv/gHgiJR+zJkwWJkntyVtambYh81YUmM9YbT7/B4BVqXj1z0qqXZHhsHgDPY3tenxd2Yso4lPTY2oducY/1ROX0yXVp8HZOyh8FB3V86gYkQu8tuZ0xAJsnzvfR2yPyT4tRgDUzv99kK4XhvwtLeThE+9bZa2IOhXVtHcPv15hM/+7AYHWdX8Ca1b+eI0wiN9yR2gGFOUREe1h+tavLftcoLdY8q//jJqIPLQFsfYhxKzhQNptoxg4q8HtmDaYRr0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 22:45:47.7307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8540e8b5-2729-43e7-cd57-08de9689be31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

On Tue, Mar 31, 2026 at 08:19:19AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, March 7, 2026 7:41 AM
> > 
> > Controlled by the IOMMU driver, ATS is usually enabled "on demand" when
> > a
> > device requests a translation service from its associated IOMMU HW running
> > on the channel of a given PASID. This is working even when a device has no
> > translation on its RID (i.e., the RID is IOMMU bypassed).
> 
> ATS is usually enabled "on demand" when a given PASID on the device
> is attached to an I/O page table. Above sounds like there will be a software
> action to enable ATS upon a device translation request.
> > +/*
> > + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source
> > requests on
> > + * CXL.cache, devices need to get the Host Physical Address (HPA) from the
> > Host
> > + * by means of an ATS request on CXL.io.
> > + *
> > + * In other world, CXL.cache devices cannot access host physical memory
> > without
> > + * ATS.
> > + */
> 
> s/world/words/

I have updated commit messages and inline comments. Thanks all for
the reviews!

One question regarding VM case: if a device is ats_always_on, while
VM somehow doesn't set nested_domain->enable_ats. Should the kernel
at least spit a warning, given that it would surely fail the device?

Nicolin
