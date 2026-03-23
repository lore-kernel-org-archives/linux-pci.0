Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020086.outbound.protection.outlook.com [52.101.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C46288505;
	Mon, 23 Mar 2026 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235765; cv=fail; b=l0og7vUFcwmrljLrEF8bA/wPne5A7H8iRr3UQToT+6JDVwS2t+fdyE21OofJZRiT8rJOdB3iSXrWtCH/U/MGZ91/Dja6dWin4WXU+c4y+B6CkRxaaCVr9ddhiRdFivarXkS6TmEWkVq7s6A1L9v10JoLT/RNYtJpXIftE6lAm0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235765; c=relaxed/simple;
	bh=SR2GeG88ta4GDBACZLHUn682wci30W3Ne9jWi5PnWaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fwKjQU8TF5N1d7qUexWj86SNDbiuil8UUjriE2pmGAbJ9yW9O/1bmajERIEchyWU84R/zrySefWOva2cXcd57Gg7u1R/sXqcdx8aGP1P7etwqWO90lPs3wgPTSEFUWI328tr6hqSTFichIvIHG7SSSVV1XKyqwf4XSvUIkuGB4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=M55bK3kg; arc=fail smtp.client-ip=52.101.228.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="M55bK3kg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaLO45IOxvi03DkiKvXHCsVi6+d0PftDIjQeYfikjcHEDF9qXpfv2Mgr5YWIlY8Eps8ZBtQ9gsswCOThZNns+TWzwh/9zBPOyt72wEVrFtIv2d7LWM5tQzgFvFFKiPuZcDBwLXgjYe0zepKbZ+/4sWxkXuNf4Wm2FfM9eU8Nwl9vUnxQ+ldpmXZ/AwRNZote0KxVVhkb3ylBHi0Gm6ErRHH9LQtNoYDOjZg56rwkV8iVYmTRHY2hzO0N9eVuemkZzLmB9yBQvXqTRc22qY3IURQF7ziQrjW2QwzD0H/+coXVbEFnCTyjDDeILGhuEqySK60cq7zw/xB+1uAqqZeQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUlISL8egwbZyC06vqvzS2GtovVSCpr9UCZhCBpX+k4=;
 b=nGDKj70FQuQAniRJvRwS1sS22xxFWm0rKPFB3D6cDkFH5vm76sU0szgdb0I1dPr4THICE1jfynHf6BvBpsSTvVqtwHnjeRSdMcvh0u0tsIgfI7MbjfJJOfps20jz0hiITV1kM6CY38W7KopFQ46DDALdlieJpgppZKa2bJ1NZONomgqXzx1+wEe8NDwMvvimbMUEwWnaNY96KZLANY3MYcq1h1h/CKf6Hhv6fST44WY1SKlhbrwmkw7FCo5l7FCE33veCLHWiYK/jNKRQ09WNlrMG1cHJMMhpQ2ECPowwc2iRGaIf3/uVY+UpRjd5dTSXMkmW0Hp989oOHKC0lm0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUlISL8egwbZyC06vqvzS2GtovVSCpr9UCZhCBpX+k4=;
 b=M55bK3kg99IGiwt/9SJcwQnhTJKjD7z0QqsUJk4VOedwXjoU0D6wrhIafL3fILgNSSfYD92vYaWJQpHfFjOm69ijeU+L/5wR2J/PwAWk74TzzAzdbmt4wSvyIO2hx3Wzumizf6QdbC4oytCfIJBeu3u4gZlQRnYQDDD/mPw27u0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TY4P286MB6894.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 03:15:58 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:15:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v3 01/10] PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
