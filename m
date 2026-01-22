Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADCE39282B;
	Thu, 22 Jan 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101126; cv=fail; b=F8GNEAA41vX4t7TqpvmG84+SJnyGlfP3IjqXJ//Z6t5goAZ0iHIsrbHDwbN9eFSHJAdjh+9MIkUj/RKUr49UkB42MihG/+g5eADx9T8sY89j+Ig4kups6i5poozHePN4GVRh31ctZZCJ4j5yjkiDoTOLIlppR0WDJ6jDSa6DPPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101126; c=relaxed/simple;
	bh=8ppBYCLVIRWUVV6hKAEYSdxNI1yyAz9KK5ga29KqJhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J3sUzr1+Ue9ITjxStELwdezS7IU21QzvZNGTUCS7KgXmEd1m8l9Y7NVh49v+JjJv8YhTbZ63x9WYq6O40NhFYAuBxv15X4ubjWBhFOoFA3RsFAsI1RLeOePt3aRPq7bpuhjuujFDB3DHJz6h+FJcjEsmJY2vkN48yNgQm4uCOM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B69s5Uzx; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B69s5Uzx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yN7bV4vp/gVvyu7qT1mYIXUIWq9wOOdlNHXc+zyO/KD22M+wnpntLu1C09Jumro8+vaIrEJfXNJPoIE/eUyF00GilZg+gbxVNotcxrM9doMPYa8mWCyXkmVW8odKo7/c0vXAEdHwthNbJBl7qY6HnDGCePb1jK2HWAwKY4vnAPIfL8QwHRihXJ7ZIBMtbI1u0FCNf84orJVqOPsDMZIV4s/9cBcjomrgkMBEhXD0L1OkNRAXDcoMdhGSPSqhnpRT8zTq7eWrtkxp40LsnRAJ9eSp7+9uNRYHjfkO3g92ly2+B1O9bp9cwfX4KZdkDczQOqWNyoT4Kj6+CscQfN5fAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdfhEphug/ocRpRg69bu5daK7dedQM8NBydcgmWK9ik=;
 b=nlFdoWNAwhAb1pVQtM4G/x2lHDsU6Cg9jXb+PhnIhzpj+iwIKqvaZiAo/J9S80NVe8zJHaVNSNGLfCdiAqYqrmpNt9uTZSTpdP+EBm9/WaIXo4bIdgDXPFvebLbm6ZBZWMCr6NXGY4Q7G82nABAPRK4gMEkD76Ox8uU+jOhTIS+1gE6ZGRp9zbnlpSeRyUXjxHUy00VNZGbfN1N6R97wn7BVOtGapKeVo9RElWXw3ZrcZCfwUEh7sbkAChnWafCnPDKAWu9qztOfJAMP8wQmS45ud01y2wNKa8D1ci0lm2ODxhiKgfG+Yr18DX8WJsN3d/y2kumMzrFmPtCeISxUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdfhEphug/ocRpRg69bu5daK7dedQM8NBydcgmWK9ik=;
 b=B69s5Uzx/+e1zk8sWfnW++ifj3SdoCac/+GFSDEINy5Xz2/1u0Him8JE4dVA3SvbaAVPcQ4C4NzpFfvzCPOK4JgFHDa3UPlfuj+APqGft/5Ylm+ce/Losiu30gxBJ6ko4iagoXb29V/arEmdBfeQIpMcG5boOUj7wyhXNZ8CwwuiLra4KhiMvgmCnwr7QFE9wHmTxa+mrw+ErGMBQcSCh5VFZTEkoJ4mdbSbQ4wsPSwVvcdFz5uD0Nf3HiKWxj995e9pJFPY/bkNRJ+rov9hECuUcn1iaYV2f+u3nV5b1WeZDRYh7odArX9ABxkdNiY/qcsfixi1Ft7xRSPNauHQiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:58:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 16:58:28 +0000
