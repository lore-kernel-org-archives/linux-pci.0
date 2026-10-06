Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020139.outbound.protection.outlook.com [52.101.229.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9233B9929;
	Tue,  6 Oct 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276413; cv=fail; b=Kr1hUz7UzW17F6TPiJi7r0ImhTN3WWW4jN/QLAyXq9KPVQrctmoVifykxECvbY5jvOPcbsB/2oCeetNPZ7YDUMEkJZU1fsZuPg6jGZlSvjAtZhRAGCty91srUOUFSkiujlsRJlByiyUL87jCj4/FMyPZlBqdfST+xvkHKTAZzh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276413; c=relaxed/simple;
	bh=bMwhpMd1KFVRDol+VZpmtPgBbzwgV/iMF3+0IfLGMyc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QSGK985uN0RbRKWSkWX5+OueXJuoeoSA3AxJqfgp9C8TZWGG8XLvd5xArWbw7hmKXc8awglI+27VGV6306ufTr/YJRIopHUtuhhfrNKSvTRvcRynar9zs02aBg+Z05y03+mqrrm5n8LMKpb7KBo1EDI9b48XBTCZ2k4AkR1bO2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mgWzrlvv; arc=fail smtp.client-ip=52.101.229.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mgWzrlvv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+slJSgkwWIpbTtnDBO6MIJazHTV8RFA8J+0cwVxGT4QL8GPRmlM1BtCxmcmu0BXgAuJKuZMIcLg7x7BGGzsU0gR5r6//r1ntqYhl9Ty52Bg/RQz2jUFBz9VV5oTcohavGuaBUPgeLS5wHj9PrO0G99adsWzEztDjbNjQ1FlTJnysdHzCYNISTiPraajA+GHDECYuUMJ7c+BBIXer9wMKl0z8lkWl/r2fOZj93N2YOLNg7RU4RZVNTKW1Q/Ov6myJARtw8f0eCKt1OI9En9r3/00Hj2H3uOvOTZgepW8OTWONaagr29XnFFImaMMYan9sgDu0GqZxBuPY/WuWwMrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+Iiu7dhqLxXv+oiBLT6QS4QNUXJdONhbuuY9CzyGc8=;
 b=LDpcCijRbnI5eTFzk9LqvojNJNDw8LuIkIYBVIMH/sjYy+9PKRrcfIQhCjT2mLVc6DI5Uyw3BIemvFDJNq+ClWkDe981T4WQY5cZcJs3nbzy8SZPizF8UGuB/Zs755D4OC7+JsitSDaJqryfaZOw+2GlP8cnZ8WYicg87imV5DifF4uTDoaJoeJvJlolwPCaxQe3CmZjsyTkvVRJNRaZW0RjhW3EJDHnUyFUTc0AfULulpJLSoqGa2pmDPbsQSKuV6uwiWKyA+TG2093bjW0ikYthp/wsDtq669sRsF84VGox6IoKmXRP42jVIeDnh3/uqSy4dIvQu+W5J3byUz28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+Iiu7dhqLxXv+oiBLT6QS4QNUXJdONhbuuY9CzyGc8=;
 b=mgWzrlvvZBABVrVmRcFIEfoXfYdB/W1W+VJqOQ15qu7GMmRaf/EpAcRwMYXbIBGcC6KwS3YiLmKT/drGAXvmr+6N57LhZW7rm7jwpUI4w5CoCX+1O5PufdBZBAzB3vxcF1ftnDkUiUvQBbDs5Z9Zc6uVkAP7AI7giqFri7g8mGk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:46 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:44 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/18] PCI: rcar-gen4: Recover from link down and route Root Port interrupts
