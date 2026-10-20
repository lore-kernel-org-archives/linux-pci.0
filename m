Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792478490;
	b=KJrpIxV1NzswPXIZFXzVqX9Sj8CQdJwhKqVKdN5ykkQPptYAhQbwLvq4AjwHNmATFZnf
	 fesrmLePS5nrTi239TJIGGcRiCK85/gfarEJ8O1YHk6GHhBOPcI80Q4sQe2zueD5YPJei
	 bJSmchKdEHxBN02mDMFVRpl1utnNyzr8l2OAY/1mgfqZ+6uR/hwydl6TCVTEmgLRpylP8
	 /C3TTvGNMrqB+pQZVoRN2tVjAj8qclf0i3q/I5WO/61OA4G4Ol8vIauWFTdel28WV9ag3
	 Q6Mdsi4KSs3FX/bAh9e1VFnToDbsxX/5J+M4JJM3biFRsHkyO6hi3Pk45Z+B9ziWFjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478490;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TsvA8H4j7jP2IcNpGFfdfFlS4HtrsyItbZSkYm3qTII=;
	b=fL1k3yl0vh2gT2SbJKYS5mOjdIgz2Mews5e3CBxhNTr+INOY0DWUheeLuN2bnA1RS98E
	 yYfSG0as2KcIZ6UA5y8EvK/52lAKwkVA+mApy0sghxoU598tZJ51uxL7gXTWavSJi9aMQ
	 kdZNJS4Dg3uM49VnkZAMyuWq9l9PyIpK85OzPomnmHqB8D+C+7j4ZoSAbrt09gsuNc45c
	 I2u38VdOuXqFoaM3PJhVGv/T9LtNFKN1kgOG9DT9fvXJFZihsnKCy6UZA3Mk73+GGjIOX
	 yT5+++fOCgdxxnPxmB4sNHKlZg2eWBqnEcZt8mwclVg0JeahRZWYFkFcJPtoF6tRNsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=fi2lFlWi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020128.outbound.protection.outlook.com [52.101.229.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051C606A31F;
	Tue, 20 Oct 2026 06:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B051C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=fi2lFlWi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD1sncB7iLEdrtcahQuYc/JVxkIoB4Pc8HI6eNgv0GpUUcRyIK0vIO/eZuwb0HH99J9K4Ebw/gchogu+tgEWu+AbL7Db4n+v+HjuFr3Zm18eGal2vT9kaTSLrYFaZq56K7wWpr8ynfHcsdfmZCDE24oaDwihNgofDF9JmiDkA6ousMN6HvnkaudpTJ6vq21kN5i4hBVKKiAVNdptYOw4j8ObTEor1jCz0rCFKRAsPKHoghzH44K+IT/E/aEtG1xOUMvL0+RTh96LMJrQKTiLH+nRpYEuYUSStKbsCOEy4A4lHIURmGsXn/aWGKcM+jycbEAltLwrWlJs/Lg1tyWv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsvA8H4j7jP2IcNpGFfdfFlS4HtrsyItbZSkYm3qTII=;
 b=Y9tPXnqtHOkvFMEGNxcKq8JExTgKealctRuOjdwKo09HWAyJfTjgf/K9M8k0NbC0IsQoQyULslqugdWCx+cNBjpZMo4MuP3/sYqSyZSZf/bth0jcguuC8kw2OcpwD6rOPfGCahE1I6BMrFMiavSgL5SM2090Rd7jFUDKQL4T6vtauwyDJeGrZr8vP1rXdTAraZ5V1IrjfsEyCcJDal+4MQWAEFGOFng+cmFsZVG90rbefX8jgXIjNUP6lsDqpuUo1/vWP8A33WZ/f7EfP+nPn4f+MkAtAcdw21PtngCUIZNhufhZuiHlrz4SO7VMzqg1bZH7KalyK6dk65R31jCGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsvA8H4j7jP2IcNpGFfdfFlS4HtrsyItbZSkYm3qTII=;
 b=fi2lFlWirvJpLs1WzuUgFDlJwvoBBVm9RF8PHJNEWCuT7HiIB2otwDrCxUTledKSKKtR6mtLrimtPiu+FeSVx9HBopokxeHrMm2xs4aB2aB6bBXig9GQXQEQ0tC6HpwZUzrStXfjpX/B6an1KnXszcxT08Y1toL8WysxveXZg8M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS7P286MB7189.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:457::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 06:41:20 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 06:41:20 +0000
Date: Tue, 20 Oct 2026 15:41:19 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/17] PCI: dwc: Free the MSI domain after the host
 .deinit() callback
