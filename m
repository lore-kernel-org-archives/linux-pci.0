Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243B3876CC;
	Fri,  4 Sep 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531339; cv=fail; b=De2qRmW63TmMuypQ9DM7QxgbvH6jbANZIMo8yqIjsEAJyL4fBO7MoRgWc10LQnQ/i6OeyAAG/z0MIqfmbBOmsBYzMuUJR5dKZos4BF5rBa2t8bbL12cOh+pf/rrL0iqLI9gokrOdgJDcrFhF4oeekETPernoCyeUdMUz0cDhfjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531339; c=relaxed/simple;
	bh=jz+kOTZy8sSGCkGKDsbjNh9bwhJP8zhhuItms6mXQVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QG1lTMdMXSgGd7D5jXMjrCGTymuLiLrSS/ZdWwUWb4on9FpVKPvjRV7BjILGNrDJTFt5n2IhoTmg2KiqGx/rK5DMuIYYYlMliepPWS1+qXaEZoTGwYg994PmO2XisE4KtXRFnod5eiF0M1jhaUHDSjo6Fgvr4MLGFAc9WJ3HOUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iRDcEYfO; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iRDcEYfO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciLePMDH3ecWM1H6IFIqiCu0lNapiKOJJe4qZ523LA7bUXRGFzkg11erFTjwGRmXrscxTSPe9lLbazjPcvRwxNqj3oswvYiMbFl4TeajV3SjCSMchQ9JoX1obupbQfzjTpuIfsRI0IEJnw7PzCTosSPoQQ2JeVWPrGj5hbgV69LHkn/c18Upy+dMRWqxI0qXEQQnm4r6ajxY0fjLpaXCSRkEQBL3YedunA09znvM5BUDaKDLG7sLkOjyRIZHWpO3pDXubmvyPGhcNihz60OwyEeHRybEN+uaGV6KbTmPQ+6PvUskAfkrfBXBHMeR+Zpzzrw+oZSCWRnGPc5KInNhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1lY+2VwuN67dTt6SfJE39ZXzNTyyZ6IZ/DQYnSrzi4=;
 b=lYQKVoKwmTkEPmdA4A5piiAyBzJ4aA3b1T4+9ux/Xb+TY5EZUl3dpRP4IKR1PflMmhffPdSphYnb8mhToUsyqZS3P3trOmwQynpFTdWQnmSpoM2Vfuyq7ARLigKpCa/BOefkQmARfuy9GTAftrk6v2oxSZjEIfQ52BPhxs7wnx24tHe0C2R7Nx6FylkIVmT4+XQjA8U0+x6YG/rwWR6r91ulXgu69JZtb6V5PbvWyfvcWyguWaBO1TBPytBXUhQyNMDnzaie32HZJ7bhHClPmoIMIiHx//QTuzaYciV5RBu3/R8y98ryt0wosbgmoRFP56Ruieoj+ttOf4cMClED6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1lY+2VwuN67dTt6SfJE39ZXzNTyyZ6IZ/DQYnSrzi4=;
 b=iRDcEYfODbeqWO2YyfUNnubkj7OUHr7gMjF8p+MFgLryjXCSlVzoCLn1A3XTYIWQD5opRESpD2byO2tEE+UZmFQTJqQXSOJe98v6qfIbCMqiqVUudgMBZR4rNNf1HL6FTJkK2xJ/IqSQW7KpSyE8Zf5HEmNibhoI+LAON/4eBf/r+Hj+UNu631nRvOmTREJYdjMyi080wHICyj4+pqF3SwuHk8loSkeMH5c7pcGo0NIzH2QVL0c4l07aGMJ2oO10wfTLpSDAWOlQXtk5YatGtdpV6ha/OaHAJ03lMIf4cyH2FdYgJWZcbMOoxcYYEcabejUmradBAnPVesUjmupaRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 14:15:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 14:15:27 +0000
Date: Fri, 4 Sep 2026 11:15:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	praan@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com, harsha.v@oss.qualcomm.com
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
Message-ID: <20260904141525.GT4157646@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <0b5282c7e850f1a1c650e43670899b4ef5335efd.1788222486.git.nicolinc@nvidia.com>
 <178846311318.1308030.4956293524348641228.b4-review@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178846311318.1308030.4956293524348641228.b4-review@b4>
