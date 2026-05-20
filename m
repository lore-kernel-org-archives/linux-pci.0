Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CDB672;
	Wed, 20 May 2026 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237033; cv=fail; b=R7A7fklVepzhAkC+pnw8oYYT+57gCj/pbrVfj5C8FGtqc7cIwLOyhstTxMr5NsCjitFQbwXa8nx3tmeSPJYrnaVbAYyiKsbsZrtCp7QQdDlA6z4i90Egl3zMzVcIVkmqlLB8rFZnBgbDenHEfHDJB9Lpk1caoA9O7j/6hf0boVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237033; c=relaxed/simple;
	bh=stGV49GQqEDwlmp7RX72w9rWv8ZeFRlgjiUi3U/3YyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lTIulBOE4pRF8qfMZEPPpugaDd5GBj9EPNBsHbOwhTsjocuYGxSmVA8J94ZF2XmcuBOBu0S5KTr0VxVt+t377YzReaEbGnn/2tL4ptDszNO+lU89ZYwrQBbmM9D+JO418UvyjPrCV2+PLWe1VqCRoCojUWZciXZCdwAm2du/LBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLHoYdiV; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLHoYdiV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkwoapLSWjsp1NGZ7rE0YrnyxOVHyB9gPOngY3LWh6507sHPoUwg1fzyyMlX/0IxTQFvQUKyaDT1hyAstt1qXeMh3C/plbPdWURdTz6KqRgnuYSqclrWRzsGEhRZ6fEh3Y1kDPyQNHBsOPJ1ycbOy0RBt9PSasen4HkzIjwqp+N9alfWv6x7uwGGAj6suQbWvpQm0b6dfT13+P482fmcIyMJYCxR4BTtN5wAm/wHMzVpStgPuYQRX+buZNvWPWoAPC/pPYEsg+igZT2c9isz9m7M0q3TyQne/yC+zFAR3SfgA7ixb6p6TAnk/bN37xWv9SD0/xwfnBGoh2OsL05wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzd99xfaAKx5SF48hdqihGWMFwtKCZKDsgmOXAR9fhY=;
 b=lVEYE5VpBjbXLmkvv7CTZ0LYjjFB0Rf38AH79q2OffPcsdftnHAOlnoMrMOWWq5nbwFlY0QNHZ7PbjVH/U6/aLFgmtYtGxDKi6PJZS1j9NJYCPdH+5KaGf9aQ4C4tpuzdYU5MhQQaCHXiLwzrczDdCC1+rFSFHt8C6ft7/SYnPGpwK4HzmvTGHynIVeEUqVeS8cX6BsCD768chY7GNBVUkEuHWiWd9WQWgRaXxIMGWabcZAlPq0Lkzq1taMPVbKsPwNQKmDziPEp0TLIHpgeDMT+fp6exGufQzmCkHjBS3T4vL/m4pPbICgt29qdIt4shsiqkQgwwz2WCyymfA06qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzd99xfaAKx5SF48hdqihGWMFwtKCZKDsgmOXAR9fhY=;
 b=fLHoYdiV9LkfG/UtdPuny2TXp8VnzVqJv2YCm2nPL814e0xs2q+ycVMCtXIQ20licsZ+T5rAr4Hk5Zz+GRgktQXe1UdYhy+2HZzevXan43zD4rZ7EK9MReegq2TQA7PA5Iqqa0ZQVyyL6TBgaHfs8pDh2Rncu6R46WnTcHJ6lFM7hq9UV3WYykHxy7O0KT0UV9nr6lb9usFeBdd8kwuK8f5M810GKELypSkR9S7gUjV0r3LlBmcfW/1uyVY6YwHUcqNl64aEiU6yjDYyCXOeFsX4HKmGQXnOAgmHRz93CswAafJ/aunJfbM1YOOOTvVgq+W3BDtJwu6KDOfRT7Xe9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 00:30:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 00:30:24 +0000
