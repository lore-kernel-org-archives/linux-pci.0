Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CC31AF31;
	Fri, 20 Feb 2026 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591852; cv=fail; b=F2YmyrQJEINTsNqp7BEWX1TQRm2EPgpdNHFL+lsLNWdW9JS6fNPs1PjTESMcT/cMscL4dwi8kCjb9GSsygRo8Mot+8X2kyBSPIO2hzz3PwJmrUdqknoYrBZ9vfI18pOJh3j9hlov8lTShWumJXwgdntvJy54GXMV/c0GqtioYpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591852; c=relaxed/simple;
	bh=QZXhOeU1Xg0xc4n9ZWGbF2ChQG2dlEiILYDhIya0W/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4DwWScvtyMRP7S0MFx7iUXW1Qj/JsEVSidrEVg/eM7NXUnnS62A4gReLQhTNIqIp9EV3ou1Pm9jSQ/ACvIFu+906sJcGRTX2O7P8x0hO4S0t4LBpgXjHbgR4YOOIu0E1lD4r3KZmGYyPVUDJ7PGh6ocX7HcZ2deksn5aHUxdx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4+gHJ3k; arc=fail smtp.client-ip=52.101.62.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4+gHJ3k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id2UhzWHqHdZZDxhPDGItD4AA3gHf9ktkC5L5DLGZKJ74uEXdjGtikNEaqMlVW3cC9N723tkF0sGU1j12Y/VmuzLfbuCS2nr1P6uvc7JuJeVWpZLFmchGixAt2b+I9MNuPMwAFfpLEDaTICSkXg3fuTV6LkfIOxoQp/86P/SOx+EZI0rDT2lXWALEXP8Lh2cIvIW6AOGVeK/GgaJ9ze57A0dubZnAxrVuShxEPyDWubXD5fJbpRZ5/19AZHMbEa37AUPK8zoQDfIGUYUjU3SSa1Qd2jV7XQpAYU1KF+W6D5Aio5IEI3uD3RSumlaDR+mJRZ/Aelbg8CwI+b1ut/8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwrHlzmtHsa5ogvhRX34aCNQeHA7c5YiXKWXe5mHUZU=;
 b=lo15IfuhUYz608tRHNuYdiTJSYu10geLjyPz3am14sw63W25I6oZwRQ1UaeBlKjO8f8iR3PdzJBaNvi84bloK9LPFlLDN2r64A7gnzmQ8Ld6AwV/57EgjIHP9KwzFPFRptzjO7IAwEQWzCeJ8BOH4RxAKfzpA9/SvieguweBubRfkLXX59jcgtm/o/zgbceEUn0tEOXkLLZlIDGNkmlL7XDNei2T2TgVpdZgawp7eq3VOunW0F7VsOPtLVY6OpiRN+/P9tcJ/saYnQrqcCKKwsSy6N5E5+kVO/og+QugQcyrMnzc4szVuAnIZHZkprQEQSY0sn+WU47OXVXac1e4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwrHlzmtHsa5ogvhRX34aCNQeHA7c5YiXKWXe5mHUZU=;
 b=O4+gHJ3k0vwDw+Vb2dRbW9dIxW1+qHlWab8ur/H7rg4Aib0vm+XBQaupOu+RrHVmHTYQ5e0d11XQoDhnjfkLi/27dGWbFLxmUT29e+ev6gj2wtb6NUTmgdnDiUt621uyJiGkE/h1cnx3WgMvUNr6OJ3lNFbfIUyYDxZeBDv/pbjKCFfbftW4E7t8Q0wCYUyTwUdqILGoddQgZeGKE4R0E1CPEnPyrHg0TrHVKlfRFRUtHCx/kjv9wX7HAvhlL2yEXRxTVrYgDjIFntqfrYE/omLaWesPTnKbeHFTDr34MeYQs+rrBJPC/uewpbRgufc2NOyIrZVWRzUeiYA7S/+ibw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 12:50:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 12:50:45 +0000