X-ClientProxiedBy: YT4PR01CA0337.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: b224616d-34bd-4583-d00f-08df0a8ef7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|4143699003|56012099006|10067099003|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cj6o93DOtzG9tIsxlJLafbUYVCnWcmoKw15J1edSYvX/MjlpW6y/aZ1NUpDHdyUe8OtkrqE4cCLqZMeABS5vRB+b3z/+BnGCwFt6ja1OZudnZL9KX0c+4nlN8fJzsizbMiBuhB7+6Te/FTpzSG+67lSbDWIVZATUnK//Wrn/r5eVgt420LI0rOiO8whr+7S7y2TQBBwLu2rZHgvLgOi9Ldr6XSgVhmvmtpZgFV1HGoFqiJ/QYkNkcCTL4biiUBx+O9wv3NUXu4rIaLcEz7EOp1fbSW7+emb3VMUBt2NsUCPFPNo4JYHoatyFITzbTs1qZVEk8tWYADx5zInVA66Um7AiHXDvbJ9CHjEPgm4bv53kxUJy45Mi8HEJeyrR7ipKrmjxy6Epyf0u21wtPms3+6cAvEYkE9j04PQvn6PVCsNQI/TSwzOTqbF79Bn23gxhcNDT/aBzIrHbFLdpG98qKV3zf5snD1ziXC3TOM5UwLKeqpdxfE1qbyN1z4YirE1alJXsKmqR4KQA+o0R599vUO6t/vCzk0B+QOx1Km9XlEK6wKdIBsCFPAVhZwkHEmfe7qeXYgtRDQY7I4zHy31c7rOQ6scR9O9Eu1K/qECG4qNl/KI6IHgFsmwmQ5yprSfEcjNRGOQicQo5NAFqYQuiQNRz5NJXsJn7USvgcRXtm/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(4143699003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?afiA+0MirxS2iqTWECQO1rAhYVCi+wtRmrIMLCyfhRrNy+yP14bytwRh60v6?=
 =?us-ascii?Q?9I7xa/hmgGjqc16JDfm0yNdzgv8TKDaCxDyx5oDlzfiA1TiKQ+H6dJufVORF?=
 =?us-ascii?Q?ezIprlY8tdvBb7b+6JvdKKFK8nfzUTBSUOo9LUF8yt5mRqv64TX9BPondfAd?=
 =?us-ascii?Q?Ke4/ybSDf+dPjZ7WZ6x3sOG7oun0WoAsQW1ZqBFK/CyawTAdYMpoZQ2uUkGZ?=
 =?us-ascii?Q?pzawVcEURy/EE/hgT686FzW4zo+mCljTV6auOjYtPqfKh2zTq217Q67j+J/k?=
 =?us-ascii?Q?1OJadZ+KNlo8amNZyr5Onq9NuYaAL+/FiUJGd1ZYkv2AGT/xVCVCISRcX669?=
 =?us-ascii?Q?lSgs4p3lr/5yfW2gvg5tyXDh9mgoXfGZIs162SZWmKDPujSVSdNsZTSem5nC?=
 =?us-ascii?Q?zZF9sSjtvQnHSeZSkHSNnKoA0aXWsSHHA0+bXv6UR4Wto1iHzj+UfL1OE7/i?=
 =?us-ascii?Q?L7ClZ83UbCfulHQG/jBiPBbJeqQeOklxoAuEPDtabedQtGyO9H5XCKfNKsVL?=
 =?us-ascii?Q?jOKOC6elyF1mlX3RrKmg3/EQaWDVTj2BEjTfhlu4cG8tD6iGEcLtqAvb3gLx?=
 =?us-ascii?Q?4Ffk6qpjXw6+3D1Hl2b9dQh+5MYwwfJVIREGU0fvz/qqa71RWHKMoi27efgE?=
 =?us-ascii?Q?vOpV288aZ9hKyOHOwXuFTU3uXKRiu7efKWMgHUOdToZvcQ5OlmDkn6srAwQw?=
 =?us-ascii?Q?VNiv2Wm0QSwzgX6FiZSHwO21qnCDG0HEj/J5NWywrtry4+sSxhvZqX9hQBgP?=
 =?us-ascii?Q?89dl55NmpZC4lMnBbu7rqOpP1GiJkpP7gNYLbCqBXURLKyYPmlV8n+B4q+wu?=
 =?us-ascii?Q?oSntD5P7PQ+KjGK/iKIXQusTZtsanqECm81KyKGNeE/IDZ0HqsMuWsMcWJuC?=
 =?us-ascii?Q?h4QRQje5HpBHsWiqGdLf2PDtZOFFU8oqIUlYqDDTHDE2mOehPBX17/czX1LJ?=
 =?us-ascii?Q?nUwxCsqupqXYKYTj/VnhvU6C53ffStleLAW4xzAyyj5jgh3SXW5JIqwWpR8f?=
 =?us-ascii?Q?yZ/YqSl1MwBLqk9jlHkESIUcolGl3TQjJgmL/OtYwqredBondGWkRnB1VXAn?=
 =?us-ascii?Q?p1thJF+8z1eW1Nl24Qyu02tIOFR1dR5nEBnOLHJp49y32Yot9vSHXDZo8S4e?=
 =?us-ascii?Q?llp9ptHIDDBf/6S6dIiHiiopgxhj27xEm0QxyETpx4ea3VpYcyQShB8Z7M/X?=
 =?us-ascii?Q?YDIDbrNHAlr9bdH6E9BgL5D+TxXVgyL4Cg6w85PcttHChdbTtGDwtscd2lct?=
 =?us-ascii?Q?vYlFXfMx0kouIrMjIEkAq0o7XtFQgpAUYsd6DVGZa/xKY1tG8AXaD5wZcPrB?=
 =?us-ascii?Q?Wy1PjcRxrU7jv/+WSdfjByHeGgx4bgX4n32E8sEH3PDWmZm2noTjSvqCzkDF?=
 =?us-ascii?Q?4CRMXtRnq7Hk4BNBKXtztLvalMunaK+6eoX7OSwmXBfdKIcceZ+ciJy1RMyn?=
 =?us-ascii?Q?TSndFSqFnTLQVErfxzW9npc/FiutOvV1TiAS+NDHeBUEby2y8FyN0+/tem3g?=
 =?us-ascii?Q?54fqAmG++yoWnVt702RjyH9f7wkP7SueQ1YfAKV7MzQbe4/dvGsggi01on/H?=
 =?us-ascii?Q?QMUwc0ZrT0znYCIRuBaHB5Nh2rW8XJ6rRs/3gBSGDRDNN9m79D1TS6hckG50?=
 =?us-ascii?Q?6PDE7RmMOK7W3WwC+RlTGRXik98/UXxaBOzVEz10HrkOkQoaMG7tGaUd46/I?=
 =?us-ascii?Q?eXrJdEHHwMrZ/SMMveiMR3Njx8Zzxe8dUM0wXHxKpsOgULOR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b224616d-34bd-4583-d00f-08df0a8ef7b2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 14:15:26.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIplqGmouBkyhgcDk/+8OaYt9zly9KHSSEfrLWFTs33++foTK0tBR5jmDbbCO5HG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210

