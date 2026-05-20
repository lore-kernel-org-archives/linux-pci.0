Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D43F0A83;
	Wed, 20 May 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299601; cv=fail; b=iNLr5AUKLF/rRr6KLXLjOTiwgAIyZJAa+xZk78TmoLNbgN088VSPkYzQdN8AGqAu15s0LkTrqCHybQOsO65BA4/xQK13u8UgFT4G6AnWgcqmRq7AWrk2oRN287MUxy4xJKOXMBOiHGWZp5IY37CWVbB06thgkfLdaYmuVLsNCGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299601; c=relaxed/simple;
	bh=o2WyrBgEtOJYcQ0PGxvK5DA9CV9YPkbCoM5KlyUNGYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EG9NGR1vbIJyMl8LuS115LHELb3oGr1v4hVxLip8Mp9gufCkB7jExywATR1fIw/vT45uab2yvdhPKS4MJ4BxdkgtUFAr4qRp/POO2QdUGjrpf+0sOYrHh3fcLQAIiTSn0q1UfbcWIt07Ej/SVhPN+whMVAuH/k/4HSCTL9XyGs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfefR3Zr; arc=fail smtp.client-ip=52.101.53.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfefR3Zr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACGbl87eipJeg17qrWK0X3s9iqHt3+COJb1DBRgm5+RJiJbDmFYzJbCzsMmQHPHAdpEh6qzrbOKDZrP7Rb+Lvdwg3I1Ok2g2WO8N5Qih1RdUOxAJKk5QQW3qiTEn67v7hgPiV1WFr7KSCbw+pvrM5YkqeuA1FfklCRjmNDwwlapS2iuAW6/QwXbHuHMdcWX2T3p2rqO+EmxU3Ww/OlqafyS9akWXF57UUtMSq9KHWbbTgSFD9ieJ8HCHtfv7gXyfs4jRnEXlLckcgk9KQVhQWuseNmQ4M4wi6tkZwLj1tsIM3/WXcpyX7fWdybuVOkYHX1kSkzCZraucpfSh36G+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXdSjdmZ+ej6MLC2dw02Pste8QIKyaW6NgHENkVddjM=;
 b=N32TWeK+2ceyIDmywqCJe4HQlQSPG9QpQyTgJsV44nkA5g5HIAXyesrsYoFLgrrubNXYJYiU4u++7F06YOygmoVGxW992W4TEj0XGsliilnjQCZMgkW0DuqBxvXqcYK/G7CvoTcACPkZCcCfp8J3CSDK8FkdqxNsL0ZUEhaPKJZwjDikOdXiXPlVXAqaV00ASf/wA1bgb3ulRSsrgZfNNPsSj+aWjqss2uChad40NyaqazuZDItFu9QD3qLzDdT/lRT1qWP6icNZRIdbiJ21UguSL0LDNZHJRv0P3SjzCEVGU39Xrp2KyqEt4jqapVyAYsGwAmEJY4vl17wDoHtBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXdSjdmZ+ej6MLC2dw02Pste8QIKyaW6NgHENkVddjM=;
 b=UfefR3Zr9nvKAKdf5SU96I9qhIsmLqQXr+VvswUstfffxUoBF7UCMzeQvEDEwkWBHBNQtwdE+1Wh4qMDCNv4XhTHAhnkzY2K0wWTAi8tS9uAiWaVfRxZIU8z3Ib1jGiL3y8E4qw3bAyfmwq2veGiYqW/LfFG6t1CSo35PmTp5J9+5Qfm1LR+czUsAy4aNerHKHbuDmq6kcLHN/wM9082nRhBPKCKdzXG68c4ZvV6pAxsuxYyw0ugqst4YQTYThN0pf5Isd20RZdxS0jeeFd/bTQciYWZgq67RNshFhIYjX1xjNhGvIMeY7Tob95Bfv7lHt7WYI5liXarRu8oyN8sQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:53:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 17:53:05 +0000
Date: Wed, 20 May 2026 14:53:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v4 2/3] PCI: Allow ATS to be always on for pre-CXL devices
Message-ID: <20260520175304.GA3602937@nvidia.com>
References: <1a8cf5e88051ab5c10417edb94df598ecbc810cf.1777269009.git.nicolinc@nvidia.com>
 <20260520175026.GA67027@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520175026.GA67027@bhelgaas>
