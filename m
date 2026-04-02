Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D653E316E;
	Thu,  2 Apr 2026 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123443; cv=fail; b=ipbx4USWtOAoV/ggh5dZ6x16hEy2uOI50/F8oqAlQp7I5GaHi42pLvZuGwOZFn258VEdKcrkK09uMRUbN2ZD5DYRPnLL60aewP6ennkaOQie7r6w9lQTpLgTVXP4C9jC1gqEuG4ztAnKcFkiS16naneyT1xpsdVx9OQgTM4I0t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123443; c=relaxed/simple;
	bh=SHgkdcWQLmIWNdmd6FVTnV40+Bso2NkdfEmA7AAkDSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdFkO4HH7ovO9NthkuG2v7lhRzAmLDGszvG1OANtJW0bHZzPbwvVvrubHt46NDczoa+vr3smUepIUT1h8PzW9vL7Bld1bZRvl/cPttGF+9laQJ6DOQvaGTI4A0ydoa77anbj4AfJxfiGFUuea5r2dD8oH/8YYu5aFvWgVa1OU8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HPPWCaDH; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HPPWCaDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tN7SgY8IM3Lp64Vycy9BQTnF56Gmj56BCbNA2UpXcQ2XEuF7hZhw2rVIIz+B/PwyaR92CNBW0TATpjgBAsqQtpd4wWUdqk6sBULPcxHKCndoZzUnKHBiMXNdJoOZDKhfCy3NzPuZwdsM9wh1d2vkSvdikkqCBhNv77rU1NADBgiyqgjuLvPLWrKbIrpiMfIFpfhRxp/h+LHPVSjRVbnMo+OK4HTCmF6LgIywUJXt05ZLZ6mgGbPC4v5/3jxg135SHVHTnAV0OTj8E1+MeNLtjXbBL0p2PWD9ixKEU0KZP34sTRU/rsSyosMCvhTMJHyPOup5Zkuqm8Skzu4NcC87mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+/4iNXAH2Vuhz/GgTRpfoMMfLPcLnPEqw2X2iiifgM=;
 b=K4Vl8x+PknAQMdfXE5JtHK0Xb2j7d/DDiQUHR0rLW2qNdwi80Mo/1hhsqF84M31DZn2eSZu4ja8ZNQDQr4m4iDvtOjS8iz7K7W7lSpO9Q8+b7ZlKVMbNqVBYjO5ymleCwLlY8W0DSQLIfg9w5eHRUO/DuImiekxbQVqJ6UZfSVWzQiUFlAr3/CUkcLR6UH9abEKlbUVUn0hbwLdg2RkeqXInWnxRRE8G2O1MZnvzvW5sRQYD7aJ+CiFcJzuOuES4g7C5OfdoLHV50j77HHEiXH8FFEdCrdUXqD3hLWhnYYRzJLHKR2jHu9arEuJ8asldCQlPCsn39QHlrhF3TZfVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+/4iNXAH2Vuhz/GgTRpfoMMfLPcLnPEqw2X2iiifgM=;
 b=HPPWCaDH83AkVpSg6BfpCchkhTSBJaf4C8BujnPYeplFWmSsht+9+XF3Q7FEng86E3qP75PJuVpypHaLHbUlI/jYC5ymST9RGK8ZyQ3cxPGaIvdwkDHWiEtIHoyeORxO0ZWRRj3ePo+YiKvZm5uhqqEulQHLb+iVTyWoSnk5GxgdVVSpl83vddJDcGk1r3/5/vIMCrfjDBQsc81gF7RqO07WDxiublR27h02JuI4D5HrNwIJ7oA1EXa5YqFAzPdn6QYtiEF04UsmyVS54KjjYhNQEHO5hxy4buvigNBsGIOghyrzXwnyNUAIh2GNQ9lA1i9aq7+Qbr0KU+tlwgsB+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8471.eurprd04.prod.outlook.com
 (2603:10a6:20b:416::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Thu, 2 Apr
 2026 09:50:32 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:50:32 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 05/13] PCI: imx6: Add support for parsing the reset property in new Root Port binding
