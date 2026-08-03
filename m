Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B342CB00;
	Mon,  3 Aug 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780292; cv=fail; b=E3T4SuyKc+TyjJljzt+ph6y5e80ALVASPeEEN46jdECxoLyjDimTisrUEhhknV8dyUMfydfkgKHHsUpJV9GVbZNU/xSxm96lx7FPFhLWf4ffFKa2q/CBpjM3s7/ALlC72h3Fq7Fd0lk+bC6/DDr3NCR/pTgk3llIvIVFJ+n2Bdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780292; c=relaxed/simple;
	bh=O0Ho8J6i2t6fEAUlGaHA92BaKtSIyd/eXIcRwgzN6qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bswONULCRlABgLo2d4AziUMDKUMYqRt5ix2+njEBvv21kVKdJGb1ba9zAqViThGuPHQe7UCwLVjV9zsNgvh2DIOy7hektYQBcuWVwQx7V/VepSCvNHYcP89KRwIahZ8FSajBZsrhxq4mC/ffSBE7K/sgjzIp+kEdui3z6a4cJ7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qudVY6zC; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qudVY6zC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lj1pVg6K7yS6knoHjpG/Vh0In8kb5rDjXej7ubZt0A6x/Ib89h06+LWep22YdSL8AKefSOEZ8ZLBAbLNt4NucTRp9O3HCumlIN3fq6mRTYkKNycoUoX7/aIUR0H+6UeteteL4MMt6OSJPsxlEURPZ8OYQ1eXvBU5plmkvNrw/Bvj+5bjAAUWOWBzsUC8CK9ziTXu3oifPDpNCOl5FcxL5vWtgdxvEGT6S2EmAcO4Ltx8NS88yuVVQM6AIXg7Ha/57DrM7Qx1jU7VpuQGpM4nutwHS+nZeXRIEAThxm7zHb8r84HyXP5/d1vb4I7v7R7yMaswU86AMcNsQgwpFYfpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geEuVjCuehft+hbLXxu5XRXdHimrCPTVDZwD0Z5xTyc=;
 b=IMUE+RCD6LZdTCf3840g4YEei6CKsAK83j+Qd0UIYrSdJuAEM2w7JqvN2FsvnccZQRxVrTRqOBSEBdf+bH+8yytfz3vPRvDcqWQnry9XViYXE67NZyMhotPXgNxGVr4MhhNOP//2NzGq5BkpWP1dtcrF6MYX+3eo7CFuKZltwbodiarsRlsARH2oQax5UwrcHNdl5Y0ajP+VoIbvps6r43zYCEjNThWMoC8bAAdWiSySLVp9rBLfBX2z/i7bwp50uzGvBnlensUlrpCQ8pcerEiKFkU3i2mqkBO326yWj1KQ1YZeBZfrcdCeKASLUGt4NH0XmOgUaD1NKXMw0UUyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geEuVjCuehft+hbLXxu5XRXdHimrCPTVDZwD0Z5xTyc=;
 b=qudVY6zCh6gCPtQczl84jlmvTuWe+G2QksERHj11Uax8G6mndc9h/pEFtlimDI82fewPZXg0MnNPhnFQXV3bxwaqhrQ8njr2wS1y5PRnmCHA8h7ogEMziMLo4RgkXO7Ug2rtCOz97eTLJoiczxVeB5w4nIkAtCGsHpx21Iq45tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:44 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 03/11] PCI: endpoint: pci-epf-vntb: Add packed MW layout handling
