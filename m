Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020139.outbound.protection.outlook.com [52.101.229.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B13BB114;
	Tue,  6 Oct 2026 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276415; cv=fail; b=OE0tcvSi8dw/s/seTgjlSDiq8OIySRbJvJ3ZFMPeC8OhN7ugCEQarm62mQ04C3y41wp31AsCk8ls0oPu12iZ6f0p0M/FT/Iu8jW8SkB6Hp0+e8fQN/RLbtwJEETZOK0YBvVhrqWZvzg1/Qs++NDDMvAZHb354TjvPK8laifkU0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276415; c=relaxed/simple;
	bh=Wf0DHPJwckpmpDw2cR9MwuDLXaAkP7qOTdZb5iVo2ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mw4QjjrmMYzICUgvOpJii0Ee4SLN9Itj6o+wgpqd5ZAgcML+5FyqXvoCFuBKo8e8wpLtXp3k3tRQOoDdy32+4WiDGE0sxVrVxOXGSWfK6AXECRbLV35+Pct+/ZkVCpmuN+0f8lPiKGoutSc01A7JOC1LSL1SbWZ+Z6g9/dc+96k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SzIm7dBn; arc=fail smtp.client-ip=52.101.229.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SzIm7dBn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FX9oFZ4UVO9nVbFwl1f7kSFMxZa8/oB1IzoiIq2nbfh0XPtogwFdFnHgoCGhF0jcN1LpUQ7O1NcisAT84l2c7/L+xxxJgfq9irLS4uXFgd0M+A8j9wx06XRx27qelb8DXYRoyATAMX5YjqEp5PSF38/e9HTh1FeHTOZf36oK2ghKHK41yQgeF7eLUg6nV9emQNDWP1KfY641A/9l6ZhVwynBJmI3UdVZ3RpkXeLPNqRCwSC+xoot07pMziHvdm0NsDWsbhdS5aM+E+XOv0G4NKj2lsopw7YUuttk86j7ezCPEwyQuPNUyLiwy64zVVFnII2WkXm9sB5K+aL6jwASaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1s9b2dALj0FbFPCe6WyllQKnoFoBM1C5zS4ALzgxtk=;
 b=IA/mov2P2JeY6vUg1bWnXdUV+KDo3iJ39rYOvAeNl9vC4uGkPL5C3sU1UYTOKCopZr4/lMHhFyIrYDyXQLjQHEJno1IoqscySeemAw927gDMpuzGI5lK38xZB7lJsZTQfiCvG25M7v4p5ydIY+ZQRGY4wgOKhs9Ic1p+g3JhE9N+M6Bt6uBtvdquSgug6Sm/8roVE7SbqkgIr7fPEi3WTUZBw2tPwe+xEU9UNHFUNzn5BwiGLrYKlxqPCf5BT6MgkZ48UlEfs5yC06vcTAVnl1wDp3Am7RhZUfm6zGzhN4RlXgl5x9k1ak1mZ7OF6WmpX3vKVDd0RBDPKbzBPfme1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1s9b2dALj0FbFPCe6WyllQKnoFoBM1C5zS4ALzgxtk=;
 b=SzIm7dBnnBEFj/UAHKMHZuQn8Ew4T59h8/TaTVRErsSOA1YuEYeWLechnhQW5jnUF3bFlxcpmFnG/G3iB6Xqq+YnJwCwTp4KyWaU1q9nLsBjV0+8DIT0vScWlfabOgTQxZsHFt/lyvMfrryP54NnTRKcsH72YgqkbHqhoeV0CZ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:47 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:47 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/18] PCI: dwc: Factor out the PORT_LINK_DEBUG1 link-up check