Date: Thu,  2 Apr 2026 17:50:59 +0800
Message-Id: <20260402095107.205439-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402095107.205439-1-sherry.sun@nxp.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: cf032d08-5110-4c00-9c13-08de909d47ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014|56012099003|22082099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	vyLJghb+VJxKn8KI5q+ymIk7WZiumY3WgKF1g7okBdtU7Tfc4F+g+JqRmNso8jPbdAUYMIaIHEH6aYZIaLGJ19qMM3DnMW4W1ZdcHThE7vWaH+VfvDiy9w82REcrjJPzmIfA2aOAO9/KUVBjKH0NXsrb9E/292v+WgcO5nYpz74kBBua5ueQjqLjeL1JEwSPCYSu/H5TJgZujBH8bZBJsEPP0GZALvzLe33Cl+afDHd0+wn3hMxrIb1/VovME6jy+ZgkAVCPUOOaWRvN/44IJhPcq/FuvrEcf6S7EDLqOAjdcZF2SqfRtu5zbWIt8fRPyh/mjtT7Rm3DOfBaUP41I4TtlkIjf2DL3G/8C5Gou5U6awRv/mXucWVtnrr+ZPLuYCSnvpqmW2SHx9cGuq4hT12iDHDVfhid/VLr8RhQzJYbckRtUVermBed+6DbzemEyhS7JsZD7+/+zGsRr1WE/qVYsLq18fk4YExdUcDKj5kkqIw/c2IjZ+AgNCe03A0vzZBUXObONofiMG42iFJuKmGSc5j93iIzwXLVuBVvcTQT/6CrFSIpV9HFQSX5QeI0kBDVA3QCI8wuN3/zO3uchKYNsSMC8ytLXp/se+qksdAaBDka+wrqtVA/idK9maJEcxp91L37IxQqMYXPJWljH7BaCdAhxI6feljW5ZKgEK3Pd6lsg/N/5V3PL8txDMrxR65x8VUJAVZTR6drMgffdtPdL+EPalWWLn5fomoir73HiWmUE45ryfnptA1b7Cq4NBO7C2RmljIlj1ljqZpZl4a1MLwS6rmslvjaoE+fPCEgDVyzzhOzecQWW4I35ZfA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014)(56012099003)(22082099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tj41lA27r9qsjDnHisScfkLXEZNwCHjFzpzOP2YV2vcyjp71Neukfll4e4ri?=
 =?us-ascii?Q?KBPVlkXhQbVew/AhkIoFlbSm3VrBFQaBhukUASzDOJ7Fzbqjjs4yfCTRK5h7?=
 =?us-ascii?Q?rzI6yyMHKqhlTHibcQu5eYP4Gbe8nzo0SwKWg3bBAy+hiVCA6bui7uLk5hfh?=
 =?us-ascii?Q?us40e4LFk/HRqDtdvgeojAvR6WiaEAxVvBxJUkLopqHX7wwWO9OHQLUk9YVz?=
 =?us-ascii?Q?/B5Xhu2V/12AqyMpUnf514Ra/sRRealYVBckUG0r661hATOC8C4vbdRjgGXZ?=
 =?us-ascii?Q?bkAKwLeXikh6iWWAOxbwOV1dxUTNtQ9p8BtCWZ7qXyuYPOEVu4FepKZdWa17?=
 =?us-ascii?Q?6joIsIDpM8/OcssTOslKP89h+OHy6b6mor3j3Gnae6juZp5DhQKLMEkMyaYO?=
 =?us-ascii?Q?x9yt890gN7BHbv0+yOWWU97eOclmSuZdJEzOq2jo5M2ojnocpbka5eI4Bmex?=
 =?us-ascii?Q?FwGByAewdEamBO2kcyVSJUUx0I64QcyNyMFOpM+tj01B7X4ENs/dvrJOsgiX?=
 =?us-ascii?Q?e6VdB29CNfvJgcIKfWZ1IyhLSwhGgQVTJyp25kOJ7FEKoHboR4BsJeY6Fg12?=
 =?us-ascii?Q?8CEiSKcjy7waA6OsT37JNXmex/4/t3qtcPYkyXuUXwNpuTVf03eyEoed8GGO?=
 =?us-ascii?Q?6p7k7/mE4w8PUXxOBRaS6o7aCjGUj51JfvCc78PjLju6N/2nDvmlzXHMHaZa?=
 =?us-ascii?Q?fduhPQbXK5Dyr2aZhoGv+tq+reynvG+nadPLo8581Gn/sKVuiIadY7qske0u?=
 =?us-ascii?Q?7l0Ud2Bh98psPPzrKkmwMUNpg76h5pzaBO+XNhwzysVc6y3b9iTX995vzDU+?=
 =?us-ascii?Q?2nKmE3iK9MiDVSbigsOEQShpQiEme4mKFynOIEvehqtEALBGXWYU2CZjIeqq?=
 =?us-ascii?Q?vhdugF1khuUIVV/M+iGudQn1F9/4/HmxgbmswrtfgikcsQnAPXweXDiFyPiv?=
 =?us-ascii?Q?x4k1oL+oSsg4zjMdUTfWHq6hDfYtGjSV7ljeM/AhUrNFpS+974ENO9Ezr5JR?=
 =?us-ascii?Q?Sfq9BVona49kOMqTfyGZVPVYog/GCOplj84PKegOFxEyW2xYYWLoXyVGIbDD?=
 =?us-ascii?Q?2mXJutIDJ15smg1NbTkO5Kq7PEoL/gooxCft/n1ckYHpOtpwdIC0H9T/Hp9L?=
 =?us-ascii?Q?HJNOa8Iq7TZllbjx7xibrrXSq13keKymy6AcgIgeUyfh10Uq+UYNl1RPHd4u?=
 =?us-ascii?Q?OQPIydSqqK2xqtkojUcG038n3SpN0/rk1KmKmVl3FhNb/4HSxQF4g1xGE76+?=
 =?us-ascii?Q?FAe+FwURSz+PNGtyBVkd7BeW64+yRfO4NrhggGGhXRY5yC/c6KWue6rqKYtT?=
 =?us-ascii?Q?KMYUl9teGNMKW5842fw0CWGWPB6/3mwvEbCB9TgCktFPxTbnyY4Cy578vrrY?=
 =?us-ascii?Q?7Ixsa3hZ3dYbXUWE/ukObJK7c6b6wA6n1BziwTlCW4Li6JYvCa50/l99L/ed?=
 =?us-ascii?Q?XuSGObmNH1ToAWWbxK/gK8IWM8UNDVITpoGEBghgqeKvIrdovAgVj7XVfFqs?=
 =?us-ascii?Q?6hPJJYSyASi3V/EdcqJpw2STDTevqfi1F4ZHq72rbbh3CTOTcV37QnN0OET1?=
 =?us-ascii?Q?fPOEIcWvl/RGdZV/2farRmdA99lVxHEM4kyZ06VpnoCmnaPjyyp43tt6goor?=
 =?us-ascii?Q?Nd456mAQKDQmLBirZpfIjzQO0GBvpzwS3heRNGxkeDBJDHMUTQpRBLkzyt3p?=
 =?us-ascii?Q?xw+BiBqp6PtzKemEAVUDr4RVYOathsflqrYoFafJh9qO1B17JVN2Kx7zUiB5?=
 =?us-ascii?Q?owyK0Z+Isw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf032d08-5110-4c00-9c13-08de909d47ed
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:50:32.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KZFxcaoFWYuY4FA5lEuvAgj/2vOybU4NIZpJ+vWtFiY9u0XG8Akq7UqQjywfvOJ+3Jl7ACtQJ16TjFYl++KJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8471

The current DT binding for pci-imx6 specifies the 'reset-gpios' property
in the host bridge node. However, the PERST# signal logically belongs to
individual Root Ports rather than the host bridge itself. This becomes
important when supporting PCIe KeyE connector and PCI power control
framework for pci-imx6 driver, which requires properties to be specified
in Root Port nodes.

With the common Root Port parsing now handled in dw_pcie_host_init(),
update the reset GPIO handling to use the parsed port list from
bridge->ports. To maintain DT backwards compatibility, fallback to the
legacy method of parsing the host bridge node if the reset property is
not present in the Root Port node (indicated by an empty ports list).

Since now the reset GPIO is obtained with GPIOD_ASIS flag, it may be in
input mode, using gpiod_direction_output() instead of
gpiod_set_value_cansleep() to ensure the reset GPIO is properly
configured as output before setting its value.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 70 +++++++++++++++++++++------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 948ffb75d122..b44563309d40 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -150,7 +151,6 @@ struct imx_lut_data {
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
-	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
 	bool			supports_clkreq;
@@ -1222,6 +1222,32 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
 }
 
+static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	struct pci_host_bridge *bridge = pcie->pci->pp.bridge;
+	struct pci_host_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	if (!reset)
+		return 0;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &bridge->ports);
+
+	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
+					&bridge->ports);
+}
+
 static void imx_pcie_vpcie_aux_disable(void *data)
 {
 	struct regulator *vpcie_aux = data;
@@ -1231,13 +1257,22 @@ static void imx_pcie_vpcie_aux_disable(void *data)
 
 static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 {
-	if (assert) {
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
-	} else {
-		if (imx_pcie->reset_gpiod) {
-			msleep(PCIE_T_PVPERL_MS);
-			gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-			msleep(PCIE_RESET_CONFIG_WAIT_MS);
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct pci_host_bridge *bridge = pci->pp.bridge;
+	struct pci_host_port *port;
+
+	if (!bridge)
+		return;
+
+	list_for_each_entry(port, &bridge->ports, list) {
+		if (assert) {
+			gpiod_direction_output(port->reset, 1);
+		} else {
+			if (port->reset) {
+				msleep(PCIE_T_PVPERL_MS);
+				gpiod_direction_output(port->reset, 0);
+				msleep(PCIE_RESET_CONFIG_WAIT_MS);
+			}
 		}
 	}
 }
@@ -1247,8 +1282,20 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	struct pci_host_bridge *bridge = pp->bridge;
 	int ret;
 
+	/*
+	 * For DT backward compatibility: if no Root Port nodes were parsed
+	 * (indicated by empty ports list), parse reset-gpios from the host
+	 * bridge node.
+	 */
+	if (bridge && list_empty(&bridge->ports)) {
+		ret = imx_pcie_parse_legacy_binding(imx_pcie);
+		if (ret)
+			return ret;
+	}
+
 	imx_pcie_assert_perst(imx_pcie, true);
 
 	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle */
@@ -1702,13 +1749,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx_pcie->phy_base);
 	}
 
-	/* Fetch GPIOs */
-	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(imx_pcie->reset_gpiod))
-		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
-				     "unable to get reset gpio\n");
-	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
-
 	/* Fetch clocks */
 	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
 	if (imx_pcie->num_clks < 0)
-- 
2.37.1

