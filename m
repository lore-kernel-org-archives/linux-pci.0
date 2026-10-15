Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020109.outbound.protection.outlook.com [52.101.228.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295C3905E6;
	Thu, 15 Oct 2026 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035083; cv=fail; b=rPIt10eqiQopwR0tfnocsiBMlm8chsvSvQI3EmKtRYpyRL9BSmi55cH4/HarEHRAN2kS1HlCJMyvokUpRgH4DYRaFhr4I45T4uqGTZ/K7nVySbm8Faz1+gkWoInHPkTxI9IhcS3Eo6MYApoJGOZbYZFXl/JNY7IXrIIWXDUqmh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035083; c=relaxed/simple;
	bh=zuAe/tonWry9dd6B2PbSw73lKLGjGDmPLIgh90RMi7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YTLE/jiZRcZWWg9D7aFNNRMOT/6IYE1jc/i/VyduvCxZ2KfnFQutd7eBrOw3aWVL+VdH6T3Tz7xUeUcsbRmBxHhrX/4SCS4VSxcPOnwymgXGPLZeCJwziCSKr8U5yS3oy51ncrlpp7Bpi/bX28G3bHiZPXLeKikmdQcxwuvasco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=itdN/A4q; arc=fail smtp.client-ip=52.101.228.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="itdN/A4q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQt7w2cg2dPtZMX0ZUgZEBtDuYuue6yOiw3tQtQGla0GK5qqkTfocY2qawQofHHyEaCOlXPgWNRTs1GyEvDqp0rmS4f2ATjLcCtjmuUtH+zuf529gnmPfH9SwXDv0I9Q2USDXAPqaPQjYwzSmq3cgdifVoGiKyQqGIMmAa6K5TufRyuiMSud+TGbniB5eH3aVgTjkRrN2dbcAWaptG9QG4XnzmAp8yTmSS0FmdYt9UcaDpMudgryfRJJCLqAOGEHyw5FNWQ7zskqsH9M5kc3GGuwNxU0PkIIAgAoRabxg9eVxw5aHUYhWLYKOZxcSMW1TJ5bkooKxjszfNl9D9ROtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THn2DaZ3oWGLeE5G+aGaJ56xT5GP2bMmV9HVXb1f7qg=;
 b=WflVQVgf9Uh43EoG9WVMtZ+HbVGlp+en/TWTEygdCE/eobMB1HuFAb7T6CBYID1TmBVTlZWVJjHHsaKJg+wGS17uzkYkti8brQDmvb5p3D6AP1iQCPE4yFTt6dAmgzxBdAY8oBOt8UroiLYqJIL4y4NNXaH0Juz9xg/KB69udojWPRd3ftDk4/5ei3Ac+4fsCdYyuGq+RSbj9hgvHK2OX4p8fULH0XXG/FwbvdTBiT78CXiZ9xTguw7bHNQLbFl1WBOhJ1qU2lHo7xmIZp6Bna5gCsk7uMVRnx/OrtBTCF7RZy8P3MeQ1vFAY+K+JApprAJrQ3KU6j3xazKnBusNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THn2DaZ3oWGLeE5G+aGaJ56xT5GP2bMmV9HVXb1f7qg=;
 b=itdN/A4q1GcVspkM2EmapvimKxTH31v9Ex0ux+kxx8jk4/FTtWK3TbTEkDHps7zVCua3o6UZzPFJhz9ZnzNsWf2kY8k44oSbzSMhcMc1wwtzthV1HY2KjFP2PGAGAoH0r0tVJDMTZl2QUKsdUs35s9EBXVCijs/AP5qm4MQi5qU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB2464.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:09 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:09 +0000
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
Subject: [PATCH v4 00/18] PCI: rcar-gen4: Recover from link down and route Root Port interrupts
Date: Thu, 15 Oct 2026 12:30:45 +0900
Message-ID: <20261015033103.3076869-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB2464:EE_
X-MS-Office365-Filtering-Correlation-Id: d752a0a3-908c-4b7f-e762-08df2a6cc10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|6133799003|18002099003|10067099003|921020|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1F1UrXXzM44SfASxBFYZXpfoehOwraCuJHDvBri05pyGUtkarVxFxo11ywV7Z6HcPPlbMxlj/YvsscHPYIAgQ/hSSU/6XXi2LSBlcMz7qpPmxrfxFjIDZDJSiZTbl7nVjiTUkGJifyS6+uSZt/znTyWSnKpb6qv42wEP40cRlMW/6JpQVFdCFND6hHba2AJx1oMxwBU9EPHPMHXWhcthJrBJJSpBtIJCa9KML+W8U/NBfmyvbklb42VwI+0hdh5xzNwkA1IaLzGp1DmJjDV5N0rhqnTA7Kq/+ulIbBzLyn2AIs+tPJDvmEpiTKlB5b/EE40LKP1e53uj+7fSOdrGSsLy2vAZFDqFaRfZLDEwH8zTnOCgs3z1AJ6ZutIKbcDPNTjMd3NtPDIzVKCf53vycq/9BmTaUjuNu03Jmiv5U5Z/KJTw6maihYrU0XPIUW3jefJFaEOMoRsVV/QBXtrPHihVbu6KKe0j9tUYzxe/vfMpbemn7jrtuFrBXDTq/YsLmVlm304cp4AsC7Gq7fadCeRzE+Hyj18fIN8V+Wexe3Q7nKC7wJEzulCaegp4fhHrvT/pvqXj8rouOfmNoOb2azOWcWO1TPefyz7QcYoMAZNFOrtRM4quTJQnzshJhTd8H7/S2khpDOeJ18EdJjWmZzyNgPqXxS9DKZc4meFVtmo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(6133799003)(18002099003)(10067099003)(921020)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMhZAprfokkmAQDm1CLFEFw2AX7SoU/t3n4H84Z/hcxWbgLhzES/7bqpY8uk?=
 =?us-ascii?Q?ndDgsVpm5KB5HmPNJT5JcvPUZACFtCV6Ysywi2WDDb2b88U3NwIGDoQeXcym?=
 =?us-ascii?Q?/TxAPpssih8S8vU/cdh2koKAwX1DXMQCNwFp5Q0rQbaksi8q08dZb7tQyejF?=
 =?us-ascii?Q?5mPf19VmNb49PyZ1/krNj+wjZty4sW3m5NHqbH3KWhLLuGXT1eejodRvKG1v?=
 =?us-ascii?Q?lqRu3+8+dFmVNLdzyRVDLCDfelO5fJSP8xEu/ea91yryZUGAWn3Se961a6Bn?=
 =?us-ascii?Q?TuPElGmCShOAjj2PKictTxVu7v/9+A6bCDV7gJJQnVyPsbO13USwg9Ll2iRm?=
 =?us-ascii?Q?G3miBgm2/QhUL1dmKloNQODsHAulXYC5nDLOI8jREU2LDi7UtbRkbHAlNeea?=
 =?us-ascii?Q?Z6e/W9CKDR/huI6lO3VDQoNPvTkzWyzF1eOZt7tHEY2zO46ytL5IFohI9rtn?=
 =?us-ascii?Q?oos9PIIlnhZ/bElBcTvaeay41PZ+jPZFb9gFedekKhLATAPwz0JmMbCqUBJc?=
 =?us-ascii?Q?tK160exZmcDQfVsRIlP9hijcxVZUDrGJKgVf8Z77wk0n7j77HA5elJQupbDh?=
 =?us-ascii?Q?sOGZS/4dPam6lSgByEFNub7JJDhdC/8gl9lVhI/EekNylrAdLqNPCPFa/0LE?=
 =?us-ascii?Q?IMxQATFuN1jCHSats66NnQ8IAX/C7iXEJDeOz72AV01jtpB9jRL6Q2m0pvzT?=
 =?us-ascii?Q?hCn8Q1GVehjEMpaCmhv2VzbcLRKRtl4k+Pp0E4n3LhYV7UQw/S4IK7/nHV0S?=
 =?us-ascii?Q?ytNdcpN7BAV+J7fZT7OW+Hxtw7+imH2ITTovltFl73egwob5PCQ/zCV+7M3W?=
 =?us-ascii?Q?CQd6dB6yjq+Bhi4RDd93kYhh8oxpPMbp4uYmF9tnvZZeB7K+EefppadvicUi?=
 =?us-ascii?Q?Q62VqosSRW4v0N9rtq7B1ASYl3ON6R7T+Dmp7a8/fW2FBkxUI3DSdx+9vn4Q?=
 =?us-ascii?Q?tFayb7HdlSt0r1wGhGNLCOO2Q+B/IDobLX6M54CRhShZF5tM10d5SOOBUFlc?=
 =?us-ascii?Q?h1qtfI4X+uJUivMaoRhHmJb/OlAujfY+zI2WvI2zEtgy/edSC8nCddEguGHz?=
 =?us-ascii?Q?bOj/MnbT1lXZdeQavgdDcgXySKgE5HyMKn3o7TZPY57gI4DjQFR2ikTXPcFA?=
 =?us-ascii?Q?+VuWPsxrLOuTqLBcnDSM1w5wJO1yM4fa/5+cCDg/HUDInvX8g8gJZzeJxh2m?=
 =?us-ascii?Q?5aA84UNccAuGMMPDFTGb2n6/7OGV35xnNaNSe6ys89pT8o7HdTCcZOodVEA5?=
 =?us-ascii?Q?ba4FFNo/p+GoCo5Dh4l3QWbZp5NT0GW5oX9jusdtNmh58XxCmur5uvZjRxiD?=
 =?us-ascii?Q?E2VzVpZNo89flaWI+JV0V0jWZr/JwFeeq2kqlssJdaeF8fQXW0Zeu6wWbCjj?=
 =?us-ascii?Q?Zu+2V1L1Ep6fFrmvSCcGC2ikoXhBWuK63Pocf/4/VRHacia+aY04FDpHuujy?=
 =?us-ascii?Q?VvGuknHJHNNOEFDY+4n0O/K/m5y6ZKtImeuZrluh79D+6XQsdwwOt44wbrUl?=
 =?us-ascii?Q?Fd7kWlJwWEuJ+wfNElkYSYUhReUI94qeoW+mt2KwXZgd+DY9zMBjHQOsvIak?=
 =?us-ascii?Q?Kf9hKsf/imsRIO+FEYKtdTTfBn5zleEkKqwx8TbpZMpbrwn5a+sur9gzkddc?=
 =?us-ascii?Q?a6RuwAxz8sHu/M5RwQ+13DzzHj72i4F9jRvNQyPTgIRzLyPMmZQScgPg8d0V?=
 =?us-ascii?Q?Ah0CFtQRulWN093CWE9I4U5M1nhn79/cbiMS+qFbkQEWRk0xqeWDqIpV8Cc3?=
 =?us-ascii?Q?eDGovchaO6LP2J39BtrM/sM+h4JFE04IOzv2kTSnpCLLlAhrdbX7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d752a0a3-908c-4b7f-e762-08df2a6cc10e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:09.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsGyyY1LIcZ8q0jv8lVh1OQPu1oc2tNXS1/RoGfquZeqyAIIB8kLbpzDxpheNI4TG+2mzCRZu8y1zlCuW13rHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2464

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

Based on next-20261014, with Marek's PM ops v5 and Gen5 AER binding
fix applied first:
- [PATCH v5] PCI: rcar-gen4: Add missing PM ops
  https://lore.kernel.org/r/20261004011851.866833-1-marek.vasut+renesas@mailbox.org/
- [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ with AER IRQ on R-Car Gen5
  https://lore.kernel.org/r/20261003215710.792518-1-marek.vasut+renesas@mailbox.org/

Note: backward compatibility with older DTs is kept. Without the "aer"
      interrupt, only Root Port AER remains unavailable. See the Testing
      section below.

Retesting with v4
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
  d. iMSI-RX, DT without msi-parent, msi-map or "aer"

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
Changes in v4:
  - Rebase onto next-20261014 with Marek's Gen5 AER binding fix.
    Only patch 4 needed changes.

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

v3: https://lore.kernel.org/r/20261006084638.3821710-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260928165230.3397664-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260918032038.2216471-1-den@valinux.co.jp/


Koichiro Den (18):
  PCI: dwc: Add Renesas to the RAS DES VSEC list
  PCI: dwc: Factor out the PORT_LINK_DEBUG1 link-up check
  PCI: rcar-gen4: Check live link status in link_up()
  dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt for R-Car
    Gen4 SoCs
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

 .../bindings/pci/rcar-gen4-pci-host.yaml      |  13 +-
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     |  10 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |  10 +-
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi     |   5 +-
 .../pci/controller/dwc/pcie-designware-host.c |  38 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  15 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 723 ++++++++++++++++--
 include/linux/pcie-dwc.h                      |   2 +
 9 files changed, 727 insertions(+), 91 deletions(-)


base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
prerequisite-patch-id: 5b4c9da1333342baa90cf6a86dc879e8382d3f65
prerequisite-patch-id: 258bbb5c2aaf676b727308d4e97d52f9c313eec0
-- 
2.54.0

