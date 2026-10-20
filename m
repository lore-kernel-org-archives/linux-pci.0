Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465871;
	b=VTCowxPn1SHNlfZNkf+11bTg4651SaCm3xDm+r2Ii9ySHnV+lOl4RkK/mpI4wJ0fUJET
	 vu5EmnEI/wDNm+wRy3R3FHzp7oXh+np9xxjWixfAYeO8y5T3RlAYkzogsM9dKP+fV5sd1
	 RxxhovDTlYbZu/i7t3ZFI6bSBP/LLm7JrzlogND4O5FCcProlmm5dOR6+ftHunYxxllAf
	 kG7+vW1eEZZkfTQeOYNep+zgKGiI49gh0N1fcitk4O0ItfB+U5bYXM+y31WhR8CR6nfmk
	 IRW/PW2kCWb47i5kChJ+2QylW+xD0SX8+7eAGoUE8oKqCKauLIJVBoEm71NpjHz1swA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465871;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+qRZMoqRvnAhMiyl+WSq0yRpKH31w1TVF0SLWZ1+Pbw=;
	b=a8MsCEVvhFIpXTorOrfRIWttVBr5KPNTVUF8KlK+XjX/ugLUfLw+HwjrlIl2l+pSw2Oq
	 zTOpSOMY6PmtKgInhVlGOK3fNl+PnEblQkPRxOOdSYq80TgPg4r4COrNqj67xJ2trDSSr
	 8j4KvHUI5jn10Uyvs1UZzJ04+NgNoMCpzjzZudghbxnCrNQhYKGprpB0pbH3gfR96LmJ1
	 H5MBAZVtfbhaAaFJgeH6/4CLfc+dKmw7IX6c+ipR2LOsUPbK70o7yBUNyNgIuP7lmsOu9
	 7+aht5156s2azND0lEJvL4uYatR7zKBe9GvCMO8EurMXLSYYJ3rHFli+dWFozRfhl7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=EXEdq5t9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB260A3829;
	Tue, 20 Oct 2026 03:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84FB260A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=EXEdq5t9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MznTlifBklqFMQlKd4xElUhsQV+iLIMs8juIWUpGIRxZ6prCwg/M3u2heuNP5pcguTYSCTWtSNhwhphZ4IbkSZdPSQacK2x1xnO+G8IkBnhlwmw5Y9OhrYS5XEp4KeGpbO0+ih7oQ9yQaK+Lhp9XfuEO6VQSabAbPID3hNJI1/KjVPhybMnZYkiKJgq38g79rTjQ3VTOFawbhwPRvJ+rKTNzmksdWyZplRhQbHBFvEWmmdAYmcxGRWoO9yf9kgW9BYJTZ2BKMjCq6pLxD1SkulaGPZAW0vhrNUg3fvz9BbPyx+rBHIyeZbM2Sw9SJnh+7jc725wMJqofb5AayZdYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qRZMoqRvnAhMiyl+WSq0yRpKH31w1TVF0SLWZ1+Pbw=;
 b=E5t0bgrL9niW/q+xfsq+kknP3gt8dkiAEYHyuTkVOAqM2yetQ9QL/OCqryl+J9TMWQQhlMH4pSLDjKZMw99Taj+aUyaAI/k1sWkcG2ZzPLMPSR9ogIH4O7LWOmXOVnTzpJtraLycc8NcHs8gW/omZy6UoMy1h2JH6VIhcyPpcrJ/NOo3obb3bVNVNdMhb6OPOZ78LlfRqrv5YBVmc4ruJQTADK25nuACQpjMENWuH6B1VKkbcnR9Z7JCKJTaD06u1WbSe4lo304cmnH1uA6kkg5s6SWYPJ8N7h8ukX+Q8yxViOo6KhiYTW9Wbw9uTqzmopzIjOfvZEWmX9jydcHHEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qRZMoqRvnAhMiyl+WSq0yRpKH31w1TVF0SLWZ1+Pbw=;
 b=EXEdq5t9tdaFQOHiw4w1qS8qLwomsgfTNKLh7R9fMhjVI8egS7zHUxnM2zhZM1Vsy37I0oTEZyXm6kouofmH6NmumkiZTHdyu86cmUpvavzfDjnrtVT1kTKj4ARJonj4ALknqkJ75ICzjSBTaqUk8aVGzQ+JXcbbIjgemqwfFOw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:08 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:08 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
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
Subject: [PATCH v5 11/17] PCI: rcar-gen4: Take over the iMSI-RX interrupt
Date: Tue, 20 Oct 2026 12:10:43 +0900
Message-ID: <20261020031049.969895-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0061.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e7ee84-b4b1-4dc0-94bb-08df2e57c944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|6133799003|22082099003|18002099003|5023799004|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1jRUIKIUI7OuT/XCTxDC/lz1xwhrpSBr32VqY80PeDP65RrgLGF5jepwgfhJ2iQMw/x9mSHYKvvK1YDgZ3laB6uU3f1R+q9ZgCXGGEKMKpTrSbzcNoPCaida7wFFjfBhbT7tz2ojUPXX+5j2QNCPAvPS4iPLbmqaMIgzZ3pVfvPLxkoN/s+ahSzTRhAQxKy71l3dcInaS6TgAFrD+AFmVDU/Bsdau8nUMFLo1pFILZ6Wnzj1sCyXHvLCcMbji4bLsSUVNpdJk9IGXt6jFyKfKFhgVPRb22yMniguse3eL+nnXlB5yqzgK3epbcmipvWIxEBeo7AaFBKEZMl4oV4+x5/eqrJojtrYF0OH++npE4XMHVFJfiTpmytrvZc8HxxrE+z4YJ0OGs8YrBHqY0GhQirpE9E/uG1USGZgCT7FQ+uUxyiVQ7ZvEiFDID4lwhjmQGYkJemP5P11vg7iyVG2QL7H36bOKKJyj+i3C+wzddchZLs3NwDDWkoMMQVbPMzIIJftMteVLn4ESLRQM7qa+1SO8QkIT2cx8PLd4ERZeH7/BZmtHESk0L7lNB1LHoEKMG7MSqc37KzYY0Dklo2VTwIJ3hGqZ+pB8RHWJcpGqHNvD/tBFD+QGHF2c5yyLxlRzGyNiCtP4zZm+Q0FMwRQL0B2z/LT9H9EzYj0xCuaIsoGRayffKUkWaSwXoHXq8bvnZKKtTp4jqRNQsA+TekAyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(5023799004)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VodJfFGY6ratLxvTsGGD9ee48Rn2OUaGUvdEk5WhNpM5Z7WiAyxnTI4XwQtx?=
 =?us-ascii?Q?Aitj95hLt99Y/sSqrLx/Coj9gdQ0iHRzQnoULME4zXF1yWpnk4icsqFlBbG7?=
 =?us-ascii?Q?Kixm/aCBte1WIvh3DF7OdXtMHnabm0ducN+8skrJY02nYjCgeErf5d9J7+Yr?=
 =?us-ascii?Q?pZZL5t+bMVQLI4+a7jwD7OfwXw3xYJLioaqpfQE9n0kPoUToD9ebmfPGF8Vv?=
 =?us-ascii?Q?EkOKIXTmpKa3WXyFQuC2y3Ii7lfxZ5k5rhsyNaYLObxARgClLi86ydrxFKqE?=
 =?us-ascii?Q?9aNjpdXuG3PuKoymLFpQq6sY7+2PKRkOMK5K2YfHr9uF5fbeVMWUMdFGHI0X?=
 =?us-ascii?Q?Ku2XbkG0fouxdG7uW2VWLuVxpYIkWInQJ1NnixnnNumiOX6xr4hMLymvYJ27?=
 =?us-ascii?Q?lnlrqi9jV0HZjQaAS0MCf4USuLvu7smAkdht9vm73MT79haAP8JR4lpLFgKa?=
 =?us-ascii?Q?eru23NUdGRKt5TpfsSwW5WRK8NwkSn9zTKAq46hPPBDLAhpQ5GaBI18quE7b?=
 =?us-ascii?Q?vnWbHnKknb/JOAMfaATaCjBjAYxXWt2beUz1p3F+ScCaYhYrMkM3ntFYuQLk?=
 =?us-ascii?Q?sAacB+kuIr7sLeVFjbgtXqWSDzQ9eFpBdweb+hW6GAnlPeNsZ0NdLB0WCGuz?=
 =?us-ascii?Q?9m18D3imvlEbZv9MNE7LMyceC3sg8GMpSJ+nk12fV+onG1QDxh/+RN3OsNnE?=
 =?us-ascii?Q?F+zUQBnJUZzer9VLqKqrinqxRJQjsnZMNvU8QuQQ8BzPfnXgc8w9Oq0Svdhs?=
 =?us-ascii?Q?eLogTQKWqr+XwiQW0DzYLW5FI9vS3vM9/dm2kmIsvxmEaMge4PaTPHKvcFlP?=
 =?us-ascii?Q?O+C5nvuuXq8D8LA0b5kxUub3HsJ3D9hcpAeH+3nTFtUqoE1FwlbtJ4t+jn15?=
 =?us-ascii?Q?muyFPANcCoMimJPxIaH4RYogAS6o+eTM0hE4LT/GbhfGFcJvgDJ8r2B1z4KT?=
 =?us-ascii?Q?1tBqYKZpe6m7m39GYdpcTZVbTjKNow2kZoSjXbsGIYF5X+gD6htThFNPaYGA?=
 =?us-ascii?Q?ityKZ7LOzPFwCb7XH6aXZzJ1RPXN/RkFD53rD9C9PnLKhu+ekt+cmBn5qTKP?=
 =?us-ascii?Q?fDiaCWkKHpaGtcyjnA7m9FyBXIX146UxcheZgXC2DBFIVPKlDrKTNvfj5U5V?=
 =?us-ascii?Q?erBxlDflFTqmuSGvV8xXoCjW2vFaorC3NGOEmyroG9MZox1JFHcSwRckahWL?=
 =?us-ascii?Q?nYqWUNCoUQ/n9m1cfsUzvv7A7/Y93TMHGNbRA6zqFYksJ3mviT1ZlBXiIhV1?=
 =?us-ascii?Q?yVyPj59VuHLLapU/dq3d31bpQGkMmgjzFyssJMWL29EU0H7mCGZsqiUmHBEd?=
 =?us-ascii?Q?+svUzuWPJ0NrQl/pzk//58B+TKqVL+Zlj+8aQVa/Bz+NNgQbyNoWMrCO0ZTJ?=
 =?us-ascii?Q?OpP7cY1qbCbcIkcTOrXi8+GnrATYAQOde+8h/b7y3pWwYr0wDbVFJBGe6CQ8?=
 =?us-ascii?Q?PuWoPzDl6WaWLyyNjJbpmK0XzCpPBCJUPGIzfU5IButMdW13RZ3WIzLQmORn?=
 =?us-ascii?Q?+t4NGUcEjEJfhvsV7dKH5MqVBFRZQ0DdkWRRFdwfR9PbrBQJSAygveIxgk0b?=
 =?us-ascii?Q?PuEQZLHe9tLObNG6ft+5eQZhw0ONH+g5xm4wWRtzn3iim/1n6ev5435HsuPX?=
 =?us-ascii?Q?cMAEcl2rPggL7ad40VHwnR08AL/aEwoE9ASOfAO2ICzs2sc2nRn1qu9qcrS6?=
 =?us-ascii?Q?/us4VbHY8XrY9r1shMkUmKud1L7izviFx0AKDL8vbhS2wSKUiYq7Hc4jsNzJ?=
 =?us-ascii?Q?ELmb/i6NOufaO3PnVT3jMlTCvObunhEtzlljSWd6oF8BtWGiXk2w?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e7ee84-b4b1-4dc0-94bb-08df2e57c944
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:08.4470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5nnmeAv3gL9CHQjZAZnTVBUu+E8MJAHKi7BUzp+szVmvM6kfk3v3Q+EGgsJ60mJvf/KNDCZWB7qOjuFkdyiwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

