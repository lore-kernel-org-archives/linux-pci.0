Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795640203;
	b=L6ruW9/hPDXMSZ4tubDvi8qrKKfoZepP1oSJX6kwSKDtjr3NiWvo+uMdZRbRQeGrM3tT
	 /d2+y9zVQH6vJkhOKYO3yvA1LkQrcc5DAUPd3obgRn1Ggjtx5uc9GFBj3NO+5kZM2KXUu
	 lRtDV7pTpEUSaI6Bqzj4c0HBZm0J7wTUL2rKYXTCbvxYdvBixO0zRn8bZWa+SXJf7HjNq
	 aYs5nKGK4djyDu8evHxBUqqhc71zv61LSQmOfDsG6wZdUja2yeg0NxJy4xDgL9YVGHWHA
	 d4WmEKruDp87vGjMxC12A2t++a6ESOh4pMvnXJ643a9jMpeOwYWWoJWTbpEN2pwoOZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640203;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=l+l4nnaZ4t626MTle3gj8DEmcSrt8V8MIDRtyHdxC9c=;
	b=uMkIzIT/VgcdgACMpDfO4g4Nv5ipYQOWV+23X0S/YMr4EPXU06NsHBwbBCkygZT3JrWX
	 EC1y7DEkOmMcCHoAzmU6Jcqpd2FDmf4qruDI8C1dFQ3QSxakYsAdZKdI4CG8Y2Clt0aXP
	 YonXo0psvZ5hx7SU6TQlmrQ2rlxPGXL0Lpd3m2iJOKVs3OaHum4U3+iL8grsaqVF0C7IO
	 oqG5mrwMr7StGEzjKV8Em7a0586/q4rt4EEOlnOD1iB4j8wdyzKY7OsQFbvmFlM9bz88H
	 g5uCmkaas6+Nz/UzlS3GjNFnX3JKCorO/EMw+8NtnyMakhEH9yT3MAlxfQALSmcXaiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ayk0B3YM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.19
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D53606A323;
	Wed, 25 Nov 2026 20:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D53606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ayk0B3YM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9PukXFasuP6T4+CWE891GocSWMvSu6SfFo0jBK4mjw/86gQuiJnhjmuEqKLFiX/na3jB0UJCZX6zwN5dOlFgMSzYUeE7CfDbT5IgoXeHKFJk2aT9DJye8qzB/rDJBNoEPhyOQRovocfxFbU/g1psWswz6eluSDHHH6PKJMXkfuDQN5IVndtAVNPabk+pWjSRq0rkeM6o4+jhMTRq7vF5Qvi6ZLYFOvtw9BDBCdV/Ke71rvaevNBvQMi8IqtT6K/u8MijZK+CkxhdNPqA9W/0/JZKpEyzLzBGrevXsJLACTwXR8Y1KZ2ItWAy5HE9bjtsdNnd8FJja2T8AFhtDQVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+l4nnaZ4t626MTle3gj8DEmcSrt8V8MIDRtyHdxC9c=;
 b=Xt6B4ynXCu095hx3emtSL7CSjMfEPC22BFKOxPk76hp20X6qGqvGyRu4QVdMAo8u46G9iEzlWf9yTPuug46F1SQc87EAKwOpTfqnvqnTy5ezgI6yMt+5mRj8BMxkVv5v8t1tXFKLrddvFAy7G71EjWdb272B7fAuoAD3cUGFtZ1R8BRRmJYvvZ98nHSH+ifPCgotXPnXebabJWBj9fUnMEIQQgskw8uPhjwUJtqLnMcCk9d3zal1F0VJZZSGMTOWMa081DfAzYYYoxPaxxF5cqE1NPoS4Tzi/0NchlF/VeCXxduEZ5UqK2Un0LC7b9u3zGELDo5T2Tu2v5MX67c5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+l4nnaZ4t626MTle3gj8DEmcSrt8V8MIDRtyHdxC9c=;
 b=ayk0B3YMYL7jQiNUKrriFgQt4HnXCgwI+JzxG/8GiHjxgS0IWQ8J250JlKHfii8PoyliWpBoMIKSvZkcw9Ow+pJf4L9+tCZ+g9lcUPPwpkv2BtpXYyIjC0RgvzsSsHMpdysB2f49soNOfGdI9lhOSLN+l/9GMSRQdbuNHCQn3j8fUIX0Pn5WmfcgTGasY6cI+LtVt6GLEx+q/f4MNTBqbPIOFxFRjwPGP/a0d+htf2Svw6YZE5DG2myAe96q85VaJNwN5jPyJjzFsIaTGgP+fFwiY3u0M2Z9zT2Ktmp18lyWOrFbAZ7B9krOrLgNKZ8O3efrMe5PUxQdjXLrZ9qm2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AMBPR04MB141163.eurprd04.prod.outlook.com (2603:10a6:20b:81a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 20:56:39 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 20:56:39 +0000
Date: Wed, 25 Nov 2026 15:56:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>
Subject: Re: [PATCH] PCI: imx6: Fix kernel oops on user-mode external aborts
Message-ID: <awdLfpDoEmhxYcZk@lizhi-Precision-Tower-5810>
References: <20261124131432.695946-1-stefan.ghetu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124131432.695946-1-stefan.ghetu@nxp.com>
X-ClientProxiedBy: PH7P220CA0051.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AMBPR04MB141163:EE_
X-MS-Office365-Filtering-Correlation-Id: 67263600-f3ba-47bb-28bc-08df4b3699c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|19092799006|261102123227099003|10067099003|56012099006|11063799006|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261021121427099003|261028144727099003|261021123027099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	b7gVMcpgtIYAX567HsxSbu4Cpnki9XSluCOhKgk/JjXrW4caBSdmbKUuz9hpzO66hS6Uv82/rkeqAXiZbDQBO9btD2eDIjODPMCbh5jjkjS93nzYNbMM9kMHs1dcM74UI87l9JM7qk1yl9R1YzosYXwTlz3/VRq/c5Ph/jrVSbVIG5c2oIJmeDKH2UMHbLQKDOabmeKALqvP6XJnjQKK3hBuFiWvMkubfoms1rFBymQwgeTus0T7/d5YE4xO2g+hFJurEt8sVVGbF8B9H+k0a1QON5j0Yjz4/0FYIMiii37Xg12SDespqP9gqEyIrqwAQ18qgUiAzXQnj83Di6vg73z4m8TBcmPX7UO2h51MXPNG/dU9BemCc/cYYRnvMsERz0rj7nOtO29jDRQD5e0f8ix3B/8WoDDU/aEbr3ufuLxRgek/ObVoT5Zb+exZ0F2kXjD+sQHxpn2n24pUW3ZNr7GKDOUqMDoTMf2Zc7SlC7dst3djHmdQ2Trhfs7ga9dkA8frO/EJUDwdinf4VZdzSr25ThTA6Jc6ubhDaJgE1NPUzDhfS43ahNxW/IcyEDs8T7e/nZQG7QOkB7T9qy5F4bUFL3oAG6IERLpFRCVyTNLoCNSJjaPL2slFMT0GAH/JNbEjSbrtW80OVVDrzbV9WPY76ltuBNNqPEnc/pSsuks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(19092799006)(261102123227099003)(10067099003)(56012099006)(11063799006)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jb1dy9EhD4FX7QoB0BLGBETaWQc4lFyea+dPkDSiecrksJ9hL5WZchqvM9LN?=
 =?us-ascii?Q?nkgeBJ7dgmKEBYKxHlGo1GJiNP8KPU4oJmRqsMjU0QUWhtxx5QpThma6nbkk?=
 =?us-ascii?Q?HZgUH1SUNbGM+WZG4BLt0D+Z+TunWn7oxZzUYRR8CYOErfz8VTAhjCkqKhhC?=
 =?us-ascii?Q?a/MG9p52LRzMUv7F1NuMUqbyq6JElpE7uhD/FMD25MJWIst075lYiVdqpG4O?=
 =?us-ascii?Q?cdxxLzdb4uP5wOK4VfW2stSC9yhLZGw9SxcIXkg9X7SchrS/J7OpQGQITmeI?=
 =?us-ascii?Q?afqUZDeBnGoevHsLT57JcPJb4/YBl5FihmLP3PTUGwvLILBt9lZkstEJSfN5?=
 =?us-ascii?Q?N8PIPL8NR5ULBMyXdQjV3ja0tzWmkjwzv/UafRezoHS6cB/Bcd+JJlhs4fTU?=
 =?us-ascii?Q?f/WOXnnHkdv5rnpNlB6ePnP6w0JO3FWD1RJtWPtH9ttLC1OgmTXBmf3L0GJN?=
 =?us-ascii?Q?lVTc7puCmb6zszUMJsnaTBqvY6APx9mnNvH+ADDX+Sj88idEaSrpIzdmyM+2?=
 =?us-ascii?Q?Gr6Bix3GZyWAg+KzOofXcpdkfnB/jmTp0asjpbjQXXmfELtjjvWGXkpOVVGY?=
 =?us-ascii?Q?c2wYfQm/E4ALhNkJRXMMwGsk42V1BGHFE+2HF4TDLX0c+20EhxhaEbLou8MK?=
 =?us-ascii?Q?WvjKJUm7dV939qFRdsKMFVeQTdwoUEMb8b2XM1J+gJgfSnPH/v02DvPa5wnD?=
 =?us-ascii?Q?BI21FNVuLwaH1aihfWMZaseWGtoCQ9Wywty84L5HTAQxzge18D2nfLgbHgxu?=
 =?us-ascii?Q?6vNQHe20ivfQ02aVHzj9llUQP7HrjDVmiHqVeRDcnN92W1B2PUXiByLqZmTj?=
 =?us-ascii?Q?GTrJQttD/lsQoV2zayvsevAcgzQwJGP4EL8YQpS/mL+rr9aKP84og3b+OQna?=
 =?us-ascii?Q?WSJRE6qewukkZg19MBlrZ7zZiuf6e2Z1P3Q1Tuc6u03kvqvN+3V1d2v1riyD?=
 =?us-ascii?Q?ORiF0UaU+vyEBBis5sjppekzYa6Tlb3LciEBwMb16995HX5xpima8LcLNd9q?=
 =?us-ascii?Q?6uOw1HsnHV760mCRwIAF+s68CVteb527kWegBFES7fQjhHRvn9PhlpOk/uFZ?=
 =?us-ascii?Q?ohuaE9kP99BY89hhtqMdSMamr9idp5w5C8zVle76uTdJzLlUF5NkvEe6mfle?=
 =?us-ascii?Q?e1kN6Cl7Nr53MJFRj8JyoCCsyQOsbh1kvPhsS9BUSWjAg217HeIROxGsfM1W?=
 =?us-ascii?Q?36+Pxdp+d7NTq+DM/XcvXZuR20mYOJxWAoL3Otw5Ci2rWQuo6ajyNb6vQL7o?=
 =?us-ascii?Q?SKdA+vSaDVeh3Bl40OQiKAPtu3gXLBVHZEyWCQy55+5xD/RGM+JebDTmz7al?=
 =?us-ascii?Q?TKHZifDR5UXq+SQ546KhO1izTy06LsbLatxqtbIiZSsNm3bp+LhsiGQcXY0K?=
 =?us-ascii?Q?BC8eFLnLICupDpKXFCaPCr6dyIwYDb/HdhWbXvQbxSD0ye2zjp2Rt3xQ9hO6?=
 =?us-ascii?Q?aCyFoY55bYlOsfjpgQrmALPkXN9/Hnf9rGIcrdNGVgS1WG/HDcMiaPRerhVE?=
 =?us-ascii?Q?UrHFcOhw1OxmJ8VOMKx/J0Q9PHobvapJpf0dXuOLaUUbibqSonlnL+Bn4MLM?=
 =?us-ascii?Q?VO30GiJivPnNJHtCn9SCl28/dkeOSP16tU7MBD27KRplrDGA7gmXLx9WOSWZ?=
 =?us-ascii?Q?MafAUzRJATlPPEPCuh6htA48Fu4BBpS3yOh8qlXbRdcQlW3sH1YfH0npA547?=
 =?us-ascii?Q?ZxI2dMtTTQ7G4DteQqZqqENwkk/lRFmDRyB0re+me/r1DhKK/U+9DKtOWuHM?=
 =?us-ascii?Q?nO6YMYH5CQle+lp9BAw588tts28XpmIG4e8H22uuxs/ToDR8vDof?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67263600-f3ba-47bb-28bc-08df4b3699c0
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 20:56:39.0827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0dPpKPzij4g4c4eRabyuaAjz/fiOwlXUKq1EVftUSsy+kMbOTGD8pxvZYx6MeHmwUEsWK8ayjB9qCbS2GxVSoOr4qG9CWY39ui8Dsc/LmLn+Lwym4eQ7e2do/zQzi18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB141163

On Tue, Nov 24, 2026 at 03:14:32PM +0200, Stefan Ghetu wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
>
> When a user-space process (e.g., memtool) accesses an OP-TEE protected
> memory region, the SoC raises an external abort (FSR code 8). The
> imx6q_pcie_abort_handler() registered for this fault code attempts to
> decode the faulting instruction by directly dereferencing the saved PC:
>
>     unsigned long instr = *(unsigned long *)pc;
>
> However, for user-mode aborts, the PC points to user-space memory. This
> unchecked dereference from kernel mode triggers a secondary domain fault,
> which is not hooked by any handler. The fault then escalates to an
> "Internal error: Oops" and crashes the kernel:
>
>     Unhandled fault: page domain fault (0x01b) at 0x006e3316
>     Internal error: : 1b [#1] SMP ARM
>     CPU: 0 UID: 0 PID: 1415 Comm: memtool
>     PC is at imx6q_pcie_abort_handler+0x4/0x7c
>     LR is at do_DataAbort+0x3c/0xb0
>
> The abort handler was designed only for kernel-mode PCIe configuration or
> I/O space accesses and never hardened for user-mode faults.
>
> Fix this by:
>
> 1. Checking if the abort occurred in user mode and returning early to let
>    the normal fault path deliver SIGBUS to the faulting task (as already
>    specified in the hook_fault_code() registration).
>
> 2. Using get_kernel_nofault() to safely read the instruction for
>    kernel-mode aborts, preventing recursive faults if the kernel PC is
>    invalid.
>
> This ensures user-mode aborts are handled gracefully without crashing the
> kernel, while preserving the existing fixup behavior for legitimate
> kernel-mode PCIe access faults.
>
> Fixes: 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0377d72b54ea6..9a9cc35f6559f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -669,8 +669,24 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  		unsigned int fsr, struct pt_regs *regs)
>  {
>  	unsigned long pc = instruction_pointer(regs);
> -	unsigned long instr = *(unsigned long *)pc;
> -	int reg = (instr >> 12) & 15;
> +	unsigned long instr;
> +	int reg;
> +
> +	/*
> +	 * This handler is only for kernel-mode PCIe config/IO space accesses.
> +	 * User-mode aborts must be handled by the normal fault path, which will
> +	 * deliver SIGBUS to the faulting task. Dereferencing a user-mode PC
> +	 * from kernel context triggers a secondary fault that escalates to an
> +	 * unhandled kernel oops.
> +	 */
> +	if (user_mode(regs))
> +		return 1;
> +
> +	/* Safely read the faulting instruction to prevent recursive faults */
> +	if (get_kernel_nofault(instr, (unsigned long *)pc))
> +		return 1;
> +
> +	reg = (instr >> 12) & 15;
>
>  	/*
>  	 * If the instruction being executed was a read,
> --
> 2.53.0
>
