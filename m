Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3E308F34;
	Mon,  9 Feb 2026 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625445; cv=fail; b=aWLgOHGONKBEycJVYnT/3ZI7T4V2jS+94tBLI62Fa8k/sOBu6SvS3QPw3mJtD2+ETB3aZzVi3WM/dJ8tzZ0MCA/046mEm9S/AtjOk5TZJzyMikadShOpKMmMx88cQ8DIJPwEPVPMCPDk9h+fNeKr0o/pINbz3GFAzifp3CHiLH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625445; c=relaxed/simple;
	bh=Yze9neflQtXyYd+bgppefdW9D522PheDalzgHXyRfxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aNblB0RKGIYSUhj5zW4tQHy6ajlyJKbe+rZEl45Tk9u3CGz5dZmSEqKemvUsvh5UwsB5lI9kpff6fObFgLP7IbrePR9IbCDu+b1laGB9XxwK53+2Ff5DAs4BqdS9FdBbC3DhwGXpmeMBV5I+HC9QdDV7UblBmChJgrBWd7cv4FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j/G8b9iM; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j/G8b9iM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omQs2WjwEdaAjoGtoVqYlc3YScObSi4ulT1B5a32+1yZQEBnF8wJyzI57HNtPFiqcncxaVqo2sU7dks6N9l6dzS6g/sk7OInMcsstX84ir7dkbNxEcXGOL/T9cEgBl/UuTSDOgTbK/YL2PI78OFsY/pE55hFlFnW/GITIy1xQCkbwRsH90a+Pwh2MiuZKQUFU2g6/LeUn6VWbSy+5gOsxZTiweH1mqsvYfAvF6Tx1a/sPIrj0nMpzn4xXoMLEyg1EUvAgV0dcFQowTVNy85t13WuAn1yMAzcB1mkX/w3aMRX6Ks+cScUx1pE6h/o1SyLpj6CoLprhPJbrgH4kQcKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GznAvISv4pFzGSeu548pViPvbFqorK8VVW/pqvZGJ5k=;
 b=dSkGMh9kwHz2wtP8SZCDd/LrhgoMP48YbU0AwfmsuXArC0AL4QB9X2gbeUx+M+HW/Sw2D0nayTsJQ6YyvyW9iTHV5cvsrLWt1N1n+akvkmoCLYJtlFkWpMuPB7djXrvnPEM4/gzPkHRTFoaAWNGc5oscVWL+uqmQzkOAaACCfoebIMA6f8KwcvWkrXnBBUZ2P/maFhdgANZEXumzGVX1WT6zWf1JmQM5zK/Mj3G8trdjkfsRWl8hV0DcbghblRHCpqAjXpaSHJAf9xsFiB9YBX7D4c2ziRRtVwmjVfI97iL4v7hdbawPQahBH0BtEbtcF9E+VhjHEVj9GBZNYi7ZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GznAvISv4pFzGSeu548pViPvbFqorK8VVW/pqvZGJ5k=;
 b=j/G8b9iMcZAU8Q2kF8MaihZMOhJEYHHyNwiD+c0Ar3w/h9HtNGvGsaGn4ok85JipMaUxQ+A+QjqVy5xLLOTCb7/0zjudkeyK9A3iof/s2yTMgFKOx5AzxkYKnPMU7/jbFXbK2E8X+w4atJkWugvZx9CS054B6OIzJQpUj8f1ArGc2nQTqJVNWNYUnPYp/iWH9F+q12/vsTIZimNlOEwN1+cxBm9HqpG/k6AmmhWYylMvEXOw6Xoiz525tM8sIN6EprLgo1DE8sIoH99xduN8QfMxkM/3vH6w2oeaPB/Mnck8xl5dj0hfA63Eo2ES19p2liyIb8nHUCvOemSLDng8bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA4PR04MB9661.eurprd04.prod.outlook.com
 (2603:10a6:102:273::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:23:59 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:23:59 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 02/11] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Mon,  9 Feb 2026 16:24:45 +0800
