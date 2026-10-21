Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608700;
	b=htRaFS1iHp16KXyXt0pWn1bttoHpULryn0nNDzJ/O7gr6c/qtD+YkMkhVhGwp4pXSXZK
	 k0PEHl4gmzlmy07CxPF2ZAguHhHh23ImFCQ/v2PDs8GMfwIlzWLa7L1hy93aCTrtSibi8
	 q289iI8ooFL+OhACtzIVHHueGnzgk+fKuj08oh2ZACAcHfct+/qrSx053x0LbgwlQSr8Y
	 amYogx9JaAd3PQJKR6byLX7MHexOua1QBpUOf2lJeIqmAgLMLna+QT3E6ZOr0bqj9z+Zf
	 L202YOI2UGtDAKMR3565rKVVZNoQoLZKBx9GHFQrzGGRCd94aygcqgNv13CktsXwghA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608700;
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
	bh=b7hEFsS9thTm00SOzCZMtr3Go/q/Nxsh7VD5l4ETbII=;
	b=SG3p979cZX1fFUp7KV2ir/jv9L1UlKmk7eX4QxdH0pfY/HBKDEs4M/FEH83IEkQj1FD2
	 IEfDCdcbIgV4xDgy0qLISFGglG/UaLvBPmkjt4SNhZ+O36SGF6lL3hIuAO9cEqxvxlXEQ
	 QpKCnFMsl489QRi1+b5QCUjqn/dIc+/TB2c5Th9UzjxpALB/o7grGAgvs5Kma1b0pzV6w
	 A2OFCdynE4a1928H7Ypk0tWveQ7M4jhIvttKlgoyg33cgHKgGKM1JVspCEMK07NuX85I3
	 LWJoc8sOqniGQrvofWTaWEhMLnQTseyLFdULFDzbewFpkJOo4vmxmmV51Ib3d576SXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=U9SoEqug;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.61
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470F606A31F;
	Wed, 21 Oct 2026 18:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C470F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=U9SoEqug
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rqe62rkDutXxsESr3AyXXJ55oOOhJwyUfXy52WJONyz9HaS+ojtkXC+3BVA+RM/VcHcrYSM9aKhTVFJ50SHShKauaJubdhgvNqFrByKUM7taCUaEh6IbCeAwEiYgNP+s+3AF8xxxtTpJUM6o6U++JQ7EeVjis+JtDfBiMI8E2OEA+h0LokhSTqAPxIsa8yZiVXCxi9Kue+SBu/pr5I09+ExxY3cNik2wcsojUi8gMg0So0y13N190yEE4D1wKEklarsuU7DCcXPR30DccZsJQ2XM4DW1OqRbUfjmWlqmn6Iqtjs56tafhHQ+S6Lpeq7TbJHcKzPVc5+4+JHq/AY43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7hEFsS9thTm00SOzCZMtr3Go/q/Nxsh7VD5l4ETbII=;
 b=uB6ChquOkNTcOs1pMgq+0cqcBY0yoqNpH3ijY+CQWNMciS5GDYGXQVTPYJiSLzRuxD3HoAcMrqKGWEbh9n9JJ6aatTKb7q96iCgK0Y8x6/f2MhGS9At3VgZEurvB3cgjlqczZ02KEWa/a90rUARYYbNzLQyi+30225JIPed0olb+IWSnZYVkYRSy1hrOyL7dqEnhv9bYMOH4PstVZpCDwMYcMj+AqikuEuEljlKm1Ok58DxpVIjw5XJQaioL1UPIRM043C3W3MJBi4P6fMIHlgxJcf7V4Y2kBQGfyBCJfsTK0y+KzDo7aYnv1TpCYS7YTz8KgkSpa/KbFZhbLwr+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7hEFsS9thTm00SOzCZMtr3Go/q/Nxsh7VD5l4ETbII=;
 b=U9SoEqug4J1cvEqQ6eD1k9Z/4yblO0N5LJHbx+rRyOoy6Lj5qDUxcgVxeLFy7l/xSKKVfdgZ/WrIunr5zKnsgXoOQuc+GQOubsQWu5sQtKsCBV9oyA8lGsPvBz1aecwwMPhId7ZYAtML4CUO9xgOjPIlQ8eqYXCksdnD+/vF6/S45Tef+KiorlaQlP6r1OoNI2UHRG5dRydc9C1GvTTEC0TxYEotc8lOn9OwTmJaYIO3j4ueSq3AJOIbdv3HT5ts6ygd3dbkRuZ9f569tycUD7IxXPJEIUsl3EpSvGwFtKTvEJVVVWBnKwz5UiG5q4Q0ZHoFipqKSdSILSOPoEV6yw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 18:51:33 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 18:51:33 +0000
