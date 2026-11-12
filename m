Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794506633;
	b=W3Wsi+b28EGoYpoSMod2qA5HYlUZrTgT+XRE0rdQ4CL/e75ngpnn9C4P/SzqEeHZ35kB
	 mzOezc+ls9pvqlDwPhkAUJwSzLd2H7OrAjhBbJgSZDIeKDNKym1Y+9CNuM35pGVMLaDEC
	 KJFOJ01FDdAbJKDtnTIX6tLwceRAWsul2VFeDrmoblYjgnIswmjvvbC5ZFqd397iQvTGD
	 Vlap8QIbNF4boP6F9jHzd+e43M6TX+1BjbtpsQwqZ0vqDlehZX3Zd7UZVqfoa7AQscycz
	 +TepLnbcP80Zkc6LIbuzbsWnLrNAemgmu3OPLPzQFS1uHKOro1hiYublhzLMQVQX2mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506633;
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
	bh=MPE5gCb55qQobPSrPrZDul3kzNDK5TGXNK80dY6uZDA=;
	b=kfVRxp4Bc7Mfqd+qZgVS6OjxAEq/0zUCnSlh8XLJ/2U0wzwLoRsMMucMzC0gbUEJZEat
	 381GvDUOBgQkUoLQVg9vzMx3iYl3ZSuXdm7KTsgo2Dx1lIYjafNEL9balDRyGytUzEj1x
	 kCmeEM6066g9LeWFYxcswcroIgbKaVnEBIRJmxMPcQsGBTg9j5Y5dPacwNG6CAZP+3SjR
	 e9qz2LTuW4RsFRFTURtXP7OmU04BbiVPHINRebQPcNKqJmMFMYlWrEOel7SSrB3xNr+Ez
	 NN1lLPGu9Dml/3Wg/n0mi1PRGQ55UeQRtavA86qtYxuQGeDb12W50I9eC1CB3TbkiwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aBkooni1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.67
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47432606A8A3;
	Thu, 12 Nov 2026 18:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47432606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aBkooni1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/8BC60+qxOVkxu7tajOcOritMdnlZxvevSCsbwbxlg+WcjSABJsXWsut3iUy8+5w7DH6GqCTDoI9hmI1PHEeCSer8wRywBhNLFJwpPqRjCd5+epTJaFudOsR9nt9bo/ctbD3iFOw1YzWa+gc5fAqeSg2K2tVWcAQt/Jst0PRxD/7fSG5GqMy3VjfyjgpYrXkqxLfOz7fjHGKdPP1PnGksMUvN807mWPx7CnlBI+eL/YRr8jPBbj193akj36No8BmBlj1ty7fb/+tF/OeJMwinELw42tCn+sknkVuhoH/0mNfsi94qREjRrNyFMydbRSU/owMtpkjQd0pQvo4nY3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPE5gCb55qQobPSrPrZDul3kzNDK5TGXNK80dY6uZDA=;
 b=RePogW/znXxxnKKCYrs/+oKUKSclT/NEWdnD+zfoVzHOi5FYhYLK6Qtc07tB+5YtievuGDugMuFaYjkpGjQDDMVWGBnR4acEygQAiE2A4EjeF7CqFO3v89u7G2NNZ0R1Yl2ahCnFnM1I4ZFfMZ4fj3qPVHY8CkT6/CnSjl1RwrvlqgZ7b7hVasE83kbAWeH2TKvqN6ps89S7Z12HV96mAiGKI7tBF1ja6G+SkG45XEgrY6VQJJ/q9lFZxADLEmY7RUJKZBSOkKq+FPHuf8x+69mjrDprUsYVcnN4dQjlVO76TblZ5DgrMfn1tGydcOs5MjjS725mjvax93CyqPulCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPE5gCb55qQobPSrPrZDul3kzNDK5TGXNK80dY6uZDA=;
 b=aBkooni1IgE0Kzw0VVF6KakmnjlUCTXRGbEFHbnsM33AOeVcCgMi9/qOAEHMWK0iU2jUIU4IXPNhn0zMKVjFJa31cHbalhS6HjFQGLsoQPp9pNPmHx4whv4JQ6e3Xb2ECa8IwQs/unZCE2Y7NbxqfJ+ntO3v4aJ4QVKlDzeE3ih8VH2twhdEj6uQEncUfJjNcJEqwYX60XrD819bsG2AqEQqr2Q94nsRp9iL1VChW6DtmoKkXw8WTNNcrd5MjSs6fh76+PRCGkTvnJJg7fuMGcyMgI3AuM9eP2J1PS4+TtEjsQhkSPAaF9wWNDUxgNGdFM/CO//I5jQij+GN9I3q5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BR2PPFB8F05BE80.eurprd04.prod.outlook.com (2603:10a6:2d0::d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 17:58:49 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 17:58:49 +0000