Date: Tue,  6 Oct 2026 17:46:22 +0900
Message-ID: <20261006084638.3821710-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 33095d3a-ac42-4333-8916-08df23865af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b6ZsJmJdMxLlS389WKdL4FRE1Eyu7ZX9+45p1Q0BqwlXgqcI4eBP7MZrYOqOLz6jgigjtpw1DxwLCSamb7E58hvE23H6l/c5gd2FpRSpPMx3jRTzg5vUHfkXgxQnsYEhVBK3dWDgfVrhw9qePCfIb+5vVDnVsKAWgq5ylZn/xcYhlcDbUtmGsM9aR7I3QrHwLAxIKdMRwVJm4d+mgC91yVJ0W2N2ctPsMDvA8jJgj5LjQnTSLz2rDuVzHeXkcNdjq+dUG74hgvUSjc469e5I+XoAlEfSd2CqG3pyFqxuNJ+nT0WRNS7nNmVqEPgHiUnGAyYMcU+OexY7WZXn9jiWXo707F/zXfcetXUUIobvviPid6hlhSM8UyhZclKLPwGZa42EV74paxb5BkX6KuNJ+WkhxqSIhhL9as/Rmx06mn4a1wq6woblEzuNgdRVBGx2wiWSFBJcET6jUOEc/SaoOx2UFKv5CtYQCyw8zmjxAH0FBHGqKyYVzHRCgDB42T7vw9IWIaGXuJE4/VNwNE5dJc84u4/7H1XKCsyGjemsUPTkfv0Pq/ptl3rUUTWhEh2rWCSD4ehLdzW0g5Yxf00d62Ksy9wiOmUtQ1EoUYlJR/yY3a4/PxYOcSHEj9zj4tuG7pNJfKPrWznz6J0UYd58/A2L5oddSmn4WJCCo2fsiu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXPmSuww5YBjS0eyzwBlSncTAO0f0b/e3mXOZtUYBZJylhGuMhckmiRmN75F?=
 =?us-ascii?Q?5IkIdaPWqPfE707CkKjYXvl0AB5aSFOtb3oDUVhgtzAJTXtnLLgWRpmA7mty?=
 =?us-ascii?Q?20/ngi9RXKp8aWPYeWApa0aAx13YAYUn5wVpY8C99RT6RNyWLl+sWl2xW+Ii?=
 =?us-ascii?Q?3AC4gRgBkTOQF/iNQQe02wcusBUl/c+MxE3X9TEmtRNiiwLl0Bm88oqYw1D0?=
 =?us-ascii?Q?Zz8cGbr9uqwxdozmr7XJ7HytsGNLSLm4b2bkb+iw8rz7x7TKLXmJD8W9EK/8?=
 =?us-ascii?Q?QTeK2tGwD4JKdj7rZncp1mcxqE4yuJoav2bNPpKm+sscfdjLIIsxv9nO6HS9?=
 =?us-ascii?Q?bVJHPHDDBlT+VnIofVsO6XIFLPf3l2TyMlLbwYQ9YFRNct9PMjU8n3Sh/NMr?=
 =?us-ascii?Q?IunNkak/2S0rXhtdRb+/JH3JCV/jUMCxzWCVW9Pbqp7RxMdJL4gPHWkRu5DW?=
 =?us-ascii?Q?VHWa4/YXRYIxXAjWJuTJfBTC137PYsfHqK4RzA6EN/QdYwZs7q4HQkHeKyQZ?=
 =?us-ascii?Q?mGE1vuUovHDxqGmUOXSTUPp3SQ05yz73qmAe7tLxu+853z0g6F/kHTq5pIHB?=
 =?us-ascii?Q?IrnfwMx1SKTZb5YpohqSQB5/w8R/qOVcPEwBTkTPb9+EDcd9OHjsPAmDf11I?=
 =?us-ascii?Q?ljO4ieAekNU6bJu8w59yHrMsdKPvafWY81YEus77ZnB5X6HjXd1Y/tMURYJC?=
 =?us-ascii?Q?rWoh7xGLhNqje8rJL3wIi1gvhsJahjkoYXD0RFto+ieAbnRoWQAxnH+puypF?=
 =?us-ascii?Q?UI+oB5ilPoq3lxGJ6YULfJuaxtE5LP337jaB7L4nzf5NMrWK7JsSBXclaXR+?=
 =?us-ascii?Q?zlFqjOtIiD94t4x2+vLSIggLqR8DFPu70OEML2o8T4DNSBQ9HSoA8a5hRNJ3?=
 =?us-ascii?Q?4RCFC15LRNK+4vMZh7Git+grAxTJB1qi8F+bUpXG4dgurFLA5N9WzZX+Aard?=
 =?us-ascii?Q?YuNdikiWGgCjnXi2V3ATPh2qaIVZ7/oJVMvWwc1t3ZD6k4vue5QxRyaUHMpx?=
 =?us-ascii?Q?w8/XdK0rGvSD3FjcXdtt8VWB08f7VIDCTaq37aVqXs0Oh6OplpKJp4rSde9/?=
 =?us-ascii?Q?Gx0MecRIemGeOhmfwXQ8xPPz+J0blrC9fLb3pblULpdydT9S03WIoWYvEmYS?=
 =?us-ascii?Q?HwcuWIBxn8xS8ccO9h2mzrhvpLc9Yoy6vb9TlA1CizxXtkj4ieeirPYO2JPb?=
 =?us-ascii?Q?34DLKJIOswtEe12vEQv7XUev7S/4MjNK3f5nEt35TtcJKie36uh9607NIZ3w?=
 =?us-ascii?Q?sRbicCRcNBiG3T2rVUEpIUZxxno1LfhXJWLuwudRweFzOuenrKL7PVyvbpTY?=
 =?us-ascii?Q?93w78uQ3L/PY8wnf6zz85J996ZYiTk6qK2h2CvM/wOJNJzZKmpLgWWauqZh4?=
 =?us-ascii?Q?VjHWLIKkTLlUmULqax4HRd7ogVWC8L/i7OyuM7zSATLBEa1hdDau2O2NeScj?=
 =?us-ascii?Q?0VtFzwsl/vzh3buGaeg239OMuqlqWC8T83DSzR59lVUqz9pp9+39JoIz38Wi?=
 =?us-ascii?Q?BHJqxWR7AHY0lgKEHFhuT4HGFfy4HOzaxtIu2DfXU6oCEqKyoZb9Dj3cPSLw?=
 =?us-ascii?Q?Mw8J8Ij3x73IC15mdJuKawq1Pc/TPxfSM2Xi7bp10iMbfX1NugHi90z0hHnR?=
 =?us-ascii?Q?vsAIdsuE2oGQ+OoRxezXetzwDNSIkCdfDKMFJBIcc9VUoXAum5oJ5Iwg39wR?=
 =?us-ascii?Q?Gvh9KgNwQsJmjnb2bsmbEg1EmCt5aCKnazsWZdXjbXto0TxhXZCzBGakSBoz?=
 =?us-ascii?Q?Gzvk4AfGEwRNKT9K2FyswbzTkIoRF3+t0ACBbNCcJ0cpU3gauLe2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 33095d3a-ac42-4333-8916-08df23865af9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:47.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0g2EAzjA7kfSiSoIoe/dan5qaBx9YAJBVCtNJO6BENNEUO3Rzb8spGB6W79Rfz1tSJE4/e/J0mXwYBxL+MIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

