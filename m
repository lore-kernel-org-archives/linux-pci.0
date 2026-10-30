Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348550;
	b=aw7+I5l/IaO2parXjXOda3w82NJ916Whog1tY4f339pL+/6SF1USybNpX+9kvVujiuuu
	 cNfqx5XHTsiKOHOuRYHf3bZPAhpC7QZQXZajoK5KuccDbR/i9kzojjhurj7e4v2hrB1XI
	 fn/tM9D+tdbKZL37hObtE5iN/3HgWAk0eueGd5cymsqT/YF8q8T11jRBT19bsv3t0h2Fm
	 cQrkIFIXP3b5rqHb5UCUhAtGePMi0zB4Ix0GmXVBtO/aCGicES+90z222R6OcF49Gth4q
	 2UmRKzZcAS9pT4x5JRK3v791hXTTNnKxNoYV3lQuFceNlY0ZCoAcuJuv7clHUwbF7Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348550;
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
	bh=VSMuLJ97+gvWj2AIGK1+R7tTHH1vvg/yLtRcUUhwuC4=;
	b=ppZ1Xy5M4ykyJ0r7JZ+nkTLtI7yGK3wzO2x9VBCkq/2tR1UQHlVUIid59AMquTgV6sd8
	 ablbDcgHWstFC3Oe9JfmsTXtEe943DfQVJZZnHj85urK8YxyuEWsMV+/nA0hdULtjDxuz
	 sGcsnf+qW9JGVpx7HRV0hQLNTyfyPMsvToTm92iSZrqFuJSjw8ihjV8wY1tmhIn/f1oCa
	 hE2CuvOdh+5AIVTkX+M00elRuL74JGEx5h7TKZaj67Cs4C0p7iB4wTN5xVhCrg+0M4+bD
	 WLswAZhVMSP1K/w+kThIw1eSHGJFT8ey7SDYN1+oLRTE5uL2PIQdMkzbWFiEfHcZOdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ByC1+nQ+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.19
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17F960A2601;
	Fri, 30 Oct 2026 08:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17F960A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ByC1+nQ+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhEP4zvA/Q6lsbVgf+3/hwVzGct9FzqfEjgBHgvCk2/89Xkr3ngVHA+xpvSk0PeBNW99z3RWMzLH4eLOq0LLINSDyckNgu8R+CNPzTY41QeeNjX0qoywLHMFOPIgOwz0SYC27kjfhkotmsxmvdAhu8RHsdmmyMmoX2evuLM9pQNUp2saSNHZ9/GWssTYpalGK4bWKa4zG+/pA4PzXAvShYveMtwXUBiPAGQuboPVOv+I5RdChBsweOeATr5oJ/CE+isfnLpS15qAAiVn1RZkhco1lVN48+zW5BcLrfZFPG7/FPj3nhfqnJAH+3rSDkbGwmZH3RhHo8sPOFIyQYsa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSMuLJ97+gvWj2AIGK1+R7tTHH1vvg/yLtRcUUhwuC4=;
 b=xz5PWWt+OJKYTlKNAnoaKOcYPCa90u/XnSVN1b8fYQnldxX6rQR9dRvN90J+yk5cuLm3VaAbNUagraVXNkjGrSsK3iG4QGacrhQCogzs7xLJYQ2GwbAkaN9wkKPYmp0wNJosRRnir7RoAzmAQgf2ZWhAKRW7C7UUqxbL7QUwjG+eeUupmQJ4ix0dPIasFehLFpJ6oSfrB9BLkWpUcIEePn2N+xumkyZaK/74jYcfZGBaSzU5ubB0SwmE1p7Qm1AGZj9SrOF7PwkU3lSseEpX8mqgDAwq0SiKTFKW4csTjAUwjQX6UriBsVzNjbnA+XO59HhMU+Om50Jp7BlnmfyWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSMuLJ97+gvWj2AIGK1+R7tTHH1vvg/yLtRcUUhwuC4=;
 b=ByC1+nQ+4MPaYeBpaznswiUuAX7Sg5dceb8LETDNsiexlHEBdbadYgun3T422C+TCS/Ger+zbmn27FKTbUtvL5ovk2BP3h26B24bhubYidn4s3RedUBDBWy9EMqCQjnkjKykgNjLbCJfTi/PpWXO/Qa4KY2OSl2yqRSWAhCgSEqZ/H3pjSd2qhxWJ4p8O2MhVg8ODZ9J/kVVdVrzlJny5Xh7nsAgFnLOgsgBTI13jbtAeIbUtFt0l34sU83UwyosWFFglKqf+Qn6ETwkZ8RG1Cz9Arzt86ubslxcZppU4hq8AXcQz/ihuki1xQO2+wASWym61IiIIP4Ohe+GLsrO5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 08:22:24 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 08:22:24 +0000
