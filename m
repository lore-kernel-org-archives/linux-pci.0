Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24AF3CE0BB;
	Tue, 18 Aug 2026 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032555; cv=fail; b=SS77UD26a15bpPDKz58Af5KvXHgDyVag3Zg4aYLZInn0GOYwy5mBn9i/mQp5dnaXyIVLJ0uZbl74/d3F3QJYrqYmQ2RTs+is1thbpgGprMCYRV5sIp6GQbhIqV/SWOxTsA6Z5lz9T92Kzs9gRQWqSUB3oR6pc6p69LGWnm+9kXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032555; c=relaxed/simple;
	bh=Vbcw+4YHt1D5as2ntrkHQ1x069GDa2qv8gOj07P7wiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eZFpDgABerwGJy0nST/nQKwqmBE96xbdD4fx+XPN9DqHPeWOywFUTHCOLi1LIXTVU93n3dWIyPjlyhwDnR6KqQfd86sx6ZitNeZRlBZjz7V3ZxJbayBecTmbWahmBTDON0xnKNVQvhHpt8pGYWVDqQQKlU+Zv9FOv7IB9Hdf5zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RI2QfjCS; arc=fail smtp.client-ip=52.101.228.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RI2QfjCS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNJ5gh8xB2Uo1K55G5lLLpKvLe8gjiWe7L1k8f2dIRpKul9KVTVnAlax5uhu1PJmAQREG1xua7T8GfGBYhinn8/X+tkT+kdDhUJw1a04aWK4Lupi0Q8Sgs4h7src/YkTGHzfIuCNt6oCzTjr3dztqzE2fwEtm7kpnQBVbd12MQ8O2dLkuQI+xWJRPPrcLnGOCK3xjahzLQKaBvwhPSJZd+zFX5/qmBpEi1cUvPxCIuJiT6R+hDZgOzm1gw9g3Yomv9kxlkLrNjsURceQ5XTieFD2eMp5D0W4RQ+dTCqz+yxWYKGXtDWaYy3Ntl0824cDYIUmNr+CY7iekAbueX8nHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzaJGgKYu1m5ZI5VXIz4Ub8SLkvZAR7l5JVV40hY/MQ=;
 b=Z8lR3DlAUnX8wOZxmWXLhDb+IQ63nhwrUDP5XlfQ7kmvjvi9n2CXVBTxD3mPMtZZsWv29X1HGxgZh7UedHCnbl1A+pEFFTfZYgZnvxPmsKhuaT+q/jn0k0gCKqTmApOacCzFy1KZlrNlmpXJjAwHbCLF27VfbFKD20e0OEFUfb7cu0el0eHUqNfNc0i8sYdqyQ0JEkdh3tl0yKVbBz6zYW6oXUm16MOa31+XmArjHmhyxKUEJCuLJsQMQii5JiZgaAmH2PVNxqJ17uuUb7juqXfwRjv7XTmGzQ1fARl2ydaHcKg7ZViN0w2KtGWwRVp31kYyU3kGW/uzOrEQ+4Y6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzaJGgKYu1m5ZI5VXIz4Ub8SLkvZAR7l5JVV40hY/MQ=;
 b=RI2QfjCSHIYCQZ3UELoW1wft3H4L7puLumocML3AONyVsqjO3HJBfC4qfFHycpQOQxTHDlxH1GHq4YCVRYewHyXf6q2LbxTGDRW3eFZ5sIIVh418a2bVCvQxSefBbdr/Av1sHv8R3Q/xwimwa0uo12KSaMuYO3jisJ6KfCJa878=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY1P286MB3406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 05:55:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 05:55:49 +0000
Date: Tue, 18 Aug 2026 14:55:47 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: rcar-gen4: Fix potential unclocked access in
 rcar_gen4_pcie_ep_deinit()
