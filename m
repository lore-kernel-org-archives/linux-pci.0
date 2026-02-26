Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3F30E820;
	Thu, 26 Feb 2026 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095347; cv=fail; b=WYGSdMiy91rq675Cq30kC6K/km2iLeaUDPRTFVmntMgxW9zVebtZYfG/IACNAZSgTU4LNacdE7avUVLBgy8PUiiudxPAT2UmAQL53PjrCuXhrjSCGfkHv7X7u5MWZGTBAS8zRVzIf2SQqnt/jKSauHQ7ujRgfsEhR2N1+zP86pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095347; c=relaxed/simple;
	bh=jwGAQ11xKT32lcEr97K1ulQczxVTyYh2ku7xTU4vGkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oj+5tcYVqWKjn5g7esGT50t2PbU8Ya7WBFuKqTUmNnrX2Be71bKj3BNSdplgZoZEyD+94zTfWAzU5S6KWYplm69UwZlkzkPS/XsrUDXiHoXQ07LsAFSlZo2GmVi72EW48H1QDruV5dMqt7yldeVOZ9t+7XyM60o1oeKzZh3DtU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KmdHF/SN; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KmdHF/SN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZOgjJDGGTzw5GVgVPu2rRCvpuNw2Lfu9eiv9cVFG13XC5zr8D8MMrxmrFdq82U+z5yTYtOPzjmQ6LpnIsI19OLTDh4C22s7LdG41pRXgABS08/ktCpujaAna/AhQFgZ4duzjWZBFleZAXYJEcoWdpU5l/VxcrVj76Hdc7YahAF4yvcdPs5Qgr4tkCdJMYcIx9wTF+qh1v88br5YsC4Ktb+diTbv8a7uYHgWkS23mNvtVyLXhY51nNej3d6fJFwr9pgqC205RoflRTSRXZURoQ8ZcOCLtJDz3tjN0dHhShOHkhEMWiuLssDK8NMigRYw0tRicrZFbeC0CMhzx4oDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN3PFZfKuR/b4Zkf2BblfxslXgwz8HAIJ0eW+NhFi6c=;
 b=dTOqlqlwNH4D4ZUa/4I2tav1UuqcUsNfClF8Bjfc9TA/F6IOYud1A/8uFO23h+5sBLC5FUBpnef9mojNuhBl0HIxuNNVuLku0NXQCFRS3WOYPRn6tA4kQoLlL6xnHhM4hqeIlrKteU4A/mn6wx5a1Y7Ml68nCTZ+PsJBpCm9N4viOyXvS4su6y8PY3ReCr5s7Rd0+i9gD35ACpyFrtNwtknUEULzktBOKkymUcuy5o504EzlxyXReR4dJ0YsxY6UfKXW4UKgbZGSxDPgCNOETGItxHW0Pg2f2xUqVOJeXY+UR4XXMo2N/S6zeboH2RbVRTRut6lhfx9/qQC5J1njgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN3PFZfKuR/b4Zkf2BblfxslXgwz8HAIJ0eW+NhFi6c=;
 b=KmdHF/SNUzRT2XEdciWlXE8GZfGSuMk2WUdFQ/IruwuDaYOE4TRvznGJiiSrYvwSdxrpsAzOPNh9FI2JlWwcAHbNEKLKEzHh7FpHjU5sA2yiPpRI9GCz2+8v+MV29ovegVean4GLdfuwXqQHspUcoQ1FnZl5cEdOekm3sKx4P98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5288.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 08:42:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:42:15 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	kwilczynski@kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ye Bin <yebin10@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
