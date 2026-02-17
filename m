Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A34C2FF;
	Tue, 17 Feb 2026 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347932; cv=fail; b=lJsqFQN6achz2z9lpkeY0kBAaLSDZ5RV7cQ3f8Tpkh3kRG8FXllNsu8RaLyLI89xHtMrGsSyLGoZPfLnTvT2iOh6i0+J8q2rObSpECkfZ96pwLPtjTUT7/yOUKvLstNP0ONgLcfpFsxhb6lI1JAIl4xejwQ+fEBQBLtZu8eBths=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347932; c=relaxed/simple;
	bh=Df3Ks9rnT1BLPVNS/kiCZsUDcSrwHFNCesZrEFP7vJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dtM0FGa2fd9qmkITgP01PIWZDUUIAgcVA+GhPfoq7sL373yK1voPoXHVe0Dow/BmDLs9P7IEpEv707373miajZrfrhQSDNQcQWlVWsMaggkT6VsiNvQHefbjtCNAAb3/wloe5DKG7YK/aS6qKwtfChd56hNF+Kw2rzDpPRGDFUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B5olUnmX; arc=fail smtp.client-ip=52.101.72.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B5olUnmX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVY5vI1HO1iTgssMkzuhgmS188JgNW9GSzNrJRZz77JR5G+f+OJC5UKFNH33m4+xmQF2wA9tXNlHoXCltn6hrcepRzPeXNwiFcccIsqYOz3skVhNt/Bf0dHD3zwA/KOG62Tqd1I9NIF8mO/2GarTKi0S+WlbTzGFd1wIppr6Gqn05ui1GIk2kX2uuKymXKx4gFJVOinm7wmbC9wTshUanKiaLx2hUcNTn4VtDb1PyQ6nmwIMX+/Q4tW8oKu1EsrmdQv1lQfJQzK9Y36/Q2kxmzcApg2YT4dDcR7CT0PPvk4MdNwuEzIWFHyAdwsCb0Axtupw+IZ2+fqnKcxclUW/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PWr9rhctU5/hzv1zYiGC1Olg2OXxmzZwYjV4wgNOPk=;
 b=B8kwhXqcRyO3L0PVvcB67/xo0CTH9CVqfKgkQ9zwPVuRmvAE5NZqKO+gn2EzzRqYrQFM1UDIrFQuIHOi+cO2sV/qS+WNNSsJCxMF77dvh0ZZfl6pCkTaTUBMTI5jkWbgICU2jmuEoxF2/cJcoH1cMyGPS49HE5I9X5Vxgi/9ErDSB9Kid1O3frW9bvnq4oogSFYyqiT5LwsoAORsX/lJqsepl+I96b8Ni+FdefwfTwNx0Ri1t5XLW4DtmanenRPns03FCSDhbXX9LpQlYrfQ/sc43SdH+Z4iC1Wp8Oa9rQHrDR1XgB5cqhCZl9ofWUdzMCpx4282pQxLZqo2t93/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PWr9rhctU5/hzv1zYiGC1Olg2OXxmzZwYjV4wgNOPk=;
 b=B5olUnmXyYxi5xttfXZY7WVFM+xGkj/ppUqN9br92+wdFtt3CxX43Vi+Tdl7APnowJq1i33w4WGg5IzSdZkx+kxtKMd0uq/LUPY3wQE/aoipk4IY3P69gGR5iRyGrALjETEg1a9n/NtKK7q8dWhkrPP4fojLiQwcMyo8YyAac+brczXsPUYqooTAdzhUwOZq6vrdTjQhiJsOnEAmDEOY8SqIOnzlT8JW6Xl++L4Ui+xi7H1vtdYc1gmLvDFJmTJo78DZ00Mp9tPguyahdt++ZwF3j1MLW9AxRTK+/KLev1jNYgSeFRYowkcnDc3SHmcUiiL8az3CJd+9AvRu8YFFTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11167.eurprd04.prod.outlook.com (2603:10a6:150:27b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 17:05:27 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 17:05:26 +0000
Date: Tue, 17 Feb 2026 12:05:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, cassel@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v2 2/3] PCI: endpoint: pci-epf-test: Don't free doorbell
 IRQ unless requested
