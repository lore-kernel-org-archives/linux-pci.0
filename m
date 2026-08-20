Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784D3C3F60;
	Thu, 20 Aug 2026 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213500; cv=fail; b=kwST43fbM7ycg7l6LKd11EPvd1TgJKG6THrpIycg40amjXCQMGBt9HES4NtsvuV6wxu3cGjOwN7vHcAjJc/Lh8mZN2KHsO4hzXnZ0SEQ75yuC4L7aLFmgNbAn1n1hhDrOrshkvbMivZEf3H6Z3zeOc0DNGN29muT4sJGqqsCeQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213500; c=relaxed/simple;
	bh=lvE2VQfiBNE8YgmN3xdXViu/JP034fOmdcPrOQS97Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUzZrvubdeqPdmCI3S6ewdW/pxvH9DsRWSvNE0X97tmTH0I5L5pjVsfEUHIGmTW61+YDFL9x77nKxjUNkp9FHvfZHkeQT/YiGqvZUo+mtJmV1xeVERourorQLOngYClpoiR74idEBCtCjYSKxzE6Gi5YZP14AXIK3RKHHWsPwmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dNOLo+yx; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dNOLo+yx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvSiEnQg0hVGcN+JSeHDeo+R5BjNLOOt0gwIXZdpTb4GXYtiwXS62eL3EK3rP882FjSkLg2slLGoOW9gDwSs2SPXwjhMLkP1O/WyGNaz2xnYg6mTQXi+b5bXA/yay+AW1Na9c/2BzWFx+F01iOvS2KqJ9nz0AFJcmC4Jm74YN6/LwJqY9ccF4TLcwbvDY4ZqDckorHzVCL/JzQrCt/BBXphMSbVIx1yv7EpWvc6Jl3fFrtQCOfstJ2Es3tyk23enyohc1YEZQp0Tdi6hdVVewcV/vQInVrFK/9HEQg5uXaVCUnDJXYn4J+JW53xsskk7D1gQhPa7b8b0na80leIuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9POSXjerna/GKbllNVtHWJgvFY6isEBkHGtzJrYMLv8=;
 b=GWo3WIKcAjMQPhcOI0Fo6VTXb0CgvjhYvjqfw1NU5xfNFX4xlQGWxvkRpshKXgbubmj2D1Gegad6F4pvC5zZkPkpEV9qXkc/MiqDXD8SiGHsvdLWCwdf/k28WUQcdCq8wg2RH2Fhoi/1t+HLHMDZDwl0Iw7bZcsP4vkj2Pw8QTWKRhTwPrPLbdaMh0+abEQxbX0AfbURQJAOa5uE9z1y82qorbbsd4r+S9zwBT/KRDV9+waofOJqLXCIj+N9VaVhnAMl5YH/tfjXke4KKh1s1Vgw0HapZ4jiDIpd81heaoGCUUvvotYCIW/XtkwZS9OzPRfYsM54G+gIzNr5F+Ddrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9POSXjerna/GKbllNVtHWJgvFY6isEBkHGtzJrYMLv8=;
 b=dNOLo+yxTvygC3yCvrnMtnhzAzvgR6ymiE4f22lttKoLToAPvIe6OkeFDS/ZKyFKnZNe+Wb9Nj0qde5Uza6e71dZQDaAy97WYYHfKQHxEJEqTl16OL0+d5Q/SAvwals7md6RSZmjYijVv8qep49fKqM5TL8wdT88HRmMziXyPGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3351.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 08:11:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 08:11:34 +0000
Date: Thu, 20 Aug 2026 17:11:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: rcar-gen4: Use .post_deinit to handle
 dw_pcie_ep_init() failures
