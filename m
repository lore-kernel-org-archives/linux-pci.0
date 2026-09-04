Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87E38C438;
	Fri,  4 Sep 2026 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558204; cv=fail; b=ApDdZfTN/oXbituGaxDKXonWxQ+jQapw/lUCsHCGV4h6OklHr6BOKEwkTAFje2dL9X4vQ/WOtBh464k4FnknhUghrefy0MI3hgZfmLUXq7Tm0SsLd3BA9VFwnU3j2bd354Oeco3dpONqCaIqV/wmFcuQlsTmkuD8Vo9xPwHj+T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558204; c=relaxed/simple;
	bh=PV9oieABOLgKLeLfzRf3V1H2KWky/M7fOMAx4fVEq80=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6x/CoqULEbnUPEnCI1QNnrIRPPu6ErLRlTpQ8KYymrJKc5ks7mzhXvTaKhpqtDpgGJYC6/gaN6MYG9QHcWXucD7wGcCcX3ZJbT5p0Qq0hc8kIJ9hWtAMwi+v97JZB294HTo6IJVMRZaskELLjsHpsu45zVVg++Uvnfoi1aRHBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=glOV3U6S; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="glOV3U6S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0QOn9skyYaTc5crsdNhltoTZxXVZ6QRw2qWquugP1DwIbaBM8iSXp9xfVEy0Y4GYuJi5lwaYVANKfducb9tRS5aLbHAcwjujGRoyvMHmZt+TqoHL5XPQtFR12U+VXzMG4TK/8NN5qnueL9ZKupH1tavWYQyRVggTuKJGs9Wz3usU7hD0MNclQQqhTu17vuL9L60+M4cGR0t3STvqbSPx6FE9yOs2aWwksSEHIknusrLjHB6iaeWx2C14XALyrpirse63k1cLU9R7OQXoVFLSIoNgvZroz7proLXgj1KjTma5kRId+YcOuUUwc/16A6vJ9EPW9YEYKIi8Npxx6myCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNDtMp8O1f5/RjnvNdJtIo4LKUolLOXAiPzCUJDt5XE=;
 b=HExWSD9SQsu3E46X8MxqljHz+Quv3OwYX4SfUO1dkZz6UsQ8jyC9fU20UGQEZtnvhiYajbpaVAyRmRnVfOsu+hIeduzjgOyPqtqsGUGD3NPWkjx3+F9J/6j51Wl7j00dBu/j7jGr6ch3imiYQc6npAe0ksCAV9ESnGxKwVQlVD8TiON0tUUM6kZSEIgpTm1ugI8DMIZZz1ZaYHNcvMelynTbd1zjUKXbFegcGf9/1XKOQ+aL999kKTi+42EOc4fnz1zVMZpzp45jRHRAqKJJxQdOuo3DDiPQWwRX0cENigRXGh2NIIxJphx8VHoWTodQV5FYObC/pxC2MHuteXN6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNDtMp8O1f5/RjnvNdJtIo4LKUolLOXAiPzCUJDt5XE=;
 b=glOV3U6SY8UO7OBbflh5LMRPH3BMOq6u1FXpPemuxAkVkH7oEueGj3kGFheGcLnrTOl/CTBxDO9fcqZzf7Mac6qH2TmNlQjFIgUjE7a7VqkiEKyuqbWiWPo1tvp0KGYwp6Kd8rujAOj5DOB63hKQh23/r11Jm4X2J8LMlMa8V2dSB73JLoNR2H/vsp/cacHGNe5Df1Pq/XZKjSM1nWmjTyLjtP2PWYdQLymamOU9ioAigMS1lkHLjWPESGTL3+0Wccl8hw25Iz9r3uWLB6JEkAlE+jh03QOeF5i7OjEGI2oBtwMT5VdgD7ihh1GBjUbiciYD8fhIMWVfeooR1p1veQ==
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 21:43:07 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::28) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 21:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 21:43:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 14:42:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 14:42:45 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 4 Sep 2026 14:42:42 -0700
Date: Fri, 4 Sep 2026 14:42:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Drain in-flight fault events
 on domain detach
