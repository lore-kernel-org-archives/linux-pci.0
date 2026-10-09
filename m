Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020131.outbound.protection.outlook.com [52.101.229.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1663E410F;
	Fri,  9 Oct 2026 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522018; cv=fail; b=R6oIXfBUO/9n1tR/jA30GlZ40U3PoE8LBOCbNx09QwnbbU4eY7QUgGRg9W+TsZS5jSF8N7II015I25MFK+Hj1/1PiAePJLRBV7UONQ4fVnRVCs7LZhPIrSduAqRQBYQF1i+QOqoXMTaDsaP8wfGTejxtzBxX3Pjzx+2JNfdgFe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522018; c=relaxed/simple;
	bh=SKJ86d5Slg9hnWSF3bwRszJYt2Qzk6QNY6r2ckbm2Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PiFJT6qQ0Rb9+9/JYoOdKAvlTSj4TEFw65UmM6UGfOlyHhmi+uyUins5xZyPSbBjWM5p5EiE602xGApBpItRED7WGGo1oI8S5qYSQOY07ME3xtDNXSKsZnCvbWgh/BdIw2Tb3s1LZrQUcdvI/xpqARHvfWyLhGgb082gUhDxZsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ed3Yosu2; arc=fail smtp.client-ip=52.101.229.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ed3Yosu2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sF/UwNM/99aar/5bdCZ4lP/pxQNqe6+rsyrbaxg0bK+wYsB/hdi7jmt5GXtMdiE47HwQHNpe4gJXBDo7ST8Sp59FF2mb8+NeyKeVC+N89i9nbaRgaK0MTqFFDyeGMVUziFbOLjCjRf+LeJo2rCMpgmfV0gQ21mvFuMPDZaKzRzSuRG1IIxelRJ4hmqE5/QXaF+BiK2khu3+CvEQDAaDAMb5YcbsM1c9tooa2RkesJqgH0j7RU3+ejrIGQyiMkTJgQLL9vmTVkIt7LbEGmOTke/zsZWjDrks77UGmtQiibwB/br8tKeAc6zRw32bq/ox65RC/CFIbLhNG8XmsmSUgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8YB5PCtmeUEeQaHxAYw4nitYuZYk/H72nI24UxFtNk=;
 b=vFxnPt+chHAle3mRt81YwN9bJibpkWRbcq59hCRNM8y+qFVoRCtCwIcO2clr9XmPtrvc041aVBOPm4IPojDST0LityviV0WeQ+LzrAyQKU9PQvvOoiCT4pp3ii855ac+DVu2xR8YdR/f9l7fD/ALa7sqGxKUKHaFy5uYVUgBOzDKy40Lo4/ovNRptBb3o2Z5Ok/W03Jmiu7TnsuEpJZPXymndmwD1M7FjuMqyez+XkiPGHlHLOZlaA0lUziGYLu5+1SwWALf0gPNjc0Hh+QKKquEnYBk3yK6yNRu2W5yKHZxBdMogRy2I3OGPyrcAlkPEgbJb7V6oRtXYsPe0WoE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8YB5PCtmeUEeQaHxAYw4nitYuZYk/H72nI24UxFtNk=;
 b=Ed3Yosu2nBLzF7w1YYXUP1uV/Twt7f/jnUcoM9KGCyZE9gcMsq6DjJnlxA7s5Neprf++A7Lmy0sXZLZ7GMAcaRVXvGNw5lTxTh3/rI9mOn45TyB9C8eDTutNUQ5Lly6oWLy6Y7r4VAhzF9LrlnylZ//qkP7NAl5Ed6eMNejCBrM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4369.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:00:09 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:00:09 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v5 5/7] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
Date: Fri,  9 Oct 2026 13:59:47 +0900
Message-ID: <20261009045949.1109871-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045949.1109871-1-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0299.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 7877a25e-b3f8-4ff6-f906-08df25c23168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rK2N1pnM7bkkSiFPM4mP02qm4W8sVkpMrmH5UKr7hXTZQCY26v4WRUe9sLuQ0R5fIyi3wbz9YBvcj7AIYfvtqXZhNOkvmalXnnInqXmvpJuFQN9kL8I2vFUUvyIXd8JF9eGdD/wn3/kIQDfGZtGI6kv9sbeolIMBrnrVULjRc+vbAbpCW6RV26gYY5scFHE8tDmq7TOeclOOt57YlsRQw2kKsXBICb+YWWv6MyJPmVIQXpslzoT9iVtg2/nmTgYiPazDnwVvlj2HvM5kVbLkA8ST6vEJzolzj4P62vLPg8Mh6QjDEyRwpxvvhmq24FslneQ9s/FFbvObsiGaHHQl0nvJhkivvcHOfMYn/R7j2ONqLBlPeOW4Nr9GxbO21khTEq/tFBQLd8Y1wthq+qt8P3tKZ1pY1Idg72RCJD7JYWfefORaIZF7L7lEfuqUJSTbm5y1Dg/Tk+ADdsZADw5oRwahQbqrWHvVqWCJVdjRaAGBKZDswsNkY8lM3jQp69uHiSwybFV6BRYkImpzIgGwm/5FOYaNFRXtneqZdasGQiD/1eCv+sbTsuBnjih7YL4zFo/PEAz2cuPhy9ZP0lpG8n8XaV6FbuE7zepTG02qfChJNomUTFNHdojxlD2GoOw0vbiGrJMypU4t0szmVJ4YDDIJx8dD65oJqwZU68e8FEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JDI24VmznGTAzbYvf0wLa/YFDbxcH8eopiI4h5+mcs7jBVAHnsjcj94yvlQx?=
 =?us-ascii?Q?JhXRhEXs8TOF1/nRrFhZ1PA7he3NsffvCPC10+SWD5iltnDJtqqs14pwIUmN?=
 =?us-ascii?Q?/f4hNDMzcAkaoFeeJNjiOa9d4Ls9T1KFO2eii7ExF4x/R+PL6YzTjUQ5y/P2?=
 =?us-ascii?Q?gAyLJOKjIAKkt9Q/+1p7jCgAk4iBq0nBUfPHMxQJXVx7d02APFP44rBe2dri?=
 =?us-ascii?Q?ERKFTGNC3IhgGHtrpvIAYIqkN1poRgddWwoHRbqorWbx4ZovUZB+xZqYRXi7?=
 =?us-ascii?Q?QfTYyjLMzlTch/53pE4J1W26eRasIrb39Kyt68n/jWRpf9+z7oIQYNCy7bWh?=
 =?us-ascii?Q?1R3tZfWiB7ROuzGaE88c6HavMui1i+yxdBWcs+fBggGRl5OwZZDZUaIbm073?=
 =?us-ascii?Q?JVsxeqNDzfqRfYOac3zwZ5u2vmHxGOH579lAjmsFgPFRpdxL/dAQxlRYttCH?=
 =?us-ascii?Q?9XQOm5GN/WaMrlCmVh7zYQfy0nEhYP4bSS7CLRHMtZyq5QqquzgjHYgu7eQ+?=
 =?us-ascii?Q?C9lGQ8oWDEcGDcw9HC5n8sYQaJSegJKQ2WdPPdk1DCxzaAxK463GhT0leQjb?=
 =?us-ascii?Q?yrrpYM3C3+y6Ad2JeBGARmMxkg4dWmiLV63cGiqC5Im4zTmXFqNRloWeyq6A?=
 =?us-ascii?Q?BA7QtnP/HovTBoWfu8EEvK1RdjCInsVf5734+j2Lnm05T/bl3Uh7BxAAv4b/?=
 =?us-ascii?Q?7/s0ExpzmutWhiEALRwa5RD4tzMnySh9btLYZ5nREeV+QQ8lLaLwgEC9Vevz?=
 =?us-ascii?Q?jtF/c7nQtmuG1Eap0KYuxbDqYxqXKON9MLRqlG2DxxftIRX4w/kbfZNsyNmb?=
 =?us-ascii?Q?RkErQHKYrOqQsK9dlIK2Ngk76DNORSK24KV3NkJXgQDa4kocoFGb3Jqs8aZ3?=
 =?us-ascii?Q?pm2y38c8aLmnOvgfhRNBDtMESrwc3UWIAAHZfkSPBralI7UXZFvtO7juXnha?=
 =?us-ascii?Q?c4Jb2SopLC3gG6dF5a/DmInIyt67EIB6qC+r7QH/56y8HwkNQJBADPMmxDI5?=
 =?us-ascii?Q?T+UovJrYuOUcmlVlnpFMi8Dg6uBf48E9Vld7pJRrIAqWhEWsYE+deDZbL9TB?=
 =?us-ascii?Q?vCgeOMvx0aACyozPW9YFTuz6Xd+AH+nNHwisvPwHkCZuFzbij4UgyldlA7w2?=
 =?us-ascii?Q?SsruFp4H8FBsDT+uTU6lCj+AoF2gceiR2p4pJIQQrk3o5iOEzQonATkJxdO5?=
 =?us-ascii?Q?usL7AEK4ZTSAnEVOD5GmELRygfYQOItXkF+aBT06Dqz91cK5843z9+DiJg38?=
 =?us-ascii?Q?Y1gomH/2CBnbiz/CKPk9h0aERP1KhoL+wLLakM3L00FAi4hrFPT7E+/E0ge4?=
 =?us-ascii?Q?78hrJ5nObQPg3HIiqOMgL6+nKhuF8F0IFbxlnLkmcFcbY3oWFge0bycl+6ML?=
 =?us-ascii?Q?AS49/CLd7LFtfaKmi1flh7jSGjJE2kOyv1+RRdDyXjtwvvOUUhfFpjSH4YIj?=
 =?us-ascii?Q?8ZmW9gY3dHcpncIVg7l3rKQdI2b/tOEycq1l1HVfT0DjfvEk53FZt9sZ90n7?=
 =?us-ascii?Q?2Icd2EXbj/oMjxiyxNSFk/6cBA5+fKk9CK2YHLS1knxbwN75Sp3ngS4BY6/n?=
 =?us-ascii?Q?EqS9MNcCnifKHvVOk0nualEMFzw2N4Q/9b6lrYk/LAhE+3iSutAzxTCxRx0U?=
 =?us-ascii?Q?e72J24oprXRJKvOXKnc2ZoD8ZiVGTI74AgKEeMJGl7Y80/drDI7emrKjRtRz?=
 =?us-ascii?Q?kMDHITh0nS559c34alVcPj6aH2sFmKjACNqjETHsDNg7aVxUZyWa/C9WW+To?=
 =?us-ascii?Q?FW8f25c46KLBfpt+dOAC/4XQhLtUuFTOsYee7WHOxTAKnc2Zc0xq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7877a25e-b3f8-4ff6-f906-08df25c23168
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 05:00:09.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvExoIaXiG+1s6JeaFa1vYcP3hKyJtOKGatQFoheCs3ywKDweOngkfA0Clqd45CCuinRws+jjxR+zw2hSCm4VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4369

Some endpoint configurations have no spare BAR for DMA resources. Allow
dma_bar to select an MW BAR and place the DMA ranges after that MW.

DMA submaps have fixed BAR offsets, so a shared MW translation must cover
its configured size. Report that size as the translation alignment and
require it to be a power of two.

BAR sharing requires ntb_hw_epf to parse the DMA extension, since older
versions treat the whole BAR as an MW.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v5:
  - Simplify the implementation by:
    * dropping redundant submap count checks
    * checking the shared MW size during collection to avoid a second MW
      scan.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 148 +++++++++++++-----
 1 file changed, 113 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 9b376ab87225..7ab3b94c6aa0 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
 
@@ -167,12 +168,13 @@ struct epf_ntb_ctrl {
 } __packed;
 
 struct epf_ntb_dma {
+	struct mutex lock; /* Serialize DMA submap and MW updates */
 	struct epf_ntb_dma_ctrl ctrl;
 	struct dma_chan *dchan[EDMA_MAX_RD_CH];
 	void *bar_scratch;
 	dma_addr_t bar_scratch_phys;
 	size_t bar_scratch_size;
-	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
 	struct pci_epf_bar_submap *reg_submap;
 	unsigned int num_submap;
 	u16 rd_ch_cnt;
@@ -273,6 +275,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
+static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	unsigned int i;
+
+	for (i = 0; i < ntb->num_mws; i++)
+		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
+			return ntb->mws_size[i];
+
+	return 0;
+}
+
+static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
+}
+
 struct epf_ntb_dma_filter {
 	struct device *dev;
 	int chan_id;
@@ -397,6 +415,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	unsigned int i;
 	size_t align;
 	u32 next = 0;
+	u64 offset;
 	int ret;
 
 	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
@@ -415,9 +434,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	if (!is_power_of_2(align))
 		return -EINVAL;
 
-	if (epf_ntb_is_bar_used(ntb, barno) ||
-	    pci_epc_get_next_free_bar(features, barno) != barno)
+	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
+	    barno == ntb->epf_ntb_bar[BAR_DB])
+		return -EINVAL;
+
+	offset = epf_ntb_dma_bar_offset(ntb, barno);
+	if (!offset &&
+	    (epf_ntb_is_bar_used(ntb, barno) ||
+	     pci_epc_get_next_free_bar(features, barno) != barno))
+		return -EINVAL;
+	if (offset > U32_MAX)
+		return -EOVERFLOW;
+	if (offset && !is_power_of_2(offset))
 		return -EINVAL;
