Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020081.outbound.protection.outlook.com [52.101.228.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC31C84A0;
	Tue,  8 Sep 2026 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829535; cv=fail; b=OkOG8Eku0IgVOxraQhixLTtfzZSw3eg6PZbsxzdLcV1WW3VwOs+1x/1a1Lm6rK6CAai9R958Mqskx2hLD6kiJdDo+2ZAN/UFhFtmAOwUTNEmwLNigaXf3OkBwhpT2EQrwhloyeAnt5cEpTykPeCs7NUh00A3Yb6GRkQSak+StMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829535; c=relaxed/simple;
	bh=6yLh671ywjfoq+14voEty+D02dm5nUXwG7MB1XUdr+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HkKx4R0OKSg/SzHNEECruqnfjvRVfFiPjkp/Vhu00P0mBF9VeIYgQqlMbAsK8R4uwBvt55WF/Y/7fIyGe494WI5b3B0iLLsl3YmgKN8/++Fr8TCgtkkHI/D1+SeMMlLNQsyQn3B/cTmoIMEHHhUImjnZoZb9cH9IluVXKh72LZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jaabjjXW; arc=fail smtp.client-ip=52.101.228.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jaabjjXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ftfcqczgfo7DmXG0b0pJphN/P8Z7bhXEsTzefh7yMgs/OK+jl0nuNmd6qiLE+nEmvGIpZYSVdxc4dFiVyCeJhfTEYjYg3VCCzryfFCimK1DLa1BXYfp2GksJtrTIZfWpL9MeAU05tb2ua24Z/g2LxJUV3cKgo3YEcHSH6ZoGMtk6dYUioFmu6RbogtDubNnan6M3Evui/kqfFwxI2gi+n4pNtrqk9g9RfHwOQFQr6VBkQTxspvi2NukyoyzidrFtcwHPUBAhUrZQQHRYFVJQfk4FkuszZKafh7Xhh0ZWRDMhuLd5lD+6MRuwN6GP7KUstqGqemOZXmDxtEAUCpUpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTIEus1Qya2B+HWhWJC0EJBj7G4JfsNhTMlecNLnIeQ=;
 b=vrmzssmGLU6Zaib5WX3Hp37WpMuxk4ze/oIEIpgdOf+D0eTYoZw1UnbOBoSE1Xzr9rk+wZRpfBlPjauLOqWtGqxUVZ4f+WdPDkI07TYFgojbIIJlVplhiwn5NWwurKtMns7QQkh/ugu2l+ih2Vf6A3lcZkw29JTM+L1ggh6/2y/S3znhibXo6FNsDtj7lK7GcvtDlhjgGNGPr3fG3GxCFQVVByYBD3Z7EyYoaW99Ewtp0e/kyetcBVWTsuKt8wbp2sAwSuYg4IFBmnHf3hHVUWC4x5hf/KIR4xFAWnEYm41untcOH5Dy6yHue+UrRIu7+3dBzpodC8hLEha6VoY0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTIEus1Qya2B+HWhWJC0EJBj7G4JfsNhTMlecNLnIeQ=;
 b=jaabjjXWyHfTqokHLEQcEGLxoJImVFiM3AX0978YpgnoxIq/Ed/Z3IhiDTk4/v+eYarTZeTySJGQx0SwcKvwc4ejdMvwg5A9yXgwVlbuXLV16O1ZtfImuMqbqQsqHe2l1KdeSEzhOoGDEL7BYzUFvHyzo87dB+PDU90xWgaQRJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2070.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:161::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 01:05:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 01:05:26 +0000
Date: Tue, 8 Sep 2026 10:05:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing PM ops
Message-ID: <74il3j2dzfdt4xhqrfjkifhnpnmgqtplon2mtzfjzkbszwegi7@vou6a5rshcvr>
References: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: TY6P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2070:EE_
X-MS-Office365-Filtering-Correlation-Id: 95281513-aff1-4337-1f24-08df0d45449d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	anfuG/TvWw3vTKA11CSJFCjSEnRwPSxh63zV/G4b9MM+LwJIJrEl3MaS/PXPoXm6y832DYdtqyo44HlH+ChTugbA+utd8xGVavFosNfo2JIZfINw78izKprTnRFxR2sjVrTjxup3Z6xccHScWSJI5W4YrwNl8y8vjqT+nNZ73SSqGjkblDNSyNgDga2VokI1R3gQkgWkWRKwrCOLv/qoMxyXcagfYXEXRjgvQRraGy/13udZaaz+s4YHr2sC5z7iHubIJvGZUpT6R7STl+ho7GR64Mqk5l+o5RJAJLNCexXH3JnszWKD7Hg2TgZSGvCIAiSEPNWGHql5585kYQPvGuRBLq+qY3XpDCUrMvC+OoVDTNkoWW5ON17cHYgbr2XSwJ7ZFqPpZ9R1CBsIdzkVH9247xXCzAmNRtTujg6KEAT4OU2ziAIcUAGbCcbBlqG9FxntsAoTPA3ffrN37P+MHnzbve27s0pxkKaX5hPPaFI1ara6+1zlFXUTCK7c4YvNdSXZErf5qvisfUCyCa/tjc2ipsj0i1DvztmAY7ciSH39+ge8laX1aDB2SdvRU8MTMbVnjEiJi5xL2WqE58AEGf7Mw2akqtVkOn3gt4tOiBO+jAMoq7r4XkRAMmlxnIG8o2Rs1jtRaUj9rjQYTENvx24qzTM+WGK5WwuNzi7YdBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U21oU09GTW9ubTNoR1g5VW5PMlMxdngyVGZRVDRVanZGVm1lMTIyb0NDM2sy?=
 =?utf-8?B?SkJZRW5LeSt4R0dGQlRVYTlqQVFvWlhySHhKdERZVGJHMDNTdXdFZ29JeFFm?=
 =?utf-8?B?ckhqeFlJbFNyTmRXNzd2OFY1enBYL0hlSlk1RmIxelU1OVYwbWZ4QWdOK1NP?=
 =?utf-8?B?MjVvUzBiamJ3dFBSVDFDVzRGTHJhWkFJWFYyVDFSN0JITmN5SlFVZzJ0V0t4?=
 =?utf-8?B?L2ZOdXJRRElYaVNtUjhKM29uNVJpeHFnalBLSGpldFgzVHUyK3h4c0h0RHd3?=
 =?utf-8?B?eGJBOUZJcTZXS2tDL0VTY09WWE9malE3ekczM1Y2VnNVT05yN1drakx0bUtU?=
 =?utf-8?B?bjU5OGdtUHk4UlV2cnFBQkN1OGZqS0NwZjdSNmhnaHNrYnliRjg3LzdBV2Zx?=
 =?utf-8?B?bS9haFhLNDZiTk1KZHBjbzBYSW9uR2NLbnhUNzVoQVFLeVdZVkowS2NuKy9I?=
 =?utf-8?B?TzVGRXdyaVgxdkpMZ0NvODJPS090Uzc0VllHSTFZcmR1cmgxakh4endNbFdT?=
 =?utf-8?B?bmVXUHVob2dVN1Nnb0RzaUF4YUFGY0JNdmRkMllaZk5xTkx5SGV0YjdNZnBB?=
 =?utf-8?B?d1oydGx3U0hMdHc2WjhkRHJwbmFweDN2eHhGMmN5V3lCSlNEMEVoQldzYVlL?=
 =?utf-8?B?ZHI1UUVBNDZkZE9VTDAvT2I0aXY2YzJjaVR4VENXeFJyVDMxdVNSOWNhaVp3?=
 =?utf-8?B?L0dzNlRSMHlZV2xPRXRudEZldUxSeUpzMEhTRjMxY0hPQXVVSnM0UlZNVHJh?=
 =?utf-8?B?MlNVcXEybHA3NXl0UXE4ZC95TW1idVVUdnRDSGVkV2M3SzN0ZUk1Wmh5R0FC?=
 =?utf-8?B?VER1c3c2dVRVZCs0QVFHWTNBK1RCNzBaV1lzTTZNY01zRGp5MHJBNjFYUFdv?=
 =?utf-8?B?RFlrZnc4SW9hb1ZUQk1vVEhDeHoxSWlpYmk5UnQxUzZIQ2ZVQk1HVk1tWjJz?=
 =?utf-8?B?MElCYTJmdE5kRUF3cEFNNGY2WVNubm92SE9iNS95WENvUDdQTUFQVHQ0L3VJ?=
 =?utf-8?B?ZWl0U0Vvd0xLMitpdkl4YXdXb29kSFM0aExrVm10RXdCQlY2STVPZkwxRHoz?=
 =?utf-8?B?MW1HRENwMDRHTDE2MjdPN3pHSUt0Q3ExblpHZ3Fmc3doNjBxNlljWHFsTjZq?=
 =?utf-8?B?K0NsWG9LVHBZUVBwUk1lOWdBVEd3NW9oSFJhSVpxU1RIMS9rZVkwUUwzS2Y2?=
 =?utf-8?B?aTR0dDQ1cTBZUGlUU0R6dVdWVlNkaGZaaGlvVmY1MW95WkNaSFBCVXBpT3FS?=
 =?utf-8?B?cGVYUnZ5dHZrZGowQ3FOWlNaaXl4SnBjQWRIZmZRMTExUW5RL2w4bVA4YytE?=
 =?utf-8?B?eEJCdy9JQXhsUVBpM05GUEFQUzZxSm9hMnVBSjJUc0t0VU1rUS9WQWVtM3k3?=
 =?utf-8?B?cTFvbVloNGt5OGdmTFB5SUE1d2d1dnc4UWt0ZmdRR0g2L1YvWFlBSjkrcmxT?=
 =?utf-8?B?R0xtbEtHOGxMYTNTTTdUYWtuTlFhc2FuYWdDM3dMdmVPVW1OQ1N3UmpVTlZI?=
 =?utf-8?B?bGVObEdTL2xSVG91SjZsVkJrUXFFK0NobHRJVy9mM2EzQ2IzM2ZSYWZXVnVL?=
 =?utf-8?B?dHhJbzZtbXJyNVp5RXY0SXpXaXZYYlU3ekVTYlpiWjRSWEQ2L0FvbSt2V1A4?=
 =?utf-8?B?VDlYbHFiY29DU1dSNDdZZFZzeVA4b0YxeUlWdGQzZlNnYU1BUXZCVWd5RkZJ?=
 =?utf-8?B?VXcwaTJNMkN4L2hvWllpV2RJMkdaekh6YWFXNFM1SUsxM1ZSM0w2RUs4YmZJ?=
 =?utf-8?B?aUFTYnpmWnJ2MTZLNHlleE9hNThIYUtOTDFWVDlsSnZqSG1JNjBoNmFjOHpQ?=
 =?utf-8?B?VjVTMnlVM0Q3N0paZFFvYWRwR3JXcjA0aERNY2lhOENrT3hXazFEMldUbjh1?=
 =?utf-8?B?S09GblJYR1NjcmlMc0FKcm5FbE54ZHZzV1VuZHJsYUdIQmRwQnNDT1ZvWFVw?=
 =?utf-8?B?b1IyeU5ZblpiRHpROFM0QVRNMnJPNXcwajR2citxMnlzQVNHZ0VsdzJqNGFJ?=
 =?utf-8?B?RjVkVTJXTUQvSVVHY1hUbHdpOU1yUFFjVEZRaXg2eFh5UWRFQVBOYkFjVEV3?=
 =?utf-8?B?a0NnMGF1YWR3Y2lTMG5zdUFveGR0dmhtcStRcGI1WUdNMHN1NHNMVm5Lc0Ja?=
 =?utf-8?B?ZU4rTU45RUxMdnNuczkrZzJybWFBYW53NTVoYU9WMlZzeElPTmpWNS93cVFy?=
 =?utf-8?B?TlJmd1NDTlF4L2piSlNyY25HalZRY1JvT2dGVHg4a3NpRWV1SUd6QWJjVWpC?=
 =?utf-8?B?dGNkYUF0QXBwRE5NQmhNTFVLWUg3ajlaVElxK3gzdTd4YzVtOGcyUno1OGdY?=
 =?utf-8?B?NUpKNlJTR0lHNnlNZnkrWEs2SzkrdnFGenpENzhMK3YvZE5hNHBNQWZZNlZl?=
 =?utf-8?Q?qPdA1edBi3voT4nqJfdWTyzPzQKn/BBv3wdMT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 95281513-aff1-4337-1f24-08df0d45449d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 01:05:26.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4ygcoqcUowgHCZWXLsItXTBny8FBEiqLUO4W8GnEGAGeB+y5TocrpUXyNJjnLL1KVVxmzbhZrplIGiIg8okmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2070

On Mon, Sep 07, 2026 at 06:35:22PM +0200, Marek Vasut wrote:
> The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
> and V4H, this is an always-on power domain which is not shut down in
> suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
> which is shut down during suspend, and the controller loses state,
> which prevents the PCIe from working after resume.
> 
> Fix this by adding generic suspend/resume noirq ops for the controller,
> which tear the link down on suspend, and restart it on resume. Use the
> same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
> PCIe link on V4H and S4 too.
> 
> Test case which demonstrates the problem on R-Car V4M:
> "
> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
> $ echo s2idle > /sys/power/mem_sleep
> $ echo platform > /sys/power/pm_test
> $ echo mem > /sys/power/state
> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
> $ diff -Naru /tmp/pre /tmp/post
> ...
> -00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
> +00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
>                                           ^^^^^
>                                     Class 0604->00ff
> "
> 
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---

The s2idle test with pm_test=platform now passes in EP mode on S4 Spider even
with CONFIG_PCIE_DW_HOST=y. Thanks! Feel free to use the tag for it if it helps.

Tested-by: Koichiro Den <den@valinux.co.jp>

> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Add TB from Geert for RC mode
>     - Use pm_sleep_ptr()
>     - Call HOST suspend/resume ops only in case the controller is in RC mode
> V3: - Add RB from Geert
>     - Make rcar_gen4_pcie_pm_ops() static
>     - Pull the mode from driver data
> ---
> NOTE: Depends on series
>       https://lore.kernel.org/linux-pci/20260903205153.283553-1-marek.vasut+renesas@mailbox.org/
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 25 +++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 5690dc32f47e0..8b6a6cab1b83e 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -909,6 +909,26 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
>  	return 0;
>  }
>  
> +static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
> +
> +	if (rcar->drvdata->mode != DW_PCIE_RC_TYPE)
> +		return 0;
> +
> +	return dw_pcie_suspend_noirq(&rcar->dw);
> +}
> +
> +static int rcar_gen4_pcie_resume_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar = dev_get_drvdata(dev);
> +
> +	if (rcar->drvdata->mode != DW_PCIE_RC_TYPE)
> +		return 0;
> +
> +	return dw_pcie_resume_noirq(&rcar->dw);
> +}
> +
>  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
>  	.ltssm_control = r8a779f0_pcie_ltssm_control,
>  	.mode = DW_PCIE_RC_TYPE,
> @@ -952,10 +972,15 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
>  
> +static DEFINE_NOIRQ_DEV_PM_OPS(rcar_gen4_pcie_pm_ops,
> +			       rcar_gen4_pcie_suspend_noirq,
> +			       rcar_gen4_pcie_resume_noirq);
> +
>  static struct platform_driver rcar_gen4_pcie_driver = {
>  	.driver = {
>  		.name = "pcie-rcar-gen4",
>  		.of_match_table = rcar_gen4_pcie_of_match,
> +		.pm = pm_sleep_ptr(&rcar_gen4_pcie_pm_ops),
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe = rcar_gen4_pcie_probe,
> -- 
> 2.53.0
> 
