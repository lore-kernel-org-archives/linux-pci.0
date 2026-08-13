Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93BE41F359;
	Thu, 13 Aug 2026 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603099; cv=fail; b=qn1tgtsneVpcs5ZWlFKom+MwS6tbaSc9tj7pVXoVEw6+Z6Fd1R3+dpOKEr1VimsT3ssn/SxHKNvtWHMsDAIMujsWycOPVsXMK2ia3gFac6gZUAjPtGF+nJh/yYKx5rDGGgtliHyx7wQIm/8Euxzj9LUecepSyLYGOlMvc27T+Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603099; c=relaxed/simple;
	bh=6faGvtZ4p8KTtPOj23O20d4SOfAyDeSTgW6eJZl9o4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qK+Pxn1Qkz7ORu7A26tRL+X23CmCmOIARxrhRCO/o7v1GL+mcqOGEv1N5H7At59l2C0SURS5f/GN/iCyDxpB9DcCaucNLBR81TaST8U5vtztlLJ3ze1bhBHuUYWBgaOPFK0H9BTJdJpH52A4BEayLWmNYpdLhBZiiD1qubLD2Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CbawRU8D; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CbawRU8D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqEm6RyB5RoqhkKGDHsm9EhDKZJb3ITW2Tgo5SdgecaKltY/D+jpBH9zz4syH7yPKMfBWxinr6/Qexbq+B1FZFE7hLyW7TArpjR6bPnUWv9rDJHUWFJQTLJO9XRwmofF+23/zJ1lMISwj82Uxgz1eTezI/k4WCFP5yn/FBC9gF165UFlvm363ccKvzPZ0naqWnYJcxDjXFq++IHXa7u+7T3jjjPzPuey2vCtWQRV/e0aHpMW0veDtl0a4VM2K00E7TgJUiommMpCTUnh0j/HCRjvgTaDM7sDnrce1yjspxfiL6cU7pHoiUu+nqJTyot8sh9ODgdQMdiy9YzcX8H75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH6ayCgrlvM3yopYnRbwDCuPlDL26gRVP+f1XaotT2Q=;
 b=iyba1ZUrJFsk4OI6bNeobNxHGGlybx7twvOxwYMS6BLP60wk5aj7sYIJ/zHhZzFfd3nSqEmo2uAvNyktVFcIuf02JuGRaul17ok1LtA2sWpT/PFcRdFeZgaMOYf7tqpHwUnzk5JS/vzO4o2QDO99HTIBiTErZsrH+iSooeNMDYzGhWnGJfX0o/2+A6ytYLbfULJ9DSSVMUU0/A9nXtrUaSytwMHFQY1NokH6NGGi5w9+Jl9HVqX0esVoGNAq8aoYOH6IMT3cCeUxRqRC2U/LFAwtkoQf9+5OSiwLqrNBsnxl8gTQVSw2uuJplobCVL8zkb2S9HJgAsJnVQVKPec9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH6ayCgrlvM3yopYnRbwDCuPlDL26gRVP+f1XaotT2Q=;
 b=CbawRU8D3DyrNRurHWI1ZGoGKso9EHGtmOd5m9bc1TqQ9yHvfjn2z1fQXJbEpF7WhtGG92XdloMK1wT1LwYqAz0WAkKyKO0E0mp8yaT7KkSmKhLUx3nKDM4caMasU3BKy+IKvx9fv1MMLX1wzKfd60aYTqIeW5uvNYW5V5ZIWIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2252.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:38:10 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 06:38:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v7 07/10] PCI: dwc: Expose endpoint DMA resources
