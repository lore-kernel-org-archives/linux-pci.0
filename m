Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021096.outbound.protection.outlook.com [40.107.74.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC653D3337;
	Thu, 20 Aug 2026 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213372; cv=fail; b=cjZpPe55l+MPjOuQWoq5r1JovrO3V33AkCSwpq2A2bnF45nXR0ncBq/sdHDkKi0GgCeLl3BDt85OVMeOzeApfUD+JGCIImwnjTdJG9yH8+O0e8IBGpuM1NxvW2lFdWhHuEhR65MEvZQRm7p4haWq4N2kz8uSnHp0xpxEoGb3qFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213372; c=relaxed/simple;
	bh=GRhZOI3Cq5jCkeCsTLUKsXEjwrHwb5z9YjJaSB2tnCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aP3t/39lddY7Wwkz9j5t48qkPQNc8m3vtvOqzW3i93ySaapLAweYy+lgq+uFCtRdtaP2Cq2+yVObuWWaXr49LBj9l1VljuqW9gmYHQ97p6uGHf+yhlDeSzTNS99/9G4cNVbKhUp9ob6K98f/mmbwvdsGwINRkjfc42CeQua6zgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BvWNymK1; arc=fail smtp.client-ip=40.107.74.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BvWNymK1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAOtTdijfw7Iu9daOXmmuXYJ/IokpOooVm7FNXfXBthq7jmlYBNHIhCeE4R51aP2pn6VyiAO8LKDYBFZV9jz2KlfiXFgAxV/w28Jmi32kaRax/R0uUqwxfSsEoZPTFIQkxFpgTNm2Xi58D3QPikGBgKkS6n7Zivir+pszEQiDgCuSLBhtgrWO7UDENZsGQfgFg1RatFilZCbWxqnLSXKdA1AQFu46tRBUt80HYYpslokujjTfuUnQDeqRYrh85K9z3i0mw4DlhYCNiYBKS4fDx02DMYjNJ3JHPZzOpm0ILAix23schBhQBhHSzcZaMivl8bUgUCrT8mi8Y7izvz1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNU5BiHe/2o6y1ibGyegqEG0L1TgSKSHb63kYYWM8GQ=;
 b=Z+8eKYzgElw3vkNmOZU/zjxbNhtkaW4W1rOXHSUeUDbD+3e+xw6016SJmtnHXJB3r2fpvSfznQG2GZR1ZRRjgvKzagvZVTKz4ZKye0HIxAjXKxjqNvCnmKHepMcV2aM//TAtBhT+QIZh00z4j00AVN4nQG4YvVfTfSRCXvu8TM1Szbawmn/ffctus2o0ADHtBOZSiLTC3cSnu0tV+0bxUX1YwpWGW8o84NQ1LchAtg6bFksPce/IOWbUy1Eo86kyiPYWqzgbUNr0gz9j8YWLpk85g/CO23UMdwOhy0obLjhoYJiRZcuuHgisjbHGcAHjX1ajyuDLFlGCBh4vgR2JnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNU5BiHe/2o6y1ibGyegqEG0L1TgSKSHb63kYYWM8GQ=;
 b=BvWNymK1UgAYi4hPOxWbaQWL0++evcTZ6YyMmVmdCKSnfixUzb8iXcTY+3qM7K1SxurLV1xhRc92o23QrP7Zcp122LhrScw2Lju7HK8rGQha7fFzpLVvMavMmWl4p4M/RhdlNIjOGn5/gktAH4stMmwF/pMeW46Mmzp2ydC+ATA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2847.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 08:09:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 08:09:26 +0000
Date: Thu, 20 Aug 2026 17:09:25 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Add .post_deinit counterpart to
 endpoint .pre_init callback
Message-ID: <5vjlarzjb2luxfzri4ykpjbkhevfbmufbefdvzafi2oo2q4j33@wwizukzejsys>
References: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: TYCPR01CA0156.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2847:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e80036a-230a-46ef-241d-08defe925a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|6133799003|56012099006|10067099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zYqzna6+MudnHgy6FB97p8imME/kJeYh0zbDhP48/tF60Qs6FBMAdCC6+DFWQHhHgR3t1xW/UCkfrGVU2HE9ydMKqjFamecx0DnhAj+1C0dhRzEjsuPHVMvo09NXc6yG8LjpLZ9v7ugNXois1HwhGErrzJOswQuxuYw5gdgePxEY608VyPr0rYkEK8IM6cFTg2B3354G6a7VoWdZv5PGbV0Z05TkufApvY7AKXxB4sRxl4o8YLTbVJnLKC8P7DtGcm4+x127FJllbiZtWF6wSvCU9UwRiIX77uxYITrFZ2OKnsEFV+6DkolhJxcBCIU66HuGCvikkOg32IW1ODktjjSiUDUT6bg8rQ37kU33KEOcWQqRrHbf8t2A0YghCWREyF6uygXngrx0HxiBQ54hydR7GRPNe2flSxQfKSqULuAi6vsBcDIDST1f0df54PCD9IQ8R9n2qd9zc0TOFbE2NO9/se83rNVTJQpusq9XEWNXYjVS7HGmLUNXw1QPPAVAktv1xQj9JiYq1UEwlHuBwaw4OH1k/7PALtJzjJpYXqafxR/a1PCHfRu+u4g2OjKtiz5QxpitN1JLAklNULyJBYYmCk/7o0EnoRTTddJ3Fb0WXdYiYENbmJC+l05aI3D0scAQsxneZmgwdkZfrg6Us6186PkjSOV8XS7xi4DBLWs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azRSNW96bW0zdEJNUHpObi8wNVBOSVpvTk1vNHI0Q2xPUGZZVWFnMVc0VU9q?=
 =?utf-8?B?RkNmQWdvNk9QRFg2djluNXFTNzN0cktMS2g4RkM0Y2VBekFmc2tHM09PQVZG?=
 =?utf-8?B?UEE5VEFkM3dnamd5aDVnZGZyMkRWaVg4emk4NVNGbjFLcGdCc3cyL1cySU1R?=
 =?utf-8?B?MFBOc3J1TEZjZG52N2ZqOGdFcmpMVk1ybFRvV1piOU8vSEV3RDQvazRoNzNr?=
 =?utf-8?B?K1dHLzU3enJ6WHdQbTBRUnpRb0NCVjN5WE5ubmFYU2Z4OEpVWWxiSEVEaEU5?=
 =?utf-8?B?TlNKVVRjQy9YN2VIanVTbVRxK1Y3UTg0YUVDR1kxbVR5aW0yeGl6NEFyZlNP?=
 =?utf-8?B?NHdZZEtpLzZmd2FtbVZqQ3U3cDllUDYrdDMrWksxTmpuSVJpYUFMNEZQR05y?=
 =?utf-8?B?czNJd0xMb3BFZWdFWnA0L09iMjNMY2thNWlyalYvSTZSY3dLckg2ckVJL25o?=
 =?utf-8?B?aGNDWmxzcEo2dHVoZkNTZk0zU0xrK2o0R281Vm1aZlc1Uzk0aDNJWXYrZmRG?=
 =?utf-8?B?SW1wSXcwMFBsZHZReFowUDZ0Zk5hUE4yUE9TbDE1SzAzeXJGR2FrblBEaXJ2?=
 =?utf-8?B?TjB6MGdpa3JOckNjQk40Y0dBOEpzdnVyK0ZrazlzekR0YXlPeXNNZERaaXhz?=
 =?utf-8?B?SGhKTEp6SnhTdVFIdzhVMXNWblhwLzEwWHBJWElTVlFTaGlvaVN3WS9yK3ZQ?=
 =?utf-8?B?VkNVV1FMUThYR1BxWW5Pc0NRZ1dpc3owTFBlVlErek1ISWRnV3VzMDFjb0Mw?=
 =?utf-8?B?M2p1UXRwRng5dGxDeldkK0VlSDJGRTFkUE9oU1VHWGxicTcwM2k0a1U5ZkdO?=
 =?utf-8?B?Mkc5YWNWRXBjd0xOMXpSc3dpb3pGMzVSdTE2bVZLQXkyQ21QTVBlNVIzeUJ0?=
 =?utf-8?B?dTZTRXdiNTlCRUhpRmh3TEdJdWdPMlcrNExVRFd2eUVqWVNJdGpEaVlqTXFt?=
 =?utf-8?B?MkVCdkNwcURvZ2U4UHVCQmF0K2xoMjZrMis2bi81MHplZnZYNkhEYjFQczFy?=
 =?utf-8?B?TWlXVHY3ZWJmTGYwckE4cERlQitBQk02ay9BMytuaUdJREc0cHVLT3YyZGJJ?=
 =?utf-8?B?Z2xBNXh0UXdFU2JjT1VOSHZ0TnpJUmxVQ2hVQUxFSjFYTU9qYnptZ3BZSWZ2?=
 =?utf-8?B?TTVDYUJjd0dXRWRiYmg0dkVxUW9keGFoWVR1TVJ2UzZSTGdqR3I3WHdNdkt1?=
 =?utf-8?B?TUlxYVNLQzNBaFpCZGdiZk1BMTgxYmowdXJGeG9NcHRXanlLckZScWpreWM1?=
 =?utf-8?B?Wi9rcE1ySjdDRjJMUmtvK01UVEphWDFxek53cExoZkZPbUxPRS9URGgyamZr?=
 =?utf-8?B?R25pRmQrbnlwbjdoMjhnMjZjMXJ1SkJFWXBGTGt4RTZrZVJmTTZiZGdaTWJI?=
 =?utf-8?B?VGlOY1RoNXZhaWRTTU5sYlE0TEczZzY2N1N0WGtqeVR3TlE4ZWVuTXZuRDlL?=
 =?utf-8?B?aG5YMG41T2hSdjc2QmNBaE5rU1dGREJKNzAyUEZLZVRvbmF4RHpWN0VUNDNS?=
 =?utf-8?B?UU5WcmdSaDBMTkpqQjhCYVpWMTArdllCQ2N4cXhXWTA4OTFtTlphTjdvSnBU?=
 =?utf-8?B?bU0yV2RLaWF6QzAzQ0UrNTduNlFNRVZiREQ0eStXR0I0aDJMQVB1dHFPekYx?=
 =?utf-8?B?T2swdHJFNWVSTHVNTjZ4L0toYURHbEZkemRHNVJsczFLRU9aREIwMk1qalVZ?=
 =?utf-8?B?R08rUWFZM1F2TjVpeFJQaU05M3VmUVRuOE5JMXlsS1ZNZ28xdlJXUENoZnM1?=
 =?utf-8?B?RXZ3aXVVa3BTdWhwakFUbUh0K3dmQ3JIMEJkNVBBSVhJODZuMmhjTzhoQWo3?=
 =?utf-8?B?QWRjazJzTHBMWEI5TzcvMG81ekVxRFkzL2d1dVhIdlZhTFI4amQrb3FuaUpD?=
 =?utf-8?B?bjg5THZaa0E5YzA2STRQUnJmZHBmZ1haTElaZE51NjgrUHQ3dXJCd1h1OGVS?=
 =?utf-8?B?VERueURMVWxCNnFlazNrWS9qN1pHbWVlVWo2TlhuWEd6U21oNmZMNWhIN1BX?=
 =?utf-8?B?UFMzMW9uT05YZlFZTXBKUll0Wlh4dldqd0Z2T1hJNHd2RER5T3FKNXFlQ29C?=
 =?utf-8?B?RmxnZmlGWVZhaXhvT2YwcmphSUgwVVhSakJuMHNxbXgzcVVXSWIxQWhTeUcw?=
 =?utf-8?B?dVNvWVYwbnNtZW84d2pSV1N6eGhNZkpQK3BXd0twRE4yNmlobjZ2OGV3T1Br?=
 =?utf-8?B?MTRPQjU1TTRNVDVTZFVZRlJlbHdDeFVaVmdISVJGdEx1bW0wRy9yQlNTTnhv?=
 =?utf-8?B?Y1BCc2hMQzJSbHlneG5FRkVrcUQyeks4UTZYVU9uQmsxV1FiN0FWM3J2ODhj?=
 =?utf-8?B?OVN3T2RPUVJEMUVnbXBySUNhcXZ4cGJJbzN3KzU1NmcvdktjSHVlT0VadGJq?=
 =?utf-8?Q?Nr43NoRgbuU6e1/tgt26EShyVmZzpuGjhdI5K?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e80036a-230a-46ef-241d-08defe925a25
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 08:09:26.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUFTsvm1IXAzw9korJZkIH4CAcrlkhsNZVu8ykl71OxCgOyOLEvp2/oHXfCeQoLKCNcULUiRbebWPvYNRUyOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2847

On Thu, Aug 20, 2026 at 05:57:55AM +0200, Marek Vasut wrote:
> In case the .pre_init() callback fails, it is mandatory to correctly

I think this should be "If .pre_init() succeeds but subsequent initialization
fails,". Otherwise LGTM.
I did some quick tests on an S4 Spider, covering the normal path and several
injected failure paths. I don't have V4H hardware, though.
Please feel free to pick up either or both tags if that helps.

Reviewed-by: Koichiro Den <den@valinux.co.jp>
Tested-by: Koichiro Den <den@valinux.co.jp>

Best regards,
Koichiro

> undo the hardware configuration which the .pre_init() callback did.
> Intrododuce .post_deinit() callback to do exactly that, undo what
> the .pre_init() callback did. Usually, that means stop the clock,
> assert reset, and possibly program some registers to quiescense the
> hardware. Invoke the .post_deinit() callback in dw_pcie_ep_deinit()
> to retain functional symmetry.
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
> V2: New patch
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 8 +++++++-
>  drivers/pci/controller/dwc/pcie-designware.h    | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index de8ee3db43601..1a3491b5003ec 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1194,6 +1194,9 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
>  			      epc->mem->window.page_size);
>  
>  	pci_epc_mem_exit(epc);
> +
> +	if (ep->ops->post_deinit)
> +		ep->ops->post_deinit(ep);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
>  
> @@ -1553,7 +1556,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  			       ep->page_size);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to initialize address space\n");
> -		return ret;
> +		goto err_deinit;
>  	}
>  
>  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> @@ -1568,6 +1571,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  
>  err_exit_epc_mem:
>  	pci_epc_mem_exit(epc);
> +err_deinit:
> +	if (ep->ops->post_deinit)
> +		ep->ops->post_deinit(ep);
>  
>  	return ret;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0735ae9409240..a53ac27cd2447 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -475,6 +475,7 @@ struct dw_pcie_rp {
>  
>  struct dw_pcie_ep_ops {
>  	int	(*pre_init)(struct dw_pcie_ep *ep);
> +	void	(*post_deinit)(struct dw_pcie_ep *ep);
>  	int	(*init)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     unsigned int type, u16 interrupt_num);
> -- 
> 2.53.0
> 