Message-ID: <ghdrvrjbozm32y3o5m5vw6tl4l2tcep4ok4i6vtcvgbsbnb662@7katihdy32nl>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-11-den@valinux.co.jp>
 <5f982595-f3b1-4d64-8b14-ad38dac2b3a1@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f982595-f3b1-4d64-8b14-ad38dac2b3a1@rock-chips.com>
X-ClientProxiedBy: TYCPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS7P286MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b6be83-99b8-451b-34ea-08df2e7526b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|23010399003|366016|18002099003|10067099003|22082099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kFp22hd1jW5ChKc7f6KUC/Pd6hdZ6nl51quEE7TNg28hYi5AT4+rklESazznIAmQYX/ND65GB/83f+0FNrdDc15d5PQfel20e2EhA1kxpRNAYKMB82nmXmsxrW5991cODf36gaYYz9eLMVYcjnkWk2cV67jO6b0kf+YAXlP7WozqTn743A9bv2HYIkG9ghpxM+agwUOl7i5bHwkhVBuWRP3pCbYBcms1hlP6lmxTzb8GTIaqsPci8N0d8/ctjzW/7bNkG8SO5oKC8GbFYzfY3yNQ3m+ITKlQ+H+8IDYu+1VV3uaHY/v8XXOJSmMm9QRUO2/aIwKajLtgl0O0sZomHrqnq9U2K9qrHxVnT3MoPumboemv67mbpKlTEi648ZWGjjLG6oi0YlgF0AhtF3HBx6qEu2Idx5TbrbsU1EtLrFHfcNaatJdcTfXbUA8TIf4euK7mofcVSmm5CHrSFmAoyLzve3EfpxM7pvZP0ZywfOewRV8PcKDxsCOOr99LCNGMGAD3ackLoLz5BfUM6So7z1d47QmViGlgP7E/8HjG1tGH2P5TFNRwJk7wijn0gUHAo3xdh82htCDNtNWKv/zGGn5PGtrk69pjl+Gl9SXwpCRgsWytCaihi9SY4seWYEbYSwv6qQwqjxkfk/Bv4hG3uk2wJ2tTfWuUObA3xH7fcyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG5CSFYxVE9xaW9hQkorUTJ1OXUxeWJPY2Fkd3g2SjJ3UWhpQlNESmhnQmt6?=
 =?utf-8?B?R2hUTFgxZVl1UnJqc3l4S2RUbDR2c2xJYmJ2TUxYVndlMCtZMzhUbkNjQk9W?=
 =?utf-8?B?dzRwU1pPekdtNDJsUE9NOTFocFY2M0M1eEZLd1VaWGJNeGJEV21WYWlUSkRR?=
 =?utf-8?B?THlIMlQ4YVhRSnlTekZrOTVLb25XSDJUSG5VamZXWkpUZzRzU2NBMEpKZHZS?=
 =?utf-8?B?d05MRWpoeVl0R092VnRPRDAyVm4vYS9VY0JObURpNDRKVTF4VCs0bW8vOGRy?=
 =?utf-8?B?ZkllWFMrS3FlaDAyRURmRmxmb0pvUVBVU0JrQ0M3MTA2L0pCM0VLamQzMWxM?=
 =?utf-8?B?SUhac0N3Q1dKZ3N2a2xnYjlSQVdRTXMyd05iR0JXT0IwNmRIcGEzaHJxRmMr?=
 =?utf-8?B?dkxtZnltQ1k1RVpiK1o0MEUrcVNwMGtjSjVZaW1kZFMrMzJiMGJkM3hscjdv?=
 =?utf-8?B?NnI5YjI3ZktZSE9wSWZEOUsrTEJTaVI0RWUvR0srU3YxSWM4eElyZXUzQWQx?=
 =?utf-8?B?T1FsU21DQTdVMVdjRzRVWUpiandvR01iQy8vakQwVlFNMDY4bEVTNWxzN3RE?=
 =?utf-8?B?V3RCeGZTVGp1RkpOZWpjNlNiTFNNSE1qRzNHc1dnMFhTSDVPZnV4TVRCOEpx?=
 =?utf-8?B?RDV1cW1jOVN5TkU2R2Q5YXlGZEF2NUV6RExhcHlYS1NST0ZBUXd6a3Y1dEdG?=
 =?utf-8?B?NVgzckNsSkFOejR1WFU5dVZBVzc3K0Ewb1dQUVR3bEVab3gvOFJ5ZVBRN1BK?=
 =?utf-8?B?d2JUMEpyV1czVlZtV2NwYUVhMDR0TWQvL0lhQ2ttV3E1QzQvT09rNUQrRXhZ?=
 =?utf-8?B?V3ZreTVTYkNLUEhYYThRZm0rY1BsNEVvbmg3dzdQN1ZQWlVFVnJ3R0hBS21s?=
 =?utf-8?B?VnZaR1J2anlEQkh0bGhyaXo2WlFlcEpCdjd0b3JZZGdJaXZkcUVMNXA1aW9D?=
 =?utf-8?B?QXBYZWRaV0JQWEg3RnNKVUdSb3d5NWhuYmRka2tUQUthaDE0Y0ViMUIrWTFS?=
 =?utf-8?B?NXZRMExqcFVVSjlPZnNvOXdYWHhON1g3cUtmeUhXZUQ3cXREd3dzQWV6Z2c3?=
 =?utf-8?B?VnVObnpMdUY2ZFNJRnJDTHBRUkhoKy8rQXRjRTFyRml5SEZadENjU25qS3JG?=
 =?utf-8?B?YWFNeHQ3M3RXdHVoTm90c1RIejZqU3NWNjhkQ0JvVWhRRDN4UkU5VmtEbnpl?=
 =?utf-8?B?dEtsd0hyY1h6OGxHSmg0UVd3cjZSNUdLVFNuT0FQakx0TkdaSlMrcCtQLzJF?=
 =?utf-8?B?RnEyMTh5WTJLYVpnWHZYL3hNZlJTZkkzVGQ3SDhTa3IxcUZXMW5vc1BvWjBF?=
 =?utf-8?B?ZnF1dXlLWkdOVUxuKzVKL0YxTGNYZnlCcEJ6T3pxd1ZFL3ZhcXpEM0lwWE9K?=
 =?utf-8?B?TEdtS3RFRVNpUDErcDFnTVJSNTRKY0Z6SkkxdGZCTUZxSUpoSENGTTdZT0Zm?=
 =?utf-8?B?dEFiVFUwWEIxZFRPVFlDZE00UzJvNlh5TU1adEVGN2ZJb1poeHBIOUJyUGt1?=
 =?utf-8?B?dDdyVVdzQ0IySFZad1pNVTNuUWM5Q1dVUzFEM2RrYmk3NjI2SkQ2TFhwYjh4?=
 =?utf-8?B?L0g0a1VCNlo3a0ZySytSWUpsVkxnSll1Z25RQnBNUmQxby9GNmFEdEN5c1lq?=
 =?utf-8?B?empyYjFqV3lPQVJCQ25sWDhmUWQ3Q1FOemVDVnYxUmp6VW1zNWM2Z0xOSkFx?=
 =?utf-8?B?SERVYTFXaGhTWEMwQzNCOVdic2VrcmgxVThrdGR1aU4rVXFvcHExekgxUzgw?=
 =?utf-8?B?MUt3V3g0dCtGRFUzQ2ZTS3dQVGE0Y2Z5emltb1c2L1Y2WlVHRjFybmZFZDlW?=
 =?utf-8?B?NE9jUWtEOUtyMFZ5TDA1OWRuMmY1MzJGN3lxOXVoWE9yMEovK0FNem9xWU9Q?=
 =?utf-8?B?MEJPeU9JczBSMktWb3VQQmhjM0RwTXg0ZHNrZDQwNThpUU9TRHhHYTY0dlBZ?=
 =?utf-8?B?UXZNRnRUZU9EeDAzSXVlb0k0TndhVnZlSUltckpCUjZRN2ZOdFpRMlY5MlFt?=
 =?utf-8?B?d1VsYmF6TWlPajAzRCtWRkh3NnZMTG53aXJTTnBBcXgvUE4yc2VaV1QyYTdy?=
 =?utf-8?B?MEZCWHUxdERJZFR2ZVlMUk9zTWQxUEZmTDA3amtYTVgvUGFaNmtwUkVHaXlr?=
 =?utf-8?B?S01uV3BHdXBHWGxrVXM0Z0JXdk1hM3AyRXZaZUs3U2JtT0xjQlFsVC9ReXc1?=
 =?utf-8?B?S0hXRml2SGIxRmVSY2p1QmtDanZKVDNNMnpRd1lWd3d2WjRIalkyTnZRamQw?=
 =?utf-8?B?QmFOSFBRS0NEMTV5NWY3amtZVXROZzB5dEtIYTMyZzRhRWpuSW05WEpwa1F6?=
 =?utf-8?B?Rm1NWm11dGtNT0hmM0taVDY2elFGNmxnNVc1UWZFNlJIS1pkQUl5L2UzbmY3?=
 =?utf-8?Q?dhXQDwW3H0pMG4izqIKnR2HOgwQE8Xe0ISjqq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b6be83-99b8-451b-34ea-08df2e7526b5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:41:20.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtWykZCHqBC7F06fiWlBAAv+/Wy2aSxFjG+QZ5TNKwt6iwsbj3FdHdfqtJYftxFQwWXy1vOjXxnDaYY5N7cuHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7189

