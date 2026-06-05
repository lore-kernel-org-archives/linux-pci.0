Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82D257ACF;
	Fri,  5 Jun 2026 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688589; cv=fail; b=juyNWg65y5wI9S0+NbTiFy1efuNTBlnSN7Ia7C1RQmuFoWQIoHyhGZAprdm4Vh5JNkSdEf3Sasu00Tcu2odfAQHIavmX7lpbPD9Ngd9D2ZpUwEcoKcV0LDwp2k0GAB+mbnwP6hykAyFaNsuuHWfOD5fJ4v8UKGb7okdCefbWUUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688589; c=relaxed/simple;
	bh=rMns5IxQBr+QVqK5Bq1FQS6RoEp57G7dqQIUDRa//e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FlM59UsLB0qKVNkPrkTEeUoAhYwTrHVobWEd97ho1z20606KUnd2/r9pFB8b36wbynBWrhMABZhkk7eDtMjRuNONgVFL2GKRuLpCmjFk113BjfDKRE3Ltl08HFtPXEvJ0/7mTcWnAz6pv6pkBEIfKGQsyiBF7LeTBK9lKfKthQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PmnpjfuY; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PmnpjfuY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hfx+EFxiqqx2RcQj3YanE+EDf288xh6Pqh6prbYfZmZ0ME7aP+1wqf/zK+sbrvuXe4ffI9BCj2JUVqMkwtkv8pTCKB2y7iwVquactv4aTgXVxLEd53qH4dw90xSm1w6+fRmhhHplR+U+S9ieXmFrLXTHgEmiWLFjFpwmjWRQzF/5Qh9Z5viGHby3z8ymJ8RtSL1cuVlrspLAln053MLj7j8xza0tAkRDqwo1jrv456tSGtM7d/Rqzh8Y1ZpEvgaIlhaFM/bebDXNWRvtmejqtNHQjuW2bsSIh7uUn7t2DGlQGNKgzwWiWPkjtXijpIghrgnvzsIIyxngm7ToazFsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBZRp0KaBQ+76913pWkiHwE610K2H+OXh3TaILdezsk=;
 b=PNnxNrYMeTeuFFhgQGKOf59zhUK7tUNOiIHXCvlubj7yOi6OLN+M3yBdcm1XOTzBkIhltz5s4+EXWdtmYL8m2imj2SQD5cNJ2CyDV+S9Oy/vt7WfM2DYmBuVhBBzRFfDN7ZJXdbSNdI0kfUyMlsLPQJZo3jX6IX/j5UaGuXVuNUJpvVMWFOkZFS24OO5CdkhROOYYHXN3B0oXTomj2xFxikTXSRRFv6B64wLu13CilmqcRKs6lADUKpxkcMQ7zvCsslzirfDCriSVM4MdP1/2LN3DO7Jf/h/WvD3VM4z+Tki0awnVkQWqpwAVv7UxaiPya6hU2kFgk4ybDrga9wtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBZRp0KaBQ+76913pWkiHwE610K2H+OXh3TaILdezsk=;
 b=PmnpjfuYzJ3F7KngOo4M+z+KXwxGk53SBiLhHP0QM0blsjGg+qfoYCXL91A8j4uyUI+B0zcDIZuja9MWMpBzqsw44kx3zeRJGrSVqK9VFDSc+EO4bsKbJmyDYPcKdBDLpq/bmVJpGfkyDlMp0LAOIxypZujcoI1HW4qhZ3NFqADYrb44YpDBA2BQQM6N1rcHs0pvzofFL9c8YrmNTaIz8E025MCajOOqignX7iwDVgRwHsIfeaiuboDU5olhXoL77XmbI5k3tbIzibYdpvb2+Qzwh/osPhxD3nZ5v4nk68Q3bqzO9Y3RHLMG6Pwnm3BW23SmDHKz1GIU+wFyU376tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 19:43:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 19:43:00 +0000
Date: Fri, 5 Jun 2026 16:42:59 -0300
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
Subject: Re: [PATCH v4 18/24] iommu/arm-smmu-v3: Introduce master->ats_broken
 flag
