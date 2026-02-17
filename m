Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F411D63F0;
	Tue, 17 Feb 2026 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771296569; cv=fail; b=higMVIMo8CHZQmfItlO9NCGfk0lwtXLoJfC4109PPLmm3x99ATqvchGLtelwcYkFBZO55NCx5J9jCyrzPGa/uk1lXfoeFlv+kzJwTRQXPAkrBv5vzF5mcabmJEklMouOcvjKKSaeW/14T96rjpJMDhBcrfgtZDIlTRqApsi5JnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771296569; c=relaxed/simple;
	bh=bUi3Ps3GtxDaKEoGio2Y6LgG/5OSx/LIbqZ8SrtPGG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nUF0v4eYL8/GVB7v+9tPFPAZwZNmWHFirMhbgSIoA757dNsdHKwubRVuO/SeV4lxAKkXrA9bjz6nABiZF+OAX9itrATc0uPMTx3UnDoPw8/HiXHkdtYKfgTVi3194MI72vXRC+Lan2cv8MNbBWbST5bpqcdfRhPQ5oOY0Wekokw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pfLzhU2t; arc=fail smtp.client-ip=52.101.228.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pfLzhU2t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAwfd+02qyT127flWxOb50Xw7maeHj4t6ABp1IgKySCfd0UM/m+EzlIZawJ5QncbNADpZBLS5mGxNKLqfoUIsP035YPm7p8qBGob3YIMcBwFn6G1M/PfkcJTbyzMNj4j+mFduO2QfTWiFzOz+fsWTX0yg1yyh/xGxMnE5yP4oWivjJo7IBj36pxDTXHSHE4+YVsgPWhtN1xyq18fChuLm7p/PgmY7dvGdSU4yoa27yoWIvOCeZ8n/FN97UgfleWVCOa58qHywTYhltBtSrDLkmknL8v649STRMPRe025IbTFs3KSFoj2txQ/07vsbItekQOVYHfoKm9Dm8qhjCuw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USn9VauAx4AExr64XUBUwzhR+h7mHW7oTin8YDfNZtw=;
 b=m8J38Fp33fnEy6+v2mW/9smmAx9SMyUN2EEUZ1xC9+9fXrraTKsO+QYM0vpioLHTHGGkZdK0zuKaELgLO22wfh8tDff824glpZJso7OJogRMLytvvlt8S+BmivFTKzRCaZq1aCLuGcmbEJNXAB+L8ofVV27GVtx/+RpOlzAnn147rdbPFz730Kcv5zjDCBT8dLunZsyzlG6Y7tO6TTsHZsoXZ9XsdtIeiKurpfQP3j6PwZQ2qYMRLsDraiepJVIFpXOh0YU8QrxtKhcg/2XgTF6rijJdiRNswIebubhy4+3PY/Qb+0yFItKFgX8XzHoHxXhFOB6NYNo5lDA7+ll7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USn9VauAx4AExr64XUBUwzhR+h7mHW7oTin8YDfNZtw=;
 b=pfLzhU2t79dj2sJdnv1vq7tlrkehS5KJ19KpNkp4GyVTyA6fBnhREKfvOE/BbEe0KjDtZbPUmaPmOYMhX9Z/9Mi45QQocdam+YxzsbDPMq0IySFaWnTCFGfs72aCRJpdGFFerZufNMqY98RWtkx59mrr9apxYzdR8Uiz5FAn2kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2068.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 02:49:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 02:49:23 +0000
Date: Tue, 17 Feb 2026 11:49:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Frank.Li@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 3/4] PCI: endpoint: pci-epf-test: Don't free doorbell IRQ
 unless requested
Message-ID: <3p2xxxpbsmkxqbwsdtl7v5itv5fnmyi72sltnsn52xtxtnzc4z@oxj5ktatnp4g>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <20260215150914.3392479-4-den@valinux.co.jp>
 <aZMBHNd5zOgDGYbu@ryzen>
 <p57p2nsf3csq5h3v2kgiubiqnl2bioewrofnyszmcvzkydlxl7@iyxbzrogccvn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p57p2nsf3csq5h3v2kgiubiqnl2bioewrofnyszmcvzkydlxl7@iyxbzrogccvn>