Date: Thu, 26 Feb 2026 17:41:39 +0900
Message-ID: <20260226084142.2226875-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226084142.2226875-1-den@valinux.co.jp>
References: <20260226084142.2226875-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0181.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: e38c584d-ff78-4b34-0dbd-08de7512f145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	c3khvUjmJu3VAeW54rz2Og7vYqpIpjq7Av9/jy26UgfQgjtPphyL6D4mbyJIiw6czlkRqmy4W/NFcBqqC/5mv4eMml661tWzLzcHFrjy8KqCFrDAtJt7Y1VvCCuP0OMuBD3oAW4+wu1mUOMaNy59ZBE7ZWH54LqdsQt70LRMvfatf7YcKGvcHkTVJYxKdNwBrO3s3ou+ZkZ4nicHNzeruLclG8xH7TsCPU4+UQfHr+nZr9HclEu4rr+TYAhrirco6x+ZGrBzVArCm5h2GQp30JzuHFIS3kwOaRYigR1Y2bWe6PFRliLccDQGRG9htfJZiU6tmckPi2wULZQSFu2idb5J5PIlD/P24RVLVNR0CqAEZYJBI5e411zSksmldKd+nPbB+DbzRjva9o5nNHFIXQm4CD9n9KnU5RpSrVY9aL/dCHW2cTkNXs7l3jUrf8KlYaW8PijC5onTXFf/o8e87RSC4S6qmjhuGPAet/O6F7EHob9ypkbxICGC2bdZBJHhfSvjP2NMCuN7Z1/1AOuLn191qNJYdLypue2wgagG6RSqyLJkz7biN7zVt9IOA0Ko9T3qheEAiv1/Yl7h5WloHYj5BUDGzS+hgtuPx7/UJj0GyLxF00aO4jIAQW7rGvAJ+3cXrocys7VPYjSQgONnf6Nag2foDUkooOI/XzeqJHbobeAuN6WGt8w95kEUUEhYph5Jp6AiSu1ZiAsCnPp8ECdoeIC5ArWprQCauAhS66K6DPiqRd8f1Uc/CJre4LmrUMByTy+ZfVY567Y0tZ2gEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5+O7rQVyPYXT2vOQPKPOBmLUNZLmFMVgNixLJ12cLklQod9GzshkEeUlyiB9?=
 =?us-ascii?Q?KbCE7m/CyKdSn7C/W2RDkW3gsAuoxGP4kMGHYwgmwjfKQMUPLxZ5kxGiH/J1?=
 =?us-ascii?Q?Pr05hZd8Amc/J7vnUX6bycfpQTjDmIkKTivPztNwyDch9mk4sQDvJj2HjNoU?=
 =?us-ascii?Q?ZMJMSidRbAvcRf0iRrQfX/v9AwZ6vBfe2ilELlx54rHmW3W6m5uolf3SEgIn?=
 =?us-ascii?Q?mmbzd2m1FFlDDZr0/vW5IpXOhoo1UnJJYQ6SZHQJK4xaGjPXOxBsomB7+H/+?=
 =?us-ascii?Q?PB7ELGpqPgXYUQSnK4vJ2uK40EhnnZqWir2/mjEQgm4E6Fllovijeu75RiDt?=
 =?us-ascii?Q?pBAcP6xYp7KWQxp/pyFTCVWJsrnXOrJ41pXrtOTgdBr9SOMoKByHj5oimS4A?=
 =?us-ascii?Q?iW7XJWXfhqR3xmkts1ehi6EzhdclJA9kwYcJcwPIWs68U1btSiW0cvDH4eRq?=
 =?us-ascii?Q?V3g+QuFpJWRGK8A92DTn7CWTv4OXP1VlpUh1t9pGd1lEVerch5aMXEh3yn8K?=
 =?us-ascii?Q?YPvqqI6GAtZYaSIaEWHfwYxHJ5WqoqGGqiGUDE3FPbjtkWp+0MbRjxiB9ECl?=
 =?us-ascii?Q?zTXMEwS8cxg/DECHSPZZNelOqTLCIZ/kbp6aoTlLIYOL+h1e09GfIzw+/QCm?=
 =?us-ascii?Q?lrKjm99P5op0revLAMZ+IYfCi90dsNCSJCYk3p51FlKV6SHPDemHLA4Du0Mc?=
 =?us-ascii?Q?YUTNJ94vvSRSTdRlb6FTgmkf5FcC7CuaeNy91KUEPEIxtbp09BinlNvdOF+9?=
 =?us-ascii?Q?M0ialCfA0UQhotEUbZsmQ5yBvk/ktsTwEfOYXZ8YInWqQ1YEd5mT9xcXsKDX?=
 =?us-ascii?Q?tep0V9dJtm1uS38j376FcswSqpAsFC6j/IUu9QYPNwMyn1SOpNLXULMcq2q1?=
 =?us-ascii?Q?cO9obNC/bK7g1XvonwxygDnhIe/GHuOabxDxYg/Xi8pu96pYNc5jfA1kSWkx?=
 =?us-ascii?Q?wNeBEV78vF8gdYrbZaM8MEu7gD1ksy6D53DZD8V9l6rHcytro7MtLYZBwPKi?=
 =?us-ascii?Q?OWHb8RzDaqDzmkByy8msfNx7IFCpte0nmHVOIYBOvRb8DwnfJTI1O6i7Lt8+?=
 =?us-ascii?Q?Pl7CtemdefePFD39xSMQrxlu05DrPAEzth6FQW6PwdPH6E00KJ4sJlbzJ5q0?=
 =?us-ascii?Q?UVSF0NLbLWaPPO5vfSunl37CDs7Jki4Nyzs8E1b92DhkiUI8eZ1yJ9jwEXDB?=
 =?us-ascii?Q?4STl0Z+FSW6XSQhIK4d7LPn1o/xyAdKkoTgoTL+z0HSYLZBr/odgsRDMcM6y?=
 =?us-ascii?Q?qI71EkzV0iwsway0zUDmJP89DMrdFjCSrboNL4V2PMXI6Ob0rKe0us2MHbgR?=
 =?us-ascii?Q?rFeDSksEEaDBwiaZBAvczhr2N3jlg/aFjEX3XaiQoiSJaDheoEdeORXwqTS3?=
 =?us-ascii?Q?WhBu8rnkDB2vskR4aOFd/HNPNfqYqGrKtUmh2cM8e8l1kSjEMuaac30BjtO6?=
 =?us-ascii?Q?RvgH4LyKCncpq7BkwuPEw9U2vc2WuRZmdysyu/lXm8k5hyym/FbI7kAOkORL?=
 =?us-ascii?Q?2E5wPjm+JJhna9dZlVcGMVy0veaOWUgsfEuUuK/RYYQmoL2RnOUAaZVpgO21?=
 =?us-ascii?Q?kDvOymcgymuJkuKq/RfEEZQEwnalJdHy/E83yu3ec92GGGathBDmfeyh9TkT?=
 =?us-ascii?Q?DvglVGuZxVJkgchgXKGiHwhIQP2ky+XqCPIg3cf+A//CxKJb0Vg9UjpQ1zBz?=
 =?us-ascii?Q?O7gAi0xpDpZfGQL1+Ruf/mfeF8boLZUhTWLpV38M7jAbA2jFyNEZvLhMndt8?=
 =?us-ascii?Q?HfL4esucECVbWN0y4S5JfATTsDwy9Kv6fgcIG2Bila8ljJnmnr4k?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e38c584d-ff78-4b34-0dbd-08de7512f145
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:42:15.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdOQl8f8oxpYfW2yE0qXvZUE0yeLmRl9+rSCHP1YokA3iodQKKOK/l7/+my7oQZVaPpJJltPu0fGamsJeL5FVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5288

