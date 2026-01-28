Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670B350D67;
	Wed, 28 Jan 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605531; cv=fail; b=ZfCQpmz9duqoW6A/WqO3185m0Q8zmNLrvCeEHfLn0y6xe+B3Ulfxb/HZIZwtKQRbmB42I4zorcc6rcvuoN+B9CsxZQmeizF7+/Rjcx7O9rxL370h1KMgp5+8eQ4Jmc+zGiPLMzjkamIwyUHNHchq+jiZIMu64gSf5PWfkNZmYiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605531; c=relaxed/simple;
	bh=LSE7tfrTLUbwhCS2v/s5x/mH+R5nFZiUckbZFCor2DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lT2dqOrofjOMJdl6qLZ3NqGLkNliRuh0C/JPjOX/DI9QFSQkxm15Nt9NiiPuvo1tGC0oCiAny2YnyuAC146/NzwlnKGQepb/Ixpn4AOlUezwKTNf6lDkhua2xoHQBA8M9M1wlj7HZlNS0DASDeNrAjuf1Rpncc12U3OhE0gKmVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pJqsHAjy; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pJqsHAjy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1DBhjMefr1cgOUZfZV+bo6FZTcQiXTZazIH/Xi6sy8GT2o4K84LrDn+Z+/l+sIHZyYMvuacVolvasP4cuEm3IhXoKZpC5QbSAx018ZU+I/tS7enSmko6SydHDDuU/EBeP11Jj3exxNGTxmfKCJQwAEglsJUuIYEtkkQqGXzsEszF19nsROijkfu9erGARuvNW+abONL8YVvMaHfKqyDY93iq7oVL7pc395TA6/bY+9tHxT8XIU+FxU4xDggjlqlh12fuzpEWe0V9mAh6fakCRuIqZF3G+pHBsFNpcWu3xoo367tZHPtjOMc0Rf6hexj2NjwZNoQdkQHqX8M0abXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHC9d4iBnP6d8vUklQyXq6MEfYoMZmnRC1t50t/vJiQ=;
 b=p7tJBdQnKK1EA7zwYIkcRdHYIagaJ8IsZ5XgH/4HUpceKvLPBrkUqUYuHEnt0YRLYYVLZb9iCx4Cp37ly4AcjH3XpJJc4zXUqRNlns1CSIonzruUFkbe4qyppmJ7MRdhXo2NiDkeboIC3d2K9iAkmozPdvUokJsoDFrBrIBcBIrusso0crd8h1KRRwruUQhqFJf5Zc5YiU3/TpuEn4SpcWF3Ntdwxk3WBuLO9lxu6+PGXF0jxLzfR+qkmGT1qUvMcGkacajISAOfJZyyW9WGdoS5VbjmVZcAddGoERx8d7X1SCatKwemNhoGypX+30sYZoE1TFi+EP4+ho7zlA5wbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHC9d4iBnP6d8vUklQyXq6MEfYoMZmnRC1t50t/vJiQ=;
 b=pJqsHAjyrHDV5S1zNlCFMwhmTp2eq5JvGvoNlU2OXVK5JDtckFIn99PjVojum0w8S11kQNrVjllf2MCJToNhC6X5QHDwDgjVm1kDbC8DLq/FvGTaeMoFI5hnFiUma/RjWA603mZWMkvSdDvl7XKED/dBqCXgqteRnBBdyM+nbji6D4xww67haWgW4SSJT21KIBnobGb/2WKTDzaBeSH3eb2tC6avSGHpNIwMy1U4CykTGn3l4Lw9aowQGPuTMM5APydTyGFhcBhsq3jHyGmYAvyCvcVZU0NAoXYbFfilrANJRwc4Mef8lPUJUkC1S4at7j+CHHF+J/K7MDx9uRcELA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 13:05:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 13:05:21 +0000
