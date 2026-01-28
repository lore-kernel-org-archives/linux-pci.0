Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539B2874FE;
	Wed, 28 Jan 2026 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769577692; cv=fail; b=LxtW2gr1Y0a/wgyoHS8cuTHVbBINUJlf3iOgREzJ7X0fNolTG9tGe1FAiFkElHZ5rYVpmh0B/4D6PQiMy7qAw9vDNZ3eZOuhYeRyh5O+5FfXAgbOMEaWbtpkKwkZq/3vyFUBJ/mAf6HXd8W3WyRStAxolb/L0uhuqrlV8Aci9AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769577692; c=relaxed/simple;
	bh=ibIOKZ/zn/tYRtvNjxCOIDfMt71suJT38lnGKU4z3Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RRM+PzapOkio3QF9+275cTt5ufqA+YxhVQhBjQK9kbc0dRBrcfjhtruetnU40r90hRllOCcYgQxmg2XAtEBXfNw9Mz+ct7SPJYMIHzugCb2Vl3KBVI2ypAhTogOXv8mQzRpwY8mbrDVevKJ4dYe7SIpNhWfP5PFtUO4DU3pqMfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iCoU+r4b; arc=fail smtp.client-ip=52.101.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="iCoU+r4b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoaIM/KERiPsf39/JZYjzbXQCVqZP9Rqxuai52LQ5oAdnUP4xe6a7bX4w1XBQyA+xHvI7xDf6EWjLMSLIQwijeV+ijXa99aEsjW0qSykTB9uM0tI/MGuHdFx8ehVqJTSAeKc2wF2KeekmiopLD+9Ev1ank10gk/jENMb5hQHFnGL0/E4Ow1vVuiNG/U3cMx3iHYChAyqM1J3jXgERzNUvmmTunaIw5mC+GbBbY+QuZgCFLomMUwzTNh9634aNosl+gvkCyd9R4bgDwWxH3h6gvIf/iOLy0x6s6syyySE+UEUNwBWWQc8ORrqdpdc+GTWXumE2hKAXUYQvJvSaAsCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8geDrSPJxROhKeF4iC8SnfDprWUZ5GdvhlZZhpW+uQ=;
 b=x5chVNDA3IeDBgarwvxLADrn38ywS2LmmyJCcwPzvdk9wk8yKdQqwJlNPACTrdpCVHQIbc2sr6j+ThUdywVd9+t7drsirXsJbjKMragMP0kd6WmK+NsVkd5FMsrc7+sQkCAzBWlr0KawhSMgo/rCalj0uD/cbUf8BhJ+38zu1hlMCBuG+F8KjJENpon0uLkdTZnI7TangKAUlbj7qUbaTTDwpZm4729WMggxwpNPRCaTwERMPh8mPVUUAgc4pczTHcMZwXlBr5BbnRVk2tI5raYDlR2KZWlIdEa+JkWNqhjoHO3f6giP5hx4HZXd8fDU4WxUXAhzbWQm8K6DemkS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8geDrSPJxROhKeF4iC8SnfDprWUZ5GdvhlZZhpW+uQ=;
 b=iCoU+r4bCDpd3YbHhBd2RJuvJLXfZ9SuoQ6V/OhZw6tYnyBch3QJhbzXN4YU5xCe2oUQuzRi8dCdQ9JAxSauGx1qw5cNtj/k6WJGdL2wt2LVwVkBE/oUUwDxt8F4u3GneKeElrhlNktqIcEAD8l96ko8z5piJmYKdpJjteNruXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7578.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:346::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 05:21:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 05:21:28 +0000
Date: Wed, 28 Jan 2026 14:21:26 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Frank.Li@nxp.com, 
	dlemoal@kernel.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Allow overriding default
 BAR sizes
Message-ID: <w4dzwnip6dhuxgvs4xdgrwsq3drztpdmezfpy2yjqvcxmpdcps@y755eamf54ng>
References: <20260123180747.827357-2-cassel@kernel.org>
 <23lxq2hvynxqmothnkhjtarpklin3prv7tvjlvy3xjnzpn5kdj@ks2qay2tgzc2>
 <aXiJyDUSj68MLQaa@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXiJyDUSj68MLQaa@fedora>
