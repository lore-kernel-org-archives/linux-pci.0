Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD72BE02A;
	Mon, 23 Mar 2026 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309879; cv=fail; b=duHGZ7zPh0Ql/TC33yYbP3+pbe+u48/rYVy68MHl7V4XHRuzGlf62NcXL50wl3OGlEQIKLFhPK0iUB7z+BtsTegyl7yEz+ORlb5m9aYVK75ZvIA1WxYaXkOq7ldjxkBm+KUIxkbKcilg/rYBZprfQZMt9T9819gbYkjhRNeTKMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309879; c=relaxed/simple;
	bh=e8f3aM8POJbbCYYfS1e/LpKe58e+qlBSExPu2ed5Inw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gnZT/pQQiua4BR4UAnOAgPsimS8c7QrUqaG5sV/gdtVlayQGjpJEohmIqrj/vGaFA4UMVwK/eygJIRAJ+KIek3bPW6r23hVX+Fjwk6xvBD1OLW2PoRUYAEWpkT4biAJj41n0ZneKBeqWtHV5ZAgt4+BX3JpOv+1XbyJdk/yrlrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ps/VWFgI; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ps/VWFgI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEVZYlKXUvZtJra2VPKC9nPliZtnqw8Dw1LyI2q7QmMnuF+M10iHo8jL2zCbGriWZWOX0tRgcDhAUEp8EntIYcS746hRZMA+NY1RW7Ll+qnOxTb7EHW6cr8CqPjietN0xaIRUTsqZm1+kLdya5WuNAd9oVZA5uoZqV3aEbOV1OVTpYWV8og7E4e61dWXRc6AcP0o3qP92HN2hTXb0dhjDoJyebwZdyeb3YTYSOpq5oN2vX8rVgVr5e0u9SNTOjEDIktg2vAYBS3Up83PQCifhzw1QDB0q+bMkGAJXM32rzrnXreysk/0A+E5lgEniPmpc7FqQUI7DyRWv4kyHU26BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9Da5k6WP+86JacWrLFEK3tG8Zzl+JGl1sXrsfbnrzI=;
 b=q/D8DB+1+Kv8OSdc7c03a1KLT7SJ6YKKfjOpbUAWFD8zLKSM8XpxP+R6MXYyGYY8lCuMUtOwItWG6zjCDVHw0t6mIO9cfxC0Mz4cLFAl+n4dWs7WkQLtoHj7bDYbVDnhYqIHizyBTnSTDwL2LD2DbkM6fdC5PpOPqcNrOjS9bl5IJzpgKJ/s7jvTBhaUV5waIDvdp+PcdogD2/U9DU1Sjjmv816Fr22fbOOq47PwP02+Kd8yFjz2MR2yrU3CIVtJO6gWpOLCb2hPmA52U5VQCdOmCvDyZd6dGt6M9MNTu2ZOZja93dz0WDHUaK5ciLme/QOguVFn6BP4VlHGX25jyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Da5k6WP+86JacWrLFEK3tG8Zzl+JGl1sXrsfbnrzI=;
 b=ps/VWFgIn8e5chzoUrG42nTE7wdCLG3ZA5d3XdFyFyOMbWBh2kAAiF8hnfZdQxgRW6k1tboVVZSZdvD/yjTB7mA7YkzgGeCRvgvmjJc0vOyh/zgiJeprFBwLRrz/fnpPbzjQ783jhB2jjLXlEdT4veDQKiLf7cm1Vt/dguhg4YWLrQPdliwBPJ3A8P9i2q5LcdUpmsrDtr5Hy9fa2494gSrkqpZLzu/b0ORE9VKJc8fEOfpk2DRkO4xGcuUNosRM2iONsqXXVXgTDTVsqjeaHrQznWJb7IPhXyo+EWDAWeW+uFZqlnatDhiogqLQzXa/YMeL267UcNM471ADGVVVwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 23:51:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 23:51:06 +0000
