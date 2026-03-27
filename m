Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC3374171;
	Fri, 27 Mar 2026 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583677; cv=fail; b=gbgSQwrUnqu5FGbmJiM5O4jPJKyC/mCU0CAkUvd4tijK7uEV8m1/laQM+yTker7u8V7ZTdIRi5V0fYUpMJvrzXm5B8V9XTbjjyJiY/crQ/f9X94t8Zkg8SRNEY30PLqZyDVe4f6XtnvqcazL9wcHTP71HMwqFbBgTyW/djrF7GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583677; c=relaxed/simple;
	bh=HYHjYYbJ+LK+MKgfogzUKbUDLxGKBbAfHQmsVYE8uvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d/Yjem4gpOTrAyX3gxeuz32D3AtNblJ1mReM/h8aMseKDfo6Pe6ZC/f5xxUlbfe1D+fyKto6lam+xzgRdROhjKmBqcRjSBL0Ib3MUbFTJ5EGSq8rg05Ak6A2yckd8C8TEew4ru7fmgC2gnai58x4knMQWU5r4NAfS9XyZ5j5zng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DjNdqFBO; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DjNdqFBO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksvNP3MPZJkVly/GlRHLPfW6pcKw89iq4k+bVQ1MfZImslJW1CzMf18OD59XhBIgzBlgN85iz5mSNhSw47uU1a61DEx1TsoNAqLdehOJAQCb58xvZDWMVDMoSnqAfsFldzEAdSo4MOjBWRpJiAS2yVlojwA9K16nwrHHatKqTxa8DhwjRKQgZecp0kAzjqIlzQFWomiNKqmUaG7RbdfojM2ZQpX4gsrQrV7eQ3WknPJyez3eLJ15ZIsmrHGWFHcKzPzPfHx+n2l/myBb9KEEoOLptV+tF9/bCJS20Z/Iw0nJvQpdkm1pGBFN547yqonFAByWsF81cn4iiPfbWSTbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkG0mQ/dTmFeKTp/KBqXu1p+N2etQdhVWA0Lv2npZuw=;
 b=viVefzWaOLMMT5ZawbXGdNGzuxIUrtRXcbFMRJykR4xLO9F1ek/Sncn9KD59jMBhV/y/2vNJ2frssKwan40fust4qPw3LnxuDyXrC2Uf0fFQJlEpxnp7cFjwSNhT1gduSZXQhhtTOfXwhLjAu0EDL41g3EMeTdaO1sS85K4uiqbgSbxZ/8CwEZ3aWFJoV0Bt01/bEH65ajbUMY1lJGqu3vkMcyFyx2tliZ1LpyLpjY+cPpAPL0RtxorXSObrvXlkiM3sWfUw/Bie0fGBPs7da5Anb6BWzzGrjV3NXE18bJ2YVuj3iT1sNA6fmLvc7lVZiYbmNHpMe3D185nobSs4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkG0mQ/dTmFeKTp/KBqXu1p+N2etQdhVWA0Lv2npZuw=;
 b=DjNdqFBOkNY527Vn8x3NsNZPbQ6JgmGh36aUmBFDNYcQ2viyR5DgKPNY22718VuIKcUttA1aau7CWUkYMZl0B686k8e77qB5dep1/fivuyVDB0z0hONom/yL48/1wzOdWTXWPts/d/7T/Up8B9yJxOj3MQfMI2rP4042h1/6fjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7090.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:54:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 03:54:27 +0000
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
Subject: [PATCH v12 3/7] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
Date: Fri, 27 Mar 2026 12:54:18 +0900
Message-ID: <20260327035422.4020455-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327035422.4020455-1-den@valinux.co.jp>
References: <20260327035422.4020455-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: a3000e34-5967-40f5-ce62-08de8bb48b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Saj1NrS/5QNZURB42KsN3DS/YDpaoMPmrw2K9NRBKhLtARLsMyRCX2z/aQpQRO+Ia1gVYX1qdVfl6MeIMQ8a1hTWz89w2tmQmLV9xgm6pyvJzNG7OAMTJOlOdW+5+IgMamZUhls2ZkqSsCOjXoyrQzp1m9bzBLxSgJp79vCmvA+tI2pGgNRmIjzj/zK8i/fsPvLkkKwJGf2Q4EFeO0OYAYaAl0/9uHY7pzuDBrrz1CH3xFaVyVep/eyNIs9Xt3V/HYRhJe53FG3QZOBvVZCJ9R+PJt6DpkMaOm+a20JVMAwRHOB6JLKaTquom5ESP3q5gEdVAH2zFBaS7BfRdaaCFWjoWrtTYOzG0oyJKTzKdJJaBWzughYDtRLnMrtxt+XjUXG6qB09dKhe7AU7STmYSmoHIo1REpQbFLlZYu7YznfjtgdHIlzLYule/1I+W9FnUMei9meYnroMfAb7G3gD3YINJGnhKCMjoT7LKbaRfHe+4bgwT94mWfMAWaIZzoc9qgg13SbJSpYOuXQZ8rkQbvvXP2w88nm6yTZr15u+eTDoGbQZEa8u0Q6mVkMcqp6wufWruSVKYTxBtfGJEYV4lH1TMtUr59jc0gXD140MnC1SoA0cQ1GyvrG1/FNUYnlFvZpArMnCMUyOPYp5r6k+bb4NjV9NN9EmXP9qh5RxeykcBUgH54Sw1E+OFqmZ3ROi3ROX8daJDu8tXfS6/nv7GOGGZ5o3zx9Q88aaFhpDbLOz6O3iXTjnnCmodtWLLFoPK4eh/yLi0KySOVMWTv2mVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7eh8JO3V/kY55RnaYjvnaNiKLQ03Ry1+eVKenDZX0FfWMCoaS9zzq32Mg1LZ?=
 =?us-ascii?Q?lHUYsdxQiVRgI4IBDp0mLZ17RKEp1XoDOJ+yEMlN0UfeFXe5Ak61lJpqsoG6?=
 =?us-ascii?Q?nYa5hJgqLpG5uIX4Ah6o7LQTJ3ZfTtV22ybfnxZYRGRNmCTXBUspUxytLCfB?=
 =?us-ascii?Q?CrcERAorUMZEnEQ1v/RvQL10+wPqs2MMgT7h19YBMBOgA9A0/wpI4vMJE/vl?=
 =?us-ascii?Q?Ne7m5s68uwBCEaR4/mTvo1K+i7eeCoCJHjzirIHXB2wNm1T9RjMDLIymKVtb?=
 =?us-ascii?Q?DK7dn0u4NG5RRy0U8GMVr5qeydeC7oFZvDWU8KZHekD00f+uRr/FjNpJRM+k?=
 =?us-ascii?Q?V2ygwg8217BH+Oh9YwNYjqQVIGgZctXFnGE9Jr2T+spW7JfEA8nEY/r11JnS?=
 =?us-ascii?Q?OP+sGOZ8j9h9QaeTHAL4DuuWTFymlIXbGswe7hoOVvgig644m8N4893cc/Dz?=
 =?us-ascii?Q?ymDLo+l04zd2uvq4CZY4+9qaxbdoH+rBj9QZBugdHRD/uPgwlg8IjPICQ0mV?=
 =?us-ascii?Q?TUZWRxbWnNvzabXCwQNitgg+ViouHQh+t6WxJC3WR9cGQsLAyp2q3ffF2pGL?=
 =?us-ascii?Q?CUFR+v9OCZV1KSBR0Vmv2J2lWnA51+53qkFr1QwCjZeaO1rDAFcuWmhe7/Ku?=
 =?us-ascii?Q?yBzjDuBKKJ3JZnOKaSXtytjQjcBe1JaXHqPBe+aAsKxXfUV6qIXyDeWTtJHR?=
 =?us-ascii?Q?D6ZMVOWUjO76IT8/l7IKQCP27pJeWEcCLBowmGeF7jUGdbCeQ3oCjwXQMgA6?=
 =?us-ascii?Q?Gs5W7LzYshpoyyUXsRX26fmORohWgT9pTisAqlfuQL4K/CPnQDEgfVj80076?=
 =?us-ascii?Q?UF2wRbJKDdDMpP1Sf4ZamPsqiFGLOMAc4402w9Nfg7O1SrmzlavxKA5DtwAr?=
 =?us-ascii?Q?V36gPj37oib+59H+0ZCDqw8ypjIE/cz/NOm9iDrsndNndEykiLGOEaVvosWV?=
 =?us-ascii?Q?FQha0m9dEVD5T+0xIXPn74S6LdX3ljVkSrHkZ1M/YBwR81ApsVTlcxo5BqNJ?=
 =?us-ascii?Q?XvqI6axxT5hbsSruDfPS4rjXPLCzH3RkuM6SpQjmb6DdYcVDqToz8GoeR+ZO?=
 =?us-ascii?Q?W8wo72Y/X4gd0EqC1I4bb1zIEbIWQOjZ67zHR6C1nvbcLUBaQo3VQPMCu+Ok?=
 =?us-ascii?Q?NLUgZKu6Dx6f/LyqX2C2KL3B7W97sckymcLCX6xk5rBmVnR91q5Q1svLdF44?=
 =?us-ascii?Q?5VAbhEyWipDRM6uPVHnYlPdwZHWsnLTDFxtA4Z7+tPNhau9GD6Nb6m/lC/D/?=
 =?us-ascii?Q?iDxomYNja5wYel1gC+ADPYIT47wLQDU4f9lvkm/hjUA0DTzhEVO707EgRpRf?=
 =?us-ascii?Q?qdbP/fUJr44bMg/szLESoJaosbqM7ZCW4i2Hd1NRUWGW/e91ZgiUJbV+WOpT?=
 =?us-ascii?Q?s3fFf1jiuYKqKQaQFFCWFpWj0MIKzLp4PxeMtj8+Nct0OK9B3aBh+31LEijG?=
 =?us-ascii?Q?ZUJc6DaqiOwXms1ZdPaDAL1QbrIwcCYzSlHDPhyjYn1UDL2RghtAAj0Ra9TQ?=
 =?us-ascii?Q?hI403Ix81CnufnySb3+sNeUXqmrsfYaLn0PPSlVvF92RWnRPuTsb8OYq2z+R?=
 =?us-ascii?Q?vf5C0daP6aga2H/jvboFWQFVQ7grc/PexrkhANehljGhYZReIsxzKe/cHT4m?=
 =?us-ascii?Q?4+rzzzguXdAFsxQXH50MS2kefbxSNiKzv6vQjOFeNmXecJUcnEJC+FzOMUnB?=
 =?us-ascii?Q?vi+cCO+D1ZZ9nkLnIe4YGaILLnvlE8JfcQ7O5ksIxvblyKUjuAy5yrC44RY7?=
 =?us-ascii?Q?LFSyQ1DGNKckunlRghBECxHHvKTJgSQUV9h7SJVki50GT8YcsKiT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a3000e34-5967-40f5-ce62-08de8bb48b00
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:54:27.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ir1gaNaULyqb3ki4pUgHzWpnkULIqUdkLqUgJqs2ze4Zn4zV+5sD77hsngUJ4s4RgY311zOT+Qq3gx1XogHz9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7090

