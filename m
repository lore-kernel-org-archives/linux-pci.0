Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EE351C06;
	Thu,  8 Oct 2026 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791438324; cv=fail; b=lk0GVnDEDuVCSq+/uBKGD8Q7kUjm+/RYiLlpl/qstWb4CcEvkpCZXQkS8EmSKxYuGvf4DQH5riS9BlEmrbShrUBU6tb2X+hnLz5NKflPdW0FRShDCv4bXk1WdgTjU6bjFLmR4Y4LcSgcKeysVj8Jpf9n5+cknp+9SOVYtFjC3Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791438324; c=relaxed/simple;
	bh=i3f2XNI1krvfrMHeQLd5EVojPy/CiMndzMnynT4RsBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCi0L9Huce648ihXJ82qTB64gVSWoFX7vKu//6WVdVBC9DpSlkyKgATKIdVluffvm2BP6hrWAsSI5BGIMyML+ZLrMvM/PJgQGoneTacsfPFziYlGBq7XpE2TqvmLwfFyGK99PLArBXiXNYWSJStP7YpXMkooDBBdohmwGM4vKWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RJYQw9/9; arc=fail smtp.client-ip=52.101.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RJYQw9/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwsOLMmmSJfT6BqLZr+HJrvqhjiW2Gjp3Qphal6f/PbnHLqw4/8n5zIXYc3y9tK7eBfzPmBeq2jxUXWxPDTBqRiwz4TzygZ5AWw9L6oz1IXOwR4a09nfYSPhA+Np6ASIFmeGTA2ZpvwDSXV2NLdIlW7Kfh1XTnBOfRm+HuubkXTqd0Grsza7IrtQ1/HmTfCUbkU6Lyz6D14k6y6MHIgkPo/eTlqderbSEm3tSsZpyorEnyQ3/EFecliIVOw4zNRWnYTYYjkCzGRGFkRtE0GO3PvQvzxNvm7L3d7Yv5P+MekwKGHmqlasE/tBaeZg5gXMEy81KifqxdISX/2WszDJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnafT3Ic1a8uD2MHhVzUbOoEsS9zxK1/KEV2TaVsBbI=;
 b=N25G4S49CDFq7KPOnTRWCUdin6spEPSXC8VI0V42tzqdjk7x/EnylBhzF0Eu4aT9UszsMVbIZVQpi0QO1tRCsg8OwBBIDHk1WL0UjCRDhZ8Md1BZhAVgk4yihcOLO1+cnxkiB/N82E4e8aoxLWIzVKYHdMJq8rpI5mKuU7zOz7JogT0ejQOiI9kiEkfN61Wn6Qhvy3taFXSwuFLSIc19QbyWwKIqfzqn/9Yin+q38xh3AgEgkiQLpKEKVSXTNDQ8v9fZYJnVYmZA5UtTURKbV2/v1kfe1WpaEumJ5GA6gfNj+f61uolrcDaauauh9+BskXcQnOStzSRw4m+pOuZY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnafT3Ic1a8uD2MHhVzUbOoEsS9zxK1/KEV2TaVsBbI=;
 b=RJYQw9/963ROjnvKgmntMQWwlU2jt/eQb1BC6TuM7xnGAuCQVQJnS+xSg7oeCsUAVADb5eXJixA4bY0AH0vPQBnBhMNSB09cniVtn9hyFrnYSWAxyJeQQFIkUNGzJY5Uhy3E9v9ORWkPywauErrarALbZ6KpGRG9pLkCAlaOexY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB5710.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 05:45:16 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 05:45:16 +0000
Date: Thu, 8 Oct 2026 14:45:14 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/18] PCI: rcar-gen4: Recover from link down and
 route Root Port interrupts
