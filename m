Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5101D282F24;
	Mon, 22 Jun 2026 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160860; cv=fail; b=LqpEr546hJUyjYeKJUXmX32HbvPUzIijN9gC14sWzlmljA6ES+0pDKtUGtr/LSi7fwvJ2z6iM/pDdYbPM2sZ/1vsc6K9huBCJNXWQNLIx1PTYV7aBREeopJIpJGLQsK3OmY3aRVkeYyXZgaGIeYBF9Zg0nFqO/dnr+g9/xtAHsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160860; c=relaxed/simple;
	bh=WwYrWKYXaqBFs5+ntXAlT9m/WuvFICKd3jB4Id55Vhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ev0FnpiQJ7G7DXxBUz7CoszIiKap4gODkpVaXVUAyg+I/Nthqjj2CL5rXlcYQj+CZNMgTQSE1RguOT+0WCT6xcpwUDjIx3Bl8zdc7TnhHziDt3BBs9rI5jOFHVq38mYABCZHzh64eHSOaXm+jiLRi4U7wDl5VNWlXPkxLQmVLNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=p2tmOeAA; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p2tmOeAA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww+nG5EYmXK8ZfEcUa2eoQdrrwJ+B7p8DoEdk2xO3uhjPUAcGfyHDBOgLPfaz73MRtiYhT+QMB2MHosbTT3jg9/rRovBiqFgFmPBJv8j0gxa4i1DpAWGN6anaYHCgMOplspJvlDy+bHR0NaS2nn0NDVFeS0TtUMn4T+0XWd3fJSBvu97T9gV9/JrFs59RgBOn+Z3Peq8oujil8fjsj6L5/EL3e6hFb3WcNKmpSWszxDS4uAS93qsp1r26RON7f3dRZZXbvZJGFWE9+QgNwAE9AJeL5d/QC5cFjJAJQSIeNOtxqA6qYCzkAd2ayMluhAwfiFW7nP0VFLFB3hx8qkGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAajf/zAkMvU4peg6PSDUNPelu6P0iT0rgxt3ODr18I=;
 b=w6JDSwEoUNn+Fvnfi3FhDWXe/mIsu1uE1jRyLOxwKkqNldPNFaZ0WQeAR6XtPYindZ/IgWJiRCScQBBoDUijf6LZzt8p0KfdaoW1S8yqsANRcTO65GudaaZcV/a3JGA7d9/j6BUqDwU/LB5HKXON93hiWMCr/ixg4CpooxAwa5OUBi0R688dnA7kLkq79FBrCj5ntUeB6KjSAsO+HG4YkbjYmOjG8V2AP8gsBKNaRTIZVQ3AQL3kQJ/kZak1SXvU3gI1N22t46PrWNKVe2PjXC/EMtTjwQMxFNH5QBDMjfm+zq3HrJwjHKKYdJsIGP9ZX57Y4baN3RboxpHcXVnzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAajf/zAkMvU4peg6PSDUNPelu6P0iT0rgxt3ODr18I=;
 b=p2tmOeAAOaGqrTdvwp5frdUID7viOiBaszK/brhz+MOMsY+OedJA5t7wbR7EOrQpADVgUKuAgdNs/wm4IQaOOwfnr2doB4//c9wfmZH574kyBHk/CCDfcbrvk7uquCL4sToQHrbYYRiIFAqhL5WlNQvO6RvIQ+d/2elndiKcE9Q32KQfyaQO45lOGPRQRmDc24Mr7UEqPR4C2uKoV0XoIrg6f9sBhav13FAvwb0eCybWCS4Ju7CvgwzJkZ7OOEA/gJe4HOqeohszUzhiXRuZ1BFdjHSEYAHV3csU0CvlrOhHl947GqhZLuln0dFRGoADB5xVipO8GrWTw2v89t7C+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11190.eurprd04.prod.outlook.com (2603:10a6:150:278::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 20:40:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 20:40:53 +0000
Date: Mon, 22 Jun 2026 15:40:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	Frank.Li@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: fix use-after-free after
 device unbind
Message-ID: <ajmdy4yoYh7S2kS6@SMW015318>
References: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
 <20260622165249.374155-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622165249.374155-1-shuangpeng.kernel@gmail.com>
