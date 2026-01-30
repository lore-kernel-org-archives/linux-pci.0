Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B736F40C;
	Fri, 30 Jan 2026 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774136; cv=fail; b=B9+hM5VKwyjnxF+xSnNDt/g8jjBVlbgIDmhgWu7Hsr6e7G9O81PgKXaCemUB8fBvHQnrpa5Yb6mgO0YATg2WRRNhFePC96Ok6Zs9XttXu/2o6M6QwN6eiyw71Gr5CPc3aeQobXZRc1BnCqnifl3xlV5mnWTR2gTy9GiKqhWYTbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774136; c=relaxed/simple;
	bh=dnt3Ywyo3kRrN1O9kcVc+pHLI6DZ+oRycSjBrSKmnY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/eikJImToy9NtSWTzEjTOhFQzu1D6v4Tx0WwmOk5yBRxJ3tjhXRRYXC08/GkXSYCKue+lYdH0kXXxEStDo5/W+k76zOk1PkMUhO6bp+wkEquk3e7HKOjl/7Stxkwp9hXxaPdswYEA/wiIbfWTqMXMd5cxlaIy90PfcbRB8mXew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gtV5l4r5; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gtV5l4r5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3UlGQbUJsxvDv+SLXFxqAs6d4RzEB3HeVC30DQUOt3LkDlzUOLTccvbFQhIsyg309NeaegYGLJe/MocmZOzDsLSpOqVGXms3s+VCzFsWMrikQ0qexSh8isncci+jbPQ+HPIiP+4UXODSAtscpCZbxnSqZ8AVuEJDcqEFVwyjCTrl0BlyzmbuuCEM4AAzHT3/0apoYpHLn/QLvdyh5qBEcR1Ohd5arUD/8oBtFggdgF9+hrLpnK4Sx9vohzMZ1jvvS2ITOvxEv7U3TMnrkq2HThNZ/a85cOfjtwHmb9muDJguIHvdUtR1CIKT1rr7Mlp6HmNbfR+LIdojt2ljKc0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odZKYb45py2tu0D13lN9N/LELubn2OG8kN46xOHwpjw=;
 b=nxkFz/iUu+VUJleJMlQ1csnlcFFrfyWZVZMKDHe2IRzMV/n/9119GN1LQrXAdHtFBu4RHTWWiTXAqdf75JMMGAOhpmgxdHAG9lnYfe7vwfzFMkmMLrQ104GlYffcLemddWofFruhyoX7h2tDzrDOq8yj/Cws1HbTJQVn3W1xiakQ33t+pCGKtpgcwRPQ03OfbJyUHn+k1PzsttC3rF29ArhBK5RYPVlNQt2JfVMUhRzhXQM1m3Ks8r55RzncUacyAKyIsrwsveuRS3pnYkIiXvhs9nY2llaCQd/VD/6NNnAKbkvl8vNE7xdWhsz4liB+Ca0THIF+rR/TNAcuyUYPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odZKYb45py2tu0D13lN9N/LELubn2OG8kN46xOHwpjw=;
 b=gtV5l4r5KyuI0/qH6JV4nGbRtdZUIbAcjN3C2IouvViGrLybN1jH1Et3jCNNn8Qnp9EvYrY1PKNns+BMIJmpspHfANOg/An3el8qIIQYDDXZY3QhPUImQT+E9X3kEHxuRU+aOZTONvK4HuEsp5i7VYSTUgiGh0SAO1L0VX/eWf8=
