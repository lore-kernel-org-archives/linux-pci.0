Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166F330672
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430523; cv=fail; b=i61iH2tQ9GkrK6Cv2VTprJugT94h/8ve66YraSa29Ey1Wz17j5fGRlfhsQPaoQIelk8Pt2XP6hLIMhN1b0EbUROVVdYt0vDW8u7cQ7YUZEo3LUXKphadiZ7CuoQvpp3hDNRwrG1CYcjAPd4rdUvvzGhfMfAgWtF2mMfBq80g+Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430523; c=relaxed/simple;
	bh=80PrDcRyQx33wtGXwDgV4s6zAsm23XTzIkVxWT1OLQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GGLH62ymSdTrA3u07tL3qAJVqKGDjeW5KBt8tinE8B3ZehFR2U9qfeHau1zkYNljHyoj/xz2z6PHvqyRR+e2t6hqL8L96JA2/0ui3LkYN4AbtLQI6lUYHY8bkKvXjwugKtB/QU7dJyaicB1WUHygyisBbHftclomoWEOX+3RVQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EtpzMaMq; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EtpzMaMq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O41xY0ikoBoT21u8VOb7SH3HxnOzh5jmUXZBUewwecpQa+OrLB6CcflfDnZZl6Zyle3Cvd+TgalHSoLYF0zaDps23Qr48QxKXukctfb6iKMf+GWlmV5hnf/aiuZchWPMiJH5HnL/p7oi3O4ArWNHpDwhMyJ5d/8WOTfecUY6MlX4YjxWHMseDnSOpuAC0HkNvWoEHZf6hG3F70vatklrgeB7vA8iaLCuXh6PnFbgvDQtS4ekyutlSesputzWPys7qCbuag9rrFPjAS5g4XSNd0jiEoHGliwXwpO3+DnWo8IkL/NgcpyyP4TkF4wc9u6wpqyImF2y6u/yj0WqUgxqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80PrDcRyQx33wtGXwDgV4s6zAsm23XTzIkVxWT1OLQk=;
 b=mUC/cbyW4nd+n06a8gErwy9ZAeM4L+v2XSM32FSQnrEQb8RW6ja4h1ZMRoktJ1W27HkboLYRXQ2mPIGgn9XzpRI7YZDkq3Hz4HXO32GxSt7eWtWndlVRmc/k+jupyGisqVdfgNFcdZSualSbbyAJK3je44JgCvLNDfD0ao/SXvt492PzVNB2AKQ5wj1pxfMmCUCSfw+qMyEn/8c3efzkE106RiPWfTevGtKWz+m56VarGKuC8ejMbTCpBZk1m4ToikYfq+7dgo+vNzspuJpHLnNLLEQyBJL/6+l8UD3vnxYj6anj4IkbbOeyS1UGY+m+seYSwmdq2lpkGZTp0c8eRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80PrDcRyQx33wtGXwDgV4s6zAsm23XTzIkVxWT1OLQk=;
 b=EtpzMaMqdokCR/dJTZ7gi/EhytWwQjGh9AQNC+emxHJIKnSf3thaALKaa1R10AZHPmtpVtA8MUFdDiSOPMQO6WD25OZeMy7z5Lqbv/kI3rz46G+57LH0ZXTiCmBMfs5TigmQfWvoWfLa2Ug36uL20CY2og2lKOUy4vvuiay+FgUQuYfhEjiLVR0fScWiYQ8Uxu3//kHrQAQImJYCbpb9t+pabbvPe7YqdWHbfj6+poDyysTeaPrez9yUWH3sj+fUXb+FLJZUZVLzZwRkVT6a8+X9cBUdWeP4UdjUYX4q3kgAEqgvf+oecUK9x3BtGzh89uvzyh4SuJO9LmePAQrS+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11350.eurprd04.prod.outlook.com (2603:10a6:150:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:01:58 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:01:58 +0000
Date: Wed, 18 Feb 2026 11:01:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/9] PCI: endpoint: Introduce pci_epc_bar_type
 BAR_DISABLED