Date: Wed, 21 Oct 2026 13:51:23 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a
 BAR
Message-ID: <atkJqyI2GZRvWo-m@SMW015318>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-11-den@valinux.co.jp>
 <atjhPo42pjkA8vJK@SMW015318>
 <eg2sbks43lnyvs7i6jtzqkhqkgpjalgynhkwi2c2pkpklrbekv@oiscofavvmxh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eg2sbks43lnyvs7i6jtzqkhqkgpjalgynhkwi2c2pkpklrbekv@oiscofavvmxh>
X-ClientProxiedBy: DS7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::8)
 To MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2f16eb-0d78-47b3-6e66-08df2fa453aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|23010399003|7416014|6133799003|10067099003|22082099003|18002099003|261021121427099003|261021123027099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YM5/ncA/Wck8ikQpFXMMkp3i9nbGRe8HWPXXB2a6HfniLQQyFHDarWdJaCaWgd91qH8grT0SUGPxVQT99+aN2+XmL2DOX3uoCAxa6q3ndrmv+uU+BdxhgkK1xbzBSKfdMrwE20JbNEXGaws3zqrGTF4Dk9/LQh7wbtiIOAId88F6B/J3TYFNBw5VpdcpQkMDEUQD6zqqEY+UljFvyL03MKW22J+U/vtGxzHT1UeWjMljFotEpr/oY1tB6K95RWiM0hkOpPzDDVPFbCHaVyJ24mmVX3NJxhFEcVBy9jXkbT6tkXbgHd1YPKbW2D/HO4imblVJO6J+ClSBWX4LEPusobFFszdM9GrLcEZ6/8m4U65VKZBiasTS7zcdk4KNC2VoIm0O+58dJxuyquKV4MYkrJ/WaEUBibeJUCY+BrbaNFzEI2LKyCP4f6AxaHajbuYsJBva6nsZCUbtK+JwLw9glp6CXNYAJb212OhE4NedcdWhnZskBRZC2HsaUr/YovFJWhiUF3YhsopVMLWG2tsr9nz4Vjxw/LCo9Kq8HIMuGuQsz/7krzbe/HQsUCDxJikpauFGfHKilvjhYtk6/0wcJakj1HAGElBeW0MkD3PtZJ1L3cvDjC9yaMWV/tiT/aswpg+YP/4OHdQV9dHBCI+yQBIqjqT2RD6oJn4H1Wh3YaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(23010399003)(7416014)(6133799003)(10067099003)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CgFw/UHemUs51o9L7TK/WqR/6Dw3bErwiToOBnTD4N4rGFoUHAtGYQAwkk2Z?=
 =?us-ascii?Q?gh7MO4vnN0Wf5a8fCAjgHd9xsBcQe0kAMMoeL20ewipZOUhS2fewfAOegAMI?=
 =?us-ascii?Q?/7Ns75MWnlospkxhYSNkTS3kA3CNgWAXpCxAGEZgQP6h0scQJucsIuvgOfBT?=
 =?us-ascii?Q?CzAQK+PZ6Y3V6QvRHN37Gw15o9B2ZyV5qwN/P5exaco2m4LcjiWDd8NTnhYP?=
 =?us-ascii?Q?mpiFv0ZpvL3mcG5714wKuKmEoe+4NOS1n1WynQ9Oc4fwckNUIkkspMg56Wn1?=
 =?us-ascii?Q?gQRdALJslv0gdE7TVBLNAczrheepbmcsZlsf/E5KmQ5CNXUHh7pt+Ak9kjQN?=
 =?us-ascii?Q?eUfpPmjVyyqnKIiIwMTFandBAb4mPmLM1+VyswAZV0QikIIJlSQK4BvmthkR?=
 =?us-ascii?Q?Iok6yhfOwLG2zb/5M5RUSYT4iqFJ9Xa0Hsd5RD7UoTXzKdVHwkmXL+q0qSDo?=
 =?us-ascii?Q?F71U9iLa45n3bVPVEFD1L2ZvAV0dVNjuz6PCW0VDIqpYbmnbut1Lh8zY5yeO?=
 =?us-ascii?Q?vGAABBH+MNbNdMRXygqdM6wXgMyVPv8mcXLzSwzfZrdc5YSAXiUhi2IAiKaE?=
 =?us-ascii?Q?7KUuTwp/3EujUXWM6OjRrH0d7beVfkRXoMSaZN1/dEE43gWcWYbBwQPHRPj7?=
 =?us-ascii?Q?Y8cuDdOP4yGXX8H/k9zstpgFcO1KtJsMIjJSuOqvZ8vGMa0NFidOTf8qLafQ?=
 =?us-ascii?Q?fTrfFpuy83f59mv7ht9I1lNKqZJeNq0u0Zjd1TvkxKaM4CvxS48EoQo0MXjR?=
 =?us-ascii?Q?MmgvJSAvopvZQgg4115wAiBs+4pRKitjxxgvX+s4w/4Hu1uMc/Z6MU9QUKNG?=
 =?us-ascii?Q?LXcy/mEcgHYPInDxyPsfDM8oMUCafsvurmOTgEHtbG1kko16nfaosLVTJPxF?=
 =?us-ascii?Q?XYoleS88HSjqISP+MPEgJyPBgWWCqJJ5v4nHKerjN3SZ5Cy23wQ5Cv84+Ujn?=
 =?us-ascii?Q?h3zuCWrNExSiuaOo7J5f3uayjRp5Zr/X93Huc9gZtiK/MCtp3vTCqj1gBmRE?=
 =?us-ascii?Q?Tj54lPKHqzw7jGPSFBEDJy0kKdVOTQyq3u3aYn9j7/Sh0coAM7rSq1Yy8WmF?=
 =?us-ascii?Q?vOqWFBNBf8nuQEuVXAZfjzU9uhZ7Z1VWGsARBuH25GvPAqLHYWEFyO2pJ6bT?=
 =?us-ascii?Q?TkGTI9e/wiCErUS+pkBmteuXgfEGVR+mgEXpq9Mm3Wt8HRFf91fo7CmoK7R8?=
 =?us-ascii?Q?6v34gWTp7Bxbz26eVLiEfuNiVBtiGvGFBvim8xX6Wvitn1twT0zZUwftG/St?=
 =?us-ascii?Q?nb1vcoNlG1Sju4gR/U3cw39s2BcIupPEQ3o+y9clibw6rtBb3oMDPwTYfPVU?=
 =?us-ascii?Q?3JpnPcTnzhPCzOUVzlEr2JB5n4V9kgyP8ztS42lOjE9e2gqZ1VW7Ri+befWV?=
 =?us-ascii?Q?O75inApOXLyJbV/L6x+O8IVJkgGwzmRE0Jb8JNAWqeV82olbi7NnPtFSR2od?=
 =?us-ascii?Q?DdEQafpcbWV/f0ToSEdN3jO2JDD41/HAQzGOlBPMSwi0SmOtUHmPQ8altpYi?=
 =?us-ascii?Q?JEYBTz5laSUrqrtCmTQ9/H+T13yxNIcElQBtLrr/9X5fYLTeyf/zxO6LCaWN?=
 =?us-ascii?Q?4yq0lH1U06h7kSGmyhSm5gdtcVZHUas1Gm5K7Sd9EjhzO++6qFwf1yxkjU2J?=
 =?us-ascii?Q?qwkbB8w3H8XzRh1ySGjdLhkyQdIPh86LOR1fA+tTgmUOSSC1oem/Cc/OnKku?=
 =?us-ascii?Q?dkPcv/bnd4IqyvUN13xKAzaUOmnyep4z3POBBtwj4qswViIxabTPAQScF2GM?=
 =?us-ascii?Q?99zX/evRADlkgHO8Fa+ltTTYkui0XwCPA7m9zrDK/w4Wo83qDPDV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2f16eb-0d78-47b3-6e66-08df2fa453aa
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 18:51:33.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03ul7NXnFTDmYrfg3gwd86nOfC62r9bOgY9O5N6F1GlY+dLAaUnxbbv2bAfel/qrjZKU/VbjIS7S0djQS3XAIKsIYuk6Qha8als6qJh/Cj0VX6m4TuRZ4QzT3+u6XVdf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778

