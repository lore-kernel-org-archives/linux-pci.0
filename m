Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA1339363;
	Thu, 24 Sep 2026 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214187; cv=fail; b=H7svd3HKrX/S2fd4ri/r3qaPY75xz6f4fGugvOX1bNq+C2j6UdLudCtvN1k0wiBxGGIIo2+3RMoN7cV3ZedABD2Qey49YLhC3d7jjCGba2vibBCnnWa9TC5yu/KwSsqpLIuMFiXOJRTAqpHjg+OGv8lSKIRS2n9Vn/FsSv+7lJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214187; c=relaxed/simple;
	bh=qN21GbKNzXpuWILmllyQmbv/xRh8KL8a1Ufk3UlBRhc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf4eQYCDuZz6g46WX0og1+304A2DUDghJ3kmcmAo2ivYVvkEJH4lETg4uIVPrwsQVBiU8FkXlStgqb0lMl9pl2IGqzMDZgABMkdnITHghBh8KRoYZOJfKQDPaYL3SovMk82mEH6eHm/lW6NKfUmfXaABLH5S5Sm/SaSx244U+/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XnueeWz/; arc=fail smtp.client-ip=52.101.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XnueeWz/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0MzJFzwTGHYGn5IVw+jYrBGE3MTYpzGjIyJDP7e4g6GXWKtoMyL5wW2Vq+UGypxvXVVb3s0lS/V1T9N3Jf8IEnqxBlm8h92AYt6in81IpUpcbScNjEbH1wdaYHbhcTzEvaZx6x6ixuIGrj4jgzMPQIfWSyYozoeNvXKvKhuB2/fCQNA/p3SkENY3Fb7WOZM8+T0Bm/R4tUFG9nO/BQMsYIeayU7g68zyvwj0TttdUcNLZ01yLdc1opd3o/FCwvqnZdJe56up5HMmj1MzGLWmtAtIsst3KjFz10XQyJ3Gn/o2fBHDpvJRnxwovNsVNN0ByiYkuu8NvYKhFKtoSgvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEZLo9AUHiO5jcnAUYo+1q1Nm4mHoh5Vg5DjUZd6yLQ=;
 b=gMjMDeMLKDjGWQo2ucFiolnEgpEns/kqZURAaZC+GaaAWTYeYEoD6HeFgRe8s8oZroC0gRr0xrikYlEFbr0K3Y1uiMATNDcXNcfcKFhSSwis3/sTi+5yCBivZIaVkvq9x0ED4MQ1ME4Wuc7Vq7bKtrLJ7wuJbtEp0ShQh9aMx9AhvoUejFyRHxva18jSuJ9msUnmgestJCpn/nfGxoEKETqsctS3BibWczUDgFuY91+D9J4PeUCPoeabfjTgrIX8rMPXpHHciwMX2o4hE5sjHOszJ9v237yTuV9YRmBjXDd1MhlnahNMKYL4bD3/MEaMYZ/sAh+wtITLKdjfwPK+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEZLo9AUHiO5jcnAUYo+1q1Nm4mHoh5Vg5DjUZd6yLQ=;
 b=XnueeWz/XsG28XcgO/EHCUD2yvb7WRvB7PUpGc7+sgXX/4Tp4sYk4VbdmyjU/ACNb8iRiL1dJ1SyStU0QYpCS8zubqL7UqZFVaa5psXpE9l4To5Y/jx5MsSxC6A8fcpsnRfw1zXcPwj84hGmtYpj70IqdLYGnw104kRoJs+A2f+Fhzl7bYj3YO2F/kVWor6MPgDJtWcZNLbSnOJEEv5S2iSO1NVmYL99y4ao9bEnbjYnLjO0V91H1au7I3Bu3rGTB9JfdITaB7Vx7ZkrvFj3Vf40sWCxnvgZBJYDnmrFmutDd3P/3fTbKanbrYEnZD7g1y88c3EyIAmrNHpWg/1+Qw==
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 01:43:02 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::5f) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Thu,
 24 Sep 2026 01:43:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.0 via Frontend Transport; Thu, 24 Sep 2026 01:43:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 18:42:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 18:42:46 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 18:42:44 -0700
