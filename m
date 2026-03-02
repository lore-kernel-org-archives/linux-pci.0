Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600B383C77;
	Mon,  2 Mar 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435714; cv=fail; b=nqddhfDFUB1wY4q0Z/kk09uELwQUlcQ4boF/EmaFRDu+EbGXwWftoWdacC0rP4cqg0MwsmLx54/NPcVQqpvuCsTBcfghykiQAxOF768dvlhjAzHw9TcfIt36A+V/JR4ig/+QSjecCNWAFWugrugIX82pl1//gibToI7bCl4s+u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435714; c=relaxed/simple;
	bh=JLhFeEo0xxtRK53o32PFqPKhetCrVXKsSD1nGlvmOPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNlN6BBf0GJMP9c/1JBCWRVLmXh8ELKGE+XIauTPnrRf7QTo4JWENbT8fIoUOi64MvhXdXkEwGY0beqV4PTB0lTcEqgE4ZVfES/Xzb2YinKdAxZrlA2Cc6ddmiXPEijcu5Cr+UjU6OK6uiO73RKD0TKHbtQevBaoJjnIquzw29c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NcaKT7fb; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NcaKT7fb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cj8YHpGfToKnmOVqD7Pns4gM5rCVwemAdYuvHVQ+sa/ymCE+32k2YLmz502RM14CjpA1nOWA7Mqw2pOzZbta08q5tIkSnjJ8S5QQwaxj5z+zQR/LmmTDnYuWUhxGG48uqdH+K9QdNhBx0FdZB24yp2m97gvhjttZuotXjKR9UIr61d/0go/KUF2ZKB3v7YnZ36GxlDGfsgDu+YqYqI8P+9h1q/uiR1XiZc5Fmx+S4EJxYQMo5cht4A1yGHx9V67T4R8bfjwizUUhRSvu8hv28XzAvisp8ibLYkN1pVPvvg9Niy8+4ZV7tWFMYfCoQQcDxpUWkJA/Xf0UDsQCnf2tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqXmELfjF+kO5KOzf2p73cdYwrP9bb+TVFCrxYRlBLI=;
 b=xeRPJcXjZU5TC3FGV44CxM2unbifEZmaA0oMfprosRG1Z+grwJNGkNebQWBtQsAXrwvss1RS9/ohxI5gptYywvrSsCSDqFQs+9W8ubbhkdJb8Diqg5Mf72hFuaPBUPD1QwB35hcv7V4dVaWCAUSv60zpzixifD+dz1/fA4G5iRQcB09/1zi4hSWlpuiRnvIp6tPZE/uyysXrbdPdqZ2kKlKfmoyhb81TbL1G+Pox9oeP0hEzuksn4GXpN7OMLa1PlSiXWRPT4TIuVNdMGsiusmGnCd8rv10Vdha5gP+pXnGDR/C3Xh8RGRiNoiFowD3Bk2OvQirdFKF58mQqE4em5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqXmELfjF+kO5KOzf2p73cdYwrP9bb+TVFCrxYRlBLI=;
 b=NcaKT7fb0+oCBfP5y6AlSdEORF3LQvNNK3C5Q2id5FJmtMh+fH8j5auNx76CLErHOhgrHRxnM9muYZJdiTqMcWBP1yzm/KriXOGNKC1vvTIaxh44vGyHci6f945ZS+7WM1ri7zLpTKPuVaj02d27mvUveunCx5os8xFRzlTwiXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB4872.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 07:15:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:15:07 +0000
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
Subject: [PATCH v10 6/7] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
Date: Mon,  2 Mar 2026 16:14:26 +0900
Message-ID: <20260302071427.534158-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302071427.534158-1-den@valinux.co.jp>
References: <20260302071427.534158-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0184.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: ae39af1d-2c02-4b3d-7aad-08de782b6ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	MC0mPBfNC7iNdOzkJXDrMJLhTZ6D+DNgj8dXUgi+9x92+Mx0IjMJV76NVTdox9eELlb3wosgdINxYY8YeU0tuIQbKbxa7o7RvSdpEaFGrsXqbIKuil5wuZipNOpCDKlAzixZKKJ7yrj1a00e8TFNpKFiou/Ad2aL1Zhsg4Ehl7wYBLCJxucUMIQ+14G8S93Plrg9cmW07dumQ/k/CTQWUcbJ4YB5fyoDnD4SWXksr2QLhGlxSAPb+tP6Q/0IqMz0+VjDIpxHhul0vrnq8WMGm446ossRSt7xJbBQDjCRv6KHCb7shgTLw+5L3sMC7jdfxrYlYBvj78xmbcOn3xJu91qQXg2DG+aZgWHEPKtWWGHnwjk9LR48/vm85iaGbBwiBqG0c3zDmKbuiBzEbhUbRYg1ZcIHiaKcUxF/giCbtoxsAI9yHV/vZqN7qS4B5h92/LOa9n6P2NGKAKDNSU5DBGNthCbv05cVNFLsIGF6SUmeNl1j0lykISIUGSfFpxoGBX/GEpLqfdEtkvG7XsEeVPB9EDNauqZxXJ9zgTCPpP3LrrHhXA8lAP3PFNhrPLBh964vnEns5v0vsuRog/4ygnOJOd/n3g/LZO613tPMBla0Vv85jqNf+8jjE4FF/nevGTHQ6zFZQ01f2Mi7n9PRA7uhd1G/3MqtQhzNSOPfuG2Yc3+NdyOlhkusF5FVFbWu+m62TIyLZFtvJXyZQstuldqQnLlT2fk7FPPrYN/VXviwYoJ122c2Sd78kZ+yKeOxdu+Iqow1zzss8ryyIMobyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WhNN8abIBPYS3czkmvoBXSfKrp/aMIgLI7DkWHGKmzDcGYzWQ2hbgGJKpaU/?=
 =?us-ascii?Q?vkQzs71A6udy47+jBodMcW3h23jmenD2NzhTVlLQs4chz5F3JtPLbRir3VX7?=
 =?us-ascii?Q?ZKMyfqGujoYCT1D6L6yaMBp+gcBYJyEZV5K+Y8ZTSUt1BBh/9T5AiAZWvH9u?=
 =?us-ascii?Q?6ROBHIwI0rwDgcdu9qkLMcmupl5mFLsVE5lfCfy4QqTbVIavna3YOvUvMNar?=
 =?us-ascii?Q?+deBLBiqIren9Wyv/MkQW4xYZABfJXAYVR4lDkXOUrIhnwzf8Gs7dbItGhWr?=
 =?us-ascii?Q?jUU7ls8VuIYHgQSLFzcSBn4aEL6GzpmQ1DLoNgNTKjWCAAU6xKZDSgoQeR6k?=
 =?us-ascii?Q?ErHxdyybMu6TOAJSTd1/YXRGlKbYLA7TPxeYEfpV+8S0lk6C0lcChvnOvcOK?=
 =?us-ascii?Q?ibLhHSgyJgRbRhcT/JkGBuTNWJFUPh2PlgCHgBs3I6Be2RczNBaVEMP6YQsW?=
 =?us-ascii?Q?Cjfz0q4ByyGm9lN1XBrXZUDd4lETrvVe5qVkaLC2dBwz92VUhLiID0gw1Dt6?=
 =?us-ascii?Q?Kia9YvUO2muVmZpxjSTaNJHQBi0gtg0XxxB8gxz3Pi5V3/zl2P70YCfcC93B?=
 =?us-ascii?Q?FX86z+AzJ0vCYNwayTnetE8m0klDexiBZOaAbw4wZdoNoInFsz1G6wAktK0u?=
 =?us-ascii?Q?vyf6uMt1d5EtVXHE6Teq32fDRKE7+QeR+1vuNRnYTW/j/+4E3/DLGzV/pgyS?=
 =?us-ascii?Q?UCwdYSxL/DpSr5Tje3ymbbL/kX62QlCYXQrEDp2OCGR4gANsDM0/AHsKfcwU?=
 =?us-ascii?Q?UXeGiSGllXrjH9ycJrWq2nuJJIhdM53CvRIxyeSiF+VNpdxGe9QDht9lIE8I?=
 =?us-ascii?Q?Ni00Y18J5R8sOSgokzWKZvXqt+2JM41WVcqX7m1Kwtpr6pHbDl5raykg3zYk?=
 =?us-ascii?Q?Qgec4JrLFrOp50em8QyeFiCHYJQsqVB7Lbt2DBwfx1zcBXgcrYbQy6gSEcf6?=
 =?us-ascii?Q?LowwvYdMzmR92IFQEzaX5VT7nzthntThfOTNAzO+ZyFQdj21RdncGZS+iKOc?=
 =?us-ascii?Q?YqajwI14TyDDqEa1GLvAzuEUOJC2gVGOKS0o7K5d8P753DCHfVb/RTzWJsHG?=
 =?us-ascii?Q?07D8+Z+Jg2h3JyY/3qwo7JbKsUL7RJa29ekHSbXy3zaEPe3YBV9QY55DLbh3?=
 =?us-ascii?Q?T2DCySptNNWd5bgN+nqIBUlLlAYYHp7pLVb/7ZgWBCrb791U2HBljv6LMu/l?=
 =?us-ascii?Q?Ov/kPyYpWVqhM38BYvPsg4bCodLOzUlUFCnOwQVIDSbzX7Ht5H375TFBygck?=
 =?us-ascii?Q?s399ezlRaanyuc3lMfzOLLxvDTNu0OtQ9kewefpvDp2HY4XIWpsVVsSa7rha?=
 =?us-ascii?Q?iIN6Ugw7rpcmIePp6PkfXx1ZKpqZngXOLMVgezpB+M7L4EZc0sWtulwxWxy5?=
 =?us-ascii?Q?TGwXNN0p+r6/8wgLqlxANfGftKPoDUvAIMjgVurGjzoTi/tJZXJCGXeQCSwH?=
 =?us-ascii?Q?+N6xA0vUuOvuAfthAP5Tuh7XQMEIn1pQsNx5dwVVw88v71ILr9NSmr1BQO5g?=
 =?us-ascii?Q?F9eOwfwWC/uP2fc8GQHPy4l8RmS1vtEQSRo/7OzZN2gq00DEUkEo5DCeQuyG?=
 =?us-ascii?Q?1kpHmXdrYQmt/8iJ7HGAtSz8qOBQ4xxciDw7CVZYEU3cr/rALjBQzogmnojx?=
 =?us-ascii?Q?mwWWMpiu00cZY3j6E3ZowOzeIlP4XNF3szbUzFKEMylj+I32HFWCGFOfmUXw?=
 =?us-ascii?Q?9ZHKnUGG952NmLuAXJgfXLHam1A0XIHSBjRL5vx9uxXEzbE/XLIxoce4XLTv?=
 =?us-ascii?Q?g1KR/gqtf1gAu+WhG5pDK061KS0QgOQlImYzv0HiakfoyAG/S0be?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ae39af1d-2c02-4b3d-7aad-08de782b6ee9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:15:07.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp49mD19THsXITAde/0sWmNGxIZXw3xfb7JCTexoYCLnaSD+60VD0MyQsfkIpYSXT5I9ZYk3f04isTdooJFHJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4872

