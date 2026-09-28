Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021136.outbound.protection.outlook.com [40.107.74.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054704F390B;
	Mon, 28 Sep 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614393; cv=fail; b=FVcA6CJd/RJEel35G3NoFdB0tefaJCTuNRejQeCeDz8/1/cKC+nQYb73ej+CgkdtucjyEzTQe9olbu5ZAmDcd36lRceSvDug44d43TUY94wvPgcPSnTDwwxNYLK3BxLfbzhRyoYS8VrQ4VoM/IM+ndAEsIIGJqhfUPwMk4qGaQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614393; c=relaxed/simple;
	bh=r6sFGSRS+re4gXPQy9uMl5zRT1Cb6vnd/mck5Ey4dLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rtuw5atJLktcNHtr5v6PcvvD8p0q/7LoiKTf59Ws+Chepomz20DcgT2XrgRI8JxEYJfTlRSVMVWZc0aTyqF1Ped72hmVOuyikw2psNiDLEgR51bmGWH9t1omMWRYLfNfH10d0bf097rMmf8guk2RMbQZdRh5MRkyxmmq/vb3Z98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Zr8MmgZ4; arc=fail smtp.client-ip=40.107.74.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Zr8MmgZ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyyyFiUkiwki0aAKQf0F/er8gnBntazoyBqHjqvJrA4wgqNWw6AZS9GzxoVpYuhJYfvTJW2zD6U6AFo0iPxsd/9Id8TOTC6s0HKf+7qW4+LLzSEP1G7faAYKXanL0E8e4COQBccjttO3Y71+AVoyvjDLR4jEUKZirh4UPGU6Xzb1t3TMdgApA7KUdbf2URmeNO79SMo6+MUsz08XDfngGFI16UqH3KkDlnnUy+qEoeJ8UHlKCwljJiQguy+4GD+JveNQ4zTMCnUAHSEhycY8rQ72g+8xGSFUPFNQ2iQBzKkQ7gtYhaXKve07qnyVwWQ01ZrdTUDEM3/lr1NEW3aapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vxxxEFgM6XCNA2fRGkNENK1PZF0Iv/RNX5mBwcZrhA=;
 b=QSklpjF0wxtikWCBtMSu++VZLYV+DLFErh4uzPk8ZnaO7WrQ8dFe0YamAJ9pHPIOZfldya/k+aVWY5XBRwlw5j/zjlOR3TOfV4On4q+lL/x79hxTCehVy0+0+s1RzJCYncR7+UFgjNlQKJbCSWH2JzLWS8M/rBEY7zEGe4mVWDJ8bvTMCj7L1QSagK3kYkpB++BuKIR5/1Qj2lrzs6OLMqW1Rcd5hIsEMY9FduzPqA0fxfHPtkouxEIH2GviXRNeHOZdNInbjdyn8xi5jN1PcitpUTQcJtGZShXtevlWCpsbCUyG5nJn8IZ+Dm5TSkeYADvaX6VcUAtG4O3Xj7MbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vxxxEFgM6XCNA2fRGkNENK1PZF0Iv/RNX5mBwcZrhA=;
 b=Zr8MmgZ4w+rXzI1HtWCB7NRNlmDf6ZP+eC4sZ89gal0Wso695PSavMYmMizy/wT44JoqmB3keLFcRk2QJJMKs/cBEwpuHSCc++0R+DjfnZme/28BQdopV17SItvcSwZWvd89v4qr4gHFN3haKLCV+rtMaKiNYj6ubm9grCwV2Uw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:05 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:05 +0000
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
Subject: [PATCH v2 06/15] PCI: rcar-gen4: Assert resets when Gen5 PHY initialization fails
Date: Tue, 29 Sep 2026 01:52:21 +0900
Message-ID: <20260928165230.3397664-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 6828ba33-9827-4f67-84b3-08df1d80f746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|5023799004|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p8lAwERFfE4gsRSXhmoJ7PloUE2AwGc8msd5jcAjthvN6LcQIQN0K7vDW8Y8h7+qlhzPfuMeYGop3thcuTfvPngTJDmbu4DfSMV7evfkbkIh35KFn5Mq3twO+fLwaII/g1eStt9PFrqK+rd31XAhgY485rlSJUQ6sIx1tQCWSym+7y+rZgudYvScjkIWC3IeoIlNZ27DtSRH2jE+iEW0PUbNDoqSDwyEPS/IMtJyYaTc8aMK9w2bU4+X5SeRZuuhitHmGXr5lQpQpu/SxBIVIs6E46XBN7Y6ZiAknBvv/qP3cixQjP0+t1QuuoCfB3q1UJ4vXJZHyZTXfpqX6NKzdZPbg1K0Z7wYLYI6Aju+XWX9NrVptpWTkY8CMY4wShTsyaqiGuJk9xykVYCnLTlloLTFjGq44RM4wUNyrIiUimhlbMW34Zr+dxBOVQeqKVbvGM/GkV1UnDGn51QnAJ7EeMM1jdgx5KBHYYdifHb10GC1jRy5eCHxMCUZHpeVvCLI7NreIywCcYf6zz3WaE0jBxaymdFPNrgzAvJx4dCAU+fmLpSjjRHZFJHnTILSJtU0J8NjsJK9+KB7EQz2wnDN1HfXvvPsTCqVKAgk6jxm/7iBaYGaSD3/Fku+VSjmIN/EKDGQVJt/z3FbjvEW5HhQ4JVUKbbPK9FPAyBc7bKLDRz1FnSg0aGBLy2blR5MICB0gMm7r49bTNGnk+e93viKCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(5023799004)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ugSqJbd/RGs5tsucs0zhT3HSxTqPr7/4rorpim/z5NhTpwzHrXU0fmdVPz7H?=
 =?us-ascii?Q?lGnd8UwjT6TebxLnTjFZE2QO1mDjXYCcIMcW+sV4upysNJ3KaRRfJjeL0Js+?=
 =?us-ascii?Q?cwIFbjAXzhAG2VtW9lWic4HpNRm1diB3kMNYkMfichbNoE7Hh5QbmE3BEUOA?=
 =?us-ascii?Q?USYKeIHkLWRFNIweadhAym8oZt2I8F6BAWnNIECwqIhmcInW9k9oJwEe9Ey4?=
 =?us-ascii?Q?xe4d2q4VtZuxtlFpQJK+UtwqYF2e0/F09kcXyGc3TD53IbUa6v2Q+/G7BNFd?=
 =?us-ascii?Q?mRBtvoQHjTa0oGvHJTRLujIG7QAJXyOl7ixM62PauTNxJUya6j47MYKgoN1x?=
 =?us-ascii?Q?XYVQ8Scbn6D0eWcGlVtRhNHgLaMzOIsZ04kANu0bWkEbbyJk5tP0A35H2pvI?=
 =?us-ascii?Q?9pWFNn9WlAkdB0dwnc6GonUhDoIVFV4lyvbabjauaspstZWe9ytwHXt2ga+I?=
 =?us-ascii?Q?F+vEJqyc1MYC4KitXqag2kaWSd5qx5hnOD8x2KSBkZiQvUH+Qumy1vckc+wA?=
 =?us-ascii?Q?pW5ar7NwRvGBjIgofoWQFQaJBIYrK1Evu2Q7000HK4tmHQSA1fsEzUD1rCQp?=
 =?us-ascii?Q?PPucvTfo3cspYDvh8oNlK3roqxNzsPrIgPTox4bBx4C9QxQVWPTdMMUNBM6I?=
 =?us-ascii?Q?a6EZBj6t+KfQdxJI/1Upcqilzf7MzmEVaevY7eZonyZQdFnZsT4kkQQBR80C?=
 =?us-ascii?Q?VxuLpIonQm18FLRlNFf1UondjDqVwcl+TSZDZRr9zdSrl+S47IJY0AKRS1w5?=
 =?us-ascii?Q?Y9WNFt1bbyxIaofmIs8Cu6ySZaUgsVypob381hI5+C5GITsLPwjfmzeKHH0v?=
 =?us-ascii?Q?cSlGe86sBvA1xIKwR6Hwz44lAHbYVKzzTX41LoVguOyivNhy2lnXNvSD+TH0?=
 =?us-ascii?Q?ytSkVUpMZaFK9i0UUCmXR48xorT1MRJbgRUuFcnIIwsEve1kyh/ranyPIUMu?=
 =?us-ascii?Q?FkStYo6yBFxPybJafsKShMUhlY4BC/rcoJ14Bkv5lMpK7K04W6ORhDXfPHxd?=
 =?us-ascii?Q?cowLpCl1u8c3sIpEbDp2TxKyAA7M/mLQs/0OCPVb+RnOi7tUIqLpCZD6FdRJ?=
 =?us-ascii?Q?A8baBkAsxvmpPD/S9K+JYCARsvwMeh5y3QuCx3WClf7fOqGmcgFKTnOGR3j1?=
 =?us-ascii?Q?ZbpAiPVzam/9T6QvEINcWg0KVSg5U3oxY4X/J+1NQHtTBS8azDrM47FrUfKc?=
 =?us-ascii?Q?IVbEQKwcUThBYg5mQdtPGnlDvVqtm+MZqsPNoYM9C3Fs1YMph8gwWhsrjSP8?=
 =?us-ascii?Q?Mr81Z8THaqYXDZvFSaWJxyQEzMkW5Up5NKtskC/qa9u4GTBujf+FAFvnskoO?=
 =?us-ascii?Q?gLwy/ALWa0BeYe4gYeMQoTGFScg0f4Bg1nSTtSp3sXhR31/pGT4UnODdBH43?=
 =?us-ascii?Q?mxPCbiw4UTZWpBqT85Yb5PA4rw1Xj9zNandvj7Edg3UzkJSypF/UkFi9wW+L?=
 =?us-ascii?Q?iGwZEwQSU5/FofaPOFYcXZoHnsg7m7JHLVu5Cu7vikgekG7O8bh+XFxxMyrX?=
 =?us-ascii?Q?h+qy6kYMC7isdls78n9hw3DUJuICtqOwSIN5uvTstAyOzvFj4WggwyUcoGh7?=
 =?us-ascii?Q?yhILKUMOgY5DJub7hOJn4+Mzgm6DwPpsvILXPATVLYGT0aFXEYUNF7Tmgbdv?=
 =?us-ascii?Q?RnnBKg+qpgz1GR5xkFFsAh4uGaB7JYZnrG7zN7+gxmPK5YNm1+0skBL8/84W?=
 =?us-ascii?Q?uM+Gp0IkA4rFhSdVtd6ymnRLCkqRvt8YfYKNKuCHCN/cEapnfrOgrJa+Q8au?=
 =?us-ascii?Q?tYxWBnWySKIPtm2WERBSqwZ0nIWbXyTrugHhdtk/e7uRet6Cuqgq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6828ba33-9827-4f67-84b3-08df1d80f746
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:05.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpmUvVVi91AOzVAj8y2tDgmJ5M5icHFMIMwycMc6JeL+8yzdvJv3nG5GFllxtXujXOae28Ij30Dgp+U9XpqJmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

common_init() enables the clocks and deasserts the power and
Application/Local resets before phy_init(). If phy_init() fails, the
error path only disables the clocks, leaving those resets deasserted.

Assert both resets before disabling the clocks to unwind the completed
common initialization.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch. Place the fix(?) before the initialization refactoring.

Marek, I looked through v1-v5 of your X5H series, but I'm not yet sure,
was there a specific reason to leave resets deasserted when phy_init()
fails? If not, this fixes the unwind before the restructuring in the
following patches.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index f9241ec0f116..75e74fe3889d 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -381,7 +381,7 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 
 err_unprepare:
-	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+	rcar_gen4_pcie_common_deinit(rcar);
 
 	return ret;
 }
-- 
2.51.0

