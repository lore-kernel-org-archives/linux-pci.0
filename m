Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021113.outbound.protection.outlook.com [52.101.125.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11E1E32CF;
	Mon, 16 Feb 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251462; cv=fail; b=mpHg9RMkMZmxgmg+K4zaT/9f6T1IRZq7+RZ0lP+694nL8ViIvYU87ZsagCzzc0/tataFohUR9DsapFeC2qAZakEha/2gacLNP4wFkhKOve9gW40XOx5sPKQuIqqkwlx+uXOuO49h0E7N5C1E93tDa22VQoZlA6ZsGd5iU03ggxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251462; c=relaxed/simple;
	bh=BFJMsGsZ2/M8JTocsMmlcaRy1TIyyQxSAaVNfNx4QIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fFYYZgsMf8a0HGoK5pkLdpA+UopWl5E6M3rzkeCBLo5equUhHoK/REthO4xFa0FKPhdKsmWHdmOL8YmFH3xV+X3MewD0efkWETgUksauVld3VHwrPRTi3m/CfWTpnEXKpLjnU8kAxytI/HzOIJ0aJYiGISO2fCbzYLRtBI6wpzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FjN8GfJb; arc=fail smtp.client-ip=52.101.125.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FjN8GfJb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeUd8cfHePm7wn4tycwzdOjX13vEr9qY4NMb57+o07itObIQYxHuAcAqUPOTHLSFVAchwwrYrKALJyFjR8oQ6yJE2qmcmBA4J/F7jVw9ZPfi8YctGktWBeVMmBEiQE/ZV3XiZ4VDJHY4NYZywaDZrI/DSKC6vro6R5qUJ9LoywFB5g2KsNSb2azCr3ONPwXnLvPdehAOxLrJ1vE93KM99d+vovtiGSddUbnUAR/G6Vc1yu+FVwU/QS2Py7UoICFXR5aJYhFIlXptaTOZv1VeypStAJXf8pNvQWzCkKLWdhW71Gp9rAXFUkRIbgdi3eNTAmE8wegOED0O7+hvhpCrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYf6xktdAPXEGrR81dW3HKlpcIlYAJfEtnEcRnyPAm8=;
 b=TyURBUyCvdtq3ehgJbkdmHAVcKRb+hHa+sPmrAm30RNNPA33mgKyuF4qAyXCRsj8ib5kak7QkkDibkX23C2hF1p3ONYSbPygNT6UrJtFleN94nUMiMhxcP/mzms7Qx1KkyfXRm+WY2US6GwqQ60O4xdkCHs2s0q0491BHaL1ypulCIlBuZ3t1wRL920nEPkcGZ0y82SjTD0DAcRgNawvsjf64TIWfS2u0GJuBRBfegpm0SvdXvKvdDzjpiHwgebuC01Gt7YcNCSt0+60NVHWiMXKsF65/Y/r+I1/rDTQEhz8K27ConH6PBzVtT4dHkD6Is2aYcyoFZbqbNnhqaU0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYf6xktdAPXEGrR81dW3HKlpcIlYAJfEtnEcRnyPAm8=;
 b=FjN8GfJbd7q6m0M0bs1l24e8mX+6yCibhvsgWyllF6dOta2xxavW+yDJV8e5yQkgLpEf6PhK5+j2xoAfJf4Xbk/EICwhhRYdAz2kpCnMpplrHmr0QGVCRIOkGME2KHVWArjv2Iie5XZxRC/YlT/O65EVxIy3uZf47tNL0PQOjaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2959.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:305::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 14:17:38 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 14:17:38 +0000
Date: Mon, 16 Feb 2026 23:17:36 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Frank.Li@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 2/4] PCI: endpoint: pci-epf-test: Sanity-check doorbell
 offset within BAR
Message-ID: <jcjson6zedvhkpctwzfao2wfaaujtdfqsnnm3k25e2vpz2evf4@hbsegnyevisu>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <20260215150914.3392479-3-den@valinux.co.jp>
 <aZMYJsjpqPR9uNqp@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZMYJsjpqPR9uNqp@ryzen>