epf_ntb_epc_destroy() duplicates the teardown that the caller is
supposed to do later. This leads to an oops when .allow_link fails or
when .drop_link is performed. Remove the helper.

Also drop pci_epc_put(). EPC device refcounting is tied to configfs EPC
group lifetime, and pci_epc_put() in the .drop_link path is sufficient.

Cc: stable@vger.kernel.org
Fixes: 8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 56 +-------------------
 1 file changed, 2 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index a3a588e522e7..2bdcc35b652c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1494,47 +1494,6 @@ static int epf_ntb_db_mw_bar_init(struct epf_ntb *ntb,
 	return ret;
 }
 
-/**
- * epf_ntb_epc_destroy_interface() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
- * @type: PRIMARY interface or SECONDARY interface
- *
- * Unbind NTB function device from EPC and relinquish reference to pci_epc
- * for each of the interface.
- */
-static void epf_ntb_epc_destroy_interface(struct epf_ntb *ntb,
-					  enum pci_epc_interface_type type)
-{
-	struct epf_ntb_epc *ntb_epc;
-	struct pci_epc *epc;
-	struct pci_epf *epf;
-
-	if (type < 0)
-		return;
-
-	epf = ntb->epf;
-	ntb_epc = ntb->epc[type];
-	if (!ntb_epc)
-		return;
-	epc = ntb_epc->epc;
-	pci_epc_remove_epf(epc, epf, type);
-	pci_epc_put(epc);
-}
-
-/**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST1 and HOST2
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	enum pci_epc_interface_type type;
-
-	for (type = PRIMARY_INTERFACE; type <= SECONDARY_INTERFACE; type++)
-		epf_ntb_epc_destroy_interface(ntb, type);
-}
-
 /**
  * epf_ntb_epc_create_interface() - Create and initialize NTB EPC interface
  * @ntb: NTB device that facilitates communication between HOST1 and HOST2
@@ -1614,15 +1573,8 @@ static int epf_ntb_epc_create(struct epf_ntb *ntb)
 
 	ret = epf_ntb_epc_create_interface(ntb, epf->sec_epc,
 					   SECONDARY_INTERFACE);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "SECONDARY intf: Fail to create NTB EPC\n");
-		goto err_epc_create;
-	}
-
-	return 0;
-
-err_epc_create:
-	epf_ntb_epc_destroy_interface(ntb, PRIMARY_INTERFACE);
 
 	return ret;
 }
@@ -1887,7 +1839,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc_interface(ntb);
@@ -1909,9 +1861,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1927,7 +1876,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 }
 
 #define EPF_NTB_R(_name)						\
-- 
2.51.0

