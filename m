Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4922FE067;
	Sun,  8 Feb 2026 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574245; cv=fail; b=q73lXwN/QcjEUWwywOaBQmnqCb7PAHg806Ykz97ac6+eCn06SvykXRwdHVZRKS6rioL6RUtfnraNdjxxDAdXzqKqsboThl3x6XGjfE5vMaoG01lBBtxkIW3ylOEyEsyQEVb/e6hygurRXlCeEJnJsvEv90YIR2+5F4Unoa8IX1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574245; c=relaxed/simple;
	bh=gSh8K1LI7p/O4qpwK4Y446DPGMDHCtCJQrdrIWmwdqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNIPXGPuOP4DXfUnalxJlMOPKj/qlqs6B+ZoZiqNtsQoAzVBg1hMQ71v0/Z1jM1bUzOVM1zh8T+bB8BY7Mk2iIMn3P8VsiOCe2xq7H5VM2AQoeU5euq7t9M6srLIcPhTF1EjLt2YvtUe5hnv9gIKDhW7oKfcQq0Xa56HsHI6tT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HupFlQdn; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HupFlQdn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXsn0NHs8rEAalJgvqXNISNEVJHyjZ40H8r2RPR9EkgDRMBFACku9b11UaG47l4raZ4vVXNj1chALpLRvzleMYQXCNw4x/ur2PZ7Ufi/LFQlNRanzFm+0OK2c3kp8Kp+qeCZG+cZarv9gXa2DWgdDS1hmPrEnDXo3HgiK7zl/B3PMbxtcC8Vh8rXsn+i5l5J28s0OIezbRmxiqdjzrzMDgKSFH7lwmTCqLklIONXHGiAVjPbj4dw8r9GDVHRp5OJbzO5Aznuc8m8XFi32ZNkWTA8Wily+Jagak5i272l+hDFifs2DQwaBu4wNtwnZSxkyb5+djyESXsqTJOnAHugKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZeL0XlPuSAXzlutHu9PBDVxfSn0u6bBrfj/VOZ5ujo=;
 b=hjvnNhKDycm65Eu/tSyoLuiyrFCmr24908pc3102wiahA/vrSTd8Zk7Pu/tHgrP+hYGp9meputlFkl1NeqpKkGmjGBEQTJdZTk3xYr3g9n+ZHRVvEsa2tXP49fBbV4RHCtCw4jn23ga3zGdl8zmxCgxctkHYdhA2D0Bsn/A3SwN2Hw0rXOFuloAJWT5z2192I1e3kXfnvuD/dgNNwhtfSFFv7UQVM8e2zzIHRg5JAHXxrhaH/9q93JLmKt3+cuF4FlMDAOduyQWmKnQHPIydu+cwWYoRYKJXmaA7Ztqz6cOti6PeWfn9ndJvUvUUqWb9+KAMu/wBAQ3xE9uKCdXKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZeL0XlPuSAXzlutHu9PBDVxfSn0u6bBrfj/VOZ5ujo=;
 b=HupFlQdnT3VLAgeh1NahL2yMDb5RuyjGNcwrfpLJW97etdPjGsNgNvGREZ38OXp0EqiSsXwg5eL0qQTimPfaviUq1x5WH00QdgqHhkanE6eIkGPMxG9v4Ies1jnm6OZ8csj20manxilGH1Qnc9d5pOd8GwjqXmCqZH0tHnudQOYUVfNRG3i3I5tqST/oAxMgFtheVBX60Uy/pDNMWYKshXurpul13HG3sSen2k4w6gcUk2DXztz/o+gstuxcxg0xcj74ndF+zcr/svk9tPt1c4y6wDR0k4fHifWojxbfZwkGv4RupxAbvTn9ubm2MIA1SiXJsa8ofLVElE3uGIp3wQ==
Received: from SJ0PR03CA0099.namprd03.prod.outlook.com (2603:10b6:a03:333::14)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Sun, 8 Feb
 2026 18:10:41 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::1b) by SJ0PR03CA0099.outlook.office365.com
 (2603:10b6:a03:333::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:10:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:10:19 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:10:13 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,4/9] PCI: tegra194: Enable DMA interrupt
