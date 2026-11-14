Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794700713;
	b=esu6QbD6q/GOzB/FOyb6eUIfO6ty2SNcHAzeurOHPWu0ZFsSIfHsr+iWm3H29wJWssQF
	 EPG+ZmXTe10tSUJXlsgBYFe1jae2pgClgWhw4PsxilBjKjXPPgkBMmBKvQmBtEkkJjyar
	 PWqGWhWtePxaaIbtMsdROpxqZZJ+y67VjjwovdmIGsPrXF8LXnvSpdgGDGQtJwJ86IvTd
	 VJR+P3yyq3h6D7vawzVzV0wd1uL3X3D2LFhxLRrPaihAxgtSzQ7zIS5ZdTGowK3OzyeH1
	 DWpJ9ayHH69Tf8dueJZx3ComNJ+WawJ/lEZWf7GDXcfZUvbVGUUGNBHZJHSR3aqDA3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700713;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bpeeawqXAwXe8hvlJopUeaTMWg2WHuyiLKNJWkrx+f4=;
	b=u/nEg07VXOOJQxLDw9XbbcTTaVMNoQB6DaCnEjvFCpSRY5n8dOA+SOzaJMG0b+bKT7S3
	 D4VrDBlY0o1z1cbcYceL0y5brQ7vKomd0203/nEUr/h1tVlBe0V0RayT9/oN9IFzi1eee
	 1MlQYOJ6GmY1GY+maXAJdF7V50Z3JaWlxxci1pBcCUiUv8969dqYFMl9vUc/pAQG5GyJi
	 hyEksQG4oM+VECWwFhncMaczSJ/VQ6roZUB9njVBzO66fS29ypQAL/vAYuCg/q6D+xGj1
	 SKSF4RLmkFIG7FgDv1T3KuXM3yUEo8FUcXEpk+P9o6LwUq/iWRFbwNLulhf37QxaI0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gnQX0JSf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.2
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D311606A323;
	Sat, 14 Nov 2026 23:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D311606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gnQX0JSf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPYuQiX7nVQF6jjTls2JJ3dWYsqMTYMXgj9VJT0rqq+yERB9PaV50OeZu4A9Qu3ZPnnbjnRsZTsgJdJJsvfoNHrQ8onpPuknUYCZSopTzHzkdipU0YFV8/WEUKFzlwtnYSNXbcK6i+HRt2TkgEFitVeVLgccGp4NJUpmOWfaIHKmzH9C+q32WaEYxjs0NyQLogOI3Blr/3GK9tTaeE0peWUfK90mhO4WM+bm0C1tPbCsb+o/V840fcURV80gueKGR4efK27/Qe7ELFkd6JgBe4y6qmvyNUWGki2WImIcKhFP6LWlVs5bMqroMzNM1Kj/DzgZxySzu/KyDtj/PPyg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpeeawqXAwXe8hvlJopUeaTMWg2WHuyiLKNJWkrx+f4=;
 b=phlFpl3CphybGUtGR42SzP2r3OansBies9l2kTtnZAlXWtUXBTMJySNkCIBExCNy6MNck91miINysetyW4jRJkBh3iqPdY4KsyKYsuzKcPR613Y61gY1C/yn9LKRpNLwPmZOctP3s5nAlyP91vr6uvTyuAFVxUhQKt5WuIB9PzQGFq4AxI6r8qtN/1VvFpvMDB6J6ups56LSa1L0Bm29VXkgQA/MYgaP5Qf4bTYO3g1xzLkr2ksH8QR9z7KI07zaUXshjZfyw/tl89A6s9BfwPgGabEc2/wSJ9P+ruw3Ebu4FxRXjYtPmgF8dju3pYRiipaX4YsfIqNlvBioqe9CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpeeawqXAwXe8hvlJopUeaTMWg2WHuyiLKNJWkrx+f4=;
 b=gnQX0JSfaWIThT5puKLnGEzubVl7uJiV8PQo8McKIAkp/w6Hj12wRI74nOmPmByqufWPNCZY/xBj9kVZ4q3pO5WK9bPdbGmaXubxdY93ESwhMsfCORaBH6S/jZEy3EcJg9pjysGF4y0OyBJrsZfXCPK34R8yjV3nsKPTpzqraoHhq4C7fyzvhFgdUAeC3ljtInuA2qT437ZZaRA20LP4tdo4klSxgf5l7SiZWN5QwlfqlB/uo4RSWlgrEZ3Dkf/I9kyvE9xPJ1fb/4Haq+mWe6t86O0vRjQC4jyyIdudODa4GdkGx2723N1P5334SO3/9GkXw1bV71wvbJ3kzgZLdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV2PR12MB966079.namprd12.prod.outlook.com
 (2603:10b6:408:3a9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sat, 14 Nov
 2026 23:58:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.012; Sat, 14 Nov 2026
 23:58:29 +0000
Date: Sat, 14 Nov 2026 19:58:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Gustavo A." <gustavogyn@gmail.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vfio/pci: Wait for GB202 firmware after reset
Message-ID: <20261114235828.GF3706007@nvidia.com>
References: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0258.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::20) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV2PR12MB966079:EE_
X-MS-Office365-Filtering-Correlation-Id: 89250432-0d3d-4650-c1eb-08df42ab2e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	30TQXdawrUHQb0c/Dc4EDp9F8mkt9/XnyJjrSNA/m3A5NZMPdN5UijqN080uVwnIQ5k0vPn1cpnshopgbJs2A7ymaHkFAIREk1jD3WG3VC/SOpxVxmkT8pDzhjBOS+R3d1FCmYZZtYjvVFy8xEzPhT4wlH5vu2l80v/GJcUzcO3qghhE7NQ4u9A9umJWiksCO0E9DfHsvYjY3vKebmNPhJ7Z3KtaJhnbmABtJN8yxhbfx9yLgBv6EdeUaSN+4ujhUQ8Dw05YXQScMXVt+8CGQ/eLZp4eqj6bjJE8lIp4YhgqXQBE3NaAqT3RGJDEyh1hO6U2yf7exO9KvMXeTjrDJSG3Y8UF9Mvb2Le1H+v07DayOyJdXUbRX+48Fcys6XXh6kkLVNtxU72G1bM08skhGJJDtVJxXRfChhgvMMAMszMyOkLSn4ueWtQc47lDK5DvacV0hZMcvGua32MSeV8klAKdDyQQE/djyLyi1Jw1F5MZv90zTrkoMNneLEMBmkfndXdwo0fCen/moCOnBPdbQNACejur6IsVRFWTShxILAkSnfX/BgV/04Jzhtz2AA5O/Fhuh2jOCpmqJ6hTRh3iVeoOeqLZB77L+v5BrMISqXiryiIzxdL75mgDVEWh8u6SW1ITQ9VnAX95pK7XVDtnZrO+wQL5ndVJdgVQJYCdWI0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZerEi3rYKFysHkeTB3ffQvD7eIpXPOB5DnWvWGKShGEDycO2bHpy5ccZAhIB?=
 =?us-ascii?Q?veDWjdhdZ0ujFnjvyzBI6GXhK983Xnkbeusd8oBKKTblKcN1SrC2Lcd7FoKF?=
 =?us-ascii?Q?Wy0ekRqoO7+SF067K04SurT8yko1Mm+3Xj6RP0wld2Ld0k+gNvdf+t/GP1Nt?=
 =?us-ascii?Q?hMbvGAU/yV43wtG8bYPnQGuJ0HfAvosYXehiHRc23u4qSLEZmCjan1ReaPRi?=
 =?us-ascii?Q?uA8Tp18EymkJHSuq9p91e5wYzN5Z9VUr5bYuYLgEW8VlUxvCXo5zDbYG1FgB?=
 =?us-ascii?Q?nIRLHMuwTqHkG7FI4s032KoCfnP1RHJETkijFx1hULK8LuQrH3iRlRq+Njgv?=
 =?us-ascii?Q?gtu1qne/+puZadoc5gsC1COaTIYC9MDe+Ek7xXNuzYjtl61geYv3d5O6qLac?=
 =?us-ascii?Q?BkWibYHE5CUqdp1OKZ0pYyO/zzxWBtOt0JX9pjYWRkvzaGCEx3UG4V2rkI+A?=
 =?us-ascii?Q?gmKBAtyHy0OKYitQXL4ZTiaRlrz2IehBa1z/WGfgOfKlNiQXdEhUsKqw2JWf?=
 =?us-ascii?Q?oV5j1pCdtFFsQ1PAsAwktMTM4QI2RbHU+jCh45yqtKRn7s7QDlqGR3JumAxD?=
 =?us-ascii?Q?cBlem5at2GFJcQeSMyA2G2gyC3xr0RlYwKmI8dZh3ofNl8TJEyH2aA0no2CI?=
 =?us-ascii?Q?HmAH7gsw7j2vFpWuAfiPGJ4YR2iYEW/3UIpD+P7nx70lf9L2AKm5BbHdD+kY?=
 =?us-ascii?Q?bokJM63MC4A0riZ3EcVusZMyHPYpf2BCmGzhl5eJg0E+fKRW1ouSeWPHN8Fy?=
 =?us-ascii?Q?6p4IE8oKD6dZFV4Mf5+A6qpUp1MjUrc0ojYnEwCPP45eM24Jj0jaraiRTaGf?=
 =?us-ascii?Q?ME2FWzTjqc+spWXq72yO3RKgN5XnBqmLfbHDNapdNVeGfP19wufkCYlDdt5X?=
 =?us-ascii?Q?hGIwnNlBWFs4TGHHcr/KCgAC6wjf9yeuZxPrakEsGIuOGaX3LTrWucKHKMgl?=
 =?us-ascii?Q?WXyp5ofnLGRxiTo/UPrRUr80HstzDRzWWKqyNDipvVI7QcrkCP2ca0VngH1F?=
 =?us-ascii?Q?ifw33hvfbmisHxDT8gvrSku+Lt8cbZZAGOH4AArIIY9cNg19XbqVA45/Uerx?=
 =?us-ascii?Q?Wa6CV7b9pgWC+V8dIjW+5HtvjEuSZ0a/I0yyCKE9a3rBjeb09fM1IidseNBB?=
 =?us-ascii?Q?QkzTVcSpVJ2F1bFlAgNqnSbUG9dlD0D/CMHB9IJ6VWw8kKzuRgZQf65P8Y5N?=
 =?us-ascii?Q?zuxSrGfLUFFf4TzB4dGxY+B0X8sx/tQfO0A9YiIF3jhFQk1PWS/jVEweQfey?=
 =?us-ascii?Q?/XTHbjrh7a+Xuhs2wxT5G8kEIAbgOdiBFz3vgY3NjzkbW28KwbdrI6V186ej?=
 =?us-ascii?Q?WsszYT5OulotIAYFtVwxvPkU/of8HHJ9gaYto2vFiTtfJQ2eGvGUqHz/alvx?=
 =?us-ascii?Q?qM58F208bp4kKAcA/QQT3v8x6gz0VCsInlhpE/Np+6eBmty3+os5Bt5L+I9s?=
 =?us-ascii?Q?g5pjJGoRRYmTH4n2gBmxpSoUcvW/mi6mh/4g6r/TtsgM3EofIC+Hh+oAX2Kc?=
 =?us-ascii?Q?5LfBS3krDE1jbmKfge9293CytdW0Y9MprBdBL93ISorRnR4IfBXTmvdryrOb?=
 =?us-ascii?Q?6y5sXnq5G3PqwOWTXFGMAL9ycpDYxiRaWXiC1m0pVAGW18OiJuZvf260H5BB?=
 =?us-ascii?Q?gIsMbFydf0b4lmrkdAOiW74D77O53NFTbtpDCOFZjRiR9AIypfqEf4rdfunn?=
 =?us-ascii?Q?jjiTnPzyuabwJ+INQqM/wC2TyTfuwSjQPr4SN7crLu1vsBMZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89250432-0d3d-4650-c1eb-08df42ab2e74
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 23:58:29.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KO2jAZofPRq7Y4vrWGCsNEXfFiU2olO5d2dpg69lFp4W/eyalNFsG2ZGwROzQVnw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB966079

On Sat, Nov 14, 2026 at 02:48:53AM +0000, Gustavo A. wrote:

> PCI reset returns successfully while the Firmware Security Processor (FSP)
> is still initializing. Restricting BAR1 to 4 KiB mappings masks the problem.
> Waiting for FSP completion after reset restores normal output with stock
> KVM and verified 1 GiB BAR1 mappings.

That doesn't really make any sense, you are probably hitting a race
condition somewhere since 1G/4k changes the timing. And possibly
because your new kernel versions boot VFIO faster than older ones.

IIRC there was some VBIOS bug in old versions that caused issues with
vfio.

VFIO should definately not be doing things like this.

Jason
