Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22703164AA;
	Mon, 12 Oct 2026 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810077; cv=fail; b=Dq8zNmn7USlVzyKU5p+NUfcfaQtCieVlqbocrJMM2wl1PXmWil9dUru+NCnJlKPslbO+iJtbxuRZlLdQgW6ojYdQtShCc6rDnDjqeijL6I/do+aSt/b3G1sbcJeyHWERH5ACsiXeMnuFNdGEC9Ng0pYzDkM8jg7CUgjtwfh6Q4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810077; c=relaxed/simple;
	bh=WatcTcIw3EYXv2oe/Hwdo8H21vBAU0+/qGZpBeMLSTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u0UyT1D4xl1bwXnoT/DgUXnBrpDaOZknG11b9ByYgpc1UG4rN72tBciyD1YGLuziiQVr/bQmj8KqUjnv849vrjEjkvhv5e6C574SVUelg2xpr8+zzqNus1cw/7kBwhhEf3s4oT9qLOf4zWU48EzSaHnJ7R8tHzkw80pZz2ddFjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tXKqN7LC; arc=fail smtp.client-ip=52.101.57.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tXKqN7LC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptnZyyMVmrCpVG5nQiEuJEnmlQiPiG21AvuGEp2SoyjIBl6WQgepTzjkH9oHl0giZaGtB+IVYWk5QeJIIA7y8Q4TpB2OLbYIlbo3X2yGjeuHT+5M2qA+GVYu0V2BARvYMxtGHgxOmqKCTNKG6YLRfVXl1wwniSy+lvNIYXKaWxpjLNH4G320IX86L/spq0hWSjsX64yQJwMgzW4pUJoJBMEJk+PsJamCMtzyWyN4uvMIRtzx+K3ihnpSdKlxpAcpDgaoUai4UamzmWEbB8L0f1x2BCA5xn/q8+yy9WlHx9Ld8a2TokustEBmeU64NvGcwCQt+DQFWbFhRZE2e/awvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf21Fbv/ig8qZ/zx+ce8oTV4jnuE2k/R+f7uc1w7nRM=;
 b=q67kavmIRz1S36ypzxax2b0c/o9TmgRCWpbNHmdi2Q20IwiVniDU0Y/l7dzLtPdyHrwegtnrvju/+5hI0+Ddf0XVFLdstR/Sk18LFE6OnUzfV/6cvCYKpn4TTM7anPZB5j0RDvPpl3AlT7Nt70fx8VncVqy7tjUGbb6MNkdphytjFxYzq3zjtrAhAtMxWmWhgQltn41wAgsRRQn7HYpt75qtnDa2bcEvMYEQYj8XCUkznULsHwr+CPq3jK5FYXQbWS0T3FlZtU3AR/vAlfXhf4lBU20bawSfZDyqLB/W1YE7EdRiuwzKib2j9CLypaP5neinGpqo0O1Cz6EPW6B0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf21Fbv/ig8qZ/zx+ce8oTV4jnuE2k/R+f7uc1w7nRM=;
 b=tXKqN7LCFxmsBbb4RnuMQLsyJEYfVy844jSluLLjxoUYNU/K4D0uUMobCBpVD39pluuJ+0pDdg3wJoMZ4CcqYouXAlMVFSEDsj92xlE+MBbwm+hJ7fD2uIpN28BzW+5hdlVDj9RFlud+mffM7eWmfArhmY5RBN9oSzCX8aIW6kq2A8q5pjOqJV2gd0IfF5cv+ME3n4naLsq0VG/jVfut9s1Pdh+qbcZpGvyCHeJ0V4JdgjmRqFtC3gTCdfePyO6rOSg2GQ1ObAQOnUMu1nnFjvhPMl9Fx1Ix0eWw1IvvIvDv3K3p/SfqMxg0vDLcswf4K6u6vV7U9p/+N/Tff8ZFYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA0PR12MB4366.namprd12.prod.outlook.com
 (2603:10b6:806:72::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 13:01:11 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 13:01:10 +0000
Date: Mon, 12 Oct 2026 10:01:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 09/16] tsm: Remove the device from lookup before PCI
 teardown
Message-ID: <20261012130109.GK13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-10-aneesh.kumar@kernel.org>
 <sashiko-outbox-163673@kernel.org>
 <yq5a33ub5lgt.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a33ub5lgt.fsf@kernel.org>
