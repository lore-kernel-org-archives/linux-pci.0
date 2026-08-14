Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020084.outbound.protection.outlook.com [52.101.228.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD2825B098;
	Fri, 14 Aug 2026 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687039; cv=fail; b=rG7/955PnAiJiqZzwxTQ8DrNz+ngF9RDku+lXzObudYdvGMW7hIkMwEQAe6GuUrBSye0vMw+nVB4zeolVR9tQINJlBmhPgHQNyAeoY45O4tFTTRXRZwwIWoCUlhKhZs/2jH5U8jb4iweSnRsK0ItgYb8GV0jot91E1hteIDhDGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687039; c=relaxed/simple;
	bh=AqxRTmK3CSLQsm9tSjFZM5emeuQmXTW25RI11PcUrL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJsHqUY84zppjO3qwsPKelQFULWlZozJR9LrfYtWFkoU+PNw/CrtnxPME8hV/YC3GiAqANUkRenSEv9C5YleKNjfjc4Wl9j54bt0v6F21GLQKSCb56uXP7UzcdQkBdI+N191CW3Buq/5kQnkik9O7NHZGWbkbcQwyF8NFkLq8C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NSK0C4Bv; arc=fail smtp.client-ip=52.101.228.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NSK0C4Bv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXuI3sNYAgoaOJ1asdm4Ve5ssnGMwMD4FiqEL4nzFo3RdEF9UUQ+DCFaW93kbSIMWoktt8KB03woPzxDdj8t6+va7nyJDlKadaQwb4Keo2FT84j+Dz9ubala8vbR5+aJd21ZgagAvZeQjEo3y6YwqXp4iZrcpVD0zlqixed2qYw1uWRr53yrFUGL8xyRoGATNK4noJZJ1niFroFajnZxYeLnWfBaPtNXeKjSfqC4sXbXUA+n4c+pm1rYpvB98kNW0LsSGKb8Pv9oP6GNgGqFqC3nwyokNxm3IXMz7BxgyfsPvQrCGJFu34HexPczyGxfWT/YTP46vuea5vtCDJC84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2JubYtpK05PMKwGZHyHylxZWaNsYwx+OHyb3uSMNVo=;
 b=i4S/jTELwfI1iUFhNx2ngPLxR5BSnec0xCQzUHEim1Mv4dewiFj2rtqHKifkuID3O7UL9//PQHWCHDc+y5naEgQcvlwdGYaZDd65TPUYaDGhHBOpIIubAY0Ak5D6SffsojfjcKyVwdbIu+9H3YydpJB1z+Ob4R8gFTIiRFDJIVoUSfw0dZolmn6krZfvGIFD8aPFQBD4KfPFROTrw8oimRvqIVdYPpSz3CQBdMhEwTOZfVqsL6v+YAnEqpGtsyDHWmCm/CypwDce1wNnaMXcAA2kwV4tpAN6ebYVDgQYFfTaB8fJl5dqqPVrtjxtxni9+1lYx/qwxesPzjUz9yYqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2JubYtpK05PMKwGZHyHylxZWaNsYwx+OHyb3uSMNVo=;
 b=NSK0C4BvvJEtwwBSryLT5Jtz4ZuC4OtSnzstMo5hUQ4oZIfj20KflA8Hp8ctiMp93cf6jE+gPEt3lNipA71aXM+n+js9b1MMbRLEZseI0Ao2VhEL80De6VLiPPkubTsIUAwVig8ErK0RVVEV2Zi+HCDDX1NIMKgrbVQzPjZ7BDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB8011.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:476::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 05:57:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 05:57:14 +0000
Date: Fri, 14 Aug 2026 14:57:12 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.li@oss.nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Message-ID: <fg7cma2ccvdgjgcref7qa4q7ocvvume5dteekedikszebkq7rd@uhrjfp3nmmwh>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <an2uf5mXzGq1Q7cj@ryzen>
 <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
 <ztn47y23ctbjrbkmgyyhc6d5x3i2lzz5txotpgtbjtcsvbsvf4@fzadsvt5fl4d>
 <an3p_j-F10e9x0vM@SMW015318>
 <7kzvkrbc6w7yojufwekzjubndgg4ao2o65gnla6mjwhwn5ji2d@vhrj4kg6uia2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7kzvkrbc6w7yojufwekzjubndgg4ao2o65gnla6mjwhwn5ji2d@vhrj4kg6uia2>
X-ClientProxiedBy: TYCP301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 558d4553-e941-40a8-7474-08def9c8e397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|23010399003|6133799003|22082099003|18002099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FT6D9RJnisjV1+Gl5nIbLl6XKAtdC/MmHblRy7e0gTSoJ9/W6obe3FI5h0haNSCkdr1a2PDiPObH1jrsYlSR+ku768CrnI0DvlpMeU2vzfoUddb5LaIfbrgVpf5gMfh0zcUEjZBRaMRCtiA1Dec5idBqNpB605JBfo3vh16ZK1C/MIavZsr/lL8epLtPxLOVR/Kn4UrjGARiqrdSCaOTQnmO3xO2kLdZSnGBAGA0MjrfJbbPL+VQx9g32kEpIquMzjg774r/AaUXJ8OLohXodiIs9ZSAdfUGgWMeemzkX5htc2yiguoTbM6gLDp4sZ9gB8/AhGXWkdF4F6dcd1nqbcQJiYuxzlrqsUQ2JvBos5ksRhoQp/T1PslQ3J4KdmQhjiVCkHE0eXGOFygetoeGU3cDHGpHNrXcU8kbzppErcdo5eik+h/J2P1qc+nrYT4T9FVhq84huOKtZzC9fm1KSHsnKzpC2eBzGmxHRmkcJEoM5FRwZpU64zU6l6WsIf5cYBoxPUp2c9Cf3jDjmUANoRsEIvwtMAQqPLefQVkdqndmsj4kqXu4ktB1hkUXgmNswdOCWVpgygndNNuEa1IVTWQL3q1OY+TThjbLMCqYYE647PD1pHImC8c81qeqvzKPk4RS9IK/f+RFv1NzRolz34F9RP0JaOuauGi8LgGHZzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0s3dHAxRXVOV0pPYi9OMkRhRDZRbnUzNktXTGtNYnJGU1NyZDcwcEZ6UEpT?=
 =?utf-8?B?cWxVamRGbXFJTTdRcTJIaU1zZWpZZGUxdXlJc1NLcm4wOG1ydHNzNEord0V6?=
 =?utf-8?B?WS9WeWV0SnREMGpRTFRhbTF6Mjd0c05SaGxZSHlRSnRTTmFqR0JFZmZYK1FX?=
 =?utf-8?B?V2RCbkZVdUNaL1djcG9Kd25zMHRZK1ROdXA4YkRPOFRlTmJjUmFjMm53TEZv?=
 =?utf-8?B?Rm5oRWpCTmNDR3N0cURJemhxQlIrdlhkYmxhdlUwTmU2dGs2UEVtUXVuV01J?=
 =?utf-8?B?VUFCQTdzcmEzNDhBd0JXQjRzOFpaNm9TYzJtanZFaUlSZHZTR2hRS3BGQ01O?=
 =?utf-8?B?eHJoZFBRa0RGOGNCY1VuWUN6TzhQSGZZQUpJdnAvd0p1SUF4cHg2eVgzY0ll?=
 =?utf-8?B?T0crT09JTEs5M0hFSDRyNnNyWDFORXo2UncrT1pSSy9TbkJXVnZ2NGpiblg1?=
 =?utf-8?B?YWdsN3hKMzJPcWJxWjN2dEdoYUluaUxhUWx3MWtGSzY2NzRDVjFxQlNZUHlI?=
 =?utf-8?B?QkFxS1pMR0ZxUld5T0FSdmE2MzIrMzg1UUlXUkUzWkRIdExjRDNBV0FoU0Zt?=
 =?utf-8?B?WWpWcHhhS1JIRWhneGIxUmRpMXBxRWtCdVIyWE9aSmdCOHRpSUc0TW5HdHZv?=
 =?utf-8?B?Zi9QSXV6ekZyRFJjNEMzUFkrNFp4d3Y0aklaeXQ5N3BtdmtCblJjRmNYdXFi?=
 =?utf-8?B?VktETUt6V21KQmJVRHRza1JFTVo2SlhTKzJFQXphVHhUejBIOU9HKzNjS0FN?=
 =?utf-8?B?dTZsK3lFQjZWV0xuaVNvNlRjZVFaQ3hYYWlpclZrcEw2eEswOEo4S09UQVNO?=
 =?utf-8?B?anpRbWVZQ0VNRi9TZm4zU0E1Mi9Ua25pNTdtZXQ2cTBRaVBJU0NXUm1QbGNC?=
 =?utf-8?B?V2pLZmtJenBMTEprMlF0Tys4VnJ5MlpxOGZIZG4zUjdJMWRicWJicTBoWHI3?=
 =?utf-8?B?WUJ0N2V6My9jZ09qVTdEY0hYRGJSNzZPZDNGVy9VK2pDMzJaeThUSVNkUnIv?=
 =?utf-8?B?ZUEyd3B0Z2NKREZJZGtlQkxQbDlLelhUY0Z3UjA0eThHK2xwVnVFUGF4WWc1?=
 =?utf-8?B?YlNsamFCN1dSSkRMc1JRbk9DMTJIK2pWQW92VXhwcE9DZ2NwcGsyQmlyN0tR?=
 =?utf-8?B?RWlWRmtFd3ExY1FzZTJPY2liQ0JjcTJoM3RmTHZobHc2OHlySFZGWUh1eWNS?=
 =?utf-8?B?Yk8xdzJ5WlVPN0YxWmtKWm1RZy9aOVpsNFh6b0ZrOUM3cmpncGIzUy90Wkpu?=
 =?utf-8?B?aHVvdGJLdEkrUWdSQUpJY3dBUlJSd3M0am81QUhkVldFUGV2MkJscVF3Nk10?=
 =?utf-8?B?Q0UxSHdOd1RRZkZkNHU4SDQvVGxSUUw4RnFQazRZRnBTVzZXVWx1NnNUaTNu?=
 =?utf-8?B?V25SU1pIS1JCNk02d2xMNkZyRWNqdDNFRGl2MTZWYnhydjdFM2ppTC9jUUtp?=
 =?utf-8?B?SGI4elIweDdXZzYraTZPSnVhZjI1blgway9zemw5cHgzcE5IV3JyVmUzY1Uv?=
 =?utf-8?B?ZWttSGFpU0JWeVJIeDJjeTFIQlVaSEMzVnZGbnBQaDcxZHU5UTgrNGlaRzR6?=
 =?utf-8?B?WVVCK2x1UHVGamNFZklmVFZOaENRMFlDR2VFci9FdkNGOTBkay9QWjNYWnhi?=
 =?utf-8?B?ZC84dEFXczk3dUxsU3hsVzQwWElmZWN4NmhsYmtDWkNodnNvWHdPYmkzWGFZ?=
 =?utf-8?B?dmpBU05teDYzeDM1QldtdDd0aXVWVy9FUzVONFFIMlExSGFMTW9UZGpmYVVq?=
 =?utf-8?B?VHpiQ2c5ME44bk5YU3hmdndJdE80QkpieEtyMFpJUFB1TW1TUlVadWtSUnhu?=
 =?utf-8?B?M1JCcHFFR3kyZTVrUThuZWQ0YUMzSzEycExmQTBIeVRYWHF6WUtPRmMxeHc3?=
 =?utf-8?B?cDFabDJBMVRTaGNvaUlpZWdsVHQyVzlndkxqdUFLbzlkZm1TVHZGaE9nVkRW?=
 =?utf-8?B?Q0hNR3ZwSHRRRDI4SkVsWEw3TFhmRHV2RkMwVVNxbUxlY2k3UFFlb1h6dTNp?=
 =?utf-8?B?UVFuaHVBRTZnNzZURWJuYVA5TUJSWVpWZWNWbUJ5Q1ZqNFpjeHlsR0tUdmF4?=
 =?utf-8?B?SWNRUDE4M1BQczZ4MmdjanYwTWM5UnB1cWg1NE13UTQ4WHBmZTl3ZDZZaktP?=
 =?utf-8?B?eGQwblFTZSsxd2V0bHArQ3VXQ3BXTTVicnVJUVFXcFN4ZVNaWDRnVW80MjBm?=
 =?utf-8?B?a1QvZzdva2pDVVppdXJSWFlXbGtyQ01NeHphWVNidkhHdjBzK1Nob1hHd1B1?=
 =?utf-8?B?VUlmb2xEOFRpYjlXbTlTN2ZvSEpiZkh3T0lJdXFSa2U1TE5kWFlKWW1SczBo?=
 =?utf-8?B?cUc5RXVTM0R5MGg4ZzYwazk4cmZvUG1VcXcwQ0pBSEEvVkN0c2oySUcvSmpo?=
 =?utf-8?Q?e5i13RcFfPzzWFXCfff4Q/taejLYjNsvW28Xo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 558d4553-e941-40a8-7474-08def9c8e397
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 05:57:14.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzxwmxCN5yMPDvuc293uNPe+oSSUb8vAx4xAhJEFhCHWPDKB95ViB2vOnPGEPOm9SeG/snmzShoPfQg4971fwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB8011

On Fri, Aug 14, 2026 at 07:27:10AM +0200, Manivannan Sadhasivam wrote:
> On Thu, Aug 13, 2026 at 10:59:58AM -0500, Frank Li wrote:
> > On Thu, Aug 13, 2026 at 11:15:31PM +0900, Koichiro Den wrote:
> > > On Thu, Aug 13, 2026 at 02:50:59PM +0200, Manivannan Sadhasivam wrote:
> > > > On Thu, Aug 13, 2026 at 01:46:07PM +0200, Niklas Cassel wrote:
> > > > > Hello Koichiro,
> > > > >
> > > > > On Thu, Aug 13, 2026 at 03:37:47PM +0900, Koichiro Den wrote:
> > > > > > This is v7, the remaining patch set for PCI endpoint DMA.
> > > > > > Parts 2 and 3 were merged per Frank's suggestion.
> > > > >
> > > > > (snip)
> > > > >
> > > > > > One open question is how to support endpoint controllers with only one
> > > > > > PF. Keeping DMA in a separate EPF requires multi-function endpoint
> > > > > > support. Folding it into vNTB would work on single-function
> > > > > > controllers, but would also couple the two implementations. This series
> > > > > > keeps the separate EPF model.
> > > > >
> > > > > I see all the work you are putting in and I admire the effort.
> > > > >
> > > > > This is now v7. I think it is time that we close the open question by
> > > > > waiting for a reply from the PCI endpoint maintainers' opinion on the
> > > > > design before continuing. (I am not a PCI endpoint maintainer.)
> > > > >
> > > > > I understand that you want a common DMA abstraction, that can represent
> > > > > different (embedded) DMA controllers on the endpoint side.
> > > > >
> > > > > But if vNTB is the only consumer of this, then why not simply embed this
> > > > > DMA abstraction in some BAR exposed by the vNTB EPF?
> > > > >
> > > > > Looking at the host side driver that goes with the (v)NTB driver:
> > > > > drivers/ntb/hw/epf/ntb_hw_epf.c
> > > > >
> > > > > The BAR layouts are hard coded, and it only supports three different
> > > > > layouts. Would it not be possible to add a fourth layout that has the
> > > > > DMA abstraction somewhere in one of the BARs? ('BAR_DMA' ?)
> > > > >
> > > > >
> > > > > Right now, I wonder if it is not a bit premature optimization to create a
> > > > > DMA EPF, if vNTB will be the only (ever?) user.
> > > > >
> > > >
> > > > Yeah, I feel the same. I haven't seen an usecase to program the DMA controller
> > > > from the host outside of vNTB. This feature is supported mostly because it
> > > > exists in hardware and someone wants to tick the checkbox.
> > > >
> > > > Though, I'm not against doing it within vNTB as Niklas suggested, but
> > > > generalising it in the form of a new EPF driver just for the sake of a single
> > > > driver sounds like an overkill and maintenance burden.
> > > >
> > > > Sorry for saying this in v7. I've been meaning to say it, but somehow ended up
> > > > procrastinating too much.
> > >
> > > No bother. Since Frank has given a lot of feedback on this series, I'd also like
> > > to hear his view.
> > >
> > > I'm fine with either direction, and can revisit the earlier vNTB-embedded
> > > approach:
> > > https://lore.kernel.org/r/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/
> > 
> > One of the important value is test dw-edma-pcie.c, which generally depend
> > on some fpga hardware. If there are epf driver work as fpga hardware, it
> > will help cover edma remote user case. So more user can test it.
> > 
> 
> Testing is one thing, but using is what matters. Are there any products or
> use case based on remote eDMA? Or even dw-edma-pcie.c?

My end goal for this work is this series:

https://lore.kernel.org/r/20260810165136.2292436-1-den@valinux.co.jp/

It now depends on the PCI DMA EPF. The host side controls the endpoint eDMA
through dw-edma-pcie for one direction. This is for an industrial use case, not
just testing.

The resulting ntb_netdev/ntb_transport improvement is substantial:

  (unit: Gbps) (UL=EP->RC, DL=RC->EP)

          UL UDP  DL UDP   UL TCP  DL TCP
  ------- ------  -------  ------  ------
  Before  ~0.6     ~0.6     ~0.6     ~0.6
  After   ~19.5    ~17.3    ~12.3    ~10.8

  (On R-Car S4, PCIe Gen4 x2, controller IP v5.20a, eDMA)

Best regards,
Koichiro

> 
> Most of the time, dw-edma-pcie.c driver feels like a dead code to me which no
> one actively uses or tests. So unless a real justification is put forward, I
> don't want to add a whole new EPF driver for it.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