Date: Tue,  4 Aug 2026 03:04:30 +0900
Message-ID: <20260803180439.1963864-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4b7839-b187-4c2c-5226-08def189b274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jCUL5GXgZvWR8Vnx7nB7qBW2tWBU7aab5QMftd5nMFfhPEzuUY7H2mIiFiyAayTg+/60qJ/sQQpb6q1WnHSLLnvC3q+0i3yeqmom541KEmZlfSGA8gyocLusm/lYKebYG4x2sxpnEdk8rauNrJR/gwKE+RlJs7Df7cAxIEb935KoAG7DvIfT0ecVK+2d+HelpE660A8zOmDGMtTH+t+2O0bpbkg8CQwywpLJCVoXJkL1d2aaSSj8Ino0oqppvZWeV+p+t0Puq8gMpJ/oGzDYk9RUAIBxK0IbuVI/RvEhTHD4ZiadKcwNzV8WTuPNmJ2jwApNAKb6Lcd/6/0Suip+VWOlPMDUm75CuyE4V00FDrLUmlbAGU5KyTvq4SmxVk+GukZa59PVDSR1tRcLIN+oS00Zex13mJd9W2k/Lh2FLMsuRTKC6aFfF0P3wAMGHIkNuTMbGYELvUxdSf0OmNoHCib8jexNnR56O5BhkQyuQkHrgn7a1ah3Sg+FvJ6l2Hv6D5nAxLbwbmHGAR4qx+/zOhTgk3fhXrcCCb9r4eLMCu+Wn46LrnG5zBdd0lIy9nJl49WRouGneZCOo12AykuGVmRdtPVHz4fHOdHH2t2/5CW+9vCJNGLkLkunljbtfFJ7+khrHLgtZradbfqrkNwFq4vZMvmZLM8ERzwasaCYu3G/mi408LER26NZ5rjIyMB5JKbDwupXwxgyfiywALgqFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4KwHHA6TcdVMHY0eY/aQUSRHaJtFlgKwBfUvdab11crRN2/bnIHL+pFXOzXE?=
 =?us-ascii?Q?XlzfMs60dlLz87Bm9N8JMP1TL5i7f77oFKQzaBiDHORAjEhbfunuKCZVzysT?=
 =?us-ascii?Q?zUItLpXhg9kJqCGGWRX4Ll3g/ygRiCF3CWjslvgjBfBKs3QTNjNo3cntpzZT?=
 =?us-ascii?Q?GASbiuOkzFwLXJQWICcAy/do5xr/fWDfC5cHDvWWnufXsCgjYdOSaT/+8SwE?=
 =?us-ascii?Q?cQVXL4vq410aUceRI38GVmhgVRhII7oHcs/TIAMHxCc9SkFBuJ5cOAGCFMiO?=
 =?us-ascii?Q?CR7dSDjAPq59KwB71JREEfiXtN7qG3t8WogPiadW6COI5SGMlgAQ1jKJbGYG?=
 =?us-ascii?Q?0WspHMpfONQCruhQ4CV3Zd9a3MURt/yx7joLV6s9ZFaIp8T5z2x8e5nVWE4k?=
 =?us-ascii?Q?T6sIbchhOi1aQIFWEDjWGA869wDyE21Gh5DK+3kNc55Nl2c3fBB5oqjbtWCI?=
 =?us-ascii?Q?FhloRXivhzaVap2puWu2Ju3eh+z0ZDjXYqqpqDa8Rrk2ozqlADiQbGoEf5W0?=
 =?us-ascii?Q?c6a4tVwKvGii2EnxxfDYnfwdrxGfUzomsrpqo+11jNGW7DOJUR9U3sj7wGQQ?=
 =?us-ascii?Q?wJHnByVGwZKnLf11c48sRoXU0WUsT7ivoQdvnyby2WrQaWPxJ1QBKq5Pa7p0?=
 =?us-ascii?Q?90c55yver9UY2ppf4fy9m9MDj+zy4cuF1FoGZbqA35AVTrcA/x/ExdqBioHA?=
 =?us-ascii?Q?MWx9Nz35Aw9tlbFik0qypw7zEhDw1ozzpNE7TBH8+clG63YcbPUucdbQH6kg?=
 =?us-ascii?Q?tQvyzC7oufkhe/MzoUugFy3MYHAPHU9SCKfaKBrmdf+eZteHSGnNvNHOXJlI?=
 =?us-ascii?Q?qoiknHPLCjmvniKU2cc5kjIVqf7UYsAF/jNNf/P5wpau7zgR8kaSShTWaJ8p?=
 =?us-ascii?Q?4u7tVloIDZ+q7O8zgxtShyxaQY7WR3b52Z9EBCchag9hk+relyzaGtWZlkzZ?=
 =?us-ascii?Q?o/T+nZcq6cHrj2+K1LUdmzRqzco8k0qyzbEtbTqvzIBZif8PP2bXziSxzaKC?=
 =?us-ascii?Q?wNzXSqtEfO1ChZQLdfeGpva5BRNrSPR3AhhZxHiV3YIBZ6ozAQTUVDrU7rRO?=
 =?us-ascii?Q?ewhQNkdNG+x00bc7eKvNKPggz8ziy8HNNPLkuCH/uFJz3TkgeuPuaGhThhof?=
 =?us-ascii?Q?lzQsnZRMXN1l+kyxXQWiLbkykpc8elQOsmNTmGNInmbtuwcCWTv3ZCRY9CPX?=
 =?us-ascii?Q?1H2ntZJY1fprK3L0rZ+4Yt4yzBJIotIp+WGj9h2JgLQYwj6OQcdCUB7EzaCa?=
 =?us-ascii?Q?2RidyObU76OByP1OFnlXWa1aWhiiGMyrGP/mYxZwG0wPa5UehH+2H9wJ2YMA?=
 =?us-ascii?Q?InamfWNP90MgmCyrZW/0H+NUlfykVhcm9hKHWu5mjlStZ6bl4pBlis8Iaq8z?=
 =?us-ascii?Q?uxu6LcisjX3nrJL6QVBNsZ00qG8EHSS0dFMe4JQFhqzft7Ic5zHuvDblkzNH?=
 =?us-ascii?Q?KRAxQtBDMDikapGYbjj4k1j+4MhzXc+ucDnNszpaW7syy6bsL77fW/tTVJfe?=
 =?us-ascii?Q?mUk2yyi+iasZEpIKwdqCfs8nVsNk88MD+y/chWfGFxjF52ToFgwSVMZSlOhz?=
 =?us-ascii?Q?WA9owKWWWmMvt1OREl7+FB/Uu0tvJ9avWc/vmdY1EddBAAg0pkDhxMJkSxwb?=
 =?us-ascii?Q?GY8isY9b7PwI+22+AsZkd5AGsKk3NhN3bz0AYfCEYcoU4JpJ/YU5DavR9XtD?=
 =?us-ascii?Q?Ym3LPDAQiY7oAbSk6Scj5VyT9O6QXGt4hqgiNuBPsZz0wIDTCmVh4GXXHq1X?=
 =?us-ascii?Q?ltLLGaLX5yuh7gmdjnvegNfcjVVPH21+/DtPDrLeZsk4NKe3zG7U?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4b7839-b187-4c2c-5226-08def189b274
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:44.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ/FR6REuEVaGY/pCNfA6rmgQRf0jxcBha8weq8/XoJ4SZ4qPFshE9nV8HY8Okuhn8egKC04mn+WObgxqG1/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

