Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E043343882;
	Wed, 23 Sep 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202814; cv=fail; b=V62KWM3JqYQP7TzgYsb/5InL5mIFSOHC+p9UGiIkfdhI4VhAp2kE3GOTKRXjpJwYcZbbgbrpw6w6QYyd6Z3YIc0RYisCyuHw7Osq+Gc8w4iR3SegbawP5oHfYOY9YqhotP9znAl5yazOfAk5oxkdpUJyqDrLz0o1+Mm6jzyP138=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202814; c=relaxed/simple;
	bh=wsjCwBc6LixRQ9P+t6puZB1kV7/h2d7NEto/WhbuSUM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQN4Mg+uynKIANL+J7eg2sqAqMSIrh68bp7WdFAyfQ5dHhDn2SN1Ezodb/MrIwOOsHUvPdSr6mTtyEu+txzyMJDQJtn9RMg3xmRtA5a8FN9gPQs/KMGecHC308z+OfhUf+q8VSp+rHSy1PY8TCNfohO+Jr4OYNV05sxDOu9sZ7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LVQRduWw; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVQRduWw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbGNgZjfHMhpRXxUsoQ6cnWeUVzl59+bYTOBHbmQw5KE0T/o5MQri28tJnFEWzC7OW79zVP6gw1dkX6fMEXKsokysE3+EgH2YTSXRt4VO59lcTbzvcx25hbT+a0Aqe/zEddfE2z3y3gEIif3Ny0+8DtaBCvkk/gW/yaAJWa0GQudn/pTydp+xQ0LTmvu1N9gNChp1nU5L37YqBY/t7q9iK/nluJ/yj/i4pg/FrFQDmlL4QSkslhHx/U+1+KGZxuXbOITDFFyVT6vLgv99qEMqGLUu8Zfm+96CAEwNFmEvHz5q0XoPpSbznR284tb86ep9adTJFAMNt77w9eCI4Cu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjVZsgjafxWHbInP82QtXw3nvYZsQ/D+Rt9D0nwnywk=;
 b=hn4eGKWmdLZRyCIQ6uwR/ly8kcMHft7Y3ZP+Kk2JvvpQCH5ZMrIsQbtwZIJG+1o+2HQcdmVR5tBUlmd2VW0TEXgO8MUgE2HqvCDpzZFCdgqrnEbjvwEeLCDpZeFOmbgoffTe9plXJ9rn+rGKdF3Z7mc+2TbeMc94LofCgywqpPVh0qm22WyyzbHm96ohplWIUU5vK8Qj5c2JfjOnZeKNoupd2no7a/pIkHB9yaQB3du+ste8OMTxMM5/a5ZUkOtH99x7qNby2pvqOw/iYX5WcwuCAG9ZrXqSNJ//oc2fybSwisn1NmRwofr60wiEq12FRPdZ/zsSH761EbSBzZYn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjVZsgjafxWHbInP82QtXw3nvYZsQ/D+Rt9D0nwnywk=;
 b=LVQRduWwpepK/Lz/QNJB64dLlEIOdJgGOkuy750JMFlH2BDGPkBFPd019yMz8Rol4i/Rlg2QFSSQIx1TyXqxz7a9MI4BYY/7MFzfrJCYp+5noIaHfsAcEZ95fFUsqOXnBsjEVc7Uxqtus2SqzMKG+BWKdZy5mx5KpgI0AGoYTH6eRbCeakW7V66kqTUW1ymbTU8XbEQdrYa4zWkk62rOAoakfs4uj4xUwuzx89zRRo6+Jr044KlqrhGXKgs6OjjJ+Iq0TbLEikst2FtdTkosTxF31up8ylIGETt/hDjjONR0KNMrx6DVYUIc60cwJNe3PxKlncJDNZLvlrREfsDKEQ==