On R-Car Gen4 SoCs, intreq_pcim_sub ("msi") carries more than the
integrated MSI receiver: the controller's reset requests and the Root
Port's PME and bandwidth notifications are signalled on the same line,
and the following patches need to handle them. With the DesignWare core
owning the line through its chained handler, the driver would have to
hook into that handler when iMSI-RX is used and request the line itself
otherwise.

Instead, request the interrupt in the driver in all configurations and
set pp->msi_irq[0] to -ENODEV so the core does not install its chained
handler, as spear13xx, keembay and dra7xx do. The handler demultiplexes
the MSIs through dw_handle_msi_irq() when the APP block reports
msi_ctrl_int, in hard IRQ context like the chained handler did. With an
external MSI controller or pci=nomsi the iMSI-RX is not set up, so keep
msi_ctrl_int masked, and the handler has nothing to do there yet.

Request the interrupt in probe with IRQF_NO_AUTOEN and enable it at the
end of .init(), before endpoint drivers can use MSIs from their probe.
Disable it in .deinit(), before the controller is powered down, and
around a Root Port reset, as the handler reads the controller registers.
Suspend and resume go through the same two callbacks.

The DT routes downstream INTx to the same line, but the driver has never
supported INTx (no INTx domain, INTx enables never set), so requesting
the line exclusively takes nothing away.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Add Marek's Reviewed-by tag. No code changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 79 ++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 420392ace349..63140b678414 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -115,6 +115,8 @@ struct rcar_gen4_pcie {
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
+	int msi_irq;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -540,13 +542,14 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 
 static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 {
+	struct dw_pcie_rp *pp = &rcar->dw.pp;
 	u32 val;
 
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
-	if (!rcar->reinit_pending && pci_msi_enabled())
+	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
 		val |= MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
 }