X-ClientProxiedBy: TY4P286CA0083.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2068:EE_
X-MS-Office365-Filtering-Correlation-Id: da7e657f-8985-49c4-76fc-08de6dcf27f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uL0VUiA1jhGst04wUNyQPbFQvEev5df6nkjc7pJSjKP5exzRWWBrp1xpZIue?=
 =?us-ascii?Q?Kg9Rwc625cFZxpmZONlKc46BZmA+o5nit+yfWcl1J3+pOC/pgNSj3CGMQS+i?=
 =?us-ascii?Q?Q7DjNejKb0yTOyIoCxY236iNdhpoXro4DxFgXXoHp8iBEGlyUWR0zUu/5dXA?=
 =?us-ascii?Q?aDrziw8IfO0dTfiXhUSG/ksfnWSCH5KD52CwsHulw/t+BT+2FcKQ5CokZJt2?=
 =?us-ascii?Q?Y+SDzByCUENEDayMrpqmQcaS6g/rJiji+e5J4CCSw89ID27vKtR26Nn5V+RR?=
 =?us-ascii?Q?DKK4H1j8LugHcgvgU7yxQfjiyQrDjHBk+62ogIyylnE66yZ9n0lpstCeW8KY?=
 =?us-ascii?Q?MLxewvvEXAdgPXK2Jhjf2bDxXn6P0x4iPaPBAFixefeGcgwP2/VXRB4Bsrt+?=
 =?us-ascii?Q?+FSAnfliTSHnW2BGXil7/Ha1NGYBZPExA29+HA/SP1QKPK2v3ipUWMc33YpA?=
 =?us-ascii?Q?RBgRNEZjN0s1zNueLccleCAkjFCIll4RPQAPFuH9jp22Bhw799ig+vSWxtgX?=
 =?us-ascii?Q?bvE1t7eh6z9DOuCHMzzA5YgudBkHyYUDmzJxHXeraDVTTTlfz2Q109e1+Rle?=
 =?us-ascii?Q?hSSwSXRfb17c4myXYxYy5UxsSjE1hUflcn0d4SI5wajXPPKvY03xeJcHGw8d?=
 =?us-ascii?Q?kAnhD/8pxlcAMWuQ9NtWnG2JZ9d5t+tcPz/Svy19Z52nrjGnb8G/71ib0i7u?=
 =?us-ascii?Q?j4P8WQOPNlStoFHX84HE2Khn4HXopQXX1Xg83vhGs2a07ComVLV6tDn9D51G?=
 =?us-ascii?Q?F2JFnOuBaoSw5Uzy+lMC4xfXVVEqKWCtjuHL3/wEqrsLJst29eIhOTq1wW12?=
 =?us-ascii?Q?g42fHmOUDyYfrr6xJMAQkzhr5YTjm1o4A8HUOH18qQOErGvtwZdlJIC0894V?=
 =?us-ascii?Q?IZxV/+aV1kq/VmEYW3QXMeqcuE3IlCZtVlo9QXGkK3X0FyAVrJ5l2M+cLgQ9?=
 =?us-ascii?Q?+HNXEEVmj1W9e5WWxfGp38k2fRpgOHzDrK9nQyk8HfniJtAcd+vHYJX+1arZ?=
 =?us-ascii?Q?wH0XG5vufLlv0kKHzBHAH55Y6xnA/P0QogEG99EFhXahCt7i9Fn1vbAjK0VD?=
 =?us-ascii?Q?Xe30eMBTiIm7hPVFDpjDh4rFPu8Xc9/1ZRg64A6NqeWWIrkcGiot74bZQWXQ?=
 =?us-ascii?Q?2H+m15Wzfpd7aIqFZa16HyivihAeO0OGM4453Nl/UU8WhnhhhjmMTRL5T2uH?=
 =?us-ascii?Q?0oFo1h4zEwXETfpr4KUtSfwRjyUFBsS5KSRjnIZn4kjwdafaoqLLBAdJhoiW?=
 =?us-ascii?Q?fqMxmiKyZL1A8lqHoftwEL6otxlVT562zklPv1Thczj8YroEkawZd3UaAqc0?=
 =?us-ascii?Q?+vSv8f5l1L3SBJhvS5P10J14nvaYHTF8Ex0ZuIk+FwVkb65eAGzzKfxqvehd?=
 =?us-ascii?Q?tncQ8oIikR7Nesjoi4+FFIZbtPE9ILG+J8zTBcp/Omfcvbr9l8WY1L54XiBm?=
 =?us-ascii?Q?IqOU1H9nz1NWiitlSjagmGLCmZEdeNOmpnZKjAze+EgpGzixQnrw4iJby2zP?=
 =?us-ascii?Q?wQIeSD1bvruHh94zGhYz8zs7eIEXHtzpLT/mnrC9Gvc4vr4mXO1lr4c9u09v?=
 =?us-ascii?Q?BKtPS7+hGZqauyrKYyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wqk6vY3unqnMEGX/92U3JR49nzLLcs2dM71QWSZRhk/HkPtH6UMwzZuee82S?=
 =?us-ascii?Q?74frB4B1yS/AkPWGOPgHesHYy4Zv7z7ty36MfGNjv+JL3aAy36Wu7dyYz62s?=
 =?us-ascii?Q?QgQQPEQCG9Q8gN5Fd2YqedfM6P/w3tfmswI0lichXDXTUGToiuYodq1jqBpM?=
 =?us-ascii?Q?H0co87sXbywGeB8NvoVVYztdd7Fpu/ZKErDvagT9SoI23BLanzlmbWvpGSS0?=
 =?us-ascii?Q?7EeXcF4bT26rwGskKiq5jy2TzJK3rlurMIgF1kCgXKe7KFKfrhogGy9RDIOm?=
 =?us-ascii?Q?cSDUw+HlxbDnns5OYt4bg3xl3KRmfVgWn3Q3xxbX67RXJ5lylUxhRdRy2brS?=
 =?us-ascii?Q?PEwxr1wANZmXW+VTf/lpj/C7wF08IYmAVJgb4GZ5UuSNL5qb8QxB+lsQchuV?=
 =?us-ascii?Q?upPh55ZoGTzyKDipnKgfuvYpQgW3/k2wdgWVJVnYxNtGf2ofCM60lf9hji+v?=
 =?us-ascii?Q?Xalv8teqHkefdvdq7Sw4S+spaq2fDCLNWk83zKg7UhDWwECmexsRbi2bf1kG?=
 =?us-ascii?Q?XxU8dh22avd8177JZCLnr5toy2Y75zlh6X8GQ82eRXU7ucqr4NyiaWKPdnwC?=
 =?us-ascii?Q?L41eQZ8c1OiJIxa0KPAQHX6kz7CXYE4lKqTpHll02cHx/3WpmAeCxVHxzBdK?=
 =?us-ascii?Q?FJ83XfwRyTGEX0yAjJtXsfiFj3yMR1QgZBNnDrm2d2JaWQZsJv4c3+7C/RX2?=
 =?us-ascii?Q?kmcxL1Cboncg2fRPuF3f/O8crqNL4zeQHAyqRJGQAu5N7bip5AFjF8dvmXWD?=
 =?us-ascii?Q?DXLy6IlEsbjsZ97w6hFQQCYzjh0hmFx5d5KB5mMry4rqjZzgW5+vu1R41swc?=
 =?us-ascii?Q?QqRE95NFjqeD5XCTgEJkb6WW7IU/jG5Ub2fh+xxyvnHrs7F8FCHRWgsIx3kG?=
 =?us-ascii?Q?eaN4AwOXSmUh52skqVL1R92WKrKjFR2mi5btzNzZQquISf2HrTlBHLSqKIWp?=
 =?us-ascii?Q?GcGwhsmO1tujA0ZyV6NnvX0XbECof6njBR3Uo8tX9FFRmo/NkHw2M3P9OiXk?=
 =?us-ascii?Q?jOZxu0AMCgfi8uRAsxmTb6S1mu7WxMn0tzF5ABxWDkNpOPcB4pp4FwjKJbnL?=
 =?us-ascii?Q?e2FRmEQDCrgtGM8/lQYmn40ZOPMyMhlGZzvL+PG1q4XGn04azCuR4u20rhPF?=
 =?us-ascii?Q?RlIcHVlTXQsbIEHag/expgH2SwCcUyFYrhwNYqvbqNFrGWtVZO+pP1PXDrGK?=
 =?us-ascii?Q?aWByZjM1PvyH/o0cl8JMz/j7xSN3BHnUNPhZD2vXey9Ed7QNkSDfM9y9kKp7?=
 =?us-ascii?Q?S1uBZFRay2Hw/4f/m7gbYBD1CWLaXxq3ohucfUd92CUYqHtS1MixxPArkYeR?=
 =?us-ascii?Q?7rGXAr7ywBvc9rAXqrDjkphz7xx2HrgWxwxqGHkTA1AVZO+/qI7U9fYaWxlx?=
 =?us-ascii?Q?qO0wsA4onmMfprAZT2E7rav3yOpFS0N0soeKltqRwGYJ4Op6PsqdUsd2FmuS?=
 =?us-ascii?Q?qkJR4fzj32m2xs/1RFPaORvXURznmyqfIY0i2v6p7csOxeM9RGvfW6zqmXyN?=
 =?us-ascii?Q?TSxeRAjtCBE0IWgHzM2aQwux+X5s3DyMR0v/c+iyJRTsQON2vqOwfRZMEpNs?=
 =?us-ascii?Q?lxKp2jqOYLQzg/a7JxdRbRHu9dfTAWYjEWGhNpTrixqQKxLJhH5PTg0Gtiiu?=
 =?us-ascii?Q?YAGcwIvBGrLFznntppTpVXxcFrZr4VuN/kBpst6dJ8s4dkqVplu/HwcKcvMc?=
 =?us-ascii?Q?xDFTBJtKKcuq9cXGAr3dUtj4UpiQzbpaefJyq8jVIMj3KLb5aWMSkehQj4W2?=
 =?us-ascii?Q?8QSDL7F2ey0WMy/FnhowJKrNVzun+h7CXN77AV8ksYwmDRqpktEB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: da7e657f-8985-49c4-76fc-08de6dcf27f8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 02:49:23.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDeW36rNRIHbgo39UwqrNycyC7nwKdDRfR1gsPH7PYJZLpaKJj2n98SQpmaFJ4gYpDb157lH6klOyJVX5tX05w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2068

