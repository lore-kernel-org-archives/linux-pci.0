Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749131;
	b=Yn+GMsOd3lmY0IUoOJ1tfnMGKH5mFISOhfEI3zN43usXSgQspuVlpJU6IuEwoyIOkQBO
	 xpZLzGRn7BLaFYyhddABEh9j81lm5EugYTzLJZfZxLNCUVtkVVA9Kg9ePVcjdrfavTOQV
	 v4pkC64oEXpsRL24/6cUP0PoiyeX1gIxxbpj8t3Ygsc5PEbN8jPqb3kbHi9fY17RozDZY
	 fHdsJwa1oOI8BX84anHQ8Mz1aMV5T74yPoJtzPE6u8vVuCAlCCtaitDpSAvcuU2qWn3qK
	 ia0mnTi78KM+qvvHOFDWNKztnO7LkRb2EBJdtQqyYnpfCqGdgyryPMGSceXxw1Iikbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749131;
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
	bh=ucNJQRkwyV2v98aXVl/8Xr/bHgYxyY8lT3lF3fubUPA=;
	b=mcEcg+GfGBEgfCSUgwefEcIlRC+1jMfnBcM+Eb+DTFhHV4zRDKjaSIORZ0kkdErC18EH
	 zxVLlr+FBRpO2n9f8Msb3YT5Q+WxCMg/bgSGHMUSMcRjAtX4kaevG7XwrxSsNLwy1Cbxh
	 BfWDtir5GMfcf5V8EVpESKMbKmp5eVy2x6bfYjEUm4Uvvk1uXD9zdA18ZDudn0XPJPH5I
	 XnT1wx6l4W0vWJnyjPIW8LEkWZM26fWHM1oLcsUrsepqtjUCm+itVbMD7mbVGTyNPL091
	 nKK+vCVdLTtjn99dzIwq4ksEhQ96fAFqgNHjcNDQ/BTOkn5kM3rpMtD3FFNp7nKoOGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=GPOt84pn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.135
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0F606A682;
	Fri, 27 Nov 2026 03:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBD0F606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=GPOt84pn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgukcf5rQ2B9n4BeserLSPSLYP58XNUIccGhBL7dhsSZYmTXyCHoz2RV8wdx8pGne3XUmp/VwvB2tpndkOt6LlUAmTAJ09N5WTxmu99kwpbSrRbjq+oY7SlV67w40+DopEY0WX26mnqqDe2JbyXN4R5FWSzl1mg4Rl1nJbZzm9ln2QLS7AlkMWYx4/fQPsXuM+E5LXPL8vRuSvwYnRugts/4XqtNVPHOF151z7g5nlxuMbzbRQmRyXbqBafuZxQeK7FJld2FT5H3GnA5zLEmte7oscX+LOQ8fMmY4RjT51k2nRr9oGODUq/y3mN8vbm2suyn6iMgi81Enp9Mdu3fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucNJQRkwyV2v98aXVl/8Xr/bHgYxyY8lT3lF3fubUPA=;
 b=qf1zSGe7/f8/7HHw/ONcdAZUGyiF4acAb83U8Em+Q2mhpFF+mVCBQW92j9dkquQ54PqnLVZWPD7AHyUQvQDzGww2sTt9um5QLdBezKh35Okv06TKF/mLgLOjHu2cZtWBoQqNm8VOFBvqdMRB9pLRHV/aq8sYs8I+GGycNgivm+8JOIIfQiF1wFdoDliXvWRGdZ/yIg+/7c5WCFyrjVncQHFfhl9hsWS7oyHstWczuqrjGC6WNUxfT6ycex1aTfNINYXvW0NI6toWGfqD0n19+BwcB0nYZa8MSqPUZccFptAEO+ijrbztHQ9sHicsOxescU/w/Wem/E2f5cnArDnl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucNJQRkwyV2v98aXVl/8Xr/bHgYxyY8lT3lF3fubUPA=;
 b=GPOt84pnheP73gY5sCW4XDxU/l5xT1a8hdozcdGGma63Ox53QtNZWfS+FDicCqzWWZI8BVb1xoHzKQX+8/veiYzCsWgfYIelWbKU93toto/qTlYVENQgsF96tGB/olpa9sANf7c7loxoX8qIx9CQ3TkRLUrtwDSLiyZXdXiiHpg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:06 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/17] PCI: rcar-gen4: Check live link status in link_up()
