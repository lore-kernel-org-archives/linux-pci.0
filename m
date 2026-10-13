Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3954FC330;
	Tue, 13 Oct 2026 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892674; cv=fail; b=Bi5oDcQ0UAGfjDXusq6U3xSfhtnuwkgaoS1Z5eBGOyjJiQbmtI5w9QH3ldwK9vPW+Fwm4wfN/SXHpzeAZ/IbtA0ihzAMviRwTk+lMj/Smsk0jYajOqJifbNcl4GmcbzNvUhkZs2pH+xgvbDQYbtbZpHn79xP357USsw6hUCiY5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892674; c=relaxed/simple;
	bh=7v9rYE2oxDPL3QrxNePGvbwsjjqOWCAz8v2Rn0FrXWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FGxeTiiSRS9sLp4n8JDkZo/2u2q6jLTm1UyPVIwcnvfRsratnpf3I9yFXnkpRVOezcCFtjEmc9j7x7h+uG1lJMmqomRq1El+PeUmWIjjhatRVfiTGlR0rc/Z7Rz245l1y684LhRENlumBys/+gj3quZSOEIMJCvV4msypobYKAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F3x2hxGy; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F3x2hxGy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6whly3yvNS1dkQw79SwuKkOp6KVHHOhScqYTgpZSR/ecSZXpqXqRmfwA5y2qTVm8b6tlhM+efaE+xFZIQHLeLozM9EaogGB4vHo/txrCDiqDam55VVViQdZ/YRTARKdqjd0KhKwo8xPRtH0FFkQK0L02mYSVBdbD18Ao/ptS1aDJGkZqZYMhSd11ObXr1Ng4Bc2Ffbv+hCdrf15LyZrZYNXDnzYf3seDtVGglJC9/tPl6xhdfvnkfiezpsHW4mWfELUthuxW43+SbJUhfUg0wavL+6Kva39FTpDuSanIm8nvuoCHSKzBDPN/xVArfgfZmezHRXY6Lcvo2bAh01QHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v9rYE2oxDPL3QrxNePGvbwsjjqOWCAz8v2Rn0FrXWA=;
 b=Uiyb/iId2spGNeY+dK/TEz7VF8odv6Xjx63UPfoYFxBtsqL6xGgogbrxVGjEOGbHN1xs5yUZAh2EplGjkcNPUdYHOy6H6HOue9naN/EAWMuxjAtHtC7GSzVpLeSHmLwwi6LopJekOicxoJJPtnge22k7YYDEB21Hh5Ce5iEtBihWQevLI8h2q0wGAQr9ol0PxFPZuEUyBMuIZhjMFZKXy9+RjKsPtaGzDP1I1h0b1T14WY34BiNb/Zt38s6QTH8+UalMuK1hq/oc0OriX49zKANIJ4/lEUQtLQIyCwQjVf2v53Y3pZLUZWuPwrRfhdkKre4FdirMEU86iglIcEdSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v9rYE2oxDPL3QrxNePGvbwsjjqOWCAz8v2Rn0FrXWA=;
 b=F3x2hxGylc2M3VzmZGAUEU995DTSgDfZrw7qjTZGaCzqswkqZwmUD2dhuCNmB6DjMUPKFv4jdZF7/oSpv6VFItvPpb+z91+fvEjQE9r9L15lZTX+bDeSBqMutiUdCLdJk0H/io4Ee/UCZcURr/uk2db1IqiOf16tKsM0z6FGpGRAiW9+q1lQRrw1KJrDnJBhREFRE5fXrqXnn23DSo+C23n8IsKr+JgqSG6sSfJSCPNQmw4oW2FBw3ujdQgFi55KJ7Z8Kx+RV6Yh8bm1j/N8UjngA7bZLuVjHyHNdBhxpGkArr6r5fGOCC73a3xDdedafNaZlbBU0TQc3XIyBDx1CQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS4PR12MB9705.namprd12.prod.outlook.com
 (2603:10b6:8:277::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:57:49 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 11:57:49 +0000
Date: Tue, 13 Oct 2026 08:57:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 09/16] tsm: Remove the device from lookup before PCI
 teardown
Message-ID: <20261013115748.GO13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-10-aneesh.kumar@kernel.org>
 <sashiko-outbox-163673@kernel.org>
 <yq5a33ub5lgt.fsf@kernel.org>
 <20261012130109.GK13920@nvidia.com>
 <yq5ald82q934.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ald82q934.fsf@kernel.org>