Message-ID: <cmtozkk5i3otonvuel7rhfj5p3qwmsocl5qbchgrue63ve4xa4@vs5ahqwbmoqk>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
X-ClientProxiedBy: TY4P286CA0116.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f41d44-250b-4bf1-afa6-08df24ff5412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|921020|56012099006|5023799004|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	izAhdmGA7Webd5p4T6YegWIjNNO4F+95o3HgOXTCDU8fAy2zZqLnQsYB96zQaF92CvdrL9VRIzwxtV6nxOnJNn7wdPj4kqWteMRGE0KlSbx+qRDMOPYWfksn5D/67nQU9FVlzOTXwxYXsS4v991J6tLeb6BIzYtVRjUeUynBJpJO7oC00DiRKhi3I1tRgsDkPZ9bs0uPNLtHK7liCHiAjC8eiZHVy2TzLow9Iz9tyBF9iuO6OTkvPLpd+JcSTIqQirMSUvPSM5ceIIkW6uv0e07DwMPuYQRpStYYPBIIegAYnc9VcUG4ySaHiQdgV1o5PYP0NixT2wBYaBdVEjzxsgz8/+PV7urEdO0x55vTJ7p4NcDMH1gKLEfv4Jm2p/vg+J0WJIQe3JuH3Ona721JrLTMdYt8VFa/1fdcHoKo9FjrLibymG8o7zWPFRtTodgWR04N9vV1JblJ+UkBusuaO87A+UEsko3TVjLcF5DWRp/5P2K1mlciXKo6O7bPG6CPAlXMskpRSERf6qOqWA4WsdpYzznWJ51lXNsi/Z70ZCn5FLKG5GdAx2c/8ykwd+Gf2ifRXxe8R5V9LlNmozNS6G9bSwDUfyT0uRTH7rwkn8eF6Ow6lahUldQ8tNePuZVxI9efXLqgzOBs6IRfiXgc1oIIznNtLwndr/c9MmjBHRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(921020)(56012099006)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lrEW+57MqNN1jTt78oeAtZSoW5ij1aVw6UMAKX1k/FG33VQrwAQ+BoiQeTz6?=
 =?us-ascii?Q?KEFL9t6vIPjVbYCYkr67qFdiGDv4Vs7DjzcSAEuQn6GRpYKiEmk7ZEbMANg1?=
 =?us-ascii?Q?4NEUqRJms9XB+PeedCB21HaC6bkchufFkSVUv7ab+GoGEinfi/ilOAMWpwlY?=
 =?us-ascii?Q?Phxqua3dL0yzc9IGYlMSSNDxON6p+GPNxPQXw0v3fTA1C9XyazmaIMH5VEwK?=
 =?us-ascii?Q?4JUCeUH4QXo9OYW4MYKLXSinOLG8OAtFEkqdh/5dkn9R/eK2EaZXfmts46gk?=
 =?us-ascii?Q?z+8WMIrBZiNiSLyMjd19Tv9vQnbAn8J6yaELDYU5Aetwrkdce5KnnJbttXfT?=
 =?us-ascii?Q?AkrMF59G0rb58Kc3N5UTbBSJrwbfLvAt0OfvOHVZx9gv+yUItAkLf3hBps1k?=
 =?us-ascii?Q?wUEEZbGQSW3ZhCkyV8OFSbUw5KgNZmSwSqqRfwXgSdHFcXmhiUXJTXYJKPUG?=
 =?us-ascii?Q?kE7WLC9h8Tk27DnRG+yduOk8xAJaNAIaa4uwbwga90tjz2zEtVdCDmOa99zs?=
 =?us-ascii?Q?8MDLdPWGPganS3VeJ9vqkJHudUZLmPQMdNRXtLcScY0uk1kr8Dhptmss9dzd?=
 =?us-ascii?Q?oIOrXgQRawxKm2L2Qq4ZOG1BsW1HxQsOuBS8yZ2YKPxmXh2bOCA6tuqwspI7?=
 =?us-ascii?Q?TeYxFzRUp2IhZr7XePVAPo53QCiua/Y+4DiiX0oUfAOM41Y3dGirL51rx3I5?=
 =?us-ascii?Q?blxopv8okJQp2vxeWT4Yrf71nM3UuvvB7qQgr6qri/z6/CGLio/YV6ZgPFLX?=
 =?us-ascii?Q?GeAMh7Ur4vo9M4D1c/RblfpoOGKbWTd6TpSAjuz153VvQxslDo+jmIUc/90H?=
 =?us-ascii?Q?LJRuYqr5MSF9mlx2N3Pd1xbdglq3UFa0kogLPaMMKyUc1XlN4Jj1mPOXABMq?=
 =?us-ascii?Q?6VeTQHGFUGCxlj5OBGXY+mxYp2Ai5n/84zAUA0d0Obl4HNd7045oDQ1yVVO6?=
 =?us-ascii?Q?8xaE8F51QA34dhnAprChns5cCz5kW90G7lXSAfFQLkEs3KrlT3IIq1QIZfYg?=
 =?us-ascii?Q?Rn6uzzR8KC+CO0sLRfGljoJlpRYGerITZpT1uAttXmUDijVqI3J82Z4kO0Ea?=
 =?us-ascii?Q?Z1PYLcyn8vgCZUj+54XywSrU2VjL1dxpQCYDMPXhnd/Uonj1PB8doZZwbP/2?=
 =?us-ascii?Q?1evhFE4aicmaJam45UlNfpbV6jqLYuXhz8wiLQ8OFR77/f4DxFK1LZadPgNq?=
 =?us-ascii?Q?4+Oz4uf6BXKm7HuLQxSMt3oGSZKS0KaCWcW0agGbV8no/w+YdR11xbogjNKV?=
 =?us-ascii?Q?PEWgefq+pNm2zy+8cuDS5+2jhFV6kH55L7udCHIkEhk6Wub8WWf/fu7wen2/?=
 =?us-ascii?Q?j45ZzSeounQu9yv7FJ2Ei5NWdSxm9oZzmgjW1LAp1OXURy2zD4bTq208pmwd?=
 =?us-ascii?Q?jz8KSEYyo5asVzpbWKKtwRQW/PdFys6zidtZvNAtKbT0hl+Ey3BcaGIDZZMF?=
 =?us-ascii?Q?E6U02hznfioyudcoxa2NWhA4HOtRd37MdcFPpL4LaEZxmyZSwF7xLPO+1cHl?=
 =?us-ascii?Q?g3Z1edfkvzj3Ku8+KmupSA24zAnCElUHUp9bMF2v89jxJlZQbttRIXYGZLYS?=
 =?us-ascii?Q?qBzbIhAiqgSKaA878mnwYQZ3ChvimAZsTnBytcmdSvakiscS4Gk6cCAckBk1?=
 =?us-ascii?Q?/+2HauIwHcW9T1Ne0j/00ITjUkwCjWR1bZT84oUNI+25vu+FApOPiuqVMxnl?=
 =?us-ascii?Q?o4bLZA5iRDy+pBANiFSq8L0ITC0XsXuGCXuh8M1jEwv3MsgAgI1mkaYpFlpn?=
 =?us-ascii?Q?x+okyTUmI7NZoKS9CtDcAEavA4jXWI7/1ESLEfvmXjjsomzRguZO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f41d44-250b-4bf1-afa6-08df24ff5412
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 05:45:16.1276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0FYQhs3CsXlMYQgG5pi6TlqufsTJ/gJO5qTSekjGcPHIliIbOy1U7qb7R3XdYTWTA/MfNen2T5pb2vQV5o+VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5710

