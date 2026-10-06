Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B123BAD9C;
	Tue,  6 Oct 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276422; cv=fail; b=aTbGMiVPebSqSUP4t6Wym4oC/eLfd72+EibGcIyDd0Gf5lWNGpzVFdtiN0tdVaHbaH5/yV7sEk/t+wlx6Zf39IZ52fQYV9sBqFnoP+4KEepIFeGKGJXridEdpThwCFvMmd5Wcj56rDFcMb3qF4A/hY/cuJPney70NssSV9rAqig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276422; c=relaxed/simple;
	bh=aofWkJfSCLTRe4b9G3rhxiQG9bx63DKNB1W69rOskfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qy+LDZXQOiHBA1ZpThWwyGel8l//Lt91XIHQFFHU1ytj8Sv0DFRQIkkYrpwx3FXaSxSu8jjiZZAKtMxcmxTGC17Pb3mfJhAHcF4XvnoS2v/j0Fjpr7EJO3em1q5D9ATZTF6i+43onTikjplyOwAvPBrpiqv0m8PT7CwDyBBN07I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MfiMnuku; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MfiMnuku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDVzhF2Pw/BxeG8OvNhwACGdhPiuBgW+DzuJkDYOeArN0He5YuWqVnuDuIjsnx0KN9+pcBra0/fmAwuSHdsYejr7X1TO0N5mRiN/DrWtRVaqfKizDkIWf5xDZvwpdEAFgUmTKXf4jEpskeH/bjBe4pJaxGgXkDVvv32cUI/6sqORsjF+sH/Yo5CiU8SgSEjqjXRA7Jn/D6wKSofhlbWukrv6rUbzlwHWoup5AEnuYfmSnwm1h5AOOE1cevYIXsSB9LO6xHK1yZDcHYUBnYxg8EyFRu3Fpe86eL303KZrWvLYN3nVxy/ngFA/JIYD1Bd4I3VLlZjG912zGGWedYWYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZI5j9TFJPUHC8LJfheZzr66iyUSViqIi8BEAZhKJIk=;
 b=u3VZIuJmHh10I8G6BlfWR6Tk2/fl3+bK2wrb8h5iwvrjFsmLtY/QR5mmXSoo9SYw7h/AUtCgETQrAJ9ZswKDPjZDRh2QBP3j4EOCuP+2xwukcSp5Xt7XRrtByVuXveDcAj8bfM16ZcteNEdKPZwTWytoW8zkQ/XIEgmmI/yuESIyMf6IfJ/MMi9aLqnxdrQeHskxAMjhsjR3foHuY1FoFHMq8e+1a0qgc3TscSkYMw4xWZ+AxTyCanBfXIBDeJrOoszuCqlQuE37YUml0ow3hLlHuwse16GbCjIdD2msAgUpw57ySZkUGDU1UK0NZW4sRhdIxRCQS3KNpZycZpTVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZI5j9TFJPUHC8LJfheZzr66iyUSViqIi8BEAZhKJIk=;
 b=MfiMnukukP1a6ALlzqt2UHCAxz2+KpRp28+j5M0Pno9T2ZqemuYklxg0QcWdUKHDc2fjWvgUAcN0Whe7qt/fiq/qIxM/hCYGLrkEggnxF5GNdBEs3azCKKSquv0/JY2gja9/abe875Q7mMWyHkuNJ6WUd1AhlVLEpuaVp+he2BI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:50 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:50 +0000
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
Subject: [PATCH v3 05/18] PCI: dwc: Export dw_handle_msi_irq()
Date: Tue,  6 Oct 2026 17:46:25 +0900
Message-ID: <20261006084638.3821710-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: b009f12d-25d8-48ab-701c-08df23865cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GatSSjJeUk5K4EsU6OBPV6ThjNv7YXvmKh6XLS9JtDTNF0ySa5OZQJYuAs0/Yuj3uHw2Q6aCALQNJbAeUEli7mewQbIE3CG+W5rQB5Kql+ZAgDYCUNLBvz3QoFN5V2dTHQZ/V84QSpkkRjwKmtRziQPyVN6tbdJ+H/Y7noqLW0rncfGuKUlOc/QnVAgY34wSz+54U3LLNqyZrJ2LHbDgWTWrg8vYR1+O1Pdv+U3O67aNEGoC84+ps2TMYKrVrBkSMUKHvd10CBH2ix35R/xwWN8MGI7ddzzUYvsy5KPzm5facT+5HC7NPr9UqzK+gr2wv+n7toxFp1bVZdhy26M9L4dTqutKvAX+PFUrpjUSjG1h0dch+k97gCK+bwZieWRm2QyuzSt8UR34JLBetDv370hCjHe9Wc48NSAECxV70rPeETXySRJvvGRfcCoeIYjbkMhZ14KWi3Vyre01PD3gXTTrsM2TqNJyXjko39/a1rHZWZwtd24iuhN20NZaLEoiWbs2L2aqfmNoZYU/vNmFcHmSFS+LeNjR472tnkF8MVgnx6ciV+upzeR0u4mkPwpf5QYyyXa4sRxVjUCFbqDYV2jNTl+qsCyDzQBDzwJrr92l9OAbWIrUDCXGSytc4nxnwNIQJIaakYajnAUtayH0Q2XOgBe2kQXRds2vEPu/UQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+U7nvOfn4LoUnyFLe8O30l7RcRrQYqEkzxUPwtau/L+G5T+7L6dSzZ2V1G6c?=
 =?us-ascii?Q?rE5EtHeEy/9t6CTpsKz6WUGl9nfg7VBBoY/Y5gNYroMhMgz5MKxIf6KIZ6Ds?=
 =?us-ascii?Q?kGfPzCmaLoYsSV8vz8ms6AYdzYY9e/xWXkhBhsAi1o07ZQ2LQOka16oiijwd?=
 =?us-ascii?Q?d/t1ExYNxvOeYbUh75ORmacm87DP2ZeGwe/q+N7HUpcKank90s7FjxzmwhrR?=
 =?us-ascii?Q?DkQgPlsnwdzfYROS5WU9Fn/s/7e+NSqf7NBuzECDKVjgw3KxtI+PScf31jYQ?=
 =?us-ascii?Q?0yRrzsmDC6Dz9znsVruJAzoY7tVi5gJXmZKdaylt5b6q2gRADWxxhtzqirJA?=
 =?us-ascii?Q?VgwwkUGhAlMWF7qIri6cphxVzl1EC8XsFFqEUHp/7uk1388mt49wY8nIQzSo?=
 =?us-ascii?Q?KM/vkWjOu2zWXHuESRJxevcDNmB1E6D5zU3SFOJYT0ghcj42QExvWtDLBMfo?=
 =?us-ascii?Q?eM/T27szSlMvs+OQl1B4nkuQz/nuF3OAIoilYjfkK2L8ZmIbt7zELBwLlqri?=
 =?us-ascii?Q?9wchP9Zhx9ecCHOuPF9I2dh1Met4uH7QF8wX46dlqrPQP0LMmBrLBefY5Xmo?=
 =?us-ascii?Q?wejn5IiRhXDkfVw0x0MLElac9Vnbfop+F0lixb2suLGqW1bRCKRWHMb87h2C?=
 =?us-ascii?Q?iLNb1XOyrcQPlXMwnno5y+9ekWQ/8OMcakjsaeSOvzjPm4cCLYGocTYAO6xR?=
 =?us-ascii?Q?w52lodoW0PwfehoGnCPFwCas4WikflkM75bPBq/WoV5d+TQ1+77SSYtEKRDl?=
 =?us-ascii?Q?Hhew1Pmj9col6oSSMDf2qyhAX1Nh1Kacsek9yfRcyPyjq6fktrouFSEBumhI?=
 =?us-ascii?Q?4YyreaetXGvLvtkQapLW1b79JlJAGL5Fh5lxdpHhs2UgOqTWRV5n+9e9Z1w0?=
 =?us-ascii?Q?C+qswXdypI/vmflYMlj647wYV0zBUxzPH5X6xFwJ/pr133Ae6XpSJ7P7q7up?=
 =?us-ascii?Q?M7hQRiiDAKaW6NA7uWswBbSdr/6JEZRhZrmGsQpks1hntaTn7cJZsKBspJO3?=
 =?us-ascii?Q?/kGCeWiNpze2acbbMyH58I/s065T0Wet7rNH5WtwMJ4NFEMa4kAGpXe6tSq0?=
 =?us-ascii?Q?o90GDZEvydRkWqAnDYCQ95JWxFN0TJzbOKwnuE79JPKtMH6VrlicIDsThMNf?=
 =?us-ascii?Q?thBuHc/i72Zj/mukIyCUpdTUesUmAGHmZ4xrWGqI0waQon8NMfa+QPBewM9I?=
 =?us-ascii?Q?Xcz5TfxO26zSYNfDo17td0jP+fNWz3XEs5hxmQj5NsqEZKq7CeE+qwPeWs0z?=
 =?us-ascii?Q?iwCVMU7r2sUUkYMqg4GWTeiMATKD/7CO86+SacJwKKZz9mzXvKy3U+vZjtS7?=
 =?us-ascii?Q?JK5Bd6mi8JmOJRCBJiXsNvJMDxOLFIsddadNdHL+y+gyDgDT88GThpt3FRQu?=
 =?us-ascii?Q?A1J7ZQYCpGMFErf4Rs92cgpkUspGZcR0ndZJEri74MCbk5iP1o4ihdW/9Ya6?=
 =?us-ascii?Q?Z2bQqTYoeXOTa/9kN7E2Xv4LhGOHJ4rhZ/nB5k77AJjMJWLAScIbTuD7pB3H?=
 =?us-ascii?Q?dxz2ohtucWgQtc51SuUIRK1posr83TrQ9OoWjWfOdOWF/JJmQkEJxGVkE3dP?=
 =?us-ascii?Q?B90G5SoOMrIwzsNy2uiifKbdVmRAZBsZEV97zeX6JUmgRLP5X23v+D43Rgwr?=
 =?us-ascii?Q?jxBrGNqhcLIae5aHd1uiLL/s1F+oXwwxnoGfmrWjbnOejEnWt9z4vXMuLEn/?=
 =?us-ascii?Q?PBzwE3NI2antwxyxnDu3OBPHexdsrHIhNP7Ln6c2Af4CH+sjPKE2iKMp3ZWE?=
 =?us-ascii?Q?BapWghr2AwS3Y0JT/fhkTbD0+mpz8DsmxEwl/tNrvKaV2AIFQzvP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b009f12d-25d8-48ab-701c-08df23865cd3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:50.1232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtKrUgfGJCDGcVt/PyQUNFPEnrQBn82Aqyof6YDgdrSG10Yl7ZGhyAgWfRwd9/DzN4umPOXpvUjVcIS1YMwCtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

Not every platform brings the iMSI-RX interrupt out as a dedicated
line. On spear13xx and keembay it is a status bit in the SoC wrapper's
interrupt register that the glue driver has to check and clear, and on
dra7xx it shares the line with other sources the glue driver has to
demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
not install its chained handler, and service the MSIs from a handler of
their own. spear13xx and keembay call dw_handle_msi_irq() for that.
Both are built-in, so the function was never exported. dra7xx can be a
module and has an MSI loop of its own.

Export the function so that modular glue drivers can use it as well.
The pcie-rcar-gen4 driver, where both situations apply, is the first user.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Marek's R-b tag.
  - Refer to the driver by name in the commit message. No code changes.

v2: https://lore.kernel.org/r/20260928165230.3397664-5-den@valinux.co.jp/

 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 77aa79ef0ccf..63b38532d069 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -85,6 +85,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
 	}
 }
+EXPORT_SYMBOL_GPL(dw_handle_msi_irq);
 
 /* Chained MSI interrupt service routine */
 static void dw_chained_msi_isr(struct irq_desc *desc)
-- 
2.51.0

