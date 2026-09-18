Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020136.outbound.protection.outlook.com [52.101.229.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3F25B30D;
	Fri, 18 Sep 2026 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701649; cv=fail; b=U0G3ZUPhkVckEeaksVJ1KYCJk3/nK0dNAeH46wBpjQPk6iT6R8KkafwzwbW4Bv3C0I2PdB5wC1rgI8afKzsjWZyS8ZZk505O8v9nv77ousMg38mSBBxaWMEircF96WS2YE5f8DW1gF7MGV5P14SgQw2+zyPCjyS1T+5GKJeyHFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701649; c=relaxed/simple;
	bh=18N8H1ZLk4NthfmgRoaRFV9woPTlwXSrmqa8yWIbppw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JSC0atokaBEDZW8qBmx3iULDoR2WPblDP5717fyUgKZy/MZFwR6LmwzZPx0XKdL/UfyBFIu5oUHA16W5qlGzeZpG98P0cISnDJErKJAIynZDGiaI10QGEXjI5StapVSiZCqVTIR0jom5rnuG8hzUCtTQWECxdSxd/NjPLJrI3D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eroEWVcZ; arc=fail smtp.client-ip=52.101.229.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="eroEWVcZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+b8JjAsKBNu4YOcI6qv27ntNYsV5fHvrpQpeB1k+TjKezcv81CRS16xoTwfuMGUhrC6g/fR4eO1EUSi5fg9DLVE21WL17W23XIXWVQ5TNDM+5NNTo6a33bpdhJL/3u3le26jHvh3m1G/ExQg/7ZhqJJlZFo54w9mRRNpB1DNEuo4hc71DTinT6bpuKf6YTDnv4xG3NVTZBYunPzXgyL83NoiISbu+PO6+idg+diAgv1PUJwW37LajhIn8meRA0NtpCDQ/p5IbVibtkiZBbz33SHkURssy+v9kppkgh6FVPNpGYJzluR75ZJvYeBQWVCQkgL8S+7Wzbhkk9Y6i8bKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3zZna8mXuuuuSiXin0HkLTQxbGYha0wIswqaQrUzhw=;
 b=XdzNSnFe1Olf4I52hdNmrhvtnGTuYsU1lpxaaP/roHtuo2fcABJk7LgJY4I1ADNg9qYYM254Rs+fDcu8Mog91fF42lmWHLRTZosY2wdChWS7pqssjkwACBnH5f3+eE8roKBG+9KmI8nAy34R+ckrntnxljZa3U6fBvtfNgsjBuwuLoJiFU8oVAn1SP9G9TIGdVrOZnY2dtr3QJ53yfxmFoQxLN8nPODW+kY7PoTgCgc7scwjjOPzjdQoCAe28Lgyljt6utZSivGukdeYaKkiBllcqc9gXucxMS38G7jIS0GMW++NZL0nVmCX0vYEzm7tnkT1iEMzj4EThcaXok97dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3zZna8mXuuuuSiXin0HkLTQxbGYha0wIswqaQrUzhw=;
 b=eroEWVcZYejL8lnvriMKA4W1lcO7wUcaJtKuVRamA3Ijb4MiU4HKk7ohQo8cwWCCtD8auEOHrOlcvDxkPyA18FP2KtPsciatLpBI8AUWdfwhNDU0i9kBz4lx+cKKRKkcIfwmF6/6bs8SIgqdn/cGO5Z3588dCW0CJ+/ky6LDTsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:43 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:43 +0000
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
Subject: [PATCH 00/11] PCI: rcar-gen4: Recover from link down and route Root Port interrupts
Date: Fri, 18 Sep 2026 12:20:27 +0900
Message-ID: <20260918032038.2216471-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:405:379::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b74d1a-ce06-4ec8-b4d6-08df1533d2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|6133799003|5023799004|10067099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	K24GmCyOSLfaj1CRBSjeJ39uHjB6umTswsA++mrvBXssRZYuX31mIqX54h1TTnjTM9Q+tbVGtDNAe57DaW47orylqZpRIVjcUqBqZZmttVIdXfj4OrGipnw+ZJwdq8jlt0IE+c/ukh4F/TBFqb0TP6aOtUs0VAydKfIfTCFwakxdEwW8NuUR8AD+iWwzo98cwqis6FfaRz41JzMfmbBxr4piFWGSb/Mdaz2W3YYexE+seslSZ+1L0toSaJe7MouTwzRJe+QysWR7X+LGDyPVgIl7fl7sp2bXLAKm+fQ+NY21nC/FhaoKSIeKRMScE7QDXTySfFcf1/QPh6+icvYK5poKWPUWfaMq/FgTEQX61vVWjZrAYuadeTz7ZUSyN/RLvohCSw8dM/ayiwWIbpe8JSjVAojogXJ9b1GlQkbDLE6eL6RtoIkJQ0IRWG+oSYZXshOzTIqwdMzEZV8qKawKcCHTse0biwPXTkPEzqaeWXFNTFog3nnLW39nYSTeHaKdyggPMLWTO/46OqOmXcZ+wv/5GEf+etRW5D2+Y41qleaE6uJNasg5kViJbHzEnlE5JWuX13R7QpKuz4o/6mqrEDUpn6ljWnu2KEZ9oHkcOxLQrpEeLCh9tdQq51CFZA6e8bWJ05h/jiaSY45tAExDxKcQnJixvWsAAwxWgA5AqzysBxTeKY9Dq2sa+z9aofDe0V7eCqzPG7n3Hk+f+nPVuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(5023799004)(10067099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+tLaQu/Nez+DykP0UvGXpFYQSF7+yIqAFKqT12rqU1gPauXLCs1R7EHin5k0?=
 =?us-ascii?Q?Mg9OKfz+B/yeX4Q77K/qiVPgId4gWEiAkn0p/zLWWn6vb8FwG2UDg9xBvE0i?=
 =?us-ascii?Q?V9dOU1UWQtHNKRoP2U2y0fB5V8fxmu8T+IiqWOzmmIlF88JYPinYHIZMr5q6?=
 =?us-ascii?Q?exVvGS7QKzT+CLj76jZmX5K3/BlNrNrkqopng8N39daimrDnI7lWinl7ha0w?=
 =?us-ascii?Q?abqzGSexEu/n1FVR3iElFduTHQCMKnJYlLIDcG2294sxCDWqPxIqFZHw+mGo?=
 =?us-ascii?Q?XG4+Y3zNWj93p6b8+LtSDDh0t26NP8pvv9+8nNo9qnGiui0M82hRh0dbsgqo?=
 =?us-ascii?Q?IVFDGIpOb99PC0f8okXnrsqdSuLvn72mvEA2zUlWwyQpTsC6JU9cuiskCTvR?=
 =?us-ascii?Q?r9xm3psATvIrMTOacy1xlnsbrYEz7bStcUfKQHVDg1Xu+PXpheZ+EcPvYZSI?=
 =?us-ascii?Q?Bhz9a4GvnGCSumiN2XR+QJHLx8XN/yPUnRN4vNp960pwva31rkE5Xzz0p8ZP?=
 =?us-ascii?Q?uIXM4jmaWLgeLoV9oXy9iuKd3tVXDnuKR8pW77OjVT0ErxSZwLhlIUeMEy1J?=
 =?us-ascii?Q?rV7M/mX+jxcuqB5mqCZ63upegrZC+LNDRLg3g7KimCZwdcHU6nMyR2yZZ2x3?=
 =?us-ascii?Q?4iPcnfS+gq8n85Rvv7T0ynrv/LTE4eA03xDUiGyFeod81loxjsLB0+J4cYHx?=
 =?us-ascii?Q?qOjxwbNZWHNn9lHryt4aYLumplMcDlT0VtwOOZ9QUjqWMTPurD09ODowQ0il?=
 =?us-ascii?Q?J2V2k/jZOB0pDV/lQY+sG/psLuD9q4LnOru1tUxqYadQnN/1P1clziEM40cs?=
 =?us-ascii?Q?pYOb2xbxRInDwDgU66DpaDFGxqP/rkfsqF3mmKMVSC0zSS8mErbgggSJ2WGB?=
 =?us-ascii?Q?4JfKypiWIm2X5Bc8x8etVkss3Rt14njSN4UfAukGo5dPUiQEdIC5HA/IfJ4h?=
 =?us-ascii?Q?FSMIkwGouew9sONwtqxZt5tF5hDKlX2znges36ZOhqpwuY9Bn1iIf07mESOw?=
 =?us-ascii?Q?yC22XgdqdDXA3KUt0RSl4+oddvigWaBnUl5OjrlBOW/4tduCDkBpFO7hQrki?=
 =?us-ascii?Q?odnzfe+qpvTEnsiWgR+5UxUbm0eV2bzYUsZzYxheYiJACGaHB/bLh6F0cw/9?=
 =?us-ascii?Q?EOooCCGfKI7UjyzFtFyWHu/dibFoAY3YSYQjhbdSQNE//DTsru+iycDCXfcI?=
 =?us-ascii?Q?BYYM5pw3OAET28bLaM6rZUHi+fieSEPaS+Ei5Yr0SIMD8AkxQf3QRXodts4P?=
 =?us-ascii?Q?PHJaFzviexFEHxairrkBHw2ONjZ1x7oh7WKUVSIV1ZwMDuQkdU0LZDrlco/V?=
 =?us-ascii?Q?Ibpx0jffpqxxMypGXRsfCVB7F5WNb8YTyMFkxOzAlSxzkgtle+5sHfq8l5yo?=
 =?us-ascii?Q?Y0ZLMmNNfdZ96fFVH3yOrUkSXZ3ZUP6sS1vFCm6OlmIaqts1g7M0TLy3RH1r?=
 =?us-ascii?Q?IxAZUq+uGlypbhdxjMSg90qqX9zI0GPwZD2v22dGBNMjREBtzot1VxtgzSpc?=
 =?us-ascii?Q?lTfGurVYzeBqgVekkztSxCEZm0N+0AW/wg1ifB0jm78Y11V3VVLTmLRtgtNo?=
 =?us-ascii?Q?L27Ve2cvB8r7ruhDEYdAyfCYVYB9vu6s7ZilzKwCwC+RNVQofq7FEbTpjhsJ?=
 =?us-ascii?Q?c5Is8GS45jLX9AMm1RNP9S6x6BzyQgdwcPY89AdRyor2SY1yZ4snK6pIWOKa?=
 =?us-ascii?Q?DwG1AcEWT+Q/+C5rIR1cb33moMA4f7Frkb1xucvOBFS9RCqO+xFzRhwl0woH?=
 =?us-ascii?Q?6PyZax3zqViy6F6+9wI931ROQPG2tQ7DbK2IKFikFmzb0evAccMZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b74d1a-ce06-4ec8-b4d6-08df1533d2d1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:43.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wi1/f167UrhgLFhxTDWXoukXBS0ykCF+Iexw7oTADjlcE2ElSwWSb3eFdBbduUU7AWaY41u0y4hVdVFDojN3DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

Hi,

This series improves error handling on the R-Car Gen4 PCIe host
controller (tested on R-Car S4 Spider, r8a779f0). It fixes unexpected
link-down handling so the host doesn't hang, and wires up missing Root
Port interrupts (AER, PME, bandwidth notifications) so port services
actually work.

A few hardware quirks made this tricky:

1. PCIEINTSTS0 link-up bits don't track the actual link state. The
   driver never noticed when the link dropped and kept trying config
   accesses on the dead link. Patch 2 drops this broken callback in
   favor of the DWC core check.

2. On link down, the controller's reset request shares the
   intreq_pcim_sub line with the integrated MSI receiver. Accessing DBI
   right after link down hangs the bus. Recovery has to hook into the
   chained MSI handler before DBI is touched and reset the controller
   via reset_root_port(). This works both with iMSI-RX and external MSI
   controllers (GIC ITS).

3. Root Port interrupts only trigger APP status bits on platform IRQs.
   The controller appears to lack SII2MSI, so Root Port MSIs never reach
   the GIC ITS. With iMSI-RX, INTx gets routed to the chained MSI
   handler where port services can't request it. This series works
   around it by hiding Root Port MSI caps across the board and emulating
   INTx using a virtual IRQ domain, fed by the "aer" IRQ and
   intreq_pcim_sub.

Patch 1 is only loosely related: it adds Renesas to the RAS DES VSEC
list so the DWC debugfs error injection works on R-Car. I used it to
test the Root Port AER path (see below) and included it here for that
reason. Happy to send it separately if preferred.

Based on next-20260915. The driver patches build on f0a5c6bd797c ("PCI:
rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes") in pci/next, and
the DTS patch is for renesas-devel, which already has b43aa6a6ebe8
("arm64: dts: renesas: r8a779f0: Add GICv3 ITS and update PCIe nodes");
configurations b and c below use that DT.

Note: backward compatibility with older DTs is kept. Without the "aer"
      interrupt, only Root Port AER remains unavailable. See the Testing
      section below.

Testing
-------

Setup: R-Car S4 Spider (RC) linked to another S4 Spider running the
       pci-epf-test endpoint. pci_endpoint_test is bound on the RC side.

  1. Link down / recovery. On the EP side, toggle the endpoint controller
     off and on. The short pause keeps the endpoint away long enough for
     the RC to notice, but brings it back within the reset window so
     recovery can succeed. Adpoted the test approach from [1]:

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


Koichiro Den (11):
  PCI: dwc: Add Renesas to the RAS DES VSEC list
  PCI: rcar-gen4: Drop the APP-based link_up check
  dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt
  PCI: dwc: Add a host op to run before iMSI-RX status is read
  PCI: rcar-gen4: Split reusable hardware initialization
  PCI: rcar-gen4: Add Root Port reset support
  PCI: rcar-gen4: Recover the Root Port on link down
  PCI: dwc: Let glue drivers hide the Root Port MSI capabilities
  PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
  PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
  arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts

 .../bindings/pci/rcar-gen4-pci-host.yaml      |  10 +-
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     |  10 +-
 drivers/pci/controller/dwc/Kconfig            |   1 +
 .../pci/controller/dwc/pcie-designware-host.c |   9 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   8 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 673 ++++++++++++++++--
 include/linux/pcie-dwc.h                      |   2 +
 7 files changed, 652 insertions(+), 61 deletions(-)

base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
-- 
2.51.0