X-ClientProxiedBy: TY4P286CA0088.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2959:EE_
X-MS-Office365-Filtering-Correlation-Id: 13451353-508a-40cd-4354-08de6d66237c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P77+uFJXmcr9NZbXYHExHa6SBOr7uPzFdBAeQ5VGWixZ5zxtJUGraJ4hoApE?=
 =?us-ascii?Q?rX5euFB3UXKvgPhcq7O0FhxLK4sOzFvws5paXp3Ncln140JpjAZ4UaW/pp/4?=
 =?us-ascii?Q?Hg5+CHj4LI7V2CWOuTw+tiTYrmBUq2P307ka7ni5AjNASYhOZ72PM2znV4gi?=
 =?us-ascii?Q?28mv/lx8rMTkk73tse5zmtdJ8Lyn1yfhOHnXxTLweXiTJxEbneDxyYKpHNip?=
 =?us-ascii?Q?b+0dlED/iDpOGHb0WKPpMjB4tAk1KhpqGN1OetJqCGQ+fG2pcI2CjEq5uVXy?=
 =?us-ascii?Q?YzxKdjQBReAP9nbK2feswD/eIC/EoZ7nX9mMagVJnfcBt2nDSo0Hf8F9Ejty?=
 =?us-ascii?Q?XfIFz5blG0pRHucUg/48kGdAZdl4tJmjDLt8e3K67SZOxlm9fhegdZfbPru2?=
 =?us-ascii?Q?HBS0pGrwPto8I4+GLXp5Zx/DKpaEJBUJr2kZP9yM5UeZ1IHGDYspfiax8Wer?=
 =?us-ascii?Q?4xWUB2QTtc6E9WTOKQ6zGnX0fDWaH02u7CO4uZEHiMjDwEcLUwyYU1p3PUqU?=
 =?us-ascii?Q?AbefAhW4faCDL1sRfXBjIWP8K3u5CMGGweA+Nhg+v9cndaAtSc3ZG+eK7uQ/?=
 =?us-ascii?Q?g76t5iJ3UDMdluSUD+zpAPUXSETqp/ABBerdWphS2zJ5MvGK0Wth7apna/Pe?=
 =?us-ascii?Q?sb3rqJoPVIl8Qde968WV2aRL/yqnR1pXDEtaa9KsB2E1Tm63xwEt/PMK12Jx?=
 =?us-ascii?Q?ytUJv4Lq28OyBBLI+kLV0awrS2MfNOsYAHph+rK0NLE3Aqjhp8fefqHxhV4G?=
 =?us-ascii?Q?ZUjr2/rAz9wR0mK0uqKwikmC20RexSWLHnZa8Mo1Q8ZqIadNT7vS5LMfeaFD?=
 =?us-ascii?Q?3RbVhIwAWu1qbxEoTEUjlJ+lrwGOBdAwoI59W3yIxUreQsvAIaRV9xRHfS8D?=
 =?us-ascii?Q?edA68plPuTI/Y2FqHriBPquc453pY9YAWBFWZwoKrmFIB0Gj4SM+qW3tY4TR?=
 =?us-ascii?Q?S47109OxAqXAE+IwtdynRZ+yaV+XIyqfaxtBT/rvkWNPZHsOJ+ZoyfkZdShx?=
 =?us-ascii?Q?7kO80uuHgCJK2lb7OtcPhQL1MOLQnrFo9cFjo+nOxu9CpI2DuQeMuvPcZJKq?=
 =?us-ascii?Q?Ckr5GN+p9kpX64Apb1CtMA+3rAFPa7z2SmbGIgfvSB0FQBiYx0SjJPfv84Yb?=
 =?us-ascii?Q?+cOGULhoa/WrNo0NDFyQoe2+UyWIJwi51ZysBtUmlOhn3DGALoM2G8QqAKS2?=
 =?us-ascii?Q?InGbOIdSyPGBvZaqEQ4LKP+rhQj4i8Jo9HAiS0isRcpxQWD7HwKg+wT/1T0C?=
 =?us-ascii?Q?vmdwXSvrWf6/eGWS1AhsL4Lk5zwPyQZsa/pu5B2WYC4z+S/Jicu4MjLoS8o3?=
 =?us-ascii?Q?tZS2gn/aRT9JpZO9zyYG3PzdagAwFDlJHU49JPgwxbly78/t7sHQscXtOq3p?=
 =?us-ascii?Q?T36rgWxo4xLiWhbqVHK4y5BB2T7e+hbb4u0Mrwh4bDddHjCcFSjGuxt3cZ3b?=
 =?us-ascii?Q?o3XxLBGnL6NsZQVnVQGc31y3ntMjNwJPdwOe8bUHC90jP6e6vr2ffHrmzyqw?=
 =?us-ascii?Q?Ciun6BY9jcDlDCxqU54vJ69xmdsuVOgSvrJQMwmW3a4psW2dZdEguDAAxgwo?=
 =?us-ascii?Q?5To4u4b/UXoWtUBQT55rgb2dVG8zPKu9vc+v8dFbzH8lkqjhxN9Zq4jK3xts?=
 =?us-ascii?Q?tM1UB88ZTUKs3o3HiHAr2tQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2DkgNkcQC3oZafJ3iKJLjMa82oU/5K0IY5AvTC0CVMqPAxePd9Wf7zl2G0Dd?=
 =?us-ascii?Q?JhfakI61yrz8l7bfloqnDfbnOYB7gayRgI4WCgAMwkbbSG3UfgxGsJUtCR/b?=
 =?us-ascii?Q?dBefFIS/bEcTob/WjSpqjEROY3Je7tj9562SEXSKOrdAuMdD+ONVgVuM/7D5?=
 =?us-ascii?Q?NVZlmlHAyt1GzmHAbg2idbBSwQl4mkwucBehwj2LFrF0R3n561uzIb7e5VoC?=
 =?us-ascii?Q?ic2zegQc06dMGu4b9pWvf6w+w3WSopBTBFR2DMHGgiKLyAnYHzZwOXGN4DLJ?=
 =?us-ascii?Q?AFGcWnBcTNSjsSkG433dxsVEiofVnPmJaBwBnapf4gHplg+td9lRDv9ePtG6?=
 =?us-ascii?Q?zXFQd8Fz90eCQ2bDs9MVz3a9C1wPHrh9VJbfBcTflhLSJcJyw+onu5wEhVeq?=
 =?us-ascii?Q?i3GlewJ+nfgcdiAmreNoXMcKZMrrzo1jLPdUqZKyCVh8rquEEBvxMEgjBazE?=
 =?us-ascii?Q?qOQWaLuoq8HpACCA9niGDzQDvrnsEwG+/gwUCFDCyc4TKFSYWv/CKn3zo92U?=
 =?us-ascii?Q?GVZKQqM/QWOHiZqoJS7kz30okBLl+xVhPrRK4ANzEoTvjjxrkrUuqkvm8Xnh?=
 =?us-ascii?Q?yorM1OQdjD1jvecx5qxwjM/IhTBxLPiAQ2cUIZ0hNYBayM7yl2+Sq5T8CG4M?=
 =?us-ascii?Q?wP3CVOHLBisxB/13iAsO2aW5RfZmF9T8jscTQhJ3jq0qus0g3drAxzK4qhMw?=
 =?us-ascii?Q?4ttEJLAEjHw6F2ekLgthz2zrwYUc4bPh3bvWeEQ6vRP4DXuCu6x/oY5/VHwI?=
 =?us-ascii?Q?i3XqQiw+U2ESL+Amux8Z5KfXYH8emGgpOMwwZ29pyYg4YGyIU0AZyNMbMYVE?=
 =?us-ascii?Q?4VPoa+fwxGri0PpcAjJzkoomRuU4ubUzVHybKpEdssTTOogyDGKZ+JkMRAjq?=
 =?us-ascii?Q?Vi1JE671FZKC9n7MRUNWuHNiUipUYm/bWI9xYd4p6j+LSiOYjg5fRjmOBVKa?=
 =?us-ascii?Q?OmOEgbdmvpLW3pLQF0NMbIt1M/r/vzS8WCUbcGUG2Cf0ByefWEmlkPg83dIv?=
 =?us-ascii?Q?M9q1vrApmu7ma0vddCM9NaMNPauN7RzFzpsOXjRDhLCTT+iKJWx/jis/NEji?=
 =?us-ascii?Q?gMPf0Kb1Azvcef5vYh9R6iAxdyBdX5donpbNAr2fa017SLe5quVRsQzon0Vk?=
 =?us-ascii?Q?V7rEwMXQXPobqlmPr+2LbScf4FLuXJzGkVfmSzfDGt5ymE5kAzykZC6YF7Zn?=
 =?us-ascii?Q?/otXC+GvX7A1/ImWnHbZl5kwT/5CoQPEjh8afSqzPY0I0gD4q+e1NSTmYnQC?=
 =?us-ascii?Q?uM5ynP88zYFpSzYjqVsNrH7/4aGEru4YlKnmzLwmFnihl55PixiqcwyIlSyq?=
 =?us-ascii?Q?TBTYiKOexvupgBsaK0lxTewtKL0urr5Bf1E2TlPLFrGZR5TbmKicJLryRiqN?=
 =?us-ascii?Q?pZ2EiBXcdHRIZPJXnpM8gkMs7Tep44hbDwZ8IRoCNirZgNTfIfqrP2oDZ4pg?=
 =?us-ascii?Q?m1NMPDVMZMg+eLI53z+7Ud4DRSmHhQLPnqJ2EiOxz6U691id+KqR8U03HlvH?=
 =?us-ascii?Q?MEIqxBlAuJz4pfcLDqWs+iKbOLn2+Wn47jCdA6swmXD8hhkGbJGOF8RN9v8w?=
 =?us-ascii?Q?7gu+5bnM4uPc4LqYRQSISkdJJXI8vkn4lPfb9ZTkLq0mwllIyzKwDL9ClndE?=
 =?us-ascii?Q?LMUXsYk+5aLt3SNZKsDovaiSkNspDADbD/HFkDAOhkqzmURuTkDTnT7mp+yI?=
 =?us-ascii?Q?iCB+MCLkK6lJ0FMTco2D2g2GGvV5bzF4TF/AypteBEYh465vOl6MOyc8MYJ+?=
 =?us-ascii?Q?vaVY/cgvK3EEPoe6t5yvx4lL7lSF01gfGjHjM/qxBc8Lga5cuoZs?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 13451353-508a-40cd-4354-08de6d66237c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 14:17:38.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey1C92z7EBvAV9ppx5jjmFrnCvw/cVkjtbC/Dl+tiMSIErJiM+4cFOlbHQBWFe5VKw59r9jf9tRAcR3fmb1DIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2959