Date: Fri, 30 Oct 2026 16:22:17 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li Ming <ming.li@zohomail.com>, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v16 11/18] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
Message-ID: <auRQN6a3QVtqjd5a@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-12-smadhavan@nvidia.com>
X-ClientProxiedBy: SGAP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::31)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a1809d-00ae-4a74-b7c6-08df365eed13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|260925022911599003|260925021911599003|260925021311599003|4143699003|5023799004|11063799006|56012099006|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QTY35wm8ZY8szz9DE1V2ApmB5TfoVBDX8p1pn21vJDB55mvl+9MJqcGSvwoae8KDI3Z+0TvIPfgGVjYeICtC/vJiz9QOGq2MsTQLhvuanMqfz1NRpFmhH5+PBxMIlQSGz/uCuew7HBBzTZyVCPpbDkgIodfsMgDuY3+cUvKci6CAQX2kvz1AZhWq1CSIiKgpLV5OuEogeVY8kEEGpdioUTaNMYld1sohWZC4jK+c3iVGiTnuEoHzQR5LzOd2+c9jP5HYCVzHOwekFc2bbWHO2rjvM2pgmoMZPTuEXgKc4O3PWhd6MotUdkn3Dck1RTT7WE4s/4ZoPvv71cAZPPqcWkISA+KGbvPREvDUw2oWYLN3DRpINqLkqzBfjxotwnu68+9bEFLP9YzwfWRs2hzVipKbVBLODab1t4FRGDV/uT2UveB/9KSDNAkqMnIU2uArNRg0h+acCMKcfX3rQeXS1AybNwGBcLkV/QAeonXmzoKu+z2JOdbsyMULBP1rPmJRxvx3crroZVP2EM7noiS9+Vl75v47rd6tgl4661aFbC45wItUVgdyqgXugLt26MTpElguWGDOhQ5346feCl86S3gGFalrqbXa0f6NX+u/xKIy9mQ4r7BfV8F7t93Xi2B4WtYYrJyOxkmqWFc15mbVd5jm0ib5YBEa0DFezTcfwkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(260925022911599003)(260925021911599003)(260925021311599003)(4143699003)(5023799004)(11063799006)(56012099006)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRDLiBt5GmtWFWWGILYLwlTwPM5xBEVjLpfc6kenoijwr1Laxb7jsz9aB67a?=
 =?us-ascii?Q?ckbXMZkGJvUyyggcIbmg39eEOh4Z3VZ+CH0Cmopsk+F3CngbNz00PPfw2SKd?=
 =?us-ascii?Q?8M17zx0xVbWgjyn19jGLeUTMiXYli2A8GcGdRQJ0MHAQ2B6tQYRP4diMBMcI?=
 =?us-ascii?Q?BJIDmqOB3rCbsHySt4ajMZcrQX4eUfD/SY1En/VZAKZBKSliz4h6Jha67X0A?=
 =?us-ascii?Q?xe+c4GSNSLJ5NdQOdCSt/vi0+J1F1k0/XRd2G6mMv4VasX6Xp7+QPtnj0jLw?=
 =?us-ascii?Q?XTei0bmdvkurXL3g8g5qFXK/EcsYczaNO4Wa3gBIMs5mGPF//WMM6fd79pa8?=
 =?us-ascii?Q?wPDgMnGvhbxW6NZMfWARFDT8Fn4+zu98LQhWWCkGQ4v6WeA+ZK0P56IFws+j?=
 =?us-ascii?Q?JXVe/OcqHHzKqK8KYUjJW9U+D1fcSuXAkNnk5R8OP/FvXxlhtPvxnXUCyDC6?=
 =?us-ascii?Q?4H5SDEsib052vWlhu5/cm+4ORqqPrHK2BjdHCGDjHjj/62VpR3zZhpcFgKhi?=
 =?us-ascii?Q?zQtlZE3K8ExyWCTPxcBTgPDAX9KUBxpEJAfCISbIdLipjc4if3Uff4Sqq/Cf?=
 =?us-ascii?Q?p/V+Tog2AHAF3lYtyfHYrU1iqTyqR2apJAXjZOjmbD4MDvHHK5um5nyliWgQ?=
 =?us-ascii?Q?qAos4TL0VVDU86goWs4NEdGabdPs/qMvrF42zXbCIImu1XYrKcx7O0yTnXJ6?=
 =?us-ascii?Q?Bj7Dvt/TajzUYcMNggYVYNYFGRSZaLgyup98+GGBUlBonuyjTgZXvx9zJwwr?=
 =?us-ascii?Q?GBSXDkAEXFoaSgXzZpT3srjhnAYzBwXjKtmJmlrD7MEv1CDzPIRsPt4nFEXS?=
 =?us-ascii?Q?5JpByyI7UfzMR9BHp16ZHGFqbHjlvFwAddsAI0fNCv5gArjrovPSgDWkRr+H?=
 =?us-ascii?Q?VxDnvTqdqWULxKR5w+6SqSkxbqX64JlpJHqZuarQCS1tZsYsixeu1mgZn4m3?=
 =?us-ascii?Q?qyqRHZQp8dIzGhh92SuLjD0Yvp8oAFsR6dYvd3P1D4d/NLzfkRZ/+sM3S9P1?=
 =?us-ascii?Q?A3Xta5shAzxidWTusKLnWstCe784wr7ao6UFG4se2YrK9jPyJt2XqhnZ1fY+?=
 =?us-ascii?Q?6gemTFcGlZN7Et7aVmRB8u3nRX+4U2vuo6I3c4JZbsuVyCj3zOYXn+DMADHE?=
 =?us-ascii?Q?gIHLYZQQesWrYATtjgN7vTWDjOBKMNsuZPqYw60RZXhrXZxmUEW827v74a+8?=
 =?us-ascii?Q?AGYaJJgL5uLhm/wDImYljgoql7gDuCXfS6qyeeaTZ98h5podp+j/DCPRK6yt?=
 =?us-ascii?Q?aFpTPvnM7Xzy6fVzPNC5UZGXRRXIqMQUaUDu1YD6C5z/eVHsYzG8dVd7dldA?=
 =?us-ascii?Q?Qo8Lebt9Ijoeklpz6puP+MgXOs3gjlCCwPgHhsDVQJq7zWGjairGf9q5Cvlm?=
 =?us-ascii?Q?LP6YIMZ1SfCCv1xd9Cb6ZxONkIDi3MCfkZYpoML9TjsRVUVLxGzAkrNKcS0Y?=
 =?us-ascii?Q?2A5SJTDLjFps+OMHNakrV6w+xRofbWCzX7YaJhuoVefCnyRSUot9OUkI7SAu?=
 =?us-ascii?Q?AdJm/uKUZrIZhsp4LpCeIcvCReNQ6OFW3pGD6WXJdJ9v8mdO9KnRwEBsbV7b?=
 =?us-ascii?Q?bwkuh3IDLlBTvmeVcIQsVH4NQWAMbDmda6bmC+NtO3b5C8qArSHR4rshJVQT?=
 =?us-ascii?Q?6sQLrBd0agMa9vUu5yYx9eZABg/3/MTTZ2AR8e+rpmGzMXhV6M4PaKKdK6TK?=
 =?us-ascii?Q?N/pumd4vQTqHGI51aDPzm2ufWKse7vUwB1dsavB9+ptttqGe2Z50rOxp1ztH?=
 =?us-ascii?Q?5TyGkg8YMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a1809d-00ae-4a74-b7c6-08df365eed13
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:22:24.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LToIVT5h3r6OoLfrffXRvfGdRTW5ayYPXhP+Kp+xEqiOfeHubzfSpB3IskDJjyECw6+TvDxgJIaju/5CqCkvWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660