Message-ID: <aps7UJktq3IlO5lT@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
 <178846311316.1308030.6266899352044838554.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178846311316.1308030.6266899352044838554.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 885deb12-6ca6-42bc-04ad-08df0acd81b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|7416014|376014|18002099003|22082099003|56012099006|3023799007|10067099003|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	k4FHx6bzZpZOc4ZETFtH0Ue45ER0rqt8OAu/oyITylyj65qtDzJmDXYb7P5Dr9lSnqcwMPWHqZzy2m+1Z3QHs9YiGF3GIbWc3A/oC4TPRE4SdTozWur6Ylvl8OTPUdInqgUeks7itnapiAINkDfAo7bNKmdL0nd8FwST/ZP1tfDJVNK33vhN2tIQkeZKn5teXNY+BwjxVf3/MdsOg4mo3cZBwo3WJxNip8ElYdMfNk4oJqe91H1BVV4HDtyDvTYYVkm7BGTILcNpGcHoDOkFirTtokhGlWZS+gsmaFPTmcx8e3TuaKOxQ3ge+HwGlrnXk/h8u6I5Y1NWWhhbA0vmbBwGXzaESaUV2AoRA3bYq26+dVrGv/TuUm9WGFgG/ldStBaUtnvyEW5bGiG6+v31pqM6Ko5K5v1p3MiDcNYvOvb6OSWTpysSKvZype20xTQc8PPDGO6TGoarnB59zl+dBLuv//Rkcecr6BvqBwUCXPoPRnggo5ynskhUPheZds/8ZZhNr2aHNo80uP/Jw2igDslRA7PvguoSvJ/OlSioDSbLC0lMtWz9vb1cKwvthJbiucwfTrYJySwyEylxqnxlunRVoU1ULHcXhpsBA+dikpaAyy8rgZ5r5jSNaO6KKANpVdPaS1Q5C1GUJAbVP9apWatbxtS98xZY2o6dQwlAVpdi7ssWTfWztHHauLuRp/vYnx/1BZuhO46Df3wh34OJtA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003)(6133799003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4J2PcwpPcUXnbe9kf1YibqE5ofpdnNK000/hwBOxSHgCRI/PIHbyUQR+2PUAlC2IahUSggJyJ+24oMt1Kmi8GRoXCdDjHXrXP23KXGK5W52MO1PTjqPHE0TC4mQu/QpGKvr9NyY6zUC3G6sIFB4POqlj7TlZSEI0e4O9op0zX+EH5VzZJdQ2d0r2Dcfmq4kusd3rnN6MEkscCH7AJNUQdy8x1fmpISdj/k032pecS+J5apZDd+hd7zWmIpA7BmgxNe30YJVN/SeN0NFIInnKKuiyv85UCTjDWkVYjFmO7u/Oewwmk1XXKxSeC1EkfmnZWKK+/g+XwBI3hb0l76QsQq6ICiQKW9It0S7CATe761D0r7d11+Nb+MghIbMNydz2WmOdZkMXVvf5IW6p3R+sl2f1Ox/xGD9kwZUGrR7o0Mq7jIwD8umEgNmNCde5C+P3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 21:43:06.9468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885deb12-6ca6-42bc-04ad-08df0acd81b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711

On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > +/**
> > + * arm_smmu_drain_queue - Drain an SMMU queue
> > + * @smmu: the SMMU device
> > + * @q: the queue to drain
> > + * @until_empty: target selection
> > + *
> > + * With @until_empty == true (for CMDQ), exit once the queue is observed empty:
> > + *
> > + *   cons0                cons                                prod
> > + *     |                   |                                   |
> > + *  ---+###################+=====================+=============+--->
> > + *                         |<--------- undrained==0? --------->|
>                                                     ^
> What is the + indicating?  Seems where prod0 that isn't relevant here
> would have been - that is a little confusing so maybe drop?

Yes. I drew the other graph first that has prod0, and forgot to
drop it here with prod0 after I copied.

> > + *
> > + * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
> > + * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
> > + *
> > + *   cons0                cons                 prod0         (prod)
> > + *     |<---- drained ---->|                     |             |
> > + *  ---+###################+=====================+=============+--->
> > + *     |<--------------- pending --------------->|
> > + *
> > + * Note that a drained entry is dequeued, but not necessarily handled: the
> > + * EVTQ/PRIQ callers must follow up with a synchronize_irq() to wait for the
> > + * threaded IRQ handler to finish handling the dequeued entries.
> > + *
> > + * Context: Process context; may sleep.
> > + * Return: 0 on success or a negative errno on timeout.
> > + */
> > +static int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
> > +				struct arm_smmu_queue *q, bool until_empty)
> 
> That name suggests this is doing the draining rather than waiting
> for it to happen elsewhere.