X-ClientProxiedBy: SA9PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:806:a7::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11190:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da36bd5-cb40-431c-0e95-08ded09e8db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|23010399003|366016|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	y2AHz1Yih3FQXEIG14iZeh8PX9IbQijEKScMtMC+oMvcXcCAaus1U3Y3zgSU4W22rkFOIAV9npO1B047YrcDsNmsCJ2HJKWp0hxRfV19trved7QdMm65KeMiOVlnb+j+EZfgSE1IhGUkJaYLT+LYOubwvdIzkqe/GY6MY63NX7MNb0VGx8Qi2A4qMUxGEFoMDOjzinOywtwISsiwZaOMG9HHBrjiTCYRUQj9qb8v7Jug99PeaaZCkQYUpU96813LocYi5ixAuwzCk/wUrMIv2pZQn89yNWwoSbq+2kv3WJboX7YtZ9YvoO27oMEyK2oX9Bwz3Rn6CkxpOpkseDrW9+rCnrmUytTH0VlxYtsD2FCT+5akDzIwYhAA26Ekm1MaQ4xwZehWiX537X9LnqVtm4c5+sArMjquyJ5z64h9vOABpFrbxBUwz2vmaGvDya8CjTkdqRbrisyxczjTTmgZU5E1fwYIJHmp8ZlxZBtIxEBpDfTcg1Hhb3udD7ZXFGdSFGfWaggB4pznuv+P/uQQ+farK/RWa+Ih0FjHHsp4J/zJgVwMaklTq/k++EGn3+ZUXOKNB0ecHHkDv4glpyG5oELrvm2qvDhrZQYhh4k8u3/agBRfKb9aHkJ00OmlWlpP58MHtbHyDajzIW/BRpgnn6L4SQpbcfMjYBrZNxnbb2g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T01kMVlZK3pPbmFieWlwYTg0dW05Q1RoY1JIdXZnY3dOeHpTbHVtOFhvcTlD?=
 =?utf-8?B?aE1OZFRuN2l0blJPQTNWdGE0bUlsMWk5cGo5L3QrU3Y0N2NMa3VnQWN3NkI2?=
 =?utf-8?B?SkFveHlTakNFeFloNHVnQlBxRFFvbTJ6STV0Z2M0SkRrbkNKalRJOW1ERVAx?=
 =?utf-8?B?RG1kWVhDdDFpTTZUSzdWd2hqUHk1Uk84WWRIZ01jS1RzVFRadUNPdDNZeG5K?=
 =?utf-8?B?MW1PWHE1clpoVmJjL3lpU05kNGVlWmNQck45TDI5cVdMbWtMT1VMVzlZNzNp?=
 =?utf-8?B?dkpXcEFSc2hHRUZGN2I5ZlJUSk1MVGZraUZBMnVvOStDWGRpakF5YTVzc2lD?=
 =?utf-8?B?L3ZUdjIrWHIyY0R4M3BQNWhGNER1YkJHR3pFM1Z6Uk1GWEFnR1dSYjZxYldN?=
 =?utf-8?B?M0VSOWd3VzRCZElWdFdoS2VTN2FpUFNtbzg4cE5YV0E5TVpkaGIxa1h5QUhY?=
 =?utf-8?B?V3J1SlZPZGl2a21FdVdmenM0Vm8ySE03RWgxM3l1aFJPL1RiMzVPbXJtSy9l?=
 =?utf-8?B?TXRja1NiWHJFTmJTMkhxYWU1RklmQzZVTUlCVTJZRkxaeVVwbWw1TThsTmt6?=
 =?utf-8?B?K081UXZYdk1OL0RtOGJZMHg3b0F6VGFFZUJCMmxKakIvYmNkRkdtcU9iWE1V?=
 =?utf-8?B?aXhTSkNQcU9yTkNvbkZpYXVjdExkTEtka2Y0MTlhak0reDFSYWxLK0pRWjQ4?=
 =?utf-8?B?OHdmNnNhUnl2dDZsL2V4d1lyYm5BV1krbDhmYVhzK2tXb1U0WWd6T0FjYmhM?=
 =?utf-8?B?REwrNlg1Q2dSQk8reE9DMWZDVFZFSThQSlZOSXFpTkJxU3lLeHJkWWZ4dC9Z?=
 =?utf-8?B?RElGLzhzbUh1YThHVi94czVrK1h4SzFXdjFERGNFaU5XR1F1SGRsOHhISzU0?=
 =?utf-8?B?TDgrMTFDOHgzWm5BNzEvbEFvMnh3c3NFTEdTcjFneG9FV2pwVHRvVnl0UmN3?=
 =?utf-8?B?WENsMEJZM2ZLOXkyb3BES1lhRGZRbUUyVnhGVFJGNzdJWUVoRjI3YUtOK04y?=
 =?utf-8?B?UTlFWXduSFdIdk9WQ2lKVUk5aHJlQTBadmU0UXJIaEFmWXFMd2I3ZmYxbDRx?=
 =?utf-8?B?Q0lmUkVqdTV2eVNLTWxoc1dhR2hJUXUveDFSd2VOU2xQVTF2NTR6MHJjWWlv?=
 =?utf-8?B?cDZWbThia25KUXd3ZHdBQXNtRHB3K010bVBhRFFjbjhJbkxQLytDVVM1R1Bq?=
 =?utf-8?B?MWs4R1JGakh6NWlQaFJlRU9kZ1E2TjJGT0hKamxNMnFySzdqbEVpNklqczhq?=
 =?utf-8?B?Y1FJN2U1WitwTWZJaCtXK29uTHp2V0VrVDYyL3BTL3lSc3F0S0dHUUtPRmE5?=
 =?utf-8?B?UkJ3Z3EzM0dSanNUTkRhOWRNUXRTcEVCbzYyazdtR3doY0w4Z2srRzVxeTlt?=
 =?utf-8?B?Zm5wQ1EySUZVWlBRNE9zTnVtUmVieXM1eEswaE1DaVNmMkxKYVZacnFna1pW?=
 =?utf-8?B?dFpVWEdJTGZLMzB6bFlJeUVjS1RoZ2w1UThrWTRiWDlKZytUYXJyMFIrMEVs?=
 =?utf-8?B?cUV3OUNiUUxwQU5EZFVXbVhTOFYxUHhscC95b0NyaU5MeGIwK3JRUEpXdjBY?=
 =?utf-8?B?bE0zckI5V2Qrc3MvR3hRamZvL3J3OXl6SHRjbkhyRXFZSkVlWWZpR2dHM04y?=
 =?utf-8?B?Vlp0NTV0VXRaK055MDl5ZTE1QkwyRjg4ejZaQjFuVE1WNElyYWRHSWlwK29T?=
 =?utf-8?B?YlcvMTRWM2RGajlwZUdZMTNYWmVqQWRiUHExU3FsTHZyd2pWb0NEa1cwd1M3?=
 =?utf-8?B?aUY5eTBwcTJITm9CM1VLeGRodFZxMXJzZWRXeXRLYXllN0pzNittSTZjL1Na?=
 =?utf-8?B?VThqN0JvSVdZNzBHSUxMaS85Sm5reEI0MXJaUFNPVm51NWZTVjg3U2hkWDZ0?=
 =?utf-8?B?bVdJWlRkcC9nUytRUjZGb0Zia2h4enBXMGc3RVRCQVFVVkU5SU1sbjZrZE1K?=
 =?utf-8?B?bXJvWDFieWJReEZWaCtZVmlvcEQwelkxVjR6MXFPcnMrajFrWEZyVXY0OXk1?=
 =?utf-8?B?aTFPK2c2RlhubzNiT3hzeGR5RHZ3VldYd2hUM1dTTlpNY2Q0WFZXSHJpSXdU?=
 =?utf-8?B?b2UrdFJrTEUzOWVvMjN5UlRaYXh3RWs3c1dlRVpaQXRzY0pDUVQwYzNlWkp5?=
 =?utf-8?B?SnB3aml3Z2k3VElEeCtuVVRVRHlwbm9CNzhSZXpyZGlwZVJFSW1UTE9QZ1lr?=
 =?utf-8?B?U0dVcUt5M09DNEFDNkVTajh6OXF5cTBESWtwVmFaNGJkS0MvSVRaTGY5aW8v?=
 =?utf-8?B?b0hMZ2dMZE9MSk0wQXNHWDk5WUdYdC80S2hCczVJRkt1ZGlTcjI5U3pYYnZ2?=
 =?utf-8?B?ZWsva0hTQ1lya0N3cmlSckJ5M2taUE5xc3NJTXZmR1V3UGI1YVd4TUVHTVE5?=
 =?utf-8?Q?8549O8Nl2I1QS5cRwUFdGjud/5GUgIELA5dhL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da36bd5-cb40-431c-0e95-08ded09e8db9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 20:40:53.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMypeU6iHdZNM4Al/E6dGTVpV6kmz3p7i6tXZ3DXaRqHwOJQZOjEkEavzkuUuQzK5VDFvFv/crzkfwJteieO+lhKGYrqv1RK6+JcU7bLW2K7xjUYlm3R59BYLOPqGDyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11190

