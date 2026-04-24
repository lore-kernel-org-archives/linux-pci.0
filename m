Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E725DB12;
	Fri, 24 Apr 2026 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777071506; cv=fail; b=I0KoL5V6E6sNXp9q6zGcFgEmt2m7ReFo1clWSWjYzp5BteUBwvZkx6guhTg1PsqZ79Q5AtkTNm57DJEgE6Jl5lrkPl6gqwWPyp1y4RY2Dbe8lYLGrsskmB3sy9c39l0eNzKeLrk2lR1ao+L8eTgwnK4hQvueKVMWTH1DL4GDzVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777071506; c=relaxed/simple;
	bh=n1So5/T89/cnjViz0r+kMGGhz+p+pPcaeiSkJS/Q5zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bN/r8O0QJc5V9w1WfkA9tpwLcMkbtVCBZia8Kg9AkU/Ye7HBTwrhxXQXtLWA9zzBHaDv8l0flO4deFIPqno+uzKrsP7Ql/GidU+gLrMsSVkQA0PqvVnuHU5lvBb4JO0HI7FYJZwNCq8AfeJlx9s7TsX1uzm8fc43AOAwBMe7YhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fhMWJyle; arc=fail smtp.client-ip=40.107.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fhMWJyle"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUlIxQU7JO5QLYDHS1wIrU74s1PmcgM/wf0rRHYeHbJuKtzsgLhRP7R3XNdlIv4AmHRCLQ5e9NHAYbPPBzOdlyaensvVq2LPlL/YXkhYdg/XszRzGqheByVktZSZPPhr9TBEDgLDnJGJrpWV6fzxiz6ZRY3EaNJU3Z7QysX9D3VD6j0iG38PRB2zshHbHsEJUv6WFK531K3rTZ2NfJIjDgMzNu7j3a8izv2gEmJiABQMcr8EbMhnUxb9SoxIY55TUyTnKhhryIFaKN458U7caHxSpuTsFvqBqxDDc1YV1hwESREq3KTyziYsD0/LtEuS5barSB/s/RdQz6PFNS7L/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIyLrmJdaU6lHqer63thqt59Jd32JRWFrA/W4zN/LXk=;
 b=HFX/9JmRgFLS7NtgVtuBABb6zSc3u93G4XwzKyyvkPumhNJcfPooiCOuqndf8/2SW0G2eSqMtzVKthJq/Zx8wFK+3DqNskPOYOnvXwjRVfKNwJqifH5ZKGW1FQtor2QWtNFN7vX8DRmAeRIfXg1jR26na0GpEMhao1UCHvaUEABPF40pnY6ApEB/yPQCyFqpwWiBDseqOv1EoTOHFn7GhZadkde6n8pIaE9pUWUeQFr5zD6X6quOUz1XM61qV29mmRidXIFbEbKe4Rp4aBNZ1wkeMU5dRaatloUhl8jZJuziYhl0Uy1TUGk3FMIa/s6LU21VguboLIML68W9zNLwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIyLrmJdaU6lHqer63thqt59Jd32JRWFrA/W4zN/LXk=;
 b=fhMWJyleUCA0vxbp1Bse/c86mbWZ19glx7/s7SVWY240gVF+NyvSVB0yQifEWFDNEtGCelE62XmbdBU26kxRDUkJN4bkQN4R6kCmtRd1W0YRsNP9gLIrOsPDJOe2FkWR8as2ma25ZQr5iZTSUWlBmK1NSOQiC7e1Nk1u0ToPGKTRb0iM/PPO6McWKmCuZBwrX9UYkViaImSTlSYlWFfAldL1wH866SYfy/J7Euc8bL9sptP5enDdOe3H//f30YOcnvxxJHuxDTHKplZgPiEB4C1LfSmrNoRypZsJXRFV1HvBl6QapUiHAdO6x2iloA0nOvFDp/qXeCJ+VqepQmRxug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Fri, 24 Apr
 2026 22:58:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 22:58:21 +0000
Date: Fri, 24 Apr 2026 19:58:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v3 05/11] iommu: Change group->devices to RCU-protected
 list
