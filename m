Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021136.outbound.protection.outlook.com [40.107.74.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3F38756F;
	Thu, 26 Feb 2026 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076268; cv=fail; b=t47waKXXYgCEXI8QppVAusFwy6B57UEEDpZMa5cXBnpWXpcz+bNj/RFihXUn5XqZhvgttaFnJ+8JoJIMwAMG2BTAopiClOwmKODRa2/Q6JgEWFNu+io32fMF8ZQ73QV6oNnBSqBBAMJNOPR9J8JAUR9TpL6aTTukQaOUCzIKzBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076268; c=relaxed/simple;
	bh=etlNU5Rdhcb0pg0xGhhuRv/+pxV0v0cFYrNPyz8VSos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jTMX1wBCKZ8HtmjFeGGsbCGPNq5Lx8qomrS6PYPRG6mrulYOAGrYha+4wv58iCy6/wbH8DMC0sBFMJV6kafwfwK/YLg1tW1NqZokV9SkkklBQBNBcMtUFe+IS+oCgOtPHJU3ARuPdcYYaqyxQzpfoMRv6a8BbqR+ttkniOexBVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VJ8LMxwz; arc=fail smtp.client-ip=40.107.74.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VJ8LMxwz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+MlfV4EcFO2jjEeF+pNHnaD0db6X8IhBKppD3DLtetXDKiY6V2ZmHSMwZGbGfO3f485jdSazE666w26xUheTyr5e0YBShqaALb/Zh6s58AxYEfPAO96MbtyEIK7k5ofoAfjgaXturveeFnNyP2feYMxiipf/QR0UPdp4ZCrLnYJPmITzh1pmblINButkWae0QOd63w5fVk7ckqATtoHjyKJYfLYEDQ9evjLl7gc04/I8nKdT6EjUjCqM0Y6MbSHwQhD3fh9TuxwxsSlNyxB37hvtz+T6LR2+xIf//xOHSmmf2Qlo9WFjciAgX6eNZoLJWRCf6Ns+Fltr+TTARvA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bgmkc5sVO8sP/ePz7Iab+rGlCzpZeUvQZRKdHFXdbQ=;
 b=ZTjngvgiluudV4CvPVzJiMeBAVIGBvbWC18NxPQ5hPw8pwemHq+XZJ9mT6fyUoxz6KcbEVdz5rwR81fjfZVpFBmyaQJ0aYMbqYONFT8iQGK6oHgGg7mss69hDwOn9ANR5N4gJQ6lD0+z9Jiwj6t3oF+Xbai/sT5KznlSrSLuHuXgPf1jN0BjNZjQ6e1snSAfwjBgStQ9d+3BNzZ4tZ4OupElhpwW9PSBCNnxCgRmdiJdKf7wVzUQBg3+klVVyztvk3LMW3Xh7B3IyhO0JbUxViIXBQK6WERCe9LtZv+4Rw2WRtYou9srZ9248jyp15AJq1UKomIvBQtPgEsmzwxWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bgmkc5sVO8sP/ePz7Iab+rGlCzpZeUvQZRKdHFXdbQ=;
 b=VJ8LMxwzU5WzXvCeUfdHCuCoA1EJ0aaAo6oqk2PMc2vjyVcURRlBKPUiPkJJXTuAKoNV/JkkR7hbyhnMTYwKhHGrOOntsI+cKzEutrF2QfJn3dbB0/yV0XfYG8PhwxXcKArDKIINbIddso0FkaYIvdn4FWebw90CkdWhXr5NgS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2934.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:315::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 03:24:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 03:24:23 +0000
Date: Thu, 26 Feb 2026 12:24:22 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Frank.Li@nxp.com, kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org, 
	allenbh@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] NTB: epf: Make db_valid_mask cover only real
 doorbell bits
Message-ID: <hq5xcvzexffswicrernibubvqa34y2cnoeswuuptgbusxu7hqp@mu5dzsmp3qp3>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-8-den@valinux.co.jp>
 <8ff7a843-bc0d-4ee0-b1d4-94d31e071fcd@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff7a843-bc0d-4ee0-b1d4-94d31e071fcd@intel.com>