Date: Thu, 12 Nov 2026 12:58:11 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 4/7] dmaengine: dw-edma: Reclaim LL entries from
 hardware progress
Message-ID: <avX-M0740VZFR0Ic@lizhi-Precision-Tower-5810>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107133027.364237-5-den@valinux.co.jp>
X-ClientProxiedBy: DM6PR07CA0115.namprd07.prod.outlook.com
 (2603:10b6:5:330::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BR2PPFB8F05BE80:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e667499-4da7-485e-f669-08df40e69a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|6133799003|56012099006|4143699003|11063799006|5023799004|261102123227099003|261022105027099003|261022075727099003|261026140227099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	R6x03xy8yF5jCLmBDtAbB6SkxTBX9sf53fGgBSdvI442QdxaVjahJc/LljZ5gA9v7ke0N1JA7jyFopS7/n5pkf2/eS8nHB5WC2u+1H7Y7taeHrFDN6Zm1ZgmxIPN9Vg1sA1tXziRrNrwxcF0iVCPVOpkUAXuMwVk6ARtKU7qRpFiMqjITrLoTnpgpoBXGJ+WeFnjqBgU1Z0QJi2be9VJUH53bKMU7j8reP4F/efhdusug36MXnGAxCuxRIp/kc8taOCP9ACGch9omqTtI6xV71BpO7qZyGg5sozBSH7m5PmbEWQxThxFxyNerbcgPLI1H82zka610pfDfXklTCG4zuhanq5FODjsPmxTZS1q59EmHfSGVEAHv0H+1Opoz8WI+29cN/2oQlpyWb0p0F1410/JPeqDrpEJQoVlACIJSvVIBsyYaedLYXLA6lco07fnVruIupsMFXzZLxLEWzUYZ8TZUmOYAb+1cG5Gt2BylcYaVt5IzoFPhrgkNEAJlYjl5xzJY3NCQ6TQCLELTHLIlxAIXztsiZ04uPEWeuKLzNpd8V3P6ZqjwY8dwZRyIsbzB1vMUr4wn53ro3YUvujpS/jy1yRE/sgNy+1ONqPPWyCfoe5bPkMbCN2pzVF62WCJ+IypyocDtThRNrxqjB3awE6/qyWbDbBCzwXAkFh66Lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006)(5023799004)(261102123227099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bpD6QblJG5fRDfx9DeYZPwwwDKBNrSC1gPxDFETvICWCTStmITbhjNBHA1pO?=
 =?us-ascii?Q?ggBUdJJN2HszX6W5FG5ieAFQLilbBvv5Hyq6ATBwF19CAX0DZ1EulifZRasQ?=
 =?us-ascii?Q?CEpdsKNygEIhf8N5boo8Br+3ToU2Ap8gL+AtbVb3DggBKfum8mZZI4ee5530?=
 =?us-ascii?Q?iXyo6E1yZSLCwxXdfzEqCIJDi/ihX2oxrb3fIYWrlwXsbP2jTZ1c/Vb2wUQ0?=
 =?us-ascii?Q?Kffs+2BbVh+DMzOFUqI8MbJ4ZC/G7V+gHT+YR9tVLQMQ1Dm/IjLLLufVWErV?=
 =?us-ascii?Q?tgtZsScXSZdOCjhBj0cbIM64UYO+R50j8DulBrUapUJrbEz7SUb4lBKfrlb3?=
 =?us-ascii?Q?Ri1ERRFCVhudrNHhf7zL1GOsiksInBfpA7vwMWvWOZU7OcjXhN0n6BqE+8ud?=
 =?us-ascii?Q?au51JnN2guualNnSyQy8KtbfvLaxL63FYeBuX9+n25CKNLu+4ungTmGjU1JQ?=
 =?us-ascii?Q?YgyICBEO4Tm7/GIr2zFnh9dN9vdWWMsQHuTCPgvza6GFsDkafaoxgEd9eIwH?=
 =?us-ascii?Q?scKGwmxG7CQwoO5Lkf2Yosc2h46OFSjrZgis6LS/Kv8tRGXP57ng7L9fJAeA?=
 =?us-ascii?Q?H8fwtKdg97VfjI2A0Ugg5uez6gnKcbdgtl8Lu6GKmUJ62HB1sZGc6ShNGoFd?=
 =?us-ascii?Q?jUJyeyA1rw+EBskX8w4fwL/yrr23sWUAXtvjqHyDMeFh4vbn36skvTyLCPjN?=
 =?us-ascii?Q?WlB2Yee2DGIwgEClyewHoCgwMoQ4Hg0XbwykIWw6RaQNgcYsQdA1k5Pa7MnW?=
 =?us-ascii?Q?/pVB3743dAPue+OFtSJvVsB13gqIJrR0OkeWiXNoso9yDppwwVYc+5Jiwkqv?=
 =?us-ascii?Q?HR6sGTMpDM4MTAdUoVNczlwljAJS4Iqt1ABeZySt0glNZcnTzpxQf9ZrOTfT?=
 =?us-ascii?Q?UsqYPn7ZShXDhYwuhZM3pXzQImdSrhy8PFrHM5mVtKh2XXG3SJonHb1bRzrr?=
 =?us-ascii?Q?zY6wJaIOQEzW/9QgmCRjFBzBp8ir9C/dD/0TuKgnDP7UaKps+UYo0ryvobg3?=
 =?us-ascii?Q?HJFloNxTnGf+43KTfBsMIeyYenRiKCUFwTNvJsy1NEXRlkZS0yluf5qc3cX+?=
 =?us-ascii?Q?lxyzOAIp4gna4145GH+EZVyTIfrOrYEuLtwSK/YSM40S9WIMUloTYAEnAxvL?=
 =?us-ascii?Q?EDRJ2OnRSxf7OGISAEjgenjfDQSwDpt+NBD0rE4MSgXy76SBEEsKdAEX0gjf?=
 =?us-ascii?Q?JNXC8A/E46QlSZGE3QmJELaDEVsGW4e5GwvdAATf3REKSJTVD3BiKmsh7CwY?=
 =?us-ascii?Q?wYgv8LeNM3MCd4stLM+8r76Cb6vnRnINL2DVjb2nhqNH1bNsffscBd5f5Rz3?=
 =?us-ascii?Q?zFMuWjCorgHo+zMf5XanoX+/A7ClZYhIjUUzk1WWLNallZuf1bVAxxHrZ0v+?=
 =?us-ascii?Q?gu60pQTkK6LXK+H3rHSXko4MS2dcGpSAhg24hqV0vMFw8XiwTXqwOGXGXm6o?=
 =?us-ascii?Q?GnqSSfAYbzq0DluQg+LvHbpDuNf2G2j/ivaEKlAx0ZyvmA57xCwZHEiRKLk0?=
 =?us-ascii?Q?WK4hj5Ww4OoSKVJqKpMhy56CimfjAKj9VymDcg5qaFKj60hza4awpeXVPuJF?=
 =?us-ascii?Q?GROVDLbRLD8btUG2JqgIRXc8KhsegbhX0IiKJi28FI0Zh6EGU9+q5uOy2HFV?=
 =?us-ascii?Q?jiaLviNjYIFhgetih+61BxKSuWwyKit8ZGL1XR9J5cHT7IWiGXns+VGbUKu7?=
 =?us-ascii?Q?yRdcSGdHS0LR34jodH/pY6bFRtd0JgN8AGBK8sOgxkndHvbzAwhD61CEhbuS?=
 =?us-ascii?Q?2rsle8x6YFVv4qoNq2gAFciLUDLmzQXXdyQqfksS4gM8IXKYj2/+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e667499-4da7-485e-f669-08df40e69a89
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:58:49.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MGJwZiruFPMK+Co2wvOcxUKSjbkmqExp0j7R/BFWeG+d2Qr9v9NFznGEo0dILFyegKeXnMIEr3bqBb5zWCIjwZVY7+whQoepBMC+nOJRAKkQLIzcshqeP6X4BRgW1t+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PPFB8F05BE80

On Sat, Nov 07, 2026 at 10:30:24PM +0900, Koichiro Den wrote:
> With dynamic appends, a DONE interrupt no longer means that all
> published LL entries have completed. Prepare for this by using LLP to
> advance ll_done and complete descriptors in issue order.
>
> Reclaim completed entries and refill the ring as space becomes
> available. Restart a stopped channel when published work remains. This
> also allows descriptors larger than the ring to run in batches.
>
> Hardware can keep running while the driver handles an interrupt, and
> LLP does not always track payload completion. Use the following
> exclusive completion boundaries, where idx is the raw LLP entry index
> and prev(idx) is the previous data entry in the ring:
>
>   State/event          Meaning of raw LLP               Boundary
>   -------------------  -------------------------------  ---------
>   eDMA/HDMA stopped    Next entry to process             idx
>
>   eDMA running         Observed to advance before        prev(idx)
>                        payload completion
>
>   HDMA watermark       Inclusive LLE recycling limit     prev(idx)
>
> A stopped sample requires CS=STOPPED and a zero transfer size.
>
> While running, HDMA updates LLP only at watermark events. Its documented
> recycling limit translates to an exclusive boundary of next(idx).
> However, tests using that boundary for dmaengine completion reported
> IOMMU faults on HDMA 6.30a SpacemiT K3. Use prev(idx) for both engines
> while running to keep the handling simple and conservative. Entries held
> back by this rule are eventually reclaimed on later progress or a
> confirmed stop, where idx gives the exact boundary.
>
> Handle termination and pause as follows:
> - On termination, stop publishing new entries and drain those already
>   published, restarting the channel if needed. Terminate descriptors
>   without callbacks, as in the non-LL path.
> - On pause, stop publishing new entries and enter the paused state once
>   the channel stops. Keep unfinished work for resume. Reclaim delayed
>   completions without restarting the channel.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes from v7:
>   - Read LLP before checking for a stop, and use the same sample for
>     completion and termination (Sashiko).
>   - Reclaim delayed completions while paused without restarting the
>     channel (spotted during code inspection, not observed in hardware
>     testing).
>
> @Frank: Dropped your R-b due to the changes; would appreciate another
> look.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 160 +++++++++++++++++++++++++----
>  1 file changed, 140 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 346ec8ee631d..1d13a25663ef 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -53,13 +53,6 @@ dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
>  {
>  	struct dw_edma_desc *desc;
>
> -	/*
> -	 * For now, a descriptor that does not fit would stall the channel
> -	 * forever: reject it up front.
> -	 */
> -	if (!chan->non_ll && nburst > chan->ll_max - 1)
> -		return NULL;
> -
>  	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
>  	if (unlikely(!desc))
>  		return NULL;
> @@ -181,18 +174,83 @@ static int dw_edma_ll_read_idx(struct dw_edma_chan *chan, bool *stopped)
>  	return idx;
>  }
>
> +/* Return the first entry we cannot reclaim yet. */
> +static int dw_edma_ll_boundary(struct dw_edma_chan *chan, int idx,
> +			       bool stopped)
> +{
> +	if (idx < 0 || (u32)idx > chan->ll_max)
> +		return -EINVAL;
> +
> +	/* After a stop, LLP points past the completed entries. */
> +	if (stopped)
> +		return idx == chan->ll_max ? 0 : idx;
> +
> +	/*
> +	 * DMA_LLP can advance before payload completion. Keep the boundary
> +	 * one entry behind it, wrapping at the start of the ring.
> +	 */
> +	return (idx + chan->ll_max - 1) % chan->ll_max;
> +}
> +
>  static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
>  {
>  	bool stopped;
>  	int idx;
>
>  	idx = dw_edma_ll_read_idx(chan, &stopped);
> -	if (idx == chan->ll_max)
> -		idx = 0;
> +	idx = dw_edma_ll_boundary(chan, idx, true);
>
>  	return stopped && idx >= 0 && (u32)idx == chan->ll_head;
>  }
>
> +static void dw_edma_ll_consume(struct dw_edma_chan *chan, int idx,
> +			       bool stopped)
> +{
> +	struct virt_dma_desc *vd, *_vd;
> +	u32 done, used;
> +
> +	lockdep_assert_held(&chan->vc.lock);
> +
> +	idx = dw_edma_ll_boundary(chan, idx, stopped);
> +	if (idx < 0)
> +		return;
> +
> +	done = dw_edma_core_get_ll_dist(chan, chan->ll_done, idx);
> +	used = dw_edma_core_get_used_num(chan);
> +
> +	if (!done || done > used)
> +		return;
> +
> +	/*
> +	 * LLP may still point to the first pending entry. Subtracting one
> +	 * can wrap the index and falsely mark all pending entries complete.
> +	 * Reclaim them all only after the channel has stopped.
> +	 */
> +	if (!stopped && done == used)
> +		return;
> +
> +	chan->ll_done = idx;
> +
> +	/* Match reclaimed entries to descriptors in issue order. */
> +	list_for_each_entry_safe(vd, _vd, &chan->vc.desc_issued, node) {
> +		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
> +		u32 consumed = min_t(u32, done,
> +				     desc->start_burst - desc->done_burst);
> +
> +		if (!consumed)
> +			break;
> +
> +		desc->done_burst += consumed;
> +		done -= consumed;
> +		if (desc->done_burst != desc->nburst)
> +			break;
> +
> +		dw_edma_complete_vdesc(vd, DMA_TRANS_NOERROR);
> +	}
> +
> +	WARN_ON_ONCE(done);
> +}
> +
>  static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
>  {
>  	struct dw_edma_chan *chan = desc->chan;
> @@ -221,7 +279,6 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
>  		}
>  	}
>
> -	desc->done_burst = desc->start_burst;
>  	desc->start_burst = i;
>  }
>
> @@ -330,6 +387,61 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw_edma_chan *chan)
>  	dw_edma_core_ch_doorbell(chan);
>  }
>
> +/* Must be called with vc.lock held. */
> +static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
> +{
> +	bool stopped;
> +	int idx;
> +
> +	lockdep_assert_held(&chan->vc.lock);
> +
> +	idx = dw_edma_ll_read_idx(chan, &stopped);
> +
> +	/* Terminate without scheduling completion callbacks. */
> +	if (chan->request == EDMA_REQ_STOP) {
> +		if (!stopped)
> +			return;
> +
> +		idx = dw_edma_ll_boundary(chan, idx, true);
> +		if (idx >= 0 && (u32)idx == chan->ll_head)
> +			dw_edma_finish_termination(chan);
> +		else
> +			/* A newly appended tail may have missed the last stop. */
> +			dw_edma_core_ch_doorbell(chan);
> +		return;
> +	}
> +
> +	/*
> +	 * HDMA updates LLP at watermark events while running. Use running
> +	 * samples only when processing an LL interrupt.
> +	 */
> +	if (stopped || event)
> +		dw_edma_ll_consume(chan, idx, stopped);
> +
> +	/* An interrupt may arrive after we have entered PAUSE. */
> +	if (chan->status == EDMA_ST_PAUSE)
> +		return;
> +
> +	if (chan->request == EDMA_REQ_PAUSE) {
> +		if (!stopped)
> +			return;
> +
> +		dw_edma_set_request(chan, EDMA_REQ_NONE);
> +		chan->status = EDMA_ST_PAUSE;
> +		return;
> +	}
> +
> +	dw_edma_start_transfer(chan);
> +	if (!dw_edma_ll_pending(chan)) {
> +		chan->status = EDMA_ST_IDLE;
> +		return;
> +	}
> +
> +	chan->status = EDMA_ST_BUSY;
> +	if (stopped)
> +		dw_edma_core_ch_doorbell(chan);
> +}
> +
>  static void dw_edma_device_caps(struct dma_chan *dchan,
>  				struct dma_slave_caps *caps)
>  {
> @@ -514,6 +626,8 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  		err = -EPERM;
>  	} else {
>  		dw_edma_set_request(chan, EDMA_REQ_STOP);
> +		if (!chan->non_ll)
> +			dw_edma_ll_advance(chan, false);
>  	}
>  	if (chan->status == EDMA_ST_IDLE)
>  		dw_edma_set_request(chan, EDMA_REQ_NONE);
> @@ -798,7 +912,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
>  	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
>  }
>
> -/* Must be called with vc.lock held. */
> +/* Non-LL completion; vc.lock must be held. */
>  static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma_desc *desc;
> @@ -817,11 +931,8 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
>  			break;
>
>  		desc = vd2dw_edma_desc(vd);
> -		if (desc->start_burst >= desc->nburst) {
> +		if (desc->start_burst >= desc->nburst)
>  			dw_edma_complete_vdesc(vd, DMA_TRANS_NOERROR);
> -			if (!chan->non_ll)
> -				chan->ll_done = chan->ll_head;
> -		}
>
>  		if (chan->request == EDMA_REQ_PAUSE) {
>  			dw_edma_set_request(chan, EDMA_REQ_NONE);
> @@ -837,14 +948,12 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
>  		if (!vd)
>  			break;
>
> -		if (chan->non_ll || dw_edma_ll_drained(chan))
> -			dw_edma_finish_termination(chan);
> +		dw_edma_finish_termination(chan);
>  		break;
>
>  	default:
>  		break;
>  	}
> -	dw_edma_core_ch_maybe_doorbell(chan);
>  }
>
>  static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> @@ -856,6 +965,13 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  }
>
> +static void dw_edma_ll_interrupt(struct dw_edma_chan *chan)
> +{
> +	guard(spinlock_irqsave)(&chan->vc.lock);
> +
> +	dw_edma_ll_advance(chan, true);
> +}
> +
>  static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  {
>  	struct virt_dma_desc *vd;
> @@ -884,8 +1000,12 @@ static void dw_edma_irq_work(struct work_struct *work)
>  	do {
>  		events = atomic_xchg(&chan->irq_pending, 0);
>
> -		if (events & DW_EDMA_DEFERRED_DONE)
> -			dw_edma_done_interrupt(chan);
> +		if (events & DW_EDMA_DEFERRED_DONE) {
> +			if (chan->non_ll)
> +				dw_edma_done_interrupt(chan);
> +			else
> +				dw_edma_ll_interrupt(chan);
> +		}
>  		if (events & DW_EDMA_DEFERRED_ABORT)
>  			dw_edma_abort_interrupt(chan);
>  	} while (atomic_read(&chan->irq_pending));
> --
> 2.54.0
>