Received: from PH7PR17CA0033.namprd17.prod.outlook.com (2603:10b6:510:323::7)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 22:33:27 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:510:323:cafe::b) by PH7PR17CA0033.outlook.office365.com
 (2603:10b6:510:323::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 22:33:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 22:33:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 15:33:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 15:33:10 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 15:33:08 -0700
Date: Wed, 23 Sep 2026 15:33:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<kees@kernel.org>, <smostafa@google.com>, <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/15] iommu/arm-smmu-v3: Drain in-flight fault events
 on domain detach
Message-ID: <arRTojIlWBOF57zO@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
 <179018862538.3334538.17643821143626392419.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179018862538.3334538.17643821143626392419.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6e62ab-f8c8-4216-cee2-08df19c2afae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	7LuFV1otp2NNgkH5qFGpBBp/fBMJm5Qw5d2Ab7+p3Sy3LcG3onzj+PXj5GkA83pqPXPGhxakppdLmq9RXbcVQkl6GM8Dl4LSV67m6v7990xmTYb2ZrA/WlK5dyRo2Q+wVmcsdlMP9FmzlJkrodp+vPC4ttxlNYRqxiHQW3/Yto3UWx5lzos2X4Y9k1Mnka7mNnQ2mC5oCbfg4OR2HVwDpfzCM5WGHXqgxS2ztN6LNFUalG9UywpNS5ATJLO64rBpQqjmFhfCvujfB9yaR0SbzFHW20FD07i6ULprY+EMD+NqrpWAnrQgMGgyto4GMoKKtwA6qcqNFXKt0Qi/z1+s+OocENkGetUGukeGaPa86x7P6SMXDHOIb77wTQ7lv8oPWVZTfNj+P3dUuYxp0Mp2faQjSEokfu4gu/R3p0VRMTmgqqDBkV2mxPSTx7GkJ86q7apw2RbdO5jFWJgiECGsM10e96+phpW+ZW3ssUkBlLdkIWnvlFzcBsW4Tm/HMlH2cQcwpsoSWDKjru1PxDlD2tjRYoyjbzTQYGU33dFOqGpfjaDMuUuiLxdop4P4InubbN7AFU2GGZ76owk2jxxwSTdm2borXBlr99t6GUwLH6FpQnNJmVMPYG0ASAtiQH3BQnIZ8u16zh8jx/I3CrVKF0fbt/qSWk/gYLD3r++V8u/Qqy2xKXXsElH9kqS0icxuCKnG7JmVz64IVpsr7H92bQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MhwNzTtx3SrISKL0d7o04hRRbfOsl0JIIABWvrzR6CTU3u0MmOQHwTWB5j3ypj7Om4WtQko2ivGRsRBUwGljc/NZBTvGx8vI6vCdrtUpIVGIpi2gALAnwB9GYiLQe/1TOmiAp1ZGGWCuL1l/u4OW2BOBqF14b0g3duKc+126lbaK0lt5yKs80wuXDytH7s7/J27U2pdnGCzuz4q1ZBvZZFnDoKyUHFS1uJAcyf81iMsKcb/x9K0j9qFwZyAPdTopP0qLWc2lsG+9jqapaXqp33YOJLDmhf7dAh7fouZhiWnM9bU3aZaF+rpYVeNez/KosjpTPOIzJDAaFy1p/4o4IjozLi/1cz/5ZJ7D53ZszV0WGbEoHO+ToLpS4MA6tAvVSKqVKdGRrbMJGNnaH0RbTHo2SK+Td+1uhsOSZqotoPsrTyV2chkGmGTmxMUdqIUS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 22:33:27.1453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6e62ab-f8c8-4216-cee2-08df19c2afae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