On Thu, Oct 29, 2026 at 02:56:56PM +0800, Srirangan Madhavan wrote:
> Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
> binding, so reset can restore it without a bound CXL driver.
> 
> Limit caching to devices that advertise CXL.cache, CXL.mem, CXL Reset,
> and Reset Memory Clear. Save their HDM register location, decoder
> settings, and Device DVSEC state.
> Validate capability reads and decoder counts, and restore PCI_COMMAND
> after temporary MMIO access, reporting restoration failures. Protect cache
> publication and updates with the DPA lock.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> 
> ---
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b12baa1105f33cc1a10f9c9c0c6376194397d9f3
> ---
>  MAINTAINERS                   |   1 +
>  drivers/cxl/core/hdm_regs.c   |  96 +++++++++++++++
>  drivers/cxl/core/hdm_state.c  |  64 +++++++++-
>  drivers/cxl/core/pci.c        |  22 ++--
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/bus.c             |   1 +
>  drivers/pci/cxl.c             | 221 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h             |   8 ++
>  drivers/pci/probe.c           |   1 +
>  include/cxl/hdm.h             |  12 ++
>  include/uapi/linux/pci_regs.h |   2 +
>  11 files changed, 418 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/pci/cxl.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2414447892c..b874340b0265 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6572,6 +6572,7 @@ S:	Maintained
>  F:	Documentation/driver-api/cxl
>  F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
>  F:	drivers/cxl/
> +F:	drivers/pci/cxl.c
>  F:	include/cxl/
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> index 684a17e9a601..9409beb26478 100644
> --- a/drivers/cxl/core/hdm_regs.c
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> @@ -190,3 +191,98 @@ int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
>  	return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");
> +
> +/**
> + * cxl_hdm_decoder_count_mapped() - read the decoder count of a mapped block
> + * @dev: device for error reporting
> + * @hdm: mapped HDM decoder capability
> + * @size: size of the mapping
> + *
> + * Return: the decoder count, or a negative errno if the count is reserved or
> + * the mapping cannot hold every decoder.
> + */
> +int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
> +				 resource_size_t size)
> +{
> +	int count;
> +
> +	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (count < 0)
> +		return count;
> +
> +	/* The last decoder's target-list high register must fit in the mapping. */
> +	if (CXL_HDM_DECODER0_TL_HIGH(count - 1) + sizeof(u32) > size) {
> +		dev_err(dev, "CXL HDM decoder count exceeds mapped register block\n");
> +		return -ENXIO;
> +	}
> +
> +	return count;
> +}
> +
> +/* Read one endpoint decoder; a disabled decoder keeps only its id. */
> +static int cxl_hdm_read_decoder_settings(struct device *dev,
> +					 struct cxl_endpoint_decoder_settings *settings,
> +					 void __iomem *hdm, int id)
> +{
> +	u64 lo, hi;
> +	u32 ctrl;
> +	int rc;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	rc = cxl_hdm_read_decoder(&settings->config, hdm, id, ctrl);
> +	if (rc) {
> +		dev_err(dev,
> +			"CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +
> +	if (!(settings->config.flags & CXL_DECODER_F_ENABLE))
> +		*settings = (struct cxl_endpoint_decoder_settings) {
> +			.config.id = id,
> +		};
> +	else {
> +		lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +		hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +		settings->skip = (hi << 32) | lo;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_hdm_read_state() - read endpoint HDM decoder state
> + * @dev: device for error messages
> + * @hdm: mapped HDM decoder capability
> + * @info: state to fill; @info->decoder_count must be set
> + *
> + * Return: 0 on success, or a negative errno if a decoder holds an invalid
> + * configuration or the decoder count changed while reading.
> + */
> +int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
> +		       struct cxl_hdm_info *info)
> +{
> +	int count;
> +	int rc;
> +
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_hdm_read_decoder_settings(dev, &info->settings[i],
> +						    hdm, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/*
> +	 * A changed decoder count means the snapshot no longer describes the
> +	 * complete hardware state. Reject it rather than publish a partial cache.
> +	 */
> +	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (count != info->decoder_count) {
> +		dev_err(dev, "CXL HDM decoder count changed from %d to %d\n",
> +			info->decoder_count, count);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index d4c2be1ef833..1140006de50d 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -1,21 +1,45 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/cleanup.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/pci.h>
>  #include <linux/rwsem.h>
> +#include <linux/slab.h>
>  
>  #include <cxl/hdm.h>
> -
>  #include "cxl.h"
>  #include "core.h"
>  
> +/*
> + * CXL state that must stay available while no CXL driver is bound: the CXL
> + * locks and the per-device HDM cache filled during PCI enumeration.
> + */
>  struct cxl_rwsem cxl_rwsem = {
>  	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
>  	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
>  };
>  EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
>  
> +/* A published cache is usable only if its HDM register block was mapped. */
> +bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot)
> +{
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +
> +	return *slot && (*slot)->hdm_size;
> +}
> +
> +void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
> +{
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (!pdev->hdm)
> +		return;
> +
> +	pdev->hdm->dvsec_ctrl = ctrl;
> +	pdev->hdm->dvsec_ctrl_valid = true;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_set_dvsec_ctrl, "cxl_core");
> +
>  void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
>  				   struct cxl_endpoint_decoder *cxled)
>  {
> @@ -70,3 +94,41 @@ int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
>  	return 0;
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
> +
> +/**
> + * cxl_hdm_cache_publish() - publish HDM state read during enumeration
> + * @slot: cache pointer owned by the device, for example &pci_dev->hdm
> + * @info: state to publish
> + *
> + * Ownership of @info passes to @slot, or @info is freed if another caller
> + * published first.
> + */
> +void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
> +			   struct cxl_hdm_info *info)
> +{
> +	struct cxl_hdm_info *new __free(kfree) = info;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	/* Another initializer may have published while we read MMIO. */
> +	if (!*slot)
> +		*slot = no_free_ptr(new);
> +}
> +
> +/**
> + * cxl_hdm_cache_release() - unpublish and free cached HDM state
> + * @slot: cache pointer owned by the device
> + *
> + * Take the DPA write lock to exclude readers while clearing @slot, then
> + * free the unpublished cache after releasing the lock.
> + */
> +void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		info = *slot;
> +		/* Unpublish before freeing so readers cannot see stale state. */
> +		*slot = NULL;
> +	}
> +	kfree(info);
> +}
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e2034a2179b4..44fa9d5d1a05 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -209,22 +209,24 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	u16 ctrl;
> -	int rc;
> +	int rc, ret = 1;
>  
>  	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> -	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
> -		return 1;
> -	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
> -	ctrl |= val;
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) != val) {
> +		ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
> +		ctrl |= val;
>  
> -	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
> -	if (rc)
> -		return pcibios_err_to_errno(rc);
> +		rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		ret = 0;
> +	}
>  
> -	return 0;
> +	cxl_hdm_cache_set_dvsec_ctrl(pdev, ctrl);
> +	return ret;
>  }