Date: Sun, 8 Feb 2026 23:39:31 +0530
Message-ID: <20260208180936.2026329-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
References: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4b4105-c714-48ba-d348-08de673d5e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pO11XyDZb+AhIjZmj9xmM7Q72F+da8ukn/KuGj+dcr9T/0O/Kjnh2zX9tiqp?=
 =?us-ascii?Q?qJrvR1RD9NXRpyfQ4947h61Orpzfam94+yk5htAfSzoX8FD4CwGeWlvARoIS?=
 =?us-ascii?Q?T5zcek0owtRWAPHATN8z43K5Qr92l6N4OUfvvixSKbXdb+ZIM0rDLzEYWkqD?=
 =?us-ascii?Q?V01ZhXkL05qrAyqhfmY+RKHMPC5r77jNOVuVh/C2NEJ2rvJjLq5FGPLnI5jd?=
 =?us-ascii?Q?sP0b0ZdDNDBDRz6i86lXq4l1BELdnFkR35ZBPw8O7ScebL9WeaO48ZKrb6nX?=
 =?us-ascii?Q?wZRqIWBNIN44sU66LjI5nxbkcHSbUOk7qM0FpBkg8hWhCK/vzO5+WKCrzHIJ?=
 =?us-ascii?Q?JY5w9C26TQd16Xg5tqTk1BF9kKc0ZpJE2PmPwh+fG8O7tCf3YqAwIJvGAn0A?=
 =?us-ascii?Q?s9zZCQ7UOVJ1y6kB201RDeH7lk2xsLk1gUnNSf33rCwULaAa0gOFZjXXTkBs?=
 =?us-ascii?Q?bt+PFnBPrn4M7UhzwRca9lW0McQcC2D53xBne1aZwCy8OqETDSMoSWCks/Ce?=
 =?us-ascii?Q?GPSN/SKq8+wcr+STIw7Tc4e7QWuMfcES6JTGq3FQyJTqMbzmA1l20BioaqiK?=
 =?us-ascii?Q?dhMXJBMRzVRABx3bpRTTAK3RdHsGQlyaI2s1BMMqU1iiH7eW7lFcNnertIN1?=
 =?us-ascii?Q?Hs392brXTZWZc8j12jCPAVkkKKHpaNruIvIhJqfMnWvK/3hJzl9hN3Co2lEW?=
 =?us-ascii?Q?ZJTL5rR3T6lSWblmlcIq38oe09TPtbiskyy0OfU6lfL24waOv9tiBpGnVY+R?=
 =?us-ascii?Q?irGe6EJyvDbX3Y80LrTkUSNu4Y+orAypsL3CwPGaAk8w95lMz5OQN4qU3jZQ?=
 =?us-ascii?Q?CO52Ks/sSN1b01V6M+AClJi8+iBc8JwcVAy1sDY9gBdx4pMpdEk92g6htUDJ?=
 =?us-ascii?Q?l71gSQXRvl/1w1nJekJzj9mJAVrxjAV6Ty/6sN7n1JqlYx0TAnOUUd5SUBAp?=
 =?us-ascii?Q?8HtZG+uhoZGDJ+lFN6NgQuU2wMrqcb4jXXee6O4YXl/xvm1mp8E9JA6RoTWh?=
 =?us-ascii?Q?6KCiux2K+X9TVWsvukTZ6CgO2gXvMMBrnKMKx/iduG3kuR1UbIg5UOs18rTD?=
 =?us-ascii?Q?DUSJu+WUMb/buXPb66AC0myf7D429Z5XVQ/H968amJg1dmfa/vLtnlNVp7Dj?=
 =?us-ascii?Q?SVvihFFDx7JTQag+kFy/TbrRte0h8B5JPAz+PvI/lQGgDrwHHaVFCh8jqVtZ?=
 =?us-ascii?Q?ZTtMdL4N/9Hf0X0VDEqyyG99dI+nET5wEmrxarHLo3CsKKkH7JI5DQJDp5VH?=
 =?us-ascii?Q?JVN+FgziVst4Jd6SBATrAJA73Q+oyG6wsCNDLQ3JV/m5GFLOPc65YJ/56h9Q?=
 =?us-ascii?Q?VGveNRY1qncmvtpgmifn5JIaoW3jzDJXVIdg7D398qtOkZ0R3MdjeSKr8joM?=
 =?us-ascii?Q?0TuTTACqLggk8RQjjAjMZI2/umFoHZeSNzohA1x/CmHUe7gn/vlGQ7ImKVpB?=
 =?us-ascii?Q?X55wg0+dZ3MY+vlKB67GztFzCISVHjqAEodBRWx/76Ax/RB/oGToNQhWrE/w?=
 =?us-ascii?Q?Pk7EDWWqr/ybnGFINz/2LZRmmde0Q5tSPuM+11G0wLgyklXV/gIIVjQn4F4O?=
 =?us-ascii?Q?v2PL8DdS1YUOZr72UL7m8hoIyGFKS1fDtktsqYqvJV2F9WhooOzmdoxYw2An?=
 =?us-ascii?Q?lHeRQ1svceeYAyWWrBdvf1YA3iLgBMzgcijm4TVifnmtEn1ZacmLEryUuhdd?=
 =?us-ascii?Q?nSJMwJGas9WWTg2oURiwdEWYu7U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y4RNEoIzdJSbxdZ81p7lAts9WGa63XxW5sdbP50YA69DGFSC9eZnt1iYwAxfwePPEgulXzmLsMn7ief7ZEDnxK9osxKkq6p3exmvOrVDbgxlr2R++q7eNDYIlADzKsHgn6i1iymWa7EFL6DeJp6H7hdx0ySCXBlo8Iwt9nLkhHji3yfontIFjzkfGYP+BMx4tQ9VcNKRUHHbSWi277v+n82LS27ONHNTeMWWrtLh4ucgqamyl2mkJURZENKvlgri/jGSDy+mJUzM5PC61oFkx7I9roHm3TrXZjXCE5UwoQof6O5LM0oVWkWoVs5p4CFnMMX3DqFY5SKWq986FiGtae4yZt4mcooXwD2Cy0gnyeWKJQ41Kusiqd3nqD8tK8FdV1kSCFC8rX+GkWWYIhM/t3MHUgcLzbqXTkAsZX5wym+dAcR8RRoH5RRH0Mblmfzl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:40.9492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4b4105-c714-48ba-d348-08de673d5e97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662

