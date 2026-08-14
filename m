Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4D471427;
	Fri, 14 Aug 2026 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723739; cv=fail; b=oG+P2DIatIe8gkk+5P0lpa/ziB2w7vp7AZSPJNVYzdASO/wnJxQrqNILovjldT2D9ptSvksjYf8hPgOxNSByuG8P4n/01pi004lQSl2tpKS75WkhU1wJ2T3Uxbl1oN69ZNvPoMa8WweYsTDxZMSpFzKP8Pk1K4YK6/m9CwXDRco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723739; c=relaxed/simple;
	bh=n0Av9xC8g2dKe4FC/hnenCGHpGvUMVB5bGRu0mRv1Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lXu98e4+n16FjO7Q3CDarkjGz4D1OafZi+tQROJDqOcssMmx+iFi9BDh6qgElPc4wWHLh6PGPKdBiY2AcFulKJekWrGPofYN73KQHVi0dDTTTAsfBsxirQBnOcKGNKbyuaHUdNbTxyLGGajq/aaYhlE5Ad7W/bAmI2seOQ/tQpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YLqDmZ1+; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YLqDmZ1+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pscZSoiKBo8XiCfQ7e5UdAm8W8X7cr41UVwSKp3PENdvMSzjZNDTjdDxLmD+1DHRfwBFzlQmEfZgH8OfEE3tcw7f/V0fftmEVL5ixl75/KPc0oaLxsdteuVJ+I6CBwxaylcelLYFWlxOqxyapudUu9TB3PWcfKJbse6CAFH5lCPu/4IGDpolYXnV5zUROoUrh4N9ZEoAPFXOW5CKDumTmkkiOESmmYO93LITZPgx8+eauxWlJTTbbT/1YZtLakXED5HWSAaTUZIlRLRRhAAJqQEUTWTy0QJD/f2kjQvbOy1h4rI50/e8kTAI1OAl29L0GDjXiQZ+/J26jmu8v6JbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIYFTuWcetMkp02/7n8Xksd1zMNgGFujeIaX+zSNr3Q=;
 b=LH8GWOsbAbfzZn4mK9xmgfkhrRkxdsnNGYThMUFu3CLtlgK9AQI0kmuWrx5BQYRjGZOXoRc7Goy0fUsgpefN0lnBkhxUC4dZ0q7g15OxECez+y2xs6gJM7Bi07nzjnFhs0XbR0Eek5uXz4kMO144Uoso6r4MOkL/sU5eoOrvwlF+/+NQlOzQuJ1pSBHpGDMrlfWEPTmffMxcnUHQDsXmBqWkBeN2LM+QqOjTkSQKe4rJbdFI1R+ITITepg4hp4Zk5czmE3kvkhjuCi17nRoNJ4afAPiqnZKIrc/RHmFqYsyhIyIvKDsdGX6xQYbj19SYuxIMyVDMheEymVc4llhcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIYFTuWcetMkp02/7n8Xksd1zMNgGFujeIaX+zSNr3Q=;
 b=YLqDmZ1+aatomrSNFL0yQ2BeQqiHZzps9U+6z7hnylO3h/PnnnB1Hb7mWukwkjJ4lgoRvkasBuPB2eMaTvcyQhhNoKSTIdeyd2rboSUYir4PLK6gUhq64WTOi2mko4tjROI9Swns0rkORLmfUwA2Y9Ek6jc8PUiMbuxaCg2+kedkBp4Y+2LjhEKk/OxuUkRRZwpAzwhJfeOUx0nzZ8VYwaAlu51YaXE9UN8dVII0cdxcCFuLfpgztW0Q8+diTsI9vFEQogtL1yiYTM2xaiOAVLcjclzW7691+QoIUtbv0upGZNaNR18YPXZb9yyrWnpEco5ghspeDMb8NPDcRFYiyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 16:08:48 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 16:08:47 +0000
Date: Fri, 14 Aug 2026 11:08:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dmaengine: dw-edma: Add DMA_SG support
Message-ID: <an89hXJm2wY8Owry@SMW015318>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-2-c12bb05e42d6@oss.qualcomm.com>
 <anTbNsOQ02V6umXf@SMW015318>
 <ye4bue5a2uq65d5befelyhs3cbezpjytbni4mtnge42ijmaqny@3bijtktlvyrj>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ye4bue5a2uq65d5befelyhs3cbezpjytbni4mtnge42ijmaqny@3bijtktlvyrj>
