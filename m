Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020139.outbound.protection.outlook.com [52.101.229.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2C3BFAFB;
	Tue,  6 Oct 2026 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276422; cv=fail; b=aDrxDcXFENDLHsMFbw1rKWoo5s9htnNJpP13FTXGPw7Y32WtDDZWLAIetMHaN+XqzME1B9coyD6uBxTu7tqpmytYZBB32HTqP5ih8TNx/3pxLFOdiOI1bfOsUcb6dUHQmaGVDUfyRM1ksj3ZVYTFhNxMIwZ0yXpQqrq1SnwHvfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276422; c=relaxed/simple;
	bh=EEf6FiAGgFYCfRbxZpSmHqsIvFiKj3m/0953RU3yEW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8u182hyHxLrpUVsB6qVhxkJjc1ilxr+F5jITVW8SQNdlLSdoA5QGMohVO3ri2OQa4ZFg/HfDtUe1+wbOQQfrt3YZwIRW7RZFeirL3PIDQNlnJgmpVx41WyjwxO4h7Z6aMOs8Rit+FBOSFF2NeQ95AHHXwffuoFUX8s1hKeitpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LU5WC8zL; arc=fail smtp.client-ip=52.101.229.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LU5WC8zL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpJmxREyNkqaaRlkwffotGhg+nW2OEEZ262IqutrJy/rJ86HDUEVzA0v7WJ7i2F5ouIChCHY07RITf2MBnf4dRiFhpVI3Maxy2XJAoJWKHaMzsqu4mKh+KD1xxnjPqOSUoWCnlj3YJjv7YokMlQc9VvLJqdAuVIfgR9ogVbNkyF8hwk176wuaVLeAgGdpUz0tJuB+pzh+kR1dTWuJRkjWrqLr0JnF7BwGnYnTnsQ0gUfJcNN/LduQw9/vNedIGk3FKDHYUF8MDOyJEDJhtJ7G4UY5jSapzNGML2Wd6Bdk3C9hjHp9n8g9Y3CQpih/V8nYxIH4NGxrP6l5vLYlxqiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubwewdrfSId3AfceTckMB5ErCvB/6BhbAs5PHwVEQVM=;
 b=v5VY602Y7ToydoAHJ80s8v0+5w+YvLI1r8n9n4BZ0S9lQpF/rNcwpGBsBVzL/QCU3Ut/f7gZ/vjjVMJsWkGnT7kuSlYG13M+Web5M5KqRldr59MCJAC6361l0OjYpP+HMLOEZW0lnmqjFtNQcbLPWJzzy2SCGKT3qq6MfT6xLaZNRmKMwnpa7ixaUzK5ldFrMyilrCmUuVDduYoT57lrGkseTMAQSnp5OVfX8QLVUWzuYcbxvfaa3ubJJmxi0i3tX4qq2m3wWjCzdJXYGS33JC7bIl3DvRftXmBNVbQoU3nJOnmPYocHDnPB0a0ErBRsavEBTJ3yp9GDHhuoXYzSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubwewdrfSId3AfceTckMB5ErCvB/6BhbAs5PHwVEQVM=;
 b=LU5WC8zL0nbrIPrspGU8om1KiXpmvaHJxiB6ev+CL7+b22xuZsBWESsUSEAaY2W5bzVt+ORDGZGWf2x86+O3DbFUcUXBxvEx+fZ7DcX0ySY4DntsFRQNAo/Yt9jNgQ5rFFldz0ofTcpKdtM1BvMU3PrmDhC3/7AfOzXm2hdQldg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:49 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:49 +0000
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
Subject: [PATCH v3 04/18] dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt
Date: Tue,  6 Oct 2026 17:46:24 +0900
Message-ID: <20261006084638.3821710-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: bb124c0a-3f43-429e-2e88-08df23865c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cunI/Fxj/gYL4UQHEZSVy/gg2KacrWq/0MCX23GpsoV9nLyvpEYGEK0KXfhNOA4XI9Mydf71e7OVks2vRzItqg/ntytVncdyUxEJQIfgPgw8whHpWBqanzdL9VIZhwOVFLxJCwn32rqMuLCel+1K8g1e9YiOdNFIsXq7CyUEUjMD/EG6JrS+gYss/qRCXQRFJZtPKXQkjVPrEYT9Hwnp3GwENOPUeagUDb2D4MYc2TwDXIkJJ6RFjanQwNGxsc/LbX+/PSGaW4gS/EA1Uwi8ebm53L2++//6Gd7h/oIxM46j76MJDKUmYqgRRfdTAtpL9UXF0dEv/XzW5f1RSfNSb0oHqNZ/LaEZxijSoNRxw9wrrY5Pw5Qv0m+79Yxn7kovLzwJuagenLFVYscJYs4y5XLgL8NH/BERTJiDDV7AtZrYcEiNDn4epYNoxZdkZoc/2A8yzbk+KVAiXxNhnb0bbFSHG1wrlMj0mYYFcTPdPRGNoRLm3NikAXa0tdYf+KOLa3vzOY/+KE6NZgIlrdLi8V6WCz4oVPwFwr/lnovJERcj/qfQdUGxdz5oK9sOBs/wWKAD7oCH4CWoI5TGnfE0o/kY4OPcBi7iD9L/yJcQEPfN2RtVozjM1Xi2/WMwwgCNS4gnZuV7UDUNXhF3Sbfw/Bb/LJy3z71wUuByHnWfoeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bnW/RP1+KqXB6TIIsik4p5HyQGxoUW2N2+29GG01vB7SsOtbGMw/USNxqbpY?=
 =?us-ascii?Q?fD+n/jFDYRJM2TX9wsCD0/qF7bZi26PtyjavvhYGwxVOTeRUIpDXx+K4Q5B8?=
 =?us-ascii?Q?eLGqALfiGkV7hU/SqW4gs75YAS8aju/CxrJATxXMKPWCG57tfkZwfytEOpyM?=
 =?us-ascii?Q?BkRkPK3EpIv7sz8lCzQZPv4BUyuDVVq25TvoWwWRTGPSPbh9uMtAIByL0kDJ?=
 =?us-ascii?Q?JlLXGBLkCkYJYyolyWsdaGEu0pu1XMntbINHiUondcNCU3P3fRskKNzSfE+Q?=
 =?us-ascii?Q?qxEUkvk3J5EKjEnDlNC1jG2hHG84AzuOlrrMj+HGNcQi6MX1Q4PiPntGSa4Q?=
 =?us-ascii?Q?qW08gGS6MjUyRuTVSn4zKYdekeSgAhcNuQqakTkXejX0KYwRtvSydIIIlPTq?=
 =?us-ascii?Q?tS3+nyxxY6tNOBA4oR9Y/eG40KdtzzpIuliSnqPll2iyTdYD/9l+63DShqY7?=
 =?us-ascii?Q?auVh9rctTMB0yWhBtRA7gIAkfyLA4le8m7d5QmeAILwSz1bALz4jXXviaAPy?=
 =?us-ascii?Q?ekjsKEWStU6ScwgSjj5nBirM9v+o0uXcj/3tCmZejeu3RgC7sTUGncmhuCdw?=
 =?us-ascii?Q?DaZ/U8rOeVDAcKUpMMnFTEIo/LNLhfArMtFgZ7da38+weTxnEurKW6W1t7bK?=
 =?us-ascii?Q?hoxC9uns3mB3W8N6kU8yZDpgYCKpzUqpBYAwJLsCg4aKr5NNx4T+ZEMd0RIb?=
 =?us-ascii?Q?g9uQy4tzOv99IVz2UnVP0P14wd9I8a3Df24A4BvbaxWad/AX+XAxGBN55nb4?=
 =?us-ascii?Q?KAyZ2IX3peLB/pkNuulT0/zN+POXgB7pZEsr0aKIuI2+Pe82Or7E77Qm43tV?=
 =?us-ascii?Q?A8ArnxNLAB0hBQL30xsoGz0iC/xIYUFI3MVjxmKltbsSCyzMeOYyPCB/fpWT?=
 =?us-ascii?Q?F6fGUF9XMgKOj+A1Z8e4LYyeRVDsGTFhBj2tfaEbfwqrQh2ToDXlyX3+sk0s?=
 =?us-ascii?Q?QZ//hFFJn+s0BziVKJ4gsHZonF7oUJJAGj4PX9vo7IoKCByFLSoGyP1b6rJ8?=
 =?us-ascii?Q?yxJ59XMnJTZMt+WbIRw0P41anWlNx1N7ZAc6JAF1H42FfBWaQ54phbvlM6Rl?=
 =?us-ascii?Q?79w46g5sQKfUsrIigfqGob1Z586YhbGDQBpEtarou4ePDkbnwUsWKs5e9miV?=
 =?us-ascii?Q?2ZQIRk3ZD9ykRB5yC7/Xg2v3rcLajPxOU5REdBUoT3x+f24ecfoVy/16DByV?=
 =?us-ascii?Q?NfIKS3qk9K15QNhV4QpNziUIfeI58canOzn9cQGoV460M7kAKP+HTnsuNtQf?=
 =?us-ascii?Q?hwlHrj1BTK5UlVb/8yVcM/dhA0GlA6hN7kZt5EACuVT00KqPBOfCjV5zxW7w?=
 =?us-ascii?Q?3rr1KzurxtdfT6sU074oG1eVzbhf4ci4W+RXV0U9Gjlf5s3OK9xBc51KnaM1?=
 =?us-ascii?Q?Q/ZDhf4SCfIJrJ82Yxz3UzjsoeV31ft8NxXymOeUTg69z8FYFmjQISOWguie?=
 =?us-ascii?Q?cRq2GGB1OuD8/DSKwnCOAidWPjdx0E8U+HpH+Fd29mY4xvWtK+/20gnTmqIs?=
 =?us-ascii?Q?Ecr8+dfSsDJ3SLBaL+uik5jn7gyMA+W5jXzp/bWQ03Wh36LlRUeQ1EiilDwq?=
 =?us-ascii?Q?dxdtuPADC1+mHuLiq+aKAnFnORwwweCWFZpCd5ZrKM6St7hGlm5MWBstBMkb?=
 =?us-ascii?Q?wq95087k5O6rnjfSetEWsApNVyAeD+EKLWHBLkRmRzvQX2qiw5lwB7gG/IZ2?=
 =?us-ascii?Q?je1TxkB/JiJzdY6N4dXiyUI9GA3d98LzJeyA0UQUq1R9D4hsHeQ3nULZXw1q?=
 =?us-ascii?Q?atUaQ2/Xi5QnSAsZiQlhX93RrH+qqzqL55LMBrXBwY22F8x976Xf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bb124c0a-3f43-429e-2e88-08df23865c43
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:49.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AOmHBDkWrR+aOoptTk3oBQTnlfO+aMWP7LEyJ4sybLU78FtulU0dWdjxuL1tgUEQ3v91DuDPgTKdDbauNvtPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

The intreq_pcim_lperr interrupt carries Root Port AER notifications,
separately from the integrated MSI receiver interrupt. Describe it with
the "aer" name so the controller driver can use it for Root Port error
reporting.

Keep the fifth interrupt optional so existing device trees remain
valid. Extend the example accordingly.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Krzysztof's R-b tag. No code changes.

v2: https://lore.kernel.org/r/20260928165230.3397664-4-den@valinux.co.jp/

 .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 362c43a1a15d..b24d0fdb12cb 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -26,14 +26,17 @@ properties:
           - const: renesas,rcar-gen5-pcie4 # R-Car Gen5 PCIe4
 
   interrupts:
-    maxItems: 4
+    minItems: 4
+    maxItems: 5
 
   interrupt-names:
+    minItems: 4
     items:
       - const: msi
       - const: dma
       - const: sft_ce
       - const: app
+      - const: aer
 
   clocks:
     maxItems: 2
@@ -139,8 +142,9 @@ examples:
             interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "msi", "dma", "sft_ce", "app";
+                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
             clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
             clock-names = "core", "ref";
             power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-- 
2.51.0

