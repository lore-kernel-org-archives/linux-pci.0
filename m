Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020093.outbound.protection.outlook.com [52.101.228.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56E4CB5B;
	Wed, 18 Feb 2026 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771381994; cv=fail; b=bovTXwVuNaD9uI1kLh+2fOz71tkcbhcMJx5LU6dgtn+NU/wjGvYVr4c/D82u7WpCW4WyIpto7BLazCLF4CUXVdj6ug755kvLCB0vLiQy3bKOS47Ky3G6lslK87srwxHeLpSQTxIZsxakli70J8i6GFok9snaccCanwqxHGq8ZtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771381994; c=relaxed/simple;
	bh=RahBMIXi4fldctF9gnsMn+EpeWRGLysBDIPvUvZhnq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O8OKtJLA6kl0sVS0dZWOl/TUhg/l3+MQlc3aWUlJQIFSA26qbWl4ALSdk7AaZzULLdSc0yC9QAcCWAkJsfGihpMXMiPSq/1rnYoNeU6hJY3pOBL7ymv14xHZDWfkIjGzAOqeJ5wiGq8NaJlMkYL6ULY9LKGi6SU9+dCpBYf7+gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YopJxSvP; arc=fail smtp.client-ip=52.101.228.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YopJxSvP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMBATqbihknZArQX0/SK62OBJYlCgWxN/5e1ErT0z3hX+F3y7AAKo2VaVmaLI/5VSg4E9/C2QJ7AjgINdKxOmRLxdz4vhY1wnglSaCvx0qrOEpEiC2FLJszf58dLk+OGRXDB2/ppseFDW9E50iOiqgK41av+J1rqHyWHnCIunISTilYabHK8N2yQEa685NmZdhs2p2npMrgDiza0cmnuvUXRzrZ8nJhKoNTOcoD0x065enVhY/YR/AM7L4RaPSh0vwymQraiAldzgDDLtDLJDgWQWFrKYh7awSNFc/rY5yl32X2nvDZOnYJ74LB5lvq4M87PUvKNPWi3e9og0Hsj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFTfcok9cGthMWUZG3mgg962fo3QYaRZR/QIGHIeZUg=;
 b=qR4XA9CSN5gxx3U9vGU7kuebd+TGD+BwS6O3zVqeTC0xelUm8MQ6h7+yH/aNU+jUqC/90uWoxdaLTIrTHnHxUYsyiTW86IWUuPSZe0oTQhvGWl3UjbYXhuU1oxIK39oXb1NxOHXe7EskJnEJKG4YOIigu+clI1+Zot/MKoTdakE8xf3bf7S/bOMzjnzCcA9G6JYl7AGyS4vFrHJ/1jKExDk3G9hmpRN7QCMO0ZUZs/27sDGO6jKExaxm8yjEJYnETXsc5WvF3+BuSqknEL1hrEl+wuYm+wzZ0S/7lVS5F7bU92RD/fpjI7Owvq6zHHYZcXXaZWPKfNRp3+T5Oa+wkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFTfcok9cGthMWUZG3mgg962fo3QYaRZR/QIGHIeZUg=;
 b=YopJxSvPE2sS/bktRPOMenMR0nU558ZjjxPNqLvMj9DkctH3VtOE08DB4oMywR2AS5JU6gjBx0grb5dy+k4J8qTLba2GwBRsVOeBSUJCRirrPzVsSS0O0W6afK2pPhGtzRKz2ON3WC7hRXPJqr+MBQxiZ/fO5D/8pbZ1XNEYujE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7749.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 02:33:09 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 02:33:08 +0000
Date: Wed, 18 Feb 2026 11:33:07 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, 
	kishon@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	cassel@kernel.org, shawn.lin@rock-chips.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 7/9] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
