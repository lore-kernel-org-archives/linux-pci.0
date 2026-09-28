Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021136.outbound.protection.outlook.com [40.107.74.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C24F0543;
	Mon, 28 Sep 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614391; cv=fail; b=EiYbX4qffFzzCIn7PFsOttogbYGMTykzLXeySv1ybe3LJHn5Zznb5vVOgNHX96D7F6EY/qFUjI7TlqpWpIayhGaHlV+wEyMXPz6IertQNDfBVuimhdmSoktoLTxqGtMsoMAYCKm4uXPTYY7geMPjxJTGLZSe+SiJbAjMgW60Kw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614391; c=relaxed/simple;
	bh=O2/my9Wg3rtrR71oqR+hRkEQat2mpB1f9f6Ozrx2RxI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WtB0mZKm9F8U+Kkgg0R5wrIr+2gljzU9i79rN3+Hhc/yXIN6SqPUElNMJScJ9GOfnqbpDoWRtlF8mGqnhvMQmnzuVXNgWau9yKJRBuXuT8ucl0uySTtzQ162oQxlnOC7ajpPXGfOD/QPQAX6JtLmU09B++FIgLq3sh0SEbbBo0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Lr+UtnZv; arc=fail smtp.client-ip=40.107.74.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Lr+UtnZv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qro52aY+JxQnRm808WFbZEGm1ME8UH28PtsjR+knHRI9krZxqkHCkAsJigGhO5wIw8VTAgoO2BqDWgwQd/S/wFK8gEBpAskQ3SA6McnbwWtJlqFba7QRT/8ogtJXErOaau9/Hfz+X3XRe/RDvLqkJKr/EWN1dN0G1M2rlLvJH6tMvV6TViAQisOHaX5UEaQLJEW6jV5FeW4d1llMba4IB3yUqX8LrokPdBq1+N3nSjhOWtZW8v6Mmchfx9qid06vAa/s0XM+lwWBwdUn/kzujYLTJBtbsgeThqylEkrCExKDQUyj/uRHYdSorYb00N0xYmj6yL7WqRpLoJ6/x6GYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnEKukGIEXZG/k7deak9uBWt9UKhL/sz8UIJO4+uaac=;
 b=jBgQWvFxMOmaxaDUTOhX4bXpBL5lg2uNcqocpXXgK6Za8wyEJkxIUiGoUqgmkZwpQa10EGMXjcRNzUHbnmxU4reKtpDkBWDOCGttHmfgtc43/hjVU1v18l42tJFSFihLXDGnbRWbeIx0hlspGlncbJldAV9UkdZ+ii7+wyPl9resGqoJKr2MVOqfKhLItUIWcjcpkoIk4meKsHXvgL3Jjb6VV4aziRmfxLDI2NmiEFM7nW6VXz4NicQcOtjSVvRo64SMzuSQGkXEfA4Wn1h0mgwTwQGRAntK0yQ2TvrNp/f2S3gwmeLxIs+8f2yHnB3XSVpDo01MJ+T755yDXu1xAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnEKukGIEXZG/k7deak9uBWt9UKhL/sz8UIJO4+uaac=;
 b=Lr+UtnZvHZpHnRTvbnp5xn89JrRm2TzEPVPUvYm0O9WStLeZOfJtTgNyT4AtNkrLUgHHM8T7BfrKBzR2irB9g6hSsIwAK9q6bcx4ntr4s8mpWuZOetJz1sL/TA06Yszb5ik7OpQgvnjNVrWt0CLcKpEMkkp5TQAp3uwKwj0Afqk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:00 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:52:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: [PATCH v2 00/15] PCI: rcar-gen4: Recover from link down and route Root Port interrupts
Date: Tue, 29 Sep 2026 01:52:15 +0900
Message-ID: <20260928165230.3397664-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d596974-e246-4045-9efa-08df1d80f3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|5023799004|10067099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	/88457Aq/EWE4swmHFWaOqwtkN49oTpa1tTekukqP3zKT0o6W0PrbirJCNO9UwXROYiqkwMDc0QfuAIDgi15aflHDRKXJ/CXaRVGLD1mvMvflZGNJsLg/Pur5KX0PrjYp11zJXUR/IjJ3nRjg+tmHaA2FQIbuFcxMT3cjQfU8Cw2wtZqOwn8p0r3yhC2ugc00BhqiS2bdfm4iZjqzYgrRkU4unqG88DAIgCyiv6EofYffIDJNhCisHTmGMiWHyj1vENHnBXao1FwIdTH2Upi+ooWOfbgM11ieXiMUuKXRzliu6tY3kLbk5Fy7CqZCcii3VwMrpMxyB4x23UCAUpQY9LRPIgYXn+S9LaUx8SU9hq5wLiOaWRWLewVgPWWmqRCYbiDNVIiJY6hCPTTdmw4VndzZ/b7Dv18f4dWcSe6BoVSidU0DOVut3xXKUQbhGM7VO7ojlpiaa6YwU2Slqj9y5y09kUV+Xf0Onq07cA+406HG/2n9ysh8a97UKga/3pY7Fnr7lcLhi6Gp8PrE2WQlxEj6ZuC380uiAZp0txuS3kBCEFFs47kF7KVfge4q2x+x/DN1kgl+CWEZNZOPwTvJ7Z+koagFswgHFJm/tLmAXpXTRFhcvW8jUdFB0foZdseEdfwwZqyS78tsKrEWgbscHIB58gmTsjr40RBopeMHpM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(5023799004)(10067099003)(921020)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6jMS8i2bamh5fl8P3ZI2XpnLZEuvOb2AOCqcThzHoewIoVfHgH3gh5aAIjj?=
 =?us-ascii?Q?7uJL3c3Aswwb3NQ6U5CMdItwZCP898GA8EpMYHb/rRfEWIhM6jJ2+TiOt5di?=
 =?us-ascii?Q?yEheWhWiX80rWGp6SmWE2s8e4zG+Y2ftGxjlQlB1FxzUUFj0qZ/Z9q+83Xys?=
 =?us-ascii?Q?iwDo0310K2PhmdjDg0V+V8ZJJVcjU3gz48HshK6OK9tAbHX8RoGT0ibagxWX?=
 =?us-ascii?Q?49D4qBDrkZzlnsNmiDt+MYt/jEQC02nsTk75pdoI3AGQ6IQHp1D0fblnDs/y?=
 =?us-ascii?Q?lchsIb1f6lESNTfjHcvVoOVg1/YqH+muCxhp4SmClNh4ViaF4zyef7V/Tlux?=
 =?us-ascii?Q?J7CXiAc1ninu2rO/6og7TfmFNyBixT2vNCPZ7Au37MJjyaHnMw8M5RX3kgvH?=
 =?us-ascii?Q?PHajNdVKfmz3o47YDUI5SdreROtW3e5BEnf7WQhXGCym7MZjEnQACrJtix0Z?=
 =?us-ascii?Q?7NvdQQM7EjfhkeMjwmDeduHkY9TKv+CX1hZIJFzzisrV4Jf2Er6jjW7R0SmU?=
 =?us-ascii?Q?V1qLy4q6ycYds3Wg6EpvGnU8B4ikCOKyzrHKfQt8Bce9NUj3KtCbm3+TsI8l?=
 =?us-ascii?Q?BCvHoCL4VRAsVOQA9d0D0ydq7jma5IFunNE2MM1R5Cqv48+5DbTIfGd1GaB/?=
 =?us-ascii?Q?AqFzAWXmaUOKlm9tUt0SBJtXHVsKgS0abrexXC6PzpHnH8eTt5fyufO+SB0I?=
 =?us-ascii?Q?hImTx06/kTLZkUNbDUBJtVvgJmVmeY+znpEezz8oXP+8mLPvXR/WF+GJAoRO?=
 =?us-ascii?Q?/rThbuBSWlcULmV6r8PBA5jXHnAY5TH+O/zGgjS/uXe7wUFoFyWZiBdQ8Mtt?=
 =?us-ascii?Q?pkcVQ1S2LDN22YUjgBKr/J87gPwsEqUmKExxqMEVf96/k6VFWT8D2vfcX/ls?=
 =?us-ascii?Q?JBwWdY+BJvGOnQ/akiuiZ16sAZb9WoHmumL4aGMFgBlNlT7A0bJAbRyB9twe?=
 =?us-ascii?Q?jYvy31o8V+1rPOjJ2TJPt7qBek0EUWvcIGPzDS3x5IMXe+FwKfXvRZYhQBfJ?=
 =?us-ascii?Q?piKC390pkNyhcGa/fwWerkhsU2Pq9g6bR9Ws0hpmLsWPIsv0lsJ8P+Rv/6gx?=
 =?us-ascii?Q?KGOat/PkIPCQsrAqE6ztnqtnVEmR9JbCLy9NLjrWMRggv8RAsiIxvb5jdSnk?=
 =?us-ascii?Q?ubEyEk4sZwYLuqwhQYBMXr6SaG7Uo1h6lCxkKxSbdKdQ0IukRdwmCPn5dfO7?=
 =?us-ascii?Q?NFbYdnt+AChV5noQsh1ZJ7dCIcTWEtxJc4o6gNwu7vJiX/BmDj8HBmNTo917?=
 =?us-ascii?Q?e2nc1XOmrVfxvQE4iJoDFD7TSCte8v6suwFwzFSvNHP6zZG53Sw3tVPN8q+B?=
 =?us-ascii?Q?NtY6odKTbohXTq4B7poQUSo5OkKylh1a4IUlnHkhsV7/wQ7TaKQLXzC8Jw/c?=
 =?us-ascii?Q?9vcoW0q4jQY+nGbXyJrQHwlB/O1UF4TCWXOCtCP9o9t4lQrAtxKRNaUEif83?=
 =?us-ascii?Q?mM+SQoH5h9oSlw+WpSZVdZnG1OISmfEPhStradHHLAKIiAred15/AgBShYsl?=
 =?us-ascii?Q?ri0k1m2FfiBebE/+tOr1EZr1TCVVhEf4DEOc1GW6WTIINkFTq9S0JX5PQDDf?=
 =?us-ascii?Q?+m+iPSMDa9WnVwq/HA7r0w0JwhggY+tZdLmeGlw+O3VrvTyQHRi02Vv36gm6?=
 =?us-ascii?Q?6F4HhGpcU8G0KoTWdLOEXb5VHvcH7QfWYT59Cq7IFN/hfThjG0kC563W9M8S?=
 =?us-ascii?Q?eCRdqX/tvX9aRw6BH2TAkF0jPTqrZTOPe34yNTE4SsCoa/QbdYEo02ie/+An?=
 =?us-ascii?Q?vIe65nJv8JEBvgl+iezt79XX2gj//RFr3NtjH+rQLzsX7ng97af4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d596974-e246-4045-9efa-08df1d80f3f8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:52:59.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ok65ISKLWzSPGXCvJ980GOrhXaRlCfJuwKtBCMnd3tHALg26CYKoRz/1IYqCbQNBSJCLF134DItM5bON9CH6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

Hi,

This series improves error handling on the R-Car Gen4 PCIe host
controller (tested on R-Car S4 Spider, r8a779f0). It fixes unexpected
link-down handling so the host doesn't hang, and wires up missing Root
Port interrupts (AER, PME, bandwidth notifications) so port services
actually work.

A few hardware quirks made this tricky:

1. PCIEINTSTS0 link-up bits don't track the actual link state. The
   driver never noticed when the link dropped and kept trying config
   accesses on the dead link. Patch 2 combines the APP link-up event
   check from Figure 104.5 with the PORT_DEBUG1 live link check. Startup
   clears the APP latches before enabling LTSSM, and the DWC core polls
   the combined condition on the RC side.

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

Based on next-20260925. The driver patches build on 7fc9907223d6 ("PCI:
rcar-gen4: Add Application/Local register reset control") in pci/next,
and the DTS patch is for renesas-devel, which already has b43aa6a6ebe8
("arm64: dts: renesas: r8a779f0: Add GICv3 ITS and update PCIe nodes");
configurations b and c below use that DT.

Note: backward compatibility with older DTs is kept. Without the "aer"
      interrupt, only Root Port AER remains unavailable. See the Testing
      section below.

Retesting with v2
-----------------

Setup: R-Car S4 Spider (RC) linked to another S4 Spider running the
       pci-epf-test endpoint. pci_endpoint_test is bound on the RC side.

  1. Link down / recovery. On the EP side, toggle the endpoint controller
     off and on. The short pause keeps the endpoint away long enough for
     the RC to notice, but brings it back within the reset window so
     recovery can succeed. Adopted the test approach from [1]:

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
             recovery   bwctrl/PME   RP AER    pcitest
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

v1: https://lore.kernel.org/r/20260918032038.2216471-1-den@valinux.co.jp/


Koichiro Den (15):
  PCI: dwc: Add Renesas to the RAS DES VSEC list
  PCI: rcar-gen4: Check live link status in link_up()
  dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt
  PCI: dwc: Export dw_handle_msi_irq()
  PCI: rcar-gen4: Move deinitialization helpers before SoC
    initialization
  PCI: rcar-gen4: Assert resets when Gen5 PHY initialization fails
  PCI: rcar-gen4: Separate hardware setup from resource acquisition
  PCI: rcar-gen4: Add a controller reinitialization callback
  PCI: rcar-gen4: Add Root Port reset support
  PCI: rcar-gen4: Take over the iMSI-RX interrupt
  PCI: rcar-gen4: Recover the Root Port on link down
  PCI: dwc: Let glue drivers hide the Root Port MSI capabilities
  PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
  PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
  arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts

 .../bindings/pci/rcar-gen4-pci-host.yaml      |  10 +-
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     |  10 +-
 .../pci/controller/dwc/pcie-designware-host.c |   7 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 711 ++++++++++++++++--
 include/linux/pcie-dwc.h                      |   2 +
 6 files changed, 670 insertions(+), 71 deletions(-)

base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
-- 
2.51.0