Message-ID: <ymct5mjms65qy3hzlgfopzbrhqwdxk473awdqsguaamltchcur@fydxwbqqe6fu>
References: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
 <20260820035944.163472-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820035944.163472-2-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3351:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bdff28-7416-4c79-31dd-08defe92a62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	qGhhEiOkyUrD7xuVYhqpmzVU+Mj1cA/y+pwZXm5ND/1Atw+mspZQAxk6xSdDUy4uS/s2wePQm4SmtErp5LgZZiW4ZBR+qHoQV7Rg0fBfTndEETjUtjqkd54B9it5Gd6lcOlugzA79auExfWZ9Mk/Xj773OYu6e5KDYRHwFz9u7glvuhdxj+Zn8sFb+0TcfKQysnB7iTk1YdD7EvabynSTziwvmPJnI70q4SJiWjjQTDutMuBP1oTQJiq8fbB6tf9XlaQtS2Zm7DdfrTVFLwKmkTzE1twA8305//ypcB5rcP+clj62zBqpSdbMP0c/XpXSXMPL6T/lVKsLqbdd3wTtckPylmyC9Hto66ZlcIuvaXpqzfGB0FNQAU1BytqCjpqhptcqRn6f02l4wutx1m7whsZKmZqGjoUtvFWTiJreww6f6RuUgYVETX7oL1WrLQV3IHQUyngR/42DUZFJubQUlqI6TOlm/0A8vLs6yIUhBDpZ6JBtAjHhvE6gsuBYKwy+UUK9L/T+tkrYgRjEUxN8jXkvqgg2LS/XRkBUxc0azCj5YGsFYKsNOuVs6e9XbCkIaWNGBDDUjguPV/yF7FwLIKQ1cnLgVjHVeim9Nuo/Vg7qvxBYI3AEzzlVQR3AsRsxJ4YpUUg6CmhrtAUPyRJdAyxyN64Sq/bW2Bvwh2kzsg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1pDWjBvMnprTWlWcDZldktya0FDRkhOUmZCcXY0dzV6Q2NWOHpwTDQvaTlN?=
 =?utf-8?B?T0pQbTlYVmMzYlpLU3lwb09xTE0rcE5FRi8yM3QxWVVyRXRRMERXckdoMURI?=
 =?utf-8?B?cVZRVkhmUFd3bC9CNWlickQ3NEFndytGMjlXNUFsK29IMDVrY2pPU0hKSFlE?=
 =?utf-8?B?YjVCdkRkcHNENUplemVqMldlUGsyVnpyQndzeVlKcWdJby9VOVR1eFJVYThi?=
 =?utf-8?B?dm9BQUE5QVhVdmpjZkhFUUdXR2s5MWMraTA3cVplUDNOYnpHVCtqa2JnbSt0?=
 =?utf-8?B?ZEJxUDZ5bDdOcjJVaWRmOWVIYVBMSVBQYkx3WFEvN2NuM1dEczFjQStSNmta?=
 =?utf-8?B?MnVaSzcyT2VITmhkdjZmWld6d0M3dFBEUEVrRDcxcVlyaUF5S3BIRVVGeno3?=
 =?utf-8?B?SEw5c0pCNEdxVVhyNDhTQ1ZOdUZrR0tITmxsOWhZalhJb1h1S2ozaVNjdGZk?=
 =?utf-8?B?dWFHYzM1Tkk4ZWVJWVhxclhMUGpGSlZvZW8zT1Vjek85QmhkSDhqdzZqeTNl?=
 =?utf-8?B?b3EvZURONWZyU2pOdnBHMWxLbDUvWkVxYnhrQlA3MThoZTJFMmhrbmdMaWlv?=
 =?utf-8?B?cE9FOERhbXBLZ0tBRlBEL2NNb29ndVBmSnBEUVdSYVhZai9Tdk02WFdxVDdq?=
 =?utf-8?B?bmhhTXhZMVk0THhaaUxmcDkxT3BBY1MxL2V1b0t1Smc0MDRLRXZtMmtvbDZk?=
 =?utf-8?B?NGVpVVZpYmVrRk5QM3dmbjgrSVVFa3I1b2lUbXNzK3JabHJYV0t2RkczUWN5?=
 =?utf-8?B?OWRRTnozQTRDWFpITnRkcCtrZW9taHl6Zmg1ekE5MFpzNER0NkppMTM1dUpC?=
 =?utf-8?B?NnVhdWRiN1JRcTZVTGZPSmFjSDVHN1NyRmg5dUJ6ZGJwMWdnaFZBRjZWeUty?=
 =?utf-8?B?ak1ITlRnMUV3NitvUXhvaU93c3h2cGdtVU5SaWpDdjlnOS82TDVSYjlsamJu?=
 =?utf-8?B?VWFkZG0xWEVKU01GQllpcHVyUTFjMEpNbkloL2d6RU5YZUZLRHlTU1FaTnY2?=
 =?utf-8?B?WVJPK2V4QW5pc3ZodDVSRU1jbmZDL2M4NUlnaHlKM21jK2p3R2x3aDBwTnlM?=
 =?utf-8?B?anhzVE4ybTgxM0dtTFR1OXF6MDErekZub3pyVWVJU1l4MTZrSDRLQ0pQZXhD?=
 =?utf-8?B?bDFWZWUvRTk2TVYyNnZ5R2xEbWN2dVg3N2ZibzIyUGs2UHcxU2JLbU4wOUt4?=
 =?utf-8?B?aXZLSFZzRVZxeUg4b28yZU1hcjNKUDB1MlVYSkhVS1FsUFFtSi9PK2Y3RHkv?=
 =?utf-8?B?MzVVTjdId2Z1WmM0VzhSSXNHM1V2TGpNcEw1YlUwN3dzWXlEVVFlc2hDMzQ4?=
 =?utf-8?B?NGRGdWRGcWxyWTFUa1JucDFSUEpSS2l6VCtaaVhmWXhrMUxOM3BPZFFqTXVi?=
 =?utf-8?B?UmF2YTYzZ1FyMlpYQXlqZEhCU1ZtMmVwODgxYXN2c1ZjWk9wSVZkUnFQaG1L?=
 =?utf-8?B?MXVzamtHK2VGNjA3cDFoWTNDcFJKWFdVOUp5bDQzekw4U3dWUnZzbTRhbUgx?=
 =?utf-8?B?QW5mQ2hKWEdMQmlmbkVkelgxY3VRemR5bFoxSmVjVHBBeFBwbGE5bVJ3aXVm?=
 =?utf-8?B?YzBpbkU5cHR1cU5WYWlEQzZFZzc2aGtpd2ljdWVUdkEwb2pRRnQ1WlQ3Rith?=
 =?utf-8?B?amU2RzRUQWJHaURzSEZwSVBkNS9tVGJ5RWFjdFZ6NU1SUUZXUGczQnZNQSsr?=
 =?utf-8?B?WWd2bk9qckJFU2h1NlVKbVJCZ3pOdmEwamJWNnhuWkVKejFodlM2dzYvY3Zv?=
 =?utf-8?B?akNRclE0aCtHalRBRUZ4RU8vV05STFpIdFhmcWhidk9LaFlNa2hWSmxlN2JK?=
 =?utf-8?B?NWtvei9Ba0dYMk5XcGRtaFRMNUVkbHc2MUxxSUNMSXJvL3JWZVZ6VTZNbmc4?=
 =?utf-8?B?ak14M0dsM2hueHdWQkdvR0hKQzNtaWo0eTJxbXdsN2xobDlkU3BsY3RiRFlO?=
 =?utf-8?B?N1ZHYVg0YitzVzRvZTY2RnhhV0FTSGlMT3hsYXFDOENSVVBNMTAwb2FMaXgv?=
 =?utf-8?B?VEFuUmovNHFVN2J1b3p6elR5MDZBT2dkczdwUDVSRFd6UGpBbERHU0lyWkd5?=
 =?utf-8?B?SXp2dHhJbTRLcENrNlBVSDFRQjlrYm5uVDdLdUM1ellWNHpBWWs4N1pYODBy?=
 =?utf-8?B?eDVPdHVzdnJyL2NDZnRUbEFyeFovLzUxRmc0OWNQcDcrbGh3WXlhWG0xVEJt?=
 =?utf-8?B?Q2s3RkVuQll3TVN3WjRJSGttWkxxN0Nnb21Pcm10a0kwVE1pbmJ2WE56Yytt?=
 =?utf-8?B?dHFtMjFKUm52bkgzNzhBbjU2OEY3bUZ5R2lldzJ3OWRMK0d4Ym0vK1NJdmJY?=
 =?utf-8?B?KzY0QzNWSENwQVFmMmNtYzMvN25qOElsMTdhTzE5TXhpNDBmSlhsYUFiRDdZ?=
 =?utf-8?Q?m3RYQmnpf1fMg8p0esZSVpHaTww7BGYF62Lpo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bdff28-7416-4c79-31dd-08defe92a62a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 08:11:34.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XE/sEur+8WwtHzcfc+PJephYPnpcHYgOda1SSZS/eIjQfHUhIMjifyI8ahHqxSEguprq9/u7q1h47cHFDVPcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3351