Hmmm this change the old behavior that when "ctrl & PCI_DVSEC_CXL_MEM_ENABLE == val",
just return 1, it does cxl_hdm_cache_set_dvsec_ctrl() now, I wonder the reason ?

Update software snapshot for the new design ?



>  
>  static void clear_mem_enable(void *cxlds)
> @@ -314,7 +316,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  	 * capable, there is no point in continuing to enable CXL.mem.
>  	 */
>  	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
> -	if (!hdm_count || hdm_count > 2)
> +	if (!cxl_dvsec_hdm_count_valid(hdm_count))
>  		return -EINVAL;
>  
>  	/*
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 41ebc3b9a518..7a5d9f7297e9 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_CXL_RESET)		+= cxl.o
>  obj-$(CONFIG_PCI_IDE)		+= ide.o
>  obj-$(CONFIG_PCI_TSM)		+= tsm.o
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3..aad567fb7c56 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -359,6 +359,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	/* Save config space for error recoverability */
>  	pci_save_state(dev);
> +	pci_cxl_hdm_cache_init(dev);
>  
>  	/*
>  	 * Enable runtime PM, which potentially allows the device to
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> new file mode 100644
> index 000000000000..b992f71d964a
> --- /dev/null
> +++ b/drivers/pci/cxl.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +/*
> + * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
> + * memory device at enumeration, so it can be restored after a reset without
> + * a CXL driver. HDM register formats and programming live in drivers/cxl.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxl/hdm.h>
> +#include <cxl/pci.h>
> +
> +#include "pci.h"
> +
> +/* Find the CXL Device DVSEC and read its capability register. */
> +static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
> +{
> +	int rc;
> +
> +	*dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					   PCI_DVSEC_CXL_DEVICE);
> +	if (!*dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, *dvsec + PCI_DVSEC_CXL_CAP, cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(*cap))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static bool cxl_pci_bar_assigned(struct pci_dev *pdev, int bar)
> +{
> +	struct resource *res = &pdev->resource[bar];
> +
> +	return pci_resource_len(pdev, bar) &&
> +	       !(res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) &&
> +	       resource_type(res) == IORESOURCE_MEM && res->start && res->end;
> +}
> +
> +static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
> +					  struct cxl_register_map *map,
> +					  resource_size_t *hdm_offset,
> +					  int *decoder_count)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	/* cxl_setup_regs() populates hdm_map, including its valid bit. */
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return ERR_PTR(rc);
> +	if (!hdm_map->valid)
> +		return ERR_PTR(-ENODEV);
> +	if (hdm_map->offset > map->max_size ||
> +	    hdm_map->size > map->max_size - hdm_map->offset)
> +		return ERR_PTR(-ENXIO);
> +	if (check_add_overflow(map->bar_offset,
> +			       (resource_size_t)hdm_map->offset, hdm_offset))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
> +	if (!hdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*decoder_count = cxl_hdm_decoder_count_mapped(&pdev->dev, hdm,
> +					      hdm_map->size);
> +	if (*decoder_count < 0) {
> +		iounmap(hdm);
> +		return ERR_PTR(*decoder_count);
> +	}
> +
> +	return hdm;
> +}
> +
> +static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						    struct cxl_register_map *map,
> +						    int dvsec)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	struct cxl_hdm_info *info;
> +	resource_size_t hdm_offset;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	u16 dvsec_ctrl;
> +	int rc;
> +
> +	hdm = cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
> +	if (IS_ERR(hdm))
> +		return ERR_CAST(hdm);
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				  &dvsec_ctrl);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		goto out_unmap;
> +	}
> +
> +	info = kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
> +	if (!info) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->hdm_bar = map->bar;
> +	info->hdm_offset = hdm_offset;
> +	info->hdm_size = hdm_map->size;
> +	info->dvsec = dvsec;
> +	info->dvsec_ctrl = dvsec_ctrl;
> +	info->dvsec_ctrl_valid = true;
> +
> +	rc = cxl_hdm_read_state(&pdev->dev, hdm, info);
> +	if (rc)
> +		goto out_free;
> +
> +	iounmap(hdm);
> +	return info;
> +
> +out_free:
> +	kfree(info);
> +out_unmap:
> +	iounmap(hdm);
> +	return ERR_PTR(rc);
> +}
> +
> +static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						  struct cxl_register_map *map,
> +						  int dvsec)
> +{
> +	struct cxl_hdm_info *info;
> +	u16 command;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	if (!(command & PCI_COMMAND_MEMORY)) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return ERR_PTR(pcibios_err_to_errno(rc));
> +	}
> +
> +	info = __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +	if (!(command & PCI_COMMAND_MEMORY)) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		if (rc)
> +			pci_err(pdev,
> +				"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +				pcibios_err_to_errno(rc));
> +	}
> +	return info;
> +}
> +
> +static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { };
> +	struct cxl_hdm_info *read_info;
> +	u16 dvsec, cap;
> +	int rc;
> +
> +	guard(pci_dev)(pdev);
> +
> +	/* Avoid duplicate MMIO reads when the cache is already present. */
> +	if (cxl_hdm_cache_present(&pdev->hdm))
> +		return 0;
> +
> +	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	if (rc == -ENOTTY)
> +		return 0;
> +	if (rc)
> +		return rc;
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE) ||
> +	    !cxl_dvsec_hdm_count_valid(FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap)))
> +		return 0;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS ||
> +	    !cxl_pci_bar_assigned(pdev, map.bar))
> +		return -ENODEV;
> +
> +	read_info = cxl_pci_hdm_read_info(pdev, &map, dvsec);
> +	if (IS_ERR(read_info))
> +		return PTR_ERR(read_info);
> +
> +	/* Another initializer may have published while we read MMIO. */
> +	cxl_hdm_cache_publish(&pdev->hdm, read_info);
> +
> +	return 0;
> +}
> +
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_cache_init(pdev);
> +	if (rc)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}
> +
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
> +{
> +	cxl_hdm_cache_release(&pdev->hdm);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..9e218f236e66 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -730,6 +730,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
>  
> +#ifdef CONFIG_CXL_RESET
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
> +#else
> +static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
> +static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
> +#endif
> +
>  #ifdef CONFIG_PCI_NPEM
>  void pci_npem_create(struct pci_dev *dev);
>  void pci_npem_remove(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5af..cb52357344ed 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2484,6 +2484,7 @@ static void pci_release_dev(struct device *dev)
>  	struct pci_dev *pci_dev;
>  
>  	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_cache_release(pci_dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index 06e9aa4479c2..cfb55b10f8ac 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -26,6 +26,7 @@ struct cxl_endpoint_decoder_settings {
>   * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
>   * @hdm_size: size of the HDM decoder register block
>   * @global_ctrl: HDM decoder global control register
> + * @dvsec: config space offset of the CXL Device DVSEC
>   * @dvsec_ctrl: CXL DVSEC control register
>   * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
>   * @settings: per-endpoint-decoder programming state
> @@ -39,13 +40,24 @@ struct cxl_hdm_info {
>  	resource_size_t hdm_offset;
>  	resource_size_t hdm_size;
>  	u32 global_ctrl;
> +	u16 dvsec;
>  	u16 dvsec_ctrl;
>  	bool dvsec_ctrl_valid;
>  	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
>  };
> +struct device;
>  
> +int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
> +				 resource_size_t size);
> +int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
> +		       struct cxl_hdm_info *info);
> +bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot);
> +void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl);
>  void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
>  				   struct cxl_endpoint_decoder *cxled);
>  int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
> +void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
> +			   struct cxl_hdm_info *info);
> +void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
>  
>  #endif /* __CXL_HDM_H__ */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index facaa324bd86..ca3e77b72d87 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,6 +1352,8 @@
>  #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
> -- 
> 2.43.0
> 