Teach pci-epf-vntb to build a packed layout and advertise its logical
MWs as one version 1 translation group. Non-packed configurations keep
the version 0 layout and one MW per BAR.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 255 +++++++++++++++---
 1 file changed, 219 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c3caec927d74..f22459e5a8c6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -68,6 +68,9 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define DB_COUNT_MASK			GENMASK(15, 0)
 #define MSIX_ENABLE			BIT(16)
 #define MAX_MW				4
+#define EPF_NTB_MAX_MW			16
+#define EPF_NTB_CTRL_V0			0
+#define EPF_NTB_CTRL_V1			1
 
 /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
 #define VNTB_PEER_DB_WORK_BUDGET	5
@@ -119,7 +122,7 @@ struct epf_ntb_ctrl {
 	u32 argument;
 	u16 command_status;
 	u16 link_status;
-	u32 topology;
+	u32 version;
 	u64 addr;
 	u64 size;
 	u32 num_mws;
@@ -129,17 +132,27 @@ struct epf_ntb_ctrl {
 	u32 db_entry_size;
 	u32 db_data[MAX_DB_COUNT];
 	u32 db_offset[MAX_DB_COUNT];
+	u32 mw_bar;
+	u32 mw_group_size;
 } __packed;
 
+struct epf_ntb_mw_layout {
+	enum pci_barno barno;
+	u64 offset;
+	u64 size;
+};
+
 struct epf_ntb {
 	struct ntb_dev ntb;
 	struct pci_epf *epf;
 	struct config_group group;
 
 	u32 num_mws;
+	u32 packed_mws;
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
+	struct epf_ntb_mw_layout mw_layout[EPF_NTB_MAX_MW];
 	atomic64_t db;
 	atomic64_t peer_db_pending;
 	struct work_struct peer_db_work;
@@ -162,8 +175,8 @@ struct epf_ntb {
 
 	u32 *epf_db;
 
-	phys_addr_t vpci_mw_phy[MAX_MW];
-	void __iomem *vpci_mw_addr[MAX_MW];
+	phys_addr_t vpci_mw_phy[EPF_NTB_MAX_MW];
+	void __iomem *vpci_mw_addr[EPF_NTB_MAX_MW];
 
 	struct delayed_work cmd_handler;
 };
@@ -199,11 +212,25 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	return 0;
 }
 
+static int epf_ntb_get_mw_group(struct epf_ntb *ntb, unsigned int mw,
+				unsigned int *first, unsigned int *count)
+{
+	if (mw >= ntb->num_mws)
+		return -EINVAL;
+
+	if (first)
+		*first = ntb->packed_mws ? 0 : mw;
+	if (count)
+		*count = ntb->packed_mws ? ntb->num_mws : 1;
+
+	return 0;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
  * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @mw: Index of the memory window (either 0, 1, 2 or 3)
+ * @mw: Index of the memory window
  *
  *                          EP Outbound Window
  * +--------+              +-----------+
@@ -227,13 +254,23 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 {
 	phys_addr_t phys_addr;
 	u8 func_no, vfunc_no;
+	unsigned int count;
 	u64 addr, size;
-	int ret = 0;
+	int ret;
+
+	ret = epf_ntb_get_mw_group(ntb, mw, NULL, &count);
+	if (ret)
+		return ret;
+	if (count > 1)
+		return -EOPNOTSUPP;
 
 	phys_addr = ntb->vpci_mw_phy[mw];
 	addr = ntb->reg->addr;
 	size = ntb->reg->size;
 
+	if (!size || size > ntb->mw_layout[mw].size)
+		return -EINVAL;
+
 	func_no = ntb->epf->func_no;
 	vfunc_no = ntb->epf->vfunc_no;
 
@@ -247,17 +284,30 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 /**
  * epf_ntb_teardown_mw() - Teardown the configured OB ATU
  * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @mw: Index of the memory window (either 0, 1, 2 or 3)
+ * @mw: Index of the memory window
  *
  * Teardown the configured OB ATU configured in epf_ntb_configure_mw() using
  * pci_epc_unmap_addr()
+ *
+ * Returns: Zero for success, or an error code in case of failure
  */
-static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
+static int epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
 {
+	unsigned int count;
+	int ret;
+
+	ret = epf_ntb_get_mw_group(ntb, mw, NULL, &count);
+	if (ret)
+		return ret;
+	if (count > 1)
+		return -EOPNOTSUPP;
+
 	pci_epc_unmap_addr(ntb->epf->epc,
 			   ntb->epf->func_no,
 			   ntb->epf->vfunc_no,
 			   ntb->vpci_mw_phy[mw]);
+
+	return 0;
 }
 
 /**
@@ -316,8 +366,8 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 			ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_TEARDOWN_MW:
-		epf_ntb_teardown_mw(ntb, argument);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ret = epf_ntb_teardown_mw(ntb, argument);
+		ctrl->command_status = ret ? COMMAND_STATUS_ERROR : COMMAND_STATUS_OK;
 		break;
 	case COMMAND_LINK_UP:
 		ntb->linkup = true;
@@ -434,6 +484,78 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 	pci_epf_free_space(ntb->epf, ntb->reg, barno, 0);
 }
 
+static int epf_ntb_build_mw_layout(struct epf_ntb *ntb)
+{
+	struct device *dev = &ntb->epf->dev;
+	u64 size;
+	int i;
+
+	if (ntb->packed_mws) {
+		enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1];
+
+		/*
+		 * A packed group requires contiguous backing for the entire BAR.
+		 * Per-MW size limits such as max_mw_size are not supported.
+		 */
+		if (ntb->packed_mws != ntb->num_mws) {
+			dev_err(dev, "packed_mws must match num_mws\n");
+			return -EINVAL;
+		}
+
+		if (barno < 0) {
+			dev_err(dev, "packed MW has no BAR\n");
+			return -EINVAL;
+		}
+
+		if (!ntb->mws_size[0] ||
+		    ntb->mws_size[0] > U32_MAX ||
+		    !is_power_of_2(ntb->mws_size[0]) ||
+		    ntb->mws_size[0] % ntb->packed_mws) {
+			dev_err(dev, "invalid packed MW size\n");
+			return -EINVAL;
+		}
+
+		size = ntb->mws_size[0] / ntb->packed_mws;
+		if (!IS_ALIGNED(size, SZ_4K)) {
+			dev_err(dev, "invalid packed MW member size\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < ntb->num_mws; i++) {
+			ntb->mw_layout[i].barno = barno;
+			ntb->mw_layout[i].offset = i * size;
+			ntb->mw_layout[i].size = size;
+		}
+
+		return 0;
+	}
+
+	if (ntb->num_mws > MAX_MW) {
+		dev_err(dev, "num_mws=%u requires packed_mws\n", ntb->num_mws);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+
+		if (barno < 0) {
+			dev_err(dev, "MW%d has no BAR\n", i + 1);
+			return -EINVAL;
+		}
+
+		if (!ntb->mws_size[i]) {
+			dev_err(dev, "MW%d has no size\n", i + 1);
+			return -EINVAL;
+		}
+
+		ntb->mw_layout[i].barno = barno;
+		ntb->mw_layout[i].offset = 0;
+		ntb->mw_layout[i].size = ntb->mws_size[i];
+	}
+
+	return 0;
+}
+
 /**
  * epf_ntb_config_spad_bar_alloc() - Allocate memory for config + scratchpad
  *   region
@@ -474,6 +596,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ntb->reg = base;
 
 	ctrl = ntb->reg;
+	ctrl->version = ntb->packed_mws ? EPF_NTB_CTRL_V1 : EPF_NTB_CTRL_V0;
 	ctrl->spad_offset = ctrl_size;
 
 	ctrl->spad_count = spad_count;
@@ -487,6 +610,11 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 		ntb->reg->db_offset[i] = 0;
 	}
 
+	if (ntb->packed_mws) {
+		ctrl->mw_bar = ntb->mw_layout[0].barno;
+		ctrl->mw_group_size = ntb->mws_size[0];
+	}
+
 	return 0;
 }
 
@@ -761,16 +889,28 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	u64 size;
 	enum pci_barno barno;
 	struct device *dev = &ntb->epf->dev;
+	u64 bar_size[BAR_5 + 1] = {};
+	bool bar_set[BAR_5 + 1] = {};
 
 	for (i = 0; i < ntb->num_mws; i++) {
-		size = ntb->mws_size[i];
-		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		size = ntb->mw_layout[i].size;
+		barno = ntb->mw_layout[i].barno;
+		bar_size[barno] = max(bar_size[barno],
+				      ntb->mw_layout[i].offset + size);
+	}
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		size = ntb->mw_layout[i].size;
+		barno = ntb->mw_layout[i].barno;
+
+		if (bar_set[barno])
+			goto alloc_vpci_mw;
 
 		ntb->epf->bar[barno].barno = barno;
-		ntb->epf->bar[barno].size = size;
+		ntb->epf->bar[barno].size = bar_size[barno];
 		ntb->epf->bar[barno].addr = NULL;
 		ntb->epf->bar[barno].phys_addr = 0;
-		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
+		ntb->epf->bar[barno].flags |= upper_32_bits(bar_size[barno]) ?
 				PCI_BASE_ADDRESS_MEM_TYPE_64 :
 				PCI_BASE_ADDRESS_MEM_TYPE_32;
 
@@ -782,7 +922,9 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 			dev_err(dev, "MW set failed\n");
 			goto err_alloc_mem;
 		}
+		bar_set[barno] = true;
 
+alloc_vpci_mw:
 		/* Allocate EPC outbound memory windows to vpci vntb device */
 		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
 							      &ntb->vpci_mw_phy[i],
@@ -790,17 +932,13 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 		if (!ntb->vpci_mw_addr[i]) {
 			ret = -ENOMEM;
 			dev_err(dev, "Failed to allocate source address\n");
-			goto err_set_bar;
+			i++;
+			goto err_alloc_mem;
 		}
 	}
 
 	return ret;
 
-err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
 err_alloc_mem:
 	epf_ntb_mw_bar_clear(ntb, i);
 	return ret;
@@ -809,24 +947,32 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 /**
  * epf_ntb_mw_bar_clear() - Clear Memory window BARs
  * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @num_mws: the number of Memory window BARs that to be cleared
+ * @num_mws: Number of logical memory windows to clean up
  */
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 {
+	bool bar_cleared[BAR_5 + 1] = {};
 	enum pci_barno barno;
 	int i;
 
 	for (i = 0; i < num_mws; i++) {
-		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-		pci_epc_clear_bar(ntb->epf->epc,
-				  ntb->epf->func_no,
-				  ntb->epf->vfunc_no,
-				  &ntb->epf->bar[barno]);
+		barno = ntb->mw_layout[i].barno;
+		if (!bar_cleared[barno]) {
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
+			bar_cleared[barno] = true;
+		}
+
+		if (!ntb->vpci_mw_addr[i])
+			continue;
 
 		pci_epc_mem_free_addr(ntb->epf->epc,
 				      ntb->vpci_mw_phy[i],
 				      ntb->vpci_mw_addr[i],
-				      ntb->mws_size[i]);
+				      ntb->mw_layout[i].size);
+		ntb->vpci_mw_addr[i] = NULL;
 	}
 }
 