@@ -612,6 +615,54 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+/*
+ * intreq_pcim_sub carries the iMSI-RX interrupt along with other controller
+ * notifications, so the driver owns it instead of the DesignWare core (see
+ * pp->msi_irq[0]) and demultiplexes the MSIs itself.
+ */
+static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
+{
+	struct rcar_gen4_pcie *rcar = data;
+	u32 status;
+
+	status = readl(rcar->base + PCIEINTSTS0) &
+		 readl(rcar->base + PCIEINTSTS0EN);
+	if (!(status & MSI_CTRL_INT))
+		return IRQ_NONE;
+
+	dw_handle_msi_irq(&rcar->dw.pp);
+
+	return IRQ_HANDLED;
+}
+
+static int rcar_gen4_pcie_msi_irq_init(struct rcar_gen4_pcie *rcar)
+{
+	struct device *dev = rcar->dw.dev;
+	int irq, ret;
+
+	irq = platform_get_irq_byname(rcar->pdev, "msi");
+	if (irq < 0)
+		return irq;
+
+	/*
+	 * Child IRQ flow handlers require local IRQs to be disabled. Keep this
+	 * handler in hard IRQ context on PREEMPT_RT.
+	 *
+	 * Keep the IRQ registered for the lifetime of the driver. .init()
+	 * enables it once the controller is set up, and .deinit() disables it
+	 * before the controller is powered down.
+	 */
+	ret = devm_request_irq(dev, irq, rcar_gen4_pcie_msi_irq_handler,
+			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, dev_name(dev),
+			       rcar);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request \"msi\" IRQ\n");
+
+	rcar->msi_irq = irq;
+
+	return 0;
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -709,6 +760,9 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
 		rcar->reinit_pending = true;
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	/* The MSI status lives in DBI; keep the handler away during the reset. */
+	disable_irq(rcar->msi_irq);
 }
 
 static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