Date: Wed, 28 Jan 2026 09:05:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: dan.j.williams@intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260128130520.GV1134360@nvidia.com>
References: <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c7e1d4-93d3-4c2a-f824-08de5e6de45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q+HsWzlEavd5Nje5RzRLtXPm1ZM6l3P5Jm2Ic8wYhw4zfANx0KS+o1UfZ2kR?=
 =?us-ascii?Q?LOqWkDjTTUdMwNt5o3nHNytdutQZcl+5/PtTaEtRoxWxR9TfHtvp+UFbcISy?=
 =?us-ascii?Q?544+qzO8hxjs6PhxSqbIHbZCAf1/lcDk7HjV0RAlOs39RHLJHeYLrlSujPD0?=
 =?us-ascii?Q?pqbWlMBBuvQTi3CoOc6BfJLp8sGix+CwBO9wO1XW6tfsoeYsxPn8IwB1oXdZ?=
 =?us-ascii?Q?RRJtNHT5iZJaVu4bndZyDB44hoFP+hKUamUTPLQKutCcwf6hZTqltEgXIyYK?=
 =?us-ascii?Q?MRC9frg/XcMXmos6DfQKjDDxfl8OiNJ+KqEsePK34MMmIdQNFxlSGgqGQ6sI?=
 =?us-ascii?Q?FnobDXaFuobHDn8lYTOkPTiTRZRQ4s1k03nLToTMtLrX01maptm7cWUxDsuJ?=
 =?us-ascii?Q?y9/XtVmmgy+OK/wpeZMF99UhZsJ1x8nRGvE06K1tUS79mQ1g1YFr/h9PyK0P?=
 =?us-ascii?Q?2QYlt3ciGSdNp8WWPIx8MZ1Hiv2xwApeehYgTKliuMecMdcnQXjtiIttgMv0?=
 =?us-ascii?Q?jJtjGHz3E8tJecJjBqDXEsJzJ7yCQZM4O3y2x86V5qMffVqsV0Ojy35bCWrl?=
 =?us-ascii?Q?8j3bmy82Q+cvP1a3Ho2Pj/To9at4rATBUJpDQT0CHRNeZWNBtHkFS3QaXB6i?=
 =?us-ascii?Q?w0YDnC2uubRbsvH1AP+gwlgHeaelA1A2RVHjJFX4UHih4A2LfsGrRuY4okoc?=
 =?us-ascii?Q?0hPq1+BqpCb9GQ5yBNCT32nWQaZPRRMMev+MjPdoJjPn6bqA3Rj37bfLtf5H?=
 =?us-ascii?Q?InxGkxsQ5iS4yZimtowUJUHVIB5hVTwvkUnQdPgYnPVjKxXJG/K1W79gGMxD?=
 =?us-ascii?Q?IjBJfftrEJeCOC0SnLr9MGmqzYCaCyMiZvq8JtSIuNTwXACChLQOP0CBuf9A?=
 =?us-ascii?Q?jVPQt/h3ZOUm9cXq0ML0Wn3oXb0Ov21wHygThyXg+9OvNKSbkK3HlgEHHJmH?=
 =?us-ascii?Q?0KKIkZHMzpprjrG1r3+UARTnWMy9N5PdfXjSYo8OkK7pKnmR5Mr4f1kxW3Ch?=
 =?us-ascii?Q?o5uoVqnHqV8ygP5YjpdfBduoM+KQl6rmYOUjXqUcSG+l/pX0MqSiquar21h3?=
 =?us-ascii?Q?wVNE0IkruhKTCAQ4PbHyBjB5dbFyQtlXCpzcCOMLghZqKnC8YfdZ5atF4iPC?=
 =?us-ascii?Q?wYb3rLaLZg8UgYykeMndQ8o5cmLk0/mlN2kT7SuqcrkRaxOQCYPv+svZWwvS?=
 =?us-ascii?Q?f9O5kz2CdCfe6hYcYypmsXQMV4aj30VerbmAw0k8xV5bn+y/vmBkERX9OrWq?=
 =?us-ascii?Q?kXV/K2iqN/uz1RjDaEEu/7NlO6GQaTnUqemK1SR7eIJotNq8KilZr7xpsEgX?=
 =?us-ascii?Q?mrI5SVMSuBIdInb4YDArSC5CBCX/UFAOBuAe68sN4/Abog1SjTj0h04EwGZb?=
 =?us-ascii?Q?mMoRzdQqqLKPOspSOPP2Bz279SSPmB2KCx5n0I4Kcxmc96Hqh780Zs4evn7T?=
 =?us-ascii?Q?dEQt/kfaWKoMh0bgC58KTAc5WQik4r0a9w5T6YQeozWXk4Mu0SOf9Dtn9wVI?=
 =?us-ascii?Q?XbyKSwPXzTyfuhAfVIlxx4HZFp8hWhymHAaXZify/8EouazcD3y5O6lh1hN4?=
 =?us-ascii?Q?jGhk/rBSHvJMX5BtwP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tkbg5LGrWJwXWfjTakZDZA2L06sxvnzJfoLYYpJWwP+yCnyVkpTocJpb0Q5M?=
 =?us-ascii?Q?Zh2mzhidvBDh0Sqee2DygaZU4yRA+ZmuFt4QNbjvNBm+jQeBB63FzZjkemXb?=
 =?us-ascii?Q?mIdyomQAGUAZiDjTckHZBLxGCpK3iNAMW2G+73KSSV4qpK7c83vqpClunJGj?=
 =?us-ascii?Q?IrGry2O85mFM7v56vqKaF37sFxBVLBdtmQl28BjAt9tWSnKGu591fdqdZVKz?=
 =?us-ascii?Q?jXVwqqQs2kdfjhig5baP90T2pKOwe+1JwKi/HztL0d+turPJSS4YMNMyP6/y?=
 =?us-ascii?Q?g6NYq644zToUaB//qbWHCIKUEOXzgOXYX5rZlw9o55flsXFoW1BZCi4qqpVC?=
 =?us-ascii?Q?kTyYSszdLOUbFPsA7mu0yeS1O/FNZE21lDXs+wiM4PKBpSsJirH2Y8pf+x49?=
 =?us-ascii?Q?GvESqqHst6WmhxjQkmRSABUft0UBJqnH4cXgNACIU67gThY05GIJeBOzaimn?=
 =?us-ascii?Q?hy9m5ozHzluxSAK4DNx6I8/YsftsjHF7ghoMjLh/m7X1fis/9lBhloFJAxcE?=
 =?us-ascii?Q?5RIgTKXfo2jcwyfpjB18p2jMG6R/beyORCHHiT3yZCnemDbtqD5QNrUUgd9x?=
 =?us-ascii?Q?Et5XyVyVXzgRbjuwK7LLj1ydz6fgTiOnOl2oTDbHR4AZ5+nAtZLtqVD7pLro?=
 =?us-ascii?Q?hD7RjfPg4Qg0OxLuIy4+QOv/f8q0gcu3UWXBrsnLpNqEqCp0bSn3Kx0/7OwJ?=
 =?us-ascii?Q?QfexaaxunemjCoYLegOj4bqxtjl5rpPhTxoS8vwuzB95qApgQ5UfWB7vRhrr?=
 =?us-ascii?Q?5m/VEl4z+7ZezWVyDGVkTERBVRMb9KP//yk5JL54Bj7pYfJNztnLaNA8XQpF?=
 =?us-ascii?Q?5e9gpRNRTQAaTEvPE+WPLnJhvj2kkZbibZLUh63b8fQ3M8nZbAn4UFGZIF18?=
 =?us-ascii?Q?S7yuGjUfSIKtgYm/qz+y0P/K6gwXb2WPjNXj01OBTby3NwugI0VacWf+QA6K?=
 =?us-ascii?Q?iyB5sRJK/568N1pDnP09X75b3nzlqFf+BWC2eK8oboTwBG6tcvjqmnDRl0Md?=
 =?us-ascii?Q?GDX8OM9ksp+HZeioR8FWD4DGdWtkuSxNnZfHfTMXpX0A7B2bVXhcFV73VlHQ?=
 =?us-ascii?Q?lEAX3t6LktczfjGZbEU0GPvYL8hk2x1KsqnbChEy1NPQ++AmKx7ylydz2QNs?=
 =?us-ascii?Q?L7YdrZjRRY5fX6ctDjMk6u8N7enPE76CIRh+JSWNgoyTSef+Kmn9pTai1BYk?=
 =?us-ascii?Q?8YqL/QKJfQJTyXvMTtQzhftxc/60pIotAz9vLu2k6mwWZY52mYCRvv4qZB67?=
 =?us-ascii?Q?nTpiTFEAC6rUx5+7mdi5VPVhp7/b6ewe12rRPH+w42febMyDkRxUtnyUOQc3?=
 =?us-ascii?Q?fpiBYAqDntAR/R0Ie1nPx6umKua+EWLJdMzFZwMue1b97TKF4mBLqx5/w6Qg?=
 =?us-ascii?Q?0eDpUkrEM1D/jAiHon0t9uaA5D/Qv9Dfba5rbyZrpPYMpjJGJxvmlbWNnzgk?=
 =?us-ascii?Q?U3puCEpoSw+6zrRlOYQnKSa/J0fl1a3C4ScM9rJHLBHqFRPjLk6JOhJalou3?=
 =?us-ascii?Q?+S8chv/2UFWXu7bGxRwi5l1c5DkXdTtnX2dxAHclyQPUYOXVG/mAoD21DOsJ?=
 =?us-ascii?Q?Sg32yyBAKfWWjqNk6IOUPBfziPCn0HuzqcDK5dLiNM2TNf6g3sXsvneb6rqo?=
 =?us-ascii?Q?NeVFeR0YChQ8+nv74lKdQLn5lMpZKY/5EeV2pIoVkbB/HheQPS8BT+165rvP?=
 =?us-ascii?Q?FonH9uPSnp830LpGCM5X6d7WM/dH8gtr61pw4LKNDz3LuDD9TZx0X6MI6gY8?=
 =?us-ascii?Q?PB0jvf1miA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c7e1d4-93d3-4c2a-f824-08de5e6de45f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:05:21.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0l3+LA6ihcPiSbObOybc+bz7IZA8fgZD/wVvBs8MsdiSZVyl5YzxrLR51uxdkO/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123

On Tue, Jan 27, 2026 at 04:49:07PM -0800, dan.j.williams@intel.com wrote:
> > Yes, ARM took the position that ATS should be left disabled for
> > IDENTITY both because of SMMU constraints and also because it made
> > some sense that you wouldn't want ATS overhead just to get a 1:1
> > translation.
> 
> Does this mean that ARM already today does not enable ATS until driver
> attach, or is incremental work needed for that capability?

All of the iommu drivers setup an iommu translation and enable ATS
before any driver is bound.

We would need to do more work in the core to leave the translation
blocked when there is no driver. I don't think it is that difficult

> > Drivers need to ensure that ATS is disabled at PCI and Translated
> > requestes blocked in IOMMU HW while a BLOCKED domain is attached.
> 
> "Drivers" here meaning IOMMU drivers, right?

Yes

Jason
