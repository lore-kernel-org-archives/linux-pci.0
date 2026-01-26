Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FE29A1;
	Mon, 26 Jan 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452867; cv=fail; b=s5i3ohsWLc9k2jL/3wwQ0r3NDs/ExXlXwEViZdQQm1nrtuhUO6VhP/UcrNUwZ9QpahwWR9jxEMrB/in79bnXxlBfZA7TilobEh+OZPJDC7THMnWdu/hDPYybgXq+owHMLWYydFNW8lyFXhP3/G/rGbFRvgqubOfOjcX8ruxUL+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452867; c=relaxed/simple;
	bh=uYE3c6C0rRlpwsd1WiKsh2IJdbI3bTWliS8ruYT3goY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbF36MMcp7Z3CYsb5G/NOE+ZXThhSk26qYqQ5meXr8jbCl0itVnmZjbKtyppF21CUdbH1fjIgxPeCL7y6FMaAE9WFo7UDVrht8eD6QOOwaTTYfxP3PQcGCZQm/XP9QwDV4FNz7DXQQArWQymr6MkXYZsX2eWF8NkUvJpMGXe24I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sVtgFUwL; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sVtgFUwL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fv17PY9KeZgXFRKw9OaYlZZvay2yf7uxYcb7YgXeOHkrNwPEs3wWuCuAWu6XjusWOFV3Rpo8glO70iDvdAXlINi88yXtF/SJXVnGXftIvuugsx1tgP/7Tfutnkb8PqqhqlRI+E/BVmhP1EdmhEtgccavpf6GMiS+EVKvNXmN5tRF5xCC0LENSD9zUR5VHszXXCjPuhttr0QXOmLEwoeDoQWe42P9kxYsEmJJMCSTkMo2kkKxMpt3Xf/DpBuEBvhhbpr6XgM4ICsce3SfhPP0Y6MpEF4lvRgIS1DPmLtIXlzKRb+TW0VakDPv1U+DLCkUgX/YiGjjdwL5IifflAoKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K/o3pEI17vVdEoS4x3GNfBAh3K1FMxWm9mjebWqIVE=;
 b=jF6D7OUiHncJLjU/d7bSUN9CqmSCchcd8ZeTD4nisMKiiaKrGt2V6LayeVdkkgVFbkrJPAVdJE2IK6UnrX1adEh25N4VsdYErI8kADrU/Tda3ieSXC82+cOZPqRpOp01cssAxQ5tpEsyb8FwAvTmDu8+dBkhf5DuF5tAn4Lxfrhfal4vh/E20CdDfPks269zqnKMEooPJoGj5QVYgUqci+tcb4lJeAA3onhFF7MUFB9lkkgVunUtdOfKj2ClH+V9r38zZvUt/KIkUn98YuxpQF+yHnwHyGRauUp6c/SOUzRHjx6cJsEVOPtPLj8PKCudWJCX5rR6LvgyufMxUN2VPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K/o3pEI17vVdEoS4x3GNfBAh3K1FMxWm9mjebWqIVE=;
 b=sVtgFUwLMyQrYoBvdW0p4sbBvZJadNLVeWO2BQOJADO+SJRVmt7WL7ISlBIkSo6zY4OFHz+rQX7uv7c8QZaNeBu3u3vb8OMQWDRni96P+qm4g+wtsrBaS2tiWAKs2NhCKvxDn9QBSZwpvfdrcMnJxxs42EqNsA9n12P6dPCe12JvyjJtqghunB+NADFgPmpjGRU+2xNpj0VC+1LOLGMsIms/ZnAKYujJ4cW8XgTtkIqamgQpktGdaBaEfScbFACMp2i9bVQaOYRSUeKi5lcuyBPb3GSNVbxf4/2M6SwmWf3GxPTZzY12wSbeGGIBEQLT48mVEN9RZP6DiEVNCNENWA==
