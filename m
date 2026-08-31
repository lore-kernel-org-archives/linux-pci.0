Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020088.outbound.protection.outlook.com [52.101.229.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E5435AAA;
	Mon, 31 Aug 2026 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200832; cv=fail; b=DE/df3Mj9mQ5iYgb40cFXsf87nBIZjpXULwgUpXAFPcvoRjWqJG13LRmbmXhmNy7FzbQZ5WEBkrmkTJR/hJ3XL3SwLQdxUtkC+8bXDM1hvJyJRB+7yK8ZoBANxEwPcFUvIz3H3feQUZabX4X+X52DqIyapPwujAvh25otKdtqNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200832; c=relaxed/simple;
	bh=i2Ebbj7GhjdlWm0551BOyuMkTvR0C8tKesgShvLNmc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=toxZv3yZ07an9TK29L2OL2XczIX9DIkLTF8g8rWyl10wbPkG8HDXuE0jj84xxzXDCDSvfP43R0N9UKl7koUA10JIeX1fH4FE5z+fupJVuHxUGv0nJ93XEUItLdY9cuVhLF6uXagQqykHwgB0iI6HnD0TQM8DAY9Lg2Gv3/EMpy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XHBroxtr; arc=fail smtp.client-ip=52.101.229.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XHBroxtr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jinUYf0y4dMESUue2hXcRjWHXx2xteRJMQFba4HV4VJfr32IQZroxvwM6akW1HN1x29ng6kbddRkdwQhGIOBwZBexYJQI+1i2ls0Rw3AdGn1qvuT6qFLFaZMEJLB63RutmVysEk9jruIe/M2bJYhdafpMWqaRKzXS3oJY/wsNUcmsofWGALr52UQM01vx0haf1fBHX9BkyzV1pO237cXzvusmFlTHjSnf43CFmxIBVeFjoKDPP4BOJDzjA4h1tqVGu0z1VZQNfsov3abvCGbWpDhYb5MuTjXWMoTyx5AuraILsudWVgQ2vKIiGrG+GFbKAWPO6P3zjqy5H0NW/u5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg+DhXac8DsjZtGaf1S6dAclGMKxhDnktgOQGTSVriE=;
 b=ZAY/qPtjpjkl1A4kb8QvSwfvpfIdfpAtrncuPPXd/rhivptskpGzfp6aTPsrWdcryyEPYXARo/YIlMjUSNtSbVKKjODENMgRJOO2BmIHOVL3fzK+T83A5xh4F3O4wv00w0FozOpDVFz89u9ZWtwC8P+th+NF2aQQ0zokOALLr/PrRcj5UjAd9lKCp2OCaqnbNLsAHcyWlhpMF68wO6CPr0H8Z/iE75Yycau2BMQg3HXFCdHA4515l93frTcScI+iNdUCCjtu5o6j2BsbZ2vhV378huwiFGodzrLn+REumaPzMgg2v09kXO1SJEBUwKYOzwOev9SOouGGdKqYT2U0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg+DhXac8DsjZtGaf1S6dAclGMKxhDnktgOQGTSVriE=;
 b=XHBroxtrok03RPvJKWWkwlOirbamOUa197I2QNQtGw3BbTEALH6kui8zjYzlZglMfEhyAZ8R9AXzX6z5chR9EUsQdbkWtQG1prAS2+rOfrDgB/mOexZjVjZtxtmRO3Ko/tC6D7if6LSz0NkiigcgbNTU1NdaYoevkf3epQZAcuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1802.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:27:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:27:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
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
Subject: [PATCH v3 4/7] PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
Date: Tue,  1 Sep 2026 03:26:54 +0900
Message-ID: <20260831182657.329614-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260831182657.329614-1-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: e3654b17-c3d7-433f-cec8-08df078d7486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|366016|376014|22082099003|18002099003|56012099006|6133799003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	tq0srCTzj9f60EsMs0imPrsgtu+1WkqAJKlvQo4t3Mg2bp6qav6GWazQBXMpfIvx7PfIFKQ/z0kfBA1+IpUyKfQ9eZvEI7bixu0AJZHd6qLPW+5JFBoUMpdy8ahy+plwPbAEXR3OXU2CYESI8LnNswFmGjBLoCiAc8elRHrOF/WIIriPkcvh4R4W2kbInGaypM2pSlo38qTKE4DFLFJxPKgsVGrCrIi58GOb8e8YiyksQIPuQotFkSlgXN/ArZ5DFlUA7ZSJlQW+WSzOnGyDxV5rlUfWNTl0bO2naAnkjvd2xzecPrrX6fyfOSVjGYeAHoHZyYPxiHZUFTlKOpb143JymZLid66SWajW3GsCGR3tgHpNBZxO0YZAsMM7nPf5UmfamC5QxEQXyxziCGgJkebIoaxW/Hmqk9fLUsC3U1ZSpQwrFXP5q66z7gf1wHJEMAhrYIUC2bPPs3YZp2fbt6T9ZAYKFTLIq/nk8fhYSMzjMpKVrGVW23qJTyy/0vxJKEhLb2msXwjicOWVXSZRN4qt37gA7OWJMAQlv4qvgeOi4o+8gsA/WyHQ6GsVGQMYSEd2yOUt9i9tY4atYRvZrT3EQWIm1emHxpXpa/VYPjCGD+Dq+i4F+IIQddwJChsNc+6h0aV8BKBAT4CNxdVcSmm4sYtw55FeQsWTBKTi8cM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?il1wNd0uqfnCOkwUzkz0vKlB+nXh8QIWVMy0Ggge+46RCXIc0b84zimNF4mz?=
 =?us-ascii?Q?AfI1Noo3NaaxZtlGbxPrxIfqubAC+Z+fEqqlgw9NdASnnJ2gqALrRnDahB9b?=
 =?us-ascii?Q?m8YanZ6NRvJtBJkDYsiMhjhotDpn+IzquocjdKwovcTuJQMpSsJigW/CmdSV?=
 =?us-ascii?Q?/A47iQNuzKG1vHxAx/l0WN/anfH6cE2nSGuY6CMW9KJCKE4f8zwjX4AmJ4+L?=
 =?us-ascii?Q?hZfKRRr6d14mt5yRBdG8JzJGHjTxP8KEDnXoIPQAUoqXMzj5hogDgh14FuoS?=
 =?us-ascii?Q?TNFIZD0Zy08SVeidSr/EFw1ssb3S4cQgU/xU6FcEazB4WuaOMsgD0d1F/W1x?=
 =?us-ascii?Q?VI2pZ/msb0OADimsws+XY+El/ENbkcmbyGV8x+/e6j3BxAI3GcLr4sLMTZEv?=
 =?us-ascii?Q?vAGOE4/e+lox7xlPaOGfcFaGeotOVXhB7TAODl6KNHLr/E2w5SYRl9mrmxj2?=
 =?us-ascii?Q?MfNsm0ueZbex2+V3haDz1TCCh6BUIWTOFtakthd9fYbC57GKrIFfPOXPiAyH?=
 =?us-ascii?Q?mmir3n6IczekCAIF3GNkCCnWEtbyFe4xqUtPjnrglphcJuIfq+1zF7DJQ/HM?=
 =?us-ascii?Q?KkJq15RODOHJiswV/EP2paXBIpe7KrpGax0ihcOqn7k1FBIiAcuiHzsdXtN3?=
 =?us-ascii?Q?bwFspFAC2ES6SuZ+fiWMdEDmlKKIBTmLceGCXi/+MrzBfAxzEpuGLdyC1oYX?=
 =?us-ascii?Q?KycdCaD1IERpfVPs7S2ul079udJ1ftP0ZSx75Ns6yYura8zgBEiT/j28QvGs?=
 =?us-ascii?Q?+eUpL94rO5xGv3I8iD2eiF7VBjIFs0HeaR1JP1athJwGh9oM5sU4VYyI+ER/?=
 =?us-ascii?Q?NS46pvcSWxRoXamc2MTa4c9XV+O3KPow7E2a1I3IXxY+Pc+bVdVneQI5sdGf?=
 =?us-ascii?Q?Nf4k17r3x8ldbn2bDNXV0kYLTluQIuESRyJbs9VBlnuyTi4ZqeXCY3E8FW9n?=
 =?us-ascii?Q?vF0GOCyfE9uACBzXNHr8g0Iqo8AN8JZ8BVMvflqtoJ3HnGYAQbn32Ex5p5RV?=
 =?us-ascii?Q?KA3m4bZxvIp1eE8pn5PzQu9SppesaZjgHLpiKJWgK/S/hoeO/JoBlbukv/lJ?=
 =?us-ascii?Q?8HiD7u+PNCihAIygNCewmd5D8NEDoEZMDnFRBB8fbV42zhlB5uxoL9Nz91x1?=
 =?us-ascii?Q?uYjhCVAE2LUwsosGMd7YJh3UL39dIoJI+fFmEwsne6Jb38QJ37lAYnhLvRrN?=
 =?us-ascii?Q?BshdQeD0uXbMe4go+YHBNEaKKi6bRsTFHbCW6prrOLwcIKZWSW/gGNhkyU/T?=
 =?us-ascii?Q?AfxAgpvOKsZRkaMSQoMJYBft+RA+0nRjXUITt/sY2OnrN/0OCmtQGMP5sAwy?=
 =?us-ascii?Q?sDqxvgKzGWGDDEAX5fVL2lSiTcvUWpxAxSZAf7sr1yKEHiJD8KXnl+mHJUP8?=
 =?us-ascii?Q?DG7oT5i5OIagagVs1u/dEofXJIDQTVJlgsmiWJisMOGkALz3iHfvLHnwrNdC?=
 =?us-ascii?Q?8jygrg3v62T++PQ+th8Wz0fq335T8vOvYBHzWlPfwD0sNAqZ3OOGdtvuPWwQ?=
 =?us-ascii?Q?CQ/tl5sZzEQVkDgh6P+UL/rXWt62Jt7QEH8ciJBlY3SaVEpy8mX1Wdg5MT+4?=
 =?us-ascii?Q?BHk64jMdLH5Fj0TqKCU+7Bq0Cm7ul34iYQVUQ0ZI5kus02ef/Qf1qu49htH+?=
 =?us-ascii?Q?8xM58aE0/OjX4LjLFw2eLTiULwUfe4GF2QaMT+nitjoOkTSdm/ZCWUVPQH1/?=
 =?us-ascii?Q?K5p53WXs8I6GdJFExfs8q9FwH7Nt4i76dmi1U766A4csZvZ2zx8/sGf3Oi85?=
 =?us-ascii?Q?tsZ92x0pzfNlCgFK+qj0JxXMMAt2Tz9aykFWunnjDnqhALa/Y5Iy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e3654b17-c3d7-433f-cec8-08df078d7486
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:27:03.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUkoJkzoUkHqjvaYqs28oahTaPQ/vo3dSlBIXA5o1a1KtASOGQaSR42298qmpKHPpyqAOcrHKVLc2IoOteXunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1802

An RC may use endpoint-local DMA read channels to transfer data directly
to an endpoint DMA address once both sides agree to use them. Quiescing
an unrolled eDMA channel disables its whole direction, so reserve the
complete read direction and route its interrupts to the RC when dma_bar
is configured.

Describe the controller and per-channel descriptor memory in a private
control-region extension.

Add a dma_bar configfs attribute. An explicit BAR selection enables DMA
export; leaving it unassigned keeps the feature disabled.

Keep resources already assigned to a BAR in place, and map the rest
through the selected dma_bar.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Use dma_bar as the opt-in and drop use_dma and automatic BAR selection.
  - Split DMA/MW BAR sharing and the documentation into separate patches.
  - Avoid mixing cleanup helpers with goto-based error paths. (Sashiko)
  - Use pci_epf_assign_bar_space() and back only uncovered BAR ranges.
    (Sashiko)

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 575 +++++++++++++++++-
 1 file changed, 567 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index d12d134ce553..1842493c33b0 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -39,8 +39,12 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <linux/pci-ep-msi.h>
@@ -56,6 +60,8 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define COMMAND_TEARDOWN_MW		4
 #define COMMAND_LINK_UP			5
 #define COMMAND_LINK_DOWN		6
+#define COMMAND_CONFIGURE_DMA		7
+#define COMMAND_TEARDOWN_DMA		8
 
 #define COMMAND_STATUS_OK		1
 #define COMMAND_STATUS_ERROR		2
@@ -69,6 +75,10 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define MSIX_ENABLE			BIT(16)
 #define MAX_MW				4
 
+#define EPF_NTB_DMA_MAGIC		0x414d444e /* "NDMA": NTB DMA */
+#define EPF_NTB_DMA_REVISION		1
+#define EPF_NTB_DMA_TYPE_DW_EDMA	1
+
 /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
 #define VNTB_PEER_DB_WORK_BUDGET	5
 
@@ -79,6 +89,7 @@ enum epf_ntb_bar {
 	BAR_MW2,
 	BAR_MW3,
 	BAR_MW4,
+	BAR_DMA,
 	VNTB_BAR_NUM,
 };
 
@@ -91,6 +102,30 @@ enum epf_irq_slot {
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
 #define MAX_DB_COUNT			32
 
+/* Private wire extension consumed by ntb_hw_epf. */
+struct epf_ntb_dma_region_ctrl {
+	u32 bar;
+	u32 offset;
+	u32 size;
+} __packed;
+
+struct epf_ntb_dma_chan_ctrl {
+	struct epf_ntb_dma_region_ctrl desc;
+	u32 desc_addr_lo;
+	u32 desc_addr_hi;
+} __packed;
+
+struct epf_ntb_dma_ctrl {
+	u32 magic;
+	u16 revision;
+	u16 length;
+	u32 type;
+	/* BAR range occupied by resources without a fixed BAR assignment. */
+	struct epf_ntb_dma_region_ctrl submap;
+	struct epf_ntb_dma_region_ctrl reg;
+	struct epf_ntb_dma_chan_ctrl chan[EDMA_MAX_RD_CH];
+} __packed;
+
 /*
  * +--------------------------------------------------+ Base
  * |                                                  |
@@ -129,8 +164,21 @@ struct epf_ntb_ctrl {
 	u32 db_entry_size;
 	u32 db_data[MAX_DB_COUNT];
 	u32 db_offset[MAX_DB_COUNT];
+	struct epf_ntb_dma_ctrl dma;
 } __packed;
 
+struct epf_ntb_dma {
+	struct epf_ntb_dma_ctrl ctrl;
+	struct dma_chan *dchan[EDMA_MAX_RD_CH];
+	void *bar_scratch;
+	dma_addr_t bar_scratch_phys;
+	size_t bar_scratch_size;
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
+	struct pci_epf_bar_submap *reg_submap;
+	unsigned int num_submap;
+	u16 rd_ch_cnt;
+};
+
 struct epf_ntb {
 	struct ntb_dev ntb;
 	struct pci_epf *epf;
@@ -159,6 +207,7 @@ struct epf_ntb {
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
 	struct epf_ntb_ctrl *reg;
+	struct epf_ntb_dma *dma;
 
 	u32 *epf_db;
 
@@ -211,7 +260,8 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 {
 	int i;
 
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
+	/* BAR_DMA is checked separately because it may share an MW BAR. */
+	for (i = 0; i < BAR_DMA; i++) {
 		if (ntb->epf_ntb_bar[i] == barno)
 			return true;
 	}
@@ -219,6 +269,404 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
+static int epf_ntb_dma_validate_bar(struct epf_ntb *ntb,
+				    const struct pci_epc_features *features)
+{
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
+
+	if (epf_ntb_is_bar_used(ntb, barno) ||
+	    pci_epc_get_next_free_bar(features, barno) != barno)
+		return -EINVAL;
+
+	return 0;
+}
+
+struct epf_ntb_dma_filter {
+	struct device *dev;
+	int chan_id;
+};
+
+static bool epf_ntb_dma_filter(struct dma_chan *chan, void *data)
+{
+	struct epf_ntb_dma_filter *filter = data;
+
+	return chan->device->dev == filter->dev &&
+	       chan->chan_id == filter->chan_id;
+}
+
+static int epf_ntb_dma_add_region(struct epf_ntb_dma *dma,
+				  const struct pci_epc_aux_resource *resource,
+				  dma_addr_t target_addr,
+				  enum pci_barno barno, size_t align, u32 *next,
+				  struct epf_ntb_dma_region_ctrl *region)
+{
+	struct pci_epf_bar_submap *submap;
+	resource_size_t delta, map_size, size;
+	dma_addr_t base;
+
+	if (!resource->size || resource->size > U32_MAX)
+		return -EINVAL;
+
+	region->size = resource->size;
+	if (resource->bar != NO_BAR) {
+		if (resource->bar < BAR_0 || resource->bar > BAR_5 ||
+		    resource->bar_offset > U32_MAX)
+			return -EINVAL;
+
+		region->bar = resource->bar;
+		region->offset = resource->bar_offset;
+		return 0;
+	}
+	submap = &dma->submap[dma->num_submap];
+
+	/*
+	 * Meet the EPC alignment requirement by mapping an aligned superset
+	 * and advertising the resource after any leading padding.
+	 */
+	base = ALIGN_DOWN(target_addr, align);
+	delta = target_addr - base;
+	if (check_add_overflow(delta, resource->size, &size))
+		return -EOVERFLOW;
+	map_size = ALIGN(size, align);
+	if (map_size < size || map_size > U32_MAX - *next)
+		return -EOVERFLOW;
+
+	submap->phys_addr = base;
+	submap->size = map_size;
+	region->bar = barno;
+	region->offset = *next + delta;
+	*next += map_size;
+	dma->num_submap++;
+
+	return 0;
+}
+
+/* DW eDMA */
+
+static int epf_ntb_dw_edma_claim(struct device *dev, int chan_id,
+				 struct dma_chan **dchan)
+{
+	enum dw_edma_ch_irq_mode mode = DW_EDMA_CH_IRQ_REMOTE;
+	struct epf_ntb_dma_filter filter = {
+		.dev = dev,
+		.chan_id = chan_id,
+	};
+	struct dma_slave_config config = {
+		.peripheral_config = &mode,
+		.peripheral_size = sizeof(mode),
+	};
+	dma_cap_mask_t mask;
+	struct dma_chan *chan;
+	int ret;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	chan = dma_request_channel(mask, epf_ntb_dma_filter, &filter);
+	if (!chan)
+		return -EBUSY;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret) {
+		dma_release_channel(chan);
+		return ret;
+	}
+
+	*dchan = chan;
+
+	return 0;
+}
+
+static void epf_ntb_dw_edma_release_channels(struct epf_ntb *ntb,
+					     struct epf_ntb_dma *dma,
+					     bool quiesce)
+{
+	unsigned int i;
+	int ret;
+
+	if (quiesce) {
+		/*
+		 * RC programming has stopped and this EPF owns the complete read
+		 * direction, so one termination quiesces the direction.
+		 */
+		ret = dmaengine_terminate_sync(dma->dchan[0]);
+		if (ret)
+			dev_warn(&ntb->epf->dev,
+				 "failed to terminate remote DMA: %d\n", ret);
+	}
+
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		if (!dma->dchan[i])
+			continue;
+
+		dma_release_channel(dma->dchan[i]);
+	}
+}
+
+static const struct pci_epc_aux_resource *
+epf_ntb_dw_edma_find_desc(const struct pci_epc_aux_resource *resources,
+			  unsigned int count, u16 chan_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (resources[i].type == PCI_EPC_AUX_DMA_DESC_MEM &&
+		    resources[i].u.dma_desc.chan_id == chan_id)
+			return &resources[i];
+
+	return NULL;
+}
+
+static int
+epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
+			struct epf_ntb_dma *dma,
+			const struct pci_epc_aux_resource *ctrl,
+			const struct pci_epc_aux_resource *resources,
+			unsigned int count)
+{
+	const struct pci_epc_features *features;
+	const struct pci_epc_aux_resource *desc[EDMA_MAX_RD_CH];
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
+	struct device *dma_dev;
+	bool needs_submap;
+	unsigned int i;
+	size_t align;
+	u32 next = 0;
+	int ret;
+
+	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
+		return -EOPNOTSUPP;
+	if (ctrl->u.dma_ctrl.ep_to_rc_ch_cnt > EDMA_MAX_WR_CH ||
+	    !ctrl->u.dma_ctrl.rc_to_ep_ch_cnt ||
+	    ctrl->u.dma_ctrl.rc_to_ep_ch_cnt > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	dma->rd_ch_cnt = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	if (!features)
+		return -EOPNOTSUPP;
+
+	align = features->align ?: 1;
+	if (!is_power_of_2(align))
+		return -EINVAL;
+
+	needs_submap = ctrl->bar == NO_BAR;
+	/* DW eDMA static IDs place read channels after all write channels. */
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+
+		desc[i] = epf_ntb_dw_edma_find_desc(resources, count, chan_id);
+		if (!desc[i])
+			return -EINVAL;
+		needs_submap |= desc[i]->bar == NO_BAR;
+	}
+	if (needs_submap) {
+		if (!features->subrange_mapping ||
+		    !features->dynamic_inbound_mapping)
+			return -EOPNOTSUPP;
+		ret = epf_ntb_dma_validate_bar(ntb, features);
+		if (ret)
+			return ret;
+	}
+
+	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
+	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
+	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
+	dma->ctrl.submap.bar = U32_MAX;
+	dma->ctrl.length = offsetof(struct epf_ntb_dma_ctrl,
+				    chan[dma->rd_ch_cnt]);
+
+	if (ctrl->bar == NO_BAR)
+		dma->reg_submap = &dma->submap[dma->num_submap];
+	ret = epf_ntb_dma_add_region(dma, ctrl, ctrl->phys_addr,
+				     barno, align, &next, &dma->ctrl.reg);
+	if (ret)
+		return ret;
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		struct epf_ntb_dma_chan_ctrl *chan = &dma->ctrl.chan[i];
+		dma_addr_t dma_addr = desc[i]->u.dma_desc.dma_addr;
+
+		ret = epf_ntb_dma_add_region(dma, desc[i], dma_addr, barno,
+					     align, &next,
+					     &chan->desc);
+		if (ret)
+			return ret;
+		chan->desc_addr_lo = lower_32_bits(dma_addr);
+		chan->desc_addr_hi = upper_32_bits(dma_addr);
+	}
+	if (dma->num_submap) {
+		dma->ctrl.submap.bar = barno;
+		dma->ctrl.submap.size = next;
+	}
+
+	dma_dev = ntb->epf->epc->dev.parent;
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+
+		ret = epf_ntb_dw_edma_claim(dma_dev, chan_id, &dma->dchan[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Common endpoint DMA */
+
+static void epf_ntb_dma_release_channels(struct epf_ntb *ntb,
+					 struct epf_ntb_dma *dma,
+					 bool quiesce)
+{
+	switch (dma->ctrl.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		epf_ntb_dw_edma_release_channels(ntb, dma, quiesce);
+		break;
+	}
+}
+
+static int epf_ntb_dma_collect(struct epf_ntb *ntb)
+{
+	const struct pci_epc_aux_resource *ctrl = NULL;
+	struct device *dma_dev;
+	dma_addr_t dma_addr;
+	unsigned int i;
+	int count, ret;
+
+	if (ntb->epf_ntb_bar[BAR_DMA] == NO_BAR)
+		return 0;
+
+	count = pci_epc_get_aux_resources_count(ntb->epf->epc,
+						ntb->epf->func_no,
+						ntb->epf->vfunc_no);
+	if (count <= 0)
+		return count ?: -ENODEV;
+
+	struct pci_epc_aux_resource *resources __free(kfree) =
+		kcalloc(count, sizeof(*resources), GFP_KERNEL);
+	if (!resources)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no, resources, count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		if (resources[i].type != PCI_EPC_AUX_DMA_CTRL_MMIO)
+			continue;
+		if (ctrl)
+			return -EINVAL;
+		ctrl = &resources[i];
+	}
+	if (!ctrl)
+		return -ENODEV;
+
+	struct epf_ntb_dma *dma __free(kfree) =
+		kzalloc(sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	switch (ctrl->u.dma_ctrl.reg_layout) {
+	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
+		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (ret) {
+		epf_ntb_dma_release_channels(ntb, dma, false);
+		return ret;
+	}
+
+	/*
+	 * CTRL_MMIO carries a CPU physical address, while DMA_DESC_MEM already
+	 * carries an endpoint DMA address. Convert only the former.
+	 */
+	if (dma->reg_submap) {
+		dma_dev = ntb->epf->epc->dev.parent;
+		dma_addr = dma_map_resource(dma_dev,
+					    dma->reg_submap->phys_addr,
+					    dma->reg_submap->size,
+					    DMA_BIDIRECTIONAL, 0);
+		if (dma_mapping_error(dma_dev, dma_addr)) {
+			epf_ntb_dma_release_channels(ntb, dma, false);
+			return -EIO;
+		}
+		dma->reg_submap->phys_addr = dma_addr;
+	}
+
+	ntb->dma = no_free_ptr(dma);
+
+	return 0;
+}
+
+static void epf_ntb_dma_release(struct epf_ntb *ntb, bool quiesce)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct device *dev;
+
+	if (!dma)
+		return;
+
+	epf_ntb_dma_release_channels(ntb, dma, quiesce);
+	dev = ntb->epf->epc->dev.parent;
+	if (dma->reg_submap)
+		dma_unmap_resource(dev, dma->reg_submap->phys_addr,
+				   dma->reg_submap->size, DMA_BIDIRECTIONAL, 0);
+	if (dma->bar_scratch)
+		dma_free_coherent(dev, dma->bar_scratch_size,
+				  dma->bar_scratch, dma->bar_scratch_phys);
+	kfree(dma);
+	ntb->dma = NULL;
+}
+
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb, bool active)
+{
+	struct pci_epf_bar_submap *old_submap;
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	unsigned int old_num_submap;
+	int restore, ret;
+
+	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
+	old_submap = bar->submap;
+	old_num_submap = bar->num_submap;
+	bar->submap = active ? dma->submap : NULL;
+	bar->num_submap = active ? dma->num_submap : 0;
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, bar);
+	if (!ret)
+		return 0;
+
+	/* A failed dynamic update may have already removed the old mapping. */
+	bar->submap = old_submap;
+	bar->num_submap = old_num_submap;
+	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				  ntb->epf->vfunc_no, bar);
+	if (restore)
+		dev_warn(&ntb->epf->dev,
+			 "failed to restore DMA BAR mapping: %d\n", restore);
+
+	return ret;
+}
+
+static int epf_ntb_dma_set_active(struct epf_ntb *ntb, bool active)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+
+	if (!dma || !dma->num_submap)
+		return 0;
+
+	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
+	if (active == !!bar->num_submap)
+		return 0;
+
+	return epf_ntb_dma_set_bar(ntb, active);
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -339,6 +787,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		epf_ntb_teardown_mw(ntb, argument);
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
+	case COMMAND_CONFIGURE_DMA:
+	case COMMAND_TEARDOWN_DMA:
+		ret = epf_ntb_dma_set_active(ntb,
+					     command == COMMAND_CONFIGURE_DMA);
+		ctrl->command_status = ret ? COMMAND_STATUS_ERROR :
+					     COMMAND_STATUS_OK;
+		break;
 	case COMMAND_LINK_UP:
 		ntb->linkup = true;
 		ret = epf_ntb_link_up(ntb, true);
