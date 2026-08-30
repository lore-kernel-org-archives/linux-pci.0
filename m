Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021129.outbound.protection.outlook.com [40.107.74.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D838D41A;
	Sun, 30 Aug 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103216; cv=fail; b=C4M9TmMIdBPPWUkCrRjT6hxbfG0596pqCedmqLp5M25+20LaXpUhdyNFC4SRnxqYVUgrzz2x8sEFHjfAlyWNZPekuLEkU1llUO2oU2Wlbu6rMGGvEbMd7oThhXsJslQokbc0ICt39UcHnYU7ON9vMbq9FQ+54ouE3vI/yuC22Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103216; c=relaxed/simple;
	bh=lkRAWyjdPw2iqLJlUEbDeUYLnC9HgHV/l/FTXyJ9vVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDRy1xlUj9yGUAQ2hAhRncyFRw84t1z1a3U1oDjw/jHtN9U8k5JYCkLDT/umcXinLoDTYU4K1rgU4CesuAEj0R6fqRMto8DisKlDdSD7qrCTzu/6licnVlVyFlu6VcOpYTXsudD9bD/G6DvnHcZjOnXR0OqOZK/8tBtu9XcZITI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aRoVSPCD; arc=fail smtp.client-ip=40.107.74.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aRoVSPCD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtgXotv68eBXx9rTBlaeV7/RSLntb+WWfnHnOsquIlhxV6AN1YjxgW59EmJZck0YnObRZMgTU5sdlin8YMd94xQmT4DZN+cdnyGo4OjKoouu8ArdpQpnyOMqfQvNlkI+PUUQriK7RwpvQcaObAi54aSB5wTXaeQ2nlLgHXKhQIhsQXWwg8e6IW5NdP7009cwmffS1JMDfSdgqvwvHgJ522690ueOhSUC9BX/WQuOl0ZbNJUoLmjDV5zSdVPRSdRoTXvNe5E5QGxjltkeo7TOBsPNYPAAJ2OfmIyjfQh0FwRxadKZgmxfXZxDAilIWkQetF1HnEJ8Rxq7vkhJepzUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtjacCaigq2Si6y5XiwB8SZ6VkEcuottmHl2Lg8WU18=;
 b=P9KrTfMoat5iFiA1QUVZ4SAsuomhgcHonc2avZZYJwzULrUbeqYt6nU/kXqfLggiPg81KcrjNSWECclBdEnplzfQ1uE5YhnYDWT7rGrASsquMrXZhO0yUhxowH2GB38CPquiOMbcWxckSGrFlcD+D4KojGFbiQ17JK+8hiw2Xbqe8R8URzd9Sdq7tyJyQ/2G5bh0+jtfvVGE+1wuPJjVV0UCRY2M7o4odqQCoR9VnWwFiT380bbhGGnKOliCphzyseK2ROkHihpTktWTB1ZBFZTzPmksTlmZzzR9kvpObPrGHjQO8afXfAXzMEjYpt7AiN2S1j0/4cnZNoZXBWXtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtjacCaigq2Si6y5XiwB8SZ6VkEcuottmHl2Lg8WU18=;
 b=aRoVSPCD5y1r1oUAVxzCDTFLIg4yD80P11J+AYQkVNDCGfzyPm9aOGul6X+zjaBDUri740S1aBu/bMobnpfL14+p079ONAZNt0B4HqDdPeu0ByVTgCnHePiL9WGJZ7AM6zK565ElH19e/Ltr8w8bEefhJ88TR7iV/GDbqtVvAhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB3211.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:214::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:20:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:20:11 +0000
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
Subject: [PATCH v2 1/3] PCI: endpoint: Support hardware-owned MSI-X table and PBA
Date: Mon, 31 Aug 2026 00:19:46 +0900
Message-ID: <20260830151948.3547577-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260830151948.3547577-1-den@valinux.co.jp>
References: <20260830151948.3547577-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB3211:EE_
X-MS-Office365-Filtering-Correlation-Id: 48833f31-2405-40ce-b288-08df06aa2eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|10070799003|366016|6133799003|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0jyzdUUynSh7GskkS5jZVuveViS9zFXfmejUdtTojm9KtdyMQfjZJWWZFhsSY1NhcAYaRiIyXwtxyTaSH2pse/uip4z++IriY9CyKqMCfBPIR9ECLCK+KjyQ41rgKa5T3fZpdPXcgjtSSmPhSsbiXAuVKlWeGRToX+Y8xO17BsaRRsSJwL+Iryhx6MHN+99YOwIOPkQTS7DvVnOFD7QVn7AxrRAW3mJUnwCVlHem41Zi0SGPsTr66r7cg9+pSAwIeDrX+WCeMPS11Qj8ybmFeZqbSki0yMZqGJ8lgtABLp6BCsQ8UtAGzH8PAa9uqm2Y7XtpuVyZ0RJACFNPJdgmrU/9qwf3ly9siusEpPw8aJPaKU7wns321zesxDrzWlXKsb/kCsbRmm+2+eHzbSGRY9rS+L1rsSh2YCrxpXQL3bQv/Gy5rXkykXMMVyqn5qXUCcWRJfoLq5igaN2Y/J69A36kRPSqbp/hp9CwC+qWANIEkN/+ksd/1Z21K+vQoPoTSUddjQR2zc+3Lp1mfpJ6jiIvzYRMJCnFCssaFABuzX0UQghyRkTv7PfSA7frHs5dYHRt+pxu1GzieusqHkNBfIzzNHO6OX19bN5pTAYCuclz25gNqJbMzPjjSdbjKMfqi4oXI3jsO/Y9rO6f8D1yi9AN5EH4GpKNsH0FKOlr6BA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(10070799003)(366016)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FS1XOaDBuROkbrpeVgvdCUBNB6puXP+uc7TueYCsMuvfKIp2PggJqE2Nvhi6?=
 =?us-ascii?Q?sfn7FwLjuXL2ods67T4Ops7VOAT0u0kNlEw6BfLsv8Z/4g20xjJL59/EQos6?=
 =?us-ascii?Q?2JkgJX0kpay40euYARY5g+D6Yqg+JRwSjXogAi626nY7c7bQhCKN1K9Tf0fZ?=
 =?us-ascii?Q?EPvCaPNEgbuk229D0b7fu578LpLFYEQfGaiAnepYbj8KJck66ogxq8Y24rh8?=
 =?us-ascii?Q?xUSo9YmZzAhN+Do9TQucEGVeFdWZ8dzGWDEYnsT4DTHtUm8HEZVBnvSlpu8i?=
 =?us-ascii?Q?SxXJ63iBKLWKZw+LnhhkBd29NWSFG9anWzLlss1fNytcUorhulBCGfoOjtcM?=
 =?us-ascii?Q?1utfQ4g/X3DbdYKerd/3qULjor4hbXlYywb0rQYHN/UL/47GlupsaCLdtAPC?=
 =?us-ascii?Q?ZQCNXZXvfrIVafnZHYxiA19pe/J7/w+qSpuzu+HPzKqiEB+mZMLRSW+DomF9?=
 =?us-ascii?Q?5g2fAXzl/GxzRJYwYRlNV3thNZSEyrdy/A9G2iWDsI0LuwFGjJ99ROHRVju6?=
 =?us-ascii?Q?2bB5X6OuRasYCjxaRZ3Nh5BdPzI8BMkUtVNArCS5tG0BPkeItGpNOypu36Ty?=
 =?us-ascii?Q?5YeMONqxfXDDFPsKPtLb2zZVn7lB0dulRY3DMI2niFJjWt4gtQpP43TNb4yb?=
 =?us-ascii?Q?WALcCOcP2s33Bi/Pjz43dNbl+xJHgPZjOd7RQRuIEvC++xpzrfjIHjrguONc?=
 =?us-ascii?Q?+prAYE+V6idwS51hAp9buzhfVeFyVegdfcBCwx6s8P2DB9qbAjUMzE8gukjz?=
 =?us-ascii?Q?CmGkx0tEUgFaKeozk23moOC3Gibs34o6M1P+VGm8NNU0cnrD8ohLAZqCGUwT?=
 =?us-ascii?Q?ttmamNGjgHg8DV0o6+X8juYjFUwWdzj5PDeRD6HT8HOrlx402cWSbG+5TRla?=
 =?us-ascii?Q?7rlnIpHq1W4yvwdsS6Idw5Ji0Uuj38qKwCz0ihS598/s088sEZ1uIPT0m/62?=
 =?us-ascii?Q?0qQMZcW97o8loBuI1JVVDFb/iOT4izu9Y5x9Qk/TJFU2CM0iJWR+ZXhEQcT+?=
 =?us-ascii?Q?RsZOvFv9LyP7K0SwqSI9+MMUE2pEUwtp38toUunWyr1nk15Oc2417bleednk?=
 =?us-ascii?Q?YCZeSf/9zUqA/4Lvay83C6tkk5wvEW8JFpD81pqMdibNy37J0+b/R+e+p08/?=
 =?us-ascii?Q?30Gjs/QPGmTFxHP9jH5NjPp2XveB5O6j2xTjOJCVzNmiiO74GEGq7Cww2q+E?=
 =?us-ascii?Q?NWWWr6+/dvxCWlB3HIOnbmCcRTq8Uarv3ARmoMD9kv43hrfb09JwLINj+nW8?=
 =?us-ascii?Q?w1ljXvDF81Yx5+L8AoxVVdAU5oqkWvwoMLew2AEqoZ8FTby9kwmqlj3WC+7U?=
 =?us-ascii?Q?X1b9dV6/23HArenAU5t77tz3WkXvNoE+i4VyHvHxlTmQBzO68eio0jfcoBcH?=
 =?us-ascii?Q?1Z5I7tTmaAGe2HE9Lw6ZQYsa1XI5N8U6Yz6H/COLoZkpEpmgt4ENqePZVVX4?=
 =?us-ascii?Q?zEEzDSYefsN8eRQ/a1kLnh2eT4mCDowI8hS1pspfsD6mGrL8o8LT/6Mt8eGc?=
 =?us-ascii?Q?syC+cLcOjBjrrS71te95O6hGEjVlaZeAqm4vyuZ0AQrf5C5UY//9U37CPoEJ?=
 =?us-ascii?Q?RV/q/8XoLifa0Eg+d4UtdDNeGL4FoxPzR1WlDJekhSLmLL0m/tIgvE1McDje?=
 =?us-ascii?Q?JoWImVyl+LQ2u5oqG8nNeC/YXCK5+CJuNbY06sthFruyS7AD02ylZMCS5uJx?=
 =?us-ascii?Q?uirLSyiMlwqH6J89Dh1HByTQmDjKHyCoL8A9dbWr/W9QF58dKvHX3N7bYr4m?=
 =?us-ascii?Q?qY5R3oXg1C8vDvsm+XQXe8ZXMQLNSk/KOCUPBY6hTqhCuk31bmF8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 48833f31-2405-40ce-b288-08df06aa2eea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:20:11.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iV+CsSQzTFXuQDZaSmOlE8ZJxicd7fA0PbjR/y2YXBtd9wiO35jNVDeOCff0CVs8gEGYdz1m9YlP+qWDu91vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3211

Some endpoint controllers expose the MSI-X table and Pending Bit Array
(PBA) in fixed, hardware-owned BAR regions. The EPC set_msix() callback
currently receives only the table BAR and offset and assumes that the PBA
immediately follows the table in the same BAR. It cannot describe a fixed
layout whose table and PBA have independent locations.

Add struct pci_epc_msix_layout and pass the full layout to
pci_epc_set_msix(). Leave layout selection to EPF implementations. For
instance, pci-epf-ntb reads the MSI-X Table from its own BAR. Using a
fixed layout there would require a way to read hardware-owned Table
entries. Add pci_epc_get_hw_msix_layout() for EPFs that want the fixed
layout. Update the existing callers and validate the supplied layout.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/nvme/target/pci-epf.c                 |  16 ++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |   9 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |   7 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  30 +++---
 drivers/pci/endpoint/functions/pci-epf-test.c |  17 +--
 drivers/pci/endpoint/pci-epc-core.c           | 102 +++++++++++++++++-
 include/linux/pci-epc.h                       |  25 ++++-
 7 files changed, 168 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..37182f6d29b1 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -201,7 +201,7 @@ struct nvmet_pci_epf {
 	const struct pci_epc_features	*epc_features;
 
 	void				*reg_bar;
-	size_t				msix_table_offset;
+	struct pci_epc_msix_layout	msix_layout;
 
 	unsigned int			irq_type;
 	unsigned int			nr_vectors;
@@ -2187,8 +2187,14 @@ static int nvmet_pci_epf_configure_bar(struct nvmet_pci_epf *nvme_epf)
 		size_t pba_size;
 
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
-		nvme_epf->msix_table_offset = reg_size;
-		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
+		pba_size = BITS_TO_U64(epf->msix_interrupts) * sizeof(u64);
+
+		nvme_epf->msix_layout.table_bar = BAR_0;
+		nvme_epf->msix_layout.table_offset = reg_size;
+		nvme_epf->msix_layout.table_size = msix_table_size;
+		nvme_epf->msix_layout.pba_bar = BAR_0;
+		nvme_epf->msix_layout.pba_offset = reg_size + msix_table_size;
+		nvme_epf->msix_layout.pba_size = pba_size;
 
 		reg_size += msix_table_size + pba_size;
 	}
@@ -2245,8 +2251,8 @@ static int nvmet_pci_epf_init_irq(struct nvmet_pci_epf *nvme_epf)
 	/* Enable MSI-X if supported, otherwise, use MSI. */
 	if (epc_features->msix_capable && epf->msix_interrupts) {
 		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
-				       epf->msix_interrupts, BAR_0,
-				       nvme_epf->msix_table_offset);
+				       epf->msix_interrupts,
+				       &nvme_epf->msix_layout);
 		if (ret) {
 			dev_err(&epf->dev, "Failed to configure MSI-X\n");
 			return ret;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index c0e1194a936b..2b69ea88aed2 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -293,7 +293,8 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 }
 
 static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