On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > arm_smmu_setup_irqs() has three failure paths that leave the priq without
> > a handler: a missing priq IRQ line, devm_request_threaded_irq() failure on
> > the priq IRQ, and devm_request_threaded_irq() failure on the combined IRQ.
> > Each path warned but kept ARM_SMMU_FEAT_PRI set in smmu->features.
> > 
> > With FEAT_PRI still set, arm_smmu_setup_irqs() enables IRQ_CTRL_PRIQ_IRQEN
> > against a handler that does not exist, and a later change would then have
> > arm_smmu_probe_device() call pci_enable_pri() on PCIe endpoints, allowing
> > them to issue PRI Page Requests that pile up in the priq with no drainer.
> > Separately, arm_smmu_device_reset() has already enabled CR0_PRIQEN before
> > it invoked arm_smmu_setup_irqs(), so the hardware queue would stay enabled
> > regardless of what setup_irqs decides.
> > 
> > Clear ARM_SMMU_FEAT_PRI in all three failure paths, so that subsequent code
> > treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
> > returns.
> > 
> > A kdump kernel cannot service page requests: strip FEAT_PRI when detecting
> > features, so downstream PRI setup is skipped.
> 
> Dumb question - why can't a kdump kernel service page requests?
> I'm nowhere near familiar enough with that stuff and I suspect I'm not
> the only one who might be in that state and reading this series.
> Configuration choice, or a fundamental thing?

The initial issue is the streams are left in whatever state the crash
kernel had them in, so it can be generating a bunch of PRIs with no
place to put them.

Though eventually we may find a device where dropping them is not good
and they need to be NAK'd promptly..

But I think the real motivation here is to save memory in the kdump
kernel..

Jason