pci-epf-test advertises the doorbell target to the RC as a BAR number
and an offset, and the RC rings the doorbell with a single DWORD MMIO
write.

Some doorbell backends may report that the doorbell target is already
exposed via a platform-owned fixed BAR (db_msg[0].bar/offset). In that
case, reuse the pre-exposed window and do not reprogram the BAR with
pci_epc_set_bar().

Also honor db_msg[0].irq_flags when requesting the doorbell IRQ, and
only restore the original BAR mapping on disable if pci-epf-test
programmed it.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 84 +++++++++++++------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 14e61ebe1f11..b6c865b0883d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -93,6 +93,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	bool			db_bar_programmed;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -732,7 +733,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 {
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
+	struct pci_epf_doorbell_msg *db;
 	struct pci_epc *epc = epf->epc;
+	unsigned long irq_flags;
 	struct msi_msg *msg;
 	enum pci_barno bar;
 	size_t offset;
@@ -742,13 +745,28 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (ret)
 		goto set_status_err;
 
-	msg = &epf->db_msg[0].msg;
-	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
-	if (bar < BAR_0)
-		goto err_doorbell_cleanup;
+	db = &epf->db_msg[0];
+	msg = &db->msg;
+	epf_test->db_bar_programmed = false;
+
+	if (db->bar != NO_BAR) {
+		/*
+		 * The doorbell target is already exposed via a platform-owned
+		 * fixed BAR
+		 */
+		bar = db->bar;
+		offset = db->offset;
+	} else {
+		bar = pci_epc_get_next_free_bar(epf_test->epc_features,
+						epf_test->test_reg_bar + 1);
+		if (bar < BAR_0)
+			goto err_doorbell_cleanup;
+	}
+
+	irq_flags = epf->db_msg[0].irq_flags | IRQF_ONESHOT;
 
 	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
-				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
+				   pci_epf_test_doorbell_handler, irq_flags,
 				   "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
@@ -760,22 +778,30 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
 
-	msg = &epf->db_msg[0].msg;
-	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
-					 &epf_test->db_bar.phys_addr, &offset);
+	if (db->bar == NO_BAR) {
+		ret = pci_epf_align_inbound_addr(epf, bar,
+						 ((u64)msg->address_hi << 32) |
+						 msg->address_lo,
+						 &epf_test->db_bar.phys_addr,
+						 &offset);
 
-	if (ret)
-		goto err_free_irq;
+		if (ret)
+			goto err_free_irq;
+	}
 
 	reg->doorbell_offset = cpu_to_le32(offset);
 
