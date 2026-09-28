Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021116.outbound.protection.outlook.com [40.107.74.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159D4F4D11;
	Mon, 28 Sep 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614401; cv=fail; b=MbKuxMxRWpMNIaE4bF+Z/M3jNprQXZ8HH3lS2borQgAUc6E3W6err8gw/6Omft0zo8b7WUvfaGtuyTQ38Z76tuIZxyoCsrgcrP729KgbNFIUnWct+pGwi+VzX7xx+9Kh8hKlCjrzVjp82WTVELTOueDDwzGS+R81R54iaHgwCjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614401; c=relaxed/simple;
	bh=TfB12STWm5cPBX7f8P1s9QAYu9vU9Esv5Qsl6MsgC5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZaEUAvtDtYeOfXeZ4y9sL0o2pOT+MdCfvJyiie92UfgQOoh6jDHZUvAkyWLEzW0qK5x1miG3WRmA/giK2EH7+bwrvnCfjPApEZlQ2CD5MfXLwABlZfC3Js1OjTYRGoWakqhMbsqh4KBxMNJ9rmg1tPAy3flNNtFttpNoGPsTFZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=d3FgK2qo; arc=fail smtp.client-ip=40.107.74.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="d3FgK2qo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+s8dpaVimmsg4iz2PfnswPe/sO+5Li++5rprd1xc3Dh2jFrEi3++SpvzoG9fh58FPKhd8T10xc8zODNKXcg5cGCmWSxuXNmqv+seQZ5CyBVDZY6naOODdzxiwiXcOHocDihBVlmoP3eyGsCtPhDZJh2VZPSqUcERTUIY7/sTcfxbUr2bHI5vcfqfQXwYNc1KDszmQ/OpUwGV/8I2CKLPK34/8ncEqhlbeETx5gzkpPiwcWDDX9jlzlkMnCCD54X8Chfg3vtqr1arkM0Iv+vNbN0K4DJEdtlrHSmSwcokyZREyCt6goZMvdHZ1K9U2/QC1W1rvWAh8MlgnBJ0OkVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VL+PhpQWX87zur9ckML7zBenetu4euqKz3Pmf2+qoo=;
 b=OrCQp3w1ZdH9k5SFWAyvQpGwIJXrNdmKQ02rEq7OzdDIx5BNZRwqBimIkjZlr//fP8rkHNJawpkW0paf14IsusN8mDwGMgIFoKWtkmuPjckvyhZwcTwPxxcYGfeGpGXbWvhP773/sgzADCtWuXDFCdiwP9VYtIe2cW5w4ox1QqFn7ERfUruW4u83DulOigTDdfBu1TlX+iNuPE9INHMdvKfO4/ZE/12c9SrpFLyyiOYo9VALBkSQWny4poEo9kbqheLPTggnt05e15axWpz7cZPF+4Sac9zy3wL/ziCZy+9EmCpg2Dhfe5PJR2wMqjDfkGu3V8nRhJQA0GuzSD5zRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VL+PhpQWX87zur9ckML7zBenetu4euqKz3Pmf2+qoo=;
 b=d3FgK2qoXGRzcI+B0YUW/Gvfo0erAg86DOLdSjzqDWeGh7Dntb4/Xlm4GzR7S1gjFOJueMaBJ9z3ck6yJOQ/xO4czZ2vuLm/xXGay+x/f5CUhmrw0b8P+CUC/GA6MUkDzbw3uSINSWPvxGgi1LMVZghEIB3PoZPOM9jW0QN95O0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:10 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: [PATCH v2 12/15] PCI: dwc: Let glue drivers hide the Root Port MSI capabilities
Date: Tue, 29 Sep 2026 01:52:27 +0900
Message-ID: <20260928165230.3397664-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 21168060-ed9b-4153-5838-08df1d80fa29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cHM9kUpJbzOVOPsIaKRL9SY+zWt+VEKP+WNAHZVsS9udnpcmpTtkMJLmQVDk3xqXK4f+mm4VJ7kRezG+/ag+XcUdUX5FfAl21NaLFmFb5SK2Ug7nJvyS8fRwsL1V/mNBbJkzJwDRgVhn3dPCSek7FM40Y7hRwh5dd8LuSF37cpuLOs+ju6B9rjcRr2skKCB8GIhaezj+NzIwMSIIy52uwSPrqEsQXowlKjJK16M7NmM0veMJaHKPU+C59JNzFym/3ijbAH6UNQvyQ61ttfqr5OT0zvR/aHgNGbF0zKlg1rgm8IsNcXBHtZWNgRNV+Ub1vmr0l4liidnu2X6FOQDa63ZJG7P/FeIGG/LUbCdDZYOz9BMwhf84/SlMyJ2dPaLMnoiYV/FcSOvfKRZtLziaBH4AGc+53yI31t8bP+QjtbvrZivuQW1uu1HB7tI2GzXYPBskAMhg0U3pB1ZuuhuiSjEnYvbowKHByqH82vq3Rj6E3uFVTI7lAulUzZFS0ci3QIdUMO/8wLXO4F8ufk3u8eX8BuZ7YNtdiOVaIU4JgwFN7Kn4xrcnomRA5Gi6tQEAiLZ2R6Hsy10F+7QfTkGCV+vBIjvOkKNtsZZcvK3mNBFiJbLGqfcT57yhiC+lJR86ndUW3sORyyvrD06znai7qHHQvJ0J0HMqr2v4v2ys1qlnmlvYNAut3T9/xdmIqJrQVC5nN+/4xvwgK9p3RckdGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UVRDEhy24M4ubuwsjm7vdCry3uqIlHuy+fKKFdoL9NsQ2SJ4LLacYQfrzIfK?=
 =?us-ascii?Q?UOaGlhNhUiswPjId00BnnYeIznvFLk3idjesx8fst+GwWQpVntObmm2QuLC+?=
 =?us-ascii?Q?QAWEmCg+VJy6xqaV+d3zGHFQy5xfwprySaHp0KX3Sq3poRdraryqwxE1kDjY?=
 =?us-ascii?Q?/srSF1YAPUXZzclgPbNWx/eH+ZKzx2+Do9dQlMdOEdn+nqmEmJbidu7CeAXt?=
 =?us-ascii?Q?lAzlVpBLkrMF4uoOtyR7Hv9tLe5ScjW9Eu1rupGsK1lQVQSqCnB1busudosn?=
 =?us-ascii?Q?8TIFR+r7Ew4xQZGU6xRgvId13jCP4/+NYcZPCbrzoe7A+2cY77vlVlWeAbn4?=
 =?us-ascii?Q?v/wlhpinDx7Gl+fiDCQyMymwsgSvvxKSjMn+SLG47y2vGI6AjRJWIe2+RPwJ?=
 =?us-ascii?Q?N108AMUJdeBFHZLDwGRyE9hjQyJJ3VZ7Ru9anlOuFiTXUlhZvbPfO6y5xw3U?=
 =?us-ascii?Q?E5NevW8J9Wxhd/dBk26oLd+TFntCBBH2/D1Xy1X8bNakmj3dmhJ8yaw/ezBd?=
 =?us-ascii?Q?QnxdXJjZHNbIxFsuwP/hPXgDanC4SZ7sMO3MNVZ8oE2pCRZ52OyupaJhYhfu?=
 =?us-ascii?Q?VZOaU+6EMaX5AS7NZO0VX0jJhhJfaAXv4GjCVadlIN2WggmkmL0RH3WOI+W1?=
 =?us-ascii?Q?yos0RzHK2f3vOYCtMLxTCeqJk4q+MTWNuntxyV3vA04s6IcBBMd/L9kN9i1O?=
 =?us-ascii?Q?JBEagT46zP+yIpvkl5Ez1qw+Hym+dJsaWYl/9N5ZLtFAvOyb5f0TB5L2e6Jq?=
 =?us-ascii?Q?VcvNOuiBP2v4Chffzj3GUqr+FqVvVnGc/iJewsWpveojf6wjhUxqvq4PynMV?=
 =?us-ascii?Q?TU75PbdJf5YSP25vBy6Ya+j0aw/qeQiuR5R03fWPzo6Li473pmFuloyMB6NY?=
 =?us-ascii?Q?cz6Oi1mI5HVJvefpZGHWFXOI7Swxj5qGZCwgIXGqAkINg6aiIKNiirsyh7Nm?=
 =?us-ascii?Q?lTK4SmRfDA3SDs0iQzsXoEfOT6HcjEqybkgal7BxiUEaFCgWyP51YoWwLrQH?=
 =?us-ascii?Q?mfjZM2Ey3Wui2q2A0rnQOHiULcDkXNajQP0GFz70KzjGQezM2yhzk7EM5tem?=
 =?us-ascii?Q?yAzLgtPBBzcDnERifsjvMizixOHENHKEJYAgnho00PhKwkwcRBALDmJ1NGQQ?=
 =?us-ascii?Q?mNfqB4YrRWitf1Pfq30HlMgjgMRTvf7qaeR9TlJj1MZik382pXNzBtbAGVG6?=
 =?us-ascii?Q?hZDJkNM1EnhLQ9WRgAH1/N8RIBoBUMm1WKhBvwLwpwl7spAIFv5MZnb5qC5M?=
 =?us-ascii?Q?oqHLD4fVRf+dfZCP9LbX9rf+ndX5rARzH2/mUSYjW5QNOvgj6WZ1dfJHjRi5?=
 =?us-ascii?Q?1NHSRGyMjssMte27W4jYY9Ko+DcK9I5j04Jbfka2cGuFxMRI7mWPYvqQMlwp?=
 =?us-ascii?Q?MHSVLTryE9iQCQ30s7vwqx7nnUaI+IFjFPppPUAq9JX1eIrSfej+RpqmEf6x?=
 =?us-ascii?Q?RopMmyvmOZNw3tC/oF5kYFaN5j4+24EBQjacqzJLMjdsbmxPQ/aRF7t3Aa4o?=
 =?us-ascii?Q?LZU2o87aWD3tZmHSTV3OSi4U6ZdEmStr68tqHsQ2yB2E18z0C2a92oP1h4A0?=
 =?us-ascii?Q?2BuVhe9Il9uWQkywB47E9a7ce8EuY0gwEGJq/zjiigqzmlFhYag1k6M3ABlk?=
 =?us-ascii?Q?VzvnPasxAqrr6GTZPqY8anNySGRsYQmMsPBZ+H1vwO6ssWVbMQd69bus1Ncq?=
 =?us-ascii?Q?h2lUEgdO5Q5oPjJKs5V8YQcJN9h67AnwlmQp86rtobZgUpK5LL3mnG9HiceE?=
 =?us-ascii?Q?v52R9V18UOR+bUHiR+Pk/oTPPwXaQswlZNDtchaatkzZPSpCFOGV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 21168060-ed9b-4153-5838-08df1d80fa29
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:10.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfR5yiMS54AqTsUq42ooSZ8W00f5tQgkygjtvJxVZffP9E3uSTOJ+XNdk2EHmS18AR3RiHrWbU/Zldm8H2QhVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
if iMSI-RX is used as MSI controller") hides the Root Port MSI/MSI-X
capabilities when iMSI-RX is the MSI controller, as it cannot receive
the Root Port's own MSIs.

Some platforms cannot deliver them with an external MSI controller
either. The DesignWare core signals Root Port interrupts (AER, PME,
bandwidth, hotplug) as sideband signals on its SII interface and only
turns them into MSI writes with the optional SII2MSI feature. Otherwise
it is up to the vendor wrapper. R-Car Gen4 (DWC 5.20a) appears to lack
SII2MSI, and its APP block merely latches the signals into status
registers wired to platform IRQs, so an MSI targeted at the GIC ITS is
never sent.

Add a no_rp_msi flag so glue drivers can request the same INTx fallback
regardless of the MSI controller in use. It is the counterpart of
'keep_rp_msi_en' from commit 3a4e8302e72f ("PCI: imx6: Keep Root Port
MSI capability with iMSI-RX to work around hardware bug"), which keeps
precedence: that one is needed for endpoint MSIs to work at all, whereas
hiding the capability only moves the Root Port services to INTx. The
removal stays in dw_pcie_setup_rc(), which also runs after a Root Port
reset.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 31e15666479b..5b2f249490a7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1176,9 +1176,11 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	 * The iMSI-RX module does not support receiving MSI or MSI-X generated
 	 * by the Root Port. If iMSI-RX is used as the MSI controller, remove
 	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
-	 * to fall back to INTx instead.
+	 * to fall back to INTx instead. Glue drivers set no_rp_msi when the
+	 * platform never delivers the Root Port's own MSIs, whatever the MSI
+	 * controller in use.
 	 */
-	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
+	if ((pp->use_imsi_rx || pp->no_rp_msi) && !pp->keep_rp_msi_en) {
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a53ac27cd244..cf1b912bb396 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -444,6 +444,7 @@ struct dw_pcie_host_ops {
 struct dw_pcie_rp {
 	bool			use_imsi_rx:1;
 	bool			keep_rp_msi_en:1;
+	bool			no_rp_msi:1;
 	bool			cfg0_io_shared:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
-- 
2.51.0

