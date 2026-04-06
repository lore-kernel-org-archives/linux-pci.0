Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9B33688E;
	Mon,  6 Apr 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491050; cv=fail; b=USbNS33/EZzqbETblaEOxljmW/CCoxsH3MrD3onVT9nFB4670r3esiug248evzrXrljxXRrwHDBOdxwHTYPBNQXz9hmXvFB20zITj2jMWSv2wx8EPtzZRq6PHhzGACfFJqGGnkOYSoG2C2kUE/mPzw0qZwqzr/TGx035PVkqvCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491050; c=relaxed/simple;
	bh=ZHfSoTilucSBMKXbC+oDyKYA+h0/PEx9E/CmbMydi6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmEcaRfrpBHEITdlB57+j9DbUvzZE3LFOMAohkvt79S2ONg4cNPo8O6mnQ+zU3RoTApGdwiQHMWsMsMeJtTxvORFE+dE/Tz8nVcBb2WFpLctqm92uvVuvNkVcGDIjDtpMP8004w9C84owxJ17J708RZYlROINkrkrz8qv9EF1to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MIBRLvia; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MIBRLvia"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfs9SM+HVDxaO6OtJmKbGD0uNa5Byv1HnR3P9aq2k9FIFxOCPVSRc6Q5OchMo1ckNr8DKf/DNNGkRTedlDfR0fVQSdgGOhgIs5lsEWkq+V0G3sVRvca24Xrv+AWWWGZ5C/Wl05+er0OybKvkWUj0Y/F/tcMHKP1Rxw/MuR6zxZkYdcVlNbbRKKRT0bj5LC+PlrjHoAjlI9F9HX1Mu4vOpwhwTh7zKt+JYOAGn1ziCwFud25lgeN1/hUU7Tv/DOR287A2nEhu5+LmJwj9iKfPxvzyictQ902nQR9Jjdb89mX5QbWXHu4xps0ioz486neWsW3yobpzVluojwmecpYoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+YcyJrVo9PcebSFe1ize+OnskN6MubzU5t/jCWFzdE=;
 b=uff4wxGY9w0lTiekRGDPhKecKu3s3BFdqX11pxEe+MOk3sApA8+HzjIMM44r+0VXQLkrIF7X5dc3gAwyWNbm0kI/y+xSQQ8WysHdS+M71fnQ8kn3JK4uxLs3c8VYu5inH15Lvk90a4DmKaKF0cdlvvvRB6V9AOUX1XyBzo0sD+vX/MuoV9plvged87MMccQ7Q2al6PaY1Wu6KO/PGt+sJ7oGmz1JnTrxDCeHGrKN/TUuiQyMoXTQ9WXLkUvKFzflVoY/gadWRpriVvzIRUsbYmq8JOCH/G/LVPOX91XQYTUU+nRR4aD4jVJHRINsAhMm7vujFxXNTNoq8qxJBhPprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+YcyJrVo9PcebSFe1ize+OnskN6MubzU5t/jCWFzdE=;
 b=MIBRLviaCd0lSnxkc+aRBsPH/i2WfVN4435m54CQkgl9VlCyktAshl5Cv7OTAOgswnEMmGvhYa/Zeem5RZ6pxScP8fLYrdozyJO1ZRQcNkuxzw/2UfBE/fIj+fd/ulnNKMYNrJffee6rVEhVdL5osh3IyfhgzXI/MLQy7i1TYEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4187.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 15:57:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 15:57:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v13 3/7] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