X-ClientProxiedBy: YT4PR01CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::23) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 68eb5aa5-b08f-4d10-0a51-08df2860e355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	UgDkG1erra6oD8Cuti7s2bCyGq1sNvCWGuHqdWZWR1so3KY7ZiHNBkDUW++44Ykt3kxRfsGGtr9sGQ8DGHm/QqyiPwxxXLpp8wbQJ3gSXwvmQhAEbpdC4IQNgrk4Gb1x9g2CkPxIZmG7paGg3Olw7ScVYIC5IHZGE6vGRjRkvPb7NXZwW9jKoPwVwGaRcfq0TlObnyaHz/ebwWt3F7o6Org4qh3lPaJdEwNZBromRxO9J7I9ae5IKqoHuCd6PIIKfLxxzrm+nBj+kRzlAf5rIDBL2RpcU75wZDZxDouYDtSY9FFpft0jdtKJhb7ehfqV05BVuiayT+kGiYX+e1kHX82eLtGjUiRjzoDdY2lLxLy9Du8Ubc5x9EkRnkTANrLaeTMdRbNP6vAJTJ+PYknvEHc72XQLI9oAPf6C8Gt/qXyIAq5uOfEheHTjc90fzawHqdXtf6qQLmNOyKgO3Lqm86iteEAZCcNINZKEpMBa6jljdxL3UXeG7BqVSpCd/x8W6h+jxHRJ9wTN2tde/KulNWzbAszUofr9BfQREwzVNe05jJIWpWpCyAf3lhbXcgLf2sspG6BlRVS01+NDASZ8YNMW9qdXJFpUb1AgjIlRJgZU/rgmwG/22KKrJ09aMtjN4yd7hXPPrdI/HRU5rodSarbUOstc2tUc86Y/D/ctodQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GTOrj5VeXhj1FHBkH8FuTtqaF3DZFuSYrFysBRWkIUfRWG7nTM3zJd2qVspb?=
 =?us-ascii?Q?ft7TikgNONRswm4bERAOSkdoupmvKRAKvmsh+VXnDxAFRAVIIOM9Qmrf5Evd?=
 =?us-ascii?Q?4/Tn/BLmqoPY04H2cgBSUq0A+gQBQAfSoEv84GWMz2UG8JChIxzwXwSM+aaF?=
 =?us-ascii?Q?e4bvsSdJJWwSsk7RRY7LGxOfgMMArxaqFMs4LtBVWQ3nqf0PZuwV3nl+0LSB?=
 =?us-ascii?Q?gMNrLfEfQPyOd4mMlwwJseEmI+D9eFnrPKk1j8ajSQsldeZq1FDzQ2JPLB1k?=
 =?us-ascii?Q?CKMNLhiyYsLgLpYyFglgW8/BunHfJSEvWwmwKisa+UqcbnxiPHiSw3e+ITZw?=
 =?us-ascii?Q?Pa3IvqQ+fgI23Ppe9ijPjqN7Jiqdq3BHdwi9tlXt7c1Kcid80PUyoa5UpJEQ?=
 =?us-ascii?Q?7bQejZ1TQFAqAKnZln/AvXsjSd5YJx3wP4XFHOEZUm05l1ytgv+HH+hP2bGT?=
 =?us-ascii?Q?DLGhU0n+0imgrWUY5hUSTXDnYjBvwe/q9XhvQmVP/HYQwgUGOq19EYShAfQp?=
 =?us-ascii?Q?GtXLkKWYrAdCX1DqNmMi5Xd8qhrXlub0zX3v4U0CBCcIqbU84fbuGixnwijY?=
 =?us-ascii?Q?PjzCcpuw+Z+J+hflqg7qAyeuTbKdiLdpMPCKgdqY+1IWDdCb9WxDmepmhJEG?=
 =?us-ascii?Q?Ei6xb9JjlIS/m6WcC1xn276bI+BYL2pgw/lVf4lDQ/rOzEtVkKiWcKxkVgAd?=
 =?us-ascii?Q?29eQHOez5saL1cG/4krB9XFK2IaOIKt7zbt+skUf2Saqzt+LgZFTHZB96YuE?=
 =?us-ascii?Q?gjwKbuHlW+ccNfx4gSZPQGQy4Uu1nr3GYL2u9spRx+bO92eDjcnl+V3Bz9lK?=
 =?us-ascii?Q?JAnvN65yXxKOI5WXpV3Kipfk5CLluYt0un9cPrj+vSTyEBmL4asH4dYOlU+h?=
 =?us-ascii?Q?gsTHzrDXKFAMsWZcMXsyMmRHkPzQC1m+9QtnEjhXOFRSqpPYGmZUJUlQzFyx?=
 =?us-ascii?Q?DI7zcloMygWQxRvEMBkgw+Um/86iW0sNX0p2NyJMf28qtDzQr9XtyR8tUwd2?=
 =?us-ascii?Q?ERf9/N56r6M+51Hqmwte1qtX+g4AK7GQ1MRDSWkWlvjjf+KiSbootvckAGuE?=
 =?us-ascii?Q?g5+BUC9fZTPymVyXq4Bgsa+H8UXbUUG4ReB7BkYEyKiFXODMbamvZRvT17qi?=
 =?us-ascii?Q?w1lNHSNUfOx82L7SKiVfrLVF0vOG6uXBrRMZ/wBDcTqnkdcSfEI9lOPGYQ/s?=
 =?us-ascii?Q?N4OTAY0azfMRUlPp1QsgS4iW9ZAVFaRK1LTHqf7vRBRhaEdD8inoF2wM8syF?=
 =?us-ascii?Q?JCEl14n48GYlETZ27HOF63t/XoxCTMivntZYz4D4mMiqSIt1SnousYx5L8nT?=
 =?us-ascii?Q?hhSeRo5B3Nxf3k+o48XauWKyBQCNa3/PhzM28sXxFOVMI8jIYLXsdsg+xpB6?=
 =?us-ascii?Q?004ye/DzWzXUFwK7iDx/1bi/PLi7Ca8VG/82Q9G2uEKjwDOkZQEoUsRjJRul?=
 =?us-ascii?Q?26GEl2PLn4DKhhx7OEKTYIGKduPfsPXvPGwiIs7E72j7cLKXICmJvyo5iU76?=
 =?us-ascii?Q?bABPvkgy+LAHgWGKOy0cw1N8Hi7QUxZKtnOunB91pndeK0YkORCsN+NC4fYb?=
 =?us-ascii?Q?DZc9OSheMykjtEJPFe2d2PCmVYE4yAvSENCvHdJt0k6Y9T9RS1Iwj11GaZhX?=
 =?us-ascii?Q?mnqOjcv4gqVbxzLCKFWydg0fvWtqlYJbTEzx3/che13FFoa5HupMnOG+Hdiy?=
 =?us-ascii?Q?x27joPKk7sy782cOgEVQ9VH5Qm1pZbh4GXyXv63kox4ki3bj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eb5aa5-b08f-4d10-0a51-08df2860e355
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:01:10.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wX4NrExkR01HNST38+hAPpvzwZvsU07oFzQVi/WvYdXSYm+9pn5NL0gM5ZhlrAdF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366