dw_pcie_link_up() reads PORT_LINK_DEBUG1 when the glue driver provides
no .link_up() callback. A callback that needs a platform-specific check
on top of that register would have to duplicate the register read.

Factor the check out into dw_pcie_link_up_debug_check() and export it
for modular glue drivers. pcie-rcar-gen4 will be the first user: its APP
link-up events remain latched after the link goes down, so it has to
combine them with the live PORT_LINK_DEBUG1 state.

No functional change.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch, suggested by Marek in the v2 review of patch 2.
    https://lore.kernel.org/r/c038dbd9-7675-43a9-834c-915b6795dd50@mailbox.org/

 drivers/pci/controller/dwc/pcie-designware.c | 15 +++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c726aa71c830..49a9ba910ba8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -817,17 +817,24 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);
 
-bool dw_pcie_link_up(struct dw_pcie *pci)
+/* Link state from PORT_LINK_DEBUG1: up and not in training */
+bool dw_pcie_link_up_debug_check(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->ops && pci->ops->link_up)
-		return pci->ops->link_up(pci);
-
 	val = dw_pcie_readl_dbi(pci, PORT_LINK_DEBUG1);
 	return ((val & PORT_LINK_DEBUG1_LINK_UP) &&
 		(!(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING)));
 }
+EXPORT_SYMBOL_GPL(dw_pcie_link_up_debug_check);
+
+bool dw_pcie_link_up(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->link_up)
+		return pci->ops->link_up(pci);
+
+	return dw_pcie_link_up_debug_check(pci);
+}
 EXPORT_SYMBOL_GPL(dw_pcie_link_up);
 
 void dw_pcie_upconfig_setup(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 419932488280..2ce61709b58c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -618,6 +618,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val);
 u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
 void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
+bool dw_pcie_link_up_debug_check(struct dw_pcie *pci);
 bool dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-- 
2.51.0