Message-ID: <tflsioixiwtcoq7dfnfhllcmtimh5xlfmhzc34vw5gb3kqukvn@nka53jttuyec>
References: <20260217080601.3808847-1-den@valinux.co.jp>
 <20260217080601.3808847-8-den@valinux.co.jp>
 <aZSdRWdevAr6TpBP@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZSdRWdevAr6TpBP@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0232.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 1904dd17-de41-4fca-0124-08de6e960dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h23KXNVWbZCbZscs27uZxTmUoU2vi1LxDQqh4bj5dGKQ506DPdk9xVEoB0jo?=
 =?us-ascii?Q?XEdMORsrJDZk2ZPtZ3AG2BEtRwuztPxCSB30CuafjJ1jxQPVyzMGMSA5Y11m?=
 =?us-ascii?Q?R27h1/fMfYU3ju+CAp7KTRt8VkPKhCAnDa8D5Z18quHWuGezjMUTSknPja8E?=
 =?us-ascii?Q?W3oeovF9GlC62LW4Rd8rob90Q7ZevRTZO/wYoAAuRXW3VlbIXjxfQejxb4xP?=
 =?us-ascii?Q?fsrmtHITxTBOF+RbFWTmc4gsz3bgJuTE92eZX9HyyPgJTInxkqEN/Lo7d0Wf?=
 =?us-ascii?Q?58u9aeC5XRdajuLAllmvlep7vMlHaa/sFoE3nYgpBmWIkVnux6Lh9fsAMDbV?=
 =?us-ascii?Q?ucq84FeYrlR0Bn6SNZr3X7HPIR3XOjbxaOzJS/jMWAsL2+qqNGn48sThjoLC?=
 =?us-ascii?Q?QXI0yIbLp0tAIcuHVp8Xkt6fjHHIFkN45TcYrtN1TtzVTTQzbEKp+aoorqqX?=
 =?us-ascii?Q?UBaKuGWKFqof4OTjN0peV5P7k3l4VEJd6xlOiGeaRfqM5HkAPiwINOQWW9GS?=
 =?us-ascii?Q?2gXFMaHYFNezAT0jDpD7GuPIuNYmaGejwP96iHB0GJkLSH0CKeBhTJJ6VXou?=
 =?us-ascii?Q?6E9RGJO6pQ3bUxctXRDC+oQqiiWUKNhRwBqrn7ArsBlJd83FOOycE3HCvDAj?=
 =?us-ascii?Q?2Irqoim9ununwuKXglPGqe86MMYX0cM/qr6MfvLw9m0aoQeS+Nbw3nUk1vCd?=
 =?us-ascii?Q?mhZEP8Q+pB+Qqlr8FvqFK7uVrzxA/YpcRW5d5ulYs5/fVXToq7wbB0QjH+lW?=
 =?us-ascii?Q?mnDn/Fu37NfM1QIImMriXeNv77OvIEYl3Z4olUVPn+EPAOE5hpc6WuZ3gAMZ?=
 =?us-ascii?Q?iczNKOdwkHRxZWZttB8xxfwu98hwQJccPIuOQWYEAKBiPnHZmv1TBkImG7Es?=
 =?us-ascii?Q?M1+7aMMrf7sViyIMX3/rkkxfszTp/l0d4o6sQMV4zoUlPPDQubE9BU8OCF30?=
 =?us-ascii?Q?4KlMBmMLUJZLl8n40jwh6JwM5HWu0h2jWu9NbrLua+aq0DRB6W3X6buyV50e?=
 =?us-ascii?Q?Hoq+X+yiZ0GABOZEhpOgeZzBT3J3niQM4+qnguwP5fkf9xjE8bLuNP/NA46m?=
 =?us-ascii?Q?A3b2Era6lUsshvVvjygK2u7GfOJNpfvy04fX7VA3eplAzTjq5K0dZJmIIHNM?=
 =?us-ascii?Q?vOJ3jSTfJZoC1Ko2gVIvfaaXa88ZiXeWxfHtxwY4L4BLl5Ay27ki4qhlXb45?=
 =?us-ascii?Q?346HPzj5nUuYrAQ/Z/yadU0YYpvFkIbfuuA417r+rozljOzhbfDcCh7U3IJj?=
 =?us-ascii?Q?Cd4yFns7+2/Fe8K3j5X4T00RwxDEgjjg6xpNtXwl00hnhzEa+cgtu5EYqL/z?=
 =?us-ascii?Q?voi9OiGJbl6meeOZhoaCdU6KRS66iaUjnEO/JWkFSLy8P4yJF8lS4GNIdP1k?=
 =?us-ascii?Q?QI+GxCpPYdfRbGfvtb8egsKS4frVjjWdg9E0r9szUPaNgRXHVPTvMtXYDrBj?=
 =?us-ascii?Q?+OFCAxR18USYO/XyBTGg9+mWtijiuvAq0ONyzzcsQRbKydX1MHKEilnl7SF0?=
 =?us-ascii?Q?R5Se49kJ+cm6+m6irN9gl8VDs9Jn7HVCDqIhypYyjd2sN5/4Bm+S8hp/AQ+e?=
 =?us-ascii?Q?TrDkBJGwvSYtdraHApc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C3zTrbWBMJGSf8j/LJj1Zc3Yjbe7Y2EWAJ/qNdsyqM0uA+JpSRuCrhVrRT3T?=
 =?us-ascii?Q?lj46GMlXwA5HGd7ccXiJyD3R75JcbN7NVTsweNTQjP4w0ZVFWEoos69nBORz?=
 =?us-ascii?Q?3IpW3993jCOEPf8LHo5WdtQvVzWg8aFGrEbgAPabB8gkIKX4cNmPFAlSKdsc?=
 =?us-ascii?Q?goqYtgHnT+MwFaE0ieiol/4SigA/dYphuCYmavN5fB7BM5giS9mxiaLlO7NN?=
 =?us-ascii?Q?EJdxaYszLFOoJ1IfVYg6UXpP5nek5WFEddCYVP42/rkGCknPG8smWDqI8SRA?=
 =?us-ascii?Q?zALje8CL4ZsvuCGBiuys+9DRErm+7nV4PbEGRpSXt7HH7req/H+Z7bnI8R6O?=
 =?us-ascii?Q?CO78byOpCw8R3mHBtEGjsQEL0jyZEGivI32n/Bi8+UyzmqUP6ZMyW6QvIId2?=
 =?us-ascii?Q?SOQWnFR6ZgptX9KVgZNbEr46VfeTR5XRhMz6KvD9WXnU6LOGgtE7V0J6/mxV?=
 =?us-ascii?Q?JXhLOz+LOg1W7LlSaWoAwarnrZJ2rk+Aitox+21YygdGGkKzoL2FzOXUlxc9?=
 =?us-ascii?Q?v2CzTvox2/o/JmaSOsgcVtFIBgMmKqVRYVS7FXBjgQpEXIlfUU+tfOJRalYp?=
 =?us-ascii?Q?vsxjo08uFGr7avo1re8FhZxkvZeN0ln3SwcC5JPcFnGP5VkbPGgztISO9NcW?=
 =?us-ascii?Q?J+roX/womq5yfU8M73XZZ5AXSvUxdfJvPYAhmXDM25kMKtlNish0VRW3idCS?=
 =?us-ascii?Q?Y3GeATEtXZKZ1E3F0JAOn/RHHm/iW2JG+rF2WGC6wqPKzSUJojYCEJnvZ3IB?=
 =?us-ascii?Q?ciATFBJZjTtP2rbgbbOAj/PXZW92Jk31yQdGknnWtmmmnzj8eGdPIUVIPQxo?=
 =?us-ascii?Q?JlffHOYFk5eVFiWH+uqyrJbPk6JmsydT/x64GzgVCbFZBPot35nLY6Iq7eZs?=
 =?us-ascii?Q?P0urIkl0HU+wm251fhiZMHkd3A3VOgtLaraZyPirYlyLKqDm+5Q7Xu7jzTFh?=
 =?us-ascii?Q?+2E3Q5T6IxDNef7oVam6yGMXqwCrPAxXZAOn5Mpc/iHzYLEXON6dtNLNrryy?=
 =?us-ascii?Q?zcK4bCShjFztVFh5Iw4psm5XW6yQE3z8O/AQjbuAr+A/o15Lbs9XLUkjbuMP?=
 =?us-ascii?Q?W+zn3iTssDs9TQJHy4hw4tXmm1juxgWpFmljLFPJTyG7V4xDCgvEl7XsvEpi?=
 =?us-ascii?Q?77l2Dp5Ag41L01dWLgY+H/B/EV87iuFUsR3IrLUF1oaWIV3/YPdMov2XqHnS?=
 =?us-ascii?Q?o05nMr/q4xB4K18uO9kss47EUxv3h7gPf1P3RAeC/r5GQcqG4zZGPsmr1b/O?=
 =?us-ascii?Q?BIetoRKGBvhH+gw3NFKmIkeDQCTnigivOD8mqF3NkfoxkwZNIJQtMeXeq7qJ?=
 =?us-ascii?Q?MysT+eseGjDQgA/WDLGsmXxq9RGZzMmMkYUqdgSReFgAg50xj/cJU9DpyHlz?=
 =?us-ascii?Q?0h8Ot1dteeUpI9OPk2ndK/D77G1N6vwyaBqIji/n6hBpeDQ4CGGB4sDHuD8x?=
 =?us-ascii?Q?8x1lWilol0mpy4Dzyy0/bOwcF/3eXTZgdMChUPDLCAo/rB7oJGyWaNiyH4Xz?=
 =?us-ascii?Q?wqXwXjiLD4xGPDH4AQtFGfq8JB0n0W/4bchfGESmU2AxJSz1FBN94qyzbqCx?=
 =?us-ascii?Q?9kylKZ5na0mHfZ8PtIHVsAxAMGEsvgR7KxB4YlH5sSF5Y4FAqf6LfS3c4uZ5?=
 =?us-ascii?Q?Vd76RXIRyzDccVgS1ukrzKr3ggVTQSm36NWQzl2VzkfiExXm/GjItlVST48x?=
 =?us-ascii?Q?dYM7lh3/VNYVQsHOJHzFgAd/QEEWqT6Pkq70xCMatSVjPuxARhko6ZZIOtL8?=
 =?us-ascii?Q?XkDEilucfqBLIglRnT6fC80Ym0bhfaqp1EFdQo51pqPGTxH5/EH/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1904dd17-de41-4fca-0124-08de6e960dc3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 02:33:08.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UH2E5bod1e8CAO5Ta/4XRQBBFOeFwiqcVh+dZivOc508QrFvqj34NXrPOUAo1bzs+TgzOjXTyZXvNn5UnRZVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7749