Message-ID: <20260424225820.GN3444440@nvidia.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <12a224061de4fff9e0725909fd0ba4e14996ff08.1776381841.git.nicolinc@nvidia.com>
 <779dad61-d7e7-4ae0-83a9-8c5920222219@linux.intel.com>
 <aerey+ULGG589rdi@Asurada-Nvidia>
 <20260424131148.GB3444440@nvidia.com>
 <aevAqKFq7ATYk3+i@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aevAqKFq7ATYk3+i@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:208:235::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c14ff94-ee2b-4e14-138d-08dea254fb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e4BwbU7x3BT+cfSPWm28EoMTYm3IuppVFnq9C635Lyz+L8RUN0pXPY8ELqQ28rsv5Ol4URknTg3lQHiU/8cAUov2DsTkycpCrgIud4xpfF/4Ll1rZf63yGt8hl6Lh+bMTtKtOocpGCpmiSCAbST/Q5djdrLJqC5i/TORn+TZtyzInQba9YrPEuZr6v/fT9xcEMua7JFog0YHegTPIrqwC76MPAcTQ3z45IJuGxoL7NupD6zjygADcvOp0uiTBJ0DELqQjsY97Qus4RPvFpevYZp8j8XdwrH/yhGMsxrl1V+HLtf99M09YiBVkeYIwr3h1GSGWUdtsxrgNHdgHWPmPFWAIkouj0bBDbAtnQGZZaTEl1z/SMOGHBF3jRj7Dbm2PSmhRhThT4uZaE5FMdlQdb/fpuiK01Hmwkd9W+SZBPjlFV9FCGp5hA45Fr8uzMn+KVifWAU2jKs2Ypx+wur60of3gd9nr9dC7yqvxu/52ilMihvySXvZiIFBqgmKrdIAnbeBBTm9iUfjS9Cv5DWz79zZ8sBOzRfTeOOhsgjKi+VYIcptq2LHqc4SvuXjENGVNdGzJa5V1vMKTBDrHOYr0EJC2BrBk/WV3E2A5pBy/cNAvX8Pcfe04u+8BVoGDX2sNmpYzvTN4QYw8BTh9kSFzeYvFvnEAmFdxLZ0fhRuV39UG9ktDoM8mZTDE9GISPQGgXuGhz5coz4ewjLJwbjX6VGdo+y8qo56LUNq7InI50c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YNRwXEAT5iYrNwGSneriG1INQb+byBMSPIihU+7s62KBPFmiKf+y7qkBUWyK?=
 =?us-ascii?Q?a1Fs9E4hcIbUrla53BLhO2x/RfINPh6iCjDqaEX2anJfXWzQFQlK1DKf1UNj?=
 =?us-ascii?Q?eC2/+95rDxFTp8N8j+axaTahy74kCwU6TVjkeOVtlFZgyqjbk8ISuKIQ42Nu?=
 =?us-ascii?Q?OsV5+lhUS9UemhrzSqHhgyjve+c1gZEQAhPUBpW59gJp/jdwAfJEvSyCcwVy?=
 =?us-ascii?Q?gXwc//Xh9A7YEIsAa9mpUcItbLGn0dqJwX5d1ujEt05rbs2eMxiBmFs49XyQ?=
 =?us-ascii?Q?Po8Pt71KKlpYoCTI7/6F+4IMtEBw/84wevj830xdbxodKm2IL1pDndkyS5jI?=
 =?us-ascii?Q?9S2Uz7U5lUVLCtSbT0u/yP7ceWxZcoBhV1qGl8OP2pkVniYREld4XxNDGqYf?=
 =?us-ascii?Q?lBvoYM3hbF2y5kS6bzPTD4t1FOZBBaVw0rUJ31kFB2YxvOli28FykmYkkvyp?=
 =?us-ascii?Q?t7pw5RtQieuwTZ07Yu/ZnHZ9gKU5H4+o/cJ78z+TZN7iF4ew0yJ0GA4pH2tT?=
 =?us-ascii?Q?41RAQmQN+4rnlJ4gEsguFKlRMlj8Kx6p6WVw2QapU23yJonXqg5iCBnOt43O?=
 =?us-ascii?Q?8QL4jaPiZFjc78ciszWM9i+ldqAM9DeMo13GASosSt1Ux8u1my0s92dr8wqs?=
 =?us-ascii?Q?CqGL/HKsAVaUmBgkyrbFl+9RxNqYTumYj7MNPZHoY/xIRxJPw4xYlCYfA1BZ?=
 =?us-ascii?Q?0EkKXPhPplBOJr6fkU3+JkZ+qdU4k8VpfCz8Q78fJE6/XDBr79XYj8FQXbqN?=
 =?us-ascii?Q?CRrvKvmcLruJIk7x86LgXftqFueTgzV0Xb4T5cMOvQf8NonF0RlwxvSxPr8a?=
 =?us-ascii?Q?v55B8lSM/N2daFc7YqKKBkJdTKSy/w7CRL/XBGFVSAfv61XZgIhPNPkFCK8G?=
 =?us-ascii?Q?1qZSsjRUqwqS+l2x3nlzNj1K8Uoy/jhDTUBiZRnHk46V4U80/7LWrvWIp31l?=
 =?us-ascii?Q?XQ6T+cLe0XUHIm0vyWzyJEpc3JkkxgOFzme7ZY9K5YU5L9a0nHUx0OLZRQD0?=
 =?us-ascii?Q?WkkLfr6ZOfv2WiUtNtUD2qUJQijvwnlhv052HA/RXMO9q1pinNmg+QiIdQ4e?=
 =?us-ascii?Q?+3rKsPsI8JWWAEmvvsyND5vxOhnnAO7Mlae2vVDpkpYLIzyGPLD6N3A4Y9Hr?=
 =?us-ascii?Q?EMO7mVD5MHaDttCPXU939kSYmM90Ka3rjAuo7+CpdxE7Xm4DtZ3fu+mOYOV4?=
 =?us-ascii?Q?mPVRtHPzW/US5dDSNhI5sbQ9Lh+6E/1/RdSvykPNWWPaDc3VqkfegEbfKGKT?=
 =?us-ascii?Q?FQP7qQBydfdEqYBC8e2vR2vAmSYjbubK6Z3VRNqGIBpz9gHH/V5aGVMunWJs?=
 =?us-ascii?Q?C22m/PO+CTOSmmDcXV8qA7YgIVM3CdD2ILPlDD0UxAC33MSqbBA0Z3JGQtdy?=
 =?us-ascii?Q?O4VK6CDmp8S5a6OKhlgwuRDpwv52GBX2q8t84R2e5CVccwZ7MM/MfuGvCnjG?=
 =?us-ascii?Q?ujmn0/57NEghoP2TTh/0Gkxy/UbIdhEsLUyhkoVnl68SgZiE54sT0DAllc/o?=
 =?us-ascii?Q?ccmtfNFAgcKQeOXYO95njcAjgU42QmnbSu4hC9ckm+TTDJRWFRulr2KFBDqu?=
 =?us-ascii?Q?GKaJ6FayFzPSZ60lde2qQj0s7f7ob77gv6jNw7ExBpKQqSC3PNHVMm8+Mq52?=
 =?us-ascii?Q?toYnkuzKfoJxcLwTqHqgKmumrklwq6V444kEtRYeHnSK0+4S0GNwG025LlFo?=
 =?us-ascii?Q?ijUqt5ipcHwVu7qcjjlXRpZWbA6Mh8SXODNGXqx18i7U9Qh7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c14ff94-ee2b-4e14-138d-08dea254fb6a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:58:21.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlDscv+2Fep0sLGFleKvhdULy1sCYXPfhy5swrIyz/S8XA5nzZ9alt0f1UHeEkZO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B