+	dma->ctrl.submap.offset = offset;
+	next = offset;
+	if (next) {
+		/*
+		 * submap[0] covers the MW prefix. Keep its temporary
+		 * target at address 0 until the MW translation is
+		 * installed.
+		 */
+		dma->submap[0].size = next;
+		dma->num_submap = 1;
+	}
 
 	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
 	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
@@ -452,7 +492,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 		chan->desc_addr_lo = lower_32_bits(dma_addr);
 		chan->desc_addr_hi = upper_32_bits(dma_addr);
 	}
-	dma->ctrl.submap.size = next;
+	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
 
 	dma_dev = ntb->epf->epc->dev.parent;
 	for (i = 0; i < dma->rd_ch_cnt; i++) {
@@ -525,6 +565,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
 	if (!dma)
 		return -ENOMEM;
 
+	mutex_init(&dma->lock);
+
 	switch (ctrl->u.dma_ctrl.reg_layout) {
 	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
 		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
@@ -578,21 +620,25 @@ static void epf_ntb_dma_release(struct epf_ntb *ntb)
 	ntb->dma = NULL;
 }
 
-static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
+				      const dma_addr_t *mw_addr)
 {
 	struct pci_epf_bar_submap *old_submap;
 	struct epf_ntb_dma *dma = ntb->dma;
 	unsigned int old_num_submap;
 	struct pci_epf_bar *bar;
+	dma_addr_t old_mw_addr;
 	int restore, ret;
-
-	if (!dma)
-		return 0;
+	lockdep_assert_held(&dma->lock);
 
 	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
 
 	old_submap = bar->submap;
 	old_num_submap = bar->num_submap;
+	if (mw_addr) {
+		old_mw_addr = dma->submap[0].phys_addr;
+		dma->submap[0].phys_addr = *mw_addr;
+	}
 	bar->submap = dma->submap;
 	bar->num_submap = dma->num_submap;
 
@@ -602,6 +648,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 		return 0;
 
 	/* A failed dynamic update may have already removed the old mapping. */
+	if (mw_addr)
+		dma->submap[0].phys_addr = old_mw_addr;
 	bar->submap = old_submap;
 	bar->num_submap = old_num_submap;
 	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
@@ -613,6 +661,18 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 	return ret;
 }
 
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+
+	if (!dma)
+		return 0;
+
+	guard(mutex)(&dma->lock);
+
+	return epf_ntb_dma_set_bar_locked(ntb, NULL);
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -1164,7 +1224,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
 		return -EOPNOTSUPP;
 
 	barno = ntb->epf_ntb_bar[BAR_DMA];