X-ClientProxiedBy: YT4PR01CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 4597dad2-e75a-440b-22af-08deb698a507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|4143699003|18002099003|11063799006|20046099003;
X-Microsoft-Antispam-Message-Info:
	LOXb5tBnDY3rPTpNa3dXKZ0N1f8pi1Lbu+zcFs5SQNbluWexBMqQ/mqZH9BA9fDh8JbxdM6rWPDf2MwtExyrhyy+Y8tfcM+2c0S8NHxs/pamqdNPcZ8v+QFwzygSlWx9HkCQiC2n8qpGEVwz1ei1U2QpA0HHRgLn/hrRkkoRdIoaAWg2yie770XJGRgl1aT5nYRMMyUhVL6aQ3Z4rciqGxX0UqRMvGt0OKT8BZTe8TXzsieOl06vKAa+RcGxs6FmTPBDK2b63SF8bp4Cv7UGl+516FEkSD+4JlTrVFYCJ1Vf3R6oInO3zfjo3vDJeb3ukmKfhheL94zop82kHi1K98WevY6/m4VFLpHhpNSkNY4PcaR8orVo2e89pIckKPfrAX6F43tq4sbE2StdR7A9KWUUzr5UkwZMw4sOKtFzmmjMENS2yLieoX8ZaBoX3Qf4nBoat6tB40vi8ofyyE58LLz4KIUYorAI8A71M2dKGE4w5uWLONRHWDLIL8YjRsvL4lCGNUbheB7ya1k2Xvj6K8WK3cMOHaATkkrtc0QbFBrO9UmaD172DrdVwF7RnoTzHULlJPp34cRwlTxP+xYQ96JtOvFS0Y13/gtLW76SJDo0XCWKUK3bdD6O8Eax1boI4CXmfvYh+Cvwv4CbYnmYS50weH8Ls3hUIN7linTXnNHTFDtDChbZ9xuXegbPEu/4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(4143699003)(18002099003)(11063799006)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGXRdz7PQftrKMUvfetxo/VGKbrcfbDNvqA8PnL8PoTP2O1sLCAyqfUUCFD1?=
 =?us-ascii?Q?PALXeklspM76zT7g8eTmMoXjYPtP9PEsSKM3kkEyc78yNuB99b2QrBp8CqoC?=
 =?us-ascii?Q?ABiJMiOTObWdkk416uAtARFRZM65e6T3ckEuqL6iVTMx7X5thOQg+R/Rm0CZ?=
 =?us-ascii?Q?9disHQmQPWjIBE/ms7vTaegXv/v8gha7nbP0NIU2nXkwYsvEl0a7I8TFaCYs?=
 =?us-ascii?Q?dCkBe8TNgEDQLY9u/FKd7Tv2v22nRJi58uc6Q6b+Ojy3BNgETLlWPRZFb39u?=
 =?us-ascii?Q?6Act+GiFGCLPCXVRHuqPbqPqJswqsEhLV+hZbKnp7m/C2nhBv82o9U9Wdpbk?=
 =?us-ascii?Q?sOZsCV16iHbzLd0pAc+n+0QJbpt/yn+UZ4/N9H2aIfAnVN48kzOggv72c0ed?=
 =?us-ascii?Q?tCtjNPjcJMpibbJtreR0w8jRlSNgi+YLgXkl1jnqiPisYohtwr+J7vnXgcH9?=
 =?us-ascii?Q?zMS6+MmCd1LqgOWDPeyOizRKq9pMlWrQSha1NSY53ilF/r8TL4Bs9J7ER584?=
 =?us-ascii?Q?ryhXBa1YWn72kLAHsftclA2C8OIzLwqpsBER9SsVe4eGurzSXqN1cePeK+Ra?=
 =?us-ascii?Q?ZEI2kk2PB2bQM+UWvPyuSzTk98td9l3cxwUONuqbhaPkYvkbUFFXusct8agO?=
 =?us-ascii?Q?11wJZMxo5EqPODW1xzEXM7K2GKbZA0FxAroj8vXovCEnidi6NP/tORtXZKwA?=
 =?us-ascii?Q?2pVXgBZc2pd0YUmadP5TSBtOswMQ0UmUqm3U8nT6Pe9jHkIzqYqqpPldFA1P?=
 =?us-ascii?Q?zDSXhXUNMXAnD8HjJHaNWkYcstitIgeKEY44JQ287+sEEHDMFb7cOrfHxYZL?=
 =?us-ascii?Q?RUc4r/hsDWEAsHz/2+rDMG91WjSda3TNHhwMHGO5ZsDgCR6gco9fzbt5YZKT?=
 =?us-ascii?Q?PqSARfR5Bo57cat1qlxhAstNCS3oUzC2hLdE9gziPiNVqqDbCd/JWQeInU98?=
 =?us-ascii?Q?oK5paqgqb2lrRyWkZ1xOvL65yBGZV57pQpaDWBbms4XTPV+tSS4osY72o4yz?=
 =?us-ascii?Q?ePsiE8cgG4vaLcvIzJwOAuQa2Al8V6KSaBcQB4FTDOc+oQYPxV80+HrjP7m0?=
 =?us-ascii?Q?l3wiXBXdMMsc0C3A/hJJcRN4pVAFrxBW64Ge121cyncjBJWR4itOHFUHZmMb?=
 =?us-ascii?Q?D6+9L9Mw8POyiFODk3NmabnNB8XyLNIHFWDaHtDWsnO74DEIuNbaQDIeZ5oe?=
 =?us-ascii?Q?hh98grCU8ba6FO0dmr4I+hdUMqn2t/7ZAQxN3E8jpxlQdAYzd/40WRyuW112?=
 =?us-ascii?Q?FMqnA+rSUuKBuQRxBQFSXLA1PyzXZxTyKkdriRjgeT8i7PCqteCsZdoBSR67?=
 =?us-ascii?Q?LSld3FAh6gH4egfLxEWy7meaqMF2FhqX2Kai07r45xI6zCz/3D1NbaIkW4bg?=
 =?us-ascii?Q?iToWk3p+0SvP7QlsDoWUMrjfbLsCmR0uHORkZZ0jLO5V6RFjuYJM78Xy091q?=
 =?us-ascii?Q?3eR0qfWkvC+fjjAo24fQ5bzd7C4hyijsOacNJd7ntPLeq040Vujy+7tA4jva?=
 =?us-ascii?Q?iK2xlklT9e/oqz/Jvwxy5K31iuSR7ZouR3pGcKyFzkJQodgECZiPscqT/rxD?=
 =?us-ascii?Q?3JveOfSWKdzLLTXOd++uJGv6Oy4asmanYORh0mGHGnPJYL8KH89a6tRE11GB?=
 =?us-ascii?Q?+PhUZBfswV2k3zaWUt7ZyqlHNOGy8i1G5qvFFaXb6VQm74220x9Ipyhh4O/7?=
 =?us-ascii?Q?GI1/1I4zMPDNKzQcMBYPaQF53n1InY0f16CKxhf0C70B0h9u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4597dad2-e75a-440b-22af-08deb698a507
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:53:05.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ko/ZPZsW+3looTku1BZmW6ICYFQZaafBz/RxqgRn1RzXQxc6epiAkcHj9yJWY80V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

On Wed, May 20, 2026 at 12:50:26PM -0500, Bjorn Helgaas wrote:
> On Sun, Apr 26, 2026 at 10:54:01PM -0700, Nicolin Chen wrote:
> > Some NVIDIA GPU/NIC devices, though they don't implement CXL config space,
> > have many CXL-like properties. Call this kind "pre-CXL".
> > 
> > Similar to CXL.cache capability, these pre-CXL devices also require the ATS
> > function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
> > v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.
> > ...
> 
> > +/* Some pre-CXL devices require ATS when it is IOMMU-bypassed */
> 
> I guess these devices are purely PCIe, with no actual CXL
> transactions, so a hint here about what leads to the ATS requirement
> would be useful. 

Not quite, they are not actually "real" PCIe devices, these are
devices that present to the system as PCIe, can issue CXL like .cache
operations and don't use PCIe electrical.

Jason
