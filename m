Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021089.outbound.protection.outlook.com [52.101.125.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2D361651;
	Wed, 14 Oct 2026 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956002; cv=fail; b=cCuzQ5SvKZ+xdHzEWcu//DxxqU2L09gpT9R/DBp8zwTz93XcS16sGoG5oEIspeqYjIp3JyOt1TdFDcbBTm+6Rdmnc3ZDDqvy/TN0bgR0Cb7MzEhTNZFE6RH1rX4n13kaAr9XMbi8d332IZYR3Ay/EbS2txAp1bDoDTthadk9yCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956002; c=relaxed/simple;
	bh=wNRolHmUoK6DfCJvtXAEU8+7vyjhbtJh/aCPkWuP84o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PM/dgQeGV9tjkrtm5Tc105sJW3DG2E2Pk8y0ed12scjY4XcTnWDOH2sNRf2tof9yA3uvb2LgpS7YVMDURW1jdNHbP6HyBB/fERo38kOmIk8OcCaoK+SG9w1xc7e+RlNGeTZj/c4cBo8Z54kSKjzy9qe2t9vZuhsxvaNAp1Oo69I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=H0OquNIT; arc=fail smtp.client-ip=52.101.125.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="H0OquNIT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3wjYa3ztxDndKbkcGB7zEWK6PAgw/KueaLdXvj81+BGYZH7tQi3EwhLY8XxRgznjK9oMVLhV3C6LmiRZJDDqIr7f5r/CkMVEKfex5Q2HKZmV9WWtbAQWlRNtFwnLQ7+fPyryr88eYZHQgIj4VCWOuBUFRQ99xCtb5p240/7epMacSYk+6HZiBBEsAg9JrubquON6jlBFbwS9l8psdab2iP1wmw0sdoFTzfTQCLM720B7DelWi/TNLR7/Y4RIE3cvL6IUQS0KIuVeOOSGADMusFd07IoRbSF7B2o4dPOq5VYHRcAtyQOpVW8CWsGXgHrJO3BPU6PRosxawfNCqRkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPdnZ25GlWAppZG/ONFNw68hdrnCFh0kdQcKtB8FpP4=;
 b=fiyr1S6Qvkgxb7RdBnNdFltk3i15qjYwFZrHOPywaU9tpKzN1uPuIRD8rTF88cuD54kLxgV4B1vAhAXvXpRHJ7u2olWNaVg/Gke+PLQOed3Q7NTlRi/oCOyg1fcz1lUTYCMHOwSo8i/jQXSnkPdsS+VxPltERbb5R7Wu6/Nop2J2lFJMNGw+LfGN5ShX3nm+MsfLjrw+CQdEAotzjy0baVYj9rfw1KQ3fD7KJbz2hWdLVl9nW6ZSppNbN+/SDteERWuyVvHztZkrnLQu3xJ0YyfePCQJMYmaFUX0nSQXQVc83uA4t3trsuZqRh/sqULTeormqQmo3NJUcW+CfdN7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPdnZ25GlWAppZG/ONFNw68hdrnCFh0kdQcKtB8FpP4=;
 b=H0OquNITEu0flXGh2cX+6Vf6CCC4E+tl+gzwlSUiMCKpajTrrzeR1XG/1vmcjApnI+1TmDHJn7DMhsnecJW8jdV1kGjZnIwN+NEj5yYCjk3rISDwy4Gr5tZp/PaFqOXSykjV0miszYTX8RTr5VZW71UZkb/pFJnvah8vU0odw0E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS7P286MB7182.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 05:33:14 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 05:33:14 +0000
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
Subject: [PATCH v4] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Date: Wed, 14 Oct 2026 14:32:56 +0900
Message-ID: <20261014053256.2378817-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0103.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS7P286MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 9057c3ea-528b-4e98-0420-08df29b4a45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|23010399003|6133799003|18002099003|10067099003|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/osBtyqYn/KWolZVSeKfzDotSumYkc1h8U0CH9wORdxH8IdnNSJ1+LcbejhrmNVX1dZ+DF5HbScfG/BA3sOnmaZKrdvtx4J6qZwWvQnVVkpdhCB5bvvOkxqcBlK3ENw6SGF44UvSx1f9+LOvKfW1HwmrXz9ICBYse8xOcVVnHlJOClH5BczOttr24GCsOIFbCiTT3tX/ewA5fMZpqM9gb/T0rpDjjuUZQgX937OlDbWck0XwoJYivtLZ89mMMFCqoaa+vb96z4jafCJdaeYMomjabMyGpiJPhWdCUQ+Q3vtb7rJcE5uMOJI0hidT2M03IkRkDMc3FDD66DT/BOvESz6s7RpGj3ax2d7FqCxGYguJNZL5UavMr/UmI0V4dPH5qRZsz9ymc85P/AQxqYaVAjMIwFNbLG8npCVfXmmVJhXX1mNksVWLVX8p7v7stMacO+URJ3pxVP1tN1CsD5dSwxcU8rYvGwdEk2YLge4cGHLCaiTyAexm8t/i89nr4Geatwe/l/InYQNEgVOz4DslUv4+u1cUCv3u/WvnxMBj2xR42SV+GleJOzQUAemN6wTNN8WRhkHJxphfgVO6TPU+OY/sQiMG37CRebV5RwVcSIahq2DjVflCGjocdtn4O7pZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(23010399003)(6133799003)(18002099003)(10067099003)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WXiU51G6iDCWG0gSCRryHjutSRVWUdxQbU2VNAXRrAg212lKKB7H5PC/K3QC?=
 =?us-ascii?Q?jvTh6mhr+IBZXKHnb94SjhHjYOFVd5JlqnGP80Q98eUYPrbHmdwapTGOOWQz?=
 =?us-ascii?Q?TVdu4GMakiBN+aHJnUU01X587ZwFRg6Lo4H1J5xOYlQNbNK7cuna474AFeYN?=
 =?us-ascii?Q?pgoDFEOM03oUB19ukmklSOaOgd4lDHRWnfCw0weS2fc7eUehPW/qLtLNBUTK?=
 =?us-ascii?Q?uUkjKn75430X9GOBYst8ADPbPhjjOQFs+7pse2k5fulI7fLZBhQKxzJrYEpe?=
 =?us-ascii?Q?9zwcWcJBXc4vCxQ9Zj5QaPtuSzVUpDH1kaYrLY2CVBcC4SH4BHdbfoy2xhsM?=
 =?us-ascii?Q?odv90Hxbzhtj/htl8wrS92NQyrPLwoliFhNoKIdz0Dw30ULF2wTIzD8+aT26?=
 =?us-ascii?Q?Dow5yp4LNc/pUOsKzGVN9cRCYhwKtZbEkcDRb43E1i0ZrmDpP82W+dv7POec?=
 =?us-ascii?Q?xlDsjF8vFanv5HHTeTfbioCF4kIVc5kpV62r3gSpoWAsx71P6zyltOYKAzqK?=
 =?us-ascii?Q?LU05VVCnSEjZ3/6QMWRQYb/AseVUTmIsXjrYHJiQ4HDwLGbpfW3QcZXak+YV?=
 =?us-ascii?Q?FbQ9ZzZfszhV17zYkEAzUOpR77SHwAdG85TUg21N3dF+1ZNqok9oia676/TW?=
 =?us-ascii?Q?qUckFpKTdNSRH4doZ4i1JVGiD/3UdjtQ+xjvYxso6ODULNoJ/Mt1sq2aPid+?=
 =?us-ascii?Q?HOemmV/knYoAiFAcTEPpuAqu6/SjW6VuvUNGTg++CjueK1V1y408IW5su1w9?=
 =?us-ascii?Q?yFCXkm6ua3fSLnRMd1s7GhJG+HIDrtE6rR8Zk86AwI4RAXkk9bwUuN+1Rn/k?=
 =?us-ascii?Q?pwt+4BWY9KqcXjwbpNIfZ1PRA1a+m+CEdoKdgGCsWhYpbGCxI5V6ZyxSTeIQ?=
 =?us-ascii?Q?HLwmJCE6gI0nwta0JBQ1sTJtDsRqd7m7C8GCGfDXFUfYbmWJit6EsIyhIFzM?=
 =?us-ascii?Q?tED7F90oWRGI1YjTnECuSPkwK5S6HBRZDPwrySkpU0LCIzQFHeW3bRl6QCrT?=
 =?us-ascii?Q?LrXUtYrVqt1L8COtbAezOWzwJYYi4H08GaqreC8BiYmAcm6DCOZOj3+I4WlC?=
 =?us-ascii?Q?nGyYx2mSYO1z/Ve/SoDHCCM3YOjhBosX7WzDCYgGINRuxdawWblleWrdfEhw?=
 =?us-ascii?Q?bbg3ETnEwtbIExkTD2mDogjG/tVkc7++9AC22YGuK9e+qMve/ShVPWNGyA6Y?=
 =?us-ascii?Q?SfLC4wvHqmH6yap4cSV+6uxxlgfb0fHS1J4iZcpWwJZXl8MH+ppRrgURxzx3?=
 =?us-ascii?Q?dQxZKyOZUT6fjzlnU60XCJVXH8LAw+yj4COkBa7FZj9pjloDTXanPpeiVS02?=
 =?us-ascii?Q?8DWnqjY8NLa/NYOlSHMuZiy0Tm3Mb2/iH6UUBHF7QIb01ykXHb3Y6noesTgx?=
 =?us-ascii?Q?sV98WcQEtlnoZHWn4+tRwb8h5lXN6UWDvuf61Zd8OS0+cfN3JUKtnqWb3t0a?=
 =?us-ascii?Q?LMWV5DWI+ScXD+KZP10Ct5Ch/K2IevJr5zZpAIrjtHvMWcD+2HUDYFFq5zKG?=
 =?us-ascii?Q?G2Eyl9danf82rUYJDPkf9K4QAJzVwsUSCH1/zRqpCRszc3zbBa5iZnxFntxx?=
 =?us-ascii?Q?Dk/0nIfY/57CI1p/DgxaAHyG2A2w1CIcVWvLkznHhaJwvnYTeZ6gR24OFWOW?=
 =?us-ascii?Q?5KfqOTtFOeBAmVRjsNaTYUqFgCoMtrmvpbDJEz7GJzE5ZbfFNzegTh+gbsy1?=
 =?us-ascii?Q?qce3MbS2ybKXWqjQSgHwutzBmR/jVE4xtAnP0lWr36k1FFjhL+LXuDlxD+Y1?=
 =?us-ascii?Q?yDhnqJH3K7Rl3JIOp1VarmVrGhmfm/1dpbd0gA20dWWkobKkZiUD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9057c3ea-528b-4e98-0420-08df29b4a45c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:33:13.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSwJywbrlkHn25AAOPk3go2Vuo2smMxUDO5Cs2VWiBLUyJMJFJIt1jRb5k6o1tYP75yiBluqo9k4Ehqu4+K+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7182

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
Changes since v3:
  - Reject MSI/MSI-X requests unsupported by the EPC. (Sashiko)
  - Link to v3: https://lore.kernel.org/r/20260919172021.1055451-1-den@valinux.co.jp/

Changes in v3:
  - Split out the vNTB MSI-X fix and use an EPF-owned layout. (Niklas)
    Niklas and I both hit an issue with hardware-owned MSI-X on RK3588:
    https://lore.kernel.org/r/mmcripxdekhktnn73ikylthajkdnincwu7p2nelcpcqzexpf22@rrmmzr6hfvzf/
  - Link to v2: https://lore.kernel.org/r/20260830151948.3547577-4-den@valinux.co.jp/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 63 ++++++++++++++-----
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 07ba338732d4..c30a73c537a0 100644
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
 
@@ -276,6 +278,7 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
  */
 static void epf_ntb_cmd_handler(struct work_struct *work)
 {
+	const struct pci_epc_features *epc_features;
 	struct epf_ntb_ctrl *ctrl;
 	u32 command, argument;
 	struct epf_ntb *ntb;
@@ -308,6 +311,15 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
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
@@ -451,8 +463,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
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
@@ -473,6 +486,12 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
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
@@ -513,12 +532,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
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
@@ -532,16 +553,24 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
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
 
@@ -1529,6 +1558,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
 	struct pci_epf *epf = ntb->epf;
 	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
+	unsigned int irq_type;
 	u8 func_no, vfunc_no;
 	unsigned int db_bit;
 	u32 interrupt_num;
@@ -1540,6 +1570,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 	func_no = epf->func_no;
 	vfunc_no = epf->vfunc_no;
+	irq_type = ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 
 	/*
 	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
@@ -1553,16 +1584,16 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
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
@@ -1573,7 +1604,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 			db_bits &= ~BIT_ULL(db_bit);
 
 			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
-						PCI_IRQ_MSI, interrupt_num);
+						irq_type, interrupt_num);
 			if (ret)
 				dev_err(&epf->dev,
 					"Failed to raise IRQ for interrupt_num %u: %d\n",

base-commit: 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932
-- 
2.54.0