X-ClientProxiedBy: BN0PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:408:ee::22) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS4PR12MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e9f69a-f48d-4f21-ebdc-08df292133cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|20046099003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CJggKkZJsUWErXfgFv4CSetRaGQJuHmsP9erZQMwOSDaF9OGPJ7ZClbapN8Fha0+NrQtSknb/9nqKsemhHaZ56SOkFB9SNVtokzzfpoalFlvzX0tSkDp013DHTB5k9krnz6iDpqtCHgqbxLWQq21H5TXZa196hRWnyrORYbBvimFGDfLTpgMHAaxzG8CATsWOFnZn3+pYzv4qmW4OIM3NbIZ8nCQGd5mOsLnxgNwC0OB+8ZiiByOVki8T9s2OjVy/mYiiR40ZJiAO1jqkE4gJE4sl0qc5lzjMA/zQmoEWzLfpsY/no9K0AeJk9hZgNh3mjtkMSDezs75KMjIpbXGPoQN1K/5M3rdzJT2f97X2g8LNbZl8tJPxP+xWnn4Glg9Q255QFum455BY9FqCluBFswUYJaXYjvskHkrmSD0h93agc9/wS+el/ve03OeHGmO5gNSTI8YEEAE6hiDrjM3/SIGcjjQut5vDJ+a7LlMyUHk9vdABm60UBGDyJ9cC39MGo1H05tT04XsK2PYip/v9tCU7ZfJjpM8h+46Uh2km9f93TYdZsHKysbc1rSYqvJpC3V9UfLSHMC5QTaKcS94f6mX4/3X2uvY9tBBtC5+Q3WNT9x0EwsgHIc6h3FgGUbgHf1kZoTSD4zMC3CT0keOKsQnJLKzl0mZ+55fTrO03HE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(20046099003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHrKY2AzLHYHt2prBjUHe1mYrU+h53cLUiQ3xvm9nhXFJ9FoEp0MsYFq8Hal?=
 =?us-ascii?Q?QgES3TTOfSEAta05fTRoZFEAlvqm1AXzfhgj0VYMCZ7uBZ09fPjI1Yn8NzXw?=
 =?us-ascii?Q?/gNWiwk6Qo4ZHUzia+jL4UthDo82smxozzdPOPn3mBfTQg4MHK/v0fFAee9s?=
 =?us-ascii?Q?V5CKwJ2x1KQ0gbu/SgH9/5pWvfFoKbrnWti3pMxCIkQnkMZTwQvyUJyRNSVo?=
 =?us-ascii?Q?678WU+hn/QeaFUX1+Ih+wg5KHTjPRxWvIfx6gMEC1+3FOBTLwclQUzmGZhct?=
 =?us-ascii?Q?gLx7JFb9x8mej/Z83fY/VA9ciaDOsg7VVO9vq3XL/NKbcCgOJbpPzMgBJ8Pd?=
 =?us-ascii?Q?0hbzRrosbEVwOTCoOZaux6iQ8QOKRvwo6KD191jrpWGbJClBssf39tiVRUvF?=
 =?us-ascii?Q?TJmJvtB918gN2Rn5h1vIDu/JXQxDNm5ZxXjo/P/uYLReg5oYCVaJSRMlRlNh?=
 =?us-ascii?Q?CxvQi7O+fsg4Vo5uyxA0OkdVz1RaHdJd5Kg0dCfEMALD9bOzEZAgCRzVXcYG?=
 =?us-ascii?Q?MtzbWFAR2zLCxEaar4JgCw2BHiqrEnnUH0Ohhi4GKK5fk+wvkONkFqJ+RUvC?=
 =?us-ascii?Q?LTzQomqEm7c2H1JS9C8QbclriW3SJ4qO54ZpOHalediXSz183SOvN3Awcho+?=
 =?us-ascii?Q?1ETC5+EL5J4n3qxTo2j2NkJe3OMwwVqaIeBBqpcHyOFHVRyKMTsr66Wb2sGB?=
 =?us-ascii?Q?II26xDSUut7eIC5P0XYe2n2kmNmpjcQxe1fcNu/I4pGwRH4qgZg+T7czl16i?=
 =?us-ascii?Q?4QVNClbyKE6g07fzEvSVXs0r4r/UZkPipYuVVPr14Uv4oSaD3GohVprKhdzR?=
 =?us-ascii?Q?wPc28uTRQX1jwyOIos9wVC3iKqI1SIq74nolbIRnhi7fSA3XFkYM9625EiHQ?=
 =?us-ascii?Q?NgyidRWW2BliME6++cfwuJUF/4d1rLZePfihGm1NdWDK/qIltK0L4M9Pqzsd?=
 =?us-ascii?Q?eG2u2STUQTyLVP1OvbAuP2ZhRc37OnjVyxdp5O8BHX7Fgxpa2l4a6elE3gku?=
 =?us-ascii?Q?rMKq3jV2FgBjEiFzPlMEa84zDrUcmUmRU95Nc1Sf5Y89irdk6UxEOYKy/gnj?=
 =?us-ascii?Q?sUBDVTRJglA0gRnKldtEonHzM/RLn5/oUGWcsc7NAHc9T88mpH3gNDurFIso?=
 =?us-ascii?Q?XMg8N5sb1qVBERv/cbyXg9GtA+AwQyVhcovCtwa85kFA6YFozCwU6EcXIlKQ?=
 =?us-ascii?Q?BKuI3ZlYKdNtZsJ4Vso3WoZkdIl8hVqPoQPNxfzrYQSLgWN9kp8O+qHnFxK4?=
 =?us-ascii?Q?8NxNjGLL9y8B//lF2c5VgSS6KNXLRxX1fHr4HeawBuWD4y+iKTn8LjSk/0hK?=
 =?us-ascii?Q?tKdcLY5NWMx/Rg2OnHLagphFvUKnCwMEK+URe75TzBczKq1UMXKRuRDKlO3/?=
 =?us-ascii?Q?IB5zZK+VECDqzwBrcw6z/ltoX1MY/W1I36u/TBqcJMje64lWJeQMuctlGLfI?=
 =?us-ascii?Q?uwco7PzPlr7L/tN3+7xaBJwRu8JRBCsaGsa3IFc9Pn4X1G6rKREhHDlHvDsL?=
 =?us-ascii?Q?rtcX/hx6sG9ja0kqNiKgIjsOtcXYDmxVr0ddqOJ9VMLef+FZ2QXV/b3oGBbX?=
 =?us-ascii?Q?qEeo6BmDgaCdTr/BwCJXMEnCnX0filqS6xdQVw7pUaNIuDk4i2PTecNjP+Wt?=
 =?us-ascii?Q?tRdIHiRAgk4zXXkv49gfz7ENmFFyf6kGFwUVKrwsfaxOOiV5XWlyWAedTSiX?=
 =?us-ascii?Q?UBxCt8v92s2IV3LIEn1iUCsnRqq66OB6kdnBtm0xl4KAGZAX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e9f69a-f48d-4f21-ebdc-08df292133cc
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:57:49.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mm9CWqeKdbemiYSnmKdEEYrM6l0FTU9Uo8iuRL+WL8i6Y7gSwm4aQEu2YkcjYFl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9705

On Tue, Oct 13, 2026 at 02:19:03PM +0530, Aneesh Kumar K.V wrote:
> The proposed fix is to reorder registration so that device_add() is
> called last.

IMHO I'd leave this until we have a complete story. I'm nervous it was
written this way for some reason that still isn't obvious.

> I expect these operations to require manual setup: the administrator
> would first unbind the device from its driver, configure IDE, and then
> bind it to vfio-pci if the device is to be passed through.

No, definitely not. Once a driver is bound that is a security decision
that cannot be taken back. If this stuff is going to provide any
security it must happen before the driver is bound. This is why the
trust level exists to prevent driver binding so userspace can inject
some measurement and policy.

In bare metal cases where you might want to use the SW DOE flow this
still has to happen before binding any drivers, we can take a
measurement of the device and log it before granting it any access to
the system.

So the whole thing needs to work in some fairly automatic way where
the device-accept-d in the initrd is starting up SPDM, making
measurements, applying some policy, then binding drivers.

Meaning right at the very start it has to know if some kind of
platform TSM is available and it has to be able to auto-load the SW
DOE if there isn't..

And make decisions about which devices even have a TSM option or
not.

> Since device bind and unbind operations are already driven through
> sysfs, it seems natural for the connect operation to use sysfs as
> well?

Only if it can be made to actually work properly.

Jason