@@ -459,9 +914,8 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *   region
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
- * Allocate the Local Memory mentioned in the above diagram. The size of
- * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
- * is obtained from "spad-count" configfs entry.
+ * Allocate the control and scratchpad regions, omitting the optional DMA
+ * extension when no channels are exported.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
@@ -481,7 +935,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
 	spad_count = ntb->spad_count;
 
-	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	ctrl_size = ntb->dma ? sizeof(struct epf_ntb_ctrl) :
+			       offsetof(struct epf_ntb_ctrl, dma);
+	ctrl_size = ALIGN(ctrl_size, sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
 	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
@@ -507,6 +963,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 		ntb->reg->db_offset[i] = 0;
 	}
 
+	if (ntb->dma)
+		ctrl->dma = ntb->dma->ctrl;
+
 	return 0;
 }
 
@@ -738,6 +1197,83 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
 
+static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *features;
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct device *dev = ntb->epf->epc->dev.parent;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+	size_t backing_size;
+	u32 mapped_size;
+	int ret;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	if (!features)
+		return -EOPNOTSUPP;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	mapped_size = dma->ctrl.submap.size;
+	/*
+	 * Submaps cannot be installed until the host assigns the BAR address.
+	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
+	 * for regular vNTB MW BARs.
+	 */
+	ret = pci_epf_assign_bar_space(ntb->epf, mapped_size, barno, features,
+				       PRIMARY_INTERFACE, 0);
+	if (ret)
+		return ret;
+
+	bar = &ntb->epf->bar[barno];
+	if (bar->size > U32_MAX)
+		return -EOVERFLOW;
+
+	backing_size = bar->size - mapped_size;
+	if (backing_size) {
+		/* Back the BAR tail added by the power-of-two size rounding. */
+		dma->bar_scratch = dma_alloc_coherent(dev, backing_size,
+						      &dma->bar_scratch_phys,
+						      GFP_KERNEL);
+		if (!dma->bar_scratch)
+			return -ENOMEM;
+		dma->bar_scratch_size = backing_size;
+		if (!IS_ALIGNED(dma->bar_scratch_phys, features->align ?: 1))
+			return -EINVAL;
+
+		dma->submap[dma->num_submap++] = (struct pci_epf_bar_submap) {
+			.phys_addr = dma->bar_scratch_phys,
+			.size = backing_size,
+		};
+	}
+
+	return pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			       ntb->epf->vfunc_no, bar);
+}
+
+static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+
+	if (!dma || !dma->num_submap)
+		return;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	bar = &ntb->epf->bar[barno];
+	pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no,
+			  ntb->epf->vfunc_no, bar);
+	bar->submap = NULL;
+	bar->num_submap = 0;
+	bar->phys_addr = 0;
+	bar->addr = NULL;
+	bar->size = 0;
+	bar->mem_size = 0;
+	bar->barno = 0;
+	bar->flags = 0;
+}
+
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peer's outbound address space
@@ -877,7 +1413,8 @@ static int epf_ntb_find_bar(struct epf_ntb *ntb,
 		 * Verify if the BAR found is not already assigned
 		 * through the provided configuration
 		 */
-		if (!epf_ntb_is_bar_used(ntb, barno))
+		if (ntb->epf_ntb_bar[BAR_DMA] != barno &&
+		    !epf_ntb_is_bar_used(ntb, barno))
 			ntb->epf_ntb_bar[bar] = barno;
 
 		barno += 1;
@@ -976,11 +1513,19 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 		goto err_mw_bar_init;
 	}
 