Message-ID: <h43onk4priskfkvdrheml4ttx2b7udavnulxvftj45midvcs3c@lec5rx7mrgys>
References: <20260813091925.71363-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813091925.71363-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY1P286MB3406:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e40bc7b-0168-42b3-8d0d-08defced5a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10070799003|6133799003|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7zbvKlClAR97Pk7KL0cakmT3DqpLk6ORu1V3dfBqfhS8yvR6cEcleJJo37SirM1kNMLcb9NHTkgFMxACU5VolKlET8cOZJUfGtVGswzmqI1Td1ogM7y6NFgSTttQYddddyWy+Czc6QhUM5fyXmIw4jl8/RlI+GoNOivtZmWfYZUsU43XCVOt2vjPkULHqIDPPpAXLWvCOfCL8M1Vii3Fo1JrmhelJJWT+Gy13B3fwyxS+Cenhwe0W8eWC7/WB7iyOqpbDMa8nYxXqmtuDTFPXnuxOqas1mDgRHKMm/o0olOsa+uOBkCQj96gZ20JCKTh8gulPc/6tOcPyaETz8sYWLqEvNx0Sia3LJzvhWM3yn+yA/qfnIg4I4dGz0Y9n0ojUs5DDU09fX6K7xlFysCBsxGEBUryD/ZHeBwYrybd1tqxE2P4f7zHlJS0Gvll3pWUmihVjHict38qWLIxvFYeOlbiNYTuThb43JgTnDEDXdmYp+4FsUXa7OeLqqfS0tCdxM3HD57czsjnpf+INnqoFIUUFNHRpbpOOY7B15NPRTo7GWUbx4b0o7HkWqFFsOjg2ov7usi4U9EjkSgjzwtcBeBd3l3BZBC4ydqI6L5uKz6G+WoZ+k1q3Ga7KizHwlvbHP5393y8WVTzhTPTLf81GHPLZxUjoX9u940VziOHovI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10070799003)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3NmWTlhcWUzdGUxeTVObmVsN2wxeUFhWll5MkFTZzl1VWhsaU96TXl3b24r?=
 =?utf-8?B?Smw3OHJBSEU1YStyeTNGV3NYMTc3UzA3L2sxNEhMRmdXUHZkQjhEVGZXdExz?=
 =?utf-8?B?RnFUUUR2ejAzYWhsS212V1haK3NweGtZQVlqY1d3N1RETWlyZjR3K01VcWps?=
 =?utf-8?B?NVlMSmtjRFpOR1FXN0pURThnUEJraFJrWk9lSTk1T1hIZzZ3cGdVV3dDUk1a?=
 =?utf-8?B?ei9QTzNWbVB4S0VYMFZuNGp3Tmdsa0NCb3Vra2VoZE9UeTJXbDAyV3U0Rzh4?=
 =?utf-8?B?Z3lFdTg1ejFscWVlTnBFWlNVY3o1aFBCMWRUTituR21xYUZHK1M2UE92bnln?=
 =?utf-8?B?UlpmbzZqcjliMDgyczBQUTRVSWdrbTN3V08wVm9xWnFFcW1jKzliNGdoeTli?=
 =?utf-8?B?MW9QQnpnR0JPNGNEYk5QVVNmTTR2N0NXL21wRFBscG1vZDQxMVZTbEU5dzV0?=
 =?utf-8?B?MWRLd2dFa3hIdVhUT3UzdHVialNPZFYwYkw3M0RrTEI4V2NpM2JIS0syMnB3?=
 =?utf-8?B?M3VtUnNNTTg4TkU0aHUwODlEMXpVWHlMdkVCVThlcUl0UDZobDMyN2cvZHZO?=
 =?utf-8?B?WS92UnZQNEN4ZC9GQUQzdjFjY3RlUzJybHFiYzBFWi9TeldiV3B0cGVhM2cy?=
 =?utf-8?B?WmZkcnVFeWhsQm4rbytoREppOExKaE9vMzJhQ1I3U0hTVDRyVFpQRmJzaUV2?=
 =?utf-8?B?S1lHcFB3YktuYlUyZWE3WXlRQUNyTUhNOEJpRDhodTYzMmtZQmdMdnRFWkZC?=
 =?utf-8?B?UlNDcVpteVRWUDJGVUlPeTQxbkVweEtaeSs2Q3dRNUl4a3NxdmREWFp0VzZI?=
 =?utf-8?B?K0tWTXhHQUlBV1B3V201UU1hcHlWcnEyNmE5emk0eGkrcFRHRmNkaEJHbXdC?=
 =?utf-8?B?aDBhZFlydmdZeVprclRETTBKNFo0UXVWbzhtT0pRMmNFYkhLV3QyY1JmaXRi?=
 =?utf-8?B?RjlsVm5mWXN1dGxqTnRhRjRUYStkNUEvV0crdnB6L0tBZEpaOUN0V2pIWDhs?=
 =?utf-8?B?Vi9UcFpnc0NqcTB3S0plQnJxckVQdHF2aENNd3hNRTdxSER4azJPKytvZFQw?=
 =?utf-8?B?elRJaGlSVy92STQ5QVNJaFNHMnd4WlpFdU51T291VENSNW9iVzhHK0ZBUzJ1?=
 =?utf-8?B?NDJrdTVGa0NWazJkOGhUYUM0SnJtVkQ2VENUWWNGaFVNMmN2OURvN1Z1b2Ri?=
 =?utf-8?B?UEZzREUxRk1vWDBYbmlvZU9udWE1Z3NSTWdRQnVCM2NwQTVDZVYxU1pGYzhi?=
 =?utf-8?B?UzFRUjA4V3IvVW0rb2dJVG1udUZJVWlVZ3M5TnhxNis3UnVMcDRCUjN3ZzZS?=
 =?utf-8?B?Q0VMcFpjeW52ZjhsMnRsSkNzM1NCQngwcGNuc0hXdkN1ckh0dTB1ZXpMelM3?=
 =?utf-8?B?d3JnUkluWUR4d0lybld1V0FQQWxZTHRodklKQjJXMWt6OHJDeXZ3RTlQTmpa?=
 =?utf-8?B?WlBReDhQckVOZzFHd3BiYndscTVVK2F1N0Rvb2lreUVjcVdLaVNUZFBZWGpW?=
 =?utf-8?B?N211QVc5YjY4Q0hHano5WGRZMG5rVEczWFRSUHNOY1NjaFZEM0tIbWRtSE1O?=
 =?utf-8?B?b00wWlpVb3FaOTdNcHpsSi91Z2N6aENsUHZJcFRJTlh4blZCbUg0RS9xblo5?=
 =?utf-8?B?ZS9IRTNpZkI2VTRuemlXUlk1M3pOMzJ6ZEE2M0F0ZldScThZTDdrWW5aR2JJ?=
 =?utf-8?B?QXFtQTAxWllDRFNLQkNwK0xjRU50YjVyUWhXeWdlOW9MdTZFK3B0ZjZ3UWNO?=
 =?utf-8?B?OWlUSjdFaHNiNDhFVSsxa01LWE13NEVHMDBhYlJ0RXBlR1AxeDdMdWJ2VDlK?=
 =?utf-8?B?S05HUVA3UEcxcnZlWWtNVWtaMnJ4a0d6eUt5aGZ6M00xM0JuUWVGVDlBbjJD?=
 =?utf-8?B?MTRUYkMzV3JFUVdVdGVwNFozQXR6MHlUZkVPMVlDMTZ0OW4zK01mSDdmdlkz?=
 =?utf-8?B?aGhmQjBFWHNNSkhzem45dkhsdHhmNm9KVXFwUEhha3U0cU9ETDVucmcxS3JE?=
 =?utf-8?B?MlVLSXZsSHUwTmIyNFhobVNJaFlaVGpmU3lzNTdqUEpiSGNydzREVFlHSlF4?=
 =?utf-8?B?eGw2dnVDTXpkSk1TZlpGZjE4U2JQRjZTM014V1FKZEFDNkpoYWtMNnM3QmRD?=
 =?utf-8?B?bmlLNEY3dkQ5TGRWaCt1ZXlmZ2NLVFBIR3JZYW9aQkZxNGQwa3l3b3VIZklV?=
 =?utf-8?B?alh1eENrUVhWb0xOQmFnSEF2YXk3QzhsOHAzQ0Q4MHY4dWV2a3c5NU9MRDlN?=
 =?utf-8?B?MEhnNTVTQ3I1Z0dVNGVYOEp2ZGE4aFJJRVFFZHBzOHpuc01MZVcwR0NCUGZN?=
 =?utf-8?B?a3h5Y2dIZldGREE0Q1JwN2UwQkhseXRNY1lxaWlEaWNZZDJRVStzUHpSeC92?=
 =?utf-8?Q?se2tPjoFo+WIj4BFWsDhaXEByqDQwGH6bbmmc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e40bc7b-0168-42b3-8d0d-08defced5a75
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 05:55:48.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqfUh4IM0+/OExgICvtNi+MGpkzE0Lrk4kJ65NElq0SIMHqCg0nWFsw5voB1LeaoyNcXCKSV55NOLc5rqk+gjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3406