From: Vidya Sagar <vidyas@nvidia.com>

Enable DMA interrupt to support Tegra PCIe DMA in both Root port and
Endpoint modes.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* None

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index aeec5f8b9842..110f2adb74d2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -91,6 +91,7 @@
 #define APPL_INTR_EN_L1_8_0			0x44
 #define APPL_INTR_EN_L1_8_BW_MGT_INT_EN		BIT(2)
 #define APPL_INTR_EN_L1_8_AUTO_BW_INT_EN	BIT(3)
+#define APPL_INTR_EN_L1_8_EDMA_INT_EN		BIT(6)
 #define APPL_INTR_EN_L1_8_INTX_EN		BIT(11)
 #define APPL_INTR_EN_L1_8_AER_INT_EN		BIT(15)
 
@@ -547,6 +548,13 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 		spurious = 0;
 	}
 
+	if (status_l0 & APPL_INTR_STATUS_L0_INT_INT) {
+		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_8_0);
+		/* Interrupt is handled by dma driver, don't treat it as spurious */
+		if (status_l1 & APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK)
+			spurious = 0;
+	}
+
 	if (spurious) {
 		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
 			 status_l0);
@@ -766,6 +774,7 @@ static void tegra_pcie_enable_intx_interrupts(struct dw_pcie_rp *pp)
 	val |= APPL_INTR_EN_L1_8_INTX_EN;
 	val |= APPL_INTR_EN_L1_8_AUTO_BW_INT_EN;
 	val |= APPL_INTR_EN_L1_8_BW_MGT_INT_EN;
+	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
 	if (IS_ENABLED(CONFIG_PCIEAER))
 		val |= APPL_INTR_EN_L1_8_AER_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
@@ -1789,6 +1798,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L0_0_SYS_INTR_EN;
 	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
 	val |= APPL_INTR_EN_L0_0_PCI_CMD_EN_INT_EN;
+	val |= APPL_INTR_EN_L0_0_INT_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
 
 	val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
@@ -1796,6 +1806,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
 
+	val = appl_readl(pcie, APPL_INTR_EN_L1_8_0);
+	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
+	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
+
 	/* 110us for both snoop and no-snoop */
 	val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
 	val |= (val << LTR_MST_NO_SNOOP_SHIFT);
-- 
2.34.1