Date: Tue,  7 Apr 2026 00:57:13 +0900
Message-ID: <20260406155717.880246-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406155717.880246-1-den@valinux.co.jp>
References: <20260406155717.880246-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 42edc950-ab05-4642-532d-08de93f53191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	WFvNKLjNWKn3O1Y3JW5lr+5XK0E+5zMpdISBEL4OmlMfe0oyEK3PmJtYEQcJkpvPjcCtceQrJauZDTRtzWLQm7D69alxDgbTUPS03N4vPEnkbQ3SY5EYEP5SeBaKjWIQQ43BFDJSqgX+RChb9MysZVTlS3FQ9aLIexRgMrmuDkMpMteLfPUh4lj31vPvzQxB4j+ltluBnIgn+U3V5Dam+cCfLI8qbrNEigr20zXf4ZaKXa8shJFT/obM121hH5c4RgHSjB8ETLHwY0pn7QzGjHGVXp2dGqUGoh7YCrYZoON6mRfMh8780zGa1e5GO4AnC0lhpkCYbhUU0Oog2U/Nij7M3AwCVjyZe3l5ESYTF0Yi8+uZtzDvFIsuvexvoLZ6FJiGcQ1ofTzWoDHUhDKTKvAsVYxhJXppNY1kDkRaftXu6cVkVYWycpZgXxKa/7jWraZLEtCt5xrLyF+wJFcOzaQMUOzCD4rgA4avoXbjUHD79mwhtOzI5vDzL9uzhzzc28KadabVP6t57YuQL7BcJ8es62VA1mUQkCxHc/VfQzu9JY/1zr6y34e7W2H4cZtR9eRwyZSeiAfPTiAZFqFwxcGfEZt1sz3pDyQpY6CGsr+sv8oZuCco7es1svBIOPx0Y0wPti+y/Kn/Zv3EB2I8armLIiINZZzNWDh3TkMgAodqbSVznvI1NMrG7U5fB5JrBsWzSwiNZd4udIhPyX4lSE1w2rKXg3KM4B0JMFYIQESzcWhQWzBSrjC7Kue7dNc14d/FrTusm5DkZIgfDplyJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YRlOqULppJUCvw3UdaLqqdDmlBmpivrJ5Y42T8N6ibGK4etxgMbp9SoCgP2m?=
 =?us-ascii?Q?jIPa05URO/LxzbEJZB9UTsB0UusUHh8kcqEznnwG4Olur9tzInmWWvl5Tcqs?=
 =?us-ascii?Q?Z+vR/C0oD8CjfK59vD+xOdIBCf0esFUe4ttKLi7DOnF+c6g71je1LpLawCvh?=
 =?us-ascii?Q?c3edeFto2WNWVPlDZcuk3pM36pwXnIDfWWwPMa/zKCi9gk5hTKiD6mC5N3WP?=
 =?us-ascii?Q?wvib7qUbGcA+JcERkGLHyWpKH2URr8cnIAmNc83WYND8cqBO3BiEBQXzcI0j?=
 =?us-ascii?Q?FqFtuKMKfqYoreGnSYoqxABhsJQ+0VhkIki38A9R6SnKF2UNWjm17LU8NHkx?=
 =?us-ascii?Q?rVRuzg1CCBGCcLy/cJnXG8GHsazUeLquafQuP4sMLqvX0I9+GuVnzJFKDIaU?=
 =?us-ascii?Q?GV+0w91VoeRfqaxvBSfKyNzAdNPaBcp9lq5Jy1NuKM8egz36pF+aM26QyNAF?=
 =?us-ascii?Q?PNnaTeO84zIvtNwDAOwQhuMvNKQ2beuKM20YYMSzuLH2idOyKzwFCfwg8s/L?=
 =?us-ascii?Q?C1WnARurDtOdl/SerGw4zreFSDr2XdTBRZpSMVCMNoJeSA+J6e7u62FCAz9y?=
 =?us-ascii?Q?eVQVta5LL5qGENYQFcJ6r/yFhB3vplEN8LbAlveKw36kcB41UCzCPLTo8zS3?=
 =?us-ascii?Q?lshEJIkaNRc3RwFyl0Vet+r7bJIZiSecPSncfKPA0KBBZP2yBogX8cidyFBJ?=
 =?us-ascii?Q?ipyrWh6lOo7FL0maZu0CAZxz1Md4QOKxFEQ+rRBq0rUbC0mGXikfXNvG/azR?=
 =?us-ascii?Q?j+6Ca43Tybj+jiG16BNAmt89cFU2O+YKV4CndOgVeFik0i6iC+TyQoKWh5JO?=
 =?us-ascii?Q?HbPzHgsYhYRKrNoE1LFlWTjR8C9cH3LCiy4gYTxgdQgJZPVFXJw+qlqAJPXT?=
 =?us-ascii?Q?RPp/PbfeXM26n1V92s9dvhc8FvdiTHYRI+3YGsr+PPAk14OVoqzKzEWptPDV?=
 =?us-ascii?Q?iGR+kF6OAgu3+W6Z3CH38azNr54Y9DboTduFVqpSTG5MgCUDNIysRgXx4VQ/?=
 =?us-ascii?Q?VWnIWhYE3K9FQO4Qz0haqj/3Geo4S5WJjEjjFkppLV1Qb5GZ2Yu/uCED5E83?=
 =?us-ascii?Q?2rFX2J+QMYOdnj1zXJVEC7/6BgWAK61kk3cc9uwOYWSCgtTgEAXOtbbRWxaR?=
 =?us-ascii?Q?0PEsQCnh7/GLxQWJosaTpKX02FiqLbMZOYvhjFdZeZhCv+NyR/ksOPJRrrnz?=
 =?us-ascii?Q?gQOw3yamerZSil0ubHFJotoj71X1VRp2vGxjkAZbHSK+x9igPQw875ydXFa5?=
 =?us-ascii?Q?YFiajIw89yHDBQzyAgXyOVgNOJGMQlsYe2HtgaK0LxErz51vv1ZJkBgd+sAL?=
 =?us-ascii?Q?+STf06tjIj2cekVKCmfvDd9FL2zxre1/HSVXKjr6Nbdh4bVGlH9RurVzLqGG?=
 =?us-ascii?Q?HRndG3RV9UXxm1yLqSO24DH2xOJ0pYdgx5zLb47S//6QlN3v72BFAbY172Ql?=
 =?us-ascii?Q?OcQnARiv7wC41Q1ZDHXfCfYWytg11H1gnM8SHrxfb1h1JB5wJhh6RHOflWmG?=
 =?us-ascii?Q?GTpywQIgsTZujtZ9lLYLnqVCMdFLIBE/p6wOHS3mK5f1z3D9kpurqWsaRyce?=
 =?us-ascii?Q?IIYZHVpqqswGlZABKjDA0d2FWYzAyYvyqlaWMFVIzNPKcIVyElsIJAA+tjp/?=
 =?us-ascii?Q?/1JMhJsr5qLEpQ6MLXaopW57sqnBRTG9hfpHtdOLhqk4RrSGr2pWPndG62b3?=
 =?us-ascii?Q?3YRH+U2yF+ObhoJQBrXrUPudt2imikYc20rmclBVG+NYygOFu12SCuCwEkJd?=
 =?us-ascii?Q?96dI+gs7YivZdJzyEvoXmStS+GOzOJo7NMKV2R0Hp7quaUCpR1cc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 42edc950-ab05-4642-532d-08de93f53191
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:57:24.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZZiVPYjWWWyQDgxk/JJrqcUorIKp38TkevwgZ1eas6gzLtpOfe46cR/4hHJQUe3NjXH5Qqm0UiOpbYo8XaHXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4187