Date: Fri, 27 Nov 2026 12:11:31 +0900
Message-ID: <20261127031145.2521228-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: a57c9e73-04ac-4a21-30ec-08df4c343781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	XvM0eHQrispuKRNejL6KNl5Xa42xyc3IhbN9HkblT8dt/yl7D1TfpeiVXVfrRaYzCkQSKhPxVkMfovwa2MdDNYjt56TRcLJXjVczp5OewvbsdjaN4xV358gOzM10YsgBYxXtFP41xqbfCPri8yk3A2B8aJmV7v+NNPaS0Ea6fWfPgfTdbbf/2H66ZktpVDlza49Vxg16SbGdyk6hEA9SLuAsChbK5XrbzhhuXmkhQ/4dO60u+4sOV7HPZGhDCdmWrV2OJUnwsiQ/4RKpNKi+M1MtBwsUmGhNB/66N8RFDWB49s7dr66/HWAlj9P5i/io1liPT4pafEkHEuUUFoOJ43OWXsSWTS4uQOCTQ1kh8U/FtiWblV393AHLFdof1mN00c7JQ7zPCxU7N1BaeDA9mbr2XdQWdN20sCohPSxK0eaVpE3MB6ErZukRlpyAysw4LUKf/k6KIhWoTQE0TgTQ7SCHeMYuU6fYEFu9R9MV6pAbd4GFGiHa0A6jvZn5iAlds2H/0Shqsi6+N7fE9y32Ge8jDVwfd3zweIeU1sqjGB4mfZxzVjvghtrYO0YP4/75vgiY2gIq5UvoTlIPqGCHUW4VrmtAbSJjjvky3/iRPv55vnZKFopn0UtEIAocfMDt+sLcTv5YxHltchiPDcFl/RdNjfS83pYcUc5Ih3Feepj2Fbj+wNJa5B34+4i3fnhBaoq5M7EUtVbhburd8+xI4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B48nMDMuy8Pl2bk3bA8LauDTLsYOByVtNPXkEzo0IIZ/h/WHr2WFxasHAc7d?=
 =?us-ascii?Q?K+LJBpnACLixoGGJoipYMBqsLlH05H/hkxzwslZ8K3MmcE6xEZcw6WdkFODF?=
 =?us-ascii?Q?gSfIZUVFurSJeYN8oCBYhze9Zvqkmu8p3j0nERAwQdt/cZg658kuf8QtzIs2?=
 =?us-ascii?Q?4Ab0042V21R0mW/Jwclkuiui/miX/0VcOO3Np1a9X/qFQcpho1ba0Mkvpju2?=
 =?us-ascii?Q?IXB1/aqufcD8xO/eFKlmK3Ke9N9fBl+IOL4PwXRE9RJzNjkt0ZRDGZSGQnt3?=
 =?us-ascii?Q?62ZqkEPx4Ai+wiep14Egiiad4RV062a2or0kQ1k6mWiwRNe/mmpG1QceE93T?=
 =?us-ascii?Q?S9uwdJ3oMd/RdSssoeflvnI8QVKnyTSMFR58TxSFOQfZsZGZi7QzZdot6BM5?=
 =?us-ascii?Q?GYB3BJBj4W3UsKnFBeJE2YdaE0w7vkdwTSGlDAK04IzGDJQykX+m/VwcjG2x?=
 =?us-ascii?Q?yYb4SpUnsI5ERB5L0lmZI7wMhSAdDgraZHlfdyigP3NHtGfXpHIxGEj3DSzf?=
 =?us-ascii?Q?JO7/o1U+aqMVY1bc7p1BbBriDNDm00HFbwtiCBYt748fSEIpPn8Z5H7b3U35?=
 =?us-ascii?Q?Mih/IMgEYsz5ZqyCiHZkOrRKBb4lVcCA2oWGbmFggt0UTpGlz0pkFng4x2Vj?=
 =?us-ascii?Q?Qr/SqdNbUhgZ1JUe20r0OiiM08NUxKiDxFOXRdHoELIi+VYZSuo1/ItZj5cO?=
 =?us-ascii?Q?ptLF/fOmIqahpW9DAj43WxHxYIqMIxgl8ij0olHdSLGrB24YpqqDZAwb4UI+?=
 =?us-ascii?Q?PioiQ0Acs7TgF5XXpe/TEIYJSKtTlvcxZoSdEQp7f7y81Cjk1YTNBzTyVh0O?=
 =?us-ascii?Q?wtW0MvlHBeZXVBWXbbqnHSGNlCfgA1RokqrF83PwUdM6bOMDzIR5DuvUmtgi?=
 =?us-ascii?Q?VJLIE92ZEogePYYlys+xBUKQJzwDXO49ZJ8xF6NttgWjCD+ZvF4s/YbFfNA6?=
 =?us-ascii?Q?u7hGAknc/+Wpx9kOJ/vi2uQPwLoQXMXl5xAHJ+DyRXGZsWWJ/DMGbbutQ+ky?=
 =?us-ascii?Q?AKQ1eaXjq7zXAQouF9z1sRlMaXjnUcaf1sGhzklTEDZ5B/6DqNC5w2eBJqA0?=
 =?us-ascii?Q?yzIag4Jg8GYra3EPmer8xRd7alP2sF8qCZdRQNNrN7MjZW9LfZioE8HKQghR?=
 =?us-ascii?Q?5bNV/Q0iJc2h7oXxBwcqItFxCISf3bo5l5bNbIcr2/uHaHAgDImxV1/0KJvo?=
 =?us-ascii?Q?VzKmKGGXQ8VGpqn2J73QxbuMP+yH7cgvGFq2U8nrcxlEY5DHoA5I4i8CHDna?=
 =?us-ascii?Q?RjUGWNcM5HA2uOpOXlNNB0ONzrZqR6lAndYFEOI914OQ9Sg7XK3Ow184hODw?=
 =?us-ascii?Q?+QaltErGWEQ5Fs5ob9CdkhBw6C0cT6qCFzeqi7kN4I38uUGAO9vOF/oM6XrQ?=
 =?us-ascii?Q?xcPRRAPFYhh03edATZVfEIWX3/eZ8LxGVwjiolrwWR+QuXoe2iORbhMtOXvc?=
 =?us-ascii?Q?uWUdtbekA2gs/iQ5dmYGdt+QJ4GlUGbHZstJAFLlbBNSZlERWCfKUQ+wlsBO?=
 =?us-ascii?Q?VMzE2ootiZXll56LpaX58mcJiWzs+jk+eU0mZ2dB2T4HE23Bm7ZeEsHyvy9L?=
 =?us-ascii?Q?Dmch1tq4dYZIgBHXbsm+9VyD/cJxT7Gosl2ws46KbUq2JqSAt/3bXOTMR+jx?=
 =?us-ascii?Q?fl3426O5ncxNOX8zCOohKJkFu2t/wc6AE6Z3dJYLV3jk/pBtNtOwGaRoP82X?=
 =?us-ascii?Q?2NagMtHH3iY1ZmDidjYp6zWZIquVqwk8GXfpOap7z46qrBL11DkGlwwUXpB1?=
 =?us-ascii?Q?JsC3aV+HIW8CZCnT7W1pJJMvw/dlJtQtFGhK/BMDxz/60Gmxtb/I?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a57c9e73-04ac-4a21-30ec-08df4c343781
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:06.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODrrnFLr4Rmr1JNDs+eHKJcZf2Tv8PqhP19baacXCgqaqDREhIlJAYovmuEuYg4RTP39yr8jW+2UURPNgEGCiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
link state. On an R-Car S4, after taking down the endpoint, a link-down
interrupt saw PCIEINTSTS0 = 0x20a000c5 with both bits still set. Even
after resetting the controller with the LTSSM back in Polling, they read
0xa000c5, still set.

