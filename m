Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4C48EBE8;
	Thu, 13 Aug 2026 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636817; cv=fail; b=qR/UNJGsTImGZE+rg+dPprmxk7OKbzYlvdANmxqssw+G+gqUqgTUWyPteepnxr6qnTHl6baI0MAV6C9sGnghEsL5gDW7SlgJpPzOvg9DAa1FiChRs5ULygGeg0EQ3Kdv/8UCb/m+HW/ZPPm9wnx1oO2ns6JLdx7bvCRAiwiZNzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636817; c=relaxed/simple;
	bh=poCoKdi0jPSnm0nSO3cf8DPDqq1A4gwCl+aWYDxwQ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PxrP89I7wZTBJunsvyp88CJZR1WTTRhMG7JkNoST4y0Rjzz97HCD2tkSGzXtA8YTYpPW9GxsVSk2+ybpyrDCYJjZoUUaYL4r4pu5YcP3+cM03YmHGoJP2SSOj7wxo5Ec4tuP43oCjLNfoPHLlIwgF9f3IvOKWl0E9ZJvotxbz/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Z1zlpZkI; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z1zlpZkI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3ppAzMhmA0ROnEuvf2ei4rStP/wcGW/d+YdtFVdGkZR2jlDcuXu1FqjP0Z2i2YgmShvJssuYr/qIl6lFiOwWsJ4oN9ovzFBOF0x6iWAZWadVtp+GeiuIIJhBLLSjcwdpcuIHGJLZjJqyONIIK0t3j6posm4ERChoIhzHC/I5nbO4y9lQDrgG5C5fBHF1E9ilcCYicpHPhZRE4NimZoWrCBl4WUfsSEvPMaFMbJq0m4JtvqGfFTezrlEgvFj8DEOEGJ5pJRhsX5vsL6JxxppqYovyy76sm90BV8hjo/CVSMM5y2rv1eyRDvTMKHB6pOykZjtr+hx+UiF6NwvrtxGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poCoKdi0jPSnm0nSO3cf8DPDqq1A4gwCl+aWYDxwQ2I=;
 b=S0oVzNqKbGTmEhWsSn7CTHN8elQoxJdW/NqRqSOg9rBK5JSXaye3ltJ2j/SSB8XcfZY3GrzvrXsYqRcTedi1fTskHTH6l0xb+mq+SYNzOGDDlPZJrBSJYPyJK1R2Q8iIdfb8gG9hBI5s37WFpqH0EJCnHlN6h2IreOuB5usg1/pHz+VhaxGBMJPf3ARqNYrWE/XyCJ87jRhhtQHPZku/bs9bDbb9Bpnu77o8NYiZkW0C48nanbCr3WHBO/jUxLQ8IQqourXXqD5C8ikTkQwjkkJZp8QoIONv92vmuiRYsJ9zNRcc/WtcKhU5c8GxIiXoSjCvNU2ART4uVMrC2AzOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poCoKdi0jPSnm0nSO3cf8DPDqq1A4gwCl+aWYDxwQ2I=;
 b=Z1zlpZkIhYBKmaberPv1WyK0y217pbJ6eZwXKk+L5mDV/eS2LAJm3okN7iGru7/3Xm54UmQQFzUqfwIKqTI7iKnXy0MQZR6OSNHn8caujP/1ggvYJtXi+jr8E/tq0Vli0NTP039J6r4PQi/Samn+6g+Ljy8oewkrHQ1t+VgP0BAeS6jqMxupklAitg8ZVqXEprIaNnL8vknTSWVkmMq8fL82jP2GeZ5iMumkr3tpohxf7NcbklP2fp0zMIOKjgOYB9TBHRe22z6kSBZlFlIz3YyasbuReyFAHVea10Ng6nzmc2c3Mg1jce8pJajka+w5xwMZnexT7v0bj86LJ5nivg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by DBAPR04MB7477.eurprd04.prod.outlook.com (2603:10a6:10:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 16:00:08 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 16:00:06 +0000
Date: Thu, 13 Aug 2026 10:59:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Message-ID: <an3p_j-F10e9x0vM@SMW015318>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <an2uf5mXzGq1Q7cj@ryzen>
 <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
 <ztn47y23ctbjrbkmgyyhc6d5x3i2lzz5txotpgtbjtcsvbsvf4@fzadsvt5fl4d>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ztn47y23ctbjrbkmgyyhc6d5x3i2lzz5txotpgtbjtcsvbsvf4@fzadsvt5fl4d>
X-ClientProxiedBy: SA9PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:806:28::30) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|DBAPR04MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f41422-2fee-4899-24a5-08def953f14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|7416014|1800799024|366016|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wwen+bOcFdDhr7AWEo0oU456UZo8V5Ydijvd9XXTkOYSXwGrzoD9hN2Yv3Z3ZOPKKDX5MNi/vmpkfvAcND0u64XVjpHkIVM5XktCTybl4w/i+NbAF8I2AVh+tdXeKXHmUGI960oIpGqcYmqXD1fBQ5olGUvNZ5OAsi2xBX6zNjPRqGqlIlJ5p7bmA9NwikFkn2mc8GAfxam2OwHdfg2ZGy2lkosGmS1QDVFdhFOTT539GfdU1ZTAFtmukpZuq3qZLiFpmgtg2M5ZKX3FZoesf8YE0n38iR8fjoyA7fk6p4xwmXsSDo/bgOytLlt+npesBpJQZ1cJZngZ4HYnI/5ByItakEN+F4dPvSd65ai/7c1/+09jgwM77JdXK1Jl8zGVAWvqr/ycvF0ZqO+JJVIPu9E0W3iVYV2rmH8repAv4m8E6vsaITST5tdW0IhJ+p2JFaPt3ezLTX4nxXoQgT7qBzlCNsKEDn78BKrCyjmFQktjxpuR8oYyc6J6XfWVpMsOdx0lwU1XPpQP1/e37bPq40qjmhwBqa9KZihjEJpyTvWM676bUR7Tmw5CXG2RONtEv6eracBj9bPVwwKdcbLz8adZXe2u7avuqTFfKYSAk8SbRJpMlNYF/UL9GzjWW8tMfGlJ1NsjaD3cBJKNbqtDyDS2EOV4Pq+46pKyoUP6tgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkNRbHdMT012VGgrdHorcEdnZlFhTFZqdlNmdVJabFNRRGcremN5dFY3KzRG?=
 =?utf-8?B?R1NIdDQwMi8yTVBUWitsdFlGSTRwMGxPTGNKcDYrd2xPRzhGUjZHZ24yNU9Z?=
 =?utf-8?B?V2RQemZiU2VPVzlJM0VidDI5VTlma0pKQldGOXFiL3BHamJCSEtRWnRsTktx?=
 =?utf-8?B?akhBVzlxYk8yR0plVmNIZnd3U1k5NElvdXAxc1RMVWhrYTZ6Um9lekpoTXlr?=
 =?utf-8?B?SnNUOWJNN2NoRFQwRVdXRzIvNWpGN3EyOFBxNlFzQXFzUGM5MFJKaUxPRUo2?=
 =?utf-8?B?dWp4Z2M3bzEyNWw4aDFjUkl2TFJESnh1SFdJZW4xS1cvRGFIZ1dKUDhrdjVn?=
 =?utf-8?B?aXRoQkxJUHhBS0N3NXRIRElndkw0RFlUUUZJbldvSSs2bjJNR2c1bTY3ajNo?=
 =?utf-8?B?MnhpMkhKWjRIMTRJdk96d21EZ2JPVldKVTVUbnVFMHVjak9zc2FSS0NmK1h0?=
 =?utf-8?B?UzRSSnBKUXhlTHJrelBCblFxaHhrSmcrMXpiVTdERE4rOWZYWkhVSU9pY3o0?=
 =?utf-8?B?QlBFbm1NQWRreERBYzJVeCs0S0c3OFhOYkI4VVRadHJEc2l2bC9QRVdybzI2?=
 =?utf-8?B?cUlWQmxiQlFOQWJlTi9BcVV4N1dwajhJdlhaWVlueFVRYkljVWZHME5nb3hr?=
 =?utf-8?B?MDljeEtoUUJYRTR1OUV3cUpCMmlIckFJVkMzMHpWSGVDYmJqalpEeDB2UEl4?=
 =?utf-8?B?RXhuR25NMW05NnBuc3BGNEc2MG5Gbzl3aEJwOHhNaUp0YjRvdzd6OWdMNnF0?=
 =?utf-8?B?Q3o4c3l6WVhGaGlzVEtWL3lFR1ZORUM5ZlYwWUVVSE4yZW5LK2oyeEc1OEJu?=
 =?utf-8?B?aFB2S2hYaWNKakJncmhtVXQ5TW1DeHJ5dTZuUXVEczhyaXNEeWdCTmtOeEwy?=
 =?utf-8?B?bmEvbHhFUUhBS0t4YldnMzk5amxGKzVIWVFLRFBidmJqMEU5OFBXd3YrUjl1?=
 =?utf-8?B?NGpObVhjeXBMalZoQnFUeE45S2NySGdtaWxpbmhObVlST2lCemhnQzNRcFFj?=
 =?utf-8?B?dGRWb0Z3YnAvMTlKRDROZEVkaUppMmZMQWxYZ2lXbEdacmQ0SHN5bWN0VkpL?=
 =?utf-8?B?TGdwb09pVDRzSDhPZFQ3UGdSQjdaMFBNU2hNTVM1T1hpUTIzZzY0Sk5ONUNp?=
 =?utf-8?B?TjlrQW5JRkxqOFNQUjU3dmdWWGdsdnZxb1hMaHltaXh4RFovbXBmWFZzQXov?=
 =?utf-8?B?aWt4NUdvU3R6YmZTdzlnQUM3a2NJQ0FISzZwODBWVUFOTW9CdDVRdW14a0R6?=
 =?utf-8?B?NENNZ1lwcWxnZ2RRSDVqamRuS1pGR2hkTXVlVFFWb0dUTFIyRmlKSTh4TWx3?=
 =?utf-8?B?NVZueUN1RnVUMGYvdVdvOHVUOWpxZGRWN3BVdDFhT3ZheW5wcnJwMk9id3N4?=
 =?utf-8?B?czRzai9HeHVMVGdEVkFVZ2M0UGxMbmJyMTNkUnk2WTlNcTJsMWZSUVh4ZUtm?=
 =?utf-8?B?ekFlZTIyU3JyUDVwdGJITjBwQW1odFpRaEJTU3lTdXhQVzgrVDhranpQd0FL?=
 =?utf-8?B?R0pEOVl0MzNaS25hZ01oZ3VacmVtUGduUVVrWlgybjk3aVhqbFY3VnhxSWgr?=
 =?utf-8?B?dGpMN3VmYndobWxhalR2bzlnYjhjbEYxTlE3TkcvL3hFUWdxUFRXdThQanpp?=
 =?utf-8?B?bzFucWJqdU5INTkvQlgyRVh4QWduME4yTWdoQTlUamRjQS84cGZWZjZkRTdk?=
 =?utf-8?B?cWZUNjhQODIyNjZaUkIzVHlrTVk3cG02cjFTWDJjQUM0VUw5REMyc2hSY0di?=
 =?utf-8?B?eWlJT3U4RmZOb1dFcHpCOUZzZ0djbXZpa1BRQnpHRzdTSWdkem42eVpuczdr?=
 =?utf-8?B?N1hOZktYRVBWcjRaS0FHTlZZQjc0enRVa3JyaUpBRmlRSUtzU0lBWWs0V0xz?=
 =?utf-8?B?aWh6UmFPU3pPSzNiMy9oQWFVTUUyN2dEWVJTQ1dBZ0k1c3dSMXdBak1KZ3dD?=
 =?utf-8?B?WEVTY09lTnA3dEVlMVFoSzhnSFprRGs2WXZaNVQ1Um9rQTJHR2pkTlQvYVhm?=
 =?utf-8?B?c2R4cE11QjdNNUFHTHF0Ym9tdjRnQVZabFpwdjZnekdQZWNuTEl0OEtEaEJw?=
 =?utf-8?B?azFWalV0ZlN4b2RVMk5Rd0tic3AyT1YwQkpZQk01bnJ4WWVSOGt4YyttS1Fy?=
 =?utf-8?B?YTZlL0pCeDlTM2VtRXJFQ3EvOC9Hc09tZUVxSUdQNEJvZkRxc3hhZ1NrT1dP?=
 =?utf-8?B?TG9Vb1U4QitJazBMUWZ4UGV5ZDI4U1h6UzgxTDZpbHgrR08veW1iei91M3E4?=
 =?utf-8?B?MGlhalBzRnNzTHJBK2Z5U2lTbWZDUkRoc1BnbHo0aUM1SjRVV2xvRGt0VVRJ?=
 =?utf-8?B?UElrVkJoNWF6Q0tDdU0vZEJoVmlTekpsb3lDbU5GSVg4OHFBdUdsTlRQdEN4?=
 =?utf-8?Q?kfZwEFI8LExui0oUpnWwG3pVTmteCWXTyLa7V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f41422-2fee-4899-24a5-08def953f14d
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 16:00:06.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18Ybwqzo6XbgLlwxBfhCjSJ/7wJo0u/tLxr1EHeb+9tyYvuaEPB8cMzWqWlkS3avAxBdkPwmxp2Hr2T7l58DdcCAeu5eb1rMq1LDw8ekKvWGrWAQAImHDbTS59UHHMxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7477