Date: Mon, 23 Mar 2026 12:15:35 +0900
Message-ID: <20260323031544.2598111-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0319.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::18) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TY4P286MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 935ef30e-7b1d-4fe8-45bd-08de888a8120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LG+jdNIitxMe9qGjr8iOjJuFyzCkaZzbikxHY/2LAKTHE25+cqhhH99riquEEgkXQ076CgpcRmYiHE2DRXEhW8O/UJPpD57poJUV1bAnD3yNxg7OA3zWrN/unTEjX1MmW1ETp1A9X6b7k8D3hgu9kbTh5rayoN3jHqQkW4ueg8uiRDUWjqnIWnDlDC2V5ByIa4Xad01x8gMQlPaD5et/kfJgCOYNJ8zwnzc63d7S9A5JmAKkmgqA54o4yLSyHGPx7rUaSID8IUoqChsjU8PfbR6wqlvdTUxBXNlfas3CoegkXfqQrH840+tKHHGj+24PuohXjTqnNZ6v4CMj8kW7U6LGSMem3X5nBu7DSF/gnvVpc5ZZGc5QiwIfo9nf/IDizZ44tf1Ou6OVRMaO2rLUVWtqqq/l3b+QzN4YebDUIpEMxY7GFG48sxCdN7farweU9aRzGelBQuz3e36GtoinGlXjtFHW/M0Ir1YI44YjKQODl1LhmZ84V2K9H3xBMSgvsaqkvcqTj900a1oVQRtIf5eqWJYWYsLhLsHDG/ZlXt0B+qSxuAhRwwErt+fqYk2z4IM04Ct650byWdqZR5mjfjPJp8XoU5XEqRa6610LJBtvmIjMkZp3n+cajS4zEfpZD8vq0ZsPNkD6RgyLV0dU3m2/y1NPems/OXcSKLLaH4FPejMc2BI3FIxFmn3H1QJbM8Rq8iFB/7fcutzX/IywchXmNYnElsDXNtgHu0o2H5S6oERcoEGIO1p+OgCtwLNB3jMBH9IOU9leW8c1G/rIDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XPyHFXeLCZo7NvEHHSREhV2ax1SHiEhB1emHeY2I8gXiiFcuVhzU3ComCk4V?=
 =?us-ascii?Q?Xqc7ey/RZxBLLyrhy6WZ5d4/oyZOWV/1zzGSS4mpFeJeTzupw9u6eJAF6xFs?=
 =?us-ascii?Q?pD/ECm/Ko3GEGqFpSlVe/3TEW9wEQSYE4M59aHhoBxqqrQz+FVvWSnuGG/Ij?=
 =?us-ascii?Q?o41msZViYu8fHJQieDbVRy6VldugyFCt0ueZCwgbDijyR4SqDCmuBmDF8PqZ?=
 =?us-ascii?Q?YKURngh8cLwpVfv1qt9eb8pj8vRnGFYsVF/IVkP8+8TyKLlnB25YVrf6Yfdn?=
 =?us-ascii?Q?v0kA5wq/ea2Jhd/RKVQgzXJuvBjSVbwR9nMRiXMtoFfYjP+HSD1ZJ1SFfXya?=
 =?us-ascii?Q?4o8+BSgto3It66AUvGvJiTlcrn40A5yFnF0uVAL+nMCYDDWANfwLH/lkUhSG?=
 =?us-ascii?Q?n7mAspHAZMmRhk8OeaHpbrJsJhO5X277/hVk15gTNttiN/Yc+qklHmhUsVDc?=
 =?us-ascii?Q?4Uhkc0hYwnE/AIY2ildgu1auIbtlNfIuiTRHcVUO0e3Tb3BMdIpbtmL63Kk1?=
 =?us-ascii?Q?JJrJ3mGF+Mysq/LFNjJtPbZPvk02C09zq6ywtlAQrB22pBL+xXhoDPAxsusD?=
 =?us-ascii?Q?dEavuWZdSnVxr4zka1kWRfnmnGmIakvld6mX9nZS2EwpYN0ay5xStPpw+WcI?=
 =?us-ascii?Q?/g/qD2XPDoX+M0+WpHiMGcOO5T2bzJctKpS1QAZdo2dM43KU6JvlVPrtgJFL?=
 =?us-ascii?Q?aJh71w0H0JF8Vs285LRynHwyhPseSG+ftofYRPBL0KExr+xN5UZiEr3V62pM?=
 =?us-ascii?Q?OGPNW2P14l69Gor4uRGZNUUAb5EyPYczAqSSrBvO+CB8NKdqTsfV7giBF2VR?=
 =?us-ascii?Q?/psHEK96UPFDRDqgHb1uNN8/gTiXKuzBROL89wGyrf+1cQiReErga1jkU1U6?=
 =?us-ascii?Q?3dB52DCS7/UiXG0eAV1gAH9RFjKIlEc29d0a21E+6dg0UpnePSdLawmCYWlr?=
 =?us-ascii?Q?WwStTpX0m6uA/CILzMluYMnu1DijIkKHVKW/k2jdfBfDZBPgYmR870cD73Fc?=
 =?us-ascii?Q?qAnMPqwEao8IvE3IxO8K48imx6yYJUCwrzE/AJOOGfbdQB+cqCP9dE1kIOeE?=
 =?us-ascii?Q?AIXbRMBEtNQubyRs69LQ3H5soj2x8CLE2cXMaBNNO/jU7T6DOg2CW5N1mnER?=
 =?us-ascii?Q?YGHjFBimlLx8bfwVqrKtK34uj/xZStG0HP4K2d+A0CWVOQ7EkoG10Mw5uMxw?=
 =?us-ascii?Q?m0a42uw/wa3S7/K7BFYmg/ZAt8aUYUbvGiytwnaXoNbnlhCJgNp4Chws63Rc?=
 =?us-ascii?Q?YAm4t7Zkj+kM/XCqAI4vXfsrYmtvtSUsDqHhuyEjPyrBLG8neH6DRL8HK4gK?=
 =?us-ascii?Q?OQtVor+CuqGWQzNLuhQsLQQWwN7N3Sg/VoCH2OmNd+8eKOMAus8vLWxdMnaT?=
 =?us-ascii?Q?02SnFH/uM8XbJKm9DL1qLSCcvZjTX4iw1k9XgvevuEgEcLW+gr3Nqmn7AvSF?=
 =?us-ascii?Q?rn6eJ0mFM0CiIMsMWUtMgLiZs0d/s5F7h2BDaKi//KHUYpODLULkT1DRgQpL?=
 =?us-ascii?Q?HxkdNnggdeIrKGQl0UaCu7IGeDz835BMSiRbNbMesGFkwq6PP6v5/hr8tqu1?=
 =?us-ascii?Q?VJIrZh8wOC3H1xxCD5LRPg6WiPJgE/Ol1lpZF15ZSkJ4wuqsBw8XBp/QNZdD?=
 =?us-ascii?Q?XCFgtvfqD9MaT3h7ytdvuryx2WMoGewZugOfM6zhQn4jKchrRrekjZWhF628?=
 =?us-ascii?Q?31EmFF4wTLX6XBwTcOfOoEKCgNZXs9VbluGeo5QWWUTfAl1kISK3brD90r72?=
 =?us-ascii?Q?07gc76ABCZjIhfBxd2rZmTBji9kNTp+C56au78ol6+6BWRZNio4Q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 935ef30e-7b1d-4fe8-45bd-08de888a8120
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:15:58.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjAEiBz84vJPpNP+Ao0Hr9bb8ynju1Pw/2dSfbqMeo0wqerYgzKagNacNikVapU/FNqBskkq0o0AQhiWUHaepA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6894