X-ClientProxiedBy: TYCP286CA0189.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a70113-aae5-47c9-c726-08de5e2d169d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mgiTwqxKtfIIfWHZZY/ChxFLYvfqhjbFvZmyLi+UfiAwvtJa8mjBiFDlcm2L?=
 =?us-ascii?Q?Q4wzjxfT4b1udt1rnhNcmssekg5VmhArmu+N9vHS5awAdborPjwCCULML7gT?=
 =?us-ascii?Q?Sc+4ZEz1etbvZjHO/EntuCeLOECGATryZCWFvkzMMec9cAEyEn1VLhggQlBX?=
 =?us-ascii?Q?HVCpUgWyUJvjjy35brUu0yXsg28vrjJ3pAM1ZTzRFZKr2qCUiZSKUnTg260E?=
 =?us-ascii?Q?+JqxJYNBKUGmH/ZpZ4qdekeQWz46SOhS7FbKHd2FekRBloYto/OfqLmsHmtu?=
 =?us-ascii?Q?L1peA+t521pilYJU556KfbPl5qytYXA3LKneo432erkd0Lj3AjAAbfYbylC2?=
 =?us-ascii?Q?y/eEk+yxUqzjjNNRbPvvIfAZv7J1UpSgG0uMmcjbVkft9zTeN92xNiiQ2mdL?=
 =?us-ascii?Q?+VHVdUrTasqtITbNy9XF/3vtkK2aEoHcf7YhHH+4JYBCueAgoZZJ5TFGClWm?=
 =?us-ascii?Q?tWgfucelpbwhON/eOAyqcbsIpcOZimTlfLbLOE5UWc+c/FPu/l69RaJjcm2b?=
 =?us-ascii?Q?U3ujf9dO1PqK9/Jh0qSDV85u2Gj4VIH2uaSabA378UVC3XOQf8kKiXyG4nH+?=
 =?us-ascii?Q?mjJKTMMPuHaC3kSegoRhFNoHHBgSVVhG7ipX30ULfa+rywRiqmyXaITrHJ+P?=
 =?us-ascii?Q?wC4o+Cnjt88PsembBgSjWv1Ei5iFiybdFpeMtYDFpbqFigBaJGrdWpDJbdFW?=
 =?us-ascii?Q?NW7vDRzIceb+OzqWCvc/jP2RgKj3dlkK9ykCzDAaEmAiRk21o/fi5Gv8MeiS?=
 =?us-ascii?Q?uVNg/tN99ipgOgnmO8s/wNimbf7NhioSlNElfRs3E5qgwD5I+AO2rSvUu/9x?=
 =?us-ascii?Q?2z119utVXtbx6/xlyxU012h9ezis5rYtDj+xTbLK2zGe0JsKRZ+P53yYVDbK?=
 =?us-ascii?Q?7NftZeV1y9G+8c5mh0z3timKOjs8GJBhtv7FjYj6cOR6/gdwERV6zU0SOeRL?=
 =?us-ascii?Q?W9yeWsnY5AQKZb8pm/xEa8LbvIfZ9nQtoKfYW3M27TpD58sIhixXnZK9I4CC?=
 =?us-ascii?Q?QEawaz+KkZBoZditr8zcLokGB44ZiTy3g3l8viqGyJIkLE5MNtjEYJPinWY/?=
 =?us-ascii?Q?8nctpFqmcUOualnqW6amibjZpQ6bI9YBK/dKyEHpoGkWKbIAfH13Nehk0QTl?=
 =?us-ascii?Q?X5t0DXdCZpB+3XkCq6A3N65UK4XXCJgTQSllajhd3+HoGaEPqjXcUPn08QK9?=
 =?us-ascii?Q?uo361nqebo+HFIGOn1sIWVKMD/msdPysJu+93UI5K6vsYAmfFD7oah2JA58R?=
 =?us-ascii?Q?eTmzaQ97eLXWfzKK7u1e5k5nZclROOD/xKY22Jecq7hylGNAy99JtKas0MQF?=
 =?us-ascii?Q?YXTDYUowQwXX/JZg0EYpmCudwKYlXrSeGSC1vL8Iel2BFmRk9b7MVhjWiox4?=
 =?us-ascii?Q?JxYfGe4ofcCAmAOat8fcB/lUSjiRxx4QDMgj3rEpaxNU+x6CPjQhhqtSNS3E?=
 =?us-ascii?Q?jFSqGWNcBz4gQqLgCQedlcP1ETkBrhBjZCeEW8Psdpt6WMCLDJawWoN6ZZpP?=
 =?us-ascii?Q?P+lNlz0ixPbuce0QJJVqf6sehl6KCSrpDAoixAA00KOkKyX3+njKMAflEQVr?=
 =?us-ascii?Q?nueOy1ldAh5MgZzDJ9E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OZRNucnbwKrA63OsVzh7IKLblKk95eUsO2Ne3Kz/laaCu3G7XP340cMY8nvX?=
 =?us-ascii?Q?RD6LjYYM2cYhJ5xxdCzhI8wsOhogKRbLdszwQcFLUkTW2ou3GKiqd9uMSA16?=
 =?us-ascii?Q?/0gVqZp8rMYHDK3mFUEibZp+sDQ+duFPethq8EBUwCV5bygJYXvJ0piWQt8g?=
 =?us-ascii?Q?+rvJT+klC+vWtHFjdvSENtIoZmP0G0ausB3xIdgGML9a5grYq8LXDodSsIJQ?=
 =?us-ascii?Q?qX/yKfbp83NngCiYxa5oCeuNRhd1eNDUkNpkd8MdGgneXnVr0BAAFPiKvi1a?=
 =?us-ascii?Q?lhQ873679HEc4HpjGWkXbSULkyLpNZAIcUullYDvb8aeJzqCwmG9OOuh9ehN?=
 =?us-ascii?Q?aqRKI4qA+gTezKpOaZLqRZReG3D7mel+L+kE599xa8hPUK1epiDYEpw5EX3O?=
 =?us-ascii?Q?XbJzux7aekKQyH2gHVp46K6TOBTzXvVOVXsxyVwjbc8eK+m8U2OjkeX2ZTck?=
 =?us-ascii?Q?UDmkGTDI4Wg5ctUy9zZisdDy8FRX8ZOD9HqktUMrxToUR7RxAjF0q9Kwa1fw?=
 =?us-ascii?Q?UkIxKBhf7jTNrJ2Z3Rz0FhS4ZWtGZovVUOXTHARedePqBMZUicsz7DvqibS/?=
 =?us-ascii?Q?C7G+JTvOGxQcbl6WDZ+fwTvOyq79CR4n3nxtTo3E7cyokR/Oh7lNKljINB7z?=
 =?us-ascii?Q?2U8yREhvizWhskOlKlLhCrL2nhFDiN2kQ03//GAH4Pr8DNSd69dwLKn+fhKL?=
 =?us-ascii?Q?pAQdIDzekNzRpXbezpXaNWTyKkmiMJRxEIHEJCIkFAZnEhI4F2AkXTiobB2v?=
 =?us-ascii?Q?7fber9b6SnXR9aKRJTyCTW2GSlJXILWDJmX7Y5gal4d++Ef7prCnK3WYNFZE?=
 =?us-ascii?Q?K4Pt9rVRfdZ0ge+cUIyYhe8InsqnjbOv6Qzez3fYPzdCsbRbrpSx36AnAxeb?=
 =?us-ascii?Q?lJo/cj4g0IKdqecCBF2X13aj+8yHKIgRoiLFw2Qo8jhCpLSYGRtgsqYT2eC5?=
 =?us-ascii?Q?++nsroYz6Wuu0V2hFwDrLmrtsGiZs33sZeP25eLXMVECkG4m/pDSrvz7Rm3l?=
 =?us-ascii?Q?s/zFlT/OOXxHjlW4lshp+QRbNDhkRTWKrMhCc1tAKLzhNg8vxsqsyAicQuyn?=
 =?us-ascii?Q?6BQESUasFfwB8Mq7TjesTEdGrDgpDLBNtfOAiSYIY8SFAqrbTvKB3Dpg9CqK?=
 =?us-ascii?Q?LVbs1jLplqMNMe/PovrtrODiaGW0zJ75MgUOisD9iDG4G+vYnS6eaG5Kzaig?=
 =?us-ascii?Q?u5wkx0DcFRI5Y4rMb52s8oTnE72tbfuHZLN66TBRtfX+f2TTszxStgp+PhdU?=
 =?us-ascii?Q?TEkw3FmUdJjquYjYyUKFa0O0+HjR51xRsmsOOMHNjVA1cQWTp0tRk2aho4ur?=
 =?us-ascii?Q?H04lkbN53pcrQCXZuDHc5Vj2Yl6gW/gJ195HaHVfXsMPtmx5osnvSFGKjewN?=
 =?us-ascii?Q?OkUe4uhVPWGfZEyI7Qy2OBAD948CVcIffo3DrqvVhHQ4ATwCjf7L9MoFcTaZ?=
 =?us-ascii?Q?Y31KtlnBFrRjYaE1/mxcrewIyL3HXsZDnTbPNdRzhtIWaq9GZIE6xpIlJOWW?=
 =?us-ascii?Q?eD8Qy+wQ7O+PfQo8GdPX6Ny10Y2P32riMKVL7zPDKK8CRQzxGIfp185v0Wao?=
 =?us-ascii?Q?Neq9LEBUWbelM2zq7JmM/pSV9fEXAUGhQBKggysd7BzSF+hK715qezLbBo6j?=
 =?us-ascii?Q?E5Gvk4RG29FfU8THvDq2yW9s9JzlsxN326DwP2N+yq5Dof2Qo+hVcIkX5RaR?=
 =?us-ascii?Q?1r8Z3isjhtH5hHy982dwKNnXXQDtbqP0Q0m7fPw7qb2ecQ6Z9rbmQHW858bM?=
 =?us-ascii?Q?4FkhatV3YG5HvLOUN2Iv6PC4j3AC60vKQcrrbwARm1H3LWSDmWNQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a70113-aae5-47c9-c726-08de5e2d169d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 05:21:27.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhr3N13UxbG8MHikBeKZYtci+jH/rx3LIkxPskTNr02UHoagBUJxQ7wPrGqRVhI70uWjYCMzy4wi8F4fEl3pbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7578