Message-ID: <20260605194259.GE1962447@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
 <20260519120658.GB3477375@nvidia.com>
 <aho9DB6it2R5O5Nm@Asurada-Nvidia>
 <20260601123231.GG3195266@nvidia.com>
 <ah3udmX5SIO9lAXR@Asurada-Nvidia>
 <20260602001547.GR3195266@nvidia.com>
 <ah5txKCvspL8zMeG@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5txKCvspL8zMeG@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 917b9185-e4d5-476a-4853-08dec33aa691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	Z7wc0Ds5udv5v1FlOtahq+ZLoPaOPcpPgJt50FQmespOSR0vcWBo+qCroZsuPfYsL2810RR7Q3qCxXynY4P4CaqSER2BKsg0lU2UJfDL7fB2F5ZrdbKCfPFlDdqYramHpB9CPQDvwgU45JYnq2nONVHmJpHPWlIGJktD0im+Jh55ULIbgnRvis1q2XKL5oviwBMNKDrR43wbO5kZ683opfJfVV7nvMz/iMiPoJWaIS4ESxjQVjAQNy9LX+0hLWdf0UyfvL0qhuO/8LfqasNJ8goihApAv41CI97qGZITTt3+P70dt61j/1dCfF9cGiDmBR2Gfq+jAwwLKInJNm/ecH/ls6URX9voMQqBbCuoqbmfqu3nqPktHujvowzKGdyDWI9MGRWFZ9uVZbZXlU5118P18ms4A/zamzK0tYuOeAz5nWCAzI/9PD0JTUmFB8KMOhxK8s8sThBqQerZb0W9kV2L7srwnrWY1XLPmd0GrVPOAK++V8KQtUVIPovnaAMMusrJCeEu6NPvnDu1HoBczOrl9DLAkGC4x9KoepFaUv/DcrglTANkOIQ9G7xRM72OyGMAQcAirWJ8Ttb5dhIBRLQ/h+WHwRMW0rUTFwyNJUocJrtN4Xlr3GBERz9Gn/hk3NIIEODBaBfXJXyXFCUoQ4jdmmk0+0M0z3/de5qfftUI/0TQtQTZ08h40P3ca/BA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7abrtNJ+AYNxVtIN4NiE/9GKLCm47dY/0kLoTAUzrwc+gVecxc18NjT2rp8g?=
 =?us-ascii?Q?sf2mKp7VvGpAfnsRTajvj3sd8IUEOaSXrgvvr78hj7ZqsarwGZfdX5A+i1xe?=
 =?us-ascii?Q?1/T9FsfC1r1R4GDST53eK02/yYkCoJHZYervfUYlScg9i78r114zfgLZ8c3r?=
 =?us-ascii?Q?uvudjxjhDlpWiYGNngCmscahC/lDYl+8y5kzduEeeJtw7QojCokA/91kjmQX?=
 =?us-ascii?Q?eDSowC9R7k9Qqj+OiYij32dI+GEDofyvistoROx6H9bFcbHyL6cln2BuF4Xb?=
 =?us-ascii?Q?P2hzeQJ7Q5bhxj6INsaqa5slTcIwxL/+sQD3Sfqpao3pZzx+mGsOEbfTYKXH?=
 =?us-ascii?Q?kAV3UXKpDR4izP8SCHPWb+rO2LxENAHxVR8h1WJH8IFVIUyZfTsxWAavZuBf?=
 =?us-ascii?Q?+XuS0g1KzsCFynQQn9NX83RR5NF++/Glxxgho4uYarhRO1i49UwlN4BhzjAu?=
 =?us-ascii?Q?g+6upu/vyxvMvDTA5/J+d6HaRRWMOvnNknTA4X2WeW7ZJo/VjOglzd8SBxLs?=
 =?us-ascii?Q?kCXHDvvkN5hFtVT8CoHP4cCPjmQ9YSFfp5LCn1JbfyLT0H3YZ5z5drfCxNV+?=
 =?us-ascii?Q?LnMc5T80fGikmP40DYsqDTgJBy7ENFIfVc0ijCYP9dCWq6vJVNx/n1EnQohK?=
 =?us-ascii?Q?aKNP71RdgEecS9UqShlkxqJliH0wOQ7DCjThsF/L/wxzYgHe2D6GpZjnVWHu?=
 =?us-ascii?Q?BvNjcFoaXc+y8yqABtZbkhjaWfgq9pHc4ynI5BIDy+ck1oGMs4ndJk3EM2dQ?=
 =?us-ascii?Q?Hg/LdQYMu8JFk97Jw/WhoGmTqD9zJRAEmUK+Bq4SvkFDupqVsSrSGBEosB1I?=
 =?us-ascii?Q?q4UGs9qn5+Ub4YjuyplWOFOZ85gvsvZkh0sp4qHGTFZNqP6+jjgDVEoxO914?=
 =?us-ascii?Q?AAVdTSBEDBpdAD0SHid2gyAlSZN2b8L1Gmh0Sh+Yz7QpdSLUMw6vm1jySTyT?=
 =?us-ascii?Q?qIGwnypj5tAqTU97GlvSZtJgD+7oszQCCwZwNggZbcheqBG5wKgGuQqFYOHo?=
 =?us-ascii?Q?Kmc9HSpMj7pfOtuEUUHI3TvHjTJ2dYuHutqb0ZGInu2ERwJxZ+ZlHT7xvOhT?=
 =?us-ascii?Q?oHKY7ffjNNAPnZgCbxmV/uKQQ0Rzqnt5DsS3KkNt09xi5gl3cCNyqzkC5tzF?=
 =?us-ascii?Q?B8DUYYGhX6HW/x92Ek77qS0Ve1gUDMPTk2ArYbjSB36GsVaoatrAacldf6pa?=
 =?us-ascii?Q?eKu7vZ42lcezXsJuBmN3YA/EbFu++zsrp9IslQizcj1Fl5bjPWlW9HIFHVGz?=
 =?us-ascii?Q?K3ABppkETJZ1EvWRYumuVX2MWVZznmMBcFI15O9WpBGMNWSFmOL7YdjaMj2+?=
 =?us-ascii?Q?oqXkOOlSJM8CByWuG862OVvuSHZ/PExXTiIBxSEJBA4F1hsFZgc8+SGaxsol?=
 =?us-ascii?Q?4tSJN6SmzCoPcwpwy2NGIUjhsa9r36t+MHeD1tzPsko+j0Eg8lf3xQcAvWef?=
 =?us-ascii?Q?SR7PiFPZvDbZPveJpy26cTeseEiIrDMk6CL7m1ylBSr08QUk6yYpikBQ/c1i?=
 =?us-ascii?Q?fmhjd/oTzVVZ92VlwT6/RbN/h8TVJshIe49KAht7jt8tsK777a6B2TwrZ0Z3?=
 =?us-ascii?Q?HefmZYY1B06v6/Acx4kIphpsSwe1RhAfjBBzkx+odi5V2Vuk0WuXs9pg3khs?=
 =?us-ascii?Q?kV1XIGEr7K4IaGhVS+shzjBcSHxKz5ATHRhpJqnwsie+a+5qzlVAZ3a7koxM?=
 =?us-ascii?Q?ZnAbapPlYKEn5/qwXw2WXKrdcAGKxXwXNhBx5Sbce0GaSSTi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917b9185-e4d5-476a-4853-08dec33aa691
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:43:00.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCqGiUkVCZZWGANpEaQvmKxPmlT4Pqk8danO3Q/uj6zLPcNOm7S1/TgYp7Nvvilv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