-	mapped_size = dma->ctrl.submap.size;
+	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
 	/*
 	 * Submaps cannot be installed until the host assigns the BAR address.
 	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
@@ -1258,6 +1318,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	bool shared;
 	int ret = 0;
 	int i;
 	u64 size;
@@ -1267,22 +1328,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-
-		ntb->epf->bar[barno].barno = barno;
-		ntb->epf->bar[barno].size = size;
-		ntb->epf->bar[barno].addr = NULL;
-		ntb->epf->bar[barno].phys_addr = 0;
-		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
-				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-				PCI_BASE_ADDRESS_MEM_TYPE_32;
-
-		ret = pci_epc_set_bar(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      &ntb->epf->bar[barno]);
-		if (ret) {
-			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
+		shared = epf_ntb_dma_shares_bar(ntb, barno);
+
+		if (!shared) {
+			ntb->epf->bar[barno].barno = barno;
+			ntb->epf->bar[barno].size = size;
+			ntb->epf->bar[barno].addr = NULL;
+			ntb->epf->bar[barno].phys_addr = 0;
+			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
+					PCI_BASE_ADDRESS_MEM_TYPE_64 :
+					PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+			ret = pci_epc_set_bar(ntb->epf->epc,
+					      ntb->epf->func_no,
+					      ntb->epf->vfunc_no,
+					      &ntb->epf->bar[barno]);
+			if (ret) {
+				dev_err(dev, "MW set failed\n");
+				goto err_alloc_mem;
+			}
 		}
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
@@ -1299,10 +1363,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
+	if (!shared)
+		pci_epc_clear_bar(ntb->epf->epc,
+				  ntb->epf->func_no,
+				  ntb->epf->vfunc_no,
+				  &ntb->epf->bar[barno]);
 err_alloc_mem:
 	epf_ntb_mw_bar_clear(ntb, i);
 	return ret;
@@ -1320,10 +1385,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
 	for (i = 0; i < num_mws; i++) {
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-		pci_epc_clear_bar(ntb->epf->epc,
-				  ntb->epf->func_no,
-				  ntb->epf->vfunc_no,
-				  &ntb->epf->bar[barno]);
+		if (!epf_ntb_dma_shares_bar(ntb, barno))
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
 
 		pci_epc_mem_free_addr(ntb->epf->epc,
 				      ntb->vpci_mw_phy[i],
@@ -1925,6 +1991,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	dev = &ndev->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
+	if (epf_ntb_dma_shares_bar(ntb, barno)) {
+		/* DMA submaps start after the configured MW size. */
+		if (size != ntb->mws_size[idx])
+			return -EINVAL;
+
+		guard(mutex)(&ntb->dma->lock);
+
+		return epf_ntb_dma_set_bar_locked(ntb, &addr);
+	}
+
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
@@ -2103,15 +2179,17 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 			resource_size_t *size_max)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+	u64 size = ntb->mws_size[idx];
 
 	if (addr_align)
 		*addr_align = SZ_4K;
 
 	if (size_align)
-		*size_align = 1;
+		*size_align = epf_ntb_dma_shares_bar(ntb, barno) ? size : 1;
 
 	if (size_max)
-		*size_max = ntb->mws_size[idx];
+		*size_max = size;
 
 	return 0;
 }
-- 
2.51.0