vntb_epf_peer_db_set() raises an MSI interrupt to notify the RC side of
a doorbell event. pci_epc_raise_irq(..., PCI_IRQ_MSI, interrupt_num)
takes a 1-based MSI interrupt number.

The ntb_hw_epf driver reserves MSI #1 for link events, so doorbells
would naturally start at MSI #2 (doorbell bit 0 -> MSI #2). However,
pci-epf-vntb has historically applied an extra offset and maps doorbell
bit 0 to MSI #3. This matches the legacy behavior of ntb_hw_epf and has
been preserved since commit e35f56bb0330 ("PCI: endpoint: Support NTB
transfer between RC and EP").

This offset has not surfaced as a functional issue because:
- ntb_hw_epf typically allocates enough MSI vectors, so the off-by-one
  still hits a valid MSI vector, and
- ntb_hw_epf does not implement .db_vector_count()/.db_vector_mask(), so
  client drivers such as ntb_transport effectively ignore the vector
  number and schedule all QPs.

Correcting the MSI number would break interoperability with peers
running older kernels.

Document the legacy offset to avoid confusion when enabling
per-db-vector handling.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 805353528967..a75f8a30f8dc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1367,6 +1367,25 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 	func_no = ntb->epf->func_no;
 	vfunc_no = ntb->epf->vfunc_no;
 
+	/*
+	 * pci_epc_raise_irq() for MSI expects a 1-based interrupt number.
+	 * ffs() returns a 1-based index (bit 0 -> 1). interrupt_num has already
+	 * been computed as ffs(db_bits) + 1 above. Adding one more +1 when
+	 * calling pci_epc_raise_irq() therefore results in:
+	 *
+	 *   doorbell bit 0 -> MSI #3
+	 *
+	 * Legacy mapping (kept for compatibility):
+	 *
+	 *   MSI #1 : link event (reserved)
+	 *   MSI #2 : unused (historical offset)
+	 *   MSI #3 : doorbell bit 0 (DB#0)
+	 *   MSI #4 : doorbell bit 1 (DB#1)
+	 *   ...
+	 *
+	 * Do not change this mapping to avoid breaking interoperability with
+	 * older peers.
+	 */
 	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
 				PCI_IRQ_MSI, interrupt_num + 1);
 	if (ret)
-- 
2.51.0

