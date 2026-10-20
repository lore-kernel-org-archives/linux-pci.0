Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465865;
	b=eSGo5L6V1FM4iUbdrRmxUXV7DWEMMGCb+pRdcavGbf/ntXUShIDJT25mLoBz3UcxVs4+
	 8dXL/no14t+t5S+Ob0E7+nX607GPWARzrLKZIORS7E9ckMJUIhUQ2kudoawDmcJGCD/UG
	 sxaMKKIPYw7Tzu2QMcboFr3EFG1uxdhg/auWj1HRaHlbWdkk4/QKkSbdjtqlP3zFk89uS
	 +Wd6NlS7zH5syJoLfN1lJzYj1baRiTckU/po51LNH31D2ONZ1zBbs/ufwVeNR2SCi0+u0
	 lNLd5dk6j0xFvA4Gagy70IOjpOrXA52yraUY5JOrqPTWvY+rfrgpT5zLSVtWQsw22vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465865;
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
	bh=SvnMUhfWMYq3mjz7vZNf+fLI8LIO2XMXBtSYEMU3K/Q=;
	b=GEfo6jukkCePpem4RT3EtehDJOdAdOOe5MqhH275Q+yx7HZgIxqkrgrsE9BFN44qzDmT
	 /KcychsVG9+xbup+R7G12iiTCTfvoUtz7EMVIwGzifHCTJWLa+Qv21vu6d8YA0Oca4muQ
	 GGgHA9AUYM3EyAgsNuWrcM8/pPJzInZ2UjqGLOS4OBatwspUcTLtkzNOP3kgeDkJXbv2o
	 iPVvoJ+RUB85mbaiGterYKF0Qhh3Lmfs4xdvmBtZ+CzNiI0juTyr3ewvuStbLNR7KF2An
	 Eku7o6vljd3gcGjJoTJinOM7cUzLtn4xbqrOj27CzcpJZZ7ij7hhmt9EJy0mQhMtetQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=riBW5XPm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC654606AF51;
	Tue, 20 Oct 2026 03:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC654606AF51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=riBW5XPm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqhaQQ1jrCetV8XlgBXixEcqL3nXWjbxihawAnH35RHpoDRwqMayPvQrsI814eAmCNmxiA3dl3BQZ45Uvd5S+WGiAsj4qPkKcHkiCeMs208lsPhuEx1YbViUqZe0WtdU833sZKGU75SYvctbvDmaKalBWyf/6AOokLc25ms90cuMcz/23PTo5YSVQsTHFcu4YSqj5ZPiXtQbeUFKWUhBIq0VXz3Zet76VxemT3FgkYKuJjpEce15HTAlBGja1oQDOwKcG3CMo63SxJoJndgj9NsDr1Fz+TBnUJd+gGHd4Ftod7QJCZEkaKF1yN5Na4fCrG632oCyooMCJwFmY3FILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvnMUhfWMYq3mjz7vZNf+fLI8LIO2XMXBtSYEMU3K/Q=;
 b=Yn9HRz7fcf3MhlADP83DgG+h7CRb+LfFxNCOyyQRVHbIvEWqwr/miYQX5FwA3URwRY6Fb9yUb2q3470NbwtoWSgbvGczwhAGqlcNfdLFdc+Udr8e2z2GQowni9IM+sDuEzcHtBF6Hp+EUu8Nb+2igv3So5Z16uA/zVt6W8OxO8enAcltToN3G5ZqmESM9UWRVYd7TYtgVtiFgCsYQogZOCk7KIvRNvFfHjYOZOTT59QwgbiCJ7U80eL2wS6CcTYYqoDLQ7MHuBwG+Uh/JiM3seg6kZkM2aNw/pKhD7+ZdPORsHkgul2OydcQpysAW8LubPDW6JdWDXdjqUAKUdMvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvnMUhfWMYq3mjz7vZNf+fLI8LIO2XMXBtSYEMU3K/Q=;
 b=riBW5XPmn6QCWJuk2PB3tn8WYOrJHXgeMFqY7pbrahHBbzKTQp9aMc+7F+Foh5yQChaZ3RfJE/v0OGUuURWshFxPg7uD1lIu5WMGx9HaZNdJxzwHj4+sJE/P7Lq4/l58YPSOg5OPuVfdoGyzhdJSkgetKrTm6fHPbsIjBAj3iwg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:01 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:00 +0000
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
Subject: [PATCH v5 03/17] PCI: rcar-gen4: Check live link status in link_up()
Date: Tue, 20 Oct 2026 12:10:35 +0900
Message-ID: <20261020031049.969895-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0264.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 695ce031-a87e-43a0-6888-08df2e57c4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zn7kxrEPtPZaWa7eOB1gd9ATnb5CYwXlCrC0K3ZFfzl3mMRs1w1RpdUut7cotM823JlJcXcy8ST3XQjTLN2rja7h67/GLVgXK6vj/zpVJZjOfvglVUvN4bQGIGsdOTJgGsmTAlKOf1BLlOZHTSxJ1P4vVnHdd7doHEffR69KHg49ovMHmq5jtr1LX36B/8Ndu1+St38mBhM2LMlIUYXGVfwNOyUiXNC6dpyEoAkuTKHRluZwfSvINCNHD5De0HC6z4gE+zN+FW/+p26wPVnTvSIMubN9CZ5dl2vvmLVpbGCtEKNkW0CnCjS9xiabq7wXXQeJSjdVGz3tGf+Hvcb1GuJdXVG4oRQ6CH+8nXdbnWBn7j3BGKRkmb2qT8zg2fB3GhRGlQqcoRO6oTfveAE4dpTx9O1I61Cve6TqfQSMb4Akanpnnb7V8GEyErsrPSXKxS90sp874liZGQ0OnOVhTXbWnVJv1jQhkyIPArOIdWCdZIaKYE8Zxl6LVDOaGkccAsgDsBcFSJFP1zRqsyPbjwsGYfD3p5TnrwikJzTvQHSR2rOmq8O+hwx/3piIgQbDEKlbRdKMwc7WaN/p4QMwyRyITuTwdGN9l/zl//bL7eLrT0Xj7HDN/JfAFvoDVGpYEmsNegpIUUeAX7KRg/qhUjlfQjVwJiI2rp6zbyxaLEW+6mTl/DUn7KvQ+zLFQ2wrdl+xCG+syRLeL97oBXyFDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9KHSTSpc5NXwGRIV76fG1Eu7NIBApHWaCIJv/w8LfId/ihan5lchInMZemit?=
 =?us-ascii?Q?knnY7Iq73afnKGQr1GjMNe5yJq7NKuT0xRI0ruzwU56jMqjHiKRA0w6XUxA0?=
 =?us-ascii?Q?soKid7Y+g45ddnZs8RCoMlBKb5diet6m4LZuyvv8RXfhJSvJmvyUzT3RVaaw?=
 =?us-ascii?Q?YpfRsyWgpge27q1D6geRbId9aZjlWxVHGNo6hL7RtaZyKjRRkLG2VrPOnvq5?=
 =?us-ascii?Q?rj0palzPGaJ8CTMQ/MTDeN+7ySXDiBnl1o8lFNNzflBU5lFZMpoEme0qwB9p?=
 =?us-ascii?Q?LBy9Q9mgmuoZORFnEYoUIFRY1GAzg43R4vrwdt5ZWTfN7C3fhCbjQQ689Ini?=
 =?us-ascii?Q?Aze5WfrMzgzs/Hk81FHEV631Ok5z3Momk6O7y6DsiGkqUIIWcYLsja2OUmgk?=
 =?us-ascii?Q?yxjJSQqkHys59TL/kHHubCZTAczcwxmjKtpUAioTjum9gPawOps7c5k4Yamx?=
 =?us-ascii?Q?8RrCNg0GIZAweG7jacAtJx3VyXRKclBp8DvvOQHClkAc1OtiQkA5qZ7GleM0?=
 =?us-ascii?Q?cqlldL3esmI0B25tdp4L+vcZ9BamNAKP+dR6wcU8RxnE8Z1dBf09B+9k1Qsn?=
 =?us-ascii?Q?tx3FQ5uVuJGpjHTgu1oBQZOkoG85rJP1/CvnTCohoW/lkex0xldtiB6dPkAh?=
 =?us-ascii?Q?1iFcb/fEV6ujI2OXNtd869GAFWVTrJ8mpEKiD3dbigTD8/DeQp7eZ33343jO?=
 =?us-ascii?Q?oaQfVgJRV29A+dkDvHYhvHCdumBwIbtSIFrxOyhNzIt2zhX+jUJF5Sswp9Qm?=
 =?us-ascii?Q?+MHkHUZXO6pWcxq0NzEkrOckp9UBcqtST7httM/jEww3bU54ZRNn7KwH0m20?=
 =?us-ascii?Q?VYJ9NLwYfpIuBVpUqsFWKiSi7MC4epxjEegKOhsMlK+EQdEXk6TNC6MNkYja?=
 =?us-ascii?Q?8bmzAee0rDkFVTBj5EnuKqtbii3qSvollNOJIpPW0Cjhg8OOoBn7oxxWNT4x?=
 =?us-ascii?Q?Oudo4QuJfu9pxHL5iNmGAhrYx+ibA8XI+F6eaTWmL33+uauFkFWYTyvaFcsz?=
 =?us-ascii?Q?PDuK1fkHjAJF3Op/CqtrAMhk6EUFG0MI1PXAkjcoO1ubpqpTTA6iWtk6Xw6f?=
 =?us-ascii?Q?t+9CY64BMQn2DPw3JbtUkoCec14/Qj/fDxFCK8x4WSvKtGdqIgkkROyXvQ5Z?=
 =?us-ascii?Q?rEc7oTuLpnB/AiFntyeoKj58xRkIcV9QyqvJhxR6q3XRQ96w+VG1gtUcPOpX?=
 =?us-ascii?Q?eUbwKJbLBU1ME0/HnBpJm/OjJa/wa9wzRRDnZCDywK+iNf26xeJ6e+88q+zB?=
 =?us-ascii?Q?ge0hKk872pjkLD2nxZd2ORNqB4L9GmBCaUVaAIzQjUETncC/w+VCLeNf0TfA?=
 =?us-ascii?Q?bTs685tKOn1CKURJCR7U83tpoh3TI2rz/NtjsQ7qmrjxUOzrd6EXgnk5elZd?=
 =?us-ascii?Q?SEbmTZvJwU93Fmg+1VkoareApQfg2oe1fW8CEX0fSyuWtwN4c4AeU4HbzT6B?=
 =?us-ascii?Q?L8MhGYrhmEEq3xfzxCFCScNeFHxwoK1p5W+CLzCBzf/Sn+gUiVyet4TUxKqA?=
 =?us-ascii?Q?i1AZcpwQqEw9JSi1JOs/ccJi9yUxInN31YvgqT4nez7yqGf2YyegF4142jhV?=
 =?us-ascii?Q?yqujfOw/iAUR282WM/4ifvyoDGY0epCzl0he26sWnmq9d9SFVTI1hKvmDrqW?=
 =?us-ascii?Q?wPlZUI0axleQNjNH1/QlhKQLvn+AlyFc2ZgpFwmClUySrRyGKMR5v7lSgGYM?=
 =?us-ascii?Q?4CAlHCj/s6lmOSbZoFgrThKpQKYnhfVVv6D3EwDgNg2qTWaziJNIm8F8Zmyd?=
 =?us-ascii?Q?cA9QNm0/jlAHVUWcBGtf8tFxgkKZ8yL1mctnsO7GDG1KRcwB+q2U?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 695ce031-a87e-43a0-6888-08df2e57c4ba
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:00.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQewkYfdDJIMb0TH3ruuFRTHfFBthxzgyPhRrlxnOgiqmNH4r/+gEaJS6m76piz+lo5kvIf551uP+3iohTBt7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

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
  - No changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fceecbd16355..b101ad7dbc31 100644
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