Message-ID: <aZSfzp6mA4pmdGkQ@lizhi-Precision-Tower-5810>
References: <20260217063856.3759713-1-den@valinux.co.jp>
 <20260217063856.3759713-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217063856.3759713-3-den@valinux.co.jp>
X-ClientProxiedBy: PH8P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11167:EE_
X-MS-Office365-Filtering-Correlation-Id: e67ce27c-44ea-4dae-ae02-08de6e46bedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|1800799024|366016|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4fMdrQHgEREUjALcSsoYZrjpFmsN1ebB6rubhnSjcmtNUvoY7ZGVQIr/6v8+?=
 =?us-ascii?Q?vOsXbL+CFMpMembx0dPsIYOErQCKmy/yqmnWk3vlU4fdmzLYQ7zRu4E8zM1q?=
 =?us-ascii?Q?Oq1Gs81Xhf+lKLDJ1/Xodd9ZajcrPtg2yAkcmH+eFvS886/zYeYppoCblMgc?=
 =?us-ascii?Q?tj5HkpL8yWxEsxZ2z4ueU8yquTyOVsj4Ljz7XSdAfHKxoOE5xf+7TU75no5+?=
 =?us-ascii?Q?+EZbVXuFr3oB9q8M5LPMIhQD3M4vwmIYcc/ilTyFzGEN40cV+aEM2LQ+tMfD?=
 =?us-ascii?Q?cs0IqAfuZspNcOZPqk7SAe+G24ubE5wZNhV6lkhqgiyk39ulnYnLgu3Bqeuj?=
 =?us-ascii?Q?HRVe7JmLJqPiw5D9O4u5+DAEYUoYZc13xmX0h+Vf41zYVXvZ6f/bFmvO1I9m?=
 =?us-ascii?Q?dqTWf8aRxzFQhHrr1ixlSBYiNtHcP0EvdoyPZCRUU2qyZD5t3vyFvs3t9J5B?=
 =?us-ascii?Q?81ou5cSyKw56Dh/ouJQY/wmBTt+TQYkDUYuebUbhqu0IeNlOXPT6gasapSMz?=
 =?us-ascii?Q?3gOiJhFS/o+AhAVWIigOusqyJVwrnTeYLkFmf/jpPkEQB4SdM9gemBAZTU8A?=
 =?us-ascii?Q?JMMdZmpBxCBvr+eFnACCU5alYbj7oMptIKI+52+XUXY2Yw9QNf1amhCFwfyy?=
 =?us-ascii?Q?1yXWPddAsXd4xtJL3QRWT/JQOrDiJlLoXRcbQzJjI3pqWzadW2uYpw9frpY0?=
 =?us-ascii?Q?EezZ2zfykPbe0H6a5T2/BmOZ8xmPWZWwxqsdd3jEvGLuPS8P/GTGRJeQjx5r?=
 =?us-ascii?Q?IFgYTCPjwU8W5FGUYW6Cm6aXHQ9bmp2K0r2DFdewswicNnQDVzqcXsPmjmr5?=
 =?us-ascii?Q?lPMpO4S9qanZCmFDOraShwtmjV2z1SuSuNq7yHqWyR1Qfh4GiOM7ab5jpmOB?=
 =?us-ascii?Q?WzKg0rmXA8VwZ9HWQa+7iQSN0gHXLSpT7OHoz+BuKKqD5HSicVVzjMpoaOid?=
 =?us-ascii?Q?/cGQ455eqhvYPgwdCYm8Y5Akf11VLLklI6Q8oJ81WIK4cGLQkTuOGpHMzbpR?=
 =?us-ascii?Q?YIuOhdLiuGeJoylY978WG/AjcG1j7ZadL17ScTZDOCAfkcNOzv52T+utUzQt?=
 =?us-ascii?Q?Okdio4K+pkALef3TGCpdUJfH7MMAWZ96XcQM0oWoRSniu9uyztRobYL1yKx4?=
 =?us-ascii?Q?zIUochhCbzZvh/8fSKHTdJLrvAnoZ0Tb1OWn0kNedyJdXFzv2mKzHE2SfS/v?=
 =?us-ascii?Q?WhqZHzjoysd+u7uZ5LwGU5XHGN4t6qjBT3CNbd/nHhDezj1q5a7AfRRcT/ER?=
 =?us-ascii?Q?CdtCIqwLzhF9Bwu7IroKrEs1YWRvgDM8wNgkD+OQckDd8yXDvx1wy/lXiZ/o?=
 =?us-ascii?Q?7pq5aFDLx+3Vl7ThPcru1Ga7weFLAnjYr2aG3UJjcyxzV8sl0/NQDbpjomC2?=
 =?us-ascii?Q?mFdzIYhRDwpyvuO1DAnpaWLaE9U+xAl+MfWb+0n0kYMrlMurKV5j4YzUqh/W?=
 =?us-ascii?Q?XaN7u/PpJE5TWL0BRO091BMsMUSqYdQmc1oECZgQnXTlMcZAVI+ir4kg7BOo?=
 =?us-ascii?Q?dOf3Sf8hfq2NROrNe2zDlytYKVMVqT7aakVrlZF3hB7njYq1E4xwusXmYmtJ?=
 =?us-ascii?Q?wtx5sdn5A+IVBI38Y2yRUi1aaZXy+jId/+tCFlC21Y09vU7P0j5iLhCwZnu4?=
 =?us-ascii?Q?L2ZfohTsRomJUJc//O1wktI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(1800799024)(366016)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0KfNkvHe8B7qvJAsLUjuv91pvVJPSBrB506kHpSwDA0+LuQeSmY5R1ikLdO+?=
 =?us-ascii?Q?JqC+0hK7vBKrA3iFA17zaH979f8NJ/IynDnrOwgwFd/Pj/WW7AWU/pYFntb7?=
 =?us-ascii?Q?LH82WXGnCycHAihWGyLX/sW/2M0BRG2lKcx+uZOOIkUMZYpXOIrrpvOfqh8n?=
 =?us-ascii?Q?57YpJUXVaDle4WGVH7OUCVI0/5LPrga4f96SuAKEuKLQ7+dccF14U0Qo3d7v?=
 =?us-ascii?Q?JFAa9WcoQAlXF6/+q/LdSOxqk/0/GbAOlfYcfjLjWL6t8z4J5DdJTmxheR/X?=
 =?us-ascii?Q?DHvf6ytiOyYVxIEmFaHNgvilnzopMKlRfMPmy5gEVIZW7ZAVn5YMVNACgM4y?=
 =?us-ascii?Q?+aKzbcqKF0xCqwb67YM7+bFbqeJH/dAxxegO8aAgTUnllVgRlar2GUme8lv1?=
 =?us-ascii?Q?UC2SX/haMHCGChOFm8/nNxsk9KBIcDr1LUP6PInkwOfDOdclI4z0puXJuyxE?=
 =?us-ascii?Q?YyZLqrWSjMzNpiRL4Bwn4IMQ+KkE5hsK7nAjZigWqfjAjJP/OWiehr6wpp0W?=
 =?us-ascii?Q?Z9D8f0AurpSKZuaATNKtagaWFEqGkK7kIvbOylZwOxJDzKpEPFJPoJKiBTQO?=
 =?us-ascii?Q?M8JpITQRDrVGr+t1aeqLA9v4D5jziZxwbyj24l5tUIxzH1iLvwllHh4NwSJP?=
 =?us-ascii?Q?c8/maQIowuvG6nz8GhIYOn32pVJFpI7fpxb4irNsR+TV9kjpnERQKxSI9TJ2?=
 =?us-ascii?Q?wI1aDwpnUw+Vrkcb8kikzl2py06uxpeF4GFPBY739CNwHV4dDXB8CwdgXaAy?=
 =?us-ascii?Q?gjjOjfA+eOqIzcBciZqGpINX0rApuip4XT5gz4QiPoxtsoTb0mrtrWXKPHiS?=
 =?us-ascii?Q?1tVUYVxOJz2wFY+WYcBJYquolUV/kk1a9dOx0pyhquQubroS09aDflz7rK1Z?=
 =?us-ascii?Q?fQ1qAr5m5GsiVK6XPn4T4BkYKCWiH3rb2iVhNFBokVBMjC2K+WeAjWAA0USV?=
 =?us-ascii?Q?7QGmtGr9wtzYySSnSVJW4U3cKC20WM61XlcZWphrSePm8+SDpHp7EYd4ugtJ?=
 =?us-ascii?Q?ieRJaGzpE2BJvVyYwoyttKga2WaRngmThpxB4HxxjZFfZjLr6iSuy6iCSfbS?=
 =?us-ascii?Q?AEurkzESnQ2u8FEOJ/Illxo/lPdTDYZUoxxencl8jdeS0/e56cSceMyya/JX?=
 =?us-ascii?Q?HLPd4GrEmTa6mAB7+FJvlnBCefmhRXtxJJuXJuLTKPrhpAyTwiJKymk70lb+?=
 =?us-ascii?Q?zwq5p+pj82qhi0ZycZMSgH37wH+vj0jeGmZh+47EyBw2JL32xCUxGhy51viR?=
 =?us-ascii?Q?ZXsZM065bthpkSGqjfP0+f04Ikkv9Fk/tyebwmBeYjLisI0mufkUrfceQcDY?=
 =?us-ascii?Q?RlvPBAnGzryAV33xN3C2uYFhOhrlfFTj4xynuRxOhQysF2l/hPzmzjJbMfgF?=
 =?us-ascii?Q?Kl/Gm/68Yj0raUxN0VhRkKVpx+D5ZwDC3+oGItYzrJxIdmMMauvesWmiASPy?=
 =?us-ascii?Q?YovFrlWe/1sqWD+CTRKvQhD5fKksmMrZq5gTvDqtwp6DMMo+bFqM+nTRIvBf?=
 =?us-ascii?Q?YWQz+rTVuDK7wViNFCuDVOoYyifPBAgeTysi/H8MsYmuOO9jLf3oW08luDue?=
 =?us-ascii?Q?hHDT5jPj0OiO3t+WDSmvUaSKSU+cXQQeHcLHqgHvx0UG2UvBAAmmS2MKd5E9?=
 =?us-ascii?Q?our3GrcLlJZi9n+dFLMrBtiIGMF1EMqWUhnovQKFE6R2N86eEdkGTeRxb+O9?=
 =?us-ascii?Q?NCZ8MUe7hf/cGkoPoP2KXoGg451RisD52MJXHIQUKf4hD0b2gP67kmxZCIFA?=
 =?us-ascii?Q?U2EBzkmlMA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67ce27c-44ea-4dae-ae02-08de6e46bedd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:05:26.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keyap6kI5e72KInE6+VrI7SmsQUg3dfu3SCN2NddXO6euY8DQOA0DR+1+CbqxCqRYQEBLDg9QcnbHr3AZtWaEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11167

