Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2228395D83;
	Thu, 26 Feb 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095341; cv=fail; b=f+OR+JShWhAgujnyq3vyDqvbAsQSatHiar3LrIJuJvj00pAdpa4YmZ2ZZ1E9MCq7XgEuCUfySfeTw/j49s3XjkGVMMVouLmprrPGp+TS1zzs/OasZPsCBQdg4ihkC5RQLGDbe5h/Zxone7DEn58rk4Pqdv27FtC6CgkASz2O4UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095341; c=relaxed/simple;
	bh=9Z8FL3HGkmCyQEJw4StPqAKsUeWxGMgc5FeQwWEsxqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dn+wrvjlR15iISReeGc4R3yY89PCE8276QYYsUGUZ28ecz7NksiioLXNvOEdmrziGftlZT7XCg/mfzB+RKXU2jgNb1mSz6q/npURVunhNV9sVn3TboWBhKZGN2TBtka46PwYr2J48wfO73jdAtdtJDHzEtxDgmg79RgkAIwEANc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F2w5rhSV; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="F2w5rhSV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr2WwZzXEcptyJJj+1JL84xk6b2xnoeOB81IopuPpVY48rRZklkdfvK0befZfiyhdJllerenyRA40avvyRkLCuQ7nvsCmco09PsvBipfO2BGUEvpk41Ef0qH8B6I5b0w6fqjEJ6h5kpt1OFwAb4HpNFHDLLBtjQ67IhQCUFrIx6sWZsGpneNF52dHBOCyg9JEARMvWEpebBoKDlQ3bCWGF2oyH+icIPpjK2AQIHlUhSakJNzBdhmYmLWlAe3kimVaXVsfmfCSOuqhQhD28k7AtZp4cnFiy3MdOPwQICy3EmZoW0pq0ixmCKZ/iFvKS3wu4S3PE2rWxdVa4IEbFYWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7I5U4sqeOT6a8RyMvnW4NwvBIRnUvw+JoqQyCyADCE=;
 b=A0Zk0enyEGiEG07yJpFm8ZQA/IXwRlpaGNxr6UAoNz88Z626w1q+6CKrLefXg7rPTEEQniiJ5sO2wUAy4sjQsX6lKDcA0Bv/HxB0hS99YuwNDPuBajGjwOE6oqwsdoz8ZyatqxdEYLuwVxY6JtfO5mqMCseZCMKYDbOGGud80UzR6Lmq6CfRyNVsmY9CBCfbCoJNfs7g/vTEkNDYXi1lwYJFto+PVDGNg8J9F98G/OmBTHsm/PU6RONzow88+/kNzix3+sSQKE1r6uxsBMKvCr8+8XGH9zlr2vDtSKe/fE1y60Pm9tVafJ0vdszwKNiC4caipt6o7UuNJ/O94KlgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7I5U4sqeOT6a8RyMvnW4NwvBIRnUvw+JoqQyCyADCE=;
 b=F2w5rhSVoyuYHo+D+bXaIMZETtKC+gOTY7ktNE3hv88wj1MpnjcZOSePogPdNU+qCf50iPrNggbvs+szKRi7VT48G6sLSx9kzdeZmS2H5VhSpQ+5YkrgNZq+oYkIz6IDaxbIl2SGF9qHh9F/pru1CNM9UxEuR6jKNCcPUqIBbGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5288.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 08:42:15 +0000
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
Subject: [PATCH v5 1/5] PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
Date: Thu, 26 Feb 2026 17:41:38 +0900
Message-ID: <20260226084142.2226875-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226084142.2226875-1-den@valinux.co.jp>
References: <20260226084142.2226875-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 4444e5a6-7b3d-4761-5823-08de7512f0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	5tLevucz3yT/YQFh8rSYAFrcByA/QQDzKTIO5FJjAI7XjRlIQW/g5Bhr8GyNSXz7wKrS1cP5TCQX/Tlhh2JOK8kelhFTlf3J3NbrHpR+f6oePjlLfRCkf+4v306Yj2aIxDC3oPHah7ev6fVGlcyhvQlPj+q4/k/qlA7V7KlySpY1E8CBqKlBWE0jjZFdA5hKKunJgiJnp5a4EI3w87NjseMWNYY4t4WZDUs6znnzA6OTxwqYpXh7SnL7saNu3RKyLtqfHDY13MoA3wG/EvMbRGsKbyVSlbLWy11ThKZmTeyy9aLXFAZukMghgMlAP+oOC0Uk8ac+mzcyJCf1tN/Vjw3VcfxWqU0mBg1aoISxrrCkLvFVKn1ErhdmuyG8u8qFs19CTyxPpDDv8Qv28Df6wB42V6lcfPdd/4JCGvmxNw/YwWVbAGG8nw8+RC+gCfzk1+2o8JYv/HyIZTtAZwO/dfodBA0NVsk1yDZDx8g3fFMptCbmMBYfzMgvL6op4LhfpilpBkRXJsuKThkIFOzAX2rmDCcIKqG4zKKr0+yQ8XGwqwFfTXVyexcY5VBA7J1DC1PO9ef0U+0tjusS78tT23QgzjVeJnuTJGYIBhV2sy5JD/ywb3Rrt9ZMgo2Fn3vK60uVv20lS4fEma6EFm/fc8tOrB5Ky2qnfdQqGjaduX8LSJSacuKeVoRTgYcjU1hzJlIiE2NnE/KW5ofgU+juWFEL0ArSWJHLCO9xkRA1oN+vdi1EFFmIK969bOB+VDnzwSARQBdWjCUlHOjsTtG+Nw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bbvJTcuk6ft+7zqPYpupe7aZezI8RQsvh8zP3CV3LWMntYsfk47oT9/XTRD5?=
 =?us-ascii?Q?QHwaZuZ9B2IdLCwsmnwWv2vNLu8crJukhJaVUsaE0PTuzFUer5yzWyF5dteR?=
 =?us-ascii?Q?ZpE+rAuL/Fpi+jVKqqwDRSFPw9CxclZtFlVv5pZLIqlpxpIGlHYIRGiAC2fu?=
 =?us-ascii?Q?VVZQNWmW0EYAE4wyZlE5wlax/YBkdNCj/YdOL6ASBDAKiNO9xCEWLZfgCMpy?=
 =?us-ascii?Q?mREt2DistdLPlNT9m0vSUnNfJpwCtctWo1WzJwQYuY0jrGVnv2E7McHLnulB?=
 =?us-ascii?Q?kLo5+O25nM2Coaxtkh/Is0EmYBar6ADOnfLpcq/CM4Xe2hrmtByjYIq7RHZV?=
 =?us-ascii?Q?rvH7ONidE5Y6y1iFsX2JSG6oKxn1c/9mYtH5e4L5Bfps6vmugQSmb4z34yiV?=
 =?us-ascii?Q?z1tgK1B6xSckYMJ362bhc4k7fwIaYHwn80l0BczrQCGhc/kdxRx1hgHe16KS?=
 =?us-ascii?Q?Pv6I/YUDvvOdPYa8EdVz2zEinTj/9FiJLzkhCnuxtyqXdmXNbxQlNS5Z6zYc?=
 =?us-ascii?Q?CG4rEYmZAIGEWb5AQTPRn+yco7jv9OaYSUVWlykWRsOOTh9oaodpQB9Npz4f?=
 =?us-ascii?Q?n7sqU9Z/fQNpASvLBE4lJFgeGNUSKwinF1P5XlPQjoGRpHviiBMaxxOtYrhJ?=
 =?us-ascii?Q?2y6Fc5tTlUNkh6o5SQl37lM40oY8QvDO2bYjLBoBpxa49DufsdEYjFzzGo5y?=
 =?us-ascii?Q?mT5/vE9dkdyyCg/gowy43WE2xPyloKW4JX5wZ897DYTBQdf2V4GQHCht8nMT?=
 =?us-ascii?Q?SX32FSLHnp0SzSC1a0h1it2SqGPJiIOpripsx75Cew91d0rRa3kKvBeigc2D?=
 =?us-ascii?Q?vuhCqESle3Z07Xk1i3rWZmp52fGH06/CKXb51z9/7OMBBPzqWXx8QPwWnaBr?=
 =?us-ascii?Q?hRmubgR8Fv0foTNJBGBEV0cPVLgxws2mmWb8nFSd4MJbCXTnn3u/03RTkaiu?=
 =?us-ascii?Q?x5UUeRCPFGEigd9/1hCLNIUxc2au9asj6si07xtTCfH3jLBmD0wsWeaA33SX?=
 =?us-ascii?Q?Xvjr1xswz2UDrlwJT7gswOWTQwuhqdHj0HARZiMDB384pCSot3MLdO0wF1oO?=
 =?us-ascii?Q?mSN2UHYm1qXhAXj9wikg5I1ahCKuGrFLsc9qT3xEFGlwHemIw7Uro9oM15MT?=
 =?us-ascii?Q?9qmJ4XEix80yIuG8X7XiBLv6ZA7ibqkH4IWqXV3ErkyQTsz1cpTNcQEbPcQ0?=
 =?us-ascii?Q?TdccGuWEMrgb8EtgW+/jb2vGtRgClDrkdFnzz8ShulLIo41G1KhKS38D6O+J?=
 =?us-ascii?Q?FFVWRwrz5QBjvdJaxVnm/uSDzJgCyUtHNRAajAkUV+bm7++jHeOypKqkJtGq?=
 =?us-ascii?Q?8H4o1sY9DZOmJ4HfN7GikOB08x6e2GIa6KF/wXDWISiKlWUoJIZgEnB3piXh?=
 =?us-ascii?Q?AQzmlbw7mIBjMtC4jTpksdhJa82QKMzWFJ0VQNk1IV1ZwvdNbAp8ZX5hzM9U?=
 =?us-ascii?Q?B4XhbG3NeBKLjXJdnFRe8OSZHCCRjGG0LDVqg5jWVRjLuQgHtAH5RJZ5mQ9S?=
 =?us-ascii?Q?+puJyuKhi2BqPdnCrgf/XlS5s8UIK81uUUZsR2EIuswSD+6xqtM39AG425EC?=
 =?us-ascii?Q?fxrUEa/DDOE/e0FywSjgLBOOjBcqnXRoyvWZQaU3aoaFnTfFOpSSUTOScxCG?=
 =?us-ascii?Q?sG88tn3QEoz3Iv6QixzT1/UclJt4z2PicrMz1WgWiwFFDmESMNhjHTGilqiv?=
 =?us-ascii?Q?X6eVonOWVWZDWhCJmmKThgIJdDL7aFKd4MJeTNKtVIWRkBYKWDGikF6XY0R6?=
 =?us-ascii?Q?L71Ra3mpiGJjVGDrbhiDLa0NQW67EudAEPc+GMcYIdVg50TuIxqS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4444e5a6-7b3d-4761-5823-08de7512f0bd
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:42:14.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx3zKjdBvJf88eIUGIuIjbYqn9abuU9lP4hZSwM4vgAPtU4BL/ePgrSM/vdWLGfosYwWBcxVwax5twszsqqa1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5288

