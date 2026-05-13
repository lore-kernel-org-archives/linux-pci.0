Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53451145B11;
	Wed, 13 May 2026 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640572; cv=fail; b=eGqaRLiDFgVXD1XqLZWgdttgv9wAX6q40k4ulrlQ12Ti5K7Vl0H5lwLE2dQL6J9Js68yU+fP9GzLSaSsqaJ1z0zxZOe/glFjnTxWsY22gUJ400jzETb/aDWnDOIETupUav83CuyNLkDsmFftZy9u1XOVoxviMZPjHW10BWg9oBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640572; c=relaxed/simple;
	bh=4BX2FPbEbt0o936ddZ6cO981k41V3VNCcF6NS//4Zk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QuXWnWi0/jbK/wKEPkoWfkE89kxN7OLRz96Q+jUOMGfwFbQwrUpumZkzIYCBSbv4AwUqhgCR8p+iGNDPmXyFTzHckio/aWwCNaf/onDHKXiEPWufl+GS7pQi5SZLihPFFLUUC+ofuW5abq9zv0rqCEhoipFnWQi1lK5fbw4/pA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=B7+IQypO; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="B7+IQypO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNgbOpnbriUpZZGVFp8HysVH30GGI7+3IrMjhjkhLIQiWspUVuoMl0JaZ3bNAqTRCNLzMVrsGsR/aNS/UwQpWb6MRWIRu+wq5Svo3j3OiFcCDj2sXRnn8LosKNlEAaM1cddtLwqtU6WMT+jmlTbHovJh3JrKrqZFl9HhJxkQvZNs5WPnoU/LzFBNlrFPtYa4wyHJuptYrKy56M0iT9D5SeyTwjtGeWds20BM7Xg73S+1jz5IKpk7FSykrMYewvebGpLxxpxjuw81wSOls3Nepl6jiH0XHaVjapioP4RGOuW7BSxRLjA1gHhNWQ1aqIHrhnDhZT/I4RoCXbTmjMXxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q44avc9ShprrHGoJCCQxD9QknMMDtswYDIO620byNxs=;
 b=U+T/SRW4fXyqcoknUjpkDIeMO09gs/ggSaodk5ANTD6qTA8hJk6Ik+BLrv4jqJnaXDHCroyZPmB6kz9VkZd9kQtYwvL8RwDNTglSRffx4SUaK092TfmE+SH5U5S1lOf0/Pe4HW0Ucjy5y6eP6GAKxk/61GyQ09NN+cXh8g8KxLzQSY1B5Lqbkqnx0dhH6KLofHlpIrA/XIRk7UzKqA9nNqgZLvXczyiQTA2XqVg/ppcVm6jsoflc/EsBsxrfBZR+PO+zj6Y5LgsRD1+g6y0LGWB6/eG7ZxHrTyCrzu0a+Xx+V/GGcjGC6zzmzlC5Gk1LOqMB2eube2DZUqdNNPB6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q44avc9ShprrHGoJCCQxD9QknMMDtswYDIO620byNxs=;
 b=B7+IQypOM0OdcxBHGlPhcUuoJ17r0APdChyjgToh/Zl0ZGcIGHQBGoqPmVy3ITpUQPcOK/BjsHtwZVrZhimjCBLh6hsGsWbBBa260DvsC586XvQyAQyz4bRmaGltdT32FMp7PaKxq7dLDnb6Y/klgzsp6BLdLVM+4eX/QlCTCuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5170.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:28 +0000
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
Subject: [PATCH v4 01/12] PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
Date: Wed, 13 May 2026 11:49:12 +0900
Message-ID: <20260513024923.451765-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0263.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: dd16f0eb-cc1a-48a8-19de-08deb09a400a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YOUodUu9hh9Y+o5mAh6JkBRqm2Ubb+3Qk6pPQ+FZyrZKhvtFdmUTInKhrHlZN2iqoA4MLKiHc0ICqXhjkYtN/81e26JKXKW3pDDsY5M+Kn31joqd3TogAm4Oybl5xVxlFVA5rCTcots/c63mRf7/MiYxRfiLo/AHQp5AH8eObgu4EuNgP0IgXa9nxD3atB5S7CjjgVM9mLkoSe6clfUkLxYOLO1j6fenzUkkiJy7Jr+YRvigQKoiHJKAeESWgxHW2W4JPjS+LEMefqcwAB3d/wVJl3WZvlR8Vro5K0mv4LQNE0UIEuRfC0yRHFcKBOPbq0vAymJ/pEkINZe5OrZgbGVwSovuf0rJPqydYhG2GNoXvgZnJP4Q4o+j+a8urB0G50AG2+/T5Kmvcdz8XT/WsDop0i/Ajt4lQvkdXnbXJvKyof+x54vH8CP/kMXYb7zIQKkoOjBFjCMLn6yU9JA4CLDnLziSre57dLAJ2M7giskYCrtl7NfwYy+w9ZqsYHL1kmLIsvX+R9HQ1wJLa1LmekkG3p7fEfdjcKoPKqnFeL7cyeQ4lKcQoM2J18oAXAMYJSiRtiWW+P42BTB37OgyT81SFp8OepO0PwGQVWoBipzrmcnj4wwAMaRppd7YDHLGPwt7iytjC7EePQ1dSRLHeRCO4ZF0GrdgeSt+NP6RzntyyXrhfdu/Cml5MlAVBQATblvG3pWYgN5rUrk02sYuV5XzqtxfIa1AM/iviCSL4Kk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jFq/JRZl4vcxO/uHaTUwdsUow+bG/tSX/l31M2tYgBUJh7JqQVtcZWLlW2tF?=
 =?us-ascii?Q?CXRrGVF80DxlZWfNrrl9jHDmlnsIUiNIqg1RfdCz8h02lnSdvDlamYmam4so?=
 =?us-ascii?Q?EOcOMQf2+eOXDtroJz+3uaIT3x3uEjmBso6yN9N1473nL7kuvtOQDMVx3dDy?=
 =?us-ascii?Q?sPVrTd2XpLsnRmQt72bZ+TiduMBFRIhjMVYIy7sMANPJudFHUFvJfWS9jryp?=
 =?us-ascii?Q?ohZU/XGXd9fDp9q8Zmo4IIQgbkjYnDAleM5qdudsRkFGPFNQc1gBL4hTzi/b?=
 =?us-ascii?Q?RA0townteuqFXB4i2TcZwrYzUDSvUE/HLuLUmRdjudjfonVifSrRUDQSEXM1?=
 =?us-ascii?Q?5FiVCujx+C+oLwIYwAFGelhZVUDGZQsKxEoRY/XcgJ7+sC2DAkUym7d4RUhZ?=
 =?us-ascii?Q?lzhoH3GUxIUXwA4LHFkOyp6BqNlzkxmQEgi4e73fQiPu85oEgmfsO55c6JIJ?=
 =?us-ascii?Q?tdahfwQ7kr8oExsN6820AgWUxeOeM07kEln4hYp1OKH5aXqv4CncdXHi3P0P?=
 =?us-ascii?Q?xbmGoltra+cV9SA3jzBtiJ00TLBSQfPsrOvlcKS4gBkVLHyVom8bE1oL9/Dm?=
 =?us-ascii?Q?KPlvBVFUCIL1su0+MX2q8lJQ073TOhFrub8+i64Dya/KhLidHUS3fOv/zELV?=
 =?us-ascii?Q?3AhnJos5HO6pamlsZFxQp4n0S29kN3NkI3vWwhMrj1kngjoypFMmyyKgX4Xy?=
 =?us-ascii?Q?19A+9DeDTtwyVeuq2z/54vhbOM4IvgW1GjbAd7zOZBC+2IabcOSguf1LT3Mh?=
 =?us-ascii?Q?/rmyUBxlHEh2X2kc3J5T/Y+2GR12XKVwDzneGjkBlU0Hg9N+L1I95DXo5aDv?=
 =?us-ascii?Q?ztinpx4AOXsbBsnj0lV704clIMi6KDih7RChxdbdes7PCdwV8kr9ip4iNnrT?=
 =?us-ascii?Q?4AnxcDGRe8Lt7d0Ket7M8Xn3xqaOrVxqu1KAP39a+2Ty6HUEY2b6Pv3jOGdA?=
 =?us-ascii?Q?Ih5z6dVIzbMU95+aA518d30J+CkMLYjRu90OM0zMxCBkvM4MVGUJlN8R+BGz?=
 =?us-ascii?Q?yR7fJFPJC/K8u+SIF7tH7E6e42m+vmgR93fXGKzYAsYAoexVxn8cOx5MQY2Q?=
 =?us-ascii?Q?Nfi2L6uWZRlZE0ymYB7ODsFkeop2jmv7g5KWlEFdZuq7JoYsdh4Ui6y2vDhz?=
 =?us-ascii?Q?YnnoIj3b/GeYVPyAZS41JXwuqNlYg/of5hEB+JMjwuM0Fzdk5HdHVrAsMDQP?=
 =?us-ascii?Q?s63R0VsBxYrqeoTm2cQJPx2sazRhkdFdEDuVz5T3Z0/7NYOPXd8PWAhn6VpI?=
 =?us-ascii?Q?ZbtJlv0Kc7ffFCM0pJXFpEoB2bqqNwW2qylWOT8Gm/VRFo9ssuvhenvWQH/0?=
 =?us-ascii?Q?odHQP1DaknYU++6fia9ngy8cS+G0kUoBBmO8Cr6JsmrdP9EKOGpmqHFl79O3?=
 =?us-ascii?Q?JmjYb8r9xYuCv4HR9iYmZtQf3gpXwiP724SuILK7CMKNxAYylhSNK8zOi0Ib?=
 =?us-ascii?Q?ahBg49xTCNDBQfWxGQgRj77X9BUXf1wEN3AN4ZIBXztLat97EajWtBQ1YdOe?=
 =?us-ascii?Q?QW+Mvrmi7rLPTdX7KSYO8RdygbEaSHTURIj8AWyUKGcEN13ud4UHM28RNfPa?=
 =?us-ascii?Q?LQ61QHLUs/gwBlaJoyMcw3akNoskme3+W6or0ektZ15ySFUNANwoeKipkIyQ?=
 =?us-ascii?Q?hzty5zKZF6OId3ETg5Vc7nC+MzMLA/hX0EBn9gLwPpqL/6VZtjZ84Jn/N2Q0?=
 =?us-ascii?Q?QOOv5oQeJY2/txaovRBJL+SWs1qelSqI5GHZnijomFsrpjbk8vSA3zRsnbHY?=
 =?us-ascii?Q?X5YtXHadFe9Z4RnxHiDwZ5OxVA/HFz2dB9Gis9X2qM/9m1JwO4wM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dd16f0eb-cc1a-48a8-19de-08deb09a400a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:27.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+39J/PoDmBh5zTpEonMEoQmKOHlkeE2ndPQ+jeVsQdR3rN3XOwGWpFyal2rm4Y/LnwXM3yHzfcDeo+ej0c5Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5170

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
Changes since v3:
  - None.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index d59870fd3430..668d25abc7f2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1419,6 +1419,25 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
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