I changed it to "arm_smmu_wait_for_queue_drained".

> > +{
> > +	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
> > +	u32 cons, prod, prev, undrained;
> > +	u32 drained = 0, pending;
> 
> Pet irritation. Prefer splitting the elements that assign and those
> that don't onto seeprate lines.  Here that just means moving pending
> up one line.

Done.

+       u32 cons, prod, pending;
+       u32 drained = 0;

> > +
> > +	might_sleep();
> > +
> > +	cons = readl_relaxed(q->cons_reg);
> > +	prod = readl_relaxed(q->prod_reg);
> > +	/* The exit target: the number of entries in the queue at entry */
> > +	pending = Q_POS(&q->llq, prod - cons);
> 
> Applying a macro called Q_POS to a difference is a bit confusing to
> me given the output isn't a position of anything. Maybe just needs
> a wrapper Q_DIFF(q->llq, prod, cons)  Can use Q_POS underneath
> but avoid that naming out here well away from the macro definitions.

Sure:

+/* Entries between two positions, i.e. how far @b leads @a */
+#define Q_DIFF(llq, a, b)              Q_POS(llq, (b) - (a))

[...]

+       /* The exit target: the number of entries in the queue at entry */
+       pending = Q_DIFF(&q->llq, cons, prod);

[...]

+               cons = readl_relaxed(q->cons_reg);
+               drained += Q_DIFF(&q->llq, prev, cons);
+
+               prod = readl_relaxed(q->prod_reg);
+               undrained = Q_DIFF(&q->llq, cons, prod);


> > +
> > +	while (true) {
> 
> Maybe pull defintion of prev and undrained in here so it is clear
> they aren't state maintained across iternations.

Done.

+               u32 prev, undrained;

> > +		/* Accumulate the entries consumed since the last poll */
> > +		prev = cons;
> > +		cons = readl_relaxed(q->cons_reg);
> > +		drained += Q_POS(&q->llq, cons - prev);
> > +
> > +		prod = readl_relaxed(q->prod_reg);
> > +		undrained = Q_POS(&q->llq, prod - cons);
> > +
> > +		/* Exit on an empty queue, regardless of until_empty */
> > +		if (!undrained)
> 
> Given you don't use undrained again (maybe in later patches, in which
> case ignore me.)
> 		if (Q_DIFF(&q->llq, prod, cons) == 0)
> perhaps.  This one entirely up to you as maybe the named local does
> help with readability a little.

It's indeed for readability: this matches the graph in the kdocs.

> > +			return 0;
> > +
> > +		/* Snapshot mode: exit once the pending entries are drained */
> > +		if (!until_empty && drained >= pending)
> > +			return 0;
> > +
> > +		/*
> > +		 * A timeout means the consumer might be stuck. In theory, if it
> > +		 * moves 2 * qsize entries or more within a single poll interval
> > +		 * Q_POS() would wrap and undercount drained: that could trigger
> > +		 * a spurious warning too, if the queue was never once observed
> > +		 * empty. Yet, that much consumption in such a short interval is
> > +		 * unrealistic. WARN it only, as a stuck consumer is a real bug.
> 
> I don't like 'unrealisitic' based defenses (even though I agree it is pretty
> unlikely).  Is there a way to bound this?  Maybe future systems will
> be much quicker.

I can't see one..

I think this is already an extreme corner case. Sashiko found it,
FWIW.

If you have a better word than "unrealistic", I can change that.

> > +		 */
> > +		if (WARN_ON(ktime_compare(ktime_get(), timeout) > 0))
> 
> Why WARN_ON here then a dev_warn_ratelimited() below? 

I dropped WARN_ON.

+               if (ktime_compare(ktime_get(), timeout) > 0)
+                       break;

> > +		/* The consumer might be a threaded IRQ handler. Yield to it */
> > +		usleep_range(100, 200);
> 
> fsleep() perhaps then we don't get to argue why that slack.

Done.

+               /* The consumer might be a threaded IRQ handler. Yield to it */
+               fsleep(100);

Thanks
Nicolin