-				 u16 nr_irqs, enum pci_barno bir, u32 offset)
+				 u16 nr_irqs,
+				 const struct pci_epc_msix_layout *layout)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -311,12 +312,12 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* Set MSI-X BAR and offset */
 	reg = cap + PCI_MSIX_TABLE;
-	val = offset | bir;
+	val = layout->table_offset | layout->table_bar;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
-	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
+	/* Set PBA BAR and offset */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = layout->pba_offset | layout->pba_bar;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..147b043589f0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -737,7 +737,8 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 }
 
 static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			       u16 nr_irqs, enum pci_barno bir, u32 offset)
+			       u16 nr_irqs,
+			       const struct pci_epc_msix_layout *layout)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -757,11 +758,11 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
-	val = offset | bir;
+	val = layout->table_offset | layout->table_bar;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_PBA;
-	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = layout->pba_offset | layout->pba_bar;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 5314aca2188a..f3e0e1b3ffb9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -90,12 +90,11 @@ struct epf_ntb_epc {
 	u8 vfunc_no;
 	bool linkup;
 	bool is_msix;
-	int msix_bar;
 	u32 spad_size;
 	struct pci_epc *epc;
 	struct epf_ntb *epf_ntb;
 	void __iomem *mw_addr[6];
-	size_t msix_table_offset;
+	struct pci_epc_msix_layout msix_layout;
 	struct epf_ntb_ctrl *reg;
 	struct pci_epf_bar *epf_bar;
 	enum pci_barno epf_ntb_bar[6];
@@ -475,9 +474,9 @@ static int epf_ntb_configure_msi(struct epf_ntb *ntb,
  *
  * The MSI-X address is in the MSI-X table of EP CONTROLLER 2 and
  * the count of doorbell is in ctrl->argument of epf_ntb_epc that is connected
- * to HOST2. MSI-X table is stored memory mapped to ntb_epc->msix_bar and the
- * offset is in ntb_epc->msix_table_offset. From this epf_ntb_configure_msix()
- * gets the MSI-X address and data.
+ * to HOST2. The location of the memory-mapped MSI-X table is described by
+ * ntb_epc->msix_layout. From this epf_ntb_configure_msix() gets the MSI-X
+ * address and data.
  *
  * epf_ntb_configure_msix() also stores the MSI-X data to raise each interrupt
  * in db_data of the peer's control region. This helps the peer to raise
@@ -505,8 +504,8 @@ static int epf_ntb_configure_msix(struct epf_ntb *ntb,
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
 
-	epf_bar = &ntb_epc->epf_bar[ntb_epc->msix_bar];
-	msix_tbl = epf_bar->addr + ntb_epc->msix_table_offset;
+	epf_bar = &ntb_epc->epf_bar[ntb_epc->msix_layout.table_bar];
+	msix_tbl = epf_bar->addr + ntb_epc->msix_layout.table_offset;
 
 	peer_ntb_epc = ntb->epc[!type];
 	peer_barno = peer_ntb_epc->epf_ntb_bar[BAR_DB_MW1];
@@ -1036,10 +1035,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 	if (msix_capable) {
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * ntb->db_count;
 		ctrl_size = ALIGN(ctrl_size, 8);
-		ntb_epc->msix_table_offset = ctrl_size;
-		ntb_epc->msix_bar = barno;
-		/* Align to QWORD or 8 Bytes */
-		pba_size = ALIGN(DIV_ROUND_UP(ntb->db_count, 8), 8);
+		pba_size = BITS_TO_U64(ntb->db_count) * sizeof(u64);
+
+		ntb_epc->msix_layout.table_bar = barno;
+		ntb_epc->msix_layout.table_offset = ctrl_size;
+		ntb_epc->msix_layout.table_size = msix_table_size;
+		ntb_epc->msix_layout.pba_bar = barno;
+		ntb_epc->msix_layout.pba_offset = ctrl_size + msix_table_size;
+		ntb_epc->msix_layout.pba_size = pba_size;
 		ctrl_size = ctrl_size + msix_table_size + pba_size;
 	}
 
@@ -1317,10 +1320,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 
 	if (msix_capable) {
 		ret = pci_epc_set_msix(epc, func_no, vfunc_no, ntb->db_count,
-				       ntb_epc->msix_bar,
-				       ntb_epc->msix_table_offset);
+				       &ntb_epc->msix_layout);
 		if (ret) {
-			dev_err(dev, "MSI configuration failed\n");
+			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
 		}
 	}
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 4802d4f80f78..e48292e0fb37 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -82,7 +82,7 @@ struct pci_epf_test {
 	struct pci_epf		*epf;
 	struct config_group	group;
 	enum pci_barno		test_reg_bar;
-	size_t			msix_table_offset;
+	struct pci_epc_msix_layout msix_layout;
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
 	struct dma_chan		*dma_chan_rx;
@@ -1221,8 +1221,7 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
 	if (epc_features->msix_capable) {
 		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
 				       epf->msix_interrupts,
-				       epf_test->test_reg_bar,
-				       epf_test->msix_table_offset);
+				       &epf_test->msix_layout);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
@@ -1288,9 +1287,15 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 
 	if (epc_features->msix_capable) {
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
-		epf_test->msix_table_offset = test_reg_bar_size;
-		/* Align to QWORD or 8 Bytes */
-		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
+		pba_size = BITS_TO_U64(epf->msix_interrupts) * sizeof(u64);
+
+		epf_test->msix_layout.table_bar = test_reg_bar;
+		epf_test->msix_layout.table_offset = test_reg_bar_size;
+		epf_test->msix_layout.table_size = msix_table_size;
+		epf_test->msix_layout.pba_bar = test_reg_bar;
+		epf_test->msix_layout.pba_offset = test_reg_bar_size +
+						   msix_table_size;
+		epf_test->msix_layout.pba_size = pba_size;
 	}
 	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 831b40458dcd..4a0ceb62f38f 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -113,6 +114,84 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_next_free_bar);
 
+static int pci_epc_get_msix_region(const struct pci_epc_features *epc_features,
+				   enum pci_epc_bar_rsvd_region_type type,
+				   enum pci_barno *bar, u32 *offset,
+				   resource_size_t *size)
+{
+	const struct pci_epc_bar_rsvd_region *region;
+	const struct pci_epc_bar_desc *bar_desc;
+	bool found = false;
+	int i, j;
+
+	if (!epc_features)
+		return -ENOENT;
+
+	for (i = BAR_0; i < PCI_STD_NUM_BARS; i++) {
+		bar_desc = &epc_features->bar[i];
+		if (bar_desc->nr_rsvd_regions && !bar_desc->rsvd_regions)
+			return -EINVAL;
+
+		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
+			region = &bar_desc->rsvd_regions[j];
+			if (region->type != type)
+				continue;
+
+			if (found || bar_desc->type != BAR_RESERVED || !region->size ||
+			    region->offset > PCI_MSIX_TABLE_OFFSET ||
+			    !IS_ALIGNED(region->offset, 8))
+				return -EINVAL;
+
+			found = true;
+			*bar = i;
+			*offset = region->offset;
+			*size = region->size;
+		}
+	}
+
+	return found ? 0 : -ENOENT;
+}
+
+/**
+ * pci_epc_get_hw_msix_layout() - get a hardware-owned MSI-X table and PBA layout
+ * @epc_features: features provided by an EPC for an endpoint function
+ * @layout: layout to populate
+ *
+ * Return: 0 if the EPC describes both hardware-owned MSI-X regions, -ENOENT if
+ * neither region is described, or an error if the description is invalid.
+ */
+int pci_epc_get_hw_msix_layout(const struct pci_epc_features *epc_features,
+			       struct pci_epc_msix_layout *layout)
+{
+	struct pci_epc_msix_layout hw_layout;
+	int table_ret, pba_ret;
+
+	if (!layout)
+		return -EINVAL;
+
+	table_ret = pci_epc_get_msix_region(epc_features,
+					    PCI_EPC_BAR_RSVD_MSIX_TBL_RAM,
+					    &hw_layout.table_bar,
+					    &hw_layout.table_offset,
+					    &hw_layout.table_size);
+	pba_ret = pci_epc_get_msix_region(epc_features,
+					  PCI_EPC_BAR_RSVD_MSIX_PBA_RAM,
+					  &hw_layout.pba_bar,
+					  &hw_layout.pba_offset,
+					  &hw_layout.pba_size);
+
+	if (table_ret == -ENOENT && pba_ret == -ENOENT)
+		return -ENOENT;
+
+	if (table_ret || pba_ret)
+		return -EINVAL;
+
+	*layout = hw_layout;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_hw_msix_layout);
+
 static bool pci_epc_function_is_valid(struct pci_epc *epc,
 				      u8 func_no, u8 vfunc_no)
 {
@@ -443,14 +522,14 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
  * @nr_irqs: number of MSI-X interrupts required by the EPF
- * @bir: BAR where the MSI-X table resides
- * @offset: Offset pointing to the start of MSI-X table
+ * @layout: MSI-X table and PBA layout selected by the EPF
  *
  * Invoke to set the required number of MSI-X interrupts.
  */
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
-		     enum pci_barno bir, u32 offset)
+		     const struct pci_epc_msix_layout *layout)
 {
+	size_t table_size, pba_size;
 	int ret;
 
 	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
@@ -459,11 +538,26 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
 	if (nr_irqs < 1 || nr_irqs > 2048)
 		return -EINVAL;
 
+	if (!layout || layout->table_bar < BAR_0 ||
+	    layout->table_bar >= PCI_STD_NUM_BARS ||
+	    layout->pba_bar < BAR_0 || layout->pba_bar >= PCI_STD_NUM_BARS ||
+	    !IS_ALIGNED(layout->table_offset, 8) ||
+	    !IS_ALIGNED(layout->pba_offset, 8) ||
+	    layout->table_offset > PCI_MSIX_TABLE_OFFSET ||
+	    layout->pba_offset > PCI_MSIX_PBA_OFFSET)
+		return -EINVAL;
+
+	table_size = nr_irqs * PCI_MSIX_ENTRY_SIZE;
+	pba_size = BITS_TO_U64(nr_irqs) * sizeof(u64);
+
+	if (layout->table_size < table_size || layout->pba_size < pba_size)
+		return -ENOSPC;
+
 	if (!epc->ops->set_msix)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msix(epc, func_no, vfunc_no, nr_irqs, bir, offset);
+	ret = epc->ops->set_msix(epc, func_no, vfunc_no, nr_irqs, layout);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..3d28231f092a 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -102,6 +102,24 @@ struct pci_epc_aux_resource {
 	} u;
 };
 
