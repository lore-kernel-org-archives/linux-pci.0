Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020078.outbound.protection.outlook.com [52.101.229.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DDB2D97BA;
	Thu, 15 Oct 2026 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028658; cv=fail; b=cvAAVXRM9rapN3dVmk36Hf9VpNeoPZ6CeFcf16JIiMV2v+ZdMZ3iRZWNreww5rLF/vLzcLt9JPzg3TPf8GYA1mQhNeZg7ZokuDTr6dsvDetVVujfkX3FlO+GFX4VkAF5bPuuZdc2etgR64OxuTuI8DwGKXdZ2lCTu25s+xfv2pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028658; c=relaxed/simple;
	bh=z3tmGrMHsAH69HwHmbyEDd3du2OsOh2H+f4kN05s1ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzM3/VMoiPKqMe8xLidklhWLsiRy1+cQma8ZSUOI3+XkYrsFzDx3zM+8ghTDZAox4GFwLDQvy96OIWo/EUHAi3V5aaAjOu3/vKS4cEAb5kqI8cWq7l2Rc4M0loGFBGJm6miNNJGjL8eJ6xv/XwewYmJNsiQtatClY1LpD+vFHE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=auOb/i7q; arc=fail smtp.client-ip=52.101.229.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="auOb/i7q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS/uvBNZLyGFzVmOyV5Exgc/thtRU/BJWj2nzYDlKMEAkMBQuAESMmdxiharjCdn+lQYEG6Dokty7BPgddYZZgkUv4OPmmu0osBVw5agFrbnQozELSUVzxdhqeQrpYwfB9nJS06xW9YqfTk+7rAuCr8xk0mfbC49NLMqpAEbtfkt7tmK2dS/DQCttkJKW4KZ8qAttdx6QDinjaY0hQYL2wePCZYK50jSUmHb8n9KFrq4KF+vrG+EUhj6P60XQJgDpBvzlxcyFVnUhKE5N3b1raxjjKhwGoveYYFlQz1IqOmKa0Ie8AJ6xV6uNtuI2l3fhtnRa/RBsQNagqdDZDlXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R83WpdFSg0cN7UgG/QTXgMmNIiWZ/2MBDBdDMhnR20Y=;
 b=tPnwGzmCnUiNzZpasa5oi+iw1h+z2DTIvlbETXo877dGtqZHNEEWszOrcboubo6GCF+4CHC5iATUeTIpanxL2/NLSx8Kgb0cMQVoNE3x7CAgDqxJennW3ounac7kxVaKN9rZ1Gr58nTIp9sYkmqi6Vy7AEPR42R2DUQFkqWbSgAaRJ5euvGIs9iQcOxDIgOTCDJs6lNVVZ/MV5wBxbU29uULSw/TfQma4Cnpnst2HbNIzgXySIBAZx4ha2qYmmu05EC+TfwI/rjIM1QGuLEAxkkxXD31E6bq93CcvPjJtYXWNN2TdAGwILAOwjcrOkf7QbgPXX+aPz+6GkGV5zzxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R83WpdFSg0cN7UgG/QTXgMmNIiWZ/2MBDBdDMhnR20Y=;
 b=auOb/i7qWrNi5IlPW/Qv0F3zsXWY3MPkDKZ8L+zoSHWMoYpLWs6BpY1G434xVhwt0pB7qBtiLG2K5kvKjBdikZnuSFcHDIO7QOza6X4kl1+bM+TPE5bPVh7u4j+oBGOrXqPpneIcBJowTjuoVESYj6wf1DzRNtA6qNDgejfZoE0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB6125.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:44:13 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:44:13 +0000
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
Subject: [PATCH v5 2/2] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Date: Thu, 15 Oct 2026 10:44:02 +0900
Message-ID: <20261015014402.2976188-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015014402.2976188-1-den@valinux.co.jp>
References: <20261015014402.2976188-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0103.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f9f279-64e4-4e91-a210-08df2a5dcf55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|6133799003|10067099003|22082099003|18002099003|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5NcUJQ+ORi5ztAo0Fsgo4kvC1nVsMDV38oK1KCxKe/SL0d4eRgMbU4xlB42lNfLHzX08Nxufdam7B86OQKUodOu7gVdHdFj/iJvqfz43KzGVK9UxPTect+VtzvGKRmwi62A2I8mXSTaTi8SrQcy79mJJeaqH3fDKyLEJbHLkX1uAfHL2bn9gI1ZBMf1JR3eJVexrG+C89aC7loHzqwzNToRCSgTbhUt/9wPbYfX1RikdaysVF9K7CjixxiG9iUQeGNxJUT3577VqN5lDuAwhBMkycSKX5HGcC9Cyv/1NEx1TwkCLCj7vDalea/9e7udhIsmZ/GUrolGobFP48mpCiL0ttaUPkzWjMi/51YBadLjDRwAuI9RfFQY12s7qsXm7pkndTNPFHgqpbRl/pYL3ZkV4De+GyKGupERJS3teAYqkWohMHSpPWKRxsGRjATMd8zWOXGrYtNR30huSsjo1rsqdrpQ9noYK2rSfmI2sLCWUql/eo66FIB4fksMyYIeyAJuAVcZfUaa4U0M6/EKaYER8S9jooJE1MJ8Db5TXZc96LwYVCjdBQ0/IVmzdLGV8PQhwmP/E0Clkcym0Z9p3wJOVQ3QTHEivgLjcbSipuThBEKnLvVZRxjLf5j6mzGvk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(6133799003)(10067099003)(22082099003)(18002099003)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWC37xEuezjhgcByJ7EN14PqKab2GPkeDC/f66SUKtP4nJws4IkLdnJA3XPv?=
 =?us-ascii?Q?nMrioGvW9/LLNMXAs/lyxpGa96+tsGfNVMIZBTYtoDawFKbJj7VYpcwZ4a0a?=
 =?us-ascii?Q?DWIHPJgPUq2YNRiDZyuG0HxHdFjrNc+guVo1xQMeqXOjeaGygCt8gaC/3TMB?=
 =?us-ascii?Q?0sXyWxqcC0JVPkapf/kF5uWfxSpAvR4Jab/JVeDhfpSgHtgOomIUDhDzIkyN?=
 =?us-ascii?Q?Mk3jIN0uzmOxiqdOQ3q0YYvB0inTuxCns5OOsOeCUj5jj9CQo7ko0FWvTNyJ?=
 =?us-ascii?Q?RqVGoMxqa/iBBvhn5VW0LnZyqe40uAOqrPRb8BbIS0njMrcTpjgkxr3zf9HX?=
 =?us-ascii?Q?aLYdzIgkanlioIn86gJkoDiE9HdoBCwzRWpotHyiqVOuertxg2zRySG56V+i?=
 =?us-ascii?Q?ki9sNYRKNZIa7lvmyQBeY3J7kczFzc4bPgyuh204SaN8b3LvRrh/9F6dk6Yx?=
 =?us-ascii?Q?4FpQ7qZK5+aunpliidCFVBBOey5dkoJ7C7bqq8423CmxCpGWK7GxCDHgYZ5t?=
 =?us-ascii?Q?jhLHDRBb3NhEkDFbB2dBM6KLwW0YdmtjJUdLmpnw1yPpPgp21Q8YecIxt8A5?=
 =?us-ascii?Q?+L6b1KWdpG4Wx4X7mGUIL5fcsNpXlw7F1k0LdlRUcBhJF3+SZH1nG0daQNSW?=
 =?us-ascii?Q?4EYbBtieriKsxxHSPujxgN8gVFICw1YpxvHYTpB+6CJPyOC69P4Q8GltWWCe?=
 =?us-ascii?Q?qr0xEVRSd2qB6myQsWTfxrY3FMDyJRGcMSZupNvuR+fiXwKEuTIXXZx3wbMX?=
 =?us-ascii?Q?XT63OmllWMniUE+7/YCeMYYLzNL92COJAFC4Y3fRxIhEHZ1IzDXQZ/9NZamT?=
 =?us-ascii?Q?SVPQcs9mYiLb6x24CpE8hSaB+y3vuumArwdl9gEZkdK2NJn4UqnQ5yxlneAC?=
 =?us-ascii?Q?SsCUejUC3uKmtVq205Clqym4sXXA07KQc4tAq6Yx9KYSPmDsm3J5ZXQDH8Al?=
 =?us-ascii?Q?weLF8yogt3KlNk8ABh3ylHPXfoR8xLhzLIX7GHZM6zn1xzzhCgfi9WpSNqKb?=
 =?us-ascii?Q?bzG2vGrkahHn/IZ+ytAY0CUYUF3/mMpsvfCtOSHYgBYk4GafciQdZEr5EBEw?=
 =?us-ascii?Q?fgqWmj5L5xj/Yw+Lo6rMLXeKF+X/63+G0mModUkR88qbOzluqiOeJvFsxzOJ?=
 =?us-ascii?Q?7OSrThNclUJUzv5Qawo46b4eRW5shXO5Sze3rm4w2fZz6zubcTAFYtcglCWr?=
 =?us-ascii?Q?zyGg9qtzX2nytVXUZbT7PlzbsXJmRozlENY4JUtCtTgGXTyzF7irZU1SCACB?=
 =?us-ascii?Q?w8iBlelmxFenyUFOwug9ML2gSJ9qcd4VMwnVya92irGk0oK3l5aaGcI04OYw?=
 =?us-ascii?Q?+SmCl51OyvUAFvBvHla+uB0iIyxaLJlPgXsV+7yfjBjo8U1R43tJIxh3awN3?=
 =?us-ascii?Q?eFjAOyi5Pr+NvC20NaTPsbWe7V2P2a9nGChoS1P0fDYQxe/RSi5nV3v0T4qy?=
 =?us-ascii?Q?JAUIE7hGMGsDz9oQm6aeDnZNaCW2m4ctQ04ID2qBuwPgShR56iRsoIYzq3RJ?=
 =?us-ascii?Q?905StNXJehdoXLhRdp/rkQncN1EduLQXSdu4uvp+jZC1zUnDKlyFYo6MyPTg?=
 =?us-ascii?Q?oXxvlAxCgJEZLxQfBHR6/Tz8Cxp0zmiPivG5NhZ+Gf4oHsvOl9wydcPoR4tP?=
 =?us-ascii?Q?BJhGr9jEryTI+oLAETcQAVZJ2N5HQu/GEr3JXwHW26/zvk2rRBuRZPwqtLIy?=
 =?us-ascii?Q?onx0Sznd3fWHcXdAZW7wlruc0BjW3eKERToe9kCE1a0/HOzatjc0pSqGx4lq?=
 =?us-ascii?Q?BWe/prYqraM4a/V5R3sLsvGaIj3Lyj1b+kykvqGz2owRRzmVjzNz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f9f279-64e4-4e91-a210-08df2a5dcf55
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:44:10.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ds7e4cCINyL23GuHTXHjBzqF5pyKevQ2yBd05MEY1/YxOJk789p8yejzfiScIGQBq5XTxZ3hYqAMeoxuJZMJSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB6125

ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
configures only MSI, and always raises peer interrupts with PCI_IRQ_MSI.
When MSI-X is selected, the host does not program MSI, so raising it can
issue a write to an invalid address. This was observed as IOMMU faults
on the RC, with no doorbell interrupts delivered.

Configure MSI-X when supported and use the selected type for peer
doorbells and link events. Allocate the MSI-X Table and PBA in the config
BAR and configure db_count entries. Use this EPF-owned layout even if the
EPC has fixed, hardware-owned Table/PBA regions, as pci-epf-test and
nvmet-pci-epf already do.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Split out the local epf cleanup into a prep patch. (Frank)
  - Keep the MSI labels in the interrupt-numbering comment. (Frank)
  - Rebase on the link-state fix and honor MSI-X for link events too.
  - Link to v4: https://lore.kernel.org/r/20261014053256.2378817-1-den@valinux.co.jp/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 47 ++++++++++++++++---
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index d74402ea10bf..f4eede5330c6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -152,6 +152,7 @@ struct epf_ntb {
 	struct mutex link_lock;
 	bool host_linkup;
 	bool vhost_linkup;
+	bool peer_msix;
 
 	/*
 	 * True when doorbells are interrupt-driven (MSI or embedded), false
@@ -159,6 +160,7 @@ struct epf_ntb {
 	 */
 	bool msi_doorbell;
 	u32 spad_size;
+	u32 msix_table_offset;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
@@ -202,13 +204,16 @@ static void epf_ntb_update_link(struct epf_ntb *ntb)
 
 static int epf_ntb_notify_link(struct ntb_dev *ndev)
 {
-	struct pci_epf *epf = ntb_ndev(ndev)->epf;
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct pci_epf *epf = ntb->epf;
+	unsigned int irq_type;
 	int ret;
 
 	ntb_link_event(ndev);
 
+	irq_type = ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 	ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
-				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);
+				irq_type, EPF_IRQ_LINK + 1);
 	if (ret)
 		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);
 