On Thu, Oct 22, 2026 at 01:57:29AM +0900, Koichiro Den wrote:
> On Wed, Oct 21, 2026 at 10:58:54AM -0500, Frank Li wrote:
> > On Wed, Oct 21, 2026 at 01:22:29PM +0900, Koichiro Den wrote:
> > > A vNTB endpoint can place DMA resources after an MW in the same BAR.
> > > Limit the MW to the advertised boundary so clients cannot overwrite
> > > those resources.
> > >
> > > Advertise this support in LINK_UP, including when DMA is unavailable.
> > > Older endpoints ignore the argument.
> >
> > if ignore it, any side effect? Does host DMA side use wrong memory region,
> > which actually is not mapped by EP?
>
> None. This only advertises the host's support for MW/DMA BAR sharing.
> Without DMA metadata from the EP, the host does not initialize endpoint DMA.
>
> JFTR, this is the case I described in the cover letter, see [1] below:
>
>   EP                              | Old host     | New host
>   --------------------------------+--------------+----------
>   Old                             | OK           | OK [1]
>   New (dma_bar = -1)              | OK           | OK
>   New (dedicated DMA BAR)         | OK           | OK
>   New (shared MW/DMA BAR)         | Rejected     | OK
>
> I've retested the [1] case with R-Car S4 just in case ...

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Best regards,
> Koichiro Den
>
> >
> > Frank
> >
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > Changes since v6:
> > >   - Split from the BAR-sharing patch. (Frank)
> > >   - Advertise MW/DMA BAR boundary support in LINK_UP.
> > >
> > >  drivers/ntb/hw/epf/ntb_hw_epf.c | 46 +++++++++++++++++++++++++++------
> > >  1 file changed, 38 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > index e0016128b95c..56185870cba9 100644
> > > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > > @@ -382,6 +382,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
> > >  	return ndev->barno_map[BAR_MW1 + idx];
> > >  }
> > >
> > > +static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
> > > +{
> > > +	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
> > > +}
> > > +
> > > +static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
> > > +{
> > > +	resource_size_t end;
> > > +
> > > +	end = pci_resource_len(ndev->ntb.pdev, bar);
> > > +	/* The DMA submap offset marks the end of an MW sharing this BAR. */
> > > +	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
> > > +		end = min(end, ndev->dma.submap.offset);
> > > +
> > > +	return end;
> > > +}
> > > +
> > >  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
> > >  {
> > >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > > @@ -420,7 +437,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
> > >  		*size_align = 1;
> > >
> > >  	if (size_max)
> > > -		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
> > > +		*size_max = ntb_epf_mw_size(ndev, bar);
> > >
> > >  	return 0;
> > >  }
> > > @@ -524,7 +541,8 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
> > >  	struct device *dev = ndev->dev;
> > >  	int ret;
> > >
> > > -	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
> > > +	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP,
> > > +				   EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
> > >  	if (ret) {
> > >  		dev_err(dev, "Fail to enable link\n");
> > >  		return ret;
> > > @@ -707,7 +725,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
> > >  	if (bar < 0)
> > >  		return bar;
> > >
> > > -	mw_size = pci_resource_len(ntb->pdev, bar);
> > > +	mw_size = ntb_epf_mw_size(ndev, bar);
> > >
> > >  	if (size > mw_size) {
> > >  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
> > > @@ -739,21 +757,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> > >  				    phys_addr_t *base, resource_size_t *size)
> > >  {
> > >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > > -	u32 offset = 0;
> > > +	resource_size_t offset;
> > >  	int bar;
> > >
> > > -	if (idx == 0)
> > > -		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
> > > -
> > >  	bar = ntb_epf_mw_to_bar(ndev, idx);
> > >  	if (bar < 0)
> > >  		return bar;
> > >
> > > +	offset = ntb_epf_mw_offset(ndev, idx);
> > > +
> > >  	if (base)
> > >  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> > >
> > >  	if (size)
> > > -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> > > +		*size = ntb_epf_mw_size(ndev, bar) - offset;
> > >
> > >  	return 0;
> > >  }
> > > @@ -851,6 +868,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> > >  {
> > >  	struct device *dev = ndev->dev;
> > >  	int ret;
> > > +	int i;
> > >
> > >  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
> > >  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> > > @@ -862,6 +880,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> > >  		dev_err(dev, "Invalid endpoint DMA layout\n");
> > >  		return ret;
> > >  	}
> > > +	if (ndev->dma.submap.size) {
> > > +		for (i = 0; i < ndev->mw_count; i++) {
> > > +			int bar = ntb_epf_mw_to_bar(ndev, i);
> > > +
> > > +			if (bar == ndev->dma.submap.bar &&
> > > +			    ntb_epf_mw_size(ndev, bar) <=
> > > +			    ntb_epf_mw_offset(ndev, i)) {
> > > +				dev_err(dev, "Invalid DMA/MW boundary\n");
> > > +				return -EINVAL;
> > > +			}
> > > +		}
> > > +	}
> > >
> > >  	/* One Link interrupt and rest doorbell interrupt */
> > >  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> > > --
> > > 2.54.0
> > >