Date: Tue,  6 Oct 2026 17:46:20 +0900
Message-ID: <20261006084638.3821710-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0057.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 3696a56b-da96-41e0-9c44-08df2386598d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|5023799004|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	VCytjopHFyLiYfUwWNjFyAB6gAOQ9ABmmnCG5eOxFT4NKNjrmgRStvZijWv4r7lzq+DO1wZzYrppU+Q0FT/IZdful/o//DKPbI9npulCOC5ctHyzVUHc5ru2h8wjGg9i7inLsCkVqrQu/5Ubn5VHnfTSEtyNUbsr5ye+r/Q781rfSmlv2YgcrntSkOXzJtVx88QgN1YqNU/Zv5xar+oV455DlPLFYLCRpefYSRQJmQCkXY0amt4m6G/3f1rp+K0NdsGSmI1Pq1euuvl+qQtBa04epxlzcIvwIRvFNPVxhqF7EhkJ3bM9YYni5tEobR27YRwj2dzuUsktg/OUd3j0Q1srW1K6mV3RnNl58flAc+bQBGgWfMjzToheGcsZIwKhxiMPZvC9NFmxSlrXV4lyqd8/tOozlkUQWa/2uaWZc1mjfj8lu1Il8T+Ts8cnAHKCC6HCeU/t20h7dIZtFYDEfkyEwMqxTTH5amzK9zjyZ+BDJlEB4WqzGBftI1dJbx1BPiLClvzy0mT0xmUko29Hs0ZUHn1m6FksyP7tvInbvd1MWV97uKp/qsggHgvSXD9sBBjtLFwxOao+7krXbBEaQLiaMK+qoPhr6ltzBQ0uUBlmcpzNZnLxlHr8lkK1gG/ejumfvB9PQijufohbz6LjeS1yGfVsMzsrduGGdyYbbbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(5023799004)(921020)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXPULiA43NlhQ5PqfsMX/NSGKgpED56Pu8cg0rMIYu1hSxRtzNfi3mFjMG65?=
 =?us-ascii?Q?ArVIQjtIXtph643KIhSvN3Fx13yRBzRbi+1dLZjwUL9EhGQJtZix/szy0MsJ?=
 =?us-ascii?Q?qy2sUY4o7OyWhwf2CgMCH8qur05urz6vPhdES50KuZgWrzI9/m8NBe3aAgrB?=
 =?us-ascii?Q?i+ClSt6wHEnq79K3tI3vXwqQzpjlZqLkyJ3LPKfGpDMOw3SspljiQOoTaaLF?=
 =?us-ascii?Q?Yvy8H8ygoKrMpsFXiacmOr/RxlMwfAkeXvvyK5FvqJQNqKVT7YtXr5MZwV4Q?=
 =?us-ascii?Q?81VPmhAVqvXM4OXvNctQAQtHm2tonwAPmbqG3SLmb+IXqAK62jnbm2ky9uHB?=
 =?us-ascii?Q?ugiWFg2JyoOVYJfnw3/V4XeN+cpdWJjCz/UikyNzPo4jMs8zAp7zcqPaeyBD?=
 =?us-ascii?Q?PhmDBhhigq8tpRWJIOTa2yTDHpakHLhxFDItmbVoaROE5OTQ374XyAXjnNy9?=
 =?us-ascii?Q?3GeoLXAi3YkuENDJ8Lorc/Kky9YJBN35dvPrpGpxB1udYJqujg5/uEdgPaYG?=
 =?us-ascii?Q?z4K8Ks8viYrAJWBirTQv3ZWdoErzw07jvhNUMm9tVHf9L0F3QaqOMRIlRzN0?=
 =?us-ascii?Q?h1Hn0qDKoMtrx19WKGzfOT8UPH576eQHOH4q3W4PMI3fATqGEzoadR2a6hY0?=
 =?us-ascii?Q?YDFu9GRhZdo4XJObjk8G5sEotfB0HE44peaCljz3/NZKKuY0P41GVyQ+8bSU?=
 =?us-ascii?Q?UuBr6GbTOrb4mJ3fbnKQtTvIckmdxa8wyEWJqjnBDpUTYEMRg4NXU/kwOQKu?=
 =?us-ascii?Q?Vy6sVSern5PS5UpFfIJJmAdvMHyVOdRnrkwtUNRuel47WW61A2eEakOR4oit?=
 =?us-ascii?Q?oTa+0vWDMK12H01g6whPOF9BIXC6B8mBPe73vPs633RoesTDW3yzTvdRh61n?=
 =?us-ascii?Q?RWTWHLsUxpKMVAjAz0KDQzHU9OFUqojPql/sBvvFvO4NF1mnw0dyMpSl7NvH?=
 =?us-ascii?Q?caUJk576pB2de8az6rWLya8tB2/D64tH14mu5T7FRMdQOiGVsIPbfYEW//bN?=
 =?us-ascii?Q?HzA9B/kyIeZJznwoWC1OY2NknmS88Ts/3QSP4BysFCXxugm5QN/XvRS6tkiI?=
 =?us-ascii?Q?2VRiatoNw5zj3tgoKW5+EA6Q0odkOZsK9AZISMc2k2XTdOXpmgo9vGyb7LZO?=
 =?us-ascii?Q?IFxVfb5cXr7Tce78ktbYV+sIFMAuJCi/wqsJhwf2RI4BV+SB1ICGjoUWrDFC?=
 =?us-ascii?Q?FoZEejpGe5zVKePwfARKrvXWeZwVVgHTb2XZzNjeBrQodpuP0ZYAK5C4PAY+?=
 =?us-ascii?Q?tQwZBFZ0R3eTr8/TBuzgskFF4IZpMjvxkwP4oqQ7x/Gc2mTORFjhqhB2Napg?=
 =?us-ascii?Q?8msnW5KiuhT27XiiepvM8anOR0/kTydMTgE9SIEa2iNfDDHdmFpBLjXB1Z7g?=
 =?us-ascii?Q?Yepm+ALT8yrKQHlSqZflWH4uYU+63oxs7nnx0kRW++4r7mPADD+CNd5xgf9N?=
 =?us-ascii?Q?FGrhBjwml29o5ZDFc0p9NKByTBea7GbCtpEUcGZUpsl6giri/tO8VSZhUxzZ?=
 =?us-ascii?Q?NkMmx6LMSnHm3Z8b3kPyiYBqyLvG1x8lnOZHrRehgPwo0KwJCMusj/5W1Xu2?=
 =?us-ascii?Q?q0tltK7aJiEWFWbGI9MH9ZxtUDiBUqRRWB9rWvKzdr9ncpf4vcPyulJQ5Ubo?=
 =?us-ascii?Q?/rKIoJQFgo2Xf2IucNCHh2FjxMhwVVpHHm+VdQ3kIPnKeKNvSpG/EPlcaxC1?=
 =?us-ascii?Q?FhhS7u1y2DEz3HCrojeQZwAE1aZ4cFUalyaQu536Pwb/EJj62AKtADFQYNB0?=
 =?us-ascii?Q?Mad1oYgchwGuoTltITyO/C/EYQJ2ffnTi6jSi3Rgr0dYPiPmyuq9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3696a56b-da96-41e0-9c44-08df2386598d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:44.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsjO4VSZ7CaxeibR2ws9s28Qb2osVEyxobYNG05kyH3GYf2lf70Xsl0zQaeZk+/KyA7/qqC2STrUbVJUUWtvJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