Received: from BN9P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::11)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 18:41:01 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::91) by BN9P220CA0006.outlook.office365.com
 (2603:10b6:408:13e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 18:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 18:41:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 10:40:42 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 10:40:41 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 10:40:40 -0800
Date: Mon, 26 Jan 2026 10:40:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <aXe1J6Rygrvoz/Wo@Asurada-Nvidia>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
 <aXdgljWHHPVMTmya@willie-the-truck>
 <20260126172020.GP1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260126172020.GP1134360@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 8337e1aa-a51a-4bd0-364f-08de5d0a7471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VdhNOasmi3T+LZCV+y9reHW9UBEolcVltzg6DeMGe7wh9wj6ViSXEMVytv51?=
 =?us-ascii?Q?3pKs4qOEFEcI6KQIeCvxsX1919FHruYa9g+Aw0X9uB+2JFu9oZ93q8Ht2xWD?=
 =?us-ascii?Q?GkxWvm7FGL2LAwKhfxTLL8FzHFEo+X+5KWIaAjwh58KmtYrEGY3I9sTp3au/?=
 =?us-ascii?Q?Uor1c+mIJx0YI/uz2UwyNKmAlmxskY+EuOeEW/r5en05ttocoXArHLiQN4rk?=
 =?us-ascii?Q?FeBISElJK8Cm6C1x7OJVxQqbFNZBgWvuWzxb4uWgyND8nFeZcuEIh36AjeBQ?=
 =?us-ascii?Q?H+JcUoqcKFnXmRX0B9xTch76a1hg0eH5YsIloUXTzrr1nw4Ims0PA3AbC6QV?=
 =?us-ascii?Q?F4b51Lj4XjojGn6K9MW3PtZWb62UELwqvSTAxfPQCJ3HrV+mA25Z5sh5NIKA?=
 =?us-ascii?Q?RUmwekrRSddMYWfBoBetKeK8vOc6ZStN7LLhbIbnMQSDmk1JL45wgNVjOAEz?=
 =?us-ascii?Q?nu0JXZeGDmG8MOpi0+MO8p2GTeBf3VUD1JFHDTZuQBBEVs8575hY3a90DJGr?=
 =?us-ascii?Q?d25Lxe3JUlL4iPoy+un/rZZ8a1Y6A9iMYj46Kt+Xrf4Y8MRaxrrrrinow2JP?=
 =?us-ascii?Q?ac9tYuDwTocz6g62R0Ugq1j6EeikJ95nGOdKGztLpQ7HCY7RMBJGw18vm6IS?=
 =?us-ascii?Q?km/fWte4r0UL3BE9B/sDEfNdTKJqDwj3DStK5kmvqitp0BUiggJirIpqZW8L?=
 =?us-ascii?Q?1QpxMkiOa4Uhpke95aH5nz3DbgkmE3lQe3shxZX2FRGbY3ox1YxiEWoVeYE0?=
 =?us-ascii?Q?qZWOuG7E8XlN7Q9St/eia6UUgfoCLBHuSkwE/LfiRUfBicoQSbnEDx9PNqM8?=
 =?us-ascii?Q?iGjioirynkk2EFpy4xGgyKeSZDpXErQbseLhE/bYkOHbxzah/0iCNSRZdIdt?=
 =?us-ascii?Q?r9mYK5hE/iq7eTL4zViNTDoygBYfQTJqJbbbk6Bdopwelxr5/LomxFB6sIxY?=
 =?us-ascii?Q?frPqDOSRceAM/37wP90GIobFpXFsBO6xj8a7ub2BmHGUEO8asjleYxAZgGT4?=
 =?us-ascii?Q?XpN3MA0RHtRgqBNfRvBJqVj3tv6ru73vgd1qd3ZqpTznEjamS9+UBssIAUnI?=
 =?us-ascii?Q?gFwhpOjjs14GS50TJs9LBWqiL8AMDqi84seVzju7kvHv6rbkd8gKoT8Y5Mun?=
 =?us-ascii?Q?FnU1ODmg7+WC5AgXuGxu9OK8XuBoGw8uT+LJUSrtzBainsB8Y3lPKlsDTMQi?=
 =?us-ascii?Q?O0fmnyiLTEyW8i6+2jCbdZxhMbLnx/HqOwASXiXQYhfpmGBIWaTePXU5lddi?=
 =?us-ascii?Q?BQT8/ynvTBzo872kEeFFYHIs2NykAxaaQ6XmQyYKaBrTkam5sxQiTEnMYdCN?=
 =?us-ascii?Q?7NcWSzapGZOAJmODkXaLHIS6z8ESc7Da9vdDRLNXtQMT4yLfoVDwVsTvfhUw?=
 =?us-ascii?Q?zhbpX8QPIsMxayuyNw5yQwBUFMdMq34WAytza0SnfLPx+eC7oPStkw5jlmEE?=
 =?us-ascii?Q?qiSTi3rDmqrs9JH7CpdceCec57sG7w5m4+anEnQQ8FbWihowuoRUd/I1TKwM?=
 =?us-ascii?Q?YxYWCIr6TZwkmDig6jIiQHX87w4Iui2zK321MYavlxh/gZjrwHLoMF/VnRqJ?=
 =?us-ascii?Q?lUgMKly+fe6pR2NpeIxt0aLNJN4jFeEAEIAGDxgVSCSYlec1QQCroYwL9GHS?=
 =?us-ascii?Q?xvrwsn4o+Tn536EphyZ31aZb5byUfij7BCKxeOUSkRkyDFa4vfG0pebrvDlN?=
 =?us-ascii?Q?3ONNgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 18:41:01.5952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8337e1aa-a51a-4bd0-364f-08de5d0a7471
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318

On Mon, Jan 26, 2026 at 01:20:20PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 26, 2026 at 12:39:50PM +0000, Will Deacon wrote:
> > > +	ret = arm_smmu_alloc_cd_tables(master);
> > > +	if (ret)
> > > +		return ret;
> > 
> > Were do you allocate the second level entry for ssid 0 if we're using
> > 2-level cd tables?
> 
> I don't think we need to. The entire design here has a non-valid CD entry
> for SSID 0.

Hmm, whether we allocate a 2-level cd table would actually depend on
the "1 << cd_table->s1cdmax" v.s. CTXDESC_L2_ENTRIES, right?

If the device supports PASID and s1cdmax is large, we should prepare
a 2-level cd tables, even if only SSID0 is used at this moment since
we have to support !0 pasids via potential SVA domains.

In all Other cases, we would prepare a linear one.

Nicolin