Implement the EPC aux-resource API for DesignWare endpoint controllers
with integrated eDMA.

Currently, only report an interrupt-emulation doorbell register
(PCI_EPC_AUX_DOORBELL_MMIO), including its Linux IRQ and the write data
needed to trigger the interrupt.

If the DMA controller MMIO window is already exposed via a
platform-owned fixed BAR subregion, also provide the BAR number and
offset so EPF drivers can reuse it without reprogramming the BAR.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v13:
  - Updated to use the revised direct-count aux-resource API.

 .../pci/controller/dwc/pcie-designware-ep.c   | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 386bfb7b2bf6..c3c354265307 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -817,6 +818,122 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static const struct pci_epc_bar_rsvd_region *
+dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
+				enum pci_epc_bar_rsvd_region_type type,
+				enum pci_barno *bar,
+				resource_size_t *bar_offset)
+{
+	const struct pci_epc_features *features;
+	const struct pci_epc_bar_desc *bar_desc;
+	const struct pci_epc_bar_rsvd_region *r;
+	int i, j;
+
+	if (!ep->ops->get_features)
+		return NULL;
+
+	features = ep->ops->get_features(ep);
+	if (!features)
+		return NULL;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		bar_desc = &features->bar[i];
+
+		if (!bar_desc->nr_rsvd_regions || !bar_desc->rsvd_regions)
+			continue;
+
+		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
+			r = &bar_desc->rsvd_regions[j];
+
+			if (r->type != type)
+				continue;
+
+			if (bar)
+				*bar = i;
+			if (bar_offset)
+				*bar_offset = r->offset;
+			return r;
+		}
+	}
+
+	return NULL;
+}
+
+static int
+dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
+				   u8 vfunc_no)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	if (edma->db_offset == ~0)
+		return 0;
+
+	return 1;
+}
+
+static int
+dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			     struct pci_epc_aux_resource *resources,
+			     int num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	const struct pci_epc_bar_rsvd_region *rsvd;
+	struct dw_edma_chip *edma = &pci->edma;
+	enum pci_barno dma_ctrl_bar = NO_BAR;
+	resource_size_t db_offset = edma->db_offset;
+	resource_size_t dma_ctrl_bar_offset = 0;
+	resource_size_t dma_reg_size;
+	int count;
+
+	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
+	if (count < 0)
+		return count;
+
+	if (num_resources < count)
+		return -ENOSPC;
+
+	if (!count)
+		return 0;
+
+	dma_reg_size = pci->edma_reg_size;
+
+	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
+					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+					       &dma_ctrl_bar,
+					       &dma_ctrl_bar_offset);
+	if (rsvd && rsvd->size < dma_reg_size)
+		dma_reg_size = rsvd->size;
+
+	/*
+	 * For interrupt-emulation doorbells, report a standalone resource
+	 * instead of bundling it into the DMA controller MMIO resource.
+	 */
+	if (range_end_overflows_t(resource_size_t, db_offset,
+				  sizeof(u32), dma_reg_size))
+		return -EINVAL;
+
+	resources[0] = (struct pci_epc_aux_resource) {
+		.type = PCI_EPC_AUX_DOORBELL_MMIO,
+		.phys_addr = pci->edma_reg_phys + db_offset,
+		.size = sizeof(u32),
+		.bar = dma_ctrl_bar,
+		.bar_offset = dma_ctrl_bar != NO_BAR ?
+				dma_ctrl_bar_offset + db_offset : 0,
+		.u.db_mmio = {
+			.irq = edma->db_irq,
+			.data = 0, /* write 0 to assert */
+		},
+	};
+
+	return 0;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -832,6 +949,8 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
+	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
 };
 
 /**
-- 
2.51.0

