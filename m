Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7A2DF132;
	Wed, 25 Feb 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031032; cv=fail; b=MkEKDTKEw5JkF8BOoiGALBNZbw+GNqiN18GBYLD7pqLrdBWvoXEbwYn5n8XdYJ5TD8lLGtu3usMA14QfeUCl+HdR6bwg5ANvJ5b/YYWsynt5B+IRomSkaos6/Y+w5o16+571IeArb/e5+hPRsgITJxlaAqRBZ7gnkG/IHGIj9kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031032; c=relaxed/simple;
	bh=09T/rM2oCktd1m9sQVFiQoQyGvWgG3AlTV+LNEadfRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TqOGSy1v8qdPqNny94IRBecu6Ti9HOplkMiJIRKBpfpe/YYeUb9BP3TmvWucLh5lkbASu5KPM9Q3+QBjbfSSheqnjJv86pWccaqPIGH9mF0E7GKx1rvdnvE8jAOfIb1mJE7A52v5bJI6vFUui0S3j/UvyRTix8hsVT7O9dXFd3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ieNgOph6; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ieNgOph6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLm67niimzrcwDExWBxSixs5TJgcp8QyUM3Z4V0O137oBBl1jflER8sJaPnpKVY6lLkpL8prs3TsLdM9/H/iA0kFwpRQh5hoEIQAK7Z1DeRdNlsN6ZLUEEknm781z/WrBXuVugDj5+ecT18twM2184X/G8JSEdmHhFbPsWrUJeExJCF/QFJxe8VNXcTu6Bx0AKRA3K4cD66edRYky5cpl3fZOdcp9W7zfGSA43HDlBlpWikZjSLS45dxCCJHiQrOrAl/wxVrKuH4/oe7hZApQpwLfp3rkjeWEqMig5RV1zz5nyHWMIOIoYOQKSesNujlOq1QP+gy556wL2l3aWMDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XdUlP3nZFT7J+FDqW3GLQvgqvXjiJSwNwZVViNbqq4=;
 b=ET3g2CZ5PLu2egkOn8JBh6EGUhG7s4KEg1oTRLzjQsbDbmpzzVpY86lkqXyPf6iKSwnSXkWEzIRh+p1Oc8BcESQDS966t40LTEmD+d0cWm/Vys50m3GfrobUgd1sJz/uZ+SOHcLKh+o2uNRi6YWP//WJNxW75cc9BLNgbth/3lxNG2bt5Ummqu7Bf9fDo2YAz770pp0+jrVqLFKzhMLUksVKFu8ipGU0Y5VFx9qLrqhmKA87cF3ko5XKHstMrqAxG2oByg2KEThIHv+eWlVO87dcH+K7JYijIsxYDlTb5JsvzcZOMTxnm7KaFzq8vRHXqfm8OtzZ9B5K57gZTvIoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XdUlP3nZFT7J+FDqW3GLQvgqvXjiJSwNwZVViNbqq4=;
 b=ieNgOph6RMomf/HxIu0Cq78FTddRtMO6OjeJ9lSiY9eHfMggRQbbtNBBONk42R0MJ1AKbXDmctUl1/478c3/P6aFifN1AmNkkrJhO8XsNtnb+R+EjYsFNp0N+W3ibaetaofvS1ONM+zrxxxiorenUT3aUjlIDLsqFndkvAsRZ9QcPurdQf2nJWQL1qXPt9p3JUFDln+eM6UFkvLkH4q8FHMmvdfjxR/EGbAjyaphaAelwV0pXzjwfOsKVZ7feYjfVNJ9euQYXCI3P1f+/Tj9ljDzqozdc7pWiINqagR9XzDYGntcjKxVTC4gWWoD1XhRD5vKZ1+Pb0PPGsj2OsRofQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 14:50:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 14:50:23 +0000
Date: Wed, 25 Feb 2026 10:50:22 -0400
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
Message-ID: <aZ8MLk5w8eDd3IB7@nvidia.com>
References: <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
 <aZn9cfhv0YRxI1mw@wunner.de>
 <aZ2yqpdf8cBGG4Gs@nvidia.com>
 <aZ3Jp-8ZjYwgfq0Z@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ3Jp-8ZjYwgfq0Z@wunner.de>
