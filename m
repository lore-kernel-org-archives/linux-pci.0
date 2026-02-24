Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A85266565;
	Tue, 24 Feb 2026 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942583; cv=fail; b=HDOF/uFp7S1qLYwLhW+gza9B811J2rhYHt99K1XErRcg7/N/AShb1JjQhm6iJigYChloNUNDpJK5qGz2t62wjCCeSoEU1g3GWbtEPhVbfdLf81ZgbdtD6bLyXIpYDkE+J+4Vr0no8oVfY2GkcDNb83mJjMRgoW7+hewed4rGuPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942583; c=relaxed/simple;
	bh=KShmnt31u9Lavy6EpQCF+5cX7jicqf9ok8uxC3/Fcts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CHK4ydCOHL1fEHgxTPipGmBD+yP7CgvEnj26JjiieFZG2NJEJei84m9A9xzZIfXmq1yggjGyPkHHQhtce0sRPjTkFbGs0FHzzsYDd5LLtmH+V+fcywVXrKy5NBOaR19lNNxGFBwoZDbaa+kCKYe1a+3P8tPWM4ZRx7e8lcMNQZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j4FNkFbo; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j4FNkFbo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydWIH0vv20u6KVt59hA067/HXMaE0J4ehtTnb9Zn0B+kp8PdNevoXyB0YQvWynwEHvhujFS1rUmrLpOVkyuH05U3nmXci7MPyPMfa3amNUpz/ZFIfEnd9yzzBPHVlZiN9u8tTVL7MEWbVMBp/DV4t00mF630tztYjzw/fs8hhFe9AEr2S8g3Y0ZG+2sroKCHxYFZWt1XuMDj+RSGe4+0LD7QMGyG3vT97FirsCQ7QFnuM95hkgy1vJpLNttklfyaFdB1s/dF8vw8S7TJeTTSs51PGmXw0rZ5lkzZLivjWKBXFebm03aQxwQaYLgnB1rYhSDIeIubMcH15CCotHAnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRajU2i9X16VzFoGFI6skspCLIqMevo6zJUM9lP8ejM=;
 b=FI+by2ew/OrEZ/rZsD+LaYfxkxEcu/wftP+4UeyInBIcMkyJTVcb1OMNmQeX31ET/zyjwR+LktblJ62c2DmPqlec2n9cv90NFS2eeTZjBlcGegCABSATYY7vwSjIjl9XDOuj7KeKHtE4eNnEvoVY3OuAwyx2CKjzD+/QnBXGlgXCFkbo3wjrrxaoCJkCKLtRnI0E/CgLA5gC9OOGbiTyy/fNNMtWpRPnZFbN6TiC/fMV+fJ3Ab87R1rSTPZkK3/4kxGvQuhL2Ew99C5E40QOMEIZ07okuLmc4Nmkh1omQIeZ0JLQKPcToMNJ3poPTecS9+r+RtJsDDWuIy9LQJpDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRajU2i9X16VzFoGFI6skspCLIqMevo6zJUM9lP8ejM=;
 b=j4FNkFboJnNHDxoXzAfdK4sqKotm41xunxHIxxdxm+6Zj+LWyP5EFHOf4LIw8SMFiyFHd4+PZMysuzz4MyjC7JUu2gZE3oyvvIJvAaQiFxjD67cByFW9/YcPX4CUznHGkqkGE62GZSiJWPDKxw1XJZkkfYPUqUf97YsBaITuLbsc35reI0feBNMM1BjRcef91glS3T+9aJIuezJ8gIk9XRoaBpkxxEe+NDOdpEMi0EfNc0WhaD8D1A0aSTTQYDF0+vmzbRD2RlTbFUTDRG3SU1gOLRHUQWoYdN5OC6E4sYV/DPkNHJJSqJrwy8mR34LpeUHGdmm2N0+BpLt2mb23jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:16:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:16:11 +0000
Date: Tue, 24 Feb 2026 10:16:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: dan.j.williams@intel.com, Alistair Francis <alistair23@gmail.com>,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <aZ2yqpdf8cBGG4Gs@nvidia.com>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
 <aZn9cfhv0YRxI1mw@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZn9cfhv0YRxI1mw@wunner.de>