On Tue, Feb 17, 2026 at 11:54:29AM -0500, Frank Li wrote:
> On Tue, Feb 17, 2026 at 05:05:59PM +0900, Koichiro Den wrote:
> > Support doorbell backends where the doorbell target is already exposed
> > via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
> > must be requested with specific flags.
> >
> > When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
> > pre-exposed BAR window and skip programming a new inbound mapping. Also
> > honor db_msg[].irq_flags when requesting the doorbell IRQ.
> >
> > Multiple doorbells may share the same Linux IRQ. Avoid duplicate
> > request_irq() calls by requesting each unique virq once.
> >
> > This makes pci-epf-vntb work with platform-defined or embedded doorbell
> 
> Nit: Make pci-epf-vntb work with ...
> 
> > backends without exposing backend-specific details to the consumer
> > layer.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v7:
> >   - Deduplicate request_irq()/free_irq() calls based on virq (shared
> >     IRQ) rather than doorbell type.
> >
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 61 ++++++++++++++++++-
> >  1 file changed, 58 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 52cf442ca1d9..b1e8414c4e43 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -134,6 +134,11 @@ struct epf_ntb {
> >  	u16 vntb_vid;
> >
> >  	bool linkup;
> > +
> > +	/*
> > +	 * True when doorbells are interrupt-driven (MSI or embedded), false
> > +	 * when polled.
> > +	 */
> >  	bool msi_doorbell;
> >  	u32 spad_size;
> >
> > @@ -517,6 +522,17 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
> >  	return 0;
> >  }
> >
> > +static bool epf_ntb_db_irq_is_first(const struct pci_epf *epf, unsigned int idx)
> 
> epf_ntb_db_irq_is_duplicated() look better, below 'if' needn't !