+/**
+ * struct pci_epc_msix_layout - layout of an MSI-X table and PBA
+ * @table_bar: BAR containing the MSI-X table
+ * @table_offset: offset of the MSI-X table within @table_bar
+ * @table_size: size of the MSI-X table region
+ * @pba_bar: BAR containing the MSI-X Pending Bit Array (PBA)
+ * @pba_offset: offset of the MSI-X PBA within @pba_bar
+ * @pba_size: size of the MSI-X PBA region
+ */
+struct pci_epc_msix_layout {
+	enum pci_barno		table_bar;
+	u32			table_offset;
+	resource_size_t		table_size;
+	enum pci_barno		pba_bar;
+	u32			pba_offset;
+	resource_size_t		pba_size;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -147,7 +165,8 @@ struct pci_epc_ops {
 			   u8 nr_irqs);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			    u16 nr_irqs, enum pci_barno, u32 offset);
+			    u16 nr_irqs,
+			    const struct pci_epc_msix_layout *layout);
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     unsigned int type, u16 interrupt_num);
@@ -381,8 +400,10 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
-		     enum pci_barno, u32 offset);
+		     const struct pci_epc_msix_layout *layout);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int pci_epc_get_hw_msix_layout(const struct pci_epc_features *epc_features,
+			       struct pci_epc_msix_layout *layout);
 int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr, u8 interrupt_num,
 			u32 entry_size, u32 *msi_data, u32 *msi_addr_offset);
-- 
2.51.0