On Thu, Aug 13, 2026 at 11:18:22AM +0200, Marek Vasut wrote:
> Initialize PCIEDMAINTSTSEN in rcar_gen4_pcie_ep_pre_init() to 0,
> and in case rcar_gen4_pcie_common_init() fails and the result
> propagates to dw_pcie_ep_init(), the invoke common deinit instead
> of endpoint deinit, because we are certain the PCIEDMAINTSTSEN
> register is already 0 and the common deinit does not do any register
> accesses.
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
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index fbe465a29068f..b47281b30db96 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -487,6 +487,8 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>  	int ret;
>  
> +	writel(0, rcar->base + PCIEDMAINTSTSEN);
> +

Hi Marek,

Thanks for adding me to Cc here. I tested this patch on S4 Spider and saw no
regression. I have two questions though.

1. The new writel(0, PCIEDMAINTSTSEN) runs before clk_bulk_prepare_enable().
   Is MSTP024 expected to be already released at this point? I added the quick
   check like below on Spider, and confirmed that the clock was already enabled.

   --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
   +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
   @@ -9,6 +9,7 @@
     */
    
    #include <linux/delay.h>
   +#include <linux/clk-provider.h>
    #include <linux/firmware.h>
    #include <linux/interrupt.h>
    #include <linux/io.h>
   @@ -487,6 +488,10 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
           struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
           int ret;
    
   +       if (__clk_is_enabled(dw->core_clks[DW_PCIE_CORE_CLK].clk))
   +               dev_info(dw->dev,
   +                        "PCIEC module clock was already enabled\n");
   +
           writel(0, rcar->base + PCIEDMAINTSTSEN);
    
           ret = rcar_gen4_pcie_common_init(rcar);

   If that is not guaranteed, wouldn't this write rely on firmware or some
   earlier user leaving the module clock enabled?

>  	ret = rcar_gen4_pcie_common_init(rcar);
>  	if (ret)
>  		return ret;
> @@ -571,7 +573,7 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  
>  	ret = dw_pcie_ep_init(ep);
>  	if (ret) {
> -		rcar_gen4_pcie_ep_deinit(rcar);
> +		rcar_gen4_pcie_common_deinit(rcar);

2. It seems to me dw_pcie_ep_init() can fail:
   - before pre_init() has run,
   - from inside common_init(), or
   - after pre_init() has succeeded and written PCIEDMAINTSTSEN_INIT (e.g.
     pci_epc_mem_init() fails)

   The caller cannot tell which case returned the error. In the first case,
   common_init() has not run, while in the last case PCIEDMAINTSTSEN is not 0.
   So this seems to me different from what the commit message says. Is
   common_deinit() intended to be safe in all three cases?

I may be missing some detail here. Could you clarify this for me?

Best regards,
Koichiro

>  		return ret;
>  	}
>  
> -- 
> 2.53.0
> 