Date: Fri, 20 Feb 2026 08:50:44 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: dan.j.williams@intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260220125044.GK723117@nvidia.com>
References: <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com>
 <20260219143737.GG723117@nvidia.com>
 <aZc//6kvH3Eqfwfe@nvidia.com>
 <20260219174139.GI723117@nvidia.com>
 <aZfoqETxb31jp/Pk@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZfoqETxb31jp/Pk@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:91::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3c2bf0-c42f-4fb4-a83b-08de707ea9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UqZC5JSSUXsjZU5938K/UNBlK2u4UlM1lfcnGC8dXpDQuSUQpSu3afnRKlsj?=
 =?us-ascii?Q?Joqe6PV3GjUP14yr5dg0EV8wS6HCi6eDW72KUiDFyNd3espEZLzuC95NQ92s?=
 =?us-ascii?Q?zWFpt/PnAPEPKUjdHE7REBqREF9mDGaI+6k+zRZvOwhVrrMUWUHFRhkSf/Kg?=
 =?us-ascii?Q?oKYOnI/trrog5HTQoj6dXzp1h+ozwYT4/Tr6WYpdJ7JsE/FzJ858YJJCkLea?=
 =?us-ascii?Q?eHahLk53kO1uYPQkKQcm7p6T+IaKROCykQBqdNGe07hE1rOKO6X309Nhg0Yl?=
 =?us-ascii?Q?C7KAIg2aIV96EGRrVy8aGv9GPWZfV0/8MyliZZYY/6zddEBQ/BX3QYS5P1y+?=
 =?us-ascii?Q?tZy9xKtYZQBtBfzYAIu71dCJG+lxAapWGM+0ViUkLGGO2f3fuvrQoLp+rpbj?=
 =?us-ascii?Q?GvpL3qjeWMt26p4fSBk8drOFgoddB2gKhd4XPh0xkyjMt1uV8bNRyfqjkCZW?=
 =?us-ascii?Q?VULe40uoiVofYBVENlEUS1031+dlVRCowonp8Fs5QeK5rYWdo6cBg1/JCwPz?=
 =?us-ascii?Q?7PZG0umSsNxqVOfKD4G7vOz1Lx+h/J7K0DPAYLPaDZQUtSawye2jDJSDFJib?=
 =?us-ascii?Q?A++tFtof6r7wYT3RgH6OT3KkJmYqTgatEMjmWBKY1CTTTvz5inle5WZ25fJy?=
 =?us-ascii?Q?j9j0t/O8DEIoWKcKszeh8mChGVmY3b9cXKUMEb/nves7p5l7hdeJG4BimNpV?=
 =?us-ascii?Q?8Ko31JqNN0N3hDYiv44lrYX9qmXllHk+fA/1N0y8jCl+IKc9CyAgIxf2CFqR?=
 =?us-ascii?Q?uP7xfq/ogLzGKlpc4v175KYOgeYaAe61wI70QZqc0D/BRWjH7iBGI75iMaWU?=
 =?us-ascii?Q?6Hc+sVYB/oy4SsG/Tsi8iOfV6ZPvvj1EsaHfSyyeSr+plly8eL5kCyC0+EdP?=
 =?us-ascii?Q?i4w7nYnmpHdTjsX78GhkXslToSx6krPSXhvRgybIrpaDk6iMpyGBXI/k6peX?=
 =?us-ascii?Q?VpXlWQ2IQJrgfy3PSSBTuP6FxUxQNZ3wR1Llo96LIOZdBL95H/0B/7f5e7Zo?=
 =?us-ascii?Q?CnYhr3xlfdvZwevhYu67hIbt/xcuKF1M7SlVfFONDd5w9khaBJqVcPmleKRq?=
 =?us-ascii?Q?c9TpAxqM3VxdlT45NpShCzATEojHnbWdhxMNx2xWDi1CANgQnwfI/DOIkO90?=
 =?us-ascii?Q?rL0VDvW1khecrZp0M0lHwbaWkoM1A/5FJopvt+gjs/kk2IUomFxGu5x4Q8kI?=
 =?us-ascii?Q?pxGajPTiAnNpIR8pISpU3nfkx6uc6JhuNaE4uowbKCZulOKpzgoBumjif/3k?=
 =?us-ascii?Q?7UtjSo0ANf4jtorFffZSFYuqfHhcElvF4IpNvgw1+l/smO4ClDD6zhtT7cow?=
 =?us-ascii?Q?1hsXKGtCvgUGDOzITDKXTx1l10VUIfIELe5JzR3Likis4jGTW5dkLk2Z3nr6?=
 =?us-ascii?Q?3BUO43H365YCvyGYB8vfhD+QMep/dOqhFAMu/+4/EnVg+JX3EdxyyMn4QAy5?=
 =?us-ascii?Q?hRZeDTK9+9EfRipEFQ7zJ8amIovwWiRiFQaZ+rCtjciw76MwMuybPbynupNS?=
 =?us-ascii?Q?gsPgZzwiE/0X+IhbHYDjByPJJxYST71ogHYhDRRNIHvXBvX2b2E17YWP88Lo?=
 =?us-ascii?Q?lONkEJVgTu4x/yu48VM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NPuClRaIGkOOPNxJheFk2kYGMGatjBg7yF3ReARLIGmEmAAmtuRunIEFD9dp?=
 =?us-ascii?Q?JDWsnpyt2RW0qOYiK3CA459MXsPr5rbnK7gqxAQZeuxvjAEA3vIKg+TOx5sy?=
 =?us-ascii?Q?JoDEtDg4aIWMaxZHDabC24ghpyOdkKz8oN7ORAU9Q1LSv4euS+r71+a06933?=
 =?us-ascii?Q?nqmvp1E4zl7EcJIWyVS+dXdbjfvL0t/dsdLhj+R5SCXskjbprRGrU75RykTu?=
 =?us-ascii?Q?jnuXiyghbjMY3FTtbLpvoo1btXfnRI71T4qtmHBUs1upkOofoeBu4PMm5/uG?=
 =?us-ascii?Q?Xl6sT1NGffNR+mK37bUW06KFBwwhxM/0sBmYgFl1g1KLYPwEJY0bE7edr4hW?=
 =?us-ascii?Q?i+3L/BGpjQr8Ut+5A9Voqss0AqbB9C9FMPdMVkqWrJH57P0JMVFSd5p+0FE/?=
 =?us-ascii?Q?lioOCSLlzsaZyE7NznBWwyXzIQLbaGQKnsv6gtJAed6KssfxaY4b8UBJ6+Aq?=
 =?us-ascii?Q?mW4i/GiB+KzyERchKqvenctlX3BUxporKPc0htF8sh9fFSkLB9AvIqjjFlJk?=
 =?us-ascii?Q?iu46Ez9thdOxwkhm/XAXd4urzNWVfflTkaMN4xz/jYfwElt95Sf9nyRTZslD?=
 =?us-ascii?Q?1SEEo5nojwUT7ww0Mdfm5ulOmKp0QQmIlRtqxpZETysYsVvGSJDvnfFZ4ky/?=
 =?us-ascii?Q?nukqnsGYm8P4lovOQbs+ENYvxkwAkUEEPGpFfY79KgFvS6ILel1FPZl9+U4e?=
 =?us-ascii?Q?7CZne0gXkjr7y3x/PqUZOa4c5sLhFsmBbULG5DLGX6tfgIh5ZqR5P4uujiRH?=
 =?us-ascii?Q?aucZVz5/bAxq74Pu4D+kJuzVCBLayRMh0JfKVWtrxUY/LTuSlq/XomwJCnlW?=
 =?us-ascii?Q?ee3LVI56PtlhTaGyRcdV1O/krkAwyOYk8yXs4yPIhkl4sf5sLwxp1EwV+y0m?=
 =?us-ascii?Q?55GSIrVCk3/W//iJ42ZFQudgb2TjvEcXz8ka71AJQrKNLMOgvq5mSKPR2zBv?=
 =?us-ascii?Q?hrCpAhiilEoZNHJwEeqFyrZqxx+kDyNK+xbXR8nSGx7BzT3e/sbRR0CetIjC?=
 =?us-ascii?Q?hzHYtfcSxSkBeUok/NX8ZC8ZEa90MWrwq3BktzYwi/+ag4b8CqgkZr5mh0Fw?=
 =?us-ascii?Q?JPmOjBBAHIlUj7Ct2JP5TK+eVKxS2kyZwUWhnn2NTYFPK6PLvq4XCEH814EZ?=
 =?us-ascii?Q?aMNyeUB6PWR2JctccTSbo7wEIKjIiuzMf5tl69fSdV4idGPft9TwyeLsD8rN?=
 =?us-ascii?Q?VhNpX6hhS0IgS0vsDh4br/jBaU5hjqU11aQ5PgCyJtm5SFUMUsD+mcnFUlqb?=
 =?us-ascii?Q?WDHh6o+Zpsll9I9vuC2jOXmMdSA5p5yk2JLuPxa5Jjf8XuhfWq30tWu5Si5S?=
 =?us-ascii?Q?nnUC1uwvPDYQ2E0JG3RKD8F6CJ4FNl2mgt/ZooExMa1WFMXoTXTbCzFG30zx?=
 =?us-ascii?Q?ooVmUfYulCOrR5NwvCRAz6AKC82Y8zcLzCtzW6HIiUevuPobK94jnU/VW9nM?=
 =?us-ascii?Q?WDLSg+4wQ11be1W/rpax3oPNqw3a9f17ecSQ6+CP5vziFjcmM0cdW9dt5RSd?=
 =?us-ascii?Q?TEl4JwrKHp1dtDKlWhWoyi88Nq2jrQ6JpR6bDjGqIwSH419YBBQ2uZDlAEuF?=
 =?us-ascii?Q?utdEoC1ETl86HS2kn/AtAfY5Rj0JjCpR5HO3r2RWUxeo5ILZu4DlyRr/yRTW?=
 =?us-ascii?Q?cJcgsxUer1DqzkIASm1d/0aybECI49DgGUdL3GmM2shvz6YHwlI8P2+X6K9O?=
 =?us-ascii?Q?hVAIX6NbcpkeL3MSEBrZNemnYcjVC2x8tmA9Apd1qQmWXx0f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3c2bf0-c42f-4fb4-a83b-08de707ea9fd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 12:50:45.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIIiqJaFmNy50uH9i4nwy6XJvgEGRtYbNnWLylbVvL+n/gTjeo+RN+EF/9gM4N56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