On Tue, Jan 27, 2026 at 10:47:52AM +0100, Niklas Cassel wrote:
> On Tue, Jan 27, 2026 at 12:44:13PM +0900, Koichiro Den wrote:
> > On Fri, Jan 23, 2026 at 07:07:48PM +0100, Niklas Cassel wrote:
> > > Add bar{0,1,2,3,4,5}_size attributes in configfs, so that the user is not
> > > restricted to run pci-epf-test with the hardcoded BAR size values defined
> > > in pci-epf-test.c.
> > > 
> > > This code is shamelessly more or less copy pasted from pci-epf-vntb.c
> > > 
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > 
> > This is useful, thanks!
> > I've used this patch as a dependency for my series [1], and it works fine.
> > 
> > Tested-by: Koichiro Den <den@valinux.co.jp>
> > 
> > [1] https://lore.kernel.org/linux-pci/20260124145012.2794108-1-den@valinux.co.jp/
> 
> 
> Thank you for testing!
> 
> Just to clarify:
> Your series is currently not depending on this patch, and neither do I think
> that it should.
> 
> There will be a trivial conflict when PCI maintainers will try to merge them.
> 
> But the solution is to use your new values:
> 
> -static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> +static size_t bar_size[] = { 131072, 131072, 131072, 131072, 131072, 1048576 };
> 
> 
> With my new variable name (default_bar_size):
> 
> -static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> +/* default BAR sizes, can be overridden by the user using configfs */
> +static size_t default_bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> 
> 
> So AFAICT, it should a one line conflict resolution.
> 
> Since it is so trivial, it would be nice if the PCI maintainers could
> handle that when applying, but I guess in worst case, one of us will
> need to respin.

Yes, agreed, it's a trivial one-line conflict.

As for my series [1] v10, patches [6/8]-[8/8] (new test code) haven't
received any review feedback yet, so I suspect there's a good chance I'll
need to respin anyway. If I do a v11, I'll also resolve this conflict as
appropriate at that point. Even if it turns out no respin is needed for the
test code, I'll post v11 if the maitainers asks for resolving the conflict.

Kind regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