On Fri, Apr 24, 2026 at 12:12:40PM -0700, Nicolin Chen wrote:
> On Fri, Apr 24, 2026 at 10:11:48AM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 23, 2026 at 08:08:59PM -0700, Nicolin Chen wrote:
> > > On Fri, Apr 24, 2026 at 10:53:49AM +0800, Baolu Lu wrote:
> > > > On 4/17/26 07:28, Nicolin Chen wrote:
> > > > 	    mutex_unlock(&group->mutex);
> > > >             /*
> > > >              * FIXME: Mis-locked because the ops->probe_finalize() call-back
> > > >              * of some IOMMU drivers calls arm_iommu_attach_device() which
> > > >              * in-turn might call back into IOMMU core code, where it tries
> > > >              * to take group->mutex, resulting in a deadlock.
> > > >              */
> > > >              for_each_group_device(group, gdev)
> > > >                         iommu_group_do_probe_finalize(gdev->dev);
> > > >         }
> > > > 
> > > >         return 0;
> > > > }
> > > > 
> > > > Will the change above trigger a lockdep splat due to this "mis-locked"
> > > > case?"
> > > 
> > > Oh, I missed this one. That's a good finding!
> > > 
> > > Perhaps we can just change it to list_for_each_entry_rcu holding
> > > rcu_read_lock() and drop the FIXME.
> > 
> > You can't hold rcu across that function IIRC
> 
> Oh right. I didn't think too carefully...
> 
> I tend to keep it as-is. So, maybe just list_for_each_entry?

Does your series make this existing race materially worse?

Jason
