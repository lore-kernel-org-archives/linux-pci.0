Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4A138398D;
	Tue,  9 Jun 2026 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976204; cv=fail; b=rbk7zzva1s0cA62pol+HyhLCoYv6hHgtbrlZntX0BcY5NlZlP0PTwE0JCyq1J5bY5CWPwBLUl5sPXgogHI1XtlRT/2ffX20Ru4UEJgI0epmkUBrM7FgLUsNnEypt/6OcCQSuIkxfqgO6Tj0ZcOg/XfM9s1aatuDv6Judo5+Fnmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976204; c=relaxed/simple;
	bh=Foo/RjE8Sm792E5vZKaAses/gsRhbtA4cmbjYmH16Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iNX6Yi13tjQf9rNBR03yx8WJPAMTJJO604UctF1b1crUJLys+sCN0agHJP3Mu5ozhvzOpDlaMPNlMwyivbjz+p6xCkw+ACiGLow5JBxPhivI0xAcPKq47A8z0wAI6qj1fot4uJQPK/FAZ+UcdIqOJKt0szkuV1PRcJRPX1g66Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j8+z7+Lr; arc=fail smtp.client-ip=40.107.159.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j8+z7+Lr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uus0hW1CnBGgks52eO11poPV8aYlfc7mCHhp6uQKgbl9xz4DEwCN1R/66Cb1TcVbIIpPnr1495gT1exthsinVejWK1nYgUq0muRkaTCCboOxf3LCox032rXElVDnyQLNnkK9cptxMvG8reHSz7dAAwp350D9je6+d023prtIKrEOelk6O02RPYHxfkHCqYvmesunJSwqLtfOqwyKneB2Z/MaDFJjuIq5uBi7Wx5Tg7p1i+NIh8bgyEe+cxTqgoUM0nm5nynl/LfOIs5peTsU3uLGAVLLKH2ieFNdlxc8THDZc6apYHMK+Y3JgS3qTupeGhzazeyrxME8WlsPT51KZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amICq3P4p2drEBsmR6uRKzmSPAkSDLnpgpj2tnjoe34=;
 b=FtoB+VjphXjHp9+drEjEdZw61R0io2o/Uu/mbqEfSowFwEbalSR12Bt7IDbfESFJ3rW4Mr2Yt0/AA4gHUzJ2RqwrR6uuo4nQiyTMHSrk0w4EwUS6W07cACmagCpzNA03mJtbuSAbKsHy680GyS9ewxnPABoW4zSpZ9sjNGps6m36Or7UtujARWgIsQ3eoWnlMIvh8qVpXiPBm/pO/fEBbagDP5PThQS+g/l6tzexbFVVg53A+WO54uX70x7/ciuf7tZVZb7QdrhYlB605qWjSDOkMR3UrnmYU9bPlAZIQlowVZlenC/yAEvScrf/pm9zRcRdJBk0SXwxUBNZzoCLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amICq3P4p2drEBsmR6uRKzmSPAkSDLnpgpj2tnjoe34=;
 b=j8+z7+Lrd+vx3PnED8+iX063G4Dbe0/byG4KbFJ6dyGz1dCcaNqQcBji4JHR8XetHv3Tmkm7gCklTpBGmngluKo+gHDpkoy6VG72VJhdBjtgIcKsfefJdLoSHaWR/ezxRt+eGevTHh8z0BEYx7ZsM3XY4617cZ7v4iwKVG+3ZvG5JM9rzGV5wZyJ3GlkgDdFcrLy1oFLYxf3r9r6Fx8+MfaIYdqYdLuozn1hM7C7xIsb3mdFHqDgnC291MVDxkm5hVX6tijjqEjhE+XcAwkGozea8QlcPKwmzBoWdI1dH/tUUcLjhLbgxiVFoicFmRkdhGThLWsl2XHpJUCDD5uI2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 03:36:38 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:36:38 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	brgl@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	Frank.Li@nxp.com,
	hongxing.zhu@nxp.com
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH 2/2] power: sequencing: pcie-m2: Add 3.3Vaux supply support
Date: Tue,  9 Jun 2026 11:38:39 +0800
Message-ID: <20260609033840.2006078-3-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260609033840.2006078-1-sherry.sun@oss.nxp.com>
References: <20260609033840.2006078-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0080.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::7) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e510684-9d66-4539-0eff-08dec5d85006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	h7hTLWsLMWtAF6t74IkOvvtfNgTt78pMlCFWIGTKuqQM5XQvrZKTQfca7GifTwYPi2RvkNcuZMu9gl/OI25wzy2940lKvX9H3JqoXJEzI6AH6rhOH/nC2EmSc+EWslGZJ4h2rsDfFf8HC1bjWQ34mXvz3XLAoNokFWx0NjKxFahVAE9vhnWHsfniNneqIKc5zLlLx0+tEidvGK+JSbNiRbO9GMOP4Yv97mDWa2BbJWzaLPOEjRq+27DrgOTGnwdhH+TpVN0eow/tWVnqFM1z5rS3jdyWV7uWmW5A7dZFWZ/EiLeMjwgcnSmkGx7ydKFtCkfhv4xL/SuYLDCtKWIQ9K+NlL6PTM/EkyEcergLHc4KP047Uz3o3F9f2+AssJwQ3MNJ7KDQAUcjopULYkhTTE2EWJ6E0nJ840/vdznMUKsc70HPADF4POzmb1PyXXLeVEZnp4OCLdp1nToymLZhzoK/ljo4xjeRR+Rp5cF8hBHw1ZUpYXPcUDfUnqiBOvlVjmAqxsNK04x3WlDcjtUHlAP+FglTQKpz8qOf8+RMkIFTEE/0PnjQSvxdDV8MV96NJ5YH7r6D6//tlCVpxeYQ99DgYtFBpsoDqtShAs68xSsBDVA8p5zQkT2WHDi9w57DkizLRrZrDHqDy8UoBcfagCqBdAhza67q1Gu94kfQ1i8w2IWjU2V8U4VKMwloE7Ig
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ROix+Sg9p41wVnJpQXSqiZYvlDZJA+nKwZp4NJTjS4itvC3NO6hntMWLYJTP?=
 =?us-ascii?Q?dEfCRuFXcVxxT5mN4Saj3fufyMydwkcodbB7tkGkYzMDLUYkZuRvyKAAFEfH?=
 =?us-ascii?Q?1UBf0k6co0q+0VKeCITWPJnGxQiTu+zUX3RjsUL1wu9dmtmwFqsKsOPj2ts5?=
 =?us-ascii?Q?QI2dgDbcm/HD49sxTjjVHfyzY3wggdAiIxKN9ceeHiRzUW1lH4QfLclPPmKl?=
 =?us-ascii?Q?/jQD+Ipsr8QIt8JFOn79NkRQ9E2Dh8IFXkrA7Jo0QNT9zMu1ZlqnaHApSjw0?=
 =?us-ascii?Q?YkESaYADoeypFp+s8Y33PDTRIUsOJq5Lsoq8lSfq+ypCnm38+ermfwt35lCP?=
 =?us-ascii?Q?HZ0EsGlMKfPxXvhc5rb5nalnCgWcg2oZIHsOuOng0n6MJ7CuXUDHGvzEzc4C?=
 =?us-ascii?Q?d58C3KhEllt7zXg1k/joGRDaSCufMju3ScgKRIbXc4kBZmEa7UgvMmtR+WiH?=
 =?us-ascii?Q?ajk/lwjMZFKcDvAaFxLazaN98vKnzamTORXWlqmf0hFQ0evZiB1uRFlV22rZ?=
 =?us-ascii?Q?Yiyku94t9Zo1RgJFtgXbNKHfWmOKdmLy2L5flrSNr8b+fwnY0RHj13BiZi2l?=
 =?us-ascii?Q?hHQ5461j5HvrPcfrjf8AiPdnXlE79ewtvoti178NBpNYE2xf1Cc7OPLjhuKP?=
 =?us-ascii?Q?kKfMcMPG05At8bkdWysbHO0vsTqcUPrZvIghc6C093lpfmAwZ7qWVyQmMOkG?=
 =?us-ascii?Q?Q7lkT/NuQFWe0eCbkcmIqBEydhIcdq5VNKH+4O87kjEODHHPYW+dCBv1BPZi?=
 =?us-ascii?Q?KF0eX3m5HWbHln7n/qXyCRX6zk2SpdEGEkIC9R/W42viSgfIJMWa/TZiADjS?=
 =?us-ascii?Q?UxAE9chC5w6R/zzkmu9LMchQ+WlMxEwY8GwdG4IGN5HPhfraELg5ynHLczLn?=
 =?us-ascii?Q?Htkwd4CEjsdSDj28F6k0AeyPveSWJIjcHOkHPVKqLXt+nvZlPhFWjbyr5Zy8?=
 =?us-ascii?Q?kqU/WWjJAcNJjdC3o+Caz8fJ4mL7ilkT5lmrwg5WBIqQM6OZDctnierWpnvB?=
 =?us-ascii?Q?G20z/2CBwUpdNmhn4VFqNFTMV4Fu+N/HUAs7oP+fLW4Pv1l40mLY2QrOmbME?=
 =?us-ascii?Q?ru6a7CrTa1d4QpPBqORwfgdnxigEJCIKTwuwN6sDeEeDIlRLKiR10EPK16Pn?=
 =?us-ascii?Q?phTFjN3DS4dpNp19L2F5/jWw2qKYJy3CYCcChW1sXGAer/Gl4BFnNEzY5Ou3?=
 =?us-ascii?Q?R2TzgN/JCKi+SaQNz964cJft0MJlV4VcZ/IFa4l22fdcWqbm5gxDNUGGX1dd?=
 =?us-ascii?Q?AIc9tCvqOrH2Dmi74vSZb390XUBuXgjcHPvMcUgOYP2UD2Xd2cTy6byKW28r?=
 =?us-ascii?Q?Bx89iz4+T+QF6dc27sbnQ7TZgtCdjYWLUvZ+kOUoYheZlJQAusnIiv4bg4dq?=
 =?us-ascii?Q?gPk+hNJ7Qtt53PqFLNcle71xYLEATNlmR2ia7roQ9lcgvmcjDW9+GTBQIw1A?=
 =?us-ascii?Q?Tfwx+/DLQf+z/2s6nVy6PDFZmnOAtiMbvbLaJdMmJ7APH+5VHsg1XMJREEPi?=
 =?us-ascii?Q?g0yU9XyvwR7GClCHk+2uYsUkWqdpfbTbzUMHQCOlxy2L/+PWCYzFhhKL3lLE?=
 =?us-ascii?Q?YqhEDssI8jM/UodGuirBiND6fznyBIfaJyHirXCZodiiwyj7aSreSirhhE1B?=
 =?us-ascii?Q?V+GMKBi8DXEluK7CvLzkKC1tbHPHatuYM15ytUfuV11ZRv3XjTRqIvglufBp?=
 =?us-ascii?Q?Elj25z7v4z1kDNdd79CdkV9wvFU7AHmXQXayfi6VTOtrPM0IvOKUbl9ZpLvn?=
 =?us-ascii?Q?39Si5EnM7XGytjMYA0lMEo41phyqGcpUxZS2Z9Dt1xbip2msVfyK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e510684-9d66-4539-0eff-08dec5d85006
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:36:38.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Amn9O2TaoivEJSRPOlMNcYDrA5ErwBaVkBB1kJuE2fLZSgcbIH8YcG2zcMg3LWJ2BR/sH0aDnZyHB7jPxmJ0ineCIYaB8rrAVD4vXDx/MjxsXmUcIYJWPOTUrPm4JayN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543