Date: Wed, 23 Sep 2026 18:42:42 -0700
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
Message-ID: <arSAEjFLr5y/ycJx@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
 <179018862538.3334538.17643821143626392419.b4-review@b4>
 <arRTojIlWBOF57zO@nvidia.com>
 <20260923233920.GJ2545495@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923233920.GJ2545495@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 263f0bce-e2bc-410d-ecaf-08df19dd2bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|23010399003|82310400026|10067099003|5023799004|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	E3RfBnTbUUMqY1568ivOovFxENzlEVJmrFMZq+r/COLuKAC4Kd0NTBurZU2lKFVOopWjlva+rY4dPhIzIz8OXUybvo431GqEIN+ScBrOMwZDcr12fYTXFee2kjC8k4QkMIEdayhGiKo7+lqbsVaui3ztSU+6oC3VnEJkBV3caBjlhz4mGgRyIT3hWiIvTCjjsaPz9lMdIHL07gv8CEn6TBJVzaL4s35QlFFWDpxnM82ulj9rMG7shbLDA+C9H7D3CHJZsCiqu2fLMGfmeQpCnVC7yOVrfEH+rV12xAjlUzF0jFlh4V3bdCibhN6YNKGYpFbHM056Di3d0iPmOhM1gyn4g9IB+iCxV/7TPvVx6vXRDHufdzB6sPJvJcR+kkub332MuXbnLu8/89YzPe8yoCtCfUqaYEa7MqaZFarbiH1JK2ZyXPk5oBpcx4uQSKR2SrxOU0U2jOBOKBB+GE79m7d/BnUQ/rFi3fpsmR1XIaSGDeu0mGLPZt5bfzxKftgzjxgMBxB2KMbbXJzxuaKr+aDisCzdRaAGyjFnaKJUQMNT+iJW92lGttwHOKlDBabOpY3tcO5Zk44LZyNz2tJz56APn/kQ2v4PeCXxXta4K6xkDQcs22463WPYUSXMjK8EWYELHM4OoVYX6qUueeeE5Lq2ewS9v084DSPz9b5lYAdJtdDAlKmkphTrbbRvyBls05WJDT2c3a/MPGmqZbqNGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Sh8g0RHF15tB8K6LIe0sH4vpc0f+WLtAVja50QIqAp6JVIiZyYJ+oH7m3wSeN3pw9pgKeFS7Y25PGzS0Hb4JSPG2huUGNSePur8xMtdNqRy/UPzizWbEtQmtCYZNBKXpgIwyMSgqvCK1Eifen+y8h8QcJX5erfyM9PLn0RdeMZnm1g6aVLsRl70krIFu8PAKg9jYRQS7f9e0uxmNYRuUd3iUZ48SRmt5J25upn81tkmO06jIihtCI85B5bUpn2J1ZNVZ9L/mD/UKWWdzx9XCyScdnRg8ZGOfyqQO4XV80bWIbrOS1HajMs8+blsd+0TY9/VRXLgv0xOVhpeHXBN0PK1Zx8tbNUBlNnCGzKDr8m2O/1mIrj1XMyGNqNOHjotFSYU3VoLYP0m+oON0km6GZH5vXpD6EQUrg9M6XsaPJ+RM+ZddvfU2GgVmKPegs/L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 01:43:02.2163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 263f0bce-e2bc-410d-ecaf-08df19dd2bd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243

On Wed, Sep 23, 2026 at 08:39:20PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2026 at 03:33:06PM -0700, Nicolin Chen wrote:
> > > I'm not sure how this all can work, the queue is running on its own
> > > with some other CPU handling interrupts.
> > > 
> > > You can't do this sort of Q_DIFF math unless you've somehow guaranteed
> > > one side of the queue is stable for this logic. If both pointers are
> > > moving forward then the points pointers can progress and wrap without
> > > this noticing that happened. That will lock up.
> > 
> > One side of the queue (pointers) is actually stable. EVTQ/PRIQ uses
> > the snapshot mode (until_empty=false):
> 
> It isn't stable, just because this reads it once doesn't mean the
> actual values are not changing, which is the point.
> 
> If one of the pointers is held stable then the HW cannot advance its
> value past it.

Oh, HW pointers cannot be stable, as EVTQ and EVTQ are shared with
other devices that could constantly add new entries onto the queue.

The stunt was to pick a snapshot of CONS/PROD, while HW CONS/PROD
are still advancing. And it would only wait for the length of that
snapshot. The device is detached, so any event after that must be
irrelevant.

> If both are advancing all bets are off and you have no idea how the
> values are related to each other since everything is modulo the ring
> size.
> 
> For instance you can read cons0=10, then you read prod=15, then you
> next read prod=11. What does that mean? It means since cons was
> actually advancing prod & cons went around the whole ring and
> wrapped.
> 
> You could only do tricks like this if you had full 64 bit counters,
> not truncated versions with modulo that can wrap quickly.

The Q_DIFF was calculated including the WRAP bits. So, it wouldn't
be a problem when any pointer wraps (once).

There is a problem, however, if one of them wraps twice (i.e. 2 x
queue size): then it would miss the exit at the target length even
if it is already much longer; and the penalty would be a timeout,
yet at that moment the queue is definitely drained.

Or maybe I am still missing a key point?

> > > But I wonder if the point of this has been lost? Prior to calling the
> > > driver attach functions the core code already changes the xarray:
> > > 
> > > 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> > > 			  XA_ZERO_ENTRY, GFP_KERNEL);
> > > 
> > > That immediately makes the threaded IRQ safe since it calls
> > > iommu_attach_handle_get() which now fails.
> 
> Hmm, actually that's a sneaky cmpxchg that is only doing reserve..
> 
> > I am not sure about that. Looking at iommufd_hwpt_replace_device(),
> > there can be a old_handle != NULL, in which case the cmpxchg() would
> > not change the xarray?
> 
> I think this is wrong, there is no way it can work like this where the
> attach continues to see the to-be-detached domain across the
> flushes. No amount of flushing can fix it.
> 
> Somehow we broke it :\

Hmm, I will take a deeper look.

> > > So all that is needed is to synchronize_irq() to make sure the irq
> > > thread sees the xa update
> > > 
> > > Then to flush the workqueue that iommu_report_device_fault() pushes
> > > into.
> > > 
> > > We don't need to do anything with the HW queue.
> > 
> > FWIW, the idea of HW drain came from intel_iommu_drain_pasid_prq()..
> 
> Yeah, but I think they might have over done it too..

I see.

Thanks
Nicolin