Message-Id: <20260209082454.2097628-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260209082454.2097628-1-sherry.sun@nxp.com>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: ab300f79-8f3c-4d09-089a-08de67b492ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|1800799024|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C959ahuIwlKbc/IYhHUssa6xvTDqbjcTchp0mfkpg8QyLzOBaoTbSHa8gWpN?=
 =?us-ascii?Q?W64EE5t3+AtRg+/+hcJ5jJLKTA85YAOeo4DftHtt4vgIT+JYyc6huPRlhmd5?=
 =?us-ascii?Q?UpePA2tVqAzUyKTEQ36mrCTEtAE33L87UAxQX4KIAbaUC1ilKI304Lv1Jf21?=
 =?us-ascii?Q?fweJDQaoIPsnIWLelJAXRtPRxHAnUZvZJUQndgOol+6jhWoYkMY8KX/3Iy2q?=
 =?us-ascii?Q?ZWjgsdXXyJAcle/Y0gIhr+ieCVtaTBHfhludF7glan4B00v5QndO0IgqkuBo?=
 =?us-ascii?Q?Uf3iLLW4CPnEN1mOxZny2zY6rY0u31+YsL6O9ns4Nj39ofgDKpORPNixfC7B?=
 =?us-ascii?Q?y1IiZGP1XzAZIER0/4QF7zZxviZwEJ6HPKvsUEIhUxO3Au2GohkY5VDb6I14?=
 =?us-ascii?Q?5ZbwNCWwtDTMKCan8pVPq1Iu1cdgGJEOXxBlxW8F4fgxnlRlX9fXrHqhafaf?=
 =?us-ascii?Q?n3kLqFV6kdqWuGiMLtkKFS4A0MTg4u28UfXGX+IqNK0nPuBfr5ZF3tlrPoDX?=
 =?us-ascii?Q?XW0A5JnrYpFc5747IZyvsg3Pn5PoKd0HhFBpfaVVIspJBxqu2c227XmxGVI+?=
 =?us-ascii?Q?jd6w5aY2FjUIy62rnVmk7NYQa4Dv0J79yzwHWB6VEArnHrpPHuMGpVfWIwRZ?=
 =?us-ascii?Q?AqAsOEuhDSd3Yy8sBoo6uhgFDDeyb8DuXTO6e4/Ebo7KfRb2OXYia+cS+l3y?=
 =?us-ascii?Q?8EPA61zcezHeNSZGgIS91bmXWDI3sMYS3KQZWeiI+QBVNtjL5cPrg8y0N9jG?=
 =?us-ascii?Q?AVMjCL//duMgenss3ip8zlAOX6XcdqgV9czXV+oJYdm9mkEKk5KKzZ9CPDZO?=
 =?us-ascii?Q?NFBv3hpv/PYEx6/zViqPje+za12sFE/ucJUvgNB/1ahsAwdT4aimjYJ/urz1?=
 =?us-ascii?Q?pAgiLwhE1aq5XLmcYfa0+BJTCGApm18pck/+/nJuwM0KqtwoxLrVUbhXMfDO?=
 =?us-ascii?Q?vBpihNv/DJ+pOBn8SjD1vrvz/Fbk2MM8WDV12rqBl7oxLjNurtieZPgT2XkF?=
 =?us-ascii?Q?+D8kquXVnC7vtTMuZhuRJpV/IOZMq63ac2gDe98OzNr4gVXcMRB/zAl49pzN?=
 =?us-ascii?Q?XcWrIGBFE4zNAjghkv5lI2HW+ib5kcG/8PJNQaoh8ofiBVsVhu0usQRZVMYW?=
 =?us-ascii?Q?b8K4K4pZ8NFVZAZT5OEenDDBmzj16qqYur5EZQ0nL6CDgy+G8zrYzOjRzI1G?=
 =?us-ascii?Q?atjB4fLqVfNB72TGF0Lj/5xJ/prAf43hM7DKbNyIpx0HHRKwsO3duPzIjRlQ?=
 =?us-ascii?Q?Sg151TaPptBx59K0x6rcgpodV1BlTSjy2CweEp5gcxnAOla7DlspZQhM/xxz?=
 =?us-ascii?Q?WVKQefBGLjFH3raHZM5Mw+VEkE8yT+QS9RxNQeVFLmIbMujmM/2R2r0IPjHU?=
 =?us-ascii?Q?AGAd5c63zGKgddVC4o6BSiNMYU/Pf0cHC4FvwOXVM59y5Jkoj90k2xxDhVml?=
 =?us-ascii?Q?4aX8KP3Ec6AhGI0RIKlBrWv6qFYSR7AZvk44E9bUuVCgOpJFovetmI5unliE?=
 =?us-ascii?Q?ju+v7iaRje5nJ8Pg+93U3HMaUDFpD6q4ayX9RTBFnVvAnsjfSt4aoM63ZL96?=
 =?us-ascii?Q?f0Cz8fsnh4G/Wfa6sh4NXBqGtBpRB5p3QID5vYHlvzsf8/ph0JWDZz53dFlh?=
 =?us-ascii?Q?LZbedetfDh0h453erdtdg2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Dsc5IH1qByyeQFYaYCO15rIWjyAttQJp3Kku99/VM4kN1s1TG7C1NurWSKB?=
 =?us-ascii?Q?EbFoFdLT1br+ww0iRwWZDa5QhNhZYc+CRKVRA/7v3knFb5RSSUbQtXHWSbZD?=
 =?us-ascii?Q?CrJSiWve0hAtPU1wljB7/uTLu5C/NoYG6OlMkfBnN/VhIadmSTDr03mkGU5Y?=
 =?us-ascii?Q?IKq3NzlqR8TFAJ0kchjFv7LCId6jQaSARSzQWWNYEog8rNjW3eu/0mKmSsFG?=
 =?us-ascii?Q?C6LmChh0oWfD+NvvbuATVH/Y0HZQCv3Wh8YPcuk31pJSgM3wqNeI710K68Uq?=
 =?us-ascii?Q?VIbxMwk6oFceljxXJlpV7uZp9BiLflbmfJk7rGrX/3N25pidvFVDAV4LnjD8?=
 =?us-ascii?Q?AnOkcPH28R4PCfApMOB4SKT90LdT5fn3hcKhqjA8s49HO9Ju/D+lgSluvKEl?=
 =?us-ascii?Q?L1gV3af3ewJEWWjCUQRKYXP8WnV3xoApO3j+EI8v/E0ycXViFFqZfhly+qu7?=
 =?us-ascii?Q?imNQ6IXN77BMX/gFALsfRychWY+2e6djhJR4Dfbn2wpM8TENcj7IgcoUEnh6?=
 =?us-ascii?Q?0oSU8dD0mG4+/Ftw5SRK1NRAD86yCk9wnB3yif+BSF0bV9y+9ha6ZfWUfKMr?=
 =?us-ascii?Q?4Wls8vSwsghocoO1nOkt4xMg8dOWAEwJcFyVaXfCSlxOTy5MXFArNRaqZplI?=
 =?us-ascii?Q?zGT2c7E0i6AWpeZKQ5NRJs+WwYbtN0n0au0DJuDG7hgmZaoTrH/PDUgG44lc?=
 =?us-ascii?Q?OFAgloIHdQmTw5mZVABLSHgWVpFr+3n0P1P0Tqhf3s99S47kIMz/WGGfZO66?=
 =?us-ascii?Q?hQi6Vyv2GqdVn8JpfJJAVUrmoJOmXF7w0ZMeDAucvPZWaAQQ3vOwy8XKr/VQ?=
 =?us-ascii?Q?LLJ/7p7r9bLyaWOyUNQRhGQbnvf0jgP+MqnRbI2HcOZhgeg5EAVD9kI2jb/q?=
 =?us-ascii?Q?X0GVxctaBEkTRxTsSELiSOWowOKI/w4+L53rO+2vwnKJiYvwwLwMk+6OweN7?=
 =?us-ascii?Q?joko+XgodGgoaNPlmOYI0Fx475iqJYfZFiGq4QQ18p0knd5jEvui9uTbf/vp?=
 =?us-ascii?Q?j02x37kqoV6vv3X6HpgzOCjZuXjrAy7r5oAo13JkhOotJOL67iPCCAVRKu2M?=
 =?us-ascii?Q?1tSarJ7fZOSR02pFLPI7+PhiF7OW6C3gNV2hEl1jx0jvVCWYkrn1w574GODN?=
 =?us-ascii?Q?LnK2JU+WGjYdTBn4QYl4aFRM/V9+k8V5kHLXCsXIThcaxj7QNBEj40B1epo2?=
 =?us-ascii?Q?gpi2H4ZBM3GIeCSAe6Oo9taWCQ43OtYvoYs4k2LnV2uyvwWiGoq5s7y0w7pw?=
 =?us-ascii?Q?ziucyJvVs4EnTJqKII2jm/iZBavRbuz6aBnIJgJR83ZMRIrjQCjz89YalJoN?=
 =?us-ascii?Q?9nWYAO5KwVc7OCRK1Mrn435JNEzLf8GjEeUXiDnqweVe/FiNvAGnRFXQW+tV?=
 =?us-ascii?Q?9WTKYwAqGLcDQpmGLqk2SP8dTPs+hqCeoZIiVehVhQRR9l0EMbyrLXVF3J0M?=
 =?us-ascii?Q?daqmS75aFwwMmFdjIs5NYQzD/RJqe9Q3NythuuwSiyis/QXebsIl3oGBi2rA?=
 =?us-ascii?Q?3EfEejqI/g54YJxWM5iF7Pl6J6IfgoYNsKOwXh+RTrXsjDwdGSOI+ja7uDHu?=
 =?us-ascii?Q?hm1C3qS3jBchGRGDE3ZUfe3Ba6FayegyZEkXj8U1mBJj2N/T/aQFEIpLhXJi?=
 =?us-ascii?Q?lOtoaBquY4Yp52pZD6Yq3SKl3bnwzKxM6S4WR432hNgTq4Xdly+Y3PX84AHL?=
 =?us-ascii?Q?8wczGBUkyCU7XT4O/cFdtb1AAfigLXPDmjOKJnu26nPBe0S+eYYRnmSg+zAI?=
 =?us-ascii?Q?LFNs5SmKhg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab300f79-8f3c-4d09-089a-08de67b492ea
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:23:59.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubxqh1sVuSOzIFbmaJ1qko5OOZAElVa2p4FiM3Xgg78PKhjvOCNy06L1e97+tbMj8HNpKTNRD42akTZg6G123A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

