Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A2383C65;
	Mon,  2 Mar 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435717; cv=fail; b=AkTMxLVaxxaL7MZs34xDNuF6qJfwWbFQz1caCERLf+vzBHaq8j+USEUw7p2nay5obhERdAKMZRfXzmh0fA6cYhX7YyP+q3W9HpRn7mZdNW2HMvVtjjvk1+h1aHeU+NXSh+AUjZJQSvamSY2NCQQ4T5rUttBvYJlslYnoV9j6FXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435717; c=relaxed/simple;
	bh=pzdYZAnNHVCpMxQAFnMueEPlc2qQX3a463crnU8rgyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=odFvOpQKPNN0MTZdAUleUoVliWsRyRrpkHzLWbuvFnAuFB75aL7b/BFalPaXbprsKTHKbtJbzs6DBXuKIyJuvF3bDyX+nUSOt2/dLbp6Mv5ndaenRTvAD5+rW7LTFwjdJywzFY6FG9dfVlW0pza+xcpGtjPFMTVPXkkD5wlzmyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=d/r9V6PX; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="d/r9V6PX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjEuMeyLra2ckX/nDbWDS/zhd6n+Yvrp5Z8Hau1rYndXoIRFmVMGd09oxURihS4csmWSYmDrwzY8ppp87INZjP19khye/0PKoP3ix8cV2SWakNqT9sBtkSFj0zk2XIdtpW1OcoeZ4eY5N5p7Yiq3cEX+f9pbYyNesbjQIT83ky6mo8Lt6Bu6f2MEP096R+4J9TaQEdL/x18IiwOPwUCmilEd/sXiojJ2wl71rVuu2GXi3OP1X6/xfDaw0pKinlIKT7Z6qXiGhiZWtB0481namZD/wST1Fzr1sFxzvC4yRkNrl+3wmQATFUCTKmyO8ejWzjCgJOF38IHbfYjq+wQQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkIrXeNpkhjBTeFE7+MYclZZiOtI+oQQhWqBTkB1Q9A=;
 b=ZzNgztll0ddbj1Te4t7c0jP751lWNwGiX4uuV/REvrgJYjxBSjQXQ3vWrSc4+bhs0d3BllrPkrdsybpQ3cHyGBBe9sn2gsmBYf9VK0haj/F3bMJiULiMqX2+Y4dFMInyxeO//C8Opc90/42EsHZmIDN+X3+2pzxZ6DJ9kCt3qe3u6hAdXd6GSIkgqV4n+KmbMSii3J17qsvhW+tslfpFWNgGsLtjRLNdciPL2lkPKdQGJ5k1d79UGGMYoxs2dkH4kO1PJWUHSRs0DAlExqfi/SllxcLU1uiy2K3CiItyvgYr952ZAprOW8OrrRpYDaUS9tOQ0Wi47iAFy0GSoJgqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkIrXeNpkhjBTeFE7+MYclZZiOtI+oQQhWqBTkB1Q9A=;
 b=d/r9V6PXDqqJ0GbV6As/ulJQuEz1AF36Nthq9mYAKSJMCuM1H25XlYQWVMgZtuOKHsXqbvaiF46qFxGvkuxKXh7MfDqLW8kBjALPyyZll1MOaYSaxSKcuc+Zpd9YgGFuoV744gtx9yYZldWhIppsovpbtgdy40Hk0AnFPzT8WaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB4872.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 07:15:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:15:08 +0000
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
Subject: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Mon,  2 Mar 2026 16:14:27 +0900
Message-ID: <20260302071427.534158-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302071427.534158-1-den@valinux.co.jp>
References: <20260302071427.534158-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0182.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3621956a-7abc-4d1b-bda5-08de782b6f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	+QFdrjErYUCVVUw/Sqwf4Va/Zb3LT/Tqlp5fIT5LRXygdvtwLqBUQlrzKwCXhHhZ+Kk6LBSpZmjbtKqoSQhTIQfCtKW21dLJaFratEx84xeH4NlyD23Bcj4asG4DtBU1w+ywIZsqOxmm78VKF2VKWKKRkZzlHlzUB3fb9R4TKlhEUazkG/nMM5qPdrxsC+DvXV3xi2nKf7NRN3wuTvAcNT4DwCnc+1/WJ0K0x602XgghLMBOq58F8T+maFv6AZJndHzqXRjwcCvOO/zD2qvn+j+rhc12uwVBnG4jNP4ZB6KGjVMthUqELSO0QAghboO8GoTtgHZeEwiXdbl3AQ0OtT/zNU7NZ18mmVZhSVWCvjN7tiYo5+SUitCnp8YrcznhkCECdH9xY51xejj6s651kGBB7O9vgIsm3yo+UGWatN7WT52LQd94yjHeGPXOzvmHxrSsUidIrzmYlxz/bk8LA2SpetagV90lyGGrAUrba9wnn5wMmA6Jpbg/LirSFBju+uBL3RruAczzop39K/R8yHRxZiEpQpzWT2Bzi8fJlyu5owQvDWoN13AA04xgHAAZ/MOUm3f+Ud+RBzy9fqdfZSg12alZq2kGseSKlZ1xtYEfyWBteosbWV9TvM9FbRNttXR9huhsowIG2AJquhAkYBGjsuB474n2CYiIrbbLeVdu0BzU52bw6FeVIKPyQGgAtiE/8EvHbyzYIiimG8A5CCkyk9162AJxUiMbAmYkiRXS0WnAucFaFBR0XdQiR6KhpMb1GJ1Gt3LRu1U4ZczSSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9RAIQxC/bdBwmirY9uTk2xSjF9P2cQfuCL+6tJNi1WnQtTmXH1IwnFfOb7h?=
 =?us-ascii?Q?T//4alcGPO7dV6/uoxYZx/wbYvmc6rBJNgpMWSezQ0gqA9B1qcmVSSO8PktF?=
 =?us-ascii?Q?Sf8N7/SkB1k/YWK6+nvRPxSPUsenFe//8QqubBMmk9yU/b1Xauy685JBNb3U?=
 =?us-ascii?Q?o4xbgTPGY+QQAkLlQTg7dM3QVH5dSSOtWayeXEHMZup9ZhfbHofX4c6LnKss?=
 =?us-ascii?Q?767j9mgLxbPja8L+LiSuPEFSbCpOHQIr59bIzS1V+hA5nM0qgf8EiD3woOeK?=
 =?us-ascii?Q?5pUgUrxfOpt/ctaDnckcCnvYjjDdz9TZYDcAlDkM59VBjwZcJBhg1X+4VW/J?=
 =?us-ascii?Q?cUsX+MPrhiLmQVA9pzODhUl9SoREN1gSEaG/KXGSEDiYOKna61sP+R60i+1Y?=
 =?us-ascii?Q?EvcPg0FyBCfmfJ3/b5aeuECArb9Y5Mo6t6Go1cfRUdJvIcXLAwmZBVs/QDtZ?=
 =?us-ascii?Q?9uBcZix3br/6sdIlVXiOPGfY0JWPUWhDQZz1mqsem9MOQd8F7ReisIidUbJL?=
 =?us-ascii?Q?s26Cmwwb9pxR6UzrO7hb8+8Qtjf4CBaHhfhPYtElrfY3fJVkRExc5gkurZMN?=
 =?us-ascii?Q?r1QzCXPHFV+BVZYwb4aFATrt/+BY0gsIYIiLsN6lguVyo8Vu1Rcnbh4gzhh2?=
 =?us-ascii?Q?qdeJWjtyWADIA5wUNZtKhfaTHO7hoM7ZD8/tlXJ9NHm6r+jYFsRcDpN/0HVt?=
 =?us-ascii?Q?8tiAjfWMhtkdMhhrPX3HM2O2pGvIDJR6Pi56YAKMFjrU0aZec+axwYsShLGy?=
 =?us-ascii?Q?CDHXHpwtnyC9M+6kzALxLKecCjCLkb6tLEUq+frUHXtPClK59aPRqCkfbkCR?=
 =?us-ascii?Q?esXnEVvtuf93W604kpHkaeqTubcRtOAxy9xc4KZGmbTkvk0t5VXzeA3iLgGL?=
 =?us-ascii?Q?XCNMlgLEVXbACOTxZiGy2rVoted53d5LEJNd5yMgeammvMQVjuQ/fFkCDIOn?=
 =?us-ascii?Q?vai5lue4JF1uQdRhJz/bAkd7CYdcSOQxM0iXFdapidri2adEvNbHAUtdwGLI?=
 =?us-ascii?Q?Hn38VduAsEHb9tdsVKSQHC7u68erp8w4OH+FgB4HjR6DJz2kIVdFSSD3MdAH?=
 =?us-ascii?Q?F0X385/Ttre+05Lfbsjlzn7dENQQKnJ5Ww3aigEjJkeKtnT0lm2rnOu55p7r?=
 =?us-ascii?Q?HHMb0g+TfT6p3exQCbqNq/hvnCU3OkCMFoCbOpSp75YNqDfVdqkoE056hDi/?=
 =?us-ascii?Q?hEriN15H1OAwAP2o62jQbD8JP/k/oLqdX74PCdGH6TloCiJ+qY5oIXXHBBS3?=
 =?us-ascii?Q?1v3KEiz5igyyrjje/U3ClpkmkYj/nRDfyg4YnYXGBo2AzHVjPkatsiJzbUvZ?=
 =?us-ascii?Q?lCvkd7iaHLbt4C+aiFLEva8InjX3JVqGKbaJKiTP67f65GcDSQWMixfLQjhH?=
 =?us-ascii?Q?OjJptR/vDyiQ8DDtkgBlCEEXHax9JUoUOsXc7GH3Uaf91z79mgJ6NN0n2gPB?=
 =?us-ascii?Q?47Www5dTkilpUPnKXY+7O7bEvZUUNYIJbzTEG4KEC+LhrR0ZF8C+Retepx+t?=
 =?us-ascii?Q?caED0+xV2BRmC+5u1nguLL1X8WMOSKzG73di6oVP3jvQmKoCLIYjUjYLEu88?=
 =?us-ascii?Q?545QwP4dQ0iX5/ea2Co0DLS63eV4mmRfVnAIVd/A3XvYUVdK4o1X0ZX6r82+?=
 =?us-ascii?Q?wIOc7Zd0C0OkpnCFNXBNtE03+Uvb+Z8xNrjP0nDd2e1RFSEcWGslK1FPnilb?=
 =?us-ascii?Q?fEbLlvANl8oDKFw8tiaQF4AbWJEoKGFlNn2OYKXKGb3tD85DYKX8rNwzNzY9?=
 =?us-ascii?Q?ox0CT9ub1dtV8lDItwCbjzeCaVRUsWIw+cs4rhxuUruaCO6CoJVW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3621956a-7abc-4d1b-bda5-08de782b6f92
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:15:08.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIZPg9FYOSmcCGvrrUqbTd/nza3euWLGyGh+5XZShsUgt1dJMZvHXmDuHDKnXheOZ+ywvUPoDftHTsv0MpN1eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4872