On Tue, Oct 06, 2026 at 05:46:20PM +0900, Koichiro Den wrote:
> Hi,
> 
> This series improves error handling in the pcie-rcar-gen4 driver, which
> supports PCIe controllers in R-Car Gen4 SoCs and the PCIe4 controller
> in R-Car Gen5 SoCs. It fixes unexpected link-down handling so the host
> doesn't hang, and wires up missing Root Port interrupts (AER, PME,
> bandwidth notifications) so port services actually work. I tested on
> an R-Car S4 Spider (r8a779f0); Marek tested the link state fix and the
> Root Port AER and bandwidth paths on an R-Car V4H Sparrow Hawk.
> 
> A few hardware quirks made this tricky:
> 
> 1. PCIEINTSTS0 link-up bits don't track the actual link state. The
>    driver never noticed when the link dropped and kept trying config
>    accesses on the dead link. Patch 3 combines the APP link-up event
>    check from Figure 104.5 with the PORT_LINK_DEBUG1 live link check,
>    which patch 2 factors out of the DWC core. Startup clears the APP
>    latches before enabling LTSSM, and the DWC core polls the combined
>    condition on the RC side.
> 
> 2. On S4, a DBI access immediately after an unexpected link down can
>    hang the host. Commit 0056d29f8c1b ("PCI: rcar-gen4: Assure reset
>    occurs before DBI access") describes an SError on V4H after reset
>    deassertion, but whether the S4 hang shares the same underlying cause
>    has not been verified.
> 
>    Adding a delay before the DBI access avoided the hang in my tests,
>    but that alone would not provide link-down recovery. Also, the reset
>    request shares intreq_pcim_sub with iMSI-RX, while AER arrives on
>    another IRQ. Delaying AER dispatch alone would therefore leave the
>    MSI handler exposed, and both paths would still need coordination
>    with the controller reset.
> 
>    The driver handles the reset request itself and schedules
>    pci_host_handle_link_down(), as the rockchip and qcom drivers do.
>    This also provides recovery with older DTs that have no "aer"
>    interrupt, without relying on AER to initiate it. The reset callback
>    shares the reset sequence used at probe, including the reset-status
>    readback and delay added by 0056d29f8c1b.
> 
>    This covers the interrupt paths that fire on link down. Port service
>    threads or work already queued or running at that point are not
>    stopped.
> 
> 3. Root Port interrupts only trigger APP status bits on platform IRQs.
>    The controller appears to lack SII2MSI, so Root Port MSIs never reach
>    the GIC ITS. The Root Port's INTx is routed to intreq_pcim_sub as
>    well, which the driver holds, so port services can't request it
>    either. This series works around it by hiding Root Port MSI caps
>    across the board and emulating INTx using a virtual IRQ domain, fed
>    by the "aer" IRQ and intreq_pcim_sub.
> 
> Patch 1 is only loosely related: it adds Renesas to the RAS DES VSEC
> list so the DWC debugfs error injection works on R-Car. I used it to
> test the Root Port AER path (see below) and included it here for that
> reason. Happy to send it separately if preferred.
> 
> Based on next-20261002, with Marek's PM ops v5 patch applied first:
> https://lore.kernel.org/r/20261004011851.866833-1-marek.vasut+renesas@mailbox.org/

Turns out patch 4 ("dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt")
also needs to be rebased on top of Marek's patch [2].
(Thanks for the off-list heads-up, Marek!)

I think I'll do that when another respin is needed, or once the series is
otherwise acked. At least Sashiko hasn't complained about v3.

[2] https://lore.kernel.org/r/20261003215710.792518-1-marek.vasut+renesas@mailbox.org/

Best regards,
Koichiro Den

> 
> Note: backward compatibility with older DTs is kept. Without the "aer"
>       interrupt, only Root Port AER remains unavailable. See the Testing
>       section below.
> 
> Retesting with v3
> -----------------
> 
> Setup: R-Car S4 Spider (RC) linked to another S4 Spider running the
>        pci-epf-test endpoint. pci_endpoint_test is bound on the RC side.
> 
>   1. Link down / recovery. On the EP side, toggle the endpoint controller
>      off and on. The short pause keeps the endpoint away long enough for
>      the RC to notice, but brings it back within the reset window so
>      recovery can succeed. Adopted the test approach from [1]. Make sure
>      that the unused function 0000:01:00.1 was removed on the RC before
>      testing.
> 
>      # cd /sys/kernel/config/pci_ep
>      # echo 0 > controllers/e65d0000.pcie-ep/start
>      # sleep 0.1
>      # echo 1 > controllers/e65d0000.pcie-ep/start
> 
>      Expected on the RC dmesg:
>        pcieport 0000:00:00.0: Recovering Root Port due to Link Down
>        pcieport 0000:00:00.0: Root Port has been reset
>        pcieport 0000:00:00.0: AER: device recovery successful
> 
>      and the "msi" (intreq_pcim_sub) interrupt count going up in
>      /proc/interrupts. Without this series nothing shows up here: the
>      link comes back on its own once the endpoint returns, but the RC
>      never notices the outage and the endpoint is left unconfigured
>      (see 4). Config accesses issued while the link is down hang the
>      host.
> 
>      [1] https://lore.kernel.org/r/abFMa6DCGGLUHddA@fedora/
> 
>   2. Bandwidth notification. On the RC, retrain the link:
> 
>      # setpci -s 00:00.0 CAP_EXP+0x10.w=0x0c23
> 
>      Expected:
>      - the virtual Root Port IRQ (rcar-gen4-rp in /proc/interrupts,
>        shared by PCIe PME, aerdrv and PCIe bwctrl) fires once
>      - bwctrl clears LnkSta.LBMS
>        (setpci -s 00:00.0 CAP_EXP+0x12.w reads 0x2024 again).
> 
>      Before the series LnkSta read 0xe024 afterwards, LBMS and LABS
>      stuck.
> 
>      This test does not generate a PME. The PME service shares the
>      virtual IRQ, but its path was not exercised separately.
> 
>   3. Root Port AER. On the RC, inject an LCRC error with the DWC debugfs
>      (patch 1) and issue one config read so a TLP actually goes out:
> 
>      # cd /sys/kernel/debug/dwc_pcie_e65d0000.pcie/rasdes_err_inj
>      # echo 1 > rx_lcrc            # error detected by the Root Port
>      # setpci -s 01:00.0 VENDOR_ID.w
>      # echo 1 > tx_lcrc            # error detected by the endpoint,
>      # setpci -s 01:00.0 VENDOR_ID.w    # reported back with ERR_COR
> 
>      Expected on the RC dmesg, respectively:
>       pcieport 0000:00:00.0: PCIe Bus Error: severity=Correctable
>       pcieport 0000:00:00.0:   [ 6] BadTLP | Receiver | Data Link Layer
> 
>       pcieport 0000:00:00.0: AER: Correctable Error message received from 0000:01:00.0
>       pci-endpoint-test 0000:01:00.0: PCIe Bus Error: severity=Correctable
>       pci-endpoint-test 0000:01:00.0:   [ 6] BadTLP | Receiver | Data Link Layer
> 
>      plus the virtual Root Port IRQ count and aer_rootport_total_err_cor
>      going up by one each time. The link stays up throughout, the DLL
>      retry recovers the TLP. Before the series nothing is reported.
> 
>   4. Regression check. Run pci_endpoint_test after step 1. PASS/FAIL/SKIP
>      counts match a run without step 1.
> 
> Configurations:
> 
>   a. Without this series**
>   b. GIC ITS, DT with the new "aer" interrupt (this series)
>   c. GIC ITS, DT without "aer" (b43aa6a6ebe8 ("arm64: dts: renesas:
>      r8a779f0: Add GICv3 ITS and update PCIe nodes") or later)
>   d. iMSI-RX, DT before b43aa6a6ebe8 (no msi-parent, no "aer")
> 
> Result:
>              recovery   bwctrl       RP AER    pcitest
>   ---------------------------------------------------------
>   a.           none         no         no      all FAIL
>   b.            ok          ok         ok      no change
>   c.            ok          ok         n/a*    no change
>   d.            ok          ok         n/a*    no change
> 
>   *  Root Port AER needs the "aer" interrupt; without it the behaviour is
>      unchanged from before the series.
>   ** Only patch 1 applied on top of the base, so the same debugfs error
>      injection could be used for the comparison. pci_endpoint_test fails
>      across the board there because nothing restores the endpoint after
>      the toggle.
> 
> Best regards,
> Koichiro
> ---
> Changes in v3:
>   - Rebase onto next-20261002 with Marek's PM ops v5 applied first.
>   - Keep parent IRQs registered across suspend/resume to fix the
>     unbalanced enable Geert reported. Request them in probe with
>     IRQF_NO_AUTOEN and enable/disable them in .init()/.deinit().
>   - Use a freezable workqueue for recovery and reject suspend while
>     reinitialization is pending. Re-arm Root Port events only after
>     resume has set up the link.
>   - Factor out the PORT_LINK_DEBUG1 check (patch 2) and reuse it in
>     patch 3. (Marek)
>   - Replace .reinit() with .configure, folding v2 patch 8 into patch 9.
>     Drop the reset mutex and rely on PCI core serialization. (Marek)
>   - Free the MSI domain after host .deinit(), so the driver can stop
>     its parent IRQ first (patch 10). This closes the known gap in v2.
>   - Reset the controller if recovery finds no Root Port, so a successful
>     reset can restore interrupt delivery.
>   - Drop the raw lock around virtual IRQ dispatch. Preserve MSI-form
>     latches in irq_ack() while the IRQ is in progress or disabled,
>     avoiding lost notifications without nesting port service locks.
>   - Add patch 7's Fixes tag, clarify SoC generations, separate guard()
>     from goto-based cleanup, and simplify IRQ return statements.
>     (Marek, Sashiko)
>   - Add the V4H and V4M DTS patches 17 and 18. (Marek)
>   - Collect Reviewed-by (Marek, Krzysztof) and Tested-by (Marek) tags.
>     Drop Marek's Reviewed-by from the reworked patches 12 and 14.
> 
> Changes in v2:
>   - Rebased onto next-20260925, including Marek's R-Car X5H support.
>   - Keep .link_up() and require both the APP link-up events and the
>     PORT_DEBUG1 live link check. Clear the APP latches before enabling
>     LTSSM and reuse the DWC core's polling on the RC side. (Marek)
>   - Let the R-Car driver own intreq_pcim_sub in all configurations (new
>     patch 10) and check the reset request from its own handler instead
>     of hooking into the DWC chained handler. Replace the pre_msi_irq host
>     op from v1 with an export of dw_handle_msi_irq() (patch 4). (Marek)
>   - Keep the reset_control_status() check before asserting the power
>     reset. (Marek)
>   - Separate controller reinitialization from .init()/.deinit() and split
>     out preparatory changes.
>   - Use bool flags instead of a state bitmask. (Marek)
>   - Keep Root Port AER notifications masked until .post_init, after
>     enumeration. In v1, they could be enabled during port-service probing.
>   - Keep APP interrupt sources masked if the Root Port reset callback
>     fails, regardless of the reset trigger.
>   - Hold a reference on the Root Port in the link-down recovery work.
>   - Clear only the MSI-form Root Port latches through PCIEINTSTS0CLR;
>     the INTx bits are reserved there.
>   - Serialize dispatches to the virtual Root Port IRQ from its two
>     parent interrupts.
>   - Collected Marek's Reviewed-by on patches 1, 3 and 15.
> 
> v2: https://lore.kernel.org/r/20260928165230.3397664-1-den@valinux.co.jp/
> v1: https://lore.kernel.org/r/20260918032038.2216471-1-den@valinux.co.jp/
> 
> 
> Koichiro Den (18):
>   PCI: dwc: Add Renesas to the RAS DES VSEC list
>   PCI: dwc: Factor out the PORT_LINK_DEBUG1 link-up check
>   PCI: rcar-gen4: Check live link status in link_up()
>   dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt
>   PCI: dwc: Export dw_handle_msi_irq()
>   PCI: rcar-gen4: Move deinitialization helpers before SoC
>     initialization
>   PCI: rcar-gen4: Assert resets when Gen5 SoC PHY initialization fails
>   PCI: rcar-gen4: Separate hardware setup from resource acquisition
>   PCI: rcar-gen4: Add Root Port reset support
>   PCI: dwc: Free the MSI domain after the host .deinit() callback
>   PCI: rcar-gen4: Take over the iMSI-RX interrupt
>   PCI: rcar-gen4: Recover the Root Port on link down
>   PCI: dwc: Let glue drivers hide the Root Port MSI capabilities
>   PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
>   PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
>   arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
>   arm64: dts: renesas: r8a779g0: Describe the PCIe AER interrupts
>   arm64: dts: renesas: r8a779h0: Describe the PCIe AER interrupt
> 
>  .../bindings/pci/rcar-gen4-pci-host.yaml      |  10 +-
>  arch/arm64/boot/dts/renesas/r8a779f0.dtsi     |  10 +-
>  arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |  10 +-
>  arch/arm64/boot/dts/renesas/r8a779h0.dtsi     |   5 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  38 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |  15 +-
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 723 ++++++++++++++++--
>  include/linux/pcie-dwc.h                      |   2 +
>  9 files changed, 724 insertions(+), 91 deletions(-)
> 
> 
> base-commit: f0406245cb9855e6318335a8a223551354291a46
> prerequisite-patch-id: 5b4c9da1333342baa90cf6a86dc879e8382d3f65
> -- 
> 2.51.0
> 
> 