On Mon, Jun 01, 2026 at 10:44:36PM -0700, Nicolin Chen wrote:
> On Mon, Jun 01, 2026 at 09:15:47PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 01, 2026 at 01:41:26PM -0700, Nicolin Chen wrote:
> > > On Mon, Jun 01, 2026 at 09:32:31AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, May 29, 2026 at 06:27:40PM -0700, Nicolin Chen wrote:
> > > > > On Tue, May 19, 2026 at 09:06:58AM -0300, Jason Gunthorpe wrote:
> > > > > > On Mon, May 18, 2026 at 08:39:01PM -0700, Nicolin Chen wrote:
> > > > > So I've tried INV_TYPE_ATS_BROKEN: during per-domain invalidation,
> > > > > each batch is built from domain->invs so it can carry the "invs";
> > > > > if the batch times out, we can immediately mutate its ATS entries.
> > > > > 
> > > > > But I realized a limitation. E.g., if a device attaches to two SVA
> > > > > domains on two SSIDs. An invalidation timing out on one of the SVA
> > > > > domains could mark INV_TYPE_ATS_BROKEN in its own invs, but not in
> > > > > the other SVA domain's invs?
> > > > 
> > > > You'd have to mark all the S1's sharing the STE.
> > > 
> > > That would be a bit convoluted as we would have to go through all
> > > other domains' invs arrays.
> > 
> > Ok, that is certainly an annoying problem.
> > 
> > I don't have a better idea than storing the master unfortunately
> > 
> > But I think the locking for that is going to be tricky, I'm not sure it does
> > actually fully work..
> 
> Yes, there can be a race that sets STE.EATS back while per-master
> flag is set, which would skip the ATC_INV in commit(), so no more
> ATC_INV timeout that resets STE.EATS=0. To close it, we can force 
> STE.EATS=0 at the end of commit() when state->ats_enabled and the
> per-master flag are both set, which is only possible in a race.

