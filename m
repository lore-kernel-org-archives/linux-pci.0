Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022089.outbound.protection.outlook.com [52.101.43.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132A3BCD3A;
	Tue, 13 Oct 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901385; cv=fail; b=NFVlh0nbrNJXgVL6AdsYttFqqbCzf9TyKhoS7dIrtT34dY2sAS28SO4/Pes1WeOL3HhR8OGsoPoKr69q8YRodasfwo7Xtm1uEz0bwv+u9AMpN2ZZA7s9VPo4zxZpmk6YinUW+GAwz7sgrYXu0Djv6It/B2Y8MJWwpeDqnpMrZV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901385; c=relaxed/simple;
	bh=sh28ALTecZ3S/aBgxrbTcv1nyRbZPbTEj1D1AFV1/Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Te5xH9aJDktHoU3uEferlAzL6nTPV1Bm6C9mlqnvNmbPbB57pO3yBUZ3eEl04qYhVvCX06vnTP27mbpe9hGZfuQx0+c+LPYNnI14i67BJTiYyvc9Qa1DVUrZgAUoHIw7K49d6bJeTwLKVQ3kPn6dW0hRn/5OtFDYUi3xNlLVzs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net; spf=pass smtp.mailfrom=trailworks.io; dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b=NHzuFsk3; arc=fail smtp.client-ip=52.101.43.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailworks.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b="NHzuFsk3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEswWi2Go9mrHTX7klS6dm0VocO9728H6tdZ7lxk9VndIlMg8/JqmIwTIzNobKg55B2o5IaG6SXRlNAHTs/YDUTWDs7EH4wVQdhJVikLiLmfydjkRynq+tU67EjqPU6Mjx11gsOOeoQM+aBXkhZQ1t0qNK65oGrzMwvmIM0AmEzkfdFvXlZJz/sii4tTmXCT2pYDt3EfNQPhQ2AseG8hSDlOVUXP1DTeZlZ1I4vTVKl43p4+Lm1vTSLacoXdAAMcVL8EF6yOx5gD1NuL638eNLnn1/h5MuUUd49kAqKB3lqvY3+G1zaocdGZQAeC6HG14+ZgcDiWNe2wOftR5p/wkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thg9fG52rM50NDtUu7xWYdpMHnTNV/btZXKejMSXb0E=;
 b=BEXkbja9BDa8G0hRGs0imKMENblZ3+ZQrkDL8SGSRAzZLc6NG0e3WsYkjdiP/SKTclOX/e8mwmXjFA+DNDuHYhueU7fXGfW1mVrfNuX4T++3/eeADTKunv4saqZGkzr2SqBaMvxVYj+fgmKrvQCyMnc4nLcFz3dJoNkhAxkBxwcbpMIoK/KC6iU8uIwZd88HRXeF91nSw/NtxpZRmpTmmBRbv6RJQzABHotXShZzhamSrjs6m0REto1o1kQ6u9e2wtHCNK2DDLD8YTB0M7snCHktl/E75feSZ+Ml+WlT5rMxyqXhSVGGFmEqwNYx2Ej4ffYZVTOwxSLS5+4AOvQKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trailworks.io; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thg9fG52rM50NDtUu7xWYdpMHnTNV/btZXKejMSXb0E=;
 b=NHzuFsk3EeCfZdyjMr+aUL37blB0tUn+dWqkXEJRO6wNJu+oqA4ciHduX0Kx/qy9BNQsJPsIQC8rMCcqiCDF6/PV7emlaqpAQ9ZTNHimb9Y7lqj7Iak3KqM2UFL9KBv5U36EK4dqrQjzu/R6H5r/WavaMOBMp5+JAaBH/HznlGlh0G7heTQzVwZdnnCTumIRE587PJFSz1J21qlipJgu3Lnoqdgtw482YwY/D4lE0RxG7VWMjvMauTahfWrtHygavbojFFQ8yxSC2utJMed1fhZLIVJyGEUYkl/9Ms8bEgkbuwQG9DvnvA+n7+uWmsBxb3QY1I24ZjEw1uRlE09lGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
Received: from PH7PR01MB8123.prod.exchangelabs.com (2603:10b6:510:2a4::19) by
 DS6PR01MB277206.prod.exchangelabs.com (2603:10b6:8:469::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 14:23:01 +0000
Received: from PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930]) by PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930%5]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 14:23:01 +0000
From: Michael Burch <me@michaelburch.net>
To: Vinod Koul <vkoul@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [PATCH] Revert "phy: qcom: qmp-pcie: Skip PHY reset if already up"
Date: Tue, 13 Oct 2026 09:22:49 -0500
Message-ID: <20261013-qmp-pcie-skip-reset-revert-v1@michaelburch.net>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:6e::11) To PH7PR01MB8123.prod.exchangelabs.com
 (2603:10b6:510:2a4::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8123:EE_|DS6PR01MB277206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0825bcaf-20bb-403c-faed-08df29357c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|18002099003|10067099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fZyGF3dm1UdAhY62QN31ZgehEiq1JvvMXnY34Rj2Hd0g1x7OtaBlDg9VTLBIWm0PVa23mR/lfdJY2hiEj3gQYcVJta+XPtTQ2Z+0IoZ2hD5NujUAXrudxABkk8fdCD/FyScufwM6bua6UYVuk99UBw3MplHW1ePMVOr8PlFVzS7sYt8vm8PEFz1boXmm4DM8hHrmkhaFrSeilZGzOdKQgmSJRBX1nIGVlRHmfcNYdk+KB/gScrZqMdL/pCRvZ2QZskAlVi5lbJ2x2kd1luTNtBtMT1XU+z4R6nQVomP/84fz4pEdXf1tBX06XqSCdJwY+xUEHTng+kCtP82cMfAxoHYNCNlrFdinIaA8zQkeuPn8Ze/6Ncl7MA4mpKTEFNgBsTbRbSHZTHbyjLrHS/bkw3h/TFZZPJfNwXSaSAsecbnPlQdmd0IGRtmy6KUWHqgZApbFS2EN+EeGXOPdQdrz29BvV38x/TeHagGQAPZp3Z/guxegphyfqblL4iMfMgKCa+duXYnb0qIQSbZlUPjFaE2HlJufd9CCM7e0DpcQUaJ9y1D6sc82lDJaSOQsaGmkfODvIjFENHpSbfP0Z77XWt0nxfPDKGEye8F1V9Flkqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8123.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(10067099003)(3023799007)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0KPQsCPe62vfHVH56ZZLxdNyUWaCPlhkHGx6696wGmbu4T+B2zj+aDJJCFUA?=
 =?us-ascii?Q?fnP/e0YSNKcDOd/keJ0BzUunlObFCDdQFWhm60N1vrz4h2h8UDP9q/lmz9gq?=
 =?us-ascii?Q?stGzR96C9+SXmT4miqp67B4VZNhw4toZnb2dtpV1cKAuYukOzFr7UFgom7Pz?=
 =?us-ascii?Q?cRlUs99WJCtBQWmDTGWVq9EyoYnQgWipxjGvq7ATnhhiPFxlCkGEpIZF1LDr?=
 =?us-ascii?Q?3mQB6fInRnMrAxwfLLpfNOYh2oOCti0glBQGpiZ3IrAp1CUjSchoEC/arhXV?=
 =?us-ascii?Q?boTGoWCtl2rkOWNVKcjMwd+OQxn1M86xwNKyEfhIQuBuvw6Iv6J3fjRJJi5E?=
 =?us-ascii?Q?/lSBUmAjXEpgoBMpFEafQ0JZGtlj8tsWnMgESh9S/W1lzEwAt1sZOndiSxto?=
 =?us-ascii?Q?mi7KMXyTnJa1yR5gZ7YhMyjbTkPv1MVUVGsjA9jJF+34W9nedMKKOYIeXMJJ?=
 =?us-ascii?Q?VjjzhoBAe0YDCx9NAAOFGLf1Ow+49hhcy6qDFMXnClPGERNjUYBmI++xCZiM?=
 =?us-ascii?Q?+4zJRRmCLadxrctgYLJT7sSZ7J6ulp05UGuZncWEoqXubYSHGq+8Cmbx8MDO?=
 =?us-ascii?Q?aXXJPH/RGQviEmWKhbWnn6zT850CTpYTW8yjg4sjO/rcKRNjoQ4JGTPgly8Z?=
 =?us-ascii?Q?wG6pj0HiFR3mHwZEDGAKH6FTtXlm1TL/gs/PMoHcVfzbvOKw/DdpM17aqHl/?=
 =?us-ascii?Q?nA1rCD3+bj9Ydk1tYJMDRrpevXNkQ/32oE+mXORxp8PPAPxgYwZGts/oclzi?=
 =?us-ascii?Q?XLIh6SC5yBglquOYLbKvpzhyNg9unVYa1rr22nhVk+eabzbheXwOgw6rLRDa?=
 =?us-ascii?Q?Rt3tUgE3OBFSCC5QzH+wl1ptOBHxR3D6U6+EhazvelgH6V9Dw4Ar6A3ZKiOA?=
 =?us-ascii?Q?HQWgOr5uAAYxIqURDtOv1bhVf7EnVU3ODupeRPXW/zQ/D4ijeCPs0AVCMkFE?=
 =?us-ascii?Q?fUdSh2tH9OYh3eYrtgn9Ha02L4rkC+pHMNQ1qHmNV/go09EpEWUKGctj6UiH?=
 =?us-ascii?Q?G0fQl+OtWdXlJcil5UfuBS+qaWXQqCMFTs3u7RzaqK+C8cTOaCwIc4kSjsG5?=
 =?us-ascii?Q?WhQYNkfqXT1meLRJed7BKoNRSkEO/kcXTyfk6Y/M8NVKaKzb83QUff6svf7q?=
 =?us-ascii?Q?1Px6sqzP6s4Gs+Cqq7jj9kFZ8r7247wuYZGqXnf+Y3NiZyn0VZJVrY14vL3o?=
 =?us-ascii?Q?hBEwkdOG4inYptvlvziMkGKnh7tMCUCYDQYGS8GIpoIjSl8yQGzAODzLd2Mt?=
 =?us-ascii?Q?bLwnOfmnBv9osetn6w2Lni1IuMGZ5yBM0+qPu3Idy0QEqxfo6LoOrYMwfdYR?=
 =?us-ascii?Q?S7uUlyYvczTRDfsVRobCy3x6BNdHwgycsJMx9du2xsO5g2QEqDI256Dw683n?=
 =?us-ascii?Q?2DSzANVKzp5T72b5PwL7NgOVh7aareE597GXP5jkFLoPpfY0KycgTV49/bUR?=
 =?us-ascii?Q?/mpuFfkpAKeZ3PmB1QpWNIfOamWV/9Lk3jG0+4VqP+2gGwzkutj6pCFyhsFg?=
 =?us-ascii?Q?g5KZr8wRM2C0RGvQ4EW669uFE42n7acOfsaVi7vUYNVEwPC5RrJbR/Z5mFfW?=
 =?us-ascii?Q?dK/P2t7CHydxsMRxZExNNI3mi3KRE1+3IEDc4UhW9Kl5wFTqhUxOGLSfV5cs?=
 =?us-ascii?Q?10KtBU9b1DFA3D82iPjtMrE6m+7IbH8D0YwwgAjgunw76e6VJlOssjhV+cJo?=
 =?us-ascii?Q?YWyurgoQe11oiCDC7Tey6+e4/Bhc/R6Mf37MisOqVTupf0nUAcHKeVRuruPy?=
 =?us-ascii?Q?+7p7G3VVGQ=3D=3D?=
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0825bcaf-20bb-403c-faed-08df29357c73
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8123.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:23:00.9776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zC8x7zI8C5vGvT1we68MoMMyX0NF3sz5IibtJ0NHQM5hlbDk4+C/MviHMax8/wbNPt5SnP1OH6E5kLwEKhh3fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR01MB277206

This reverts commit 910b828b22b7b91054b3bd4be676a017444b0e00.

That commit skips the no-csr reset assert/deassert (and the 200-300us
settle) whenever the bootloader already brought the PCIe QMP PHY up:

  skip_reset = qmp->skip_init &&
               !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
                               cfg->phy_status);