On Mon, Feb 16, 2026 at 11:30:44PM +0900, Koichiro Den wrote:
> On Mon, Feb 16, 2026 at 12:35:56PM +0100, Niklas Cassel wrote:
> > On Mon, Feb 16, 2026 at 12:09:13AM +0900, Koichiro Den wrote:
> > > pci_epf_test_enable_doorbell() allocates a doorbell and then installs
> > > the interrupt handler with request_threaded_irq(). On failures before
> > > the IRQ is successfully requested (e.g. no free BAR,
> > > request_threaded_irq() failure), the error path jumps to
> > > err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().
> > > 
> > > pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> > > doorbell virq, which can trigger "Trying to free already-free IRQ"
> > > warnings when the IRQ was never requested or when request_threaded_irq()
> > > failed.
> > > 
> > > Track whether the doorbell IRQ has been successfully requested and only
> > > call free_irq() when it has.
> > > 
> > > Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 148a34e51f6b..defe1e2ea427 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -86,6 +86,7 @@ struct pci_epf_test {
> > >  	bool			dma_private;
> > >  	const struct pci_epc_features *epc_features;
> > >  	struct pci_epf_bar	db_bar;
> > > +	bool			db_irq_requested;
> > 
> > It would be nice if we could avoid this, it looks a bit odd.
> > 
> > 
> > >  	size_t			bar_size[PCI_STD_NUM_BARS];
> > >  };
> > >  
> > > @@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> > >  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> > >  	struct pci_epf *epf = epf_test->epf;
> > >  
> > > -	free_irq(epf->db_msg[0].virq, epf_test);
> > > +	if (epf_test->db_irq_requested && epf->db_msg) {
> > > +		free_irq(epf->db_msg[0].virq, epf_test);
> > > +		epf_test->db_irq_requested = false;
> > > +	}
> > >  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> > >  
> > >  	pci_epf_free_doorbell(epf);
> > > @@ -732,6 +736,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> > >  	size_t offset;
> > >  	int ret;
> > >  
> > > +	epf_test->db_irq_requested = false;
> > > +
> > >  	ret = pci_epf_alloc_doorbell(epf, 1);
> > >  	if (ret)
> > >  		goto set_status_err;
> > > @@ -751,6 +757,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> > >  		goto err_doorbell_cleanup;
> > >  	}
> > >  
> > > +	epf_test->db_irq_requested = true;
> > >  	reg->doorbell_data = cpu_to_le32(msg->data);
> > >  	reg->doorbell_bar = cpu_to_le32(bar);
> > >  
> > 
> > Can't we do something like:
> > 
> > -For all goto's after request_threaded_irq() success case:
> > jump to a label that also cleans up the IRQ.
> > 
> > For failures before or at request_threaded_irq(), jump to
> > a label that does not call free_irq().
> 
> I thought this would be a minimal change to avoid the problematic case, but I
> agree it's not very clean (the "db_irq_requested" flag looks a bit odd).
> 
> So I'll split pci_epf_test_doorbell_cleanup() into two helper functions to match
> your suggested structure.
> 
> > 
> > 
> > 
> > pci_epf_test_disable_doorbell() should probably return error
> > if (!epf_test->db_bar.size)
> > 
> > (before pci_epf_test_disable_doorbell() calls free_irq())
> > 
> > pci_epf_test_disable_doorbell() should probably also memset
> > epf_test->db_bar.
> 
> and I'll take care of these suggestions as well.

I revisited the latest doorbell code with those latter suggestions in mind.
Looking at the current flow, it seems we may not actually need these additional
safeguards.

- any error path inside pci_epf_test_enable_doorbell() resets reg->doorbell_bar
  to NO_BAR.
- pci_epf_test_disable_doorbell() performs its cleanup only if reg->doorbell_bar
  is not NO_BAR. When it runs, it always resets reg->doorbell_bar to NO_BAR, so
  it cannot effectively run twice.

Given that the guarding logic is already centralized around reg->doorbell_bar,
explicitly clearing epf_test->db_bar does not seem strictly necessary.

It would be more of a refactoring cleanup than a functional fix.

Koichiro

> 
> Thanks for the review,
> Koichiro
> 
> > 
> > 
> > Kind regards,
> > Niklas