On Thu, Aug 20, 2026 at 05:57:56AM +0200, Marek Vasut wrote:
> Implement .post_deinit() callback in R-Car Gen4 struct dw_pcie_ep_ops {}
> which asserts reset and stops the clock. This undoes start of clock and
> deassert of reset performed in .pre_init() in case dw_pcie_ep_init() fails
> after successful call of .pre_init() callback.
> 
> The use of .post_deinit() callback correctly handles the clock and reset
> stop, unlike the call of rcar_gen4_pcie_ep_deinit() in dw_pcie_ep_init()
> which could not discern at which point the dw_pcie_ep_init() failed and
> might have attempted to stop clock and assert reset twice, remove it.
> 
> Since dw_pcie_ep_deinit() also invokes the .post_deinit() callback, drop
> calls to rcar_gen4_pcie_ep_deinit() in both rcar_gen4_add_dw_pcie_ep()
> dw_pcie_ep_init_registers() fail path and rcar_gen4_remove_dw_pcie_ep()
> to avoid duplicate stop of clock and assert of reset, and drop no longer
> used rcar_gen4_pcie_ep_deinit() entirely.
> 
> Initialize PCIEDMAINTSTSEN early in rcar_gen4_pcie_ep_pre_init() to 0,
> to make sure that edma_int bits will never be set in case of failure