On Thu, Feb 19, 2026 at 08:52:56PM -0800, Nicolin Chen wrote:
> > What is missing is to bring back the IDENTITY performance optimization
> > in a secure way.
> 
> I might have got it wrong (from the last part below).
> https://lore.kernel.org/linux-iommu/20260127150440.GF1134360@nvidia.com/.
> 
> You mean to disable ATS on IDENTITY domains? 

The objective of this security step is to keep ATS blocked and
IDENTITY domains disabled until the userspace has "accepted" the
device by binding a driver to it.

The off the cuff suggestion was to just park the device BLOCKED until
a driver is bound. This disables ATS and blocks translation.

That doesn't work on ARM because of the MSI issue.

The next suggestion is to park the device in a real DMA domain with an
actual page table and DMA API hooked up. Now interrupts will work and
the domain is empty so there is no translation. The issue here is the
domain doesn't block ATS. We could fix this with some "disable ATS"
domain flag.

In either case when the driver is bound and requests that the DMA API
start working if the user requested IDENTITY then it has to be
switched away from the parked domain to IDENTITY.

A final thought would be to change around the driver managed DMA
mechanism a bit to allow drivers to indicate they use IRQs but not
DMA, then the bind step could switch from a BLOCKED domain to an empty
DMA API domain to allow MSI to work.

Jason