On Mon, Feb 16, 2026 at 02:14:14PM +0100, Niklas Cassel wrote:
> On Mon, Feb 16, 2026 at 12:09:12AM +0900, Koichiro Den wrote:
> > pci-epf-test advertises the doorbell target to the RC as a BAR number
> > and an offset. The RC rings the doorbell with a single DWORD MMIO write
> > to BAR + offset.
> > 
> > For MSI/MSI-X-based doorbells, the message address is required to be
> > DWORD-aligned, so the computed offset should not straddle a BAR boundary
> > in normal operation.
> > 
> > However, with support for doorbells based on mechanisms other than
> > MSI/MSI-X (via pci_epf_alloc_doorbell()), the returned message address
> > may not necessarily be DWORD-aligned. In such a case, offset plus the
> > 32-bit write width could cross the end of the BAR aperture. The offset
> > returned by pci_epf_align_inbound_addr() is guaranteed to be within the
> > BAR size, but this alone does not ensure that a 32-bit write starting at
> > that offset stays within the BAR.
> > 
> > Add a bounds check to ensure that the 32-bit doorbell write always stays
> > within the BAR aperture. While this should not trigger for
> > spec-compliant MSI/MSI-X addresses, it provides a defensive guard
> > against unexpected offsets from future doorbell implementations.
> 
> I think everything you write is true,
> and I know that I suggested this...
> 
> But for the MMIO address, will it ever not be 32-bit aligned?

Yes I see your point.

> 
> Even in the eDMA case, the eDMA registers are 32-bit aligned.
> 
> Did I perhaps have a brain fart and overthink this?
> 
> 
> I guess theoretically, some future pci_epf_alloc_doorbell() implementation
> could return something that is not 32-bit aligned...

Yes, that's my impression as well. This looks more like a theoritical safeguard
in case pci_epf_align_inbound_addr() or nearby code paths gets accidentally
broken by future changes..

> 
> But if we really want to add a safety check for that... perhaps a 32-bit
> alignment check would be better suited to have in pci_epf_alloc_doorbell() ?
> 
> 
> Perhaps this check is better added in pci_epf_alloc_doorbell() or
> pci_epf_alloc_doorbell_embedded(), in the series that adds support for
> embedded doorbells ?

Hm, ok let's drop this patch at least from this series for now. I'll reconsider
it as part of the feature series instead.

Thanks,
Koichiro

> 
> 
> Kind regards,
> Niklas