epf_ntb_epc_destroy() duplicates the teardown that the caller is
supposed to perform later. This leads to an oops when .allow_link fails
or when .drop_link is performed. The following is an example oops of the
former case:

  Unable to handle kernel paging request at virtual address dead000000000108
  [...]
  [dead000000000108] address between user and kernel address ranges
  Internal error: Oops: 0000000096000044 [#1]  SMP
  [...]
  Call trace:
   pci_epc_remove_epf+0x78/0xe0 (P)
   pci_primary_epc_epf_link+0x88/0xa8
   configfs_symlink+0x1f4/0x5a0
   vfs_symlink+0x134/0x1d8
   do_symlinkat+0x88/0x138
   __arm64_sys_symlinkat+0x74/0xe0
  [...]

Remove the helper, and drop pci_epc_put(). EPC device refcounting is
tied to the configfs EPC group lifetime, and pci_epc_put() in the
.drop_link path is sufficient.

Cc: stable@vger.kernel.org
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 148a3b160812..42c870ee3956 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -763,19 +763,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
-	pci_epc_put(ntb->epf->epc);
-}
-
-
 /**
  * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -1529,7 +1516,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
@@ -1569,9 +1556,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1587,7 +1571,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 
 	pci_unregister_driver(&vntb_pci_driver);
 }
-- 
2.51.0