On Mon, Oct 12, 2026 at 02:44:58PM +0530, Aneesh Kumar K.V wrote:
> sashiko-bot@kernel.org writes:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] tsm: race in tsm_register() error path leads to UAF and NULL pointer deref
> > --
> >
> > commit f9b77b7469552ae6078c3a47333908a88eec2474
> > Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >
> > tsm: Remove the device from lookup before PCI teardown
> >
> > This commit modifies the teardown flow to remove the TSM device from
> > lookup before tearing down the PCI state. It also adjusts the setup
> > flow in tsm_register() to handle PCI registration failures differently.
> >
> >> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> >> --- a/drivers/virt/coco/tsm-core.c
> >> +++ b/drivers/virt/coco/tsm-core.c
> >> @@ -56,26 +56,25 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
> > [ ... ]
> >> -static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> >> -						 struct pci_tsm_ops *pci_ops)
> >> +static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)
> >>  {
> > [ ... ]
> >>  	tsm_dev->pci_ops = pci_ops;
> >>  	rc = pci_tsm_register(tsm_dev);
> >>  	if (rc) {
> >> +		tsm_dev->pci_ops = NULL;
> >
> > [Severity: Medium]
> > Does this unprotected write to tsm_dev->pci_ops introduce a race condition?
> >
> > If pci_tsm_register() returns an error early (e.g. if a driver incorrectly 
> > provides both link_ops and devsec_ops, returning -EINVAL before acquiring 
> > pci_tsm_rwsem), a concurrent userspace write to the connect sysfs attribute 
> > might trigger connect_store().
> >
> > If connect_store() evaluates is_link_tsm() concurrently, this lockless 
> > assignment to NULL on the error path could cause the compiler to reload the 
> > pointer after the NULL check. Could this lead to a NULL pointer dereference 
> > when accessing ->link_ops.probe?
> >
> >>  		dev_err(tsm_dev->dev.parent,
> >>  			"PCI/TSM registration failure: %d\n", rc);
> >> -		device_unregister(&tsm_dev->dev);
> >> -		return ERR_PTR(rc);
> >> +		return rc;
> >>  	}
> > [ ... ]
> >> @@ -96,15 +95,22 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
> >>  	if (rc)
> >>  		return ERR_PTR(rc);
> >>  
> >> -	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
> >> +	rc = tsm_register_pci(tsm_dev, pci_ops);
> >> +	if (rc) {
> >> +		device_del(dev);
> >
> > [Severity: Medium]
> > Can this error path lead to a use-after-free if PCI registration fails?
> >
> > Since device_add() is called prior to tsm_register_pci() in tsm_register(), 
> > the device is already exposed via class_find_device(). If a concurrent 
> > connect_store() finds the device and proceeds to pci_tsm_connect() before 
> > this error path cleans it up, it will attach the PCI context to tsm_dev.
> >
> > When this error path calls device_del() and returns, the __free(put_tsm_dev) 
> > guard at the top of tsm_register() will drop the primary reference to 
> > tsm_dev, freeing its memory.
> >
> > Because the attached PCI context stores the pointer without taking an 
> > additional device reference, wouldn't this leave a dangling pointer in the 
> > PCI context, resulting in a use-after-free on subsequent accesses?
> >
> >> +		return ERR_PTR(rc);
> >> +	}
> >> +	return no_free_ptr(tsm_dev);
> >>  }
> 
> 
> I think this problem already exists upstream. We should delay
> device_add() until PCI/TSM registration succeeds. The kobject event
> should also be emitted after device_add(). I will add the fix as a
> separate patch.