X-ClientProxiedBy: TY1PR01CA0194.jpnprd01.prod.outlook.com (2603:1096:403::24)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2934:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a60082-d580-4f1d-36fa-08de74e689d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	/70rxR1SkThBeTj3+elq1nWr/+mx9cutJGhZpZUzXSx53zvdO2sYpSMfsHGtE2JgxvEWr7zqV5IhDQAvcK+NOh5XwYjpQSvzZ8mPmfDgy5zEYqjLx6osETW8JH8xiZHqpCmm7eyyDiC4MhEBuqQYDZ7zFxP7GA+QwQlJVXamVdkgr01jBPqObt/lEki5L0RN+1c4AFz+zkUR0zzmb8EQGRh4dtvrHnC8E9tGoqHrWbRrozKlX83+pHje3hHs7ndGGinx8gTzqYWv7PNcNfO/mSU619KZhrajia7SiQVKwUm6El2jo8l6uTrZTNTyuNRxL4Ub0cUHk2IXul/HPX0hDIIXhFHbGsMF8bcJMaCszF8YxT9c83LREbdvQdeJG3A1SEr5lxuyTmcF/KOuos+A3/JoQb6rccve1Sg52HFUqvVil/ejF0Wm+WSLvaCspHF+akwvkGRq5zALgPadtMMD+OIUbcBz8qEw9q96HLwJKgzG+Meh0btx27/VtEC/CcVn8LKlMRujT+blasGi3EyMoMbcbu17z5Pa1fbqU6sMwTBBoh4/SPQj0D05Yr8JyybxFhLCs3PMh1cy1DCEKeudPsRq/bS/jqUYMrm8ooCtyWov2ct1Wj2U/EuEwd2IEfsghGrN3wZaCCin0cUNd0G9cF8BmCZjp19CBh0kHS/uGtMonnnhXQIxoqDK/5Pq7kuiLtdoRyPkUKFt673HpiIeTcCd6m/crGSTXLJ018mx8Y8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZthCekfCn1cwEvVbY2Q3c+lXAVduULThYfAyWMt6FX+MWhy/29PJjk2NyS27?=
 =?us-ascii?Q?nlCFZWquIaKAF4Y9VaWep+TyIFSuFtyIe8GF/Qar7IWO6wzYjxwr+lTa0IOW?=
 =?us-ascii?Q?qYCE8YuesHFXehTk3XDMT5lPWBFa5kIYdAIjwFy3qEYDSOfjwc39cte0VqlC?=
 =?us-ascii?Q?FQPtjZCLyx5gm2WqYSpHwn/7O467fEdRxULvfzHQq13nI2ZIHKylBKVUU9f5?=
 =?us-ascii?Q?d85eZiMVZNPp84g7Ug/9IjdAVwiRDnewwS0dk5mJDg8epCLVLojsx9qKnYS7?=
 =?us-ascii?Q?RHNJAk6Qt6mlWaQmMbpDwJ31LNtRitAa6z2wX+ZD1ZcbmHVygOtaNHHrApaV?=
 =?us-ascii?Q?LaOCUYZcu0fnMbBEJ3qXXOlqAqJIZ0cHuuALahEZ8Y8EbPPQrNs6RR5h2jj+?=
 =?us-ascii?Q?LfyF7wUwcUtQIfM5z/LTA+SkVrW4auxFEG6MuTt3aHsoWB19/oX8MqXOC8l6?=
 =?us-ascii?Q?L6ChnUgziD1jQb/2I8dlHwyGK6Dc3MFh0OGHob6elYo+5xm5CHhXnMKDClvi?=
 =?us-ascii?Q?k11AhiyUGjYnS/ENgrc783n3skUft01CvuyLlFZu2U1Wa9/Aev6ia+BWhUZU?=
 =?us-ascii?Q?QRGRvGvHwNZzVwTF9TnwgQ1r6jNutkx1ElSX23h654xWzgB+zSmmIXC3P8Fw?=
 =?us-ascii?Q?1Wi64BLz9Z5+QaqT9t3ggk6A7WbhGVZPHHOHq71FINiI8fYYpcbJi2FXl8IQ?=
 =?us-ascii?Q?g5ZZqpA5qL0Wd+m9AkRJMyHnKOhQwAFDgMATRCnaWxBuP6o+PCyRLqYymnvk?=
 =?us-ascii?Q?cWUeLhwcBSIDtaS5bnyc2nrcYePHOT8z90G5/bkmnNC36o1K5pYb7u2o1xBf?=
 =?us-ascii?Q?joEEMPSm6zkDXnkcVoK1HTJECrYJ29ZvMWuZ68RiK63z9unPKGxb9GFXN3uD?=
 =?us-ascii?Q?ve8F3Fb2Ggtv4CPYHl7J7IQ267iAulAR35DYiOYam1lk5nsF1nfHrwI4rf1A?=
 =?us-ascii?Q?JhJUPdntXlxZcJCTS+XKIKYCm/kkOZbcF7BOKHZ2zXmrcjZ+ixM8kl6L+8VS?=
 =?us-ascii?Q?Fir7DuoDzBHn7yDgOUYP1iERxzA8stJq0ZY3hl0J72xm8yi/h1tTD6+wMy+S?=
 =?us-ascii?Q?yxXpLt+H3yBMPqFN/XpqJ5HpDnhYbqoaxejKdemW4eL4jfESX2idxb8Y9xFv?=
 =?us-ascii?Q?M0fm3rS1vgyrhBb/whaQq7VMhBHsJoqqRnmbYepZlrnwiaxjdAXf8bPWDNUv?=
 =?us-ascii?Q?o3GU2+bWcJyId0P5YAG3vlB0/tZAdhp8Ecy49qD/IPwn/GFfkKgp2UhwyDtA?=
 =?us-ascii?Q?oU8ePoZ8c+zVY365ZnQWXxxnKtuNPeluAtD9/aKXOLSQGPprj02HFz6xrvO1?=
 =?us-ascii?Q?uJT0CgnxJNp9okDtR5mqlxnqkmdRrv1ZXt65E1Sq8ymUSwq5xnkcCYVdQfvN?=
 =?us-ascii?Q?g+yOILD6l6/hRdOV/6hen9yMm72Tvwga1pLkhWvJXJUu6kf5MZJfeptUIo7+?=
 =?us-ascii?Q?2js3mSwQK9k48sXn/J2uA2Pgj2gq7i67IoKrywcot35fku9mQUk5zJdFpnDs?=
 =?us-ascii?Q?NlCZfJN9dpWt2UUn7ZO8TDsx9WYTVDCJxzycz4KNYdis1ywG4T+dzJyROXow?=
 =?us-ascii?Q?3n1waUFKkASI2rVF5QqIvjpTQdb3wDVwgoKLBrKSG/anOZ8qsrGET68Sy5uW?=
 =?us-ascii?Q?/hpY80jQ8fUK0usSY/P673LPMXtB31KyRuembEzObwRFcB/YnBBtmhIX+KZy?=
 =?us-ascii?Q?qr49UYp1OTIatdOI76Q2pEwseYwZ4uIeNLn51DamUjysaTA/b/+O8iKyBPE9?=
 =?us-ascii?Q?fh4zlR0W4f7FQVr1hEwSFUFJS6rkdKnYGdHV2MyoO0vvd5UsnuJS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a60082-d580-4f1d-36fa-08de74e689d0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:24:23.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb9KSZKBGEOZXV36dH8Qw5M2FjWTaZ4NkdcKjx/e0UdTqqHcESC3nJx9b113lwDGBz2amIhCPm18rCMCjawiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2934

On Wed, Feb 25, 2026 at 09:47:43AM -0700, Dave Jiang wrote:
> 
> 
> On 2/24/26 6:34 AM, Koichiro Den wrote:
> > ndev->db_count includes an unused doorbell slot due to the legacy extra
> > offset in the peer doorbell path. db_valid_mask must cover only the real
> > doorbell bits and exclude the unused slot.
> > 
> > Set db_valid_mask to BIT_ULL(db_count - 1) - 1.
> > 
> > Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index bce7130fec39..ee499eaed4f3 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -580,7 +580,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> >  		return ret;
> >  	}
> >  
> > -	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> > +	if (ndev->db_count < NTB_EPF_MIN_DB_COUNT) {
> > +		dev_err(dev, "db_count %u is less than %u\n", ndev->db_count,
> > +			NTB_EPF_MIN_DB_COUNT);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
> 
> I would suggest adding a comment in the code for why this is for future readers.

Will do in v2. Thanks for the suggestion.

Koichiro

> 
> DJ
> 
> >  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
> >  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> >  
> 