@@ -310,6 +315,7 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
  */
 static void epf_ntb_cmd_handler(struct work_struct *work)
 {
+	const struct pci_epc_features *epc_features;
 	struct epf_ntb_ctrl *ctrl;
 	u32 command, argument;
 	struct epf_ntb *ntb;
@@ -342,6 +348,15 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	switch (command) {
 	case COMMAND_CONFIGURE_DOORBELL:
+		epc_features = pci_epc_get_features(ntb->epf->epc,
+						    ntb->epf->func_no,
+						    ntb->epf->vfunc_no);
+		if (((argument & MSIX_ENABLE) && !epc_features->msix_capable) ||
+		    (!(argument & MSIX_ENABLE) && !epc_features->msi_capable)) {
+			ctrl->command_status = COMMAND_STATUS_ERROR;
+			break;
+		}
+		ntb->peer_msix = argument & MSIX_ENABLE;
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_TEARDOWN_DOORBELL:
@@ -483,8 +498,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
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
@@ -505,6 +521,12 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
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
@@ -573,6 +595,17 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
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
 
@@ -1577,6 +1610,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
 	struct pci_epf *epf = ntb->epf;
 	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
+	unsigned int irq_type;
 	u8 func_no, vfunc_no;
 	unsigned int db_bit;
 	u32 interrupt_num;
@@ -1588,6 +1622,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 	func_no = epf->func_no;
 	vfunc_no = epf->vfunc_no;
+	irq_type = ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 
 	/*
 	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
@@ -1601,7 +1636,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 		while (db_bits) {
 			/*
-			 * pci_epc_raise_irq() for MSI expects a 1-based
+			 * pci_epc_raise_irq() for MSI/MSI-X expects a 1-based
 			 * interrupt number. The first usable doorbell starts
 			 * at EPF_IRQ_DB_START in the legacy slot layout.
 			 *
@@ -1621,7 +1656,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 			db_bits &= ~BIT_ULL(db_bit);
 
 			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
-						PCI_IRQ_MSI, interrupt_num);
+						irq_type, interrupt_num);
 			if (ret)
 				dev_err(&epf->dev,
 					"Failed to raise IRQ for interrupt_num %u: %d\n",
-- 
2.54.0