Sigh, trying to do all this stuff through sysfs makes such an
mess.. Nothing gets to be atomic in sysfs land so..

It looks like this ordering is to ensure that when connect appears on
the pci device it can immediately be used with the tsm that triggered
it's creation. I'm not sure this is valuable but I haven't worked out
how a userspace is even supposed to exist with all these troublesome
races.

If you swap the order and remove the extra events then userspace can
see a connect sysfs but no tsm0 device. I think this is possibly
better as userspace will want to obtain the tsm handle then process
all the devices affiliated with it. So waiting around for a tsm and
then knowning that every connect is already there strikes me as easier
to work with. IDK

The bigger issue here is I have no idea how the userspace is supposed
to work. When my imagined 'systemd device accept d' starts it will see
a sytem with no TSM and no connect sysfs.

A tsm may eventually appear when the TSM module gets loaded, eg it
loads by udev through the smccc bus on CCA.

Or it might need manual module loading because it is a SW DOE based
tsm.

Or it might never ever appear.

So what is the device-accept-d logic supposed to even look like?

Before touching this we need to come up with a draft
systemd-device-accept-d shaped thing that does the TSM startup before
drivers bind. Then we can see fully how it can work. I asked someone
to start working on this, but I expected there to be a ready story on
how it should work, not more design work.

One possible answer is more TSM stuff has to be built in so we don't
hotplug the default TSM. Then the userspace simply checks for a TSM,
if present it connects it, otherwise maybe it thinks about using the
DOE one just to get an attestation log.

Module auto loading looks troublesome too, if we want to use the SW
based DOE TSM then how does device-accept-d trigger the module load
when there isn't even any sysfs?

Once again I'm thinking if the sysfs as a mistake and wondering if it
works better using a /dev/tsm.. :(

In any event, lets not get everything tangled into everything
else. This series is about viommu, lets keep track of these other
issues and keep focusing on viommu..

Jason
