Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077D3F87FE
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355819; cv=fail; b=MXJn3u24F6XF0LoFuQZGRtrWC3XAP7Q/e17fvUnV3EO6b3r52ET2R0H+RKA1c7ssvOXKoAMMtH/ogu0MLN6uTBqI9f7e54B+NqI+3bMcqc4xRomX9hte58gC3AWJkJnXHWg5jAt4H2O5A9usi+4n0ONSeMvRkrL4fMizpzKkddo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355819; c=relaxed/simple;
	bh=3Kg9AQN2j3P6zeNd3wjGC0jNeFEyLx2XvMKNRmBOc5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GJuq7if4lAIzUyHvpZSH9JhEtvfPr5cTO4yI9yh9Sumv0CKKbBPzq5s4EWxn8CpA6PUM5BpPGmPHWBNybK76EOW33YbMEWrgKTzBgocRX/YpB70ai7hHI+7OnbunIVQCbhdQigqtdZmXxHjE99VzIeG29h0L6vkMOFtAUww7OTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GpcPkE8h; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GpcPkE8h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5spRFw5bsaYifoWg5RL5eacnZN3wJjCNU/Qz+9Ia+ksJIEbSCMKl6oWQmVA22QzCO+JsXKSHLGvbsLLeqMUQvndxws8NDb8VcDl00fRZo0l2qKOorZkHKJ1Kg5b0bw8N8wcFEvzqGVyOFxg/VdXgTBzuKMdW5+abOctQr1bhSGe1MfO2lUax703aCKW3UfoD1lOWxKVcPfBY6PPyrNP8SuXCgxBEtmxUowBNq8cc7SYG7SBYth4qoewvCq2ggICX0FUyWHJclA165r/+miK5Us0jhWybRh9SlzM8XHT7KleKjECs2YiaTFd6hhgl8PHm5dJI/Smh1oTJR6J8H7hpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujXx1pnEImhNsPDF+usWrvf05LfyxWZk/iaSIE0RMH0=;
 b=djiOL/SlFhus4QvTkFZEkI6KERq8jxfADQEma+l/0ppdL+VWa+bEv5oKMmEiJSHsjD9lFanUOOzcgKUVW79xA96fyAjlB5cTTjHaMJ0R6DJylA3Kc1mEScxugBDnmlTXRxV3QaDz2ooLnSHjZk6xyI10ufUEZycsfv1dRroEBDXJWqI9PvLQ3uWVtnVsDmti9s1It9FR4Tve1N3Xv9W1uFCutpC1X5sLuALdde2f3yGhykKaqR5J3SiKJbVIN2gxldrgoOFpkPcTmTsYDZpvTMK56l895Sp9fi5x1X9R+DCPqPPzWp7Jh3ydy34PYcP4JTaON8Y0gbHcLoqcJZGWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujXx1pnEImhNsPDF+usWrvf05LfyxWZk/iaSIE0RMH0=;
 b=GpcPkE8hC3DPaEtrkQ7KJvw+tnxBnTr4nMvk9EkWGhBKyz25GPbCridncSYUbH/jwGQLMyhfu9Q6pHHeyt+VnPd1j4GvWQRAD26Im+Ix3bSlSAVptjLCU7+kgvRIzyLgFBzFAUWL+nwek+zDs9dO01vYLuPqNeiy3POUus4GI+cryYniOm0D30MTcl5EkqrTy9ijer+IhEUyDaDHReqR0FXKt5v9KCXTy9fsDuxQknT7Mt9UCemoADh2hdKMnOuLzhL6yijn36/BcJOIbRXooHaeSpZEwiAZKS/nxyGlrKfbwOP1v9w5DD56qngN0vnZNpBKHOKIc3VtjUuFcmqn+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:36:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:36:52 +0000