On Tue, Oct 20, 2026 at 11:54:18AM +0800, Shawn Lin wrote:
> Hi Koichiro
> 
> 在 2026/10/20 星期二 11:10, Koichiro Den 写道:
> > dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
> > .deinit() callback. For a core-owned parent interrupt,
> > dw_pcie_free_msi() removes the chained handler right before the domain.
> > A glue driver that owns the parent interrupt and demultiplexes the MSIs
> > itself through dw_handle_msi_irq() can only stop its handler in
> > .deinit(), after the domain is gone, so a late interrupt can still
> > dispatch into the freed domain.
> > 
> 
> I think you need a rebase anyway since there are two patches touching
> MSI irq naming stuff in pci-tree's next branch and will probably
> show up in tommorow's linux-next.

Hi Shawn, thanks for the heads-up! And thanks for the review.

> 
> ...
> 
> > +static void dw_pcie_free_msi_domain(struct dw_pcie_rp *pp)
> > +{
> >   	irq_domain_remove(pp->irq_domain);
> > +	pp->irq_domain = NULL;
> > +}
> > +
> > +void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> > +{
> > +	dw_pcie_remove_msi_handlers(pp);
> > +	dw_pcie_free_msi_domain(pp);
> >   }
> >   EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
> 
> 
> dw_pcie_free_msi() now calls freeing irq_domain unconditionally:
> 
> The problem is that pcie-qcom.c uses the ECAM init path, which does not
> go through dw_pcie_host_init(), and registers its own devres action,
> see:
> drivers/pci/controller/dwc/pcie-qcom.c:2034
>      return devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
> 
> drivers/pci/controller/dwc/pcie-qcom.c:1995
>      static void qcom_pci_free_msi(void *ptr)
>      {
>             struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
> 
>             if (pp && pp->use_imsi_rx)
>                     dw_pcie_free_msi(pp);
>      }
> 
> This leads to the following sequence:
> 
>   1. dw_pcie_host_init() succeeds and pp->irq_domain is created;
>   2. the driver is removed or probe fails, dw_pcie_host_deinit() calls
>      dw_pcie_free_msi_domain() and sets pp->irq_domain to NULL;
>   3. the devres action qcom_pci_free_msi() still holds the same pp and
>      calls dw_pcie_free_msi(), which enters dw_pcie_free_msi_domain()
>      again;