Introduce generic helper functions to parse Root Port device tree nodes
and extract common properties like reset GPIOs. This allows multiple
PCI host controller drivers to share the same parsing logic.

Define struct pci_host_port to hold common Root Port properties and add
pci_host_common_parse_ports() to parse Root Port nodes from device tree,
pci_host_common_delete_ports() to cleanup the port lists.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/pci-host-common.c | 75 ++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h | 17 ++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index c473e7c03bac..287e92df0092 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -17,6 +18,80 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_host_common_delete_ports - Cleanup function for port list
+ * @data: Pointer to the port list head
+ */
+void pci_host_common_delete_ports(void *data)
+{
+	struct list_head *ports = data;
+	struct pci_host_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, ports, list)
+		list_del(&port->list);
+}
+EXPORT_SYMBOL_GPL(pci_host_common_delete_ports);
+
+/**
+ * pci_host_common_parse_port - Parse a single Root Port node
+ * @dev: Device pointer
+ * @node: Device tree node of the Root Port
+ * @ports: List head to add the parsed port to
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+static int pci_host_common_parse_port(struct device *dev,
+				      struct device_node *node,
+				      struct list_head *ports)
+{
+	struct pci_host_port *port;
+	struct gpio_desc *reset;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
+				      "reset", GPIOD_OUT_HIGH, "PERST#");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, ports);
+
+	return 0;
+}
+
+/**
+ * pci_host_common_parse_ports - Parse Root Port nodes from device tree
+ * @dev: Device pointer
+ * @ports: List head to store parsed ports
+ *
+ * This function iterates through child nodes of the host bridge and parses
+ * Root Port properties (currently only reset GPIO).
+ *
+ * Returns: 0 on success, -ENOENT if no ports found, other negative error codes
+ * on failure
+ */
+int pci_host_common_parse_ports(struct device *dev, struct list_head *ports)
+{
+	int ret = -ENOENT;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
+		ret = pci_host_common_parse_port(dev, of_port, ports);
+		if (ret) {
+			pci_host_common_delete_ports(ports);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_host_common_parse_ports);
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index b5075d4bd7eb..2c8df230886f 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -12,6 +12,23 @@
 
 struct pci_ecam_ops;
 
+/**
+ * struct pci_host_port - Generic Root Port properties
+ * @list: List node for linking multiple ports
+ * @reset: GPIO descriptor for PERST# signal
+ *
+ * This structure contains common properties that can be parsed from
+ * Root Port device tree nodes.
+ */
+struct pci_host_port {
+	struct list_head	list;
+	struct gpio_desc	*reset;
+};
+
+void pci_host_common_delete_ports(void *data);
+int pci_host_common_parse_ports(struct device *dev,
+				struct list_head *ports);
+
 int pci_host_common_probe(struct platform_device *pdev);
 int pci_host_common_init(struct platform_device *pdev,
 			 struct pci_host_bridge *bridge,
-- 
2.37.1