@@ -718,6 +772,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
 		rcar->reinit_pending = !recovered;
 		rcar_gen4_pcie_app_irq_sync_locked(rcar);
 	}
+
+	enable_irq(rcar->msi_irq);
 }
 
 /*
@@ -795,6 +851,13 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err;
 
+	/*
+	 * Undo IRQF_NO_AUTOEN at probe, or the disable in .deinit() on resume.
+	 * The iMSI-RX interrupts stay disabled until dw_pcie_setup_rc(), so the
+	 * handler cannot run before the MSI domain exists.
+	 */
+	rcar_gen4_pcie_resume_irqs(rcar, true);
+
 	return 0;
 
 err:
@@ -807,6 +870,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
+	/* Stop the handler before asserting reset and disabling the clocks. */
+	rcar_gen4_pcie_quiesce_irqs(rcar);
+
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 	rcar->drvdata->deinit(rcar);
 }
@@ -819,15 +885,26 @@ static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
 static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie_rp *pp = &rcar->dw.pp;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
 		return -ENODEV;
 
 	raw_spin_lock_init(&rcar->app_lock);
 
+	ret = rcar_gen4_pcie_msi_irq_init(rcar);
+	if (ret)
+		return ret;
+
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
 	pp->use_atu_msg = true;
+	/*
+	 * intreq_pcim_sub ("msi") is shared with other controller
+	 * notifications: the driver requests it itself and demultiplexes the
+	 * iMSI-RX MSIs from its own handler.
+	 */
+	pp->msi_irq[0] = -ENODEV;
 	pp->ops = &rcar_gen4_pcie_host_ops;
 
 	return dw_pcie_host_init(pp);
-- 
2.54.0