I don't see any of these options as appealing. We have to maintain a
few key invariants, and I think it cannot be done without a way to
find all the domains that are using the STE.

One way or another you have to be using the invs list rw locks to
synchronize the EATS state changes.

It is okayish to be sloppy when turning EATS off, but when turning it
back on we do need to cycle through every invs list and toggle its
lock to ensure that the invalidations are synchronized before
EATS=enable happens.

Given you must have a way to go from STE -> master -> all invs lists
I'm not sure either option really makes such a large difference.

If so then adjusting the invs to disable the ATS is pretty simple, run
over the xarray and set them all off. Yes you could find the master
through a SID lookup with some locking adjustment.
> 
> (1) Per-invs marker: INV_TYPE_ATS_BROKEN + master_domains
>     disable_ats() in the timeout path walks master->master_domains
>     and flips matching ATS invs entries to the BROKEN type.
> 
>   + invs walker is free (one case label in the existing type switch).
>   + No lock or pointer deref in the invs walker.
>   + No master pointer stored in invs; no lifetime concern.
> 
>   - disable_ats() walks every (master, domain) and marks each invs
>     set; the list needs locking usable from atomic.

This doesn't seem so bad

> (2) Per-master flag + streams_lock
>     invs walker resolves SID -> master via streams_lock and reads
>     master->ats_broken.
> 
>   + Single source of truth on the master.
>   + disable_ats() is one WRITE_ONCE.
>   + atc_inv_master early-skips via one READ_ONCE.
>   + attach gates ats_enabled on the flag; a concurrent quarantine
>     race can be closed by a short post-attach re-check in commit()
>   + No master pointer in invs; no lifetime concern.
> 
>   - invs walker pays streams_lock + rb_find(SID) per ATS entry on
>     every invalidation. Measurable on ATS-heavy workloads.

Doesn't consider how to enable

> (3) Per-master flag + inv->master pointer (v4)
>     invs entry carries a master pointer; the invs walker reads
>     cur->master->ats_broken directly.
> 
>   + invs walker is one READ_ONCE through a cached pointer.
>   + disable_ats is one WRITE_ONCE.
>   + atc_inv_master early-skip via one READ_ONCE.
>   + attach gate + post-attach re-check, same as (2).
> 
>   - invs holds a master ptr, so release_device must synchronize_rcu()
>     before freeing the master to drain walkers under rcu_read_lock().
>     We dropped this from v4 for that reason.

synchronize_rcu is not right because you have to have gone through the
rwlock so there can be no readers.

Jason