On Thu, Aug 13, 2026 at 11:15:31PM +0900, Koichiro Den wrote:
> On Thu, Aug 13, 2026 at 02:50:59PM +0200, Manivannan Sadhasivam wrote:
> > On Thu, Aug 13, 2026 at 01:46:07PM +0200, Niklas Cassel wrote:
> > > Hello Koichiro,
> > >
> > > On Thu, Aug 13, 2026 at 03:37:47PM +0900, Koichiro Den wrote:
> > > > This is v7, the remaining patch set for PCI endpoint DMA.
> > > > Parts 2 and 3 were merged per Frank's suggestion.
> > >
> > > (snip)
> > >
> > > > One open question is how to support endpoint controllers with only one
> > > > PF. Keeping DMA in a separate EPF requires multi-function endpoint
> > > > support. Folding it into vNTB would work on single-function
> > > > controllers, but would also couple the two implementations. This series
> > > > keeps the separate EPF model.
> > >
> > > I see all the work you are putting in and I admire the effort.
> > >
> > > This is now v7. I think it is time that we close the open question by
> > > waiting for a reply from the PCI endpoint maintainers' opinion on the
> > > design before continuing. (I am not a PCI endpoint maintainer.)
> > >
> > > I understand that you want a common DMA abstraction, that can represent
> > > different (embedded) DMA controllers on the endpoint side.
> > >
> > > But if vNTB is the only consumer of this, then why not simply embed this
> > > DMA abstraction in some BAR exposed by the vNTB EPF?
> > >
> > > Looking at the host side driver that goes with the (v)NTB driver:
> > > drivers/ntb/hw/epf/ntb_hw_epf.c
> > >
> > > The BAR layouts are hard coded, and it only supports three different
> > > layouts. Would it not be possible to add a fourth layout that has the
> > > DMA abstraction somewhere in one of the BARs? ('BAR_DMA' ?)
> > >
> > >
> > > Right now, I wonder if it is not a bit premature optimization to create a
> > > DMA EPF, if vNTB will be the only (ever?) user.
> > >
> >
> > Yeah, I feel the same. I haven't seen an usecase to program the DMA controller
> > from the host outside of vNTB. This feature is supported mostly because it
> > exists in hardware and someone wants to tick the checkbox.
> >
> > Though, I'm not against doing it within vNTB as Niklas suggested, but
> > generalising it in the form of a new EPF driver just for the sake of a single
> > driver sounds like an overkill and maintenance burden.
> >
> > Sorry for saying this in v7. I've been meaning to say it, but somehow ended up
> > procrastinating too much.
>
> No bother. Since Frank has given a lot of feedback on this series, I'd also like
> to hear his view.
>
> I'm fine with either direction, and can revisit the earlier vNTB-embedded
> approach:
> https://lore.kernel.org/r/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/

One of the important value is test dw-edma-pcie.c, which generally depend
on some fpga hardware. If there are epf driver work as fpga hardware, it
will help cover edma remote user case. So more user can test it.

Of course, this implement are over complex. I suggest update dma-engine
chan_id to support static allocate, which also need be fixed because
some drivers have such dependence, anyway need be fixed. After this fix,
this patches will become simpler.

VNTB case, it'd better put such informaiton into one BARs and work on
single-function.

I suggest split two things

1 - create simple epf driver to test dw-edma-pcie.c.
2 - vntb support DMA.

of course, if shared efforts, it will be great.

Frank

>
> Best regards,
> Koichiro
>
> >
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்