On Wed, Sep 23, 2026 at 03:37:05PM -0300, Jason Gunthorpe wrote:
> > [ ... 73 lines skipped ... ]
> > +static int arm_smmu_wait_for_queue_drained(struct arm_smmu_device *smmu,
> > +					   struct arm_smmu_queue *q,
> > +					   bool until_empty)
> > +{
> 
> Nothing uses until_empty = false ?

This series (PRIQ/EVTQ) use until_empty=false.

> Is that for the power management series? How does it make sense?
> Shouldn't we already know the queue is not seeing new entries in that
> case?

The RPM series (CMDQ) uses until_empty=true, as it knows that there
are no new entries.

> > +	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
> > +	u32 cons, prod, pending;
> > +	u32 drained = 0;
> > +
> > +	might_sleep();
> > +
> > +	cons = readl_relaxed(q->cons_reg);
> > +	prod = readl_relaxed(q->prod_reg);
> > +	/* The exit target: the number of entries in the queue at entry */
> > +	pending = Q_DIFF(&q->llq, cons, prod);
> > +
> > +	while (true) {
> > +		u32 prev, undrained;
> > +		bool expired;
> > +
> > +		/*
> > +		 * Sample the deadline ahead of the queue state it judges, but
> > +		 * break only after the exit conditions below, so a queue that
> > +		 * drained during a long preemption still exits with a success.
> > +		 */
> > +		expired = ktime_compare(ktime_get(), timeout) > 0;
> > +
> > +		/* Accumulate the entries consumed since the last poll */
> > +		prev = cons;
> > +		cons = readl_relaxed(q->cons_reg);
> > +		drained += Q_DIFF(&q->llq, prev, cons);
> > +
> > +		prod = readl_relaxed(q->prod_reg);
> > +		undrained = Q_DIFF(&q->llq, cons, prod);
> 
> I'm not sure how this all can work, the queue is running on its own
> with some other CPU handling interrupts.
> 
> You can't do this sort of Q_DIFF math unless you've somehow guaranteed
> one side of the queue is stable for this logic. If both pointers are
> moving forward then the points pointers can progress and wrap without
> this noticing that happened. That will lock up.

One side of the queue (pointers) is actually stable. EVTQ/PRIQ uses
the snapshot mode (until_empty=false):

 * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
 * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
 *
 *   cons0                cons                 prod0         (prod)
 *     |<---- drained ---->|                     |             |
 *  ---+###################+=====================+=============+--->
 *     |<--------------- pending --------------->|


"cons0", "prod0", and "pending" are frozen/stable at the start; the
function only needs to track a moving "cons".


Arguably the other model for CMDQ (until_empty=true) does have two
moving pointers in theory:

 * With @until_empty == true (for CMDQ), exit once the queue is observed empty:
 *
 *   cons0                cons                                prod
 *     |                   |                                   |
 *  ---+###################+===================================+--->
 *                         |<--------- undrained==0? --------->|

But in its practical use case (RPM), as you pointed out, there would
not be new entries. IOW, its "prod" is fixed/stable; only "cons" is
moving.

> Can you just replace this whole function with:
> 
> static void arm_smmu_irq_thread_fence(struct arm_smmu_device *smmu,
> 				      unsigned int irq)
> {
> 	if (!irq)
> 		return;
> 	irq_wake_thread(irq, smmu);
> 	synchronize_irq(irq);
> }
> 
> ?
> 
> This forces the thread to run and waits for it to finish. Since the
> thread fully drains the queue at the moment it starts, that should be
> sufficient?

Ah, that seems legit to me. The point is to make sure no pending IRQ
on the HW queues, so everything is drained. And this likely suffices.

Yea, I will try that one!

> But I wonder if the point of this has been lost? Prior to calling the
> driver attach functions the core code already changes the xarray:
> 
> 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> 			  XA_ZERO_ENTRY, GFP_KERNEL);
> 
> That immediately makes the threaded IRQ safe since it calls
> iommu_attach_handle_get() which now fails.

I am not sure about that. Looking at iommufd_hwpt_replace_device(),
there can be a old_handle != NULL, in which case the cmpxchg() would
not change the xarray?

> So all that is needed is to synchronize_irq() to make sure the irq
> thread sees the xa update
> 
> Then to flush the workqueue that iommu_report_device_fault() pushes
> into.
> 
> We don't need to do anything with the HW queue.

FWIW, the idea of HW drain came from intel_iommu_drain_pasid_prq()..

Nicolin