X-ClientProxiedBy: YQBPR0101CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 214121ba-7cf7-4036-8fd6-08de747d347b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	fDxOSR5AAco9NhCFCCDnG5wHKJDwQe+red29iwGm+jUCNrAH+JoDjcSdAvwhHRIivCwKWRTlg28QJ46VGRcFK3UkBZZrDn12aaxA8/otcyuyhEzcak2MaGq9ZxiAbSwVZQO+RAq1YEcdwxq/GZvdKddiK5uEYB1CxVIBsls5993KXO+Xp4C4Ti2QsTA5/a3OUxHIjfhTun17sb/I0fJiQ5IHJlmYBnFlvbWjTRHc0NXEFniA+Lx+HyxkaDL98zr8R1p5bnvu5E630pCU2ZzZJalaBQ3dJT6WAt4MwJO6cb3Tdz6TrUekabgQQYKp7kFCO6Wdu1ueoX1Nb8WbjILsTNQ/C020oJVzo5APiPKQh2w0YoLrGmiiHTM2f3bGyz+qVz/gP/67KX+M7T0a3gbu3UsB5neUfh0pCZ3L7v6joPtmeQDZWV63+yLWWmQ34zUazVyXH5ATFNWY7gYtfoMh7oBS+JANz3jLzcU5iLoCnyNppLxXPzS01sjCU89DwqRwU06jw88cEg8DTlGp+dD70SYFA7FCR7JlHynaRVCb0y/PNcjuofS9/IG3HPw3c/VeHlvldeXbUB+U3bO0pLvowMbLgkwpXFGFJCwTpGNRGBPbHhUKm79PIXO9ZMb6L9KvFsaCNelH6SaOFj0qiQ+5zeH7SNvxqmEKb2RKJiVHo7b0auE2NzJcZQsjIigSdWIOIunReVn/6yt3sOAabMBiuxcMHVo01GIFaJGvEmKjApU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LZRkfWZYKtsfe+uLa1R1Fnbe/p24djQelvqFGmFhoAhCFEVTkUTs9+sODMiW?=
 =?us-ascii?Q?fyhBzflde6Ihmv9Js7xOLzPhCDcldY0lAM92tZIvU23Hl6fQEMPlP1u+QS9x?=
 =?us-ascii?Q?EDXrFftZLVKbBVK1Px5Wyw3W4ULNnNzQxETaaijphOv6dTnAZ8/3IDC8wKke?=
 =?us-ascii?Q?VJ72Rx8Qth0Ad7JSi3KCGyOSfi0Yv0kcn66jI9utrd5c8qWw9hRNS9HtPbSw?=
 =?us-ascii?Q?yVdhlJ/eCwEU7QH08C1cWs8+OYtygbizj0HRXlsgwY8fb8I1MYFyPw2Ldvy7?=
 =?us-ascii?Q?WPfN63JVD7iAmhICkfUxWuIi2LujkKL0aZdH/YOT6BBwYWrf8z1qOisVY/R5?=
 =?us-ascii?Q?6M963p735RAfAe2vFarrKICgzM0Mx0uPluT6qOtElQFjaLgw1/pv/4E2oAqV?=
 =?us-ascii?Q?98IdVS/mrxQNh14QeyGceHJvJtPydnUsottdolJsYsA/PLQCizFHVF+ZfzJa?=
 =?us-ascii?Q?su+BNfsMRa2fN3aqQ1BDnqwdJ/qQvg3XR4NDfnCUwetcptC8ZZjtrxtieKCA?=
 =?us-ascii?Q?ySc0mS9MXhl/7zsb0qUdaRBz3qPiWN33sI/bYtQNkaM9Qjb4l+8K+01gTa1Z?=
 =?us-ascii?Q?D4YbEjrhm+P43mqvH3YSHrMwlQwG7YDYAwfwtp0sY6YiNswQQVunxIu7zAdz?=
 =?us-ascii?Q?F0bPRYYX0G2q0//MDDqcp0OYkXkfrA0ZQmJaKPycw4+X1JE5AkFcqQScR11N?=
 =?us-ascii?Q?E7dMm0++3vK+YIk3I8ciFJqH+37EFVPuUPp2C01UPEmzBMvh6EFr56uY812U?=
 =?us-ascii?Q?E4TAsao6FF2Cj2iywynOZWkdrDHXUjBGia+BKDYEANl2RNAoSUdxDdlhSyJP?=
 =?us-ascii?Q?jPStufb4dUvwfTCB9dWJ2Vx0NGw+sI7WvITSr3708K2IML02Fg6MyP9ilHo4?=
 =?us-ascii?Q?pLCGNaWUK4zefkbgi29sJiVe0pf+SPzPq9F8GJNarWkSDg5awyB8o9rGfxR8?=
 =?us-ascii?Q?obpbzCGE5Lol5HPD1l6czLCejESoXia3xbJgfmyKsjyKFeGdSF+xQK8ThIbN?=
 =?us-ascii?Q?GTqJwv3c3sI0C921VZPT6xdphgT2mHZ9Q52MnWKv4lKvX69FsdvrnfwaK2z3?=
 =?us-ascii?Q?jdDwHtvZCubQMGL/smfrN4M7Hyf5X4CEWX+yOEfX7Spcch+ngbwbPGjzqrMK?=
 =?us-ascii?Q?2Y+xCYhGLxcu6JAcyOmKr2pctlj1fR1ocOyUwI8BIE0fBiou1ClmgdamYSTb?=
 =?us-ascii?Q?7mfeAM7o85JNmxe99ON85M49QlMf0QE6vDWuv2u8X08CwxBFs40781H0btNh?=
 =?us-ascii?Q?n1rACUgcjvb+T3kIngNGPFVWAJME34P2U/saX1WF2dT9hMEpLDBF0knSNMTo?=
 =?us-ascii?Q?5WCucf5SMp5OEcGbKKfX7hbv4WcvEl/nVqwdpCL/5b1hYaMNJzscGqz63kc3?=
 =?us-ascii?Q?deqdogytb18y4dDN8opYmZwL++r/x/YXqQbPjI5RhRR2WRudU/omwySXHluq?=
 =?us-ascii?Q?CR2ZFKqr3Kxt8cZfOxA66YdSW5mpBZdZzEPJebPSS5P/q6pZEtq9DOZEbNY4?=
 =?us-ascii?Q?yU7RRHrjy4PFSJp7BlpKXaMJfBwH692WJvHYz1AT62pjkiStwEt3OKOAkd9Z?=
 =?us-ascii?Q?p0l6eVdIb+9HoIvwoZyhpp1xufXNagjjPE479ByxiUXZ5AwY9jWkOkXoaASr?=
 =?us-ascii?Q?r/br+QEwWkOYQRPe6XSduDP4RFF2ZAtVv5TQXN7N7fYidwvBRtw0aNuxA32a?=
 =?us-ascii?Q?PjtJ35IoFOvJAL7b6R4syVihupgTbqghSbSWsqmtAySUsJoR6/GAb294R6+H?=
 =?us-ascii?Q?v8Ald5aa2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214121ba-7cf7-4036-8fd6-08de747d347b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:50:23.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne3FNaadMkfJ9oD5Q50vGG201UlGNgfTiaFG5mFhBBX9UFeoipujW3nKScO5bMMa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443

