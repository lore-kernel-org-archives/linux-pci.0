Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020126.outbound.protection.outlook.com [52.101.229.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB5358367;
	Sat, 19 Sep 2026 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789838435; cv=fail; b=ZjtcPQfnCwBYe2bUDt03XOjjJk+KXFvDKNGKaV8BfWUCxfdw2sf2+UJyYCoSuocKy/z+5hBw+LrMuxRpkur24smdED7lstapHyd+eTIK3DrwLQJeHlMXkCkgyJ7B78AHDqJkJDbuH35qmFCRZcpp/rWQO1SatfweLVWk35CcoVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789838435; c=relaxed/simple;
	bh=pjppAxlzi8bVJwTESsOQqLgsXt1APh3OzYxP3pe5hBA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZZLCyK6SydOvQG4a+cGuALd+5vQId5Xb4gA0BejPSKsNEcKiJ+hN0PLvh8koOInlQiwWsU58K/mlUsKl9d1osIL823uMPQ7FUOU6QIUQisg2ddWU9BdR6iTNpRXBi2vusXZWkGAyNpicJ67M2xXORfIwBIkFUs2OkKEqd6xUoa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=W8IjP0Cu; arc=fail smtp.client-ip=52.101.229.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="W8IjP0Cu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROTNZYrijXafvfqprISrMPGg+ISCIy8x5BiNykgcbwVxmCnMiQGFM23qUV9Oo7RLvjfatEtSK1uFqYU1xlsM2JkanO8MSzbxGwVlCZbosaUY4pgEK/cqrp0JHwdWcWEZPubYw7vXh3KIDjTjRt9YoRIEAxg/O+D6h0fP1SiVBoitHY/WLPD22omoVXqH7gme2PKff59pH3j6imdJDiIeLIUAHXhpI1DLoqWzcoQ1ufmnnryMUPCq/zEPwq6kd7bXGp5ESGVVw5z5+eAvngrYVN9LEW1IcGCx1+T1qG1BOU8Oi8DYa9KXQ1A0cZDiL8IttWy7uYMugEDwYegdwf3gbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/VeX5eT6DDVXFc0MYYc3EAn7jXyXssBx6mqouFXBGU=;
 b=cH1uJE7e1xuGg4r3TGwWio+frl90HQNNJYyBHetmzS1we/bBUrcEYjkVgQoZOq+RswfIIDTbjWev8eJ2mgng/5k0tkPXbkS5w5bk9VLEmtnOOzuZ7fZOc1GRn3lVOn1kpy7kaeiK4CTUgAwHSUsnTh7/uHvNcCJSMAG7b0uwwWDh70sjSukcUp7azU+68k8qZT5FE3zQY3Q1Hr/LgeO0ab2NPRW/O7EtYADDQXh8S8FlDpjPtG+HeP/gtpQfQ5/25ZthsxY0IfCorLPbDf+F/Q2EgVNUuOVbvHmvMDCcehFsfIIcxJAaqAjQNaEdUnB7ErEDV1f0SkN/TyFpZKunsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/VeX5eT6DDVXFc0MYYc3EAn7jXyXssBx6mqouFXBGU=;
 b=W8IjP0Cu5nvwwRbxyTKq7d4m2agQ9dVlPLYKrYRto8EZepTyb51G3DmMDa5sE/8eSD4l48nt6TCWP85t3izdcw+hjA4slsXpaZ9DNb6eSAvYsSh0KXWmt8YIhB2v/SrOBrhus+h9TAqY5k108gJkEm2P76dKp/Lofml9nufoX8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB2856.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 17:20:28 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 17:20:28 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Date: Sun, 20 Sep 2026 02:20:21 +0900
Message-ID: <20260919172021.1055451-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB2856:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d76dc97-102c-4f0c-df79-08df16724ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	RnSxp+RGmMQUfgApPZsnIzczq9ZU76Der/1jiyss8oGL29JufHJZTFpLtkI2Uym4Ihh/X5ikammVSgrVTbh+yabf0DDJx76SN/plIOXS0rjMC0yfFbsTb+W/bSZ6lXihZwUC+IA6RyzvABMvrZ00Jkw1bDcLFA9kOCnedjkbDjYTDQqPXLUkwQiVO4h1CJtiRNZ+dSVaBa0/jZxDhsS2TNQF3pdQaHqVO2OIUhhHDALjj8SQRLwV3xK+lO1a0V8eMg6+dYFJnPkGJMc6OrAOGxEvL5uFaO4l4MZzX9n0acv4D9/MGNhtu/F+A2IAJcf+9Qbq9SdUyJ36qBHE2hV2kt70lGXndgizckUkhhT9Q4pwh7iCGUbCVvHG6MDBMZfooN02O7NTz8NXM6vxp0oFAlqiv0dAW0PuOWYpKGyyGSu5pwx2C7IBR0ojnPHwhGqW2enIqDcWdozMP7sthqAsSEQVFXyngFvepc0G6VAz77odTfx8b0Fbm5RoTsKjiNj8O87FklMNaI9cDFWBbt/jNj4S5+NrK5q/2EMyne1CCxduBx3XfKpAklFMjtNqt0c4F3h9ZzP4HwM39jNzjLhQHeTrQDzYLTP3VkZ6oZWLM8BgkCUJD04bCD4XxMcAWeNl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QDOA46tgwLqcyuSJstj+T50LxGdQpTnzUJLSPEkVXamESGzs9cOh0Qhgy4DJ?=
 =?us-ascii?Q?nQ46UIrPnZa1JXIczCXBZBd0YYnePZ3i8nP6iCfG5YY3UJpik4MxjV9BI9Hy?=
 =?us-ascii?Q?SpRC12kJCzhrEfTljFtj3qxLinFoK88R9723DAssO+tUfaA1xKJ+lpZcwnuA?=
 =?us-ascii?Q?pzi0gK172040qNisq3uFNudYURTogzd5hJ1PRf3MMeOEb7D48zTEL2lYASOx?=
 =?us-ascii?Q?0ZVtZ4S3tsvLxfty07rmmCk9ECqwY7KfSl50zcS6JjFRLJRD1r3OLbMj/ksC?=
 =?us-ascii?Q?YI35EqAxueHCbpRHEgm11Cw6CQoTKpFXl57JYMDvhTNqKJtMdfJbsmIJBW1i?=
 =?us-ascii?Q?92wmukqO9QmjYBwK9k3LmEDtwCntqR9NqWA08CglfS1QJVPIU1QnRZM/cavj?=
 =?us-ascii?Q?WbaX9ljlI4XnTmVB4v/if3Jp8RNzYBXWhjjM1FImBZrlr++/FxbSQUsF/yv1?=
 =?us-ascii?Q?qMZ95YGKQNV8ID4U7k8eTbdq0LJLlnbMJp1s9bCiYodt3cnPmj78v49qwg6g?=
 =?us-ascii?Q?0+8ZHr4tAtrK2PwyMGLODjOZfmp5K23Q+n/wpkwqK2LQBUOMpWlUnMN2V+sO?=
 =?us-ascii?Q?Ov+qS2GrvyFzbJ8aLvkYdJJ9cEJ1Awb2KnYpL6bl0aLkUlqDNjs9NWVHhUtM?=
 =?us-ascii?Q?IwgV/oG7sOBETSGllO+R983JElDUvDhJYYqlcpKLHMdkvikO+uALV7yt0TEW?=
 =?us-ascii?Q?W8NYmmOpubSu7esZ0uma6ksWEdhi/h9R4x7Zl+NcV68Vb7IUY8pswmYz0VGy?=
 =?us-ascii?Q?Z7jR/t/yHtdTkqIBK959CeUBK3tLtXMCOd6L6ufyKV8x7+S3AQzzwH0/DRwr?=
 =?us-ascii?Q?qauUn44MH3ErFncssoxi4MvWVUMYvbDtfpo4/YIg07z1c8rxEeExYvapFvFk?=
 =?us-ascii?Q?y9vUiRYf+8ogs6/5PqmiT3sD7q73LbIEBgQwoSQv2WJzbpX7T6TRm+90zPxP?=
 =?us-ascii?Q?YnzlJr6ZSYHxNrAEZP9B0HWMgFV25WHP95SDSsDMKJF2PD8vVsVgnr5ahb2V?=
 =?us-ascii?Q?FgV5EOUAicYUS/ol7wcn7S+38TUtVrNru2yCNLk1udp3RPeOvfgyFYciRV8u?=
 =?us-ascii?Q?ZazeGJojkjY4ORfZf3DDvjvQck6Emt/3FfCXYnheLpdOecvAJBQjtyuEmIvM?=
 =?us-ascii?Q?q08jRhB6x4Go8KD6GkB2Ng6hLKbRplyhQltOlsQiMvfjrjpEp/9/Yq1EPhyk?=
 =?us-ascii?Q?LvG5LqXlG46rPBSevjeq3sL46j24loTL8IbMIhhoKinugfkq8/Jc0mLTH9oJ?=
 =?us-ascii?Q?n2oH+bmTgkeP04EXfIC6REzjJYrF4kzBrIu4ylYYQt+qmtNKPmfFqr+0Ylyp?=
 =?us-ascii?Q?vab+ghKkkZIwp3z7aj+OUm+x6iizXU8OCe8sJY/UeKvO8fX1iBw5TAIr7Gyb?=
 =?us-ascii?Q?wND8XJZ0VSns4O3Siq2RWZBFiiMp7pfAQ2/15bLiwZr2ldX38bLKS4+ltFmN?=
 =?us-ascii?Q?iaczbeSIHf0aNoZOXSB91UpmQiYoD6BBP3PB9LshysLuiHGSjcJk8Sq3KxQH?=
 =?us-ascii?Q?N2B7K2oxp4Wj5LzcPoX9kIW2CtxGpdNmUeqj8k9THYK+sigoAkG56vk/kplu?=
 =?us-ascii?Q?hBRxOQV6BxePz1PcWQAsItsQ+QOziKcN1ImfYDSxAyAV0qgnxvQbC9UfdtqQ?=
 =?us-ascii?Q?ApKScHph+IkJw3AtLU0NLX/WLKL42BfgUm1vX8YjckgnAeQYHh4Pn0pMOcIs?=
 =?us-ascii?Q?xj6crVoGTOpyWxlkoZNl7rzlMr5EPXIqbeL2ej1ivHrn1k/Ze9JInl0sRXeO?=
 =?us-ascii?Q?5eqKVejIb5Pu4J5xY6tzG66IRNdGDcCFNtHl++9OChcKUX6/TDDQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d76dc97-102c-4f0c-df79-08df16724ccc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 17:20:28.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8NnA+iaibmkQAyb/HUfd1ncFIXYLRF+ARovJ3Nxy8I2mZOeF8D2dWRiT0Qsw3N1XLAkoKnwBKPYlBPqMyWdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2856

ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
configures only MSI, and always raises peer doorbells with PCI_IRQ_MSI.
When MSI-X is selected, the host does not program MSI, so raising it can
issue a write to an invalid address. This was observed as IOMMU faults
on the RC, with no doorbell interrupts delivered.

Configure MSI-X when supported and use the selected type for peer
doorbells. Allocate the MSI-X Table and PBA in the config BAR and
configure db_count entries. Use this EPF-owned layout even if the EPC
has fixed, hardware-owned Table/PBA regions, as pci-epf-test and
nvmet-pci-epf already do.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Split out the vNTB MSI-X fix and use an EPF-owned layout. (Niklas)
    Niklas and I both hit an issue with hardware-owned MSI-X on RK3588:
    https://lore.kernel.org/r/mmcripxdekhktnn73ikylthajkdnincwu7p2nelcpcqzexpf22@rrmmzr6hfvzf/

v2: https://lore.kernel.org/r/20260830151948.3547577-4-den@valinux.co.jp/

@Frank, I did not carry over your R-b tag due to the change. I'm sending
this minimal fix separately so we can fix vNTB raising MSI when the host
selected MSI-X, without waiting for the RK3588 issue to be resolved.
Please take another look, thanks.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 54 +++++++++++++------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 07ba338732d4..2f6f3da1d73f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -148,6 +148,7 @@ struct epf_ntb {
 	u16 vntb_vid;
 
 	bool linkup;
+	bool peer_msix;
 
 	/*
 	 * True when doorbells are interrupt-driven (MSI or embedded), false
@@ -155,6 +156,7 @@ struct epf_ntb {
 	 */
 	bool msi_doorbell;
 	u32 spad_size;
+	u32 msix_table_offset;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
@@ -308,6 +310,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	switch (command) {
 	case COMMAND_CONFIGURE_DOORBELL:
+		ntb->peer_msix = argument & MSIX_ENABLE;
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_TEARDOWN_DOORBELL:
@@ -451,8 +454,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Allocate the Local Memory mentioned in the above diagram. The size of
- * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
- * is obtained from "spad-count" configfs entry.
+ * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
+ * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
+ * from "spad-count" configfs entry.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
@@ -473,6 +477,12 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	spad_count = ntb->spad_count;
 
 	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	if (epc_features->msix_capable) {
+		ntb->msix_table_offset = ALIGN(ctrl_size, 8);
+		ctrl_size = ntb->msix_table_offset +
+			    ntb->db_count * PCI_MSIX_ENTRY_SIZE +
+			    BITS_TO_U64(ntb->db_count) * sizeof(u64);
+	}
 	spad_size = 2 * spad_count * sizeof(u32);
 
 	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
@@ -513,12 +523,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
+	struct pci_epf *epf = ntb->epf;
 	struct device *dev;
 	int ret;
 
-	dev = &ntb->epf->dev;
+	dev = &epf->dev;
 
-	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no,
+					    epf->vfunc_no);
 
 	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
 		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
@@ -532,16 +544,24 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	}
 
 	if (epc_features->msi_capable) {
-		ret = pci_epc_set_msi(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      16);
+		ret = pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);
 		if (ret) {
 			dev_err(dev, "MSI configuration failed\n");
 			return ret;
 		}
 	}
 