Date: Thu, 13 Aug 2026 15:37:54 +0900
Message-ID: <20260813063757.3131865-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::17) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad96d2b-d4ec-4216-e04e-08def90570fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	EvDGEwAtu0rw31zR/oOOgYxaSrKB3sArfinW2Elr+xSkJyWqPNWBJbDn+0t9+8z21MRETF2WMGEV9ed6HuTEqnCkOkqrDqt2B8ClK5Sv2FJ4UVOn+/BNnIE6/Pv2T5eMytfWAdNjhFvjRr8Xkuzxj3COwZofNE66iZqUY4gqQl40qIiOjDSJtpG1+HN16VEu9gTU8aDor9bMgOfbnvr9/1Q48zukF/foTxu/U9aczbC12wloQbsLmqiv5jBlSKK4nezPpyL6NtJahu0CuarDchGiUgsJ93xh2FD65ieYVrrQUlhK5Raq0kOew5epvo0kXDkCXuMdArLHu3btbKv7x092SvzX4kLdUbqq/Wg781sHYZQ/K13eVymFS6oPyafaKOsgeOmug2d+Lw2kcjdo5ESLJtRdY8K0dXHFrHI7vgTsgrEwn9YZG0asDDXwsN7lxqyDC5ruxJSVcpzxLDGuLOFt0QWG11EZiqUA56xTCGBZFfKDh1bNRs1SF8KN3eVKA58vhtPeu4SctZXdviwrW06fwNMxKPBneLWK7leNhKKOP9+fPrR/FPJuPzXa+AzS7+qtD8zmQnXXFObzZaVsr1xpvrtbFSQMe9NDoI8RwsJ/XOEmYYrQp+i2fu9rskflS9+FSzSXuLHGyyGbdQR/J1bBlyouSC+PeOahS4hyire+rK2adiwkC2M0iqC2f1mWvUlmQ9IR4s3lsYT0BvEtAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?il+9iEPJGSpyp1i1UNW3M2kHjmZx/5z4KsvqUrWfAwFwUSZRu78OUf4mxa1D?=
 =?us-ascii?Q?eEvS9T/hoJpwuHEmxFNbxNaFDNprV26a9wDElu1KqMARnSOXf8NmwlTYvomS?=
 =?us-ascii?Q?LSxHew8jCwuKWcLRXW+/v23XRGY1Ts93WKNwH5QF0xQmxZ4Ml1fUTu1l9N77?=
 =?us-ascii?Q?OLBQ9kgJJvC2zEl8TmkZ6woV0J1Syoi/KgnIXvmXGHFO6i52lfYsg+m9/TfS?=
 =?us-ascii?Q?M8SRV7/P71btN5jjIrqJSNQq96GTkWUNnzNyj2Vzm946VzZKppNpKy4WOJI1?=
 =?us-ascii?Q?8sc3JtMcokY8zeOj1UhLMzKatQPVoVGtvYmxaOKEqS2ZNVPH7UzXi2O2cv8i?=
 =?us-ascii?Q?qnOHFLdlPrP7x44rdRXbkKXjzIrYCOP/dBKBK0KWy+VueOebpiwmy7lzPIQy?=
 =?us-ascii?Q?6Kcu5/lC5JIb0wxxRggeDrigM4o+MF0JoAX3Rnk4eN79ylxWXM1NEXXb5Bu3?=
 =?us-ascii?Q?iYLKKXUnQKfdG6/WTL7oOjbyS8yWa2/1WGExDnI0y975u5Q0SiG9RQAyNHO8?=
 =?us-ascii?Q?MwBxheC8mG7MdY7AU3JI8xqmqSZODrm8tt2Qsb6JyAUyMjVwvCr0MCcKg0Yv?=
 =?us-ascii?Q?oomEqXEj9c4NwFhR+0XSmZ/mIWX8MpZ/IN4dZQkpRu71IHX/S7Js3ZcQpC77?=
 =?us-ascii?Q?mwsyLnpu1mf/vKMkRfuTVSjy2hIw6jEBUUbBy02jTpwB9jbWy1ZtnyRw8MPP?=
 =?us-ascii?Q?ALpk9rYzv35Hmx8lEbQ87QybR0Fh2T0VaAt8kyXxomlP6DuBRhxppJmO8cYb?=
 =?us-ascii?Q?EU8dcrco1s5z8t5vzcHgyI4AsjW/deY9FUv2yGWwGFSjVfDfbrZSNyF6QPZg?=
 =?us-ascii?Q?XflUlxdTpcuvFzi67fSgZOL8wK4fefWtXM4dGmJW0D4fEmXVpeCZLFTc81Ro?=
 =?us-ascii?Q?1fdeVrTdCMPbTXp0DpUOvHIj7+R8hpgnzn53MX+k4JI3gcJ7Ym4COyZTm+K4?=
 =?us-ascii?Q?QgWa6kwAIZXZuQdzcfGYNVmBa29e15mLw3mbsJdI70+OEcxcyhSFPsR2AQZh?=
 =?us-ascii?Q?lrjL4qh0Ow+EwxUZ6k9bruJJznFqbTa+3//Z6byTPFNdkvgcO6unMdJCCG7T?=
 =?us-ascii?Q?kIM2AdYnoonJWvTTGVZaIuXWC2DkSaZMRFGni+bJSBMKrxWyXs5FHW2awFx/?=
 =?us-ascii?Q?aYholYVThV+8fFsPTz7cs55DsG0crANE5GLt0pPwFOZNQNW+I82JkojO9P+F?=
 =?us-ascii?Q?QwnII+Q9jUbcJfjs3x4mNvxEYVQjNxs7GlRIJQwucmTtIbUZoPntY4NmDVuy?=
 =?us-ascii?Q?7+CvQiA4Wd6NDzUZPJgeY7UWpQ2dhG9tkHnjc4pcKxmLtL4wP6D8NVvqLynR?=
 =?us-ascii?Q?MIP/8NTV9MjFVU7eJsV8quT8lZNKYt3I+qWLBajJM/3dF5mvbfut+H1Fnonu?=
 =?us-ascii?Q?QLtQ84dA6Gyl2XjmvAFfxZJNzDzRUMbE6vAVoDtBzBtPmY9QlzirzTGsxKFu?=
 =?us-ascii?Q?HVe3vre/kToKzmc5ZfMU4A05c2oCSCW4K7inPO+38VQOPoO1yt5R+VPjL1Mf?=
 =?us-ascii?Q?AqfajiYxWuXTqYbCuLGp2LY1ngzeKNgFlhOZHsSZxg4/sypaZ7x2erlB6B/P?=
 =?us-ascii?Q?wqkBVEnQHhV+G9PBuQ3Naf6rieUN2xY+OwOjGbvtE6E09+SX7ykDFEe/eZqT?=
 =?us-ascii?Q?gzv+KmTNsKsR+mKO2clN6VapQ6HgE1+gfLYtSBE/LbI1dQ48SCy7VDsTO8JF?=
 =?us-ascii?Q?jIMgB7dPcThNp75JhLQAmClQdIOcG7V8+ouEiGUBOWaKDqxc/XX8kpgbj/Be?=
 =?us-ascii?Q?JYSzXRpRGeIB8Syb7pzoL6SHGqpmT3iG7FGj1uo7BRICTyWewHjg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad96d2b-d4ec-4216-e04e-08def90570fb
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:09.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7Lmk/zVrm1BXTEQtoHzzxwx+s9AE+pwg+UX3uZSZmmmWLCbfoYmMmgyZY3uxigwnhv5hfZ43ySPaIVGy1SvgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