On Tue, Feb 24, 2026 at 04:54:15PM +0100, Lukas Wunner wrote:
> On Tue, Feb 24, 2026 at 10:16:10AM -0400, Jason Gunthorpe wrote:
> > This is why I'm insistent the starting point for resmue is a very
> > strong same-device check that prevents attackers from replacing the
> > device with something that wouldn't pass remote verification.
> > 
> > If you don't do this and instead try to revalidate the certificate
> > chains the kernel can be tricked into accepting a different device on
> > resume and that will completely destroy the entire security model.
> 
> Finding a different device on resume is par for the course for hotplug.

And? The point is we must detect and reject this as a matter of
security.
 
> > As Dan and I keep saying you should focus on enabling userspace
> > verifier as the very first modest step and then come with proposals to
> > add additional things like resume and perhaps a kernel-internal
> > verifier.
> 
> There is nothing to "add".  Seamless re-verification on resume and
> error recovery is already implemented in my patches.  I don't see
> the point of throwing that out the window and start from scratch
> just because you think it doesn't have priority.

The objection is it doesn't implement a sufficient security model, and
I'm strongly arguing you have built the wrong thing.

The suggested path is not about priority, but to follow the path of
consense where we all agree a userspace verifier is a required
component, so we should start with the parts we all agree on and
incrementally work on the dis-agreed parts.

Saying I already built it so I should get to merge it is not
constructive.

> I'm coming from a very different direction, I want this to seamlessly
> integrate with all the infrastructure we already have in the PCI core
> (hotplug, suspend/resume, error recovery, ...), so I made sure it does.

Well, this is security work. Linking a bunch of stuff together without
having a clear threat model and desired seurity properties is not the
right approach at all.

The kernel needs to enforce security properties and present a
consistent threat model, and what you have done is inconsisent and
weaker than the models we do want to build.

It also seems all your use cases fit within the broder models, so I
don't see why we should enshrine a bad security model in the kernel,
as UAPI at this point.
 
> I don't share the view that CMA is merely a building block for TDISP.
> It's useful on its own.

I agree it is useful on its own, but when used without TDISP we still
want to have the same basic threat model and overall security posture,
it is not an excusse to just weaken everything.

We are looking at building CMA based, non-TDISP systems that need all
the stuff I'm talking about.

> I also believe that the vast majority of users will simply need this
> to ensure the devices they attach to their chromebooks, phones etc
> are authentic (seems important given the reports of counterfeit
> hard drives).  A .cma keyring is good enough for Grandma's chromebook,
> no need for a user space verifier.

A chromebook has no issue to run a userspace verifier, and overall the
kernel community prefers to put things to userspace whenever possible.

Given a userspace solution will have to exist I think you have a
fairly high bar to cross to propose duplicating it into the kernel,
which is why it should come after the userspace path is setup so it
can be properly explained and justified.

Jason