Date: Tue, 24 Mar 2026 09:36:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <20260324123649.GY7340@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
 <20260323181413.GP7340@nvidia.com>
 <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BN0PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:408:141::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: ca647b00-9a30-4469-ad87-08de89a206ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cyO9SJhoNscPEjSrsVGCsg3Q1eAb8ks6tmjppYspF1h9nK00Fmbg9q32ASMKSvL/vQKukcxLK6JDyvFoUQEV5dWZzQ8dO5uKqUZEoR3Ay/Nf4O9OLmT+nZScZiA6cA16LvEBg3vWYCglQhkEynwAeLgu/4hUPLEsxJsTPaX+9ljZG6zbjQ7E4WxxPzURdl0i1j5zyVHZsqB6zXQ09bOsrGBlcbud2dXeY7GklhaHN9S65joCWXpvjR6psQaDEylB8he00IFGPxOREvIeYQ2J/g5g7vIaYdvvJWyLBlPazl5G+pK6ijnsHbZwLxPUS1GSku7MPKna7kx3digILacpIhPuqdyJtnR3fLKbn2txLJ/j9LFwnCVrYSiXnh3K2N5uuY+tqb9JVtHou+sQGxnVwA1e5gbPja/cK/gblLJ6y3tXVAiypKcHfBWHX2xLbgTdi6nULiVkkYyy+s8wDOQdgqHqJNTwcWEVo0kyp45izB8Iz8aiaD+WJZhJmc+/mf6GAD5K6KV5xj4aeDc5GUPwqviBuBldzbcawg+/vM8hlH8D9V61zQAKj+HIkGJry9BU+T+faRnVYAyBYR77CsGP0apHwh8/rSMjUG5pG1nRQscNSc/JAXCtYZLQKI6z9U+jAmMuqMCAN9YpgOdlke65MDXw/bizO+khHhwzNZxF5WNxvJOyyuOzYUORMHg9PT85UVRvvZB/7xOh+NS65SvgniZ51bF9ag2ENNJUjssoFyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0bIXe8XM+51RdjdFrbbmS4R2eCgcWDw/D4CX4He1bWYD2qVLoc5qgoW7NbkM?=
 =?us-ascii?Q?cK45XN3CUUkHVILQOd0kQay44e/aIQFiQVbuhUVX7pA4B1/p5HzBEwE7Jsj7?=
 =?us-ascii?Q?b5c5UzpL8Nu1jzplbzxw8X1akrx9BuOoNp+UgGNSbigTk4DiybwvZN4J+NOw?=
 =?us-ascii?Q?F344O5kj8aBUMA3jkaL2HhG3rXkMNaO8gehJ5Hs08JfSqMKoAvQ7fm4LFYzm?=
 =?us-ascii?Q?M9s8nJ9lAN/aWxDBqjvDYa0PCGRiuo3u8NXQaw/qi1YDuLvwoF1CPyWFYWe2?=
 =?us-ascii?Q?IU5m9aQUFqq5CQLfawraK+hed+2aeCH/Fbb6dH0CnMXXMYc0X3JkHQUlB5dT?=
 =?us-ascii?Q?CLPixdWeSconVPJFUfi7zjMNgSkjnFBrJvA6ya5LKVAZ+0Z0tBZrMJkd2CEn?=
 =?us-ascii?Q?6NnSIZaaPE1IuXcpqhC+aXZ3ztUZit0lS1ZAlZQXsoIbtYRVcoEJTodmZvNO?=
 =?us-ascii?Q?Z9E2hH+TTpzQb+KsNFXNLsJJVo22FamWd6k4BlRE4OELpJJOQLwbrJNG/UYm?=
 =?us-ascii?Q?+5nLfbLtLBPD1wRgukTgt4NxGUjK8FneujTUsGnej7AahSKd+eWKqVR88oWV?=
 =?us-ascii?Q?AFhSHSIMlCYSvUlG0RmLMoxM8TKBxQcyrlecdphGxDOPvTfL2E1kD4yiVz+F?=
 =?us-ascii?Q?uTH3cPCeLa7y7FyNEsjueGnp8HNns7NPNEYoKNCCWPrvZoQe1IakPjzOgQ3y?=
 =?us-ascii?Q?3ZrKgFxj67rrKYGHlqvU8LKPP8Y55aReSXs49n/X3SlWSPjzg9W2vu8MO5rw?=
 =?us-ascii?Q?MCQDGuO8Fed3Qm+P2eZAR+ML8HTBoznK1HmMuzENiAnR//yiH9XviDyWUfO+?=
 =?us-ascii?Q?s0oUyRvAxBzaVufeN8T+K+e8hQMUkCOaJLkQb67cWWPLTxPMrqGBbmzIsfis?=
 =?us-ascii?Q?FhcfTmqvds+cT4e7ZIcWWiOLNWTcmtmZYAeSGGW5/jh6b9jk/O3OLz7b/7rZ?=
 =?us-ascii?Q?4S1mlz06rAN0/nT8Lm8PsVPgqdmWZEL6luK65+MvBuarBRmSdI7UNt7hKbHC?=
 =?us-ascii?Q?oewnPAlK+vyeOHPDTtEpxYKD02RrVf+UsXmCfiU9/gYVd4eSWEJbo9jYtVaY?=
 =?us-ascii?Q?u7PhVSGbyaPvn8hvoYjts2opXtQsHXCZQi7LlWzpwNo60T6naV59whR0K0Vc?=
 =?us-ascii?Q?ajovsagJxNZivAtUGARuBB8i/IH0ADFwNrTsxXWETGFt6c6lXYhmHIXWIcYS?=
 =?us-ascii?Q?jR3VznuUwktpYrW2e94haJUmO4S+uvdyDnWYQzgC4wFzs9GA5JWVR/nCBJg7?=
 =?us-ascii?Q?aDXFZit18/femACGAETpY55Ag8lmKjR5CwBhNgR4tOnqLmepV696SGxdRtyV?=
 =?us-ascii?Q?900Awdzo1mR0QrdBlyOzF1NMIoTH7h2CoqwWuGZoouGQTwy6cojZ/XBGDXSO?=
 =?us-ascii?Q?CVf0GilQCJq9kEE9bwJXLr6PWJ7FVlEIqgDtockiLD/L5uG2EDZ3oenqQQYw?=
 =?us-ascii?Q?mlWwTuaHGGz+PzewGyR6BCqe8N4XuXh6pYe48dqYQBmW1YVH6WKOWW+3CmPa?=
 =?us-ascii?Q?bISqzXxsxK6X8ZBKv9dSAYP1Yv06DmBOQ/NbgDLz9F9Vxpe2OFw6TK+evL7q?=
 =?us-ascii?Q?cZOF78jykF4EFe/MTkQ77vVrhKA9smlVPrDsZSwU5oiw2ixsALVGsYzRp+TI?=
 =?us-ascii?Q?ildqeiYAKj73Q91X6T9HdWKTpGym9qtaXZsi4Hp9Ltv3flIv2NlvkDGL1c8N?=
 =?us-ascii?Q?AIfLmUlSL/2aDYxwQlCa+rU5OeSmgs7pbVjZvREAeQ43b+o9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca647b00-9a30-4469-ad87-08de89a206ae
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:36:52.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ru96RnMEYHOfQXShhCASe+wFEOKtNF/XrdVE4G1UWIRxbBos+qsA3syP34/zTQQw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582