Date: Mon, 23 Mar 2026 20:51:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <20260323235105.GV7340@nvidia.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52763AB181F5213FAAB4F4F08C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abr8aS/MDU9aeKu9@Asurada-Nvidia>
 <absaKimeI_TXXxuu@google.com>
 <BN9PR11MB5276467C1933E19E98277D378C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abtphBuLiXxSxmAy@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abtphBuLiXxSxmAy@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:208:32f::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e49b6fd-1530-4970-9fab-08de89370cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HLHKOQhSLHj6zwyOO+6/0WtmbNuHSljMC4NRQ40DqVj4I2VK0m9SHDUKIxnywG6bEqUC40zWwDFqIsGtGa/dxcGSmNquJd3/1xEVh/nbCR014WSPwodiaQKVTpKuXVHntvxPli5ICzOE255Njsh0MC03uJIlxGpbCPmXeKqm2cLpjt0sSY2mtsfmCWa2hvUSb4VzmNZh+lKjFrEekcPzr6CvYcCzWJTPvcPS/GB7Sp5C+SDKi/FrOlzpnw7t9jYSolts/ouoRiSpNOeC8w+PkzJgRVtoxotkq/zmlsiyE5tZuBEWCuxtLcK0pZ3QYv/yqTnQ/jzPo9tJAlFs1fMFOS2hyO8LJXZuJcD2MUYZFvJwG9atFYiJMUT5Yex3Jqapg7AijQzERF6FhAW76eV28joJTRUqa/Uk8gRNuf+MPeSYsZtM8+31/EtRSy+7z9/3ogPPRg91pjmXBcB+l4+GmjiBgnPkRuh4j/fb9vnnPg/uNeXAEqw0RFvWVeSMgaVcAL2yhLED3QpAsi8tNBpQ1zu/JOY22N8OPMPcOGG2xHX0dEUzhDqATKfmNx7UV510A+XgcW9bRKKIRrhyzDwNROyzK1/G+SzbV25ToNTFS5Y2lHoEbkzgT8AMctR+UdDuvP5VKI3JoO4p//fMAL9d3gvdmPpynRBOEreB9Q8G5bdYgQVFnHdZKef/T6teITojAtLqia+D+S/yjc8ZCj1EyusNkLJuHrc7l/M7mB5SG3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RlmDNlTw+Xa8PNt0KYnrpjD6gZsvtPWTsZP7rrO0TqUUGojaw/fkP5cT2ADA?=
 =?us-ascii?Q?0x+2FzpzZkXF+WzXVlby8E66fABd5DKbL1DWVA4oAHedHNwfjIVIvfT+vPfP?=
 =?us-ascii?Q?h5zqWfE0wQioDt7pBGWky226CUKEx5anJ6ws+MWquK3p8gxod6TD3wNQssiz?=
 =?us-ascii?Q?UPPDIb0dD/hI9riRn5gsLqnPPC+29Ej8RDny5yUfH6bD4ou1waF3fQL8RACP?=
 =?us-ascii?Q?Tamz8Hr+UkC7e4rD39yALk3HEwPYF8NpjE8bLnM24IQyt6nARvyENelafi/o?=
 =?us-ascii?Q?o2QP/sbax0dzMlbfTZndw5eeO5tJVArAwNXL4NSEeF2emI50wMGs8qNPIqTd?=
 =?us-ascii?Q?OIFNyuDG1Ebj7UK8RRX+BvhHmjgneYab3hPYrrwhIqzsKXndj41YcCzZ8ysZ?=
 =?us-ascii?Q?wQK+H8KfcmthlD6/wukMMwLO9bat+233Nlni4m7fSUR8kLxdJu/3iesurTu3?=
 =?us-ascii?Q?gFrRRIaOhuHX3+e+N1V/P3NQgC5gqXr4tZrPt+jjv4YHVy7hE+l24EM+ucm9?=
 =?us-ascii?Q?8jgRizNgjuivtrfLS4lqNAUIvbjzzUJ++zzhj6tYACvu+TR4h+ZyeAH/9k6I?=
 =?us-ascii?Q?auNa9bNgoZa7t2Xi5Ia6DYCgzcIjL6Of7wt9O0Q9C2ErBZJPKOOjOm3FjLEM?=
 =?us-ascii?Q?035x+FGUKJU8h27iyk3P4mQ6LGI6HzsCBEOvbtAV2FgRjCju/CQ2TAnQecX4?=
 =?us-ascii?Q?rdSllFLtTfPKtdeDIej6078MZ86RIpJnJ3oca1FwAlBg92/n+Zav0pSENK/z?=
 =?us-ascii?Q?5wmMZOjri0vOpbS6QANGdsGkofeKTjtJkoRACEWRzi3v7gAYtwNJgUfTtDDI?=
 =?us-ascii?Q?Ql9cVbP9tLFOm+h8yTdVcjXWw9hTzfQzMQ7Dqnu20rI20XJvvLx8peH72FZd?=
 =?us-ascii?Q?OgO+AW3kYDtAwR1fOGomCF3sxHSMTPSJqjzZ9hi/q0skP5nkMHFwHSNs8NJk?=
 =?us-ascii?Q?N58zwvXBLr4mhZnkn07mFts4NBYcTcS5up9FZfyBsmFp0GBaqBCdUR5PpxkP?=
 =?us-ascii?Q?dPniIhFSVjLmM112CJwjCkk4DCN5dBSxfe57a699WoTHhwqbFI10bMSCymaO?=
 =?us-ascii?Q?i64xVRmfNnKKoMT2K/bi0OcN35ZI3ZYHcHDil5ZI0KTF5SBZknVs4KppxRfM?=
 =?us-ascii?Q?YrE7W7ei0rs0hnHwADN766/3eFZV2E/SumXn834MWQcmlC/RKHf/JRHCaIGC?=
 =?us-ascii?Q?RAUWQQQd1Mh/7MpmuKKjNiq/KptwVzVBdxmNfJWDFVRM5GqStLpxR7PFXEn2?=
 =?us-ascii?Q?LHI8OyFx0Ejr4zLMjH/qPy/1q+1u02Bb+xP8dtDyUnhqb3/7oH90J5SOTtKI?=
 =?us-ascii?Q?V5CFffYFJzoo9CCrDN4yc6ZsOWEHuYUOnuCIaDu+Ov0LRmqYYVAr1gTHEP6Z?=
 =?us-ascii?Q?/HmCZnoSEe4tBlWB1fXD1AKOVW9TSYnYOlFF9gXghvmt3BHfZrSPMD4I0zQn?=
 =?us-ascii?Q?XjKwJavL1XN81OSOeUbSXeWt65W1uS1Hx6HvGgPyYj2lplLG6eQguQkfFPOt?=
 =?us-ascii?Q?F5ezObige9qr2wRM2UYHLkZAJcrSo4Zt/QI8s+L30N2hkCaSxkb9vaez9L0s?=
 =?us-ascii?Q?oMZ/rsLlS9UdaSYAxGJEju1dkP/bH/QQIQ1WjSohyekdjcx0KXffVW3naTm3?=
 =?us-ascii?Q?ug2LxseAxN314uI9vRfDTPXMc0Y6kBA0Ny1FKEmu6gvHY/GdJ0gCASM4P1UM?=
 =?us-ascii?Q?aNuZbBkpa2NFMkL62hRpNjhRMvRhboV5kGMvsHvmuHGh525G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e49b6fd-1530-4970-9fab-08de89370cb9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 23:51:06.4992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agLvMHNcC2jBXFgxka8e1P3JTkQpLcNbZkfUfZGhKXmpTsFIq2Q2WZ/1bmsJg89c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452

On Wed, Mar 18, 2026 at 08:12:04PM -0700, Nicolin Chen wrote:
> > > VT-d is able to find out the SID of the device for which the device TLB
> > > invalidation timed-out occured by using the SID reported in the
> > > "Invalidation Queue Error Record Register" (VT-d Specs 11.4.9.9).
> > 
> > yes. but when there are multiple submissions (each with a wait descriptor)
> > fetched/handled by the hw and then an invalidation timeout comes, all
> > pending wait descriptors will be aborted (not just the one corresponding
> > to the timeout). In this case all affected submitters need to re-try.
> 
> This sounds similar to SMMU then.

Not entirely.. smmu HW stops processing at a SYNC and waits for
everything pending to complete, then goes on forward. If there is a HW
reported ATC timeout then it is contained to the SYNC that followed
the ATC invalidation. The errored sync is skipped and whatever follows
continues forward, so it doesn't contaminate future work.

VT-d's wait descriptor with fence FN=1 sounds identical???

I guess if FN=0 then things start to become indeterminate what the
wait actually waits for..

Jason