Received: from BY5PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:180::40)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 11:55:32 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::41) by BY5PR13CA0027.outlook.office365.com
 (2603:10b6:a03:180::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Fri,
 30 Jan 2026 11:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:55:32 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:55:31 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:55:31 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:55:31 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UBtIu21665999;
	Fri, 30 Jan 2026 05:55:27 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <den@valinux.co.jp>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v5 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
Date: Fri, 30 Jan 2026 17:25:15 +0530
Message-ID: <20260130115516.515082-3-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130115516.515082-1-a-garg7@ti.com>
References: <20260130115516.515082-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: d38ad26d-2855-427c-62de-08de5ff67898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5KSrDIFlDOCbgDwXoS0+IkQRMl5cYBAnyppvZ0X7XTMVEsy46Gzs0kCSsXqr?=
 =?us-ascii?Q?ZamItENWRNpsR9pETWGv3jeZU/H9BGt5p/TIfxUcMWyvisiQvaZehGQQWBW1?=
 =?us-ascii?Q?dfZZbuG5Pm1bev3Xp5OGfUjInEPVjxY1rFkLHNkVOjw5U2g0/HqW4B907I5x?=
 =?us-ascii?Q?zxglvg3rLb9EYVLltltXS48Wag1rDsPQkGV+Igg2nlsjglb+6uWEfHMS8w13?=
 =?us-ascii?Q?g/QTeRYmfysTeWORlpN/fd3ahmh4kRHOcTY/WzDLZQOQx62kyPNOqHv7N5lc?=
 =?us-ascii?Q?CeLKH31cQbdJpRJM9UbapmWN2nmKoxl7AG2nzH0CcqqadmvIl9ZABKcAWEZ0?=
 =?us-ascii?Q?luXrcQKcLYbu6RDBQ30tREx0652uHozYevAjab90QcpuopKg+/lyxsKSj2+F?=
 =?us-ascii?Q?ftehsjYFsDmDgyu6dQ8JB2tpT57MktHS/5jGlnpbWYj3rTwNYMw5mCUZVQzB?=
 =?us-ascii?Q?50aZHMCb4WEsmpsG02bbhSxVtX8ki+mnSsidSvan0lFMend7kkP9gUu66yeE?=
 =?us-ascii?Q?oAIotvK5DU1G1zC31IeJoOV2LdapWNejn8PyjXBottFyh91ki7x4blddYv+e?=
 =?us-ascii?Q?zHLAEvxhSx2HJAaJiUKICXJEZdoAMBPWWusgjbAyJdPlHLz4iPcVc3VCT/Ff?=
 =?us-ascii?Q?mpfYtCFSTcXAZfHIBbZcUN67qpTdZ6BoOA2sOR/Xllq82Tskc//6r9dfZTsJ?=
 =?us-ascii?Q?MnOSemDZ968zeAPkeTMgh5oJHJPpG0wL1+ut/STKM7hdHmnUYtVLNJW87QDV?=
 =?us-ascii?Q?PwMWxcyofF0Ps/M3xbkRZUzPJxgJd4+aOC0mYniKLl2F/mSlbftQ1yzTWeoB?=
 =?us-ascii?Q?vTspI7vA9tu/40JqQIS/wIDArpFqxnt7zBfi/4KOZg3FpK0MKfCLI9SnoNFw?=
 =?us-ascii?Q?pozTknzfjG/9E5QZIF+xmthwmkwMLYaT2KVIazKZNgkV/7HvocHH8THDz+5k?=
 =?us-ascii?Q?4Z5LhChaMuWWeVo0MQOTN0BN2CtJlLD7Pr9H8TMIqOqKozv8ZvuFzH1yIITl?=
 =?us-ascii?Q?MHFeORPGo9d+iIsiiGcIWt8CSiIdaYBXrSh8MAvkJbA1zvnuGnT4RO/JJFf9?=
 =?us-ascii?Q?mWGP4fEOXsjadGB01o/dNSCuMJI1Bv9+xLo/uqFvazg03im3k6k42Bn1HmiL?=
 =?us-ascii?Q?RApG5MjA6/GrhsRFXuba/jZ/FK8Ts+ypm1jYdtSLkT4xApeFyGqzjO8COQQW?=
 =?us-ascii?Q?dlyGwNF9RYjqYMD84ogMGVIDNJ64MkrxPwHem4JSaV24DXebJxDEOi0uovX6?=
 =?us-ascii?Q?7FXicDeYFry+zd4o9SEHlpUuoRRGk60ZgDfX8F1CxbvAm1V8bXzK7vFBFx5d?=
 =?us-ascii?Q?V9xata3oh4XFq+RNuSqfHnvS1HKPULVeQuPbRguEJsXb2H2wQhPnns9zbyAY?=
 =?us-ascii?Q?7OGW2GQYHYFEBFXUMT6JvpSmpFybXzajTiujZQjFEUnD9z4tm4MWXyUNzEJR?=
 =?us-ascii?Q?U2JxlZEZRckVTOsump6gK/Z2F52udaEXf+9waQuMDYVtzbLW8Hj9AhLLGrOj?=
 =?us-ascii?Q?S+Rjne+7EOu+jwt+1an5/lgvFUaBO9tSLrcgVZD+0g2f5R9kshSSNlZ2AXv6?=
 =?us-ascii?Q?OXL98vejRQhbhPIPICR0Bxa8yKkOjaZkStP2f5CZU7zd9o0M9qQI/5DIHZzS?=
 =?us-ascii?Q?QugQ/E1NxoRNl1ghwDEC+Py0TJzFqtOSEPXM8swB9G6YbG5d12TIXclJgxi8?=
 =?us-ascii?Q?U4b4v1w62ERrV7zhJroI5n87QzM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+T/YDGmuVjhDBMbIpV+z+O98aPvRvm2zG4xipz4LoHpZkeRz95EdUTSTRZnOFE2Rg/xc/6g7DnP2NpCP9vOijjt8Nu2rUMhZ6tt4JhayIzY5G5ZSE6gxkfElt2J8fsAeoLsWGLlwX0/4PL/l43KdE2RSblA0W5shhhoq7n7p5Ub7E0FBLbu+ex6BY+LPxNQJSWv959tvgd+cfvzzZNtiQ5j6nPeQ1wjIpqvmgiQgI3RdkeLjHs7+pbhv28VVUR54qQpmzv4A4F4EBvGmDh5wR/NjYESiYZNXwTcXJPNLJCo4krdE07kZ5zRhX+TmBbovsN6RtwmO2NUymsFrs9Cm5W1ZSAAtKXA+ZPeVOzWoXyr2361QGkuuRmyTDPadRIt5oFeBoFmoAq2GojpXdfuJz4HoIt4EapJfh/i0hGdPwSiz1u2X2HAmW+wibnAQM3bd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:55:32.1700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38ad26d-2855-427c-62de-08de5ff67898
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998

The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
for DWC") added support for multiple PFs in the DWC driver, but the
implementation was incomplete. It did not properly support MSI/MSI-X,
as well as BAR and inbound ATU mapping for multiple PFs. The MSI/MSI-X
issue was later fixed by commit 47a062609a30 ("PCI: designware-ep:
Modify MSI and MSIX CAP way of finding") by introducing a per-PF
struct dw_pcie_ep_func.

However, even with both commits, the multiple PF support in the driver
remains broken because BAR configuration and ATU mappings are managed
globally in struct dw_pcie_ep, meaning all PFs share the same BAR-to-ATU
mapping table. This causes one PF's EPF to overwrite the address
translation of another PF's EPF in the internal ATU region,
creating conflicts when multiple physical functions attempt to
configure their BARs independently.

The commit cfbc98dbf44d ("PCI: dwc: ep: Support BAR subrange inbound
mapping via Address Match Mode iATU") later introduced Address Match
Mode support, which suffers from the same multi-PF conflict issue.

Fix this by moving the required members from struct dw_pcie_ep to
struct dw_pcie_ep_func, similar to what commit 47a062609a30
("PCI: designware-ep: Modify MSI and MSIX CAP way of finding") did for
MSI/MSI-X capability support, to allow proper multi-function endpoint
operation, where each PF can configure its BARs and corresponding
internal ATU region without interfering with other PFs.

Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
Fixes: cfbc98dbf44d ("PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Changes from v4 to v5:
- Added NULL checker for ep_func in dw_pcie_ep_clear_ib_maps()

Changes from v3 to v4:
- Fix the similar conflict created by the commit cfbc98dbf44d

Changes from v2 to v3:
- None

Changes from v1 to v2:
- Fixed the suggested nits
- Rephrased the commit message with a proper Fixes tag

v4: https://lore.kernel.org/all/20260129091753.490167-3-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260127085010.446116-3-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260122082538.309122-3-a-garg7@ti.com/
v1: https://lore.kernel.org/all/20260121054214.274429-3-a-garg7@ti.com/

 .../pci/controller/dwc/pcie-designware-ep.c   | 79 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  | 12 +--
 2 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1cc2985bab03..6d3c35dd280f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -115,11 +115,15 @@ static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
 	int ret;
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 
-	if (!ep->bar_to_atu[bar])
+	if (!ep_func)
+		return -EINVAL;
+
+	if (!ep_func->bar_to_atu[bar])
 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
 	else
-		free_win = ep->bar_to_atu[bar] - 1;
+		free_win = ep_func->bar_to_atu[bar] - 1;
 
 	if (free_win >= pci->num_ib_windows) {
 		dev_err(pci->dev, "No free inbound window\n");
@@ -137,33 +141,37 @@ static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
 	 * Always increment free_win before assignment, since value 0 is used to identify
 	 * unallocated mapping.
 	 */
-	ep->bar_to_atu[bar] = free_win + 1;
+	ep_func->bar_to_atu[bar] = free_win + 1;
 	set_bit(free_win, ep->ib_window_map);
 
 	return 0;
 }
 
-static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
+static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
 {
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
 	unsigned int i, num;
 	u32 atu_index;
 	u32 *indexes;
 
+	if (!ep_func)
+		return;
+
 	/* Tear down the BAR Match Mode mapping, if any. */
-	if (ep->bar_to_atu[bar]) {
-		atu_index = ep->bar_to_atu[bar] - 1;
+	if (ep_func->bar_to_atu[bar]) {
+		atu_index = ep_func->bar_to_atu[bar] - 1;
 		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 		clear_bit(atu_index, ep->ib_window_map);
-		ep->bar_to_atu[bar] = 0;
+		ep_func->bar_to_atu[bar] = 0;
 	}
 
 	/* Tear down all Address Match Mode mappings, if any. */
-	indexes = ep->ib_atu_indexes[bar];
-	num = ep->num_ib_atu_indexes[bar];
-	ep->ib_atu_indexes[bar] = NULL;
-	ep->num_ib_atu_indexes[bar] = 0;
+	indexes = ep_func->ib_atu_indexes[bar];
+	num = ep_func->num_ib_atu_indexes[bar];
+	ep_func->ib_atu_indexes[bar] = NULL;
+	ep_func->num_ib_atu_indexes[bar] = 0;
 	if (!indexes)
 		return;
 	for (i = 0; i < num; i++) {
@@ -248,6 +256,7 @@ static int dw_pcie_ep_validate_submap(struct dw_pcie_ep *ep,
 static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
 				  const struct pci_epf_bar *epf_bar)
 {
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	const struct pci_epf_bar_submap *submap = epf_bar->submap;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
@@ -258,7 +267,7 @@ static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
 	unsigned int i;
 	u32 *indexes;
 
-	if (!epf_bar->num_submap || !submap || !epf_bar->size)
+	if (!ep_func || !epf_bar->num_submap || !submap || !epf_bar->size)
 		return -EINVAL;
 
 	ret = dw_pcie_ep_validate_submap(ep, submap, epf_bar->num_submap,
@@ -279,8 +288,8 @@ static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
 	if (!indexes)
 		return -ENOMEM;
 
-	ep->ib_atu_indexes[bar] = indexes;
-	ep->num_ib_atu_indexes[bar] = 0;
+	ep_func->ib_atu_indexes[bar] = indexes;
+	ep_func->num_ib_atu_indexes[bar] = 0;
 
 	for (i = 0; i < epf_bar->num_submap; i++) {
 		size = submap[i].size;
@@ -308,11 +317,11 @@ static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
 
 		set_bit(free_win, ep->ib_window_map);
 		indexes[i] = free_win;
-		ep->num_ib_atu_indexes[bar] = i + 1;
+		ep_func->num_ib_atu_indexes[bar] = i + 1;
 	}
 	return 0;
 err:
-	dw_pcie_ep_clear_ib_maps(ep, bar);
+	dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
 	return ret;
 }
 
@@ -346,15 +355,16 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 
-	if (!ep->epf_bar[bar])
+	if (!ep_func || !ep_func->epf_bar[bar])
 		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
-	dw_pcie_ep_clear_ib_maps(ep, bar);
+	dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
 
-	ep->epf_bar[bar] = NULL;
+	ep_func->epf_bar[bar] = NULL;
 }
 
 static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
@@ -481,12 +491,16 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	enum pci_barno bar = epf_bar->barno;
 	size_t size = epf_bar->size;
 	enum pci_epc_bar_type bar_type;
 	int flags = epf_bar->flags;
 	int ret, type;
 
+	if (!ep_func)
+		return -EINVAL;
+
 	/*
 	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
 	 * 1 and 2 to form a 64-bit BAR.
@@ -500,22 +514,22 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	 * calling clear_bar() would clear the BAR's PCI address assigned by the
 	 * host).
 	 */
-	if (ep->epf_bar[bar]) {
+	if (ep_func->epf_bar[bar]) {
 		/*
 		 * We can only dynamically change a BAR if the new BAR size and
 		 * BAR flags do not differ from the existing configuration.
 		 */
-		if (ep->epf_bar[bar]->barno != bar ||
-		    ep->epf_bar[bar]->size != size ||
-		    ep->epf_bar[bar]->flags != flags)
+		if (ep_func->epf_bar[bar]->barno != bar ||
+		    ep_func->epf_bar[bar]->size != size ||
+		    ep_func->epf_bar[bar]->flags != flags)
 			return -EINVAL;
 
 		/*
 		 * When dynamically changing a BAR, tear down any existing
 		 * mappings before re-programming.
 		 */
-		if (ep->epf_bar[bar]->num_submap || epf_bar->num_submap)
-			dw_pcie_ep_clear_ib_maps(ep, bar);
+		if (ep_func->epf_bar[bar]->num_submap || epf_bar->num_submap)
+			dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
 
 		/*
 		 * When dynamically changing a BAR, skip writing the BAR reg, as
@@ -574,7 +588,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (ret)
 		return ret;
 
-	ep->epf_bar[bar] = epf_bar;
+	ep_func->epf_bar[bar] = epf_bar;
 
 	return 0;
 }
@@ -969,7 +983,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
 
-	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
+	msix_tbl = ep_func->epf_bar[bir]->addr + tbl_offset;
 	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
 	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
 	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
@@ -1032,11 +1046,14 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
 static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
 {
-	unsigned int offset;
-	unsigned int nbars;
+	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+	unsigned int offset, nbars;
 	enum pci_barno bar;
 	u32 reg, i, val;
 
+	if (!ep_func)
+		return;
+
 	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
 
 	if (offset) {
@@ -1063,8 +1080,8 @@ static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
 			 */
 			val = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
 			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
-			if (ep->epf_bar[bar])
-				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
+			if (ep_func->epf_bar[bar])
+				pci_epc_bar_size_to_rebar_cap(ep_func->epf_bar[bar]->size, &val);
 			else
 				val = BIT(4);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8f170122ad78..43d7606bc987 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -471,6 +471,12 @@ struct dw_pcie_ep_func {
 	u8			func_no;
 	u8			msi_cap;	/* MSI capability offset */
 	u8			msix_cap;	/* MSI-X capability offset */
+	u8			bar_to_atu[PCI_STD_NUM_BARS];
+	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
+
+	/* Only for Address Match Mode inbound iATU */
+	u32			*ib_atu_indexes[PCI_STD_NUM_BARS];
+	unsigned int		num_ib_atu_indexes[PCI_STD_NUM_BARS];
 };
 
 struct dw_pcie_ep {
@@ -480,17 +486,11 @@ struct dw_pcie_ep {
 	phys_addr_t		phys_base;
 	size_t			addr_size;
 	size_t			page_size;
-	u8			bar_to_atu[PCI_STD_NUM_BARS];
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
-	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
-
-	/* Only for Address Match Mode inbound iATU */
-	u32			*ib_atu_indexes[PCI_STD_NUM_BARS];
-	unsigned int		num_ib_atu_indexes[PCI_STD_NUM_BARS];
 
 	/* MSI outbound iATU state */
 	bool			msi_iatu_mapped;
-- 
2.34.1