X-ClientProxiedBy: SA1PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 386df9ff-af8d-4c02-2899-08defa1e5212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|23010399003|18002099003|56012099006|22082099003|10067099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	iZEDBhJ87OMPtnJx635d/91ceYFeMkjF4BEi7ooJSseOn1fx2EwYk8Sr1wYK6B2b87OiR28FqEK0Rfs+QDLnQm2LCkKo3lYM+/qWpBI+sZSTtquatrvCqUHOwMkMn94heHtezxD+17RWtZVP1hsnJ9Pa2TFdFMkDp1DYkCfRasw4EVsiDRvlM2ayNnZUr/hwj2ZT4qbZ080+RwPf94rCXFYFayyz/Rl4EOTu4e47qlgGgTg7SYG1foC5EDw76fcF+1X7DSfxisGap7ZQIKmyqO93/pn1HqWR0zclNRXugqJV9EHzgwdFbH3NvGGjoCByUXNigar/C3PhAQgAJAjOR8oj2RJR/qDTKzuNANyzw63dP9mvGW0h5J8cbaCYuo8Zn7ku+rwQrUe7pTex49HGfuv7zcwssw38sMMS8P9p+5tP35rvjac56ME+eCHct3FTRSBaaEPp8gjaEx4TXUdDLTw9gM3iXbDtYhbTncEMtUTP6XoBUMhSqhSmP1EYWQ/Y6F8kl9as6tUPnuvz2Tw5m8Yln1yDxSU6da8UkUFbl4i4HLQI0V5ALBBXgfhufGBGFzXwBs8bByIeSL3g2Kgm6HzhfHKoa+AUztMXXZs4qNPVaTx0XJ/KnpcOAq9UPM9IdE+RBOub1DrRKYp9W47GeKKjfIGN+I12VaQVhxUHVeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(23010399003)(18002099003)(56012099006)(22082099003)(10067099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3ZNQkVzUTBBVzB3V2R3c0s3Sjc5eU44ZEh6TmEybWtFbDh4UUFEcFo5Vkov?=
 =?utf-8?B?bjVreENxRzBpek1pT05VRkxZckRnMDVFYUl1Yy9ZTE1XbFZrVGo4OSs4eVd4?=
 =?utf-8?B?MjFrY2U3VzR5MVNOY0N0bUh1Z0pxT3ZYREhpUzBhQ1h0ckRaN3hHekZXVksz?=
 =?utf-8?B?Q2p0VFNtK1RQbno3Y04xMHlqbDZubzRxdGRGV09CTDdtOWVNalMxczB3SjJX?=
 =?utf-8?B?bzF4NW5yc3RLU0FRNFp3YVZBUDNuZzdqd1Y2bktBZHNURUM5VWpSbG5rYXJj?=
 =?utf-8?B?UlpaTWEvb1hWUGFMZ2VMMkV4N0twMGJmOXhWWHJKZEZ6MTBlTE10UDY5cFVJ?=
 =?utf-8?B?NkhIcmx5VmQxQTNoNzA3cjRGSHhQdDZoK0pBcmczOHJPejRjT2dmblBRVG8x?=
 =?utf-8?B?REcraUJtbitDeDZVSjRJeXlzTUNHSWhwbXJBVktxMzJZb3g2VFRjL0ZLY2pj?=
 =?utf-8?B?aVlvUlNpN0ZDQ3BpQVJWeTFBTjdYKytIV2hHQlJjMmRZOGNFUzVaT29tcjF1?=
 =?utf-8?B?UHdDTU53eSsyNE55S0pPb1pZaWdvN0xtTU12YVRKSTRmclMxOVBJUnUzTzZD?=
 =?utf-8?B?MFRVL0VYUGozQmU3dmxUcGdmejVXMlVFOVYyVDJHemsrMDQ1aHFQL2dPdkV4?=
 =?utf-8?B?Z1l4NXB3NDJUc2Z5RnZMNnZUTzFJNi9zNVU3TS84RDN1cW9qWktLU1lBdnNl?=
 =?utf-8?B?K1MxdjhYTzV6SWI0Q0hxc1hFSUFBZ0prSHFwaDZwR1Q2eEFBd1diNEQraXhv?=
 =?utf-8?B?Z0EvamM4VnJDOGNXMUhSME1QcUs3RnRQUHA3QVBGdnduYzUwcldrbkllTlVF?=
 =?utf-8?B?QUxFQ1UvTDNhazNsdUp6b3QrOGtKdGNZTDZrb0hOeGN1L2dtYUw5S1M1eGFa?=
 =?utf-8?B?MnJBU2NvaHFaTkhKdEw2VGF6MlZSOHdVbi92M3ZoaXlCMnh5b092V2hMOGJJ?=
 =?utf-8?B?SHpXVld1cmZWbFltRFFJcm5iVVVLaktJK25rT0JIditWdDQ1NndnRFBVUFg1?=
 =?utf-8?B?WWI4a1d1VEtJRGNEdU1YWDRLZkI2dEQ3T1N6MExwZFFRaUF2UHRRSVI4bERI?=
 =?utf-8?B?eE5lRzhCZ0xGS1NrVkNzNUg2U0RBL3Q5UElwSGVBT2xqclFDMjZlb0tCeXd6?=
 =?utf-8?B?Y2JpdmhrQWdUTEgxcVFacklXU0JZQjM0blV1Wnd2UkpyaHFYTmdiUTh5NklW?=
 =?utf-8?B?Um50ZU90NGxzL0FpOEtESEdtY3JSWW1QQnJMQ1B5ZWtyYnZxRm5yNVFlZkdU?=
 =?utf-8?B?OXVpWXR0NlEzMS8yRlhWVTlhV0hidktQdE1lVTBJOTg4QmxvQ0V0aXRPRWdq?=
 =?utf-8?B?SWxNM3VSdnAwV0tFQXNLc1hIZVlYWDA2QU5WUXVXU1hEam5wRS9vRVFSVlNa?=
 =?utf-8?B?Uzk3MXBNTWJrdVZqNFp6eTZCc1NadnJGeFpscTVNZ3VUQkVUNy9oTlJxSE5h?=
 =?utf-8?B?VzJxZUtGV2QvYVltbjZ3akFmektPUlBNNXk4TGxLTzVYeWo4RG5pSWZ3NEhS?=
 =?utf-8?B?VlFsekRSNUZDbXZPZHVnU2FVZTR1cjU0UlVKYnA4elV3TVloay8zMlYrK0xa?=
 =?utf-8?B?S1U4K1VoQkI4RWpWeUdvYnNnY256Ryt3amY2N1pzZHhNUnpPWDhHdlh6TUpy?=
 =?utf-8?B?ODJKbnAyaHhBVmRxQll2SjJNQVFZSVRxMVhLUExJOS9RdTlHQzVwWE5LcE8v?=
 =?utf-8?B?UHhUcVhOcHhNZzB5aGYySE5BUnhMeTJ1UStzWllZSlJXZzFNK2tOUUNGTFpU?=
 =?utf-8?B?cG5YUVJVRDNNTFpJc3NvZW4zMkxnTEhySFFkRUVUcFBmSGx0OU5IaXczZnVU?=
 =?utf-8?B?ckhxTmwvRFRSMjNkTFQzVG1SSmVlQW1qNFRqRUtCc25zZWJFbFk2TWxFcFpD?=
 =?utf-8?B?MTZ2bm9nTUUvak1uK2FrNUptVDdKNGxwK3FKL2Z6L2s4TTVRdUZoTDFvL0wr?=
 =?utf-8?B?Sk05SWhKOEYxK0RJTDhPVzhDZWt4d0wwbm41Y3EwK1p4MTF6T25ySFkxVE1M?=
 =?utf-8?B?WTROSkZuYlVJSnArK3grWGt3eXdSRElRZk5KOXRCUjczKzB4Vmk4eVB0Q2pi?=
 =?utf-8?B?YW1sRThaR29YWFowRHRLZktjbnZ3STczdi92NUliZ3BEandZVW5ERmlzOXZ4?=
 =?utf-8?B?MzdCNFl0SjM2QSt6c1hMWE1HSUsxaXFqcDlFR1lNNzB3czlnNVc0eHM3Ykxu?=
 =?utf-8?B?NWJNU1VIRVFObHBGbjV5cmZGWk1tN1J5dHdtRExOM29ZRitrb01Gb3FHaGQ0?=
 =?utf-8?B?UWVRSHNvanZlZjZYZXg4QW81MnRlQjJtWUx4ZzhPbTM5V2pTQmNsUVl5cjdL?=
 =?utf-8?B?R3NjY3crSU1aUG0ydEhpYnYzZ3JMdUs0R2w0NGNSc0J2ZnQ2aHlrQVdIcit4?=
 =?utf-8?Q?m1I3Aui8f/mPB3xVqPUM7QI5kK85SFXc12wep?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386df9ff-af8d-4c02-2899-08defa1e5212
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:08:47.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFF9HVENKFjOkAHT6YC0FnEyn3zTMZmTiuSw8U5V1v9cvqHWM1P5iXdNZ160dEA0XIBq95FXwiZxHLABLvh/fkOdZ5sxdlRPhPhg4eF9eq29XIqbb16+a23VSsilS5zV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451

On Fri, Aug 14, 2026 at 03:58:48PM +0200, Manivannan Sadhasivam wrote:
> On Thu, Aug 06, 2026 at 02:06:30PM -0500, Frank Li wrote:
> > On Mon, Aug 03, 2026 at 04:01:44PM +0530, Sumit Kumar wrote:
> > > [You don't often get email from sumit.kumar@oss.qualcomm.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > Synopsys DesignWare eDMA supports a linked-list mode where each list item
> > > carries independent source and destination addresses, letting multiple
> > > independent memory transfers be described in one linked list and submitted
> > > to the hardware as a single DMA transaction. The IP processes list items
> > > strictly in order, so paired scatter-gather entries are never reordered.
> > >
> > > Implement the DMA_SG capability by adding a new EDMA_XFER_DUAL_SG transfer
> > > type and a corresponding struct dw_edma_dual_sg carrying the paired source
> > > and destination SG lists. dw_edma_device_transfer() walks both lists in
> > > lockstep, building a single hardware linked-list; a per-entry length
> > > mismatch or premature list end fails the whole request.
> >
> > It is not as simple as it.  for example, if you want to transfer 9k data
> > from src to dest
> >
> > src virtual addr 0x1004,        dest 0xA0001008
> >
> > when map_sg, src's sg maybe
> >
> > 0x1000  .. 4k   offset 4,
> > 0x9000  .. 4k   offset 0
> > 0xA000  .. 4k   offset 0
> >
> > or
> > 0x1000 .. 8k  offset 4
> > 0xA000 .. 4k  offset 0
> >
> > which totally depend on physical address allocation although most likely
> > first case happen
> >
> > dest sg
> > 0xA001000 .. 4k offset 8
> > 0xA008000 .. 4k offset 0
> > 0xA00E000 .. 4k offset 0
> >
> > descriptors
> > 1 	transfer 4k-8
> > 2       transfer tail 4 byte
> > 3 	transfer 4k-8
> > 4       transfer tail 4 byte
> > ...
> >
> > the start address of src and dest is highly possible differences. So it
> > is very hard to match your requirement, both sg's structure is the same.
> >
>
> That's the API limitation, isn't it? The callers have to supply the same length
> src/dst pairs to work with this API. But they don't necessarily need to use

Define API is memcpy, not memory to peripherail Or peripherail to memory

dmaengine_prep_dma_sg() - Prepare a memory-to-memory scatter-gather DMA descriptor.

Most memcpy user need call dma_map_sg() to get sg.  And most likely two
virutal address offset to page is difference.

So most likely return failure by this API.

What next, if failure,  fallback other DMAengine API or return user?

If fallback to other APIs, code logic become more complex. If return to
user, user will be strange why failure at some time, but success at
some time.

Frank

> dma_map_sg() which can provide fragmented mappings as you described. They can
> use dma_map_single() or even the bus addresses directly as the MHI client is
> already doing.
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்
