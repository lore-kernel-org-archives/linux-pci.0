Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793813387;
	b=txiKDWe++CYNzPGMlE/elE9bR3nDkO8JRL+eTEvpu0kyHtYuuZbS9YK1t1arnIUQ5aEW
	 tQirdsX9s+bLkN8M6VF1Ig8RZ0RE/3foVF3z3ZA0/mbyHkDpuOnoPX6JOrLJcgHMkFjNe
	 PHsx4Oetar0ZiyIly18WucomLnqMCql/QN2yoHggF9rvH58IwVRiPVxOxzp5KfRsSEiAY
	 vrejQoVRul6tx75eiQcc1pNbF68QfSFMb7w4zL4RBdhEf7wTyMY2r3VfZ3tlf+sHUkzdL
	 vZfdfJzcISZAmMzh3o6yohWtzZ36XLbhNr6qR8pnrUO70HdI7aC9LEN1efy4ohWaUyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813387;
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
	bh=0iFNJZM2JSuezmZ4rF8EsBnTQkRxBUqSwU676E3j/z8=;
	b=D4+RPAbkW8gvu9GqZR2kn1ElyHP+se+Rlno5F9KL6X7klzD0a9U6kGzgyeqOWVy0+dXM
	 RgcoXo5Q44L7lsaGDxLIInUHPQa192cIqh6GtJbLl8RSeNSesSjLazTdlxW2CnfzegMLZ
	 laCy+FT/XI9/gQ260hQlUR2YLrD7+tcToGQTPmUqAYC/yoTd9AiJEI3niw0706l3xgS/8
	 Y0G/qDIDBZUHg/CYzQkh47gMfRM1PqxBdNDgxPzktJuOlpMdo8/bKpxkezxsVey0rT1MN
	 Bfetgq+UFfe69qntg37L2+fWh4u3b5WAIxso/i5qdWCh696Ag0j2V+AG0n/J4Vga53Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uEyi6DhV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.63
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF3606D81C;
	Wed,  4 Nov 2026 17:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0AF3606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uEyi6DhV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnUAqfdG/iP6jVY2NmmDn5PJg6lP5blwlL0uVrNhthXT3BDB8V6dTmUVJ+cpNgXMaO5gvJcFl+a23nWwwlJBjS6hXIaK7z+JlKpJkkWPAMxCu+pXDT8JYHEv8IOXlUbdBecZ+i3rrBVCxUJIHOtGNM9x9Z4X+IE5NlshJm6ivKE6pEVEg4UtldH3ZN9p0LoHQsv7B6tNqQPpEdSerD3Qp82855s2vcIDjIuMMtTTjZaveYuE5yXRCjsYg35XsnlZchCD9sD6NhM8lDNjuujXIBQD05eHiPmbjhZtSlB+fj7RDORliW/s8bE9c+JCu98tFtMEk6JuWjrP7RREUlpFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iFNJZM2JSuezmZ4rF8EsBnTQkRxBUqSwU676E3j/z8=;
 b=fFGCzuvKLR3xsD9pyh0iA27l4B1smdTCDfdsw0rdaX+vIVhRPYuX8UQuMdc8B2L/4yHauQjqnfynyCta2R1TFuMU3UQyNuxGx1zduIbhTCcHU0dlka1nz9bGEa14X5ZQXk9TyDZC8j4MCZa2PNAafQ3BIQJGBqQSKbFCU5Uq2fcxQ7LmEDh6eG9br3JBXFChr3pSIGc1aQwn7jM/VgJ1ZSxlMm3ucCnxbSgZYqIVERxta9TO+kc0hUn0Yk6EK2Y92mDXUweRP9RRMMRgP49KmBo05fyhuBXEIyKiSIGOIBDMOU0hU/Sgzf7WmoKj1AMyLdsN+IUZPd9Gc7zS1n3Gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iFNJZM2JSuezmZ4rF8EsBnTQkRxBUqSwU676E3j/z8=;
 b=uEyi6DhV4hgcg36Svv1gmJJPhkspMDMinKxSTUhVgiq7BF+X2jG89/FE3iHjiqbXDQSCGHZ2mSQHgM6MfgxCvEyrHzn4c7M8mAXd6CgjN2uhVDUEWInVP0+ccVUXUjb5/n862Imp//RudwLXYv5otEVEUNG6brYQIF1t+AQ/oj8bjkdUuyL9njYggzr5ByE0/DI7h+nluJNP22ddHgjQIspWe8qgB6KoWd+uF8FABN/fJ+TiRTP8XUeSVJo4afUKPPLDH3BwW4PZSkkAJgSGreijVoQ501WqPe6tvrC8AnYm0YnS5HrUoWTocwCQEt0A+3hlSfWnqFP4T75cNA38Tw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB11523.eurprd04.prod.outlook.com (2603:10a6:150:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 17:29:43 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 17:29:43 +0000