From: Sherry Sun <sherry.sun@nxp.com>

Add 3.3Vaux separately for special handling. This supply has a different
lifecycle - it must remain enabled during system suspend to support PCIe
L2 link state and wake-up mechanisms.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 42 ++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e82821655fc4..6b8c77cf20a9 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -37,6 +37,8 @@ struct pwrseq_pcie_m2_ctx {
 	const struct pwrseq_pcie_m2_pdata *pdata;
 	struct regulator_bulk_data *regs;
 	size_t num_vregs;
+	struct regulator *vaux_reg;
+	bool vaux_enabled;
 	struct notifier_block nb;
 	struct gpio_desc *w_disable1_gpio;
 	struct gpio_desc *w_disable2_gpio;
@@ -48,8 +50,23 @@ struct pwrseq_pcie_m2_ctx {
 static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	/* Enable 3.3Vaux if present and not already enabled. */
+	if (ctx->vaux_reg && !ctx->vaux_enabled) {
+		ret = regulator_enable(ctx->vaux_reg);
+		if (ret)
+			return ret;
+		ctx->vaux_enabled = true;
+	}
 
-	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
+	ret = regulator_bulk_enable(ctx->num_vregs, ctx->regs);
+	if (ret && ctx->vaux_reg && ctx->vaux_enabled) {
+		regulator_disable(ctx->vaux_reg);
+		ctx->vaux_enabled = false;
+	}
+
+	return ret;
 }
 
 static int pwrseq_pcie_m2_vregs_disable(struct pwrseq_device *pwrseq)
@@ -497,10 +514,28 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -ENODEV,
 				     "Failed to obtain platform data\n");
 