I'm a bit confused. Steps 1 and 2 here seem to describe the regular DWC path,
but the devres action in step 3 looks like it's only registered in the
firmware-managed ECAM path. I don't see where that path would call
dw_pcie_host_deinit(). Am I missing something?

Best regards,
Koichiro Den

>   4. irq_domain_remove(NULL) dereferences a NULL pointer and the kernel
>      crashes.
> 
> 
> So I suggest you to add a safe check if (!pp->irq_domain) before doing
> that.
> 
> 
> > @@ -633,7 +643,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
> >   	if (ret)
> > -		goto err_free_msi;
> > +		goto err_deinit_host;
> >   	/*
> >   	 * Allocate the resource for MSG TLP before programming the iATU
> > @@ -649,7 +659,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   	ret = dw_pcie_edma_detect(pci);
> >   	if (ret)
> > -		goto err_free_msi;
> > +		goto err_deinit_host;
> >   	ret = dw_pcie_setup_rc(pp);
> >   	if (ret)
> > @@ -686,14 +696,16 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   err_remove_edma:
> >   	dw_pcie_edma_remove(pci);
> > -err_free_msi:
> > -	if (pp->use_imsi_rx)
> > -		dw_pcie_free_msi(pp);
> > -
> >   err_deinit_host:
> > +	if (pp->use_imsi_rx && pp->irq_domain)
> > +		dw_pcie_remove_msi_handlers(pp);
> > +
> >   	if (pp->ops->deinit)
> >   		pp->ops->deinit(pp);
> > +	if (pp->use_imsi_rx && pp->irq_domain)
> > +		dw_pcie_free_msi_domain(pp);
> > +
> >   err_free_ecam:
> >   	if (pp->cfg)
> >   		pci_ecam_free(pp->cfg);
> > @@ -718,11 +730,14 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
> >   	dw_pcie_edma_remove(pci);
> >   	if (pp->use_imsi_rx)
> > -		dw_pcie_free_msi(pp);
> > +		dw_pcie_remove_msi_handlers(pp);
> >   	if (pp->ops->deinit)
> >   		pp->ops->deinit(pp);
> > +	if (pp->use_imsi_rx)
> > +		dw_pcie_free_msi_domain(pp);
> > +
> >   	if (pp->cfg)
> >   		pci_ecam_free(pp->cfg);
> >   }
> 