X-ClientProxiedBy: YQZPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7d048a-b92a-4653-91cd-08de73af430a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0u+C+jXFvdOJ1OyImKJi1OXVHFYSzOlPUJl/MgxvQXKK58cmmTyDsewfijEa?=
 =?us-ascii?Q?AQK1d66oVJKSyhJed6djb0OriZIgOW3fA4GpMm5IUjRlmhPvCFfmDiQ5GrtJ?=
 =?us-ascii?Q?crjW+ylhIYdo9k4K3uELalniurkCtFlQxRPN3ijppYI1pqxePpwQpDMc9AY0?=
 =?us-ascii?Q?p1r4X0Yuvh7kbTC0BlOYlPuThgzY1IM+yphbYeMMghBgprRuJa9qWlPW/agu?=
 =?us-ascii?Q?DHLCOLX/Qh1kKkbATzWvHLv9FYIKkIBQpB7wWzlUFvh2LPboEf+NtRfHsYcb?=
 =?us-ascii?Q?zbCDr16G+AlzjGwthhNVFY1ZpW8ZIZN3s94qGqYzFiXrMGP6XtqEknKdt04l?=
 =?us-ascii?Q?6BoRKOZO5/Coe4uIJSmqD3kPq5B5LqWOGxO/y7Z+C1sVY7bc4rRyU3bm1PtY?=
 =?us-ascii?Q?wogHLAOJ/jDzH2zA6hKuRbjcvMfxL1194+co8zyJ5UYxa/QXlLNeUKwtRBX3?=
 =?us-ascii?Q?0XYnUZBuGQD+UxPTRnHWvDvVjvk6f0MmaobbcBSdVeJt+LccaKKjl8v/cgyk?=
 =?us-ascii?Q?ndBpMDgRLNtbpmBLeFeOEynxFI7mS4XC4Shq/Z3ZRKQbIC9uWfyBoioZD/pL?=
 =?us-ascii?Q?B6ZKVnMEtzrMa5KJ0k5JG5SaRMAaoE+Tm3mdL98iPQoYpF7ss8fX933Gfe8u?=
 =?us-ascii?Q?25DQQPvBhke1/YOrFM0IGcoVJHMPRhid0uHXlnXtBmDGoSiOOO1vXOhTEeYc?=
 =?us-ascii?Q?1h3b5dKNupWA/q+3xKg40HFKCw7thr7HpT+Oq1lwM2C8IzFh0yu2W3Bxvjxu?=
 =?us-ascii?Q?dyxYXyTZ4bxz78DI3VXwptMNf4/W3apxRmc7W9BNXC5+NmNDQ0vxGgUmqmin?=
 =?us-ascii?Q?9vuA+pMwGMqGevx6/oGyS0TR//jfe0Gt8I7wTeURcp2D6B5w1GIuJhOnQigG?=
 =?us-ascii?Q?Lpeb8gW/E3U/R8Fbx+WWMHzt2qG4ekKp5ChjEbwOMpillgwkZAMrOhXSSgkM?=
 =?us-ascii?Q?6iJ9/HpoFFvrB3IJghAGMsuLdjA9KgjJIpUAPjlhozV2VjUbsLqX4pyNZWMu?=
 =?us-ascii?Q?itDJsDatDIYs7aBkyqkY77cuAECgwQgKgyQqOBctqJrYZBkrVCvP4BIO9Dvx?=
 =?us-ascii?Q?2BMQEbsSE/OGX5GrI+CcWH/i0HpfuvGxAXMnEOLkvzSuGrFrLgZbYHgLU9h2?=
 =?us-ascii?Q?XW4DeNn4YX/ro07Gr78118GB4KwdCrLA7vOdFWmoQyCP1edtfkxxm8Mp20To?=
 =?us-ascii?Q?0MW6NXXDhY2vrolq0pDcKQDAU8/bF7nkE/GBDO3yROCRy54weejO5jMx46Wc?=
 =?us-ascii?Q?5ZwlhG57igKvadHgm6bQrk8oq8K0PKISEwS1Uc0aQI7ezKSNMm9TXMenx9LI?=
 =?us-ascii?Q?KxZl2V7ojbyzIh6WSYMmGskeh2Dnj4MXJSK+BugAbDS2ZuytRuiPWAFnuUaV?=
 =?us-ascii?Q?s4Q8Z3C+HymxwyWfMtQIpXwY69ICG+L0O2we471aq9RSxwPq53EpIVLTSdtr?=
 =?us-ascii?Q?fFLZa3ZUdrH8KXpKf+Flahc9lNWnFKMlh7ebKxwfu0hDK0iSZsR9qSuGhBzv?=
 =?us-ascii?Q?Y0zOPnNgwHnlkLyp4iUdqmXzsRlQ3Gs8IZT1cuzhgVnPfM90tFxAozXapxXy?=
 =?us-ascii?Q?+lkEXhesJSUr/eD3/zo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/tixHe4TY/kiEu4h1llaC2J49+ORXkwdNk9mt37ROviqAR+OvIaHqkEr/yB?=
 =?us-ascii?Q?mJ2Td4CY2VbPRHjPG3RNXbb1EYQL7OI6XGVGVRD+phGpaNxpk0uLjQ3WOAJd?=
 =?us-ascii?Q?FdhJ/3z3b5YzZRO44t/k8YXCx9M3MlZ0eAYsDWCprA7trYFP2WccqJorGk4Z?=
 =?us-ascii?Q?bYKqN1flOJ7dfXs/p68kOdcFTAdlRvG+Eqtio6KlSf7APaJN/+f09OE2XynN?=
 =?us-ascii?Q?oXPv2W8R9QK0+10mgghMsNHsudAFUAhG2nFhVhQuZqVdw+P2G2scm1CmRBRd?=
 =?us-ascii?Q?KZXsL602w/MinFY6/knT0EMWw3AIRWVYoyzV1l7ePHEQcvqdWjAahIYuHkE3?=
 =?us-ascii?Q?tocKrMbuwKs2OxlApBJSC4z6J1sDVBbw7px7lIiIrzAV1kQGSUudB4P3YoeP?=
 =?us-ascii?Q?NyInE0JzG6edEJZgbSyfWO65chcA5cxuf0/YWHb+HpgHNiLdnOizRchkxwhu?=
 =?us-ascii?Q?gfuvqm+tnmNbi24sG8tt6IVyXg1Wta+H/Y9rnlYyaKfArrBbx7Oi9yT5fcvU?=
 =?us-ascii?Q?7QBAl0ChdIUpUu0C3azvInhAGA4zx9FI0AGkA/qNsdAZKTcQ/nHSbbCFj6up?=
 =?us-ascii?Q?e9CZLFtjIFsKvitCai5ktPM8VFtT9FCxE49dsmTjzpy5vrR5hnlp9fG3bBLK?=
 =?us-ascii?Q?3S9lqG2RlJxAgB2QzhkxGhmAYvfKQKdSfUoRzszsu//SnDQiEVcxc7QKBs2K?=
 =?us-ascii?Q?SI+jwv6u7vxixtIYe0iVC5UtDwObhoICpgqE5j2jCGDBPl8/nOKHUQhc05xX?=
 =?us-ascii?Q?E5MyB1ndFamIkZO6wsb+FxzeI1UC7YZ+zrMA/i7SLq9dXDV91D6dVOUlCUTu?=
 =?us-ascii?Q?Bue10PO8dWT1/yrnL8GSLMu/7oxBswUwOwmw75pvPWPB+2hrUfRdAitxgcgp?=
 =?us-ascii?Q?6JjGKHvuEBNZWVFBhRbRkH8LvRpc8NR53zLyH5QUi9jh/OK1LWGak3N2ES8m?=
 =?us-ascii?Q?SKdGTWvnJA30ZN6lWWa8YzL2Faye/PqOIpc/8MgsXojNn41jvd0sz2Js9lsA?=
 =?us-ascii?Q?w3M6jjBTcniRpzUhso968KiAYlMOXpjebjaZSctXROSB4eSfcqt7juEx1mKA?=
 =?us-ascii?Q?+yCWue3b5wOyeHvuOmBPBxrnojWdy4k6QlUZuiI6iRUBME10PnmSs2MJyO5u?=
 =?us-ascii?Q?fuJpTjX/VZQCDyAE3QswfTbHr9KLd0tsBCuRCONqSP11ohCvDyXdAhNF4qDG?=
 =?us-ascii?Q?pzmSEhQ89Yo38+eI1K6M0d2BRaipIyObrTSFeYw+G4QCmQWLgH9c/crABHRa?=
 =?us-ascii?Q?7Wtm6rn1I9qrfOzBPrbcsBKdLFcLsQfIr7cr+1UzYeDEMQO2ePwnWoom0O8F?=
 =?us-ascii?Q?vI7ZuHyduCfw7CuafcjxRk5N/1XWH+BEbJREsg9hXk5yEyokbDGARYkXscAf?=
 =?us-ascii?Q?zcIpSlgklbfqCcheoXW4A4a46p96DHZlh+LBWNrdwLsGDUPYklRjhvlyoibF?=
 =?us-ascii?Q?QClaX4K7qLJGuB2GZXaLSMYWmsWyYVp61hmJCx+BrIDHqOECf84XCB+gj3qh?=
 =?us-ascii?Q?oncRY1Cz2JenEZQs8kvCRzHmZpcIvfWsW9PNgmdu4vvKSKY9Te6O3qtRzzQ1?=
 =?us-ascii?Q?FBi5fPt4D5dn+KmsZzf5YznICYlHipJO5hktIopxSyRsYejEp6ns90BRmI94?=
 =?us-ascii?Q?7+/SAk9U9hjU4STBvsgRvGEBbIlIWIXFFxEK9/aLHK9aQ+GKXqpT8PU+yAa9?=
 =?us-ascii?Q?Fr+C9cp83ghoy8B5GhynhAWz0yuewpxZpKStAhaevKkt5eGKrwxVib965CNU?=
 =?us-ascii?Q?qVpdNfk0Pg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d048a-b92a-4653-91cd-08de73af430a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 14:16:11.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgeHHObN11YypaIQ3dsFvqDNZA8RTxkHF1Ck+RtdXcP9XZ39Tp53Aeuay7Y46vTp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