I think s/will never be set/will never be left set/, because .pre_init() writes
0xffff before later initialization can fail, and .post_deinit() then sets it
back to 0. Otherwise LGTM.

(Again, I did some quick tests on an S4 Spider, covering the normal path and
several injected failure paths. I don't have V4H hardware, though.)
Please feel free to pick either or both tags, if that helps.

Reviewed-by: Koichiro Den <den@valinux.co.jp>
Tested-by: Koichiro Den <den@valinux.co.jp>

Best regards,
Koichiro

> of dw_pcie_ep_init(), and will only be set in case dw_pcie_ep_init()
> succeeds.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: This is reworked version of
>     PCI: dwc: rcar-gen4: Fix potential unclocked access in rcar_gen4_pcie_ep_deinit()
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

LGTM, thank you!

Reviewed-by: Koichiro Den <den@valinux.co.jp>
Tested-by: Koichiro Den <den@valinux.co.jp>

Best regards,

> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index fbe465a29068f..157e33c4089b9 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -487,6 +487,8 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>  	int ret;
>  
> +	writel(0, rcar->base + PCIEDMAINTSTSEN);
> +
>  	ret = rcar_gen4_pcie_common_init(rcar);
>  	if (ret)
>  		return ret;
> @@ -496,8 +498,11 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
>  	return 0;
>  }
>  
> -static void rcar_gen4_pcie_ep_deinit(struct rcar_gen4_pcie *rcar)
> +static void rcar_gen4_pcie_ep_post_deinit(struct dw_pcie_ep *ep)
>  {
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +
>  	writel(0, rcar->base + PCIEDMAINTSTSEN);
>  	rcar_gen4_pcie_common_deinit(rcar);
>  }
> @@ -552,6 +557,7 @@ static unsigned int rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
>  
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
>  	.pre_init = rcar_gen4_pcie_ep_pre_init,
> +	.post_deinit = rcar_gen4_pcie_ep_post_deinit,
>  	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
>  	.get_features = rcar_gen4_pcie_ep_get_features,
>  	.get_dbi_offset = rcar_gen4_pcie_ep_get_dbi_offset,
> @@ -570,16 +576,13 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  	ep->ops = &pcie_ep_ops;
>  
>  	ret = dw_pcie_ep_init(ep);
> -	if (ret) {
> -		rcar_gen4_pcie_ep_deinit(rcar);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	ret = dw_pcie_ep_init_registers(ep);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
>  		dw_pcie_ep_deinit(ep);
> -		rcar_gen4_pcie_ep_deinit(rcar);
>  	}
>  
>  	pci_epc_init_notify(ep->epc);
> @@ -590,7 +593,6 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  {
>  	dw_pcie_ep_deinit(&rcar->dw.ep);
> -	rcar_gen4_pcie_ep_deinit(rcar);
>  }
>  
>  /* Common */
> -- 
> 2.53.0
> 