-	epf_test->db_bar.barno = bar;
-	epf_test->db_bar.size = epf->bar[bar].size;
-	epf_test->db_bar.flags = epf->bar[bar].flags;
+	if (db->bar == NO_BAR) {
+		epf_test->db_bar.barno = bar;
+		epf_test->db_bar.size = epf->bar[bar].size;
+		epf_test->db_bar.flags = epf->bar[bar].flags;
 
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
-	if (ret)
-		goto err_free_irq;
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+		if (ret)
+			goto err_free_irq;
+
+		epf_test->db_bar_programmed = true;
+	}
 
 	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
@@ -805,17 +831,21 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 	free_irq(epf->db_msg[0].virq, epf_test);
 	pci_epf_test_doorbell_cleanup(epf_test);
 
-	/*
-	 * The doorbell feature temporarily overrides the inbound translation
-	 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
-	 * it calls set_bar() twice without ever calling clear_bar(), as
-	 * calling clear_bar() would clear the BAR's PCI address assigned by
-	 * the host. Thus, when disabling the doorbell, restore the inbound
-	 * translation to point to the memory allocated for the BAR.
-	 */
-	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
-	if (ret)
-		goto set_status_err;
+	if (epf_test->db_bar_programmed) {
+		/*
+		 * The doorbell feature temporarily overrides the inbound translation
+		 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
+		 * it calls set_bar() twice without ever calling clear_bar(), as
+		 * calling clear_bar() would clear the BAR's PCI address assigned by
+		 * the host. Thus, when disabling the doorbell, restore the inbound
+		 * translation to point to the memory allocated for the BAR.
+		 */
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+		if (ret)
+			goto set_status_err;
+
+		epf_test->db_bar_programmed = false;
+	}
 
 	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
-- 
2.51.0