On Mon, Jun 22, 2026 at 12:52:49PM -0400, Shuangpeng Bai wrote:
> [You don't often get email from shuangpeng.kernel@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> An open miscdevice file descriptor can outlive the PCI driver binding.
> misc_deregister() removes the device node and prevents new opens, but it
> does not revoke file descriptors that are already open.
>
> Before this change, pci_endpoint_test stored the miscdevice inside struct
> pci_endpoint_test, and ioctl() recovered the test object from
> file->private_data with container_of(). Since the test object was allocated
> with devm_kzalloc(), it was freed when the PCI device was unbound. A
> process could therefore open /dev/pci-endpoint-test.N, unbind the PCI
> device through sysfs, and then issue an ioctl on the stale file descriptor,
> causing a use-after-free of struct pci_endpoint_test.

Anyways to provent unbound when still open? This driver is only for test
ednpoint funciton, it is not worth to make complex for this unusual case.

Frank

>
> Manage the test object lifetime explicitly. Allocate it with kzalloc_obj(),
> add a kref, take a reference from .open(), and drop it from .release().
> The remove path deregisters the miscdevice to stop new opens, serializes
> with ioctl using the existing mutex, releases the PCI resources, clears
> test->pdev, and drops the probe reference.
>
> Use the same 1s timeout already used by the other endpoint interrupt tests
> for the READ, WRITE and COPY completion waits. This prevents device unbind
> from blocking indefinitely behind an ioctl waiting for a missing endpoint
> interrupt. Already-open file descriptors then keep the test object alive;
> subsequent ioctls fail with -ENODEV instead of touching released device
> resources.
>
> Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/178144969601.60470.7358419009914000395@gmail.com/
> Suggested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
> Changes in v2:
> - Bound READ, WRITE and COPY completion waits with the same 1s timeout used
>   by the other endpoint interrupt tests so device unbind cannot block
>   indefinitely behind an ioctl waiting for a missing endpoint interrupt.
>
> Please let me know if there are any concerns with this approach or if there
> is a simpler preferred way to handle this lifetime.
>
> ---
>  drivers/misc/pci_endpoint_test.c | 86 ++++++++++++++++++++++++++++----
>  1 file changed, 77 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index dbd017cabbb9..65d768dab450 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -13,6 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/kref.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -136,6 +137,7 @@ enum pci_barno {
>  };
>
>  struct pci_endpoint_test {
> +       struct kref     kref;
>         struct pci_dev  *pdev;
>         void __iomem    *base;
>         void __iomem    *bar[PCI_STD_NUM_BARS];
> @@ -143,7 +145,7 @@ struct pci_endpoint_test {
>         int             last_irq;
>         int             num_irqs;
>         int             irq_type;
> -       /* mutex to protect the ioctls */
> +       /* mutex to serialize ioctls and removal */
>         struct mutex    mutex;
>         struct miscdevice miscdev;
>         enum pci_barno test_reg_bar;
> @@ -157,6 +159,15 @@ struct pci_endpoint_test_data {
>         size_t alignment;
>  };
>
> +static void pci_endpoint_test_free(struct kref *kref)
> +{
> +       struct pci_endpoint_test *test = container_of(kref,
> +                                                    struct pci_endpoint_test,
> +                                                    kref);
> +
> +       kfree(test);
> +}
> +
>  static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
>                                           u32 offset)
>  {
> @@ -804,10 +815,17 @@ static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
>         pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>                                  COMMAND_COPY);
>
> -       wait_for_completion(&test->irq_raised);
> +       if (!wait_for_completion_timeout(&test->irq_raised,
> +                                        msecs_to_jiffies(1000))) {
> +               ret = -ETIMEDOUT;
> +               goto err_dst_unmap;
> +       }
>
> +err_dst_unmap:
>         dma_unmap_single(dev, orig_dst_phys_addr, size + alignment,
>                          DMA_FROM_DEVICE);
> +       if (ret)
> +               goto err_dst_phys_addr;
>
>         dst_crc32 = crc32_le(~0, dst_addr, size);
>         if (dst_crc32 != src_crc32)
> @@ -909,12 +927,17 @@ static int pci_endpoint_test_write(struct pci_endpoint_test *test,
>         pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>                                  COMMAND_READ);
>
> -       wait_for_completion(&test->irq_raised);
> +       if (!wait_for_completion_timeout(&test->irq_raised,
> +                                        msecs_to_jiffies(1000))) {
> +               ret = -ETIMEDOUT;
> +               goto err_unmap_addr;
> +       }
>
>         reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
>         if (!(reg & STATUS_READ_SUCCESS))
>                 ret = -EIO;
>
> +err_unmap_addr:
>         dma_unmap_single(dev, orig_phys_addr, size + alignment,
>                          DMA_TO_DEVICE);
>
> @@ -1000,10 +1023,17 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
>         pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>                                  COMMAND_WRITE);
>
> -       wait_for_completion(&test->irq_raised);
> +       if (!wait_for_completion_timeout(&test->irq_raised,
> +                                        msecs_to_jiffies(1000))) {
> +               ret = -ETIMEDOUT;
> +               goto err_unmap_addr;
> +       }
>
> +err_unmap_addr:
>         dma_unmap_single(dev, orig_phys_addr, size + alignment,
>                          DMA_FROM_DEVICE);
> +       if (ret)
> +               goto err_phys_addr;
>
>         crc32 = crc32_le(~0, addr, size);
>         if (crc32 != pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
> @@ -1141,10 +1171,15 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  {
>         int ret = -EINVAL;
>         enum pci_barno bar;
> -       struct pci_endpoint_test *test = to_endpoint_test(file->private_data);
> -       struct pci_dev *pdev = test->pdev;
> +       struct pci_endpoint_test *test = file->private_data;
> +       struct pci_dev *pdev;
>
>         mutex_lock(&test->mutex);
> +       pdev = test->pdev;
> +       if (!pdev) {
> +               ret = -ENODEV;
> +               goto ret;
> +       }
>
>         reinit_completion(&test->irq_raised);
>         test->last_irq = -ENODATA;
> @@ -1206,9 +1241,30 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>         return ret;
>  }
>
> +static int pci_endpoint_test_open(struct inode *inode, struct file *file)
> +{
> +       struct miscdevice *miscdev = file->private_data;
> +       struct pci_endpoint_test *test = to_endpoint_test(miscdev);
> +
> +       kref_get(&test->kref);
> +       file->private_data = test;
> +
> +       return 0;
> +}
> +
> +static int pci_endpoint_test_release(struct inode *inode, struct file *file)
> +{
> +       struct pci_endpoint_test *test = file->private_data;
> +
> +       kref_put(&test->kref, pci_endpoint_test_free);
> +       return 0;
> +}
> +
>  static const struct file_operations pci_endpoint_test_fops = {
>         .owner = THIS_MODULE,
> +       .open = pci_endpoint_test_open,
>         .unlocked_ioctl = pci_endpoint_test_ioctl,
> +       .release = pci_endpoint_test_release,
>  };
>
>  static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
> @@ -1241,10 +1297,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>         if (pci_is_bridge(pdev))
>                 return -ENODEV;
>
> -       test = devm_kzalloc(dev, sizeof(*test), GFP_KERNEL);
> +       test = kzalloc_obj(*test);
>         if (!test)
>                 return -ENOMEM;
>
> +       kref_init(&test->kref);
>         test->pdev = pdev;
>         test->irq_type = PCITEST_IRQ_TYPE_UNDEFINED;
>
> @@ -1263,7 +1320,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>         ret = pci_enable_device(pdev);
>         if (ret) {
>                 dev_err(dev, "Cannot enable PCI device\n");
> -               return ret;
> +               goto err_kfree_test;
>         }
>
>         ret = pci_request_regions(pdev, DRV_MODULE_NAME);
> @@ -1349,6 +1406,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  err_disable_pdev:
>         pci_disable_device(pdev);
>
> +err_kfree_test:
> +       kfree(test);
> +
>         return ret;
>  }
>
> @@ -1364,10 +1424,13 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>         if (id < 0)
>                 return;
>
> +       misc_deregister(&test->miscdev);
> +
> +       mutex_lock(&test->mutex);
> +
>         pci_endpoint_test_release_irq(test);
>         pci_endpoint_test_free_irq_vectors(test);
>
> -       misc_deregister(&test->miscdev);
>         kfree(misc_device->name);
>         kfree(test->name);
>         ida_free(&pci_endpoint_test_ida, id);
> @@ -1378,6 +1441,11 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>
>         pci_release_regions(pdev);
>         pci_disable_device(pdev);
> +       pci_set_drvdata(pdev, NULL);
> +       test->pdev = NULL;
> +       mutex_unlock(&test->mutex);
> +
> +       kref_put(&test->kref, pci_endpoint_test_free);
>  }
>
>  static const struct pci_endpoint_test_data default_data = {
> --
> 2.34.1
>