Agreed. I'll rename it and update the usage in the next revision.

Thanks for the review,
Koichiro

> 
> Frank
> 
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < idx; i++)
> > +		if (epf->db_msg[i].virq == epf->db_msg[idx].virq)
> > +			return false;
> > +
> > +	return true;
> > +}
> > +
> >  static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  					    struct pci_epf_bar *db_bar,
> >  					    const struct pci_epc_features *epc_features,
> > @@ -533,9 +549,24 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  	if (ret)
> >  		return ret;
> >
> > +	/*
> > +	 * The doorbell target may already be exposed by a platform-owned fixed
> > +	 * BAR. In that case, we must reuse it and the requested db_bar must
> > +	 * match.
> > +	 */
> > +	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
> > +		ret = -EINVAL;
> > +		goto err_free_doorbell;
> > +	}
> > +
> >  	for (req = 0; req < ntb->db_count; req++) {
> > +		/* Avoid requesting duplicate handlers */
> > +		if (!epf_ntb_db_irq_is_first(epf, req))
> > +			continue;
> > +
> >  		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
> > -				  0, "pci_epf_vntb_db", ntb);
> > +				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
> > +				  ntb);
> >
> >  		if (ret) {
> >  			dev_err(&epf->dev,
> > @@ -545,6 +576,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  		}
> >  	}
> >
> > +	if (epf->db_msg[0].bar != NO_BAR) {
> > +		for (i = 0; i < ntb->db_count; i++) {
> > +			msg = &epf->db_msg[i].msg;
> > +
> > +			if (epf->db_msg[i].bar != barno) {
> > +				ret = -EINVAL;
> > +				goto err_free_irq;
> > +			}
> > +
> > +			ntb->reg->db_data[i] = msg->data;
> > +			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
> > +		}
> > +		goto out;
> > +	}
> > +
> > +	/* Program inbound mapping for the doorbell */
> >  	msg = &epf->db_msg[0].msg;
> >
> >  	high = 0;
> > @@ -591,6 +638,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  		ntb->reg->db_offset[i] = offset;
> >  	}
> >
> > +out:
> >  	ntb->reg->db_entry_size = 0;
> >
> >  	ntb->msi_doorbell = true;
> > @@ -598,9 +646,13 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >  	return 0;
> >
> >  err_free_irq:
> > -	for (req--; req >= 0; req--)
> > +	for (req--; req >= 0; req--) {
> > +		if (!epf_ntb_db_irq_is_first(epf, req))
> > +			continue;
> >  		free_irq(epf->db_msg[req].virq, ntb);
> > +	}
> >
> > +err_free_doorbell:
> >  	pci_epf_free_doorbell(ntb->epf);
> >  	return ret;
> >  }
> > @@ -666,8 +718,11 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
> >  	if (ntb->msi_doorbell) {
> >  		int i;
> >
> > -		for (i = 0; i < ntb->db_count; i++)
> > +		for (i = 0; i < ntb->db_count; i++) {
> > +			if (!epf_ntb_db_irq_is_first(ntb->epf, i))
> > +				continue;
> >  			free_irq(ntb->epf->db_msg[i].virq, ntb);
> > +		}
> >  	}
> >
> >  	if (ntb->epf->db_msg)
> > --
> > 2.51.0
> >