Date: Tue, 19 May 2026 21:30:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 11/24] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
Message-ID: <20260520003023.GR3602937@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
 <20260519120737.GQ787748@nvidia.com>
 <agysAyreCY4huf0I@Asurada-Nvidia>
 <20260519191626.GJ3602937@nvidia.com>
 <agzkldmlG1cuDkj4@Asurada-Nvidia>
 <20260519230204.GM3602937@nvidia.com>
 <agz+kL2S8kcgHywG@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agz+kL2S8kcgHywG@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc68b74-ce38-4947-b15a-08deb606fb9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|4143699003|18002099003|56012099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	/uksNHkH7ywpwmailEcn+VY6oPMUfzg+fBbJtFyxQ1G5m8PbmiuKRd3urfnTPfyhnPABV39ET2ZNBoSaa+O/RvjapiZwRoaWiKCfcsus8Is1kFdTc+SIY/mzkAv78wfmVl4rGozGfRNxzFeBbgFdgsIuRArJK4UfrWxRy4IEUNLfPn/g3Fo97qXQIsEKUA+BZnd71xQmQ9PfXdVjpzkI5c99P0fuySOAVu0CDkaEVN5N0TSsExiqskE5LrKkSTiHWnh+QPtsiIrmOdkg3T+KmjZzMSELGvdp4GmZyl4sJOgP+LINVyl/K3Tchlv3mJitCkT6xb8Pm6z6Pw+M7v7d8le5ovMxGNh1KmDOybS+qPB7q3uQtaEaerLa/KJbf1x710l8N8kAVUYaEptABnk18adqfwbehsDi1eoa8WCt7gMosW3wrJ9vyuv/LHMlRavk0HdGgropK73ybiVtavPI8THhbYDVLixeGHr+y6B/wA/r06yE0oEckObcZRpBxEBb1YbWe2UuXiAIUp0UR/+hfXxwV0Lqj6bHLQXfWO8AxsNVEKI99gdT10o64r0d8EI7iWTKzCwn3tKMKx2M50Xe+Ez+GCeb6P41kFYt+WlyP67a6QKu7Uex4+vU47J3QapKGH20tdcM6h3jQ+jDWAt2qp8XckO5NXobrZ4bEIU1fLkxnYjKVmhpifBb4R6pVvnN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(4143699003)(18002099003)(56012099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ka1nVKno18tOws1z2lkVj9VZqiIgf29Pq4nweJLwouV/45RolsJdCFfB7Gn3?=
 =?us-ascii?Q?bJ+KOTALD64teoOrxvd65FA2c4FJqR9XKV7q3CJhYdvHau48ABuUnfFTxkfU?=
 =?us-ascii?Q?6Zdy5UTn7QKL82LeqVRqJ7lUahiz5H1PlRGkmkg+2Gz61pOphcQMhhjFQrkL?=
 =?us-ascii?Q?0mxdvH9fXWyuvqjcmZcp+NpFRtNVNE/0AmPhuFturAlXpTvRlZF4sve/nf+y?=
 =?us-ascii?Q?zR/0rtojVRwEw0EF0nB8nsC/mep0Fh8piVn9e9M4u0PqtBa/eap7p1RMouz+?=
 =?us-ascii?Q?g9cFcFRy9p7dhEbjoVYoznmE8xrYw6xXsP8QNOhRHr5nxE66p4LdUcZi7OMD?=
 =?us-ascii?Q?KHzZ3qBiChsr4Ixs9E32+6p3OVaRG2TubvvVc+5lbZ/in+KnqcCzpHIkihkI?=
 =?us-ascii?Q?YhxFvdHbnfkpJ+KmQMx0ZUlJwTXUdY7wMYNv5yQhPpupzbvV32dQo2yzhpTM?=
 =?us-ascii?Q?GmDXK33aFykr8ocBciMUo90xgdoaCZRvZ+9DkvOwx07mksS3mDTi8v9bZ3lt?=
 =?us-ascii?Q?xWtKMal5KuGG2+JTKNeoRa3h2+Wky2easG+ms+XwX8zPaGp4Zjff24/Vajuc?=
 =?us-ascii?Q?WCO13Nc0pO+TCnHiBieGf3spl5K6CJ1NPEuj8g3eifXFgdoARuwazJqzbgxH?=
 =?us-ascii?Q?BNEPen4K6thIXBUDaToHZ8bknPzLU4diF+fMAeE25s8NdCXRUB7x6sKZuao3?=
 =?us-ascii?Q?UhAFrBJ7jsQAoiBr3dt4KW7efHkgaJutPodqMotsylHPlNlbtFZbpUbYySuA?=
 =?us-ascii?Q?vUY2pEZvTj66QWCo/751iAJxyxl0iVWwieo6nT3tz3RiH57OYQuIR+EudoCe?=
 =?us-ascii?Q?eCOmbDzOu0I+pjNWB1raONJyksVr3yA2ed6u6YrMACK3kf5tFMo/ZD4isAxl?=
 =?us-ascii?Q?znB8cMQvQnHw0frVwBDWC6ieis3abhuKmva3slE2y+U6fRRw9/Vxmx+HtSJd?=
 =?us-ascii?Q?roRqEL9ovBOvjxRKwDzR8wnXc8E/LJ0E2my2caGanqj0D7H2SOHdJzieTNVk?=
 =?us-ascii?Q?9zf1MYq1h5SRv/nFE2T5gyxaWt1i8EDWVWi9ptDOx7F7MUwmVwj/2CDPtvEX?=
 =?us-ascii?Q?788fp25QSp9u4xVCeZL9nSqiBpHtS9gVbfwgcUm50/rkYmR/AjSE+MtyIU4p?=
 =?us-ascii?Q?Qf1SsMp917YxsBsPDVi2Sulvo56reiy+NLcOGdIasrKRdsK41wXWRCoXgqCL?=
 =?us-ascii?Q?TWUEid1CAzPwy/BgCIa7FVTA+hkLMYhEHviPjiFKqHwuGJpB4qS+lBvWkgbc?=
 =?us-ascii?Q?6Cmz51eHUiYzRfMPOUhbNc9pMF+LLDEXCAxyw4VURdk6Y4ptCLWD8WZ+owV7?=
 =?us-ascii?Q?cuOvjbkt4W8yr/unf9a7gCuH4pNt6JGfzsKLmhscHR0TWPH6o8tqYFJTIKCc?=
 =?us-ascii?Q?OXLKRS4s3uz0ofQOopyrkTdCRcoMRwEh1Ucm7nM0+erhzJY7nE1eg6/X3/KT?=
 =?us-ascii?Q?Aq0SDbe6/HM+upLUmsOy370DMkrikT+jPEHXDjOtUNLkb23nTl/X/9m/9JL+?=
 =?us-ascii?Q?Gkcup1/FvjPxTiQGgt27dKeFqKrw0kQYPRZBVHUwH82PzPoO4W0AuCUEfVbd?=
 =?us-ascii?Q?RvoUpq+lpekDoC+QOIf5QmpY7AjkJmFNejPnT3SZ873bwVZ8eF06aq1fW9yb?=
 =?us-ascii?Q?0e3CJyhU7M1Z63DY+qeS1Z9uR5FZM+Hob44UPp2bvyFVvcOcP9OtwSZRR88B?=
 =?us-ascii?Q?DLlIITgMPhFqMgLYI56xliuBFxeUgweJy1RUNxj2p8psUkjM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc68b74-ce38-4947-b15a-08deb606fb9f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 00:30:24.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlSGsBBHd06koJVy9fkTtasQalOfIcM45KmCLtyvuYOBpU3nnafEsaAC4swsf0A8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

On Tue, May 19, 2026 at 05:21:36PM -0700, Nicolin Chen wrote:
> On Tue, May 19, 2026 at 08:02:04PM -0300, Jason Gunthorpe wrote:
> > > OK. So you are suggesting a quarantine at the driver-level only:
> > > 
> > > 1. Driver detects ATC_INV timeout during an invalidation.
> > > 2. Driver retries the commands to identify the master.
> > 
> > I might argue to push even this out to a followup series given it is
> > complex and I suspect it becomes much simpler after the batch
> > removal...
> 
> I see you suggest to treat the entire batch as ATS-broken. Just to
> confirm: without per-SID retry, that might falsely block a healthy
> device in the ATC batch, right? The driver now batches all ATC_INV
> commands via arm_smmu_invs_end_batch().

Yes, it is not good, but a giant complex series is not reviewable. So
I'd start with trashing all the devices, then come with a narrowing.

> > > 5. Driver sets master->ats_broken to fence concurrent attach:
> > >    arm_smmu_write_ste() and arm_smmu_ats_supported().
> > 
> > Not sure this is needed, if we race some attach then the attach will
> > re-set EATS, get another timeout and clear EATS. Doesn't seem worth
> > trying to optimize for.
> 
> I didn't see that coming. master->ats_enabled && state->ats_enabled
> in the commit() for a concurrent attachment would issue an ATC that
> may timeout again to re-start the step 1.
> 
> And since arm_smmu_atc_inv_master() doesn't use domain->invs, it is
> not affected by INV_TYPE_ATS_BROKEN. So, ATC_INV can continue to be
> issued in this case.
> 
> Ah, I feel that we are walking in the mine field where every single
> step could be a kaboom. But your insight is clearly a safe pathway.

We cannot eliminate parallel ATS invalidation. Two threads could be
concurrently processing the invs list. So it has handle it, the driver
is going to have to tolerate a number of redundant error events. It's
OK if the unlikely case of parallel attach also generates redundant
error events.

> > We do need to push a pci error event (didn't see that in this series)
> > so the driver can catch it and start the FLR process. I suppose that
> > will still need to bounce through a workqueue, and once you have that
> > it can also set the blocked domain prior to calling out to the driver.
> 
> In the specific case that I am trying to tackle with this series, I
> do see AER error prints from the device already but there is no FLR
> process. 

It depends on the driver, mlx5 has a FLR RAS flow for instance.

A driver with a device that can blow up ATS should implement the FLR
flow if it wants automatic RAS. It requires driver co-ordination.

But I wasn't thinking we can rely on existing AER events here, yes
probably there will be AERs associated with the device exploding so
badly it cannot do ATS, but also maybe not..

This is also a problem if we shoot healthy devices as the first stage,
there will not be an AER from heathly..

So I guess we need to decide which is better to tackle, the dedicated
event or the single invalidation sequence..

Jason
