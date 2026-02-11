Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020142.outbound.protection.outlook.com [52.101.228.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FB344055
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828269; cv=fail; b=rLAHhx/OfUpoLmtkHEKXJTHOQj+WdohrkCNr+0aMn2qcBLZt4nrV4j3vKKKcnHCzq5+fcxHBGMt1uP0S/Bcifqa6htjTT4Qq2ZerD1wNqiZcHiN0rOjWZKcFXEDG46i2Sp88flKeOxWg2IGV9Wox8+aoS1vnOxRiicUfxZxAaQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828269; c=relaxed/simple;
	bh=LTtB0Cxw3nGC7Eg3no+TgG37jP3Itl1cTqRt7IidiLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rAuPDryGkpKt7XmaW8dz8vtMJn4AHKgHTj0kswcqM9QwMX8hicmq3+qMzz2cFfsLrqL8Jt1EajRJRHyz5m6j2fX5a07wbSSyj/wn3d+S3I8n/7cvma7ksSyetc5yxBDlT1NK8ytSgHNgXys4KGlT3McmzoWL7fqlhXi8wwVBsis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kxobOs62; arc=fail smtp.client-ip=52.101.228.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kxobOs62"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZ5d6GjjB12v0/DeNHioyQHoguc+NNE8SjUaXMa5xLBXKzoIFBsV6B+3YhxHmK8CiCk8dUy3EIeBy2lEz8nmirTYywm8muAlHjPZtjaYOiN/8uPGQPzkJJXKz8EvLPaB+SiVoJtEqXnTOFM6cQ8LICH8Bv/8Znk+/uCoGxQu8oxyydEqhvak2PeCPSAx3gI1t1EbjXOnGRifsTGL9co2JTZY/Mw+cgBUyoiZx/0NM0iK7z1Ut4MAIINVXcqFCOc5/7ae7hfM5fZRV3LQmSzI9lZH/KX9jEW4hPoVjPB2LKsewFn0xvLrWmeunmKliovA7s5MnX0iZ22Y36ESPIdSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEaQrCynpGL700hZRQYNHMnJOY5LfcgGRWrdV1mAMLw=;
 b=HBLEj+Z4hyPcPkWg0NgU0cQ3iUx3ykm322zMhSTL+vS2b0x/37LJpiyAcV53m9OEk7xdnzATFb4oZmRWzef0zJFQBpN3e9+gI7L/wJL6S5WwY//pXprsXSslvNzCeqN6HX8Ni6hcKqaRvXnrDa7zZ9g0AMiccgtPfVkHpH6ZWgAcEk224faqUvUJWoq4KKqzJQom/QwQvjR5fixEIL6+VRoYPQTyLkiSdQR0C3L53AyHpWjP3dkLmDDchQx96Mda8/KBwjUdgZ0dKTcrj8WvSIQ7ownjRWC4fbf6rtM/JB7nAsMBMH/qu40nUy2/P90rGeyFLSmd3wiTRsZLW2FBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEaQrCynpGL700hZRQYNHMnJOY5LfcgGRWrdV1mAMLw=;
 b=kxobOs62066AL1VUGPiZiN2PAFIalxB/FCS7sNgKfGqRiW0Ho7ioKCmmpcEe6KajCAOSx0gmrCXPqfRc1eNWwqiUO3xpXhHYVto3Lkr58DQBpVAywBfgffKj/TBlFjhUaDmOIQtScsmJUiASAWucFWgIQ71yRpLF67yyYv5twH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6219.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 16:44:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 16:44:25 +0000
Date: Thu, 12 Feb 2026 01:44:23 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix regression in
 dw_pcie_ep_raise_msi_irq()
Message-ID: <5u4amb5muvadpinjfesbkdvn6yzkpo3hbkfhzhbv4bwyinz77g@4jhq5s2qdy66>
References: <20260210181225.3926165-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210181225.3926165-2-cassel@kernel.org>
X-ClientProxiedBy: TYCP286CA0213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0273be-be7f-43e4-d80a-08de698cd0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?doXIN5NkqMXLBUS195OTUOHaYmAdC9hJyR0i3I2DJhvBhTf+lRS5gG1kqcxh?=
 =?us-ascii?Q?rMMZWDAICAIzZEDuLjRBhC10QL9FovNmhUOm0xSYN0oKZe+2Qpq7FpQokmCo?=
 =?us-ascii?Q?6nwNpuT3Wy3CKDIMjqINplL7mUdIfmwBgdjExBNjw5kuGDy+7SUoMsEVvxzM?=
 =?us-ascii?Q?iVGKx5VeCH25o6cDjxXkF7MHlkn3axP6aYme7x+qmn4qnqM/+L2gMIRh4Vva?=
 =?us-ascii?Q?k4XPF1LcrPF64vWU7atsoRFfhESiaTxMhAT0T4Id2SJi5o1cYfjSpZT2e6kH?=
 =?us-ascii?Q?F3OPOJzo1sTGwDch8fh1E+qu+33k/egbD0isGYizqmTjsoJciJV1sMEOa0e2?=
 =?us-ascii?Q?ompM0O7Rsz8RNtgxv7tTXTg2sqyQu5/HJkoZgHkiazQDza2bhOHhzL93v+dQ?=
 =?us-ascii?Q?hj2pmO25xTHb+WFkbFpX6PNHsXrmH5ccGQSQeBJKF5w96fx05vsv4VJyObXs?=
 =?us-ascii?Q?igleyjd8TNJKDOWpc5uNxt1dUCNuLjKMFlk3LzTaxHrI4l/l7pqGjs6ORpSv?=
 =?us-ascii?Q?qST9FhJ5hGheL8HDtSf88J7Uje4sVzOjUsgRQYnos4uVdNarO4gpEwEg6xR0?=
 =?us-ascii?Q?xLuaSwK70d9gBIBF4/VbQ3vj9/OnW0H1FKpL4Tf2eqOqsm3A8Xs8o6JsTtCk?=
 =?us-ascii?Q?ZiIV6xF/7RVisl/s21/tWDhAgHjNRYtYQMaO9Y6lJQuiKgE0LeFEOlM7flks?=
 =?us-ascii?Q?03+0fWiV5TJX6E2LQRfl/AkAQ2ec993ieYPYBtnd1UmYdL7x/Va7o70TEJQp?=
 =?us-ascii?Q?jfeZneNWI6NdYQq6hi2yTPHzrtUnh6ZlhfB3lEvBgjJMPVpNNcJ39+74CfM5?=
 =?us-ascii?Q?6Fhaqxl7qaBwNrJTs+uDC/nwx7pRfZL7mSUqqzJAdTuQqUMSHTHBi2M/CzJ8?=
 =?us-ascii?Q?sXnbJyI3X/9duF+oboAbrw0Cfio/vhEb7l2vDV+wweQ9IC3Rsl6mGMv09YW7?=
 =?us-ascii?Q?SH/TEqTRoCfCst8FkJ/Udzp6QZNPg8mcvd2gU1i65tsJN0LXQhQ6tjkqEAjj?=
 =?us-ascii?Q?7GZPX+9iv7wLpv8CwUEEavYFYNMlXtLaPFsLnbA/5k55aNCvelibMSWXBfXb?=
 =?us-ascii?Q?zpy9IRZe+W3Yg0hNCuxva6Hp9qX1Vf+0iGVnXTeQYRBKjYZ7xVtNA7h2D7C6?=
 =?us-ascii?Q?YKV+YfX0jcqNYbQcyvQ9aI1AwMZYwSGAqb6W7gg0qGfHu0sMlnUh1ArsKzxk?=
 =?us-ascii?Q?NDeJubDvwypipFtKL6ynF65BAC4/PlHlR8ARhj8tnuE1qhNdnUcO49nI6xU+?=
 =?us-ascii?Q?vPfVqw/mAPpO8C8BWAsZ6tkOW7FNOHwjhTBQuX68ac94fhn8kVsbxWRaEY6t?=
 =?us-ascii?Q?OP7XBCUO8XrZG0n7vQ2DIpWdJYYdneR//XrE23qw2dH0JWEuYuH3L6fA5Bjl?=
 =?us-ascii?Q?wjkfxG2UyJeEV54I++zpE6MsFqo440ibVbF7I1ozpgpoIQhywpsYezROdkUW?=
 =?us-ascii?Q?dyYaXIa3HjB58VXTLBJXXRlZeKWMzCnYJyythOd5fln/ZI4NCxfdYNPJA9x4?=
 =?us-ascii?Q?JczwndkI4QEwTAZrNmO7Z9h4UEzCkWrGBg3UJXPq1TpeuKhipkJnI9gYc9nl?=
 =?us-ascii?Q?eZLVbdV2hqidFR1bhXw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mgDJJ5/I1KAK9uscZZiU1/l2HVpn1s0wubkj7otZF8SeyjST3fxQlAjLmzLI?=
 =?us-ascii?Q?qczlnqRXM9AmfnehOZTTs6atwXZSBkP6Upoxb+IDNO1vvtPwX1Ty3BEOrJIq?=
 =?us-ascii?Q?nFMKeD45qrnypN7O6lpYy8iOe/MKAadJq5ry4UIE4bACj7gfM6IJj+6y9hul?=
 =?us-ascii?Q?5C2jH7vAKtApCvSih5jKPWWDUx+SbYqvSxqpitMnHN5LvXKX24lgkpRpyOpU?=
 =?us-ascii?Q?UuOX+dcplEg4CAp+N9L5bkYarvprSg1aMEZDlJ5k4Fa5x0doNFXFA06UbzQ3?=
 =?us-ascii?Q?lTZtGv/ygFpWcPdPLN6n0Dcl0PIrvWKK5nP3nuoe2qP81CtH8Q65nmAPUV5G?=
 =?us-ascii?Q?2DenhP9+fg80dKx7dR0FAMJCiTCuy9DYsOLDdlzOPml/c8pPYWE5ErDe5vum?=
 =?us-ascii?Q?px8gQyO+HQs8bS1uBlJYZQULZbDtbKeyV8w5Olmj/Gsoi7Qcd1yGBINPPVl/?=
 =?us-ascii?Q?Ehkp0UsGwcP+/mmSIurxsIS37mZCYv3fRPLyZXL4OsMrNEpWLlv2w2P6+OpI?=
 =?us-ascii?Q?uETd507iHm+RxQfseWZhH5+wkPBnAlHzTvHYdArKc5nMDLkuSVi1VqbkL9gg?=
 =?us-ascii?Q?pnKjVOJ/Wni9etf2vXfQcHoFKJYEwLBkL3itJhiXSgN7VT1qNcu57YnTNJqV?=
 =?us-ascii?Q?X08wINUKoSJWoxgOk4LzQO4kygbGPKZp3uTfImyavlcqq6qdXM1Duk6mc3SN?=
 =?us-ascii?Q?f+LUwHCJaITZXM/Xqav/SYzVPGmbA6XD9btBRz4T1cPccmghZPgCDDMwZQob?=
 =?us-ascii?Q?uOhbTlWUpYEGSKafy4v4FIJKgwMWr7prMX5wwm6f3tMyDbNfYqkKj3XYD0d8?=
 =?us-ascii?Q?vpowdaCBDwlishmPreJhSJYQiLHHYnR6/qh9a0D9BVpnxRpAmIfGEDfxZ7Jy?=
 =?us-ascii?Q?qwZXF0uOWlCdTK5KEcVnc6UE9n6lQhv7z7kv7wU6Arv1FomTh5xLR9Kcc4CX?=
 =?us-ascii?Q?BlonajrIqi3pWhQGwhav5Fud8dqnCphgqn211yxfeql9WhqVJMzLmRWWeV2a?=
 =?us-ascii?Q?QzBpTvU2Id5rar/TxJmcdj1ZKF29kMj2pUPH2qX6YgmzUy0/6cwK/pVDYtQm?=
 =?us-ascii?Q?blFkOzsUzqenZcLHhmax67WF2Ok8IMx8LWQU43fhzKl/XOhq4dWFSXY0XQUx?=
 =?us-ascii?Q?YGEagZ4TY+RNYsIOjUX5zJ3A2C35O1vSw5xDEzIRVibDp9SHBT5sgpMgKpJb?=
 =?us-ascii?Q?9TFvFQLZLXJXwYwwUmhGQIkiurUd4bACBBuwEQ3rNRr1bJKmMw1bjVEO0v4f?=
 =?us-ascii?Q?Q8/PIexE5K0mbjMhHPxJcKK61Xk2ZGUK3TBlKM8kFor+OHoHiRhEsXzid+jR?=
 =?us-ascii?Q?P08a0h2V/IT4GMDEmW59Dx7/WoP+uaKz7+M0taKA1ummIUeAKhPTAslRFXfA?=
 =?us-ascii?Q?0qsr7wIAS+qIlunwTdTpLE8myMSQk2+ywa3n5Nuof5nh+tCM/wqJAWYppBpm?=
 =?us-ascii?Q?mnOooVZTFycbqkTrCXQDm0KoipVpgqVQ8N74mXe89e4C7UOFuEzYHiZSqhRv?=
 =?us-ascii?Q?5LZNVUqOf3mv7GanMIhZIf/NWEkKIsI2W12zwCZ1DXTZXwgzMftIoEALIvXF?=
 =?us-ascii?Q?5hhMJl/Bc4zJ6thLYfGC04TdAm508JCgpO1k5a02BANHIjRv6JbbtJKVjcuq?=
 =?us-ascii?Q?xTgXndrJfAE/iKjTJ4FyjCttjJ8nEvjMjui/88eXApuHA346JpOnORdi7uQq?=
 =?us-ascii?Q?YTL0RRtbCvoyyhcJh6UY28NKl1+qMUdPV0ZD52Uk2zaylajvj0Xhr6kjortA?=
 =?us-ascii?Q?2zpg00g2kJYWahjY3zo60b7xWfesEV4SgT/zp3Zk7vhooRKSgwlf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0273be-be7f-43e4-d80a-08de698cd0a8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:44:25.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4P5BIhm7uoXqa+j60268qvZHDiyoHagGJ19DNFtpqygFO/B8Y+gbk4tGtoY0eabm7vdwKsrxbBjEr5CsSpWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6219

On Tue, Feb 10, 2026 at 07:12:25PM +0100, Niklas Cassel wrote:
> When using the nvmet-pci-epf EPF driver, and starting the EP before
> starting a host with UEFI, the UEFI performs NVMe commands e.g.
> Identify Controller, to get the name of the controller.
> 
> nvmet-pci-epf will post the CQE (completion queue entry) to the Admin
> Completion Queue, and then raise an IRQ (using
> dw_pcie_ep_raise_msi_irq()).
> 
> Once the host boots Linux, we will see a WARN_ON_ONCE() from
> dw_pcie_ep_raise_msi_irq(), and then the booting of the host hangs,
> because it never gets an IRQ when loading the nvme driver.
> 
> The reason is that the MSI target address used by UEFI and Linux might
> be different, which will cause dw_pcie_ep_raise_msi_irq() to simply
> return -EINVAL.
> 
> This was working before commit 8719c64e76bf ("PCI: dwc: ep: Cache MSI
> outbound iATU mapping"), so this is a regression.
> 
> Also, remove the warning, as we cannot know if there are operations in
> flight or not, so it seems wrong to print this warning unconditionally
> at every boot when e.g. nvmet-pci-epf is used with a host with UEFI.
> 
> Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Tested-by: Koichiro Den <den@valinux.co.jp>

Verified on R-Car S4 (just in case) that the change does not reintroduce
the issue originally addressed by commit 8719c64e76bf, nor does it cause
any regression under high load or in other runtime scenarios.

This looks like a pragmatic fix. The previous WARN_ON_ONCE() guard was
overly restrictive, as it turns out real-world is not always as
straightforward as initially assumed.

Best regards,
Koichiro

> Fixes: 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping")

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 22 +++++++++++--------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..5d8024d5e5c6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -896,6 +896,19 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	 * supported, so we avoid reprogramming the region on every MSI,
>  	 * specifically unmapping immediately after writel().
>  	 */
> +	if (ep->msi_iatu_mapped && (ep->msi_msg_addr != msg_addr ||
> +				    ep->msi_map_size != map_size)) {
> +		/*
> +		 * The host changed the MSI target address or the required
> +		 * mapping size changed. Reprogramming the iATU when there are
> +		 * operations in flight is unsafe on this controller. However,
> +		 * there is no unified way to check if we have operations in
> +		 * flight, thus we don't know if we should WARN() or not.
> +		 */
> +		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped = false;
> +	}
> +
>  	if (!ep->msi_iatu_mapped) {
>  		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
>  					  ep->msi_mem_phys, msg_addr,
> @@ -906,15 +919,6 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		ep->msi_iatu_mapped = true;
>  		ep->msi_msg_addr = msg_addr;
>  		ep->msi_map_size = map_size;
> -	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> -				ep->msi_map_size != map_size)) {
> -		/*
> -		 * The host changed the MSI target address or the required
> -		 * mapping size changed. Reprogramming the iATU at runtime is
> -		 * unsafe on this controller, so bail out instead of trying to
> -		 * update the existing region.
> -		 */
> -		return -EINVAL;
>  	}
>  
>  	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> 
> base-commit: 43d324eeb08c3dd9fff7eb9a2c617afd3b96e65c
> -- 
> 2.53.0
> 