Date: Wed, 4 Nov 2026 11:29:34 -0600
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
Subject: Re: [PATCH v7 4/7] dmaengine: dw-edma: Reclaim LL entries from
 hardware progress
Message-ID: <autrflI2SOPER2NG@SMW015318>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104161227.1742005-5-den@valinux.co.jp>
X-ClientProxiedBy: DS1PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:8:450::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB11523:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6a9b74-4ad5-40b4-2d9e-08df3a993678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|5023799004|261026121527099003|261028144727099003|261022105027099003|261022075727099003|4143699003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261026135527099003;
X-Microsoft-Antispam-Message-Info:
	aIufH5lavYOxOVPZfdbH/t4Ql2rIlCJA324S3v+RJtL/XStVMVwEyz/x1KJnHYWaVEVgmbmHebO7Z1ogvUiikOjQG020Lt+nrdeaLgduz05YCSk7Y5kLGIIKJImn/coXBw59Hh8I2FbqgpEn3w9GFyqP3rvJNHkNI0K3y06d6A3LqXkAxvCY5MGnL5MyqgMnH+G7peK9F1mjp13J/4b4d0ZNrOtMaiTvpJbz3Gsu7fzvnxfoCPs65/CWYMP/icxbsQYnjReePmoLZKXbA6akYh3mMpTZzdz3UJqaCOmFlSZPyfTaWnObIYlk35OfYey5yrVNS7ob7i6FvDp3798FXpcSNxAMtutphvnHMiuZcuJlMns487R2D4W3MTHwCRI3BVk33S2w4tSGa963/y6fT9H0VptwcEeToUG/UR4fJNYN9ouy0M1AoC1vU4Ifzc/k7qBOwdI1JoFM0pFJCtMUWU6qi6ENqjpAC1n24SP8oh9czy6F87CxOPlSefyVHVdQcXG1PxNTIpiyooqDdFK2ZzhNubn4e/gMm5k+vqKZ4IucEys73hp96NSu6XAO8URIVoea7A1VP6ftZNHkUHmjOT36WGd6pvjechrXYr28gE22H0pOtkUvKeS9DZuCSHks
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(4143699003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261026135527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gRBbSI/PLinJ0/QWAXVjPfLQieG9unrIBlozRSKOq+WAgaA1mCbagReVbcLm?=
 =?us-ascii?Q?c2sCspA7LgAtoRiVm3PQKFjCPkN/72m4bMg76oNFeLpyqmUTW8dMUSrePfhd?=
 =?us-ascii?Q?VybTT5Edpbk6mxl0j6JVyCLNLv9YQwwacndFTEL+TQVJWnzrS2xDuezEb3Ry?=
 =?us-ascii?Q?0qCQLr5VPY4W8UqZ5MO6SlkAxIkcPCP+s7J9L5eK8GaqA5+CP1u+qx+hZPMb?=
 =?us-ascii?Q?sgiQjUT3rCNw4PiWrwXeSRjNdp/5OUbdFWLyCeep7oTZioW2YhuIYurkazk1?=
 =?us-ascii?Q?7UmeyRJuYhltS2IzFnQDZiUMjwvytRED2mAasyNbECD9MaS4PFALZKODHXz4?=
 =?us-ascii?Q?dkz6hpOs6ZhSZ2asW02um7XmZKv8lkuDMJeYOifUjn8Fuxxkb44VO5Myb7LU?=
 =?us-ascii?Q?eAEIgJ8VNYKeqPFrYXgdNtB1d5qBvkxfkG7P6VRwxZ+Mh4MWyIIJY/JYJbnh?=
 =?us-ascii?Q?cKzGadCnELpd2Tilg+wSIRyFUMzqY9i1E2c3Tg4C9G53tY0T/wT/cKBOZXgA?=
 =?us-ascii?Q?TvAJjfbhYyPpVijnm6+oXu+dgJdOy0grfi+01t3zUz6+M+QC44l6BPut83tJ?=
 =?us-ascii?Q?UWmnRC4ECIz+gDmZ0Y5PLZToSZpqffcUAC7VFxphxJZarEQOoT+6s5dt5cTm?=
 =?us-ascii?Q?RagSYpZz+cFp71oQNXkOwJ1LLfKdupvSz8+ikAzsTfyN1UItaHI0b2pxmluC?=
 =?us-ascii?Q?AO4YdqT74GEiC6myhyeIreBsvOHx1XPOOiqxVpzfa5tDR7K95a3dto+VgZFS?=
 =?us-ascii?Q?ipZYPhnwpezPBp0n98PzBZ5rEnVc61GBBgJrSmafK7VQPwkpAjxRe0WGgIuL?=
 =?us-ascii?Q?WaHQuXzc7H3TD955DPgiU8BX6UJmg+uM9PXF+7Ri1yFopxwwEyYTWutoJCHh?=
 =?us-ascii?Q?cOYcoMksCUD9Gnb9VA2w8KL4nUQSctadZIrm/oo80kYlgEubjUiTXnyaiH1l?=
 =?us-ascii?Q?BOKQA5Bo1ybSJlpY71dVk0nXQVISJHAVjUIOVIfHukQ9Uz+Zuu+oQcANpmps?=
 =?us-ascii?Q?cmpL17Edgwil7q9dzSpqStsFKNzn9gRjoOiNJ6zZx0ayUt9Pextfl7FFDwfb?=
 =?us-ascii?Q?CiLQdBsb8cIQWAF7mf2RrFWTmfW5pTJAnGxmFJJWbheXEmFOO1Mg8iMZbk4W?=
 =?us-ascii?Q?X+74YivlKLvNzPN64mxPBNCsMg4XCh/+0C0KfhQvHVphvPMlSjYvmQS/+HdC?=
 =?us-ascii?Q?hECSShO53w6T5rFmmSvxP02iQzENSOYEMZpSTLXw3bLCHNYltMUWBciOX1aL?=
 =?us-ascii?Q?n2/eTU1Xi7bB8UE5i6SMoMBY5gP05o0NmM6c7tmdt9agP6Ysb3W/17VEQbIn?=
 =?us-ascii?Q?dleY3Gurr0YmKREmsk9PqwvA5oy12iLQXQu7PRO5KH1YxTutm+aCwSXdFsBD?=
 =?us-ascii?Q?TYkJb+j3xtXIuK632iJ2SOJZqjGiQd/heGR1SNjiNjoAlC2gU2ABENISQHuT?=
 =?us-ascii?Q?9shDgrQmjTYvJsVXMc/Lxl0EJskh+bdVa02rhS3c3psyHLhN6CdbQBM39fWQ?=
 =?us-ascii?Q?JkiYHy3pt7kv0fqaQx5/PVsfN9Ilq+MZT25Wi/RFMLRhvDVRwKadtC+IG9t2?=
 =?us-ascii?Q?ec+q+GeNa5/9yYwJeYU8utQUaBHCOirZQM5ogDrGso2L4PPp1Yi125wGsNax?=
 =?us-ascii?Q?CfOXlh60tHGblFmZnfVqLG034ty95rspwXlgCIOAE96iEJuk/1tFzmgbLCLZ?=
 =?us-ascii?Q?L0p68KViNUnuHJ4j2Euqk+AfXDV3LoVbjFwhdVN7fFkIiIg5jDVCOzvh4A/N?=
 =?us-ascii?Q?Fq5OWphtkByvVgskIgr+suX/xxXfyvx19No2uSUQtE97z1wdOicp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6a9b74-4ad5-40b4-2d9e-08df3a993678
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:29:42.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IO/wzi22NRuypUrjYIqkt5Zi6K7PqTXqfBFgEAdoLdEdIl8SULozEwASkM+Otwjr6BaQttj3BzHrQxJSFCkjuUrcAwlbRha7p1JRVRGxMjONrXvmdif3hSbrHpt/mDSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11523

On Thu, Nov 05, 2026 at 01:12:24AM +0900, Koichiro Den wrote:
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
>   the channel stops. Keep unfinished work for resume.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes from v6:
>   - Handle STOP before consuming LL entries (Sashiko).
>   - Use modulo, assert vc.lock, and share descriptor completion code
>     (Frank).
>   - (*) Restart stopped channels during termination. Tests under DMA
>     load exposed the missing restart. In fact, v5 patch 19 had similar
>     handling and I mistakenly dropped that logic while doing major
>     v5->v6 reconstruction/simplification:
>     https://lore.kernel.org/r/20260812155721.2807506-20-den@valinux.co.jp/
>   - Substantially reword/polish the commit message.
>   - Link to v6:
>     https://lore.kernel.org/r/20261030150742.2586776-3-den@valinux.co.jp/
>
> Note on (*): A channel can still report STOPPED just after a doorbell.
> Another doorbell in this window may trigger the class B stall observed
> on R-Car S4 [1]. That stall appears specific to S4 or its DWC IP
> revision, and IMHO should not block this series any longer.
>
> [1] https://lore.kernel.org/all/tkyu5rsxfa7i6rxxw6qxmmwke5qnlxptwx4j2s24fhftsmmf26@gamef2ec4wwm/
>
>  drivers/dma/dw-edma/dw-edma-core.c | 156 +++++++++++++++++++++++++----
>  1 file changed, 134 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index e2f7af5969c6..e2f2a535d5ad 100644
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
> @@ -161,17 +154,80 @@ static bool dw_edma_ll_stopped(struct dw_edma_chan *chan)
>  	       !dw_edma_core_ch_transfer_size(chan);
>  }
>
> -static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
> +/* Return the first entry we cannot reclaim yet. */
> +static int dw_edma_ll_boundary(struct dw_edma_chan *chan, int idx,
> +			       bool stopped)
>  {
> -	int idx = dw_edma_core_ll_cur_idx(chan);
> +	if (idx < 0 || (u32)idx > chan->ll_max)
> +		return -EINVAL;
> +
> +	/* After a stop, LLP points past the completed entries. */
> +	if (stopped)
> +		return idx == chan->ll_max ? 0 : idx;
>
> -	if (idx == chan->ll_max)
> -		idx = 0;
> +	/*
> +	 * DMA_LLP can advance before payload completion. Keep the boundary
> +	 * one entry behind it, wrapping at the start of the ring.
> +	 */
> +	return (idx + chan->ll_max - 1) % chan->ll_max;
> +}
> +
> +static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
> +{
> +	int idx = dw_edma_ll_boundary(chan, dw_edma_core_ll_cur_idx(chan), true);
>
>  	return idx >= 0 && (u32)idx == chan->ll_head &&
>  	       dw_edma_ll_stopped(chan);
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
> @@ -200,7 +256,6 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
>  		}
>  	}
>
> -	desc->done_burst = desc->start_burst;
>  	desc->start_burst = i;
>  }
>
> @@ -309,6 +364,52 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw_edma_chan *chan)
>  	dw_edma_core_ch_doorbell(chan);
>  }
>
> +/* Must be called with vc.lock held. */
> +static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
> +{
> +	bool stopped;
> +
> +	lockdep_assert_held(&chan->vc.lock);
> +
> +	/* Terminate without scheduling completion callbacks. */
> +	if (chan->request == EDMA_REQ_STOP) {
> +		if (dw_edma_ll_drained(chan))
> +			dw_edma_finish_termination(chan);
> +		else if (dw_edma_ll_stopped(chan))
> +			/* A newly appended tail may have missed the last stop. */
> +			dw_edma_core_ch_doorbell(chan);
> +		return;
> +	}
> +
> +	stopped = dw_edma_ll_stopped(chan);
> +	/*
> +	 * HDMA updates LLP at watermark events while running. Use running
> +	 * samples only when processing an LL interrupt.
> +	 */
> +	if (stopped || event)
> +		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
> +				   stopped);
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
> @@ -493,6 +594,8 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  		err = -EPERM;
>  	} else {
>  		dw_edma_set_request(chan, EDMA_REQ_STOP);
> +		if (!chan->non_ll)
> +			dw_edma_ll_advance(chan, false);
>  	}
>  	if (chan->status == EDMA_ST_IDLE)
>  		dw_edma_set_request(chan, EDMA_REQ_NONE);
> @@ -777,7 +880,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
>  	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
>  }
>
> -/* Must be called with vc.lock held. */
> +/* Non-LL completion; vc.lock must be held. */
>  static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma_desc *desc;
> @@ -796,11 +899,8 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
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
> @@ -816,14 +916,12 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
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
> @@ -835,6 +933,16 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  }
>
> +static void dw_edma_ll_interrupt(struct dw_edma_chan *chan)
> +{
> +	guard(spinlock_irqsave)(&chan->vc.lock);
> +
> +	if (chan->status == EDMA_ST_PAUSE)
> +		return;
> +
> +	dw_edma_ll_advance(chan, true);
> +}
> +
>  static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  {
>  	struct virt_dma_desc *vd;
> @@ -863,8 +971,12 @@ static void dw_edma_irq_work(struct work_struct *work)
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