Message-ID: <aZXibbGbVBAZRkcz@lizhi-Precision-Tower-5810>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-15-cassel@kernel.org>
 <aZTlsQedwzvGtD7K@lizhi-Precision-Tower-5810>
 <aZWVg2S00uRajBR_@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZWVg2S00uRajBR_@ryzen>
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11350:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cb515f-2964-4605-3e64-08de6f070b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k+fSOoQ+8WnXD2knEHm9zH5vJmg+27R8SIc2KhyPeRFahkWq1z+CUQ/d4L9P?=
 =?us-ascii?Q?gAj1UKWlNKt1REPUuK8QUc40nmyKPZshNcRVRBHn56y04owXQ7uZAKOWO9Ma?=
 =?us-ascii?Q?GWZ7rdFTeN4m2xJHTJCVJsaFYqhlLiFS9TM/YzPQp8AUUwewfRuc3jPipdU0?=
 =?us-ascii?Q?X4kbK3xtksbqhDJYSZhirfsbR3oMpCmOgnkCZafoZjIwhTeCxr3GQnz9VyUs?=
 =?us-ascii?Q?RhYC+HSgAUdJ4fGGtJV4JeEV1Yvcnyi8uBfOE3oy2EVze/kwMqNsYK2Fh0kj?=
 =?us-ascii?Q?eyT1FwG/tkGyRqZ654MLIeYHkr2jwk6dyVyRpmPUOnhJh+DxN65GoS+IIHoL?=
 =?us-ascii?Q?Lb6gentrPO/9PhN+tfbhcu1PDoevKMY+VBkXjeM0UJ6T+0vkivpprGJP8cUQ?=
 =?us-ascii?Q?EPz2Qk2m6NYsqWAgFCeuv/IASkNwc7qLuI8WoR3tT4zTcSPuixyLuoLtLcgQ?=
 =?us-ascii?Q?jKgQY8vYw8sIhk8310NlGnrrcu1KGnDSlXCh6uPPErG8jz57FgWa5f0hhUE4?=
 =?us-ascii?Q?/eQUipneIv2ucijp84tUMFiLErk9Ms7vzieGJj57MYwM9sNKv0hnCtV9VJmc?=
 =?us-ascii?Q?E5djvZQM1ye2FaKG4c6OJMrC75mU8o2pEq9O6qr4bFBYVzE5BI95Z5XZoNuW?=
 =?us-ascii?Q?pljeROTkBNRbZ69qqOQ1intBedm/Mr+obY1zXYfqp0yGpa0FZDoI3Eixs1zR?=
 =?us-ascii?Q?GZapnasj3ETTcHfq8wN1Y988DhvZqAy8DPUm0+Oq13BdYrsGVhTKRzDSggKb?=
 =?us-ascii?Q?9zTMJP3oGja39D4ZpCl6yy070mva4GcIUUbwXhdeYiJ2cXIhLnjsdtFPoBzb?=
 =?us-ascii?Q?NddGfcZejjGZ5rO8p/C+jVFRH0/vfsg5QBnIE/hsIE+Y8GUE1WrIC9Uz0OaI?=
 =?us-ascii?Q?1hlsZt4DKGRNqT37OcnS0hMSRQapLSiML0+LOfzJNAk6gwqZ7Ray6Oq0JTcK?=
 =?us-ascii?Q?TTO6/kthPKiMAr8V6x32u2MemRKShsP9weStJAMwJqHlPP6c34rGH6EuNVWh?=
 =?us-ascii?Q?VzE/lZ/jae0ch81rkxf9GvnnS96dxbStGvMOx9eRdth6gD0Y2R1lV6BmnHlA?=
 =?us-ascii?Q?zK3DeYSp4jO+Phh2j/P8EkLwg6Dpxg2Qp9gtYSO198tu9oL7i2bGCC/13X0z?=
 =?us-ascii?Q?gKgsF/Do+IVMaY38VOr01mC0nTsXDn5yPe9OXwazh95rIJSvW9CIV0jxSnlv?=
 =?us-ascii?Q?J/RUZfiVxShNj90yI4Yv8O/yb/oRcppaBongpLW8f+QHUEybvxIaVRE34JWQ?=
 =?us-ascii?Q?fnU84d+r7UQQB9jUmH5ZwNItr4zKBDpv0cwbSqddKSwVptgqg6D917hmFlMF?=
 =?us-ascii?Q?fdi22aDFBhBUMSDul4ykZzcB+x4R3m8OOod3ka2upxcnpTksTDzLzdviAsYa?=
 =?us-ascii?Q?0OaQzZjQQzWip14JuaILcEsY5JvsM+4J6/2R+5jaSGcb08/txBVqFiJOdjM5?=
 =?us-ascii?Q?UC98tqJMom54CPlcz7qE7QG4bEirUZ1t1+vnwZfoZH3W64/imbD2HOwwPZPY?=
 =?us-ascii?Q?46mKC2unM0iD39T7Gxyp3y5YogNQYgnAXxwVyk4PIAY31aebw1WRm1bUWuGh?=
 =?us-ascii?Q?3bO8rizdbVjF9++iXMVwL9jflBnFM+pxNyW7lFIDRPnU/xsbhIa0JSCp4Vry?=
 =?us-ascii?Q?qSpb4SPc4iegYivtc6NqFR0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cH8FD/ht5ogUlJznAW/Ga38scduxvFpo5xmRGABLc40/5fhiLifiMEbfkYSq?=
 =?us-ascii?Q?6BFOyM94W2AJddftcLC14qw3TuMmW/iYe9RzdTNEvXhK/bves11knyp0KDNf?=
 =?us-ascii?Q?Ijh0CAoFix/QqdXV7V9cmCsnV3I9pw6z5U9S6rSCl3Wkc/7DnIH5LSe+j7rs?=
 =?us-ascii?Q?R3U730oA3PfgSSthfEbVPRM4m+W0C/XsSNmZWcolyv9VYghT9Ei7cuJ6pxPX?=
 =?us-ascii?Q?9GkKmFV+K2ohKxUsUEu19HO8KwI/XmR5SdPgkVo3v2agDisl5DXoBnn1yMdQ?=
 =?us-ascii?Q?FKGcFxsup6WpdGO9ENTED49QkiQiI1yur4EGoBP38bNbweLNi6RJCWywcanT?=
 =?us-ascii?Q?ozH4g0FWQipY90qmSvT1ulLygbCA7Cimebv13XjMTeLoYaeRmWyM9lrNcOHK?=
 =?us-ascii?Q?leDZTz+YVwE5Rb+rvt1igi7GnckHQj5+EhSOFIKdiSxiQMfGjvW/bh048UIa?=
 =?us-ascii?Q?ZnbXT2IrfP84fEFuSgTyLvo4dhBOkgv37XpvH1rvk7vJaAswbzzEB8WUEFMZ?=
 =?us-ascii?Q?YxLeVXbF4+sPJKmQK4rClaWT+qLmOcxSQkvMcfJBVF2Dtsa1wfYl2WWaVzGB?=
 =?us-ascii?Q?2UmhIz+SFF/4aG+jvhs03tIWz2t5eap+foREXoNhMk5mYCkLLgohf+8U8MYP?=
 =?us-ascii?Q?9ocB1/Jnmh5cUkdylEVsIVoG2VVrpbM7zl/KalWNxyv7xg3PQ+TEvgIK1gCG?=
 =?us-ascii?Q?9uSJCN6VpxvBYO7OSNNPf6rvgJu618asXI5YQ58Rq8/JM2MmVARYWVWOzaRY?=
 =?us-ascii?Q?A7sAojpcL5c3lw/ua0gS+SM/Zda1bpz+mt1b8hJltagXpCQkAq+uD7e65J0i?=
 =?us-ascii?Q?XAM6bTTK6aqwLaWpKlZp2wH8QpiONBTKf/UHqY2VnySdyDbmODhl8Bz4UwmG?=
 =?us-ascii?Q?99LKzhjtuKaYBGAx4NNHCddIL7/7LR8bTOadayxKD1Ni7nA0hhOqqLcNieUv?=
 =?us-ascii?Q?7HIs+5ThLJ6V2m2OE9Gsxev5XUCNJd1FV6yd4rcRERMh8LaR5cekVP00NeOH?=
 =?us-ascii?Q?eh+T6RIUzFABfliWYmdcVG5rpifHhrcmejbTnQGtvx8TAeM2yc5pmvcbXefi?=
 =?us-ascii?Q?FKQch0MB+2xQPSgD9+mIuPbSlxz/N1IEFkatVZnbJJ8dK2ZolyOSb1D0mA1t?=
 =?us-ascii?Q?rDp/sPx+JIgOUE+QORqBayLXCqxqJij03C+nuI/crNj1ta8qTKEjGRzz1NMW?=
 =?us-ascii?Q?wLSTPtT3foPlru0bScg0qjH5CyUsM3iHBLI3CJPaH3o9d80Lxg2pLNXqIpAS?=
 =?us-ascii?Q?eCmuhz3Mdh2DPKb0pcZU++a6hJyBpguu49dj/V85ZruKzK8/Ox5dJuR7WcHl?=
 =?us-ascii?Q?zUyX2k5EWS8JUwKBNUGvhafbGbslpZfAWFyCD0IaDviFL/j+sgYLDHgUgMg4?=
 =?us-ascii?Q?5LkWKHoBUFU5K7ZfyG8YFatya5OLCEctwqfpQsAlSAfUPdNsGJRi9PtE6XNK?=
 =?us-ascii?Q?vJaLAATplNk1zXNptrwqP/r9PQlTl4o7KdVKntwhJETfLVhBnxswaRGHZEYE?=
 =?us-ascii?Q?dgzlRV+WEAdHpJkUpKb+8KWziyvtczYjLzVhejnpWBFVhKqoxqLFluI4HlB3?=
 =?us-ascii?Q?0SPye04hvHVHVzjgObYx5e0KRYDuuOzu0n7payh19+ygmc6NXj2D13Xgqz2d?=
 =?us-ascii?Q?Qo0UIGiwR4dWIPEdrFGoYHNHE0t5wIGpWcmzLHsDWJw0SnmFO6f3QqfY4h1l?=
 =?us-ascii?Q?m6Z9l4f1uLF8rh8fqQAH5UUfgUlJDtpQIPNyXT9EAwUUne6/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cb515f-2964-4605-3e64-08de6f070b61
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:01:58.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZwbAHCArCEsMU0h9r87QHyJaSK36sx3PxDheoVFdg7oqlfHuPRFe5rSC0mfIJ6IevIfcx0IZsUrACD68LZdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11350

On Wed, Feb 18, 2026 at 11:33:39AM +0100, Niklas Cassel wrote:
> On Tue, Feb 17, 2026 at 05:03:29PM -0500, Frank Li wrote:
> > On Tue, Feb 17, 2026 at 10:27:10PM +0100, Niklas Cassel wrote:
> > > Add a pci_epc_bar_type BAR_64BIT_UPPER to more clearly differentiate
> >
> > s/BAR_64BIT_UPPER/BAR_DISABLED/
> >
> > > BAR_DISABLED from BAR_RESERVED.
> >
> > from BAR_RESERVED.
> >
> > >
> > > This BAR type will only be used for a BAR that the EPC driver should
> > > disable. (Unlike a BAR_RESERVED, which is still enabled.)
> >
> > confused. it looks, "this bar type will be never used by EPC drivers"
>
> I could write it as:
> "This BAR type will only be used to describe a BAR that the EPC driver
> should disable, and will thus never be available to an EPF drive.
> (Unlike BAR_RESERVED, which will never by be disabled by default by an
> EPC driver.)"
>
> Is that more clear?

Yes, jsut remove "by" between "never" and "be"

Frank

>
>
> Kind regards,
> Niklas