On Sat, Feb 21, 2026 at 07:46:09PM +0100, Lukas Wunner wrote:
> On Fri, Feb 20, 2026 at 10:10:57AM -0400, Jason Gunthorpe wrote:
> > IOW the resume/RAS acceptance criteria is that the second nonce was
> > signed with the same private key(s) that the first nonce was signed
> > with.
> 
> What you seem to have in mind is essentially a "trust on first use"
> model where trust is given to a specific device certificate
> (i.e. leaf certificate), not to a root certificate.

Not really, please read my email again.

I said userspace does the verification, using all the certificate
chains and beyond. Then once verified the kernel only does a 'same
device' check that ensures the device hasn't changed from what was
originally verified.

Spec supports this just fine.

> certificates.  These could be vendors, but it's also possible that
> e.g. a CSP operates its own CA and provisions one of the 8 slots with
> a custom certificate chain anchored in its own CA.

And the userspace verifier is free to check all of this.

> An alternative solution would be to have the verifier in user space
> operate its own mini CA.  The root certificate of that mini CA would be
> added to the .cma keyring.  

No! Why are you trying to massively over complicate this? The proposal
is very simple :(

> > Linux will have its own sw model, the spec is just the protocol
> > definition. In the CC world everyone just knows the verifier needs to
> > be external.. How else could it even work?
> 
> There are products out there which support CMA but not TDISP.

Sure, but that doesn't mean anything for verification.

Most models I've seen for using this stuff are "cloud connected"
things where the cloud is going to measure and attest the end device
before giving it anything sensitive.

That's remote verification, and what you absolutely don't want is some
way for the attacker to pass remote verification, then replace the
device and somehow pass a much weaker local only verification and
attack the security.

This is why I'm insistent the starting point for resmue is a very
strong same-device check that prevents attackers from replacing the
device with something that wouldn't pass remote verification.

If you don't do this and instead try to revalidate the certificate
chains the kernel can be tricked into accepting a different device on
resume and that will completely destroy the entire security model.

> In other words, the CC world isn't everything.  The modest goal
> of this series is to allow authentication of devices in compliance
> with PCIe r7.0 sec 6.31 and the SPDM spec.  

As Dan and I keep saying you should focus on enabling userspace
verifier as the very first modest step and then come with proposals to
add additional things like resume and perhaps a kernel-internal
verifier.

I don't see a role for a cma keyring outside a kernel-internel
verifier (and I'm skeptical this is desirable in the first place since
a userspace implementation would not be such a burden)

Jason