+	if (epc_features->msix_capable) {
+		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
+				       ntb->db_count,
+				       ntb->epf_ntb_bar[BAR_CONFIG],
+				       ntb->msix_table_offset);
+		if (ret) {
+			dev_err(dev, "MSI-X configuration failed\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -1529,6 +1549,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
 	struct pci_epf *epf = ntb->epf;
 	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
+	unsigned int irq_type;
 	u8 func_no, vfunc_no;
 	unsigned int db_bit;
 	u32 interrupt_num;
@@ -1540,6 +1561,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 	func_no = epf->func_no;
 	vfunc_no = epf->vfunc_no;
+	irq_type = ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 
 	/*
 	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
@@ -1553,16 +1575,16 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 		while (db_bits) {
 			/*
-			 * pci_epc_raise_irq() for MSI expects a 1-based
-			 * interrupt number. The first usable doorbell starts
-			 * at EPF_IRQ_DB_START in the legacy slot layout.
+			 * pci_epc_raise_irq() expects a 1-based interrupt
+			 * number for MSI and MSI-X. The first usable doorbell
+			 * starts at EPF_IRQ_DB_START in the legacy slot layout.
 			 *
 			 * Legacy mapping (kept for compatibility):
 			 *
-			 *   MSI #1 : link event (reserved)
-			 *   MSI #2 : unused (historical offset)
-			 *   MSI #3 : doorbell bit 0 (DB#0)
-			 *   MSI #4 : doorbell bit 1 (DB#1)
+			 *   IRQ #1 : link event (reserved)
+			 *   IRQ #2 : unused (historical offset)
+			 *   IRQ #3 : doorbell bit 0 (DB#0)
+			 *   IRQ #4 : doorbell bit 1 (DB#1)
 			 *   ...
 			 *
 			 * Do not change this mapping to avoid breaking
@@ -1573,7 +1595,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 			db_bits &= ~BIT_ULL(db_bit);
 
 			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
-						PCI_IRQ_MSI, interrupt_num);
+						irq_type, interrupt_num);
 			if (ret)
 				dev_err(&epf->dev,
 					"Failed to raise IRQ for interrupt_num %u: %d\n",

base-commit: 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932
-- 
2.51.0