and states its own assumption explicitly: "This relies on the assumption
that when skip_init is enabled and the PHY is reported as up, the
bootloader has already configured the PHY correctly and the link is in a
usable state."

That assumption does not hold on the Dell XPS 13 9345 (X1E80100).  UEFI
boots from the NVMe behind pcie6a, so the PHY is always already started
when Linux takes over, skip_init is true, and the reset is skipped.  The
link then never retrains and the root port comes up with no endpoint:

  qcom-pcie 1bf8000.pcie: Device found, but not active
  pci 0006:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
  (no 0006:01:00.0, no nvme at all)

"Device found, but not active" is dw_pcie_wait_for_link() reporting LTSSM
stuck in POLL.Active/POLL.Compliance -- receiver detected, training never
completes -- so the machine cannot find its root filesystem and drops to
a dracut emergency shell.  v7.2 is unaffected because it always performed
the reset.

The commit was applied on its own as patch 1/4 of "PCI: qcom: Add link
retention support"; 2/4-4/4 have not landed. Without them,
qcom_pcie_host_init() still asserts PERST# and resets the controller
before qcom_pcie_phy_power_on(), so the link is down while
QPHY_PCS_STATUS still reports the bootloader's state, and the skip's
precondition never holds. Revert it until the rest of the series lands.

