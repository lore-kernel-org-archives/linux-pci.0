Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8D3D5C1E;
	Fri, 18 Sep 2026 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701653; cv=fail; b=MUDvmtfKteGihCvCQ1FBrKMCj9iy/ENIQ2R36O33wledwRBVu+FJsqQJ5ahcZ5lieyEAtfwQvYEFGmCxolk6hcMQdC6G3gQ/oeuhwoB0sVDD2GMw6VX2zoOYCBlPdcJwOwjRemvtYA63VNaxWgfRg46TQ1EipU8tnQhx2YlOtV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701653; c=relaxed/simple;
	bh=KCe9yHoE/SDLfy9bPBw/e4mZHaXU8FcNLwPuhLSP+Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVymPLctw4xzJP5h+9uKYTgXftAHOXD7eU2Tq2D95qlZkM1emP6IOtQDECaXFRsFJIOKF3eiNrqZRZRyfPU1IToDD+TbMSOvNWXANqkfCFAd8WfBx6V4szJgW15cAy8axTihJ+osKLH1WeqojC3Vn7qNqVNyWVrGQ3dsJC7p//4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tyC5fMNo; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tyC5fMNo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpVv0ZcjfS/IQPlrRl+e3eYAGvaW6mMPQ72oumsXfE2IuX11fRnDtYjtQPDkMY2l24dFTcUyPs2iRKrwV5mWtFxeZLMTdOFBarSf+68QrxYRZEKiFoj6fK9tIBlTZq+72T+JVRfZKk7/pqEjXeoG1Z/1wyr0ywZcf8kv8I/A49mxfL1wUHy6NncC8gG6C9OI22eDjZ1z81YAP+vrsjLSss6eemySvILx7zl0cH98zaqYTIPU0x5mFdTvpPCasdIap1iZj8ykByXU5KKM9MkC2w31LF/t7FXbp7YNgU8qRKc76nB309VQ/vLOvwUnhyPqLVuGcHDcZ1qOfib45Ff4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojpQSI/A7JsNSMjLuK0MY6NQnXn7Y5uDCbDwYcyk0RM=;
 b=wA/v5ozDXhoCCEcWDhtLGASln2rmcnpyiweHvjT7IZ/EKqyJbltPXmXF5EdM5OzrcVfGiQhuVplUdzuyazC5HC1sgxMCahBCEYnXwQTiWArWC0cpZdtTyTMxOvms/aqlFFXpFYgUBc0hXjS2hjoNOtwGTOF2UNRx1emtvVKK7rXTHGUa3MHpNZwZ7TqUhN87WGmpNQUP6CHvSQwBS8Qz4w8QGrvtVvY/dNmzPh7vNwFLh+AZwNC3PvTDFLg4QzchfDMZHvBakUmFXErF4HQM7OvW0RgwQfLmPrj5hlpQSUYxJ+sZo1ra32mncDhYdTcdYS4MoRsTWkhBpnhUxevp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojpQSI/A7JsNSMjLuK0MY6NQnXn7Y5uDCbDwYcyk0RM=;
 b=tyC5fMNoT89ZN4MJ3dOxiavUHhUMz3lmyjJyM/rLB9WDNGQSBmwn4Op++wOSNTpl+QqOjOlv20C70+rWiB18h5J+XCC6pS/R/mCYNsh76fNXYrcDZZesWO2n5W5o8nxDuI2tpwW2NzShwpVPgenvpE9l9PzgdSawM06a+ZvZtek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:45 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:45 +0000
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
Subject: [PATCH 02/11] PCI: rcar-gen4: Drop the APP-based link_up check
Date: Fri, 18 Sep 2026 12:20:29 +0900
Message-ID: <20260918032038.2216471-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: f163a522-b23e-4426-0277-08df1533d3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	LLtm2NO6AstxmWDvRgTk/PQozIw3bJMQvaWwxJ2P11AWW86RBGAy0f0QZ/vAarm2Jp3rLoa7Dz8WImtnDnluLI7oifgqxFRWAUdc0Q/DT0b3Cd/izGJ/w9WZi0uUKjB7LXeUM7bKCAeG6Qly3mWTOXeOHk5pZxpkz/Dt94juqsIlR+FSDX9PcJiTzGzaBcfak4WEHqlXGIZKIoUvCYX7NgJjAKGYJ/J7zOuM8UFlH3cc9xUi6WFOF8VDNQu0C1uxc9JzzBDonH5ZyqzdsdZvnQSThJz+hUU6CAmfDsEiAbrDG0DPzRiEdExy0iBPIn4Ytckb/jF2fVgCNRvm+On4qXQ1sUdWARUf7cHsyqhKiyD9EJyj+VB1KOdOdSSd++XuNNKuugu/LRXnYKrwoIUR4KR7I+KZB3+KkWn23Ze6eCW5OBrxzzlKpZpiHIPWLzu8V2NdzrdINpn5DsI6GKajfCt9wbLV4MKiFcuhkyEx/+Trc1sDUUqKt4YI8lFbJESBjRmC29zrv4ufLdKJabloO/AmB23k/zjGOqgmMTEJ3gdHOYUoKPPKoilTFVVv554w3XRpfVrY7HOz9McE/gBaF6h8nc8CvrAQk9tM58bKNlYhPqE/ENUmtuXVCZLqDRkbqsBijpPtoUU1VBwEqy2AxRzrT2xNBh7yS+Ouw+aUwWhNXKh0R+4FurTWGqWS23LSziLbqzYCHJhSpzHg1fVqDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l6wFvdvdaKW2HAI4P0kE+xAQpXvLsq4WWSOA0dnwex0ausQN+BXYUW8i7gEZ?=
 =?us-ascii?Q?nW+6igMl2Up4IMm/RT1ziOfudNfxRJwIrcHWq57XOAP55tLzW++HLBmElV0C?=
 =?us-ascii?Q?AI4t6ouMVbgAdGUqZHCOYLsOGqBT3cNpGPauY0Tu/xpT6MQ7YB5fdrcSOA2u?=
 =?us-ascii?Q?MTtAWklJDcEZgS/GvjJ6o0RkThkoBikm9AkuNDoFdB6/iBcCjUR2ezg8+Iqf?=
 =?us-ascii?Q?F0L4fIE4TSk4WHCM5V6Whw20tQK71Yaz4KN17JIkyoXnP+wyTHCcnev0AMsf?=
 =?us-ascii?Q?D3HZBdqxZEtKEVtWdSA+2a8ln+b/gzF0u3jC4/jW8bh7mhCgNPK0uZUZ9uis?=
 =?us-ascii?Q?T5s2LsB96un0NsJnaXcQqOcrRrxAKzLEIKSrYAD+J4kmR4j7IvPiJExOrjMc?=
 =?us-ascii?Q?8utBlYra6vOPQ3msmqL+DDwuh07YiIh2mHvOdCT26+D/RJoXQn0Fr4w5+AgC?=
 =?us-ascii?Q?6Ie34y8VD4tLOGTpvD7PJLPqvhc+MdPV2qhIZ0Z+TtcG4Eaeotjod3T5+aru?=
 =?us-ascii?Q?ZqjE3tY/Xsfeop6HYj1gh0uy6xDcBYAilxmbouMajtSrSy+Uhc/tqEV5H+RG?=
 =?us-ascii?Q?tO9UwjIUMBMFrfwEL1SbgEAg0jXzAQBPm9J63usaBfHuATzNAthzt3JZ35qJ?=
 =?us-ascii?Q?cVJtTtN1GkzuSo1G2TpzyzISOApyKYP3IAQwzfUVHD3xM1BCzflm22p9sXQN?=
 =?us-ascii?Q?ialhpxtO76SJUcXAINzPTATTIhflb1aOBMcyryfeTLc4BUnzpad+QHT9jGwD?=
 =?us-ascii?Q?xvjTG2aLgB6cjHy0QcbKorxpRTknbi8jwimddrwkTGpwpsjuQYCwT60DRcog?=
 =?us-ascii?Q?A815lmj/xocS5kzqJRsqqMZWIrBXzJlZReS0g4v1jY144PJwfZtMzaDXMOWh?=
 =?us-ascii?Q?TWroXhwqsSY5KK3rYHS+D/w5Ogv6HIGk5Emp8s0ITa9FCOHPrCUwJWDB95Mr?=
 =?us-ascii?Q?BvxVMDovnIx5tq4EKniQMkrLmGXi1vPXGiR8/OhLkaL1QvrGODl5+y4NxQ3H?=
 =?us-ascii?Q?fl+Apb8Sjx826S0iMwlerRQwzwge6i5717E2oLlepWDzbYr8cM1oMKXf5uML?=
 =?us-ascii?Q?IhKj0WkW3cOyfS/or7+/py7BhCmdpPM+dwMwqWUypG5hoOljS2Cud+Z+jOM9?=
 =?us-ascii?Q?28R/Jm+jpehMpAf/TaKRILQ4U82Ua8eke3pcBYfOD1dvJVPJPLLT5YNLfRt2?=
 =?us-ascii?Q?+L8daE8Me0WsZiHwocoKCKpDHgshwt8KmUneY2y4ldKmAbdhLUz7G2KmGraq?=
 =?us-ascii?Q?iCVeKow7Kfv/8C52v4NL3YtybHrlQjnhuymjpk5KCzN4E8bImBFWQfPL+kTG?=
 =?us-ascii?Q?hqdJlwym8T0K8QStKRudz5g7by9bRGpN18y3R4I7hXaE5zfrcCNzQKndYM15?=
 =?us-ascii?Q?mLCuebSROgFhwqZMeOB2NhuwU7oxuL/iPX+8HnP/vbJNin1GQXEha4dSRaVP?=
 =?us-ascii?Q?RSY20B9VbPH9JcBlNWY5fLp5GH7qN3ijJbXJZWimgrIBfWv/qR8WbUYevc7G?=
 =?us-ascii?Q?9tZ89CjCOmZdQr9TafVB18g6JjYClWsNV8FE1RB5QnIZ9ZYm+SW2jk76lWP9?=
 =?us-ascii?Q?uFXH06JzN47Bmwl0Hhbe9OPsc+W+BmvSqSd646wKgsaijC5cXOIu74tIhX9K?=
 =?us-ascii?Q?fv9brqP6NkUq890pN7eFyi40XbHUvRRNUBGHg+cTWeOfoti4gzaJ/2ZuRNtf?=
 =?us-ascii?Q?YNTMZKThnBSVd4DEULE95v2+Px37ynMYwaZPnO9pkPDaoUDTN2OfcRIS6uNr?=
 =?us-ascii?Q?NBXADhnUTjbXIv4lwv5vybSFOWmxHIywYcP7bz3lHCGV1mDLBRi+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f163a522-b23e-4426-0277-08df1533d3ee
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:45.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/r6h6idXEQ5hoFOuPmNjbxYsDxeVi3z5woOHc6FYuXbgq7tNC9bTno7jKOJ7RYpNWIU8KaieDx+5QZOXE03zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

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