Some endpoint platforms cannot use platform MSI / GIC ITS to implement
EP-side doorbells. In those cases, EPF drivers cannot provide an
interrupt-driven doorbell and often fall back to polling.

Add an "embedded" doorbell backend that uses a controller-integrated
doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
doorbell).

The backend locates the doorbell register and a corresponding Linux IRQ
via the EPC aux-resource API. If the doorbell register is already
exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
the DMA address returned by dma_map_resource() (which may be an IOVA
when an IOMMU is enabled) so EPF drivers can map it into BAR space.

When MSI doorbell allocation fails with -ENODEV,
pci_epf_alloc_doorbell() falls back to this embedded backend.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v9:
  - Report the dma_map_resource() DMA address instead of the raw
    physical address, to match the semantics of pre-existing MSI
    doorbell when it is IOMMU-backed.

 drivers/pci/endpoint/pci-ep-msi.c | 139 +++++++++++++++++++++++++++++-
 include/linux/pci-epf.h           |   8 ++
 2 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 85fe46103220..331d84a79193 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -6,6 +6,8 @@
  * Author: Frank Li <Frank.Li@nxp.com>
  */
 
+#include <linux/align.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -36,6 +38,117 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
+static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
+{
+	const struct pci_epc_aux_resource *doorbell = NULL;
+	struct pci_epf_doorbell_msg *msg;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	size_t map_size = 0, off = 0;
+	dma_addr_t iova_base = 0;
+	phys_addr_t phys_base;
+	int count, ret, i;
+	u64 addr;
+
+	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					  NULL, 0);
+	if (count == -EOPNOTSUPP || count == 0)
+		return -ENODEV;
+	if (count < 0)
+		return count;
+
+	struct pci_epc_aux_resource *res __free(kfree) =
+				kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret == -EOPNOTSUPP || ret == 0)
+		return -ENODEV;
+	if (ret < 0)
+		return ret;
+
+	count = ret;
+
+	for (i = 0; i < count; i++) {
+		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
+			if (doorbell) {
+				dev_warn(dev,
+					 "Duplicate DOORBELL_MMIO resource found\n");
+				continue;
+			}
+			doorbell = &res[i];
+		}
+	}
+	if (!doorbell)
+		return -ENODEV;
+
+	addr = doorbell->phys_addr;
+	if (!IS_ALIGNED(addr, sizeof(u32)))
+		return -EINVAL;
+
+	/*
+	 * Reuse the pre-exposed BAR window if available. Otherwise map the MMIO
+	 * doorbell resource here. Any required IOMMU mapping is handled
+	 * internally, matching the MSI doorbell semantics.
+	 */
+	if (doorbell->bar == NO_BAR) {
+		phys_base = addr & PAGE_MASK;
+		off = addr - phys_base;
+		map_size = PAGE_ALIGN(off + sizeof(u32));
+
+		iova_base = dma_map_resource(epc->dev.parent, phys_base,
+					     map_size, DMA_FROM_DEVICE, 0);
+		if (dma_mapping_error(epc->dev.parent, iova_base))
+			return -EIO;
+
+		addr = iova_base + off;
+	}
+
+	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
+
+	/*
+	 * Embedded doorbell backends (e.g. DesignWare eDMA interrupt emulation)
+	 * typically provide a single IRQ and do not offer per-doorbell
+	 * distinguishable address/data pairs. The EPC aux resource therefore
+	 * exposes one DOORBELL_MMIO entry (u.db_mmio.irq).
+	 *
+	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
+	 * For such backends we replicate the same address/data for each entry
+	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
+	 * as equivalent "kick" doorbells.
+	 */
+	for (i = 0; i < num_db; i++)
+		msg[i] = (struct pci_epf_doorbell_msg) {
+			.msg.address_lo = (u32)addr,
+			.msg.address_hi = (u32)(addr >> 32),
+			.msg.data = doorbell->u.db_mmio.data,
+			.virq = doorbell->u.db_mmio.irq,
+			.irq_flags = IRQF_SHARED,
+			.type = PCI_EPF_DOORBELL_EMBEDDED,
+			.bar = doorbell->bar,
+			.offset = (doorbell->bar == NO_BAR) ? 0 :
+				  doorbell->bar_offset,
+			.iova_base = iova_base,
+			.iova_size = map_size,
+		};
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+	return 0;
+
+err_unmap:
+	if (map_size)
+		dma_unmap_resource(epc->dev.parent, iova_base, map_size,
+				   DMA_FROM_DEVICE, 0);
+	return ret;
+}
+
 static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
 {
 	struct pci_epf_doorbell_msg *msg;
@@ -109,18 +222,38 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
-	return ret;
+	/*
+	 * Fall back to embedded doorbell only when platform MSI is unavailable
+	 * for this EPC.
+	 */
+	if (ret != -ENODEV)
+		return ret;
+
+	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
+	if (ret) {
+		dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
 
 void pci_epf_free_doorbell(struct pci_epf *epf)
 {
+	struct pci_epf_doorbell_msg *msg0;
+	struct pci_epc *epc = epf->epc;
+
 	if (!epf->db_msg)
 		return;
 
-	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
+	msg0 = &epf->db_msg[0];
+	if (msg0->type == PCI_EPF_DOORBELL_MSI)
 		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
+	else if (msg0->type == PCI_EPF_DOORBELL_EMBEDDED && msg0->iova_size)
+		dma_unmap_resource(epc->dev.parent, msg0->iova_base,
+				   msg0->iova_size, DMA_FROM_DEVICE, 0);
 
 	kfree(epf->db_msg);
 	epf->db_msg = NULL;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index cd747447a1ea..8a6c64a35890 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -171,6 +171,12 @@ enum pci_epf_doorbell_type {
  *       (NO_BAR if not)
  * @offset: offset within @bar for the doorbell target (valid iff
  *          @bar != NO_BAR)
+ * @iova_base: Internal: base DMA address returned by dma_map_resource() for the
+ *             embedded doorbell MMIO window (used only for unmapping). Valid
+ *             when @type is PCI_EPF_DOORBELL_EMBEDDED and @iova_size is
+ *             non-zero.
+ * @iova_size: Internal: size of the dma_map_resource() mapping at @iova_base.
+ *             Zero when no mapping was created (e.g. pre-exposed fixed BAR).
  */
 struct pci_epf_doorbell_msg {
 	struct msi_msg msg;
@@ -179,6 +185,8 @@ struct pci_epf_doorbell_msg {
 	enum pci_epf_doorbell_type type;
 	enum pci_barno bar;
 	resource_size_t offset;
+	dma_addr_t iova_base;
+	size_t iova_size;
 };
 
 /**
-- 
2.51.0

