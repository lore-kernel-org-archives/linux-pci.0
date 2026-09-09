Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020107.outbound.protection.outlook.com [52.101.229.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474F2D0C75;
	Wed,  9 Sep 2026 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919315; cv=fail; b=o6+G5V+pRh5EFLy3eo8VirnQ539BKKTx1wXkownL0qveZcPNhx11mH60Ie3i/RdcWkoDeS6VkW8t7oTXBWjagSqKtH3VCSNiwHoic5/CaYxF2x+WVjhLQpLBfVeZ/Xj2bCxtjAf0y1ohoT0AM10t3iIC88hHRqEuyQvTUgFP5kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919315; c=relaxed/simple;
	bh=Dv/tsG5KYa1bAE0/bhRWFZDrNXr64laIPWSS56iXH98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mFdm7gABRTgxgopufc2UnXj8uLOqKeAZrelb826m7SMKTVoOXCXVgZf4YU9h68jF+RalPewl0LMQgSjolsoNJ58QzupRL2ZFFQfLJkrge9bFU4wMwTpB2f+dAUo4uXVj7C2qR7QYB1YNoF+3VfiwhcuZjABJFxPh07MnMkKk2rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bybVSLG3; arc=fail smtp.client-ip=52.101.229.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bybVSLG3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaXH0u92T1EawUW1sK38jBWQEMxDxeF6L2odRwl38LIMNdtkI67LoZiyEWI1/MJquyq3elvrNgZhVJgUu3qfNLXGKLkeGGWFMlXbVeN8R841UaHgwlZvoRKqYtEts8tq98CK33aLcC2mJSkzw6yN1FA4A+qHpLgRN8jtfFPQ+iW9RSsYiOsf5sUF2EpjaaRYJZL/FEANcNZF7NE6FxbrxUEAhFXi/wHpPsYwHvNULVFAqWH0yDtLSydQdCC5IeIRcBEWXwP500MQ9JJztkRHQIaB2ODmi8T14fXqpJuDPbnjk3OlaCP7wXDtTzKYbuugPgUj0FGzPC6+xjBW075y5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW6O9+NCD4XaKe9w9cHgtEYy9wjHSlBE0jYx+FBOtvc=;
 b=J6hUh8S9WE9SsfTO3FrOVDuXTQSDzB587IU3e6+XGL2g376HlNOrpIIDNtAc557iQpP8QtV8ER/LqJsLoi1vnCQcX2VXi+CRHMrPJEYBR1MOrhlcXBLKJCSNQx+1pWziKYGBoeFFacAQTqsfntytzSH2H9ON26t8HtcI5fwz3TyibNxMyFe18Y+1hLwVR2C57TEbteUEY0Zj9CP2PxRi6uJAsEnNGsefAu37hZNN4Tm/CP4lA9LX1Xbk8KXuKBPE+4w9Kp4rODfnnV+GiZZElXnL3eImYwPiBcJMNTrG4mkoHngLoBEjlypTN7i/QcQJ2N6OprZdt48M7S4Re3N0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW6O9+NCD4XaKe9w9cHgtEYy9wjHSlBE0jYx+FBOtvc=;
 b=bybVSLG3INYNOj+jQH9ygUsfnMYqB7ZtxO6kyDFazWq/9y8X477N13dOllZPnFrzdixOQV1AYixm8Wiz5Vf8tLT4dloTp9U5g0eT4ZHf+w8CXApwExMAezByWMDtECreRjqqWTWaSKVUogcYrr/qKS31cHxLcaMqBWQNnZjbOWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7584.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 02:01:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 02:01:50 +0000
Date: Wed, 9 Sep 2026 11:01:48 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when
 BAR programming
Message-ID: <3nerafdorapt7erqpkqvsamuzy2ms7w23g3vrs5bildgxu7e3k@ml2udfhaqodd>
References: <20260728172306.2751813-2-den@valinux.co.jp>
 <20260908165315.GA2710333@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908165315.GA2710333@bhelgaas>
X-ClientProxiedBy: TY6PR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e911a4-7e8e-4e81-5857-08df0e164fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|376014|7416014|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	PKq4/OajpULVcZToH+cxHYMEtpxNlv1PgmVLBnGtqavESoPvkQyyven62u+CCJejlZHq8mjGwegJwdqZdyt6E77GKb3o+r10VFfSMiH+gbG+XaDwFNuMeCOO5QMA2TjRC30MBv78B4Q5QS1AHvsKzhY7IPUIAyzE+fNe/LwtIy3n35nTv2PHdZ1Yzt33cXrEYRVP+hnGPN8cMgU7Zs7MNvpWrN0ctauhmuCJiKeRItOlAQ3WrxqRBoAJy06S6YcXM2Ry+Mt+i0KWPbuir4OumYEXTXRMwYWAh9TxdnCBiQCkpfC4KcomuLG4H2Lvopj/2zBlgQUbgB1gP/innANUv0uKICRy56m8a+TE3GJ/b1KUZiS343XidSgG537IzM6+dl0aeWTU7y29smWMPTHBwNHcEhFrzLmcwbQgHTIdSkXxQVPXGV2Cwa0wl4qtBqf5TRHJ6oWnOcXKzHVBVAChUWq2R6XFLMqn3Iywk7Iakfg/3ON03WR4Pxu2w7z4OgEYIJm8DnOT1jiaTJuE35tG4S6LyjyydQbplUDVQEqwOopPgtyJTlLyxDcCNl05xLGjOvWWrFVvDrZXFASd8pLRpwrFi9lYejgA9aDerRCA0GmuU9WmfdhytORTF0k5Ii6A+WyKSQGfbDuf25hsFoshYuDsi+HW6RLAM0YJV5Ubi+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(7416014)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+oL4A1n2gL7J0vpqJ4kxYivOaYVsqK/x6RgzOfMRNK3tF4MzcCENfaaMcA4o?=
 =?us-ascii?Q?c1uYX1umxia1g+3FFFGFzR/67dkkfxyYY2EIprPjbcvHQIHGneJA2/Kuztla?=
 =?us-ascii?Q?dAYPrrZxupDmaxIb++nXE119le4zw4qx9HRsR/+qIeJ0ItMsd+yXN+Np6Xz0?=
 =?us-ascii?Q?IVRhEZS2Ozt0X1JbPXN66pbt3TVCX5yZeGF7Zs37EQklC0bd72Ki9QzqvvuY?=
 =?us-ascii?Q?iyUwFyOyDcio1YXh2yVErXZoBSYQCIuUmCQgwz5BYeWTV/+lNct1anMBAlBO?=
 =?us-ascii?Q?avM0DjlVRcJ0jUTcCKX2Ae4d41SkjxZEIP9RRCf4lrYj9Ri0yEweDL/hQ3XM?=
 =?us-ascii?Q?MYnmRiw5fj+tvsUxMVQlekGIXWkXvJ74ktdXifE5N5LKJXNssO/xGxt3ZZwi?=
 =?us-ascii?Q?yCoLYeBV8K/rwDjVA+Bqwxdh+skd5Zh+PpY8bhdPswmyz/lTXgbhUyy4v/5S?=
 =?us-ascii?Q?6KOfJfSHajaHSgSXpzp/LBeAUGxusg+B6KLf0a6zpJ5pJV7vcoJ60mA1+SPs?=
 =?us-ascii?Q?DRh0wyUagDvvDiOl6ZyEUl/qOpFqkfmQdLabWyO+p1hwb5gcxZV94qixLofs?=
 =?us-ascii?Q?NzSy8tgEPt337EzIaBDtEgLR+ZIlKKimIcSDvEq+z553K9b33JGX8GpEe6rB?=
 =?us-ascii?Q?tqde1vthPB4oqWXm/7fQGzqi4kenGs6ls/qh2Fyge0EBK9OCrAdneruJQ3d7?=
 =?us-ascii?Q?lv8gJMACXShB0qtLQviweJg+WG/LDQH4vE7KcQlntTjaVigA624Kc7KaAhCn?=
 =?us-ascii?Q?YFLj/P7Gtu6UYdUbVdHlhxAiIvg7ZXEdX6KrKroaKuERc9YIrhyiRQSQ+C0O?=
 =?us-ascii?Q?YRTYz6cTfAg5iF2+6Bg8p0mXb28pFtoEVoXTs9PUQo4Rga6LNnul+crEH82/?=
 =?us-ascii?Q?elERSQ2PQBMVoK0lewYGoybRmCm1SJ2netBity+t4GzqbBEr923Ha9DodfAv?=
 =?us-ascii?Q?KQeFs369f8IBf9atNLjQoBWxwtxhIfrQt58eNQogQrzvLqIsNtEVeLnqGV6v?=
 =?us-ascii?Q?B3KTgHhog7dG2FvAZ25TvuTitesOQmZYgWvo/pXU0iXxgpqF0gJGdg9Fx1ou?=
 =?us-ascii?Q?mAIPupkiOmtzi92M0wCJDyLCUKBHt8rEkccFJVgmuMakOl0F1JFDSMfJD8nk?=
 =?us-ascii?Q?qYbk+3o9x50u3D4KnKjf5FfXz/sbdpzk6kZR8EU6J6+uQqAeiksfV4oe8Qvl?=
 =?us-ascii?Q?OGT4vIaZQyio7JIt06Rtm5Nw8uo8AJmMYO5ttanIrtd96zrfK/7tT+KW9sGk?=
 =?us-ascii?Q?K6pk5whCgfgQW7iBVQPOzExFFCjBNwzqy4puG2CCWRhCPAjCzc8DLI7JzUBr?=
 =?us-ascii?Q?F/FCeRbqTF3oh1hP4BtNLSR+bG1vsNJcZLqfu9GuuXnTphVTXzaA0wIlNwfr?=
 =?us-ascii?Q?6B8pLQkFiR+vFBTXmNnB65yPpIndgDo671NfHQQr422lR/9CaqQzLFowaqS+?=
 =?us-ascii?Q?6pIe1yrco85PNDkqUYYeBroupgs3Nf5FuJfVy7eZOXANVbUoJhOtYNzz/Z7S?=
 =?us-ascii?Q?RXdKrUI5Tk/RgHYLSRj9v76gHMEJP+BKpgiCanYqccFvALSUEtijO9j6OIjW?=
 =?us-ascii?Q?iHY3cfFk6qL8FTKcAr5KHYlazeEasPdGqSi9g+aGFJaqKISN3eKcIKTsxs9C?=
 =?us-ascii?Q?atHqdx/fweu6+m+cStMfc3qFN+wjh6Qe6RjN+g0/1zTjjoDJAXTFCGpeGeOu?=
 =?us-ascii?Q?UAhkh2h3wLZhVOK5ZXKOpGcjifxWhJQiYhDyxFumKuFAYfQtuB33YVjNQ7pA?=
 =?us-ascii?Q?RQ06bga/qF6739IMI0jfkaBXKPQskvtrHzbbgDrz773MMzTjWI1X?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e911a4-7e8e-4e81-5857-08df0e164fce
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 02:01:50.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TNy1rra5tSmrty+NVOXFveQWV7W1TRSxf2Ky0JNmWXFdeCzTHEUZnIVl0cOE2zaFHJ+PWLtlNb0xgzePxqeFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7584

On Tue, Sep 08, 2026 at 11:53:15AM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 29, 2026 at 02:23:04AM +0900, Koichiro Den wrote:
> > vntb_epf_mw_set_trans() programs the memory-window BAR through
> > pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
> > lands on the wrong function whenever the vNTB EPF is bound to anything
> > but PF0. The other BAR programming sites in the vNTB driver already pass
> > the EPF's own numbers.
> > 
> > Pass the EPF's own func_no/vfunc_no here as well.
> 
> We're referring to these as "PF" and "VF" in the subject and "physical
> endpoint function" and "virtual endpoint function" in the
> pci_epc_set_bar() kernel-doc, but I don't think these have anything to
> do with the SR-IOV PF and VF concepts, do they?

Not in the specific case that motivated this series. But AFAICT, the EPC API
uses the same (func_no, vfunc_no) pair to cover both ordinary functions and
SR-IOV PFs/VFs scenarios. With vfunc_no == 0, func_no can identify either an
ordinary function or an SR-IOV PF. A non-zero vfunc_no identifies a VF
associated with the PF selected by func_no.

> 
> I don't have a better naming suggestion, but this is slightly
> confusing.

Perhaps a better subject might be:

  PCI: endpoint: pci-epf-vntb: Pass (func_no, vfunc_no) when programming BARs

Best regards,
Koichiro

> 
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index c3caec927d74..fba65abfb6b2 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -1427,7 +1427,8 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >  	epf_bar->barno = barno;
> >  	epf_bar->size = size;
> >  
> > -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> > +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > +			      ntb->epf->vfunc_no, epf_bar);
> >  	if (ret) {
> >  		dev_err(dev, "failure set mw trans\n");
> >  		return ret;
> > -- 
> > 2.51.0
> > 