+	if (ntb->dma && ntb->dma->num_submap) {
+		ret = epf_ntb_dma_bar_init(ntb);
+		if (ret) {
+			dev_err(dev, "DMA BAR init failed\n");
+			goto err_dma_bar_init;
+		}
+	}
+
 	if (vfunc_no <= 1) {
 		ret = pci_epc_write_header(epc, func_no, vfunc_no, epf->header);
 		if (ret) {
 			dev_err(dev, "Configuration header write failed\n");
-			goto err_write_header;
+			goto err_dma_bar_init;
 		}
 	}
 
@@ -992,7 +1537,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 
 	return 0;
 
-err_write_header:
+err_dma_bar_init:
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 err_mw_bar_init:
 	epf_ntb_db_bar_clear(ntb);
@@ -1015,6 +1561,7 @@ static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 	disable_delayed_work_sync(&ntb->cmd_handler);
 	disable_work_sync(&ntb->peer_db_work);
 	atomic64_set(&ntb->peer_db_pending, 0);
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1221,10 +1768,13 @@ EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
 EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
+EPF_NTB_BAR_R(dma_bar, BAR_DMA)
+EPF_NTB_BAR_W(dma_bar, BAR_DMA)
 
 CONFIGFS_ATTR(epf_ntb_, spad_count);
 CONFIGFS_ATTR(epf_ntb_, db_count);
 CONFIGFS_ATTR(epf_ntb_, num_mws);
+CONFIGFS_ATTR(epf_ntb_, dma_bar);
 CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
@@ -1243,6 +1793,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
 	&epf_ntb_attr_db_count,
 	&epf_ntb_attr_num_mws,
+	&epf_ntb_attr_dma_bar,
 	&epf_ntb_attr_mw1,
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
@@ -1743,6 +2294,12 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		return ret;
 	}
 
+	ret = epf_ntb_dma_collect(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to prepare NTB DMA export\n");
+		return ret;
+	}
+
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to allocate BAR memory\n");
@@ -1779,6 +2336,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	epf_ntb_epc_cleanup(ntb);
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb, false);
 
 	return ret;
 }
@@ -1795,6 +2353,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb, true);
 
 	pci_unregister_driver(&vntb_pci_driver);
 }
-- 
2.51.0