Date: Thu, 22 Jan 2026 12:58:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: dan.j.williams@intel.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
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
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260122165827.GS1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <aXJQVprkiMCWxDyp@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXJQVprkiMCWxDyp@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:52c::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 5717b7b9-ba9c-4e94-8795-08de59d776fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7IomQ0pZ/Zb2N2UjOJz11Ay8s4PUg+GxnU1HPP6GMpzez/f2iYK7edgiKaOi?=
 =?us-ascii?Q?tO4kr3eV1U4hVgj8Ipjqi8qy7/E+Ue+w7qUCSMQZx70tt4eb8q/JSaXfnZ3H?=
 =?us-ascii?Q?2vpMiR857ID+Ub18tAE+fS6uZ0pkkZ6JpoheQsUzPaq/6yKJ8x3i5nNMyYfv?=
 =?us-ascii?Q?ry6Y3WQWpmONRrgwwQPvMhvRBqIOXPskUgL34YoaPQ/+5LUvirNdnpu5fB5m?=
 =?us-ascii?Q?ZzNXd4G9ZhmgBud70tNYcwyMcysogfSk/0nXls9gFDylN2sriNYKjS1FRYMt?=
 =?us-ascii?Q?g3F8CX18hYuHHZRC4/mCHc6syugFpUKhLO6HiUL3KOIEmrl2Q9wT2mOcGL/k?=
 =?us-ascii?Q?EH8Zr5uL/E8+h4Hs7pxNyLyiJpW16RllqPjdD523bkjMq7M1WZVWTOJmhy4g?=
 =?us-ascii?Q?4ZMsXmnYW05z+qMZEujuRgbso+BohNxCm5DVfYl+o+ukEYCh7kTJYBW/JuVM?=
 =?us-ascii?Q?Q+iLXjDMqCaVpTJM0fckHvJeyfyeKM567VPbsxbN4lL/ZvBUi333KOstp8YI?=
 =?us-ascii?Q?ifRI/Lj/j82eDdCL7SVQ0IecsdzCjhqI6+SS/8Is2NJp9Jzkl3WsKE1MqLkJ?=
 =?us-ascii?Q?EmbkAF9wFmQFHf2lS4J8wcwIZTiyFT5nDCHxhHMJHOZhzWga88iFAlsre6+0?=
 =?us-ascii?Q?i3s4U4dpOkNYxKep4YYtqJwQHeP+Y6xGvHTvqNbPcypYKpVWhQgR7Wpb2vaZ?=
 =?us-ascii?Q?RqFLNN+fr5nM78xKRmHL6mohudWO2pBNtAXGia/pBUAOzKQfrY6AbGy2VpvB?=
 =?us-ascii?Q?9zHcNZO5aS8mjw5M4ZWIXUAdLdbCfk3PoSz2iKMijmPhCxZiUac+P2vFYUTq?=
 =?us-ascii?Q?3TWxlbv8f7MumJ4FeLc5I7we+P76O2Efkaqk5N38t7M9pEmHypBqq97uJqB6?=
 =?us-ascii?Q?/YlYfIFJgNpn3eESn89Th6Rxx0X14ekmQE2owEB5H8OZQLoZWOL+IRUIel//?=
 =?us-ascii?Q?50/1D0QoqKFmpGSIhbGpxTFZ46DjwI87Tt7LWPF3WPIbh0Gbihejk1vgeBoY?=
 =?us-ascii?Q?2Ezm9SIG0hrumTQTk2Iwavm2HBlA57Ui/PF+yrmnjzGXokdIn25EA18aFhEO?=
 =?us-ascii?Q?FP3En5oENnDJUAbcSB5C49PkbhbTbPmxNM6r2VoYevYBVyn5BDyjPQ+vm1st?=
 =?us-ascii?Q?+CPRfNHJAAD7PaYbUu7l4o8FZryBpn0/uXSqd1q0sd6Zs25I1cWu9ZtiOsWJ?=
 =?us-ascii?Q?gkdtEzp2lsr1lTHgDQxDZHiOcyWN3NJA5zeerngG0gMVCdHZcOYyCKRB4xEC?=
 =?us-ascii?Q?XaoWMdKtoQ6nFm5+/ytivJb+NS+RIPeRYNmIAAdSfPyiLkU47Kvo02U14T41?=
 =?us-ascii?Q?Rm0lOp6xawZiYCqwFrD2cSGFyyyXn+UkuzIXYvEIY71h9SFQLWa3hXbdioiH?=
 =?us-ascii?Q?tkRwJKEEj7dx9XWHX8fV/yWEIBRpjfkugdP8/12W1eX2FLWMNpV60AQK3MMK?=
 =?us-ascii?Q?RAk+AaiAIiAxNXM/Cgh5fItH4v4BBUi4IN2W4qggqD5LOMwijeOpaASrGWrU?=
 =?us-ascii?Q?yzjGNBTq9dtgcIRUlPVuFEI+JwW6006XBla2Y4gbeBwOLlHlPnOYAN20xTAg?=
 =?us-ascii?Q?dIdJcqowJKY95xFFl08=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CC6uAKEKbrvNk0zXZeT5HE0Xi/TSPH2rwpXnGLzC3sblsMd9EPV9jC3X3gEX?=
 =?us-ascii?Q?Z9KvR+/2k5LG7QzIzPjxobSnH78kYh6PdO80LTBawo2Y15cpBymCcFMhabsn?=
 =?us-ascii?Q?U4BhWdbpGr5SMuzah+O2h7B3VKRlT7APIdc4LxtqOaDG85pWSIZM2+DCqL/z?=
 =?us-ascii?Q?awTYGsQ5iQWBmQ2VeFQ6r5u4wjt20rjUOANecVV9a6hASoXXJUe6t/j/Vp73?=
 =?us-ascii?Q?wCoykhsTlnr30C50raCk0GpjoGaM9j3g6pSb7Xxyaay0/+2rhtv0gH4s8LDM?=
 =?us-ascii?Q?B8nTSxkBUdGy8knmuqpDrBH97+4oQQVUig36odve1ztx1Z1m5C6xw799K8H3?=
 =?us-ascii?Q?9/AVMpsKxvB+SwS6iB0Bz6QHdX4Tpndwmix2hI+9V+ukV6ClT2u6bPgFYJrZ?=
 =?us-ascii?Q?EtHgg5ttxhNHex1RgingkgJ86wf51jjxaI+YQ41OZfZf2lt7vQ1FvGAabUDD?=
 =?us-ascii?Q?Bekfb9l+KINsXjDH0nxwT4o3X8aXh8RpbEW2cGNsRtks5Vx1q4mFC/xejpue?=
 =?us-ascii?Q?YImtjssU0GypWA8mp0+n3aOZ09hBglQnYqQMy1/UiBqjDTFd8td97tpLI7mq?=
 =?us-ascii?Q?e4zlQHbtEPt4nuAhidhZHfgRs/pUN4zQjYCqvyxU+VoxECJqKJuW/xEfsYaf?=
 =?us-ascii?Q?RJUukBumT2CSmbe00C5VhnK1yaYTXCRNTPCVjOYC5hT+fIjgR6bW++fHzHj3?=
 =?us-ascii?Q?B8AN6cuepgaswDiBShmC//F3uXZCaJZ2MNV7gWjOjzoauiY5vgoWs5MVuecZ?=
 =?us-ascii?Q?15fspfad+NSZxHS8Z1eif9zYqGX+PVpQFT/283tPl5xfUwXZb+JVF0rEL1Mw?=
 =?us-ascii?Q?HNd0wida/OcW/FEhb81WbS0WYjEphr4z1XV5VTxHv9umP289xc/LyDgmMFxC?=
 =?us-ascii?Q?IMv0nrBx0036UH9jPL6RKO7b361CpeZ8PpR6JmSeGlUweIBO2rhkwXzAzlAV?=
 =?us-ascii?Q?6InQa644QRXhHf56bIXyBzG7aDZgbK9UvOPjC6xTQy+yaxSJf/9LSCaotBOs?=
 =?us-ascii?Q?elYCCzteEioKITI6fWK2LAbPK1wfllr3MTjnWLJ/X1zd7PkUcOuJW3JdzOmi?=
 =?us-ascii?Q?u37bs+9wzUGld3hXkBT+8IMD5EGyAmAk31e52bXedmmOjIRZ5C6x1LWq8yoG?=
 =?us-ascii?Q?TmYVDoGz+Z0Q8vWeyQ8E/4CAibtaUdBh8ek0cnOOe1Ie2VWwerbA5BN3D11M?=
 =?us-ascii?Q?7SUZAaxBR50hmLOU7OJFi2k7nRrG0XuiQ8+DZ89OcgUjeXwD8t6m9V8i3yrH?=
 =?us-ascii?Q?+g/EL2TukR0t46V78OJdNRDFrFwKX8Y3Crc3mVSLQigz1TT0MbDC1U7CPPh3?=
 =?us-ascii?Q?YU5ROPUFhk71uE8d4W69xZmKRGM+T2gu42fc/AAaS1a2Tp+8wl4HRIq0l/sd?=
 =?us-ascii?Q?d3rR8WqYe49hwOARe6HmOrCw71ARj4jux0UFpQsHdA9QnEPrqcAGXwAXhWiu?=
 =?us-ascii?Q?Q9+XraGI6KeaBV1r8AZ0nXDqxoLmWhfE2TcTohwyWlwfnwlBLLdXhQHSuCO3?=
 =?us-ascii?Q?jkBVQ0wr4FrdVFoU41x8tkx69aI1L96f0bdUwZ10QNSAHpZxW9VlefMz7G7f?=
 =?us-ascii?Q?RrWOrIFSrHTzPnhcPgSQVj7gVSix4zwD2kNJDKtsA+EnTKNLhrPUTW28Sqe2?=
 =?us-ascii?Q?gJok3EUJNDVHSS99vcOXFgAOHx8E7N9Z7vSQOcS1Z0dd7A8IXMrlmKm4OtjA?=
 =?us-ascii?Q?wcXDN000V2moWPrdawoWYx2Je99dMfra4tpfdrJCYRBLJU6/ezMDLbBLT7zn?=
 =?us-ascii?Q?nZHR2Jyw0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5717b7b9-ba9c-4e94-8795-08de59d776fe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:58:28.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9fD8gVbHh3RaN35WqeXVfxfRo6V72+0HVJODacNHQxxETFij1qXXiG8xfKeqoTS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174

On Thu, Jan 22, 2026 at 08:29:10AM -0800, Nicolin Chen wrote:
> On Thu, Jan 22, 2026 at 09:14:32AM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 21, 2026 at 09:44:32PM -0800, dan.j.williams@intel.com wrote:
> > > "We have a less than perfect legacy way (PCI untrusted flag) to nod at
> > >  ATS security problems. Let us ignore even that for a new class of
> > >  devices that advertise they can trigger all the old security problems
> > >  plus new ones."
> > 
> > Ah, I missed that we are already force disabling ATS in this untrusted
> > case, so we should ensure that continues to be the case here
> > too. Nicolin does it need a change?
> 
> pci_ats_always_on() validates against !pci_ats_supported(pdev), so
> we ensured that untrusted devices would not be always on.
> 
> Perhaps we should highlight in the commit message, as it's a topic?

Yes

Jason