Implement the EPC aux-resource API for DesignWare endpoint controllers
with integrated eDMA.

Currently, only report an interrupt-emulation doorbell register
(PCI_EPC_AUX_DOORBELL_MMIO), including its Linux IRQ and the write data
needed to trigger the interrupt.

If the DMA controller MMIO window is already exposed via a
platform-owned fixed BAR subregion, also provide the BAR number and
offset so EPF drivers can reuse it without reprogramming the BAR.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v12:
  - Implement the new callback .count_aux_resources().
    dw_pcie_ep_get_aux_resources() is refined.

 .../pci/controller/dwc/pcie-designware-ep.c   | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 386bfb7b2bf6..b92bc37404c5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -817,6 +818,126 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static const struct pci_epc_bar_rsvd_region *
+dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
+				enum pci_epc_bar_rsvd_region_type type,
+				enum pci_barno *bar,
+				resource_size_t *bar_offset)
+{
+	const struct pci_epc_features *features;
+	const struct pci_epc_bar_desc *bar_desc;
+	const struct pci_epc_bar_rsvd_region *r;
+	int i, j;
+
+	if (!ep->ops->get_features)
+		return NULL;
+
+	features = ep->ops->get_features(ep);
+	if (!features)
+		return NULL;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		bar_desc = &features->bar[i];
+
+		if (!bar_desc->nr_rsvd_regions || !bar_desc->rsvd_regions)
+			continue;
+
+		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
+			r = &bar_desc->rsvd_regions[j];
+
+			if (r->type != type)
+				continue;
+
+			if (bar)
+				*bar = i;
+			if (bar_offset)
+				*bar_offset = r->offset;
+			return r;
+		}
+	}
+
+	return NULL;
+}
+
+static int
+dw_pcie_ep_count_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       int *num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+
+	*num_resources = 0;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	if (edma->db_offset == ~0)
+		return 0;
+
+	*num_resources = 1;
+	return 0;
+}
+
+static int
+dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			     struct pci_epc_aux_resource *resources,
+			     int num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	const struct pci_epc_bar_rsvd_region *rsvd;
+	struct dw_edma_chip *edma = &pci->edma;
+	enum pci_barno dma_ctrl_bar = NO_BAR;
+	resource_size_t db_offset = edma->db_offset;
+	resource_size_t dma_ctrl_bar_offset = 0;
+	resource_size_t dma_reg_size;
+	int count;
+	int ret;
+
+	ret = dw_pcie_ep_count_aux_resources(epc, func_no, vfunc_no, &count);
+	if (ret)
+		return ret;
+
+	if (num_resources < count)
+		return -ENOSPC;
+
+	if (!count)
+		return 0;
+
+	dma_reg_size = pci->edma_reg_size;
+
+	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
+					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+					       &dma_ctrl_bar,
+					       &dma_ctrl_bar_offset);
+	if (rsvd && rsvd->size < dma_reg_size)
+		dma_reg_size = rsvd->size;
+
+	/*
+	 * For interrupt-emulation doorbells, report a standalone resource
+	 * instead of bundling it into the DMA controller MMIO resource.
+	 */
+	if (range_end_overflows_t(resource_size_t, db_offset,
+				  sizeof(u32), dma_reg_size))
+		return -EINVAL;
+
+	resources[0] = (struct pci_epc_aux_resource) {
+		.type = PCI_EPC_AUX_DOORBELL_MMIO,
+		.phys_addr = pci->edma_reg_phys + db_offset,
+		.size = sizeof(u32),
+		.bar = dma_ctrl_bar,
+		.bar_offset = dma_ctrl_bar != NO_BAR ?
+				dma_ctrl_bar_offset + db_offset : 0,
+		.u.db_mmio = {
+			.irq = edma->db_irq,
+			.data = 0, /* write 0 to assert */
+		},
+	};
+
+	return 0;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -832,6 +953,8 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.count_aux_resources	= dw_pcie_ep_count_aux_resources,
+	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
 };
 
 /**
-- 
2.51.0