On Mon, Mar 23, 2026 at 07:18:17PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Fri, Mar 13, 2026 at 06:32:27PM -0700, Dan Williams wrote:
> > 
> > > The problem is that for all the buses that do not currently have a
> > > "device authorization" concept only userspace can decide that a device
> > > should skip bind by default. For that, I propose module autoprobe policy
> > > [1]. Not yet convinced the kernel needs its own per-device "no bind"
> > > policy.
> > 
> > I think it is just part of the broader definition of the level that
> > extends into the iommu and so on. It makes sense to have this kind of
> > no-binding security level, IMHO.
> 
> Easy to include for completeness.
> 
> In a CC VM userspace can set "$module autoprobe=0" to get a control
> point to set @trust to zero, but @trust otherwise defaults to 1. This
> allows for userspace policy to generically distrust devices, but without
> needing to build a new mechanism to specify which devices start life at
> trust == 0 (i.e.  "device filter" proposal previously NAK'd).

I feel like starting with trust=0 is much cleaner than using
autoprobe. Especially since it would be nice that when you do
ultimately set trust!=0 then you do want the kernel to do the normal
autoprobe flow.

Double so because I would like the iommu drivers to respond to trust 0
by fully blocking the device 100% of the time without holes, so to
make that work I would like to see the struct device report trust 0
the moment the iommu framework attaches the iommu.

How you decide the starting trust value for device during system boot
is definately something we need to discuss properly..

I liked your idea of using built in driver match, so if there is a
simple command line paramater that says 'only built in is trusted'
then we'd default all devices to untrusted and during device probe
check if any built in driver is matching and auto-set trust to X based
on the commandline parameter.

With the idea that only devices required to get to the initrd are
built in. Then the initrd userspace has the policy to bring more
devices into trusted!=0 to get to the root file system, then the
rootfs has more policy for further devices, and so on.

Probably this would ultimately escalate into annotations in the
modinfo about default policies for various drivers.

A kernel default policy of trusting everything without a "trust ops"
(see below) may also be quite reasonable, however boot ordering the
trust ops might be really tricky...

> > > > The DMA API just wants a flag in the struct device that says if the
> > > > device can access encrypted memory or only decrypted.
> > > 
> > > You mean separate "trusted to access private" and "currently enabled to
> > > access private" properties? I am trying to think of a situation where
> > > "dev->trust >= 3" and a flag saying "disable bouncing for encrypted
> > > memory" would ever disagree.
> > 
> > I'm steering the trust level toward more of an acceptance criteria.
> > If the trust level is you have access to private memory but the device
> > can't actually do that then fail the trust level change.
> > 
> > Same for the reverse, if the trust level says no private memory and the
> > device is T=1 then fail the trust level change.
> 
> Ok, so the uapi for PCI/TDISP would be:
> 
> echo $tsm > $pdev/tsm/lock
> <gather evidence, validate with relying party>
> echo 3 > $pdev/trust
> 
> ...where that @trust attribute is a generic device semantic, but in the
> case of PCI device connected to a given TSM it invokes the TSM hypercall
> to transition the device to the RUN state and the TSM local call to
> unblock DMA to private memory.

Maybe, but I was thinking the transition through run/locked would be
done through TSM uAPIs too. trust setting in the kernel just confirms
the device is in the right state.

But I haven't thought of a reason why the final switch to RUN couldn't
happen like this either.

> So, userspace can generically understand what privileges come with which
> trust levels, but the mechanism to get those privileges remains bus
> specific.

Yes

> > If we fall out of RUN then the level auto-resets back to 0 and
> > userspace has to go around and fix it again. (ignoring driver RAS)
> 
> Yes, at the moment that the bus detects that an event like SPDM session
> loss, IDE link loss, TDISP ERROR state entry has occurred it can
> downgrade trust and notify. That notification fits well with netlink
> because all of those events are downstream of evidence validation.

Which is also why it would be nice to be consistent and rely on
trust=0 to isolate the device in all cases, not a mixture of
autoprobe.

> The complication vs benefit tradeoff is indeed not mathing, but wanted
> to do justice to Aneesh's proposal and the suitability of the sysfs
> uapi.

I think if you want something like this then it is better to target
the root - remove the ability for concurrent userspace to wrongly
operate the TSM entirely. Ie use a cdev, make it so going to LOCKED
isolates access to only this cdev fd and require only this cdev fd to
go to RUN. Then these kinds of bugs don't exist.

> > It brings it into the whole 'measure the device and then decide what
> > to do with it' framework. The trust level is still the generic ack
> > that the device is allowed the participate in the system with whatever
> > level of security.
> 
> Some thought experiments to confirm alignment...
> 
> 'Generic ack' is a synchronous mechanism for the bus to evaluate. So if
> @trust appears for any device, and by consequence alongside @authorized
> for a thunderbolt device, it should be the case that these operations
> are equivalent:
> 
> # echo 1 > $dev/trust
> # echo 1 > $dev/authorized
> 
> ...and the result is cross-reflected for comptability:
> 
> # echo 1 > $dev/trust
> # cat $dev/authorized
> 1
> 
> Consequently this:
> 
> # echo 2 > $dev/trust
> 
> ...would be equivalent to authorizing the device and unblocking ATS (if
> such a thing existed).

Yes, I don't know anything about thunderbolt, but this seems
reasonable. You could also do as you suggested for TDISP that trust!=0
auto-authorizes.

Basically the 'trust' generic framework sits on top of some "trust
ops" that will be provided by the security module that is affiliated
with the struct device (ie thunderbolt, TSM TDISP, TSM Link IDE, etc,
etc)

Then it becomes a general synchronization point where on one side the
"tust ops" can ack that the level is acceptable and consistent with
the system when on the other side generic compoments like IOMMU,
driver binding, etc can respond to it and change their behavior.

> For bare metal PCI device security the TSM 'connection' needs to be
> established in order to enable device evidence collection.
> 
> echo $tsm > $pdev/tsm/connect
> <validate device evidence>
> echo 2 > $pdev/trust
>
> Now, I question whether 5 trust levels instead of 4. This would be to
> explicitly only trust devices where the TSM has established physical
> link encryption, or the TSM has asserted that the link is protected by
> other means. So the trust levels are:

I probably wouldn't use an int for the uAPI, but yes picking the
initial levels is important. As above since this is a clearing point
between two different worlds it needs to be defined in some way both
sides can understand what it means for them.

> 0 disconnected: bus does not attach drivers
> 1 limited: core code deploys hostile device mitigations like disable
>            ATS, CC force shared memory bouncing.
> 2 DMA: full DMA access, driver responsible for protecting against
>        adverarial devices.
> 3 Link: mitigations against physical integrity and snooping attacks
>         deployed
> 4 TCB: full device interface validation via a protocol like TDISP,
>        CC private memory access granted.

This seems reasonable to me, the 3/4 distinction is not meaningful for
the iommu&dev side, but it does provide a good check point for the
"trust ops". If userspace ack's that it expects physical security and
the kernel says it isn't physically secure (or becomes insecure later)
then it should fail.

> Where the native Rust library based SPDM driver only offers trust level
> 2, bare metal TSMs can support trust level 3, and the TSM interfaces in
> CC VMs can support trust level 4.

I'm not sure that the SPDM driver even provides a "trust ops" right? I
would guess that 0/1/2 are simply built in always available if trust ops are
NULL and 3/4 require positive reply from the ops to accept it.

So #3 needs a "trust ops" linked to enabling link IDE.. If this is
done in-kernel the link IDE module is providing the trust ops and just
using SPDM as a library to establish the link IDE keys?

Jason