Fixes: 910b828b22b7 ("phy: qcom: qmp-pcie: Skip PHY reset if already up")
Signed-off-by: Michael Burch <me@michaelburch.net>
---
Reproduced today with Fedora's stock 7.3.0-0.rc7.58 kernel: the NVMe
never enumerates and boot stops in dracut. It was first seen here on
the stock 7.3.0-0.rc2 kernel. Every 7.3 build I have made with this
revert finds the NVMe (Gen4 x4 link up); the latest are v7.3-rc6 based.
Applying 2/4-4/4 of the original series on top of -rc2 also boots, but
only with clk_ignore_unused here. This applies to v7.3-rc7 and to
linux-phy fixes.

Qiang Yu's "PCI: qcom: Align PHY init sequence with HPG" carries the
same skip into the new phy_ops::reset. I'm replying there separately.

#regzbot introduced: 910b828b22b7

 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 31 ++++++++----------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index da83358c97ea..17c53ae62fac 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -5677,7 +5677,6 @@ static int qmp_pcie_init(struct phy *phy)
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *pcs = qmp->pcs;
-	bool skip_reset;
 	int ret;
 
 	/*
@@ -5693,9 +5692,6 @@ static int qmp_pcie_init(struct phy *phy)
 		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
 		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
 
-	skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
-							    cfg->phy_status);
-
 	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
 		dev_err(qmp->dev, "Init sequence not available\n");
 		return -ENODATA;
@@ -5719,16 +5715,14 @@ static int qmp_pcie_init(struct phy *phy)
 		}
 	}
 
-	if (!skip_reset) {
-		ret = reset_control_assert(qmp->nocsr_reset);
-		if (ret) {
-			dev_err(qmp->dev, "no-csr reset assert failed\n");
-			goto err_assert_reset;
-		}
-
-		usleep_range(200, 300);
+	ret = reset_control_assert(qmp->nocsr_reset);
+	if (ret) {
+		dev_err(qmp->dev, "no-csr reset assert failed\n");
+		goto err_assert_reset;
 	}
 
+	usleep_range(200, 300);
+
 	if (!qmp->skip_init) {
 		ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
 		if (ret) {
@@ -5777,11 +5771,8 @@ static int qmp_pcie_power_on(struct phy *phy)
 	void __iomem *pcs = qmp->pcs;
 	void __iomem *status;
 	unsigned int mask, val;
-	bool skip_reset;
 	int ret;
 
-	skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
-							    cfg->phy_status);
 	/*
 	 * Write CSR register for PHY that doesn't support no_csr reset or has not
 	 * been initialized.
@@ -5805,12 +5796,10 @@ static int qmp_pcie_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	if (!skip_reset) {
-		ret = reset_control_deassert(qmp->nocsr_reset);
-		if (ret) {
-			dev_err(qmp->dev, "no-csr reset deassert failed\n");
-			goto err_disable_pipe_clk;
-		}
+	ret = reset_control_deassert(qmp->nocsr_reset);
+	if (ret) {
+		dev_err(qmp->dev, "no-csr reset deassert failed\n");
+		goto err_disable_pipe_clk;
 	}
 
 	if (qmp->skip_init)

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.56.0