Drop the callback and let the DesignWare core use its PORT_DEBUG1 check
instead, which correctly detects the downed link.

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5a076aa3f490..fe1f1940e809 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -44,8 +44,6 @@
 /* PCIe Interrupt Status 0 Enable */
 #define PCIEINTSTS0EN		0x0310
 #define MSI_CTRL_INT		BIT(26)
-#define SMLH_LINK_UP		BIT(7)
-#define RDLH_LINK_UP		BIT(6)
 
 /* PCIe DMA Interrupt Status Enable */
 #define PCIEDMAINTSTSEN		0x0314
@@ -102,17 +100,6 @@ struct rcar_gen4_pcie {
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
 /* Common */
-static bool rcar_gen4_pcie_link_up(struct dw_pcie *dw)
-{
-	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
-	u32 val, mask;
-
-	val = readl(rcar->base + PCIEINTSTS0);
-	mask = RDLH_LINK_UP | SMLH_LINK_UP;
-
-	return (val & mask) == mask;
-}
-
 /*
  * Manually initiate the speed change. Return 0 if change succeeded; otherwise
  * -ETIMEDOUT.
@@ -298,7 +285,6 @@ static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = rcar_gen4_pcie_start_link,
 	.stop_link = rcar_gen4_pcie_stop_link,
-	.link_up = rcar_gen4_pcie_link_up,
 };
 
 static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
-- 
2.51.0