+	/*
+	 * Get 3.3Vaux separately for special handling. This supply has a
+	 * different lifecycle - it must remain enabled during system suspend
+	 * to support PCIe L2 link state and wake-up mechanisms.
+	 */
+	ctx->vaux_reg = devm_regulator_get_optional(dev, "vpcie3v3aux");
+	if (IS_ERR(ctx->vaux_reg)) {
+		if (PTR_ERR(ctx->vaux_reg) != -ENODEV)
+			return PTR_ERR(ctx->vaux_reg);
+		ctx->vaux_reg = NULL;
+	}
+	ctx->vaux_enabled = false;
+
 	/*
 	 * Currently, of_regulator_bulk_get_all() is the only regulator API that
 	 * allows to get all supplies in the devicetree node without manually
 	 * specifying them.
+	 *
+	 * This will include vaux again, but we'll manage it separately via
+	 * vaux_reg. The regulator framework handles multiple gets of the same
+	 * regulator correctly via refcounting, so having vaux in both places is
+	 * safe.
 	 */
 	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->regs);
 	if (ret < 0)
@@ -573,6 +608,11 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 	mutex_destroy(&ctx->list_lock);
 
+	if (ctx->vaux_reg && ctx->vaux_enabled) {
+		regulator_disable(ctx->vaux_reg);
+		ctx->vaux_enabled = false;
+	}
+
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
 }
 
-- 
2.50.1