On Tue, Feb 17, 2026 at 03:38:55PM +0900, Koichiro Den wrote:
> pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> doorbell virq, which can trigger "Trying to free already-free IRQ"
> warnings when the IRQ was never requested or when request_threaded_irq()
> failed.
>
> Move free_irq() out of pci_epf_test_doorbell_cleanup() and invoke it
> only after a successful request, so that free_irq() is not called for
> an unrequested IRQ.
>
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/endpoint/functions/pci-epf-test.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 0cb7af0919dc..12705858e502 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -715,7 +715,6 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
>  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
>  	struct pci_epf *epf = epf_test->epf;
>
> -	free_irq(epf->db_msg[0].virq, epf_test);
>  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
>
>  	pci_epf_free_doorbell(epf);
> @@ -759,7 +758,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  					 &epf_test->db_bar.phys_addr, &offset);
>
>  	if (ret)
> -		goto err_doorbell_cleanup;
> +		goto err_free_irq;
>
>  	reg->doorbell_offset = cpu_to_le32(offset);
>
> @@ -769,12 +768,14 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>
>  	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
>  	if (ret)
> -		goto err_doorbell_cleanup;
> +		goto err_free_irq;
>
>  	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
>  	reg->status = cpu_to_le32(status);
>  	return;
>
> +err_free_irq:
> +	free_irq(epf->db_msg[0].virq, epf_test);
>  err_doorbell_cleanup:
>  	pci_epf_test_doorbell_cleanup(epf_test);
>  set_status_err:
> @@ -794,6 +795,7 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
>  	if (bar < BAR_0)
>  		goto set_status_err;
>
> +	free_irq(epf->db_msg[0].virq, epf_test);
>  	pci_epf_test_doorbell_cleanup(epf_test);
>
>  	/*
> --
> 2.51.0
>
