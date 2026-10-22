Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792645746;
	b=ktJlqBfOvoDs3hTNDNkurpLFKEEuZms8Y0G+tbbXI4cl1VXFLAcJVywJOR6xPt85PwIR
	 rbP8rA7BSO3bcxR7fGoqZGnj4drahrLfSKBOW55iPmCN8ri+qT2k7fqgOnbwcphV2bMio
	 R/fC+H9HRgobS6kFFI5Uk+TqZHW6xLKfmWNwTmAJCjz2ulTdhbUhmH/AQUnnfRxIs72ha
	 bbGLbi/yID3/fJmtsjBXCyu5nTiHj5BN4GdqqIxvY++vjzjdU/RCHH4SaxPhrFkf4adij
	 JPeo99z+KG4muTPT8f6L78OwClkOMrkA7TJELX1iGRRVxs0VAKQbCUM/igSkt4JnZiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645746;
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
	bh=1Baohzr6HFZ0onRNndEDcuP4rBz4iqsAu8pmnGCrGnw=;
	b=D9UIN6XuGm6F5LITN44qabxkJxuhCYUYDe8Xq1Y1Eq2DIO3zHZ4oLseUygWTwyrzFEqR
	 t59voK7KkH+XQrVwelempLrSrhHwAVXXf8Nxx71ZkL9vx3kK//M3VIQUH2PUgQ7J/R83D
	 lzPIQeynSFrwDuLryDj3Be+DIJJagInUDENL06TEMAED28U15IwOB+0nhrY0ZW9hPPZzt
	 X6eeNZBaWu5eW9NL8oCzKseLpdKIoj5LQPzY7y4HJzMokl3ysrHNoEjzZY30lxEC24mEY
	 UVzDI/32gqkFx0yPYByxKgHVJv04/XhJtboQGQBm3sSvmDCw42Hz1UbPqUJRI7ujcgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="fa8ya/SG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.119
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020119.outbound.protection.outlook.com [52.101.228.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33D606A31A;
	Thu, 22 Oct 2026 05:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A33D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=fa8ya/SG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2vXQEe3dLDEcIvCWmqzswaTL1a22RAxRtl+hDtDLKhW+brUPO53+vISrE/3VxBYWYEHR6mxz9sEMd4YRQSG1ZXPCttEuE1pxxdGDDcapIhkgF0dL3xf5AwoMFy1JNOznQBsJU+TRcBT4MUfFuXA7paBov00/SJNEWn4AbblrwfVh2rE4hfpA6/EFIdoOoHrpwjXbbNdFccgrEUMxUGFq8X3j6OByl4nuJM1DQGNWkegNnoYTaM23SUJUi6YzzVqvA7pmM0tvc4wcFebu8TR5RD4ZvScmmIDplDtmtHDroHtSps73Pra5gxjkw0Q7iHN98FG1CGsGWAo/XOy/2HQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Baohzr6HFZ0onRNndEDcuP4rBz4iqsAu8pmnGCrGnw=;
 b=UPmSi34Z/yw/ZxGLC6+1/HgK2yUZU2b6q40Onict3ztS/fPrZSUd+qLGX2cbYKKBII04WMPXE4NxM+HLqArhceeMniBZ/+bt9RV1kTQ81WxOFFANJqcyyLs5uT+8wokhFSj8uctqjG9jN024wBeeOMqcPhVRzKJLXei2zaHp4AfK1CRbZ62m2mZpsBOJPiEjw5wr+XuVCuccROtSovArZsxbiDCD+25GTPI+3CYrVkky/M0FDvQO3I0racpRae1053IxH7xxSRgP5PI/WKomrtDEDZYYntSYYLEhjyIHcoJfGrn9kn7zyMxYhgvNMaC54zBedR7a8ykSOunEXJ7EYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Baohzr6HFZ0onRNndEDcuP4rBz4iqsAu8pmnGCrGnw=;
 b=fa8ya/SGM0gZAmS8Nbv6WnzM8oJCULKiNLuoYNTEmWZdxNiDwGs2UPn00JeGWB/jWc7mbg1yI02MVvWFAfzQIAW7Ug8u8TQs3vfyVHTw8ky2th4+FxqaelZE5tp7LZENRrFHOvYx0vuA99M/pHmrEX6YX/DuS1thjaMtKf+uW0Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB5399.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 05:09:02 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 05:09:01 +0000
Date: Thu, 22 Oct 2026 14:08:59 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Message-ID: <rjlarph76rs5j73m5fj5oto3mocx7isd5xfel3zodbdqrc47yb@qpk6j2yug2ew>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-7-den@valinux.co.jp>
 <atjfwC1LTX3L6ncV@SMW015318>
 <fmnltbvuo6nm2sddmoqmpb6ema345rdqgavhf6xhrggnj7twpa@nlwyqy7zjppk>
 <atkLwWs1uufsGkRV@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atkLwWs1uufsGkRV@SMW015318>
X-ClientProxiedBy: TYWPR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e459d5-c801-4c44-2f3a-08df2ffa961d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|1800799024|366016|261021123027099003|56012099006|4143699003|261009223027099003|18002099003|10067099003|22082099003|6133799003|261021135927099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	zsiP1/k9HcqCijLUBEh/6g+5MnsdYRKM/I4KyeC+UJbYUuo7sbOYnyYzemRJOhltBunZrmiQdkhys0nI0x6xIEL99cFcElAf4Mpkj4BK7xCmwUZNeCWCvdGM0dl+LVRAdvDbl1RdvyS6s1q/okVGv8i9iTnvuygE/FgIhiNhR7+SzplBe3EVmh6aenpmsIsMr+3i6+G66TIfeYij56PLisKi+hElu8kPndFPW2WiwwmHLsxwRcwW/9T6UKw3pYcSHBn9uFmYvDPxzBZ19dsIA9sfgP0mMW2RCmus1dLHvsBnuS/q3FKy7KqNAF6Cg6m374aI+0vl0xv4Ahd0qmLclWbemx+SNvJJGuNftSMn+BzcNhFQKiOgK6MrlE/U5vHv2a8kcZjYrnRiukwIp/qxdq3kARuBsZ5vJBF9q3kANH9TYiz0Twc53v0s/gJgERmx5XpqrFk63o0kXni2zsVApPSCYBZPirjwTPCRR9JsMhfEj40p6A6s/u59FR2cQrEPj8rVbed5P0FiLnz/XCPHor29jTruofsN8VRs1bOViO3R/SZMcBkTz2CBhZmwgTUsfw0UtXbmsedItk4NnUU5oeuo4YY8dXnZ3F9w9bWeIgzNsso2xfnqniJaLD+rXpEHLDnYx8d5kArfG8xLhWy/SImJJwWCI906E3O0N2qgmZg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(1800799024)(366016)(261021123027099003)(56012099006)(4143699003)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003)(261021135927099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzXtPsfP8DzPBUsfAHAkbXCvv3oaL7CWHMPJvuOyh93l5RaI4KRJZy6TzY7V?=
 =?us-ascii?Q?J2IfkBYo/ABR/k/g/Q8sXoeI4Skw/IgVdh2WC6SHdi7v/skRGWjVPWFmEPzF?=
 =?us-ascii?Q?lRfP7lmmKnnx7LKaAJf8N9wFXs/flNQwCXGdqPntrwTLDM3vgb/H2FLzWhKI?=
 =?us-ascii?Q?4EpWJnAh2Dz/1aLCxLhq2rmH1kHiF8S3p2Iypqs1yA/2F0ze8cTGPRoialds?=
 =?us-ascii?Q?FULK+a/Gns2AJFcUv8gdC0RWBu1YH5j6S9MmKxO+W7G3YSkCaSF5X3G8PSZa?=
 =?us-ascii?Q?IcQkiXOAFP9RiX9POIbYcUhvg4lLyBPYvCvm1PV94ULVAeEfFtXLePo+Ocbt?=
 =?us-ascii?Q?2QMXqiwztD/5O9Z5pgTefe5UoS1iDV/bgjKvFSoaEDmVSoIrpyFTdOAs/Qr3?=
 =?us-ascii?Q?BKIyf7x0z9vqSRw83Ir7s622kq6PZJZhZLzAavkoV1IRMlcH01zSSbfg5FK3?=
 =?us-ascii?Q?gOh2Blg8F2XDqkdbJCwRiokBntAIHdnyPbgTrmiD+BfL5w+1nHUGX25LKsyn?=
 =?us-ascii?Q?fXKdgxRyl59GB0VeCc9ZrH8XKfxiPjpaARQlSTgivO3c75afobp4++sCjgTm?=
 =?us-ascii?Q?uGP/WIqcIDF8fRhdjCJGtBo/Uptx3jZ5CJqTJJ8YxuKgRNiM9cEbi3ZgPHVj?=
 =?us-ascii?Q?H4FxFUiSmtwazn2pnoxrx3LBoWomknobACBJdtckfg58WsQ1vW54PHpfbb3T?=
 =?us-ascii?Q?k3wu7UifUjPV/qWv0fwHuK34Zg/YkkFWCq7rCY+12aXgod1xiMhS2zJAMlR0?=
 =?us-ascii?Q?Qjz8mR+vYTbRYnbOPwhfju7NZWak9a/1C8NMtWBTP0qgDjjKgCOZiVeXbZC3?=
 =?us-ascii?Q?WFcxcphNAO8wqhOL/uI9Oq98gUKCAVN3O3xyDWTOE6uZ4Hatk1qQ3TJWxLRc?=
 =?us-ascii?Q?DxDQLxxa4zVXK+iuhsT9xsXAmDw22rhdrI4Lm3M41U3vh12UxLBR55oCHEgV?=
 =?us-ascii?Q?JzBMfzAFca0OckMikuXiuxvkOnJyE7s0VANyh7MwKqxIDqU/A75hhLRqBVE7?=
 =?us-ascii?Q?P+CTLGRCF0KA3MoC9DHp30vs/nVxUub+jJV1wxBvdNTUTESfyrnF/ZN9Zc0A?=
 =?us-ascii?Q?pkUTBGnTAKGF0xPYQDqbiPFN/lQmWMw4HPHVDuoB0mjCZurY4FhZpeFoW3Mv?=
 =?us-ascii?Q?i4RTrklQb1OgQzTgE+dA/7XA9CWW7jMFjsp6joV5SUB9e21yr6fOWcuNRV+g?=
 =?us-ascii?Q?Py4bqz9Igklsjdj+2mPg+UgcptTY/mY6GTNs/xT59O3J4AYJ4r96Tn/LFYeW?=
 =?us-ascii?Q?CWhn2Bu3i4odJLsYcB98obxLy4+nFmmtc5YML89Z5yw1I9Ttg6ZR1ktrcCVY?=
 =?us-ascii?Q?+z5ycI2eddpvUQjHCtZ/5DRo+7Kx86i3OOHE6566maBe0UWM48mJvS+SssXw?=
 =?us-ascii?Q?HDxNw36BOjw7/uPYyY2BAgFB+KPoObQ4wxNOUnNiRw11ylSl6JRcBBdZEZJb?=
 =?us-ascii?Q?xDmer/XKJisCA1PwzWMi+UYGc4ELNae6GdRmycc+96Aw7ceiclXaiQkp5yNU?=
 =?us-ascii?Q?3+ytpxCFIdrlB6d/nM52rGAt88/K4fyMUc8S1Wgvqhu9tTdNtMOLtSWfD3HB?=
 =?us-ascii?Q?TyRegnkjRAgNWgcF7KKT8+N7DqKkTYrVjkC/dCeMYjW/bKA+FoPESFzSZwrP?=
 =?us-ascii?Q?BRmJCwBEbW4B+h7bv36eD/YflqIpHH3G1lcRhv6AgSvAH0195iRdESE8pcCy?=
 =?us-ascii?Q?QYkXQgtk5mWawg2JUgdxxLCPG8h0dIt/1yTCFK2p3Pei8qxjPiIvFP0y4y3f?=
 =?us-ascii?Q?18kpZTfGrCPP3DMyjLt60UVAznjhteozlEFTAn7SU5vAMCEoeIUH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e459d5-c801-4c44-2f3a-08df2ffa961d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 05:09:01.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYst8rOHgBeZVZFu3qbFHMWS4t0GlBkyEVOZO+6dzz7/QVMxjwiz/EbSLp2EnCe4jCmR2bivwP+gFhW+TVmQ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5399

On Wed, Oct 21, 2026 at 02:00:17PM -0500, Frank Li wrote:
> On Thu, Oct 22, 2026 at 01:35:18AM +0900, Koichiro Den wrote:
> > On Wed, Oct 21, 2026 at 10:52:32AM -0500, Frank Li wrote:
> > > On Wed, Oct 21, 2026 at 01:22:25PM +0900, Koichiro Den wrote:
> > > > Some endpoint configurations have no spare BAR for DMA resources. Allow
> > > > dma_bar to select an MW BAR and place the DMA ranges after that MW.
> > > >
> > > > DMA submaps have fixed BAR offsets, so a shared MW translation must
> > > > cover its configured size. Report that size as the translation alignment
> > > > and require it to be a power of two.
> > > >
> > > > Older hosts treat the whole BAR as an MW. Require the host to advertise
> > > > MW/DMA boundary support in LINK_UP before enabling a shared-BAR link.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > > Changes since v6:
> > > >   - Split out the host-side changes. (Frank)
> > > >   - Require MW/DMA BAR boundary support in LINK_UP for shared BARs.
> > > >
> > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 154 ++++++++++++++----
> > > >  include/linux/pci-epf-ntb.h                   |   3 +
> > > >  2 files changed, 122 insertions(+), 35 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > index ac83af54122f..721cd841a1dd 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > @@ -84,12 +84,13 @@ enum epf_irq_slot {
> > > >  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
> > > >
> > > >  struct epf_ntb_dma {
> > > > +	struct mutex lock; /* Serialize DMA submap and MW updates */
> > > >  	struct epf_ntb_dma_ctrl ctrl;
> > > >  	struct dma_chan *dchan[EDMA_MAX_RD_CH];
> > > >  	void *bar_scratch;
> > > >  	dma_addr_t bar_scratch_phys;
> > > >  	size_t bar_scratch_size;
> > > > -	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> > > > +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
> > > >  	struct pci_epf_bar_submap *reg_submap;
> > > >  	unsigned int num_submap;
> > > >  	u16 rd_ch_cnt;
> > > > @@ -229,6 +230,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
> > > >  	return false;
> > > >  }
> > > >
> > > > +static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
> > > > +{
> > > > +	unsigned int i;
> > > > +
> > > > +	for (i = 0; i < ntb->num_mws; i++)
> > > > +		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
> > > > +			return ntb->mws_size[i];
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
> > > > +{
> > > > +	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
> > > > +}
> > > > +
> > > >  struct epf_ntb_dma_filter {
> > > >  	struct device *dev;
> > > >  	int chan_id;
> > > > @@ -353,6 +370,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> > > >  	unsigned int i;
> > > >  	size_t align;
> > > >  	u32 next = 0;
> > > > +	u64 offset;
> > > >  	int ret;
> > > >
> > > >  	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> > > > @@ -371,9 +389,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> > > >  	if (!is_power_of_2(align))
> > > >  		return -EINVAL;
> > > >
> > > > -	if (epf_ntb_is_bar_used(ntb, barno) ||
> > > > -	    pci_epc_get_next_free_bar(features, barno) != barno)
> > > > +	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
> > > > +	    barno == ntb->epf_ntb_bar[BAR_DB])
> > > > +		return -EINVAL;
> > > > +
> > > > +	offset = epf_ntb_dma_bar_offset(ntb, barno);
> > > > +	if (!offset &&
> > > > +	    (epf_ntb_is_bar_used(ntb, barno) ||
> > > > +	     pci_epc_get_next_free_bar(features, barno) != barno))
> > > > +		return -EINVAL;
> > > > +	if (offset > U32_MAX)
> > > > +		return -EOVERFLOW;
> > > > +	if (offset && !is_power_of_2(offset))
> > > >  		return -EINVAL;
> > > > +	dma->ctrl.submap.offset = offset;
> > > > +	next = offset;
> > > > +	if (next) {
> > > > +		/*
> > > > +		 * submap[0] covers the MW prefix. Keep its temporary
> > > > +		 * target at address 0 until the MW translation is
> > > > +		 * installed.
> > > > +		 */
> > > > +		dma->submap[0].size = next;
> > > > +		dma->num_submap = 1;
> > > > +	}
> > > >
> > > >  	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
> > > >  	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
> > > > @@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> > > >  		chan->desc_addr_lo = lower_32_bits(dma_addr);
> > > >  		chan->desc_addr_hi = upper_32_bits(dma_addr);
> > > >  	}
> > > > -	dma->ctrl.submap.size = next;
> > > > +	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
> > > >
> > > >  	dma_dev = ntb->epf->epc->dev.parent;
> > > >  	for (i = 0; i < dma->rd_ch_cnt; i++) {
> > > > @@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
> > > >  	if (!dma)
> > > >  		return -ENOMEM;
> > > >
> > > > +	mutex_init(&dma->lock);
> > > > +
> > > >  	switch (ctrl->u.dma_ctrl.reg_layout) {
> > > >  	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
> > > >  		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> > > > @@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
> > > >  		return -EOPNOTSUPP;
> > > >
> > > >  	barno = ntb->epf_ntb_bar[BAR_DMA];
> > > > -	mapped_size = dma->ctrl.submap.size;
> > > > +	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
> > > >  	/*
> > > >  	 * Submaps cannot be installed until the host assigns the BAR address.
> > > >  	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> > > > @@ -607,21 +648,25 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
> > > >  	memset(bar, 0, sizeof(*bar));
> > > >  }
> > > >
> > > > -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > > > +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
> > > > +				      const dma_addr_t *mw_addr)
> > > >  {
> > > >  	struct pci_epf_bar_submap *old_submap;
> > > >  	struct epf_ntb_dma *dma = ntb->dma;
> > > >  	unsigned int old_num_submap;
> > > >  	struct pci_epf_bar *bar;
> > > > +	dma_addr_t old_mw_addr;
> > > >  	int restore, ret;
> > > > -
> > > > -	if (!dma)
> > > > -		return 0;
> > > > +	lockdep_assert_held(&dma->lock);
> > > >
> > > >  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> > > >
> > > >  	old_submap = bar->submap;
> > > >  	old_num_submap = bar->num_submap;
> > > > +	if (mw_addr) {
> > > > +		old_mw_addr = dma->submap[0].phys_addr;
> > > > +		dma->submap[0].phys_addr = *mw_addr;
> > > > +	}
> > > >  	bar->submap = dma->submap;
> > > >  	bar->num_submap = dma->num_submap;
> > > >
> > > > @@ -631,6 +676,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > > >  		return 0;
> > > >
> > > >  	/* A failed dynamic update may have already removed the old mapping. */
> > > > +	if (mw_addr)
> > > > +		dma->submap[0].phys_addr = old_mw_addr;
> > > >  	bar->submap = old_submap;
> > > >  	bar->num_submap = old_num_submap;
> > > >  	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > > > @@ -642,6 +689,18 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > > >  	return ret;
> > > >  }
> > > >
> > > > +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > > > +{
> > > > +	struct epf_ntb_dma *dma = ntb->dma;
> > > > +
> > > > +	if (!dma)
> > > > +		return 0;
> > > > +
> > > > +	guard(mutex)(&dma->lock);
> > > > +
> > > > +	return epf_ntb_dma_set_bar_locked(ntb, NULL);
> > > > +}
> > > > +
> > > >  /**
> > > >   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
> > > >   *   to access the memory window of HOST
> > > > @@ -780,6 +839,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> > > >  					     EPF_NTB_COMMAND_STATUS_OK;
> > > >  		break;
> > > >  	case EPF_NTB_COMMAND_LINK_UP:
> > > > +		if (ntb->dma && ntb->dma->ctrl.submap.offset &&
> > > > +		    !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED)) {
> > > > +			epf_ntb_set_link_enabled(ntb, false);
> > > > +			dev_err(dev, "Host does not support MW/DMA BAR sharing\n");
> > > > +			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
> > >
> > > suppose it should be fallback to old method?
> > > EPF_NTB_LINK_UP_DMA_MW_SUPPORTED is new feature.
> >
> > It's possible (by using the whole BAR as an MW), but I personally think the
> > extra complexity would not really be worthwhile for this case.
> >
> > If a "New" endpoint is paired with an "Old" host whose kernel cannot be
> > upgraded, the DMA feature cannot be used anyway. For that setup, I think
> > disabling DMA export with dma_bar = -1 (the default) and rebinding the endpoint
> > would be sufficient, with host re-enumeration as needed.
> 
> At least it should work without using DMA as previous version. Assume build
> as PCIE card, which have already prebuild image, which may plug into any
> host machine. You can't require user to rebinding endpoint software.
> 
> Many PCI card have not provided any console after production.

Makes sense. I'll send v8 including the fallback implementation shortly.
"Compatibility matrix" in the cover letter will look like this:

  EP                              | Old host     | New host
  --------------------------------+--------------+----------
  Old                             | OK*          | OK*
  New (dma_bar = -1)              | OK*          | OK*
  New (dedicated DMA BAR)         | OK*          | OK
  New (shared MW/DMA BAR)         | OK*          | OK

  *  NTB works without DMA.

Thanks for the review!

Best regards,
Koichiro Den

> 
> Frank