As a result, dw_pcie_link_up() keeps reporting the link as up after it
has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
which is supposed to stop config accesses to downstream devices while
the link is down, so such accesses go out on the dead link and stall the
host. It also makes the callback useless for the link-down recovery
added later, which has to wait for the link to actually come back after
resetting the controller.

Keep the APP link-up event check from Figure 104.5 of the R-Car S4
reference manual, but also require PORT_LINK_DEBUG1 to report the link
up and not in training, through dw_pcie_link_up_debug_check(). The
callback then rejects a downed link even if the APP link-up events
remain latched.

Clear the APP latches before enabling LTSSM to discard events from a
previous start, and only read them in .link_up(). RC startup uses
dw_pcie_wait_for_link() to poll the combined condition.

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - None.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index ba8e6b297674..c9ccdd0a7ee5 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -53,6 +53,9 @@
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
 
+/* PCIe Interrupt Status 0 Clear */
+#define PCIEINTSTS0CLR		0x0340
+
 /* Port Logic Registers 89 */
 #define PRTLGC89		0x0b70
 
@@ -120,8 +123,11 @@ static bool rcar_gen4_pcie_link_up(struct dw_pcie *dw)
 
 	val = readl(rcar->base + PCIEINTSTS0);
 	mask = RDLH_LINK_UP | SMLH_LINK_UP;
+	if ((val & mask) != mask)
+		return false;
 
-	return (val & mask) == mask;
+	/* The APP link-up events remain latched after the link goes down. */
+	return dw_pcie_link_up_debug_check(dw);
 }
 
 /*
@@ -208,6 +214,9 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
+	/* Clear link-up events from the previous start. */
+	writel(RDLH_LINK_UP | SMLH_LINK_UP, rcar->base + PCIEINTSTS0CLR);
+
 	if (rcar->drvdata->ltssm_control) {
 		ret = rcar->drvdata->ltssm_control(rcar, true);
 		if (ret)
-- 
2.54.0