Expose the DesignWare endpoint-integrated eDMA register window, logical
DMA channels, and linked-list descriptor memories through the EPC
auxiliary resource API. This lets endpoint functions decide which
channels to publish to the host.

When the DMA register window is already visible through a reserved BAR
region, report its BAR and offset. Otherwise report it as a normal
physical resource so an endpoint function can map it. DMA channel
resources carry hardware channel selectors, identify the corresponding
local DMA engine device and static channel ID, and refer to linked-list
descriptor memory by ID.

Expose DMA controller and channel resources only after the local DW eDMA
provider has been registered, and only expose channels whose linked-list
descriptor memory is available. The interrupt-emulation doorbell remains
reported when the local DW eDMA provider is registered and its offset is
valid, even if linked-list resources are unavailable. DWC non-LL exposure
needs a metadata ABI and host parser extension, so leave it unsupported
for now. Reject VF auxiliary resource queries because the
RC-programmable DWC eDMA/HDMA register window is assigned to a PF BAR
only.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v7:
  - Report the local DMA engine device and direction-flattened static
    channel ID to match the auxiliary metadata changes in patch 3.

 .../pci/controller/dwc/pcie-designware-ep.c   | 142 +++++++++++++++++-
 1 file changed, 134 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a74d3896e436..957739b0ac51 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,22 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static bool dw_pcie_ep_has_edma_ll_resources(struct dw_edma_chip *edma,
+					     u16 ll_wr_cnt, u16 ll_rd_cnt)
+{
+	unsigned int i;
+
+	for (i = 0; i < ll_wr_cnt; i++)
+		if (!edma->ll_region_wr[i].sz)
+			return false;
+
+	for (i = 0; i < ll_rd_cnt; i++)
+		if (!edma->ll_region_rd[i].sz)
+			return false;
+
+	return true;
+}
+
 static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
 {
 	/*
@@ -877,14 +893,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_edma_chip *edma = &pci->edma;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	int count = 0;
+	int ret;
 
 	if (!pci->edma_reg_size)
 		return 0;
 
-	if (edma->db_offset == ~0)
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
 		return 0;
 
-	return 1;
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+
+	if (dw_pcie_ep_has_edma_ll_resources(edma, ll_wr_cnt, ll_rd_cnt))
+		count += 1 + 2 * (ll_wr_cnt + ll_rd_cnt);
+
+	if (edma->db_offset != ~0)
+		count++;
+
+	return count;
 }
 
 static int
@@ -897,14 +929,34 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	const struct pci_epc_bar_rsvd_region *rsvd;
 	struct dw_edma_chip *edma = &pci->edma;
 	enum pci_barno dma_ctrl_bar = NO_BAR;
-	resource_size_t db_offset = edma->db_offset;
+	resource_size_t db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
-	int count;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	bool has_ll;
+	unsigned int i;
+	int count, ret;
 
-	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
-	if (count < 0)
-		return count;
+	if (!pci->edma_reg_size)
+		return 0;
+
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
+		return 0;
+
+	/* Keep the bounds check and fill on the same provider view. */
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+	db_offset = edma->db_offset;
+	has_ll = dw_pcie_ep_has_edma_ll_resources(edma, ll_wr_cnt,
+						  ll_rd_cnt);
+
+	count = db_offset != ~0;
+	if (has_ll)
+		count += 1 + 2 * (ll_wr_cnt + ll_rd_cnt);
 
 	if (num_resources < count)
 		return -ENOSPC;
@@ -921,6 +973,80 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (rsvd && rsvd->size < dma_reg_size)
 		dma_reg_size = rsvd->size;
 
+	count = 0;
+	if (has_ll) {
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+			.phys_addr = pci->edma_reg_phys,
+			.size = dma_reg_size,
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar_offset,
+			.u.dma_ctrl = {
+				.reg_layout = PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+				.reg_layout_data = edma->mf,
+				.ep_to_rc_ch_cnt = ll_wr_cnt,
+				.rc_to_ep_ch_cnt = ll_rd_cnt,
+			},
+		};
+
+		for (i = 0; i < ll_wr_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_wr[i];
+			u16 desc_mem_id = i;
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_CHAN,
+				.bar = NO_BAR,
+				.u.dma_chan = {
+					.dma_dev = edma->dev,
+					.chan_id = i,
+					.dir = PCI_EPC_AUX_DMA_EP_TO_RC,
+					.hw_ch = i,
+					.desc_mem_id = desc_mem_id,
+				},
+			};
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.phys_addr = ll->paddr,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.id = desc_mem_id,
+				},
+			};
+		}
+
+		for (i = 0; i < ll_rd_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_rd[i];
+			u16 desc_mem_id = ll_wr_cnt + i;
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_CHAN,
+				.bar = NO_BAR,
+				.u.dma_chan = {
+					.dma_dev = edma->dev,
+					.chan_id = ll_wr_cnt + i,
+					.dir = PCI_EPC_AUX_DMA_RC_TO_EP,
+					.hw_ch = i,
+					.desc_mem_id = desc_mem_id,
+				},
+			};
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.phys_addr = ll->paddr,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.id = desc_mem_id,
+				},
+			};
+		}
+	}
+
+	if (db_offset == ~0)
+		return 0;
+
 	/*
 	 * For interrupt-emulation doorbells, report a standalone resource
 	 * instead of bundling it into the DMA controller MMIO resource.
@@ -929,7 +1055,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.51.0

