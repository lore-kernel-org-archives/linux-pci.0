Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021129.outbound.protection.outlook.com [40.107.74.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2E25B0AC;
	Sun, 30 Aug 2026 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103220; cv=fail; b=m25QPD8++sfIOYU5G/4lncvsI/+rWLfrvyJDIAwATYmC6qztNovNqL6AiTPuEmVNP7gFEzA24U6OR4pmwgGH7OIq6D1VjyKUCttxmYzR4vKO57v+NkfTbZCy0j4/ObACF24yeY69aY+ijC/IQjLiwzAgckfGZ7MGlw91kkhsAfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103220; c=relaxed/simple;
	bh=IFgLUanqYYV5Dr5L0Bys/vClx7EP6Ed+ddeWc0GS4DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QXTZcHvJfOdVf/go9AD88k/t16+HQFW0Pflk71tUSYOFoJgBJcii5/xv3D6lKn9vI7PMAET7w/897FCd+YH1Q51HboLEAbj7v4gpWQyioJayb0vbZB4zqQlJsL3wgg1e3PlqUBLxvzfL7q6sD9EN7M6Q1lEBxOcyHBU7LwCqmpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kIsgxm+0; arc=fail smtp.client-ip=40.107.74.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kIsgxm+0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3AKWDBsVpwPVupFf7sapjS6WmrSRyu2onw6GVLrUErfYiUpiDk+afAlsUcwX2XS6WJRV59VyI4c/fiCUUV5ji6rsw5BxwYH9AYFzHEXB69TKBksnnZAWvVPGMx5zQrKMxjNT2kBPFmtWquGR98R/8lNCR27+aUM2/yim8FeRdo86cemd9Rs+fxy9Pt9Z2LrNRGcOX1sunBkacqC5yjzSVzV6WwN2RSUsEpTdeIFffXlB1RX3EDbAbhET4ovwTLvVc9UPyv2rU19oxdZqMGegA20IIXVaoTRG0cMGlQNWANMXdV9AerklWuGePALHV7xftcrMvxvTMoJ7YQrXTX71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efawzy7rURFDohDhxVauA3Ud/GkzLNSSI2pNYfHegKs=;
 b=WjpSvGqFTml7IZthR6DJmpN+1yE19tWqWxAkdSN50R28qCSLQ1Wu8nfS5F626h3dWHIiQlc29m+Yv+w3JCLyeWQUeo/ltLmyRVIj/YGarvTUMGNVGHYBozosdgNoXEjG2DUxGGeKfwnDRMBfNB35FLgxmmilbtoe6mEzXDEI88jym3Jx/fBjAsYsyKPwqvqpP7ka5VJ/vlHx6/AeY0wM5X5PIKifdWZvYZioTYQxQclWt33WZKXy+1RUuahEXvLKVYpcBYtvQXjkugueFgLyASPKRs3Xw24cRsmpDA2zi7OlwKAgiasnJlMfNKfqNyqNZ53FVgJhDwupIx/v7rl+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efawzy7rURFDohDhxVauA3Ud/GkzLNSSI2pNYfHegKs=;
 b=kIsgxm+0LwsJ13FFLdiFLTAL20fPWItY3gGD2t3++UIR/toL+nx70UmhSy398cLBOivLQK8sdR/MSBqiCen4J0f6dJ/6A8S4/BrziZHicau9FGYaWs8u6Cd4poiKqqNKWDtgkkKE5WXx1GuD+fmvYbsA7zesE1AP39DIEXy91Ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB3211.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:214::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:20:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:20:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Aksh Garg <a-garg7@ti.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	ntb@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Date: Mon, 31 Aug 2026 00:19:48 +0900
Message-ID: <20260830151948.3547577-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260830151948.3547577-1-den@valinux.co.jp>
References: <20260830151948.3547577-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0114.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB3211:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f380272-99a6-4b70-a14a-08df06aa3009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|10070799003|366016|6133799003|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9GK654R7IIjXgowQAZo4nlW6dL0vbc8YMcHksLk458eimsnGcKhJKSvf6UWHeSABD6LT0XLhuEjW1567CQ5ed8l4aNrk03uqavCYxeQkjPT7p8stN2ZCcGG96pVnLUNOYu7mbdYSVcDiK64/Im1v2zNNCsRot66kMO7s2AhuuwIWIW4KZqZF7T3bWu/SY7k45+hWGqzr3ZE+ezaAwLKVw4ptY/R0VJYWqC6nj/kIgDp35ftuzdSSlL9UoXVNEp6XbLxy/QaZURqbP9JkCRaIUl+WQoDU1FEmmqTdMXIKQpqHWC9FLSAfuE3WGfqdqMPKjvo0cpgR81mS9LlfimwOcEQxKLrXIfrijqbnBuc6APZsH+5vXr0KmnVk73goawRxWcgVqpqog9rxcwAYUrTge7rRy9LaWbDPFfZ7mqz24ZDzY5IU5MtAkan8qvcBzy8V5ZEi3tWlNcsEA56DB3CViyTE+hw87/TEwq9YlBKpI9HCVkXnOsYEmUtvBMKYHYkVEuFXeOeBo/mIlnbU+n3MouOEgOIiftgs619yenf/LQfj+axsGxrdSmR6ssJGvnjJJSZBA+XgqbFp3dNbu2NdKlU1iKSMIQnzMlFUhuPVPBeCMqtbFYS9MDPvyxZqsfuhzYbiUowPEyQIeY2bChjaUzIlYzuTZjDCKmRf79XxUoE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(10070799003)(366016)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6gpwNXxzSKsBml7tfJc7Wp47GhFeHr6xzNU0k2B7dt4xddB/X6YPXGKh10nz?=
 =?us-ascii?Q?B4Faf7oRZU+Vfk9TqCNsVGZ8CNe6GcAro5FQJQVMMGBhkcLsJafPfhfXCbmn?=
 =?us-ascii?Q?byPzpuLFQpsITrIi514vQn1uCSIXFAmbFsFXs0r+9QPMYrmXe6u5BFX4QrYY?=
 =?us-ascii?Q?YUjBipRh/tMGPgQ9Au3KmiMnNVijWvHH1D39eTbYwjfgwxd2jzljgCEae4EK?=
 =?us-ascii?Q?2rCA6EeEhagW3etU0Wx6FPSrNnKRN9fdgwaAr+VL8nWGJC+uDkaPBTn9wc3r?=
 =?us-ascii?Q?31rJ8EcBMAxUMY3VGkU/a9KrGJ52a+0/Rf3xUn0Wg2AWjbp2IySMigE2ZHBD?=
 =?us-ascii?Q?9ze347VYbleeCEZ/27cL7r/O0gPg4VXg8O5PdfFk6YvoJXRtst4z+VrH/Rps?=
 =?us-ascii?Q?5+cizfVgI+XrYl97K2Z3WD1aajq3+rDBhWhd7mJ+52b3dhg+C4EKYUz5q+qO?=
 =?us-ascii?Q?oWZKP53v1dZ892Oma2cSqahoxesX1OJ/kBB+ueY5bpNWjZIbArM5EnpLNZcL?=
 =?us-ascii?Q?LijoVTwltse8hXsmKMMPaRJU1OH9sAwTuy40wcaUlVgoaWjc86La9aaYNQ2i?=
 =?us-ascii?Q?u/eRaPyEoZvzoKg1NqCA2T2t9zajU4W1yScJtfR01EZ5uQWbN+Z21Lv6GDKW?=
 =?us-ascii?Q?aGyWjucFQsE5dmzMt9YGbC8WVSt9ujlWICuP5CwyVSLrsCCJDB7HWP87tOKC?=
 =?us-ascii?Q?Iqpcekjz/vbWNiO3PofyJync2xdaPwV9ilF0OJJQr5GMJR8ZKrBgbudXBBdJ?=
 =?us-ascii?Q?JyNTU+XaQNbGNBXDth5etqHMZBGEJhPSpQRlxzLFvOesI0+o8f2vv8DV7rC9?=
 =?us-ascii?Q?ycyuEu75dyuSldzabVHG/Wiew6S1t2amvXpHpCPcDw8t9sCepaPZJ5DJvVPs?=
 =?us-ascii?Q?LBEg7xkgsirUMHtc0rypXafXqodC+q4GA8kOy4XSPm8ccBGd1m0a2KSOo8FW?=
 =?us-ascii?Q?21gZmr8tfEMkoA43V1t3CBDQYOog1OIfN3B0cEJqrJTKsitH27GFnm9YNYgU?=
 =?us-ascii?Q?PA99fWbzyc5BmUhMsaOBow1MyJc3m9C44bYq99vldbLWmkrEgrkDb4WncZfr?=
 =?us-ascii?Q?NqBdhAxQPTT7hOwazVJqpGOkelGAtzRa0Lu6028ug/+VjfiUFlOuvaFgMpS5?=
 =?us-ascii?Q?y/lM5XAHSKwyFXdJ6C6IRPhGT+yx9HNxyeoYET+aFxxh9H7FueRIdWnwY2TI?=
 =?us-ascii?Q?MC6WGSsjzsTR5ECqy8XegvQXew6x1ilvJyYx6QUaYu+znANqCQKktrPXmoDi?=
 =?us-ascii?Q?Csdkb2+8gUqnm4bHH+Wo83RzjRyMMNPgKiu99ReYhEx8HXJri3jEjaeunvqq?=
 =?us-ascii?Q?kF+/P5yUdfB+i4qC4IzcB9CRExSBdnCcKuouhWy+RKVy8CKy77gzKJgoP515?=
 =?us-ascii?Q?+aF+dS2XyCR6PRhAoFIbmNKF962/TmfbyA5nsZNJ0D05h8X4AVZ1qm+wslQ3?=
 =?us-ascii?Q?KQjYBb85MR/Wh1ppPECyeCZgA28+a3Mla6B6OmR37MAzRjZsrAXr9YngczXv?=
 =?us-ascii?Q?48xDw/hRsCLv7sHwpwZCjAKJ1TSaXgjN406HmwfKze4MXXdlSOePU9HWYz3u?=
 =?us-ascii?Q?6cJX9X8Rv9op4Ib8t/Ps4OJCuoK7lMcZy49wNf5HBGjCdNftVB+uk7ZiNjLj?=
 =?us-ascii?Q?51Gfzw2VsMTuPrrBIP8YgWsuHFPHyXqNYPFuUy2YovbLTo9ic6jLjB49Dlyo?=
 =?us-ascii?Q?MlOU0+dktm8UpRJ3sQg3ppvEudxf2tLFFQ39WcNUIRJfcyDilnVtEweccIop?=
 =?us-ascii?Q?/EpA0HI6NCuc5kB8aQdIugCtdnCjnWgLCmPWHchCrkw58Y3ZxeVd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f380272-99a6-4b70-a14a-08df06aa3009
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:20:13.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhG8ePq89t9h8U7S68BoAfxOgMXfmJl7CEr1nd3OnuP9O0vZeob1eSHYDVZQiKP8l6tUuC2oyFZ0cCBmXJdyCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3211

ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
configures only MSI, and always raises peer doorbells with PCI_IRQ_MSI.
When MSI-X is selected, the host does not program MSI, so raising it can
issue a write to an invalid address. This was observed with an IOMMU
enabled on the RC.

Configure MSI-X when supported and use the selected type for peer
doorbells. Use the hardware-owned layout when available. Otherwise
allocate an EPF-owned Table and PBA in the config BAR. Configure db_count
entries to cover the link event, the reserved slot, and the doorbell
slots.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 67 ++++++++++++++-----
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c3caec927d74..d9622a5d4710 100644
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
+	struct pci_epc_msix_layout msix_layout;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
@@ -303,6 +305,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	switch (command) {
 	case COMMAND_CONFIGURE_DOORBELL:
+		WRITE_ONCE(ntb->peer_msix, argument & MSIX_ENABLE);
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_TEARDOWN_DOORBELL:
@@ -439,9 +442,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *   region
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
- * Allocate the Local Memory mentioned in the above diagram. The size of
- * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
- * is obtained from "spad-count" configfs entry.
+ * Allocate the control and scratchpad regions described in the above diagram.
+ * If the EPC does not provide a hardware-owned MSI-X table and PBA, allocate
+ * space for them between the control and scratchpad regions.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
@@ -454,7 +457,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	struct device *dev = &epf->dev;
 	u32 spad_count;
 	void *base;
-	int i;
+	int i, ret;
 	const struct pci_epc_features *epc_features = pci_epc_get_features(epf->epc,
 								epf->func_no,
 								epf->vfunc_no);
@@ -462,6 +465,29 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	spad_count = ntb->spad_count;
 
 	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	if (epc_features->msix_capable) {
+		ret = pci_epc_get_hw_msix_layout(epc_features,
+						 &ntb->msix_layout);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Invalid hardware-owned MSI-X layout\n");
+			return ret;
+		}
+
+		if (ret == -ENOENT) {
+			ntb->msix_layout.table_bar = barno;
+			ntb->msix_layout.table_offset = ALIGN(ctrl_size, 8);
+			ntb->msix_layout.table_size =
+				ntb->db_count * PCI_MSIX_ENTRY_SIZE;
+			ntb->msix_layout.pba_bar = barno;
+			ntb->msix_layout.pba_offset =
+				ntb->msix_layout.table_offset +
+				ntb->msix_layout.table_size;
+			ntb->msix_layout.pba_size =
+				BITS_TO_U64(ntb->db_count) * sizeof(u64);
+			ctrl_size = ntb->msix_layout.pba_offset +
+				    ntb->msix_layout.pba_size;
+		}
+	}
 	spad_size = 2 * spad_count * sizeof(u32);
 
 	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
@@ -502,6 +528,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
+	struct pci_epf *epf = ntb->epf;
 	struct device *dev;
 	int ret;
 
@@ -521,16 +548,22 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
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
+				       ntb->db_count, &ntb->msix_layout);
+		if (ret) {
+			dev_err(dev, "MSI-X configuration failed\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -1512,6 +1545,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
 	struct pci_epf *epf = ntb->epf;
 	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
+	unsigned int irq_type;
 	u8 func_no, vfunc_no;
 	unsigned int db_bit;
 	u32 interrupt_num;
@@ -1523,6 +1557,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 	func_no = epf->func_no;
 	vfunc_no = epf->vfunc_no;
+	irq_type = READ_ONCE(ntb->peer_msix) ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 
 	/*
 	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
@@ -1536,16 +1571,16 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
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
@@ -1556,7 +1591,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 			db_bits &= ~BIT_ULL(db_bit);
 
 			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
-						PCI_IRQ_MSI, interrupt_num);
+						irq_type, interrupt_num);
 			if (ret)
 				dev_err(&ntb->ntb.dev,
 					"Failed to raise IRQ for interrupt_num %u: %d\n",
-- 
2.51.0