@@ -916,16 +1062,21 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 		}
 	}
 
-	/* These are optional BARs which don't impact NTB functionality */
-	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, i++) {
-		barno = epf_ntb_find_bar(ntb, epc_features, bar, barno);
-		if (barno < 0) {
-			ntb->num_mws = i;
-			dev_dbg(dev, "BAR not available for > MW%d\n", i + 1);
+	if (!ntb->packed_mws) {
+		/* These are optional BARs which don't impact NTB functionality */
+		for (bar = BAR_MW1, i = 1;
+		     i < num_mws && bar <= BAR_MW4; bar++, i++) {
+			barno = epf_ntb_find_bar(ntb, epc_features, bar, barno);
+			if (barno < 0) {
+				ntb->num_mws = i;
+				dev_dbg(dev, "BAR not available for > MW%d\n",
+					i + 1);
+				break;
+			}
 		}
 	}
 
-	return 0;
+	return epf_ntb_build_mw_layout(ntb);
 }
 
 /**
@@ -1352,6 +1503,28 @@ static int vntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 	return ndev->num_mws;
 }
 
+static int vntb_epf_mw_get_trans_group(struct ntb_dev *ndev, int pidx,
+				       int idx, int *gidx, int *gcount)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	unsigned int first, count;
+	int ret;
+
+	if (pidx != NTB_DEF_PEER_IDX || idx < 0 || idx >= ntb->num_mws)
+		return -EINVAL;
+
+	ret = epf_ntb_get_mw_group(ntb, idx, &first, &count);
+	if (ret)
+		return ret;
+
+	if (gidx)
+		*gidx = first;
+	if (gcount)
+		*gcount = count;
+
+	return 0;
+}
+
 static int vntb_epf_spad_count(struct ntb_dev *ntb)
 {
 	return ntb_ndev(ntb)->spad_count;
@@ -1415,13 +1588,22 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 		dma_addr_t addr, resource_size_t size)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
+	struct epf_ntb_mw_layout *mw;
 	struct pci_epf_bar *epf_bar;
 	enum pci_barno barno;
 	int ret;
 	struct device *dev;
 
 	dev = &ntb->ntb.dev;
-	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+	if (pidx != NTB_DEF_PEER_IDX ||
+	    idx < 0 || idx >= ntb->num_mws)
+		return -EINVAL;
+
+	mw = &ntb->mw_layout[idx];
+	if (size > mw->size)
+		return -EINVAL;
+
+	barno = mw->barno;
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
@@ -1450,7 +1632,7 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
 		*base = ntb->vpci_mw_phy[idx];
 
 	if (size)
-		*size = ntb->mws_size[idx];
+		*size = ntb->mw_layout[idx].size;
 
 	return 0;
 }
@@ -1608,7 +1790,7 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = ntb->mws_size[idx];
+		*size_max = ntb->mw_layout[idx].size;
 
 	return 0;
 }
@@ -1656,6 +1838,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.db_vector_count	= vntb_epf_db_vector_count,
 	.db_vector_mask		= vntb_epf_db_vector_mask,
 	.db_set_mask		= vntb_epf_db_set_mask,
+	.mw_get_trans_group	= vntb_epf_mw_get_trans_group,
 	.mw_set_trans		= vntb_epf_mw_set_trans,
 	.mw_clear_trans		= vntb_epf_mw_clear_trans,
 	.peer_mw_get_addr	= vntb_epf_peer_mw_get_addr,
-- 
2.51.0