Hi,

This series improves error handling in the pcie-rcar-gen4 driver, which
supports PCIe controllers in R-Car Gen4 SoCs and the PCIe4 controller
in R-Car Gen5 SoCs. It fixes unexpected link-down handling so the host
doesn't hang, and wires up missing Root Port interrupts (AER, PME,
bandwidth notifications) so port services actually work. I tested on
an R-Car S4 Spider (r8a779f0); Marek tested the link state fix and the
Root Port AER and bandwidth paths on an R-Car V4H Sparrow Hawk.

A few hardware quirks made this tricky:

1. PCIEINTSTS0 link-up bits don't track the actual link state. The
   driver never noticed when the link dropped and kept trying config
   accesses on the dead link. Patch 3 combines the APP link-up event
   check from Figure 104.5 with the PORT_LINK_DEBUG1 live link check,
   which patch 2 factors out of the DWC core. Startup clears the APP
   latches before enabling LTSSM, and the DWC core polls the combined
   condition on the RC side.

2. On S4, a DBI access immediately after an unexpected link down can
   hang the host. Commit 0056d29f8c1b ("PCI: rcar-gen4: Assure reset
   occurs before DBI access") describes an SError on V4H after reset
   deassertion, but whether the S4 hang shares the same underlying cause
   has not been verified.

   Adding a delay before the DBI access avoided the hang in my tests,
   but that alone would not provide link-down recovery. Also, the reset
   request shares intreq_pcim_sub with iMSI-RX, while AER arrives on
   another IRQ. Delaying AER dispatch alone would therefore leave the
   MSI handler exposed, and both paths would still need coordination
   with the controller reset.

   The driver handles the reset request itself and schedules
   pci_host_handle_link_down(), as the rockchip and qcom drivers do.
   This also provides recovery with older DTs that have no "aer"
   interrupt, without relying on AER to initiate it. The reset callback
   shares the reset sequence used at probe, including the reset-status
   readback and delay added by 0056d29f8c1b.

   This covers the interrupt paths that fire on link down. Port service
   threads or work already queued or running at that point are not
   stopped.

3. Root Port interrupts only trigger APP status bits on platform IRQs.
   The controller appears to lack SII2MSI, so Root Port MSIs never reach
   the GIC ITS. The Root Port's INTx is routed to intreq_pcim_sub as
   well, which the driver holds, so port services can't request it
   either. This series works around it by hiding Root Port MSI caps
   across the board and emulating INTx using a virtual IRQ domain, fed
   by the "aer" IRQ and intreq_pcim_sub.

Patch 1 is only loosely related: it adds Renesas to the RAS DES VSEC
list so the DWC debugfs error injection works on R-Car. I used it to
test the Root Port AER path (see below) and included it here for that
reason. Happy to send it separately if preferred.

Based on next-20261002, with Marek's PM ops v5 patch applied first:
https://lore.kernel.org/r/20261004011851.866833-1-marek.vasut+renesas@mailbox.org/

Note: backward compatibility with older DTs is kept. Without the "aer"
      interrupt, only Root Port AER remains unavailable. See the Testing
      section below.

Retesting with v3
-----------------

Setup: R-Car S4 Spider (RC) linked to another S4 Spider running the
       pci-epf-test endpoint. pci_endpoint_test is bound on the RC side.

  1. Link down / recovery. On the EP side, toggle the endpoint controller
     off and on. The short pause keeps the endpoint away long enough for
     the RC to notice, but brings it back within the reset window so
     recovery can succeed. Adopted the test approach from [1]. Make sure
     that the unused function 0000:01:00.1 was removed on the RC before
     testing.

     # cd /sys/kernel/config/pci_ep
     # echo 0 > controllers/e65d0000.pcie-ep/start
     # sleep 0.1
     # echo 1 > controllers/e65d0000.pcie-ep/start

     Expected on the RC dmesg:
       pcieport 0000:00:00.0: Recovering Root Port due to Link Down
       pcieport 0000:00:00.0: Root Port has been reset
       pcieport 0000:00:00.0: AER: device recovery successful

     and the "msi" (intreq_pcim_sub) interrupt count going up in
     /proc/interrupts. Without this series nothing shows up here: the
     link comes back on its own once the endpoint returns, but the RC
     never notices the outage and the endpoint is left unconfigured
     (see 4). Config accesses issued while the link is down hang the
     host.

     [1] https://lore.kernel.org/r/abFMa6DCGGLUHddA@fedora/

  2. Bandwidth notification. On the RC, retrain the link:

     # setpci -s 00:00.0 CAP_EXP+0x10.w=0x0c23

     Expected:
     - the virtual Root Port IRQ (rcar-gen4-rp in /proc/interrupts,
       shared by PCIe PME, aerdrv and PCIe bwctrl) fires once
     - bwctrl clears LnkSta.LBMS
       (setpci -s 00:00.0 CAP_EXP+0x12.w reads 0x2024 again).

     Before the series LnkSta read 0xe024 afterwards, LBMS and LABS
     stuck.

     This test does not generate a PME. The PME service shares the
     virtual IRQ, but its path was not exercised separately.

  3. Root Port AER. On the RC, inject an LCRC error with the DWC debugfs
     (patch 1) and issue one config read so a TLP actually goes out:

     # cd /sys/kernel/debug/dwc_pcie_e65d0000.pcie/rasdes_err_inj
     # echo 1 > rx_lcrc            # error detected by the Root Port
     # setpci -s 01:00.0 VENDOR_ID.w
     # echo 1 > tx_lcrc            # error detected by the endpoint,
     # setpci -s 01:00.0 VENDOR_ID.w    # reported back with ERR_COR

     Expected on the RC dmesg, respectively:
      pcieport 0000:00:00.0: PCIe Bus Error: severity=Correctable
      pcieport 0000:00:00.0:   [ 6] BadTLP | Receiver | Data Link Layer

      pcieport 0000:00:00.0: AER: Correctable Error message received from 0000:01:00.0
      pci-endpoint-test 0000:01:00.0: PCIe Bus Error: severity=Correctable
      pci-endpoint-test 0000:01:00.0:   [ 6] BadTLP | Receiver | Data Link Layer

     plus the virtual Root Port IRQ count and aer_rootport_total_err_cor
     going up by one each time. The link stays up throughout, the DLL
     retry recovers the TLP. Before the series nothing is reported.

  4. Regression check. Run pci_endpoint_test after step 1. PASS/FAIL/SKIP
     counts match a run without step 1.

Configurations:

  a. Without this series**
  b. GIC ITS, DT with the new "aer" interrupt (this series)
  c. GIC ITS, DT without "aer" (b43aa6a6ebe8 ("arm64: dts: renesas:
     r8a779f0: Add GICv3 ITS and update PCIe nodes") or later)
  d. iMSI-RX, DT before b43aa6a6ebe8 (no msi-parent, no "aer")

Result:
             recovery   bwctrl       RP AER    pcitest
  ---------------------------------------------------------
  a.           none         no         no      all FAIL
  b.            ok          ok         ok      no change
  c.            ok          ok         n/a*    no change
  d.            ok          ok         n/a*    no change

  *  Root Port AER needs the "aer" interrupt; without it the behaviour is
     unchanged from before the series.
  ** Only patch 1 applied on top of the base, so the same debugfs error
     injection could be used for the comparison. pci_endpoint_test fails
     across the board there because nothing restores the endpoint after
     the toggle.

Best regards,
Koichiro
---
Changes in v3:
  - Rebase onto next-20261002 with Marek's PM ops v5 applied first.
  - Keep parent IRQs registered across suspend/resume to fix the
    unbalanced enable Geert reported. Request them in probe with
    IRQF_NO_AUTOEN and enable/disable them in .init()/.deinit().
  - Use a freezable workqueue for recovery and reject suspend while
    reinitialization is pending. Re-arm Root Port events only after
    resume has set up the link.
  - Factor out the PORT_LINK_DEBUG1 check (patch 2) and reuse it in
    patch 3. (Marek)
  - Replace .reinit() with .configure, folding v2 patch 8 into patch 9.
    Drop the reset mutex and rely on PCI core serialization. (Marek)
  - Free the MSI domain after host .deinit(), so the driver can stop
    its parent IRQ first (patch 10). This closes the known gap in v2.
  - Reset the controller if recovery finds no Root Port, so a successful
    reset can restore interrupt delivery.
  - Drop the raw lock around virtual IRQ dispatch. Preserve MSI-form
    latches in irq_ack() while the IRQ is in progress or disabled,
    avoiding lost notifications without nesting port service locks.
  - Add patch 7's Fixes tag, clarify SoC generations, separate guard()
    from goto-based cleanup, and simplify IRQ return statements.
    (Marek, Sashiko)
  - Add the V4H and V4M DTS patches 17 and 18. (Marek)
  - Collect Reviewed-by (Marek, Krzysztof) and Tested-by (Marek) tags.
    Drop Marek's Reviewed-by from the reworked patches 12 and 14.

Changes in v2:
  - Rebased onto next-20260925, including Marek's R-Car X5H support.
  - Keep .link_up() and require both the APP link-up events and the
    PORT_DEBUG1 live link check. Clear the APP latches before enabling
    LTSSM and reuse the DWC core's polling on the RC side. (Marek)
  - Let the R-Car driver own intreq_pcim_sub in all configurations (new
    patch 10) and check the reset request from its own handler instead
    of hooking into the DWC chained handler. Replace the pre_msi_irq host
    op from v1 with an export of dw_handle_msi_irq() (patch 4). (Marek)
  - Keep the reset_control_status() check before asserting the power
    reset. (Marek)
  - Separate controller reinitialization from .init()/.deinit() and split
    out preparatory changes.
  - Use bool flags instead of a state bitmask. (Marek)
  - Keep Root Port AER notifications masked until .post_init, after
    enumeration. In v1, they could be enabled during port-service probing.
  - Keep APP interrupt sources masked if the Root Port reset callback
    fails, regardless of the reset trigger.
  - Hold a reference on the Root Port in the link-down recovery work.
  - Clear only the MSI-form Root Port latches through PCIEINTSTS0CLR;
    the INTx bits are reserved there.
  - Serialize dispatches to the virtual Root Port IRQ from its two
    parent interrupts.
  - Collected Marek's Reviewed-by on patches 1, 3 and 15.

v2: https://lore.kernel.org/r/20260928165230.3397664-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260918032038.2216471-1-den@valinux.co.jp/


Koichiro Den (18):
  PCI: dwc: Add Renesas to the RAS DES VSEC list
  PCI: dwc: Factor out the PORT_LINK_DEBUG1 link-up check
  PCI: rcar-gen4: Check live link status in link_up()
  dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt
  PCI: dwc: Export dw_handle_msi_irq()
  PCI: rcar-gen4: Move deinitialization helpers before SoC
    initialization
  PCI: rcar-gen4: Assert resets when Gen5 SoC PHY initialization fails
  PCI: rcar-gen4: Separate hardware setup from resource acquisition
  PCI: rcar-gen4: Add Root Port reset support
  PCI: dwc: Free the MSI domain after the host .deinit() callback
  PCI: rcar-gen4: Take over the iMSI-RX interrupt
  PCI: rcar-gen4: Recover the Root Port on link down
  PCI: dwc: Let glue drivers hide the Root Port MSI capabilities
  PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
  PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
  arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
  arm64: dts: renesas: r8a779g0: Describe the PCIe AER interrupts
  arm64: dts: renesas: r8a779h0: Describe the PCIe AER interrupt

 .../bindings/pci/rcar-gen4-pci-host.yaml      |  10 +-
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     |  10 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |  10 +-
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi     |   5 +-
 .../pci/controller/dwc/pcie-designware-host.c |  38 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  15 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 723 ++++++++++++++++--
 include/linux/pcie-dwc.h                      |   2 +
 9 files changed, 724 insertions(+), 91 deletions(-)


base-commit: f0406245cb9855e6318335a8a223551354291a46
prerequisite-patch-id: 5b4c9da1333342baa90cf6a86dc879e8382d3f65
-- 
2.51.0

