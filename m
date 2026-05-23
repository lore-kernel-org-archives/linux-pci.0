Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012048.outbound.protection.outlook.com [52.103.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AF386556;
	Mon, 25 May 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716603; cv=fail; b=u+Ve+DmRrJDEEXQbm5TGfg5Ud54eS4NUCUQqQaw9BN7W2UnuF79PjU9gpz7p9qZKp5jynRfWfLd2sV+1a3s5kIUPIRf6tZChMHK+r+Vm+BFQy3xRQbTi2yo1R8VZQLr2NiCIUq4gY4OZBZmcf1LzQDapsq6CCmmHWMOJZ54SEtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716603; c=relaxed/simple;
	bh=vTiAHKw0uGuplPAwVpIEiVhzQbsVdI+7/RmnX2iAxjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEoycClcIk4DO9crAiKFrLlaDglmSYD1hy5LGhF6T9+z57RZsXwqKxpgvKAbBBcEMg9s9gEn3+LwczTcsggih6XQ5rmWoG7XczDs7U83lVUuhxhxXHoVRKapic3i79iibbt6pxD3kAdl/IKVHppszT7lUOpMWZmYezEKgN8kslE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=PLQJbV1y; arc=fail smtp.client-ip=52.103.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PLQJbV1y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwi68MQTJoSpJUiQwm7sKyhW5n0vsadRkL4zzoNwF0BKEFvK/Chs0eMzzHZf5foeu61v71iZYkkrPSONMrdGgvVCPP+etBDpC/lpiG47WpKEh/CPvR1U1UUAhdwFKY2IL8hhHbolKQjyljUuv6684xKfU3XuJNxBBeRjcxL2IGAhKRU+80VtzP+nybGPPgDcuvt1Ue0GQyEl4GZMn+cwMi5FT95iThz8KXuXYJ1Vwm6pA6sbZFDP4mlxMbC4gXU9ejlw6akERLLz0W+Fn/rl2Cp4Wzn0Mvvikv+u9kO4GcFdFrTbdTS0cLM8XPgEXr2d8wlOPHe8YciEdi9IHIrbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdhDG843EYZ78UNXH/PGASgJQ0dO/0RCRzh233fAlGI=;
 b=mtG1T+9ifAQnqKnXx6BimptzojsijO6k+/knbBwXCMajdG058Baxj3qJfScjHrswEW7bOLMOsqCNPUArCRe0UcTfSlHMrk0kLYoLYxDiNqo+YksWWAFbh+B2LDLN2uSbdYnD77dk3Us/vwGhHqgzE0DGemOEEd3v0i6JMn7Sa8wY3YLz1hmQVklfiZh6jLHT6Y9KSGh4Ff3eXO+ugn8Q9uVIOElChbbv+xoYilc0Hly33SAEVWpZKVN86m2GyuEOnwz0+zxpUEsFS1M7PMcuD/WoHXSp35oTbgiLyT++TG6ZoZvgFSVFNXvW7o4Ie/Idvlk13VQBCJXLfCvfGwYi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdhDG843EYZ78UNXH/PGASgJQ0dO/0RCRzh233fAlGI=;
 b=PLQJbV1yl9eE1DLtLBIIYsYRTMWeZF+Zd4gXvQKM7hZBTtMuydjto/k/ZfJXBR5iEHS0F1ktv/O7HRWB025xu3YHYAlNpDDuF2h30FHTDoW1uuJqeXs6MZaAtnW4tZNmRjkx9NojZwhxNOzcG7GzPndYCbs0g8Rv5aO7zkw1YnJTS2N14ghZ5tUjFvRSPd2nF2v21gTv4F2Z/l5vjd8vknyUQJuy733NIPcTIoz82our2GBLja7xoi4wgIH9UAQ+AgWb7QNECsycYK8LscWWHiFcg42I5thsvLiq6Cnq0Z4eOp4h35QK1F70xZ+Pj1RYEe1/K7C5ctXOYKIJN6Z9CQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5718.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:43:17 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:43:17 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v8 4/6] PCI: Refactor disable_acs_redir and config_acs param handling
Date: Sat, 23 May 2026 22:01:41 +0800
Message-ID:
 <SI2PR01MB4393AF5B45E56E8D3B50C1EFDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779442182.git.wei.w.wang@hotmail.com>
References: <cover.1779442182.git.wei.w.wang@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <146d04157fe6f7053040611ea1bcb5ff0bd61218.1779442182.git.wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b331c68-0370-40e1-d86f-08deba63930e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599007|55001999006|45011099003|16051099003|37011999003|51005399006|12121999013|41001999006|5072599009|15080799012|8060799015|19110799012|23021999003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2TDMHXP2Xm4F7W9AgTgLaAm1kuBF2c9hkhX+e8JKtuV11vLsrLL8807dCg12?=
 =?us-ascii?Q?9owoSJczscBQXORoGus+CyP8+6NZmjjx18fDvJTdxddl6ewa2cb8HxWLFiUe?=
 =?us-ascii?Q?Bk5WOMOzs4dlmL6dpNb30vKqlSZG0Oq6ag0lcRW0cUuldhpPsFUeMTsXuiYP?=
 =?us-ascii?Q?9HzCFJWifo2lyAcwQi+SZuvqcF7Sv68T0ZOKE4XyXX8D4J5jHqiS1+a7mCe/?=
 =?us-ascii?Q?xAcOwU4GekECsTznBq3CXbCjmhbFzz14hj6RyHwh2q9GP1iL4RynrgRlamHG?=
 =?us-ascii?Q?9E9v7gy2c0K17qMhzYJOURInXE2+CUEjIfB+vX+YDWv4gM1/BX5lIcWk/Of8?=
 =?us-ascii?Q?DA0O50MfFdYVJQ9KRZpVcBPhAWA0vZSoV68yvkM+DazUb8TrVEJIzaOIqiwY?=
 =?us-ascii?Q?bHmw5y6kNcCWaulJEW8/oHAVNdiCuhK8Sj4c2yWEh1eqoicFW/68dsnACIcX?=
 =?us-ascii?Q?E8E3DA7MOEhQEQJs/ftHiCt6tVmT+XmQ9Ev1Tx/LKUh+DDkfR3xAXlGuNhem?=
 =?us-ascii?Q?m5DhkAFld1M2klPQiIQ5osjcyiV6gnqMBpK/ExTwmBzilKH9pmTB5qDsKxDZ?=
 =?us-ascii?Q?NjHqsoXUGobUpe/u5AIyLrxTj21L/qK5jf5cgZSvFcP7uNu3R0lOwcMloWjS?=
 =?us-ascii?Q?+nUK2qSWP2BbtOSbeEf6fLGYCRmoVtsPMre1fEyh9/8Xt6/mhpxNhkvYbCkd?=
 =?us-ascii?Q?u6gU/i/CvsuhJ6FYXZIxljs+ig6Z0q7RuhZFHkwFruT9gFqmHAIP+3pGmVVQ?=
 =?us-ascii?Q?LB5pU3F1LUjVMn7WBpKhAQiuinNZX58GGA8vCZjiyjmPC7OqZTIJq9cW/4r9?=
 =?us-ascii?Q?fm7zmHoRJZVFcp6gRmI6QRXStDJWnG4zGrq5qM/yLYQfVAf04/eZIBrUWxns?=
 =?us-ascii?Q?Y/thyExjuNYp6aZYJnobyfxWqZE7qs+dMEdweUnmxRPPX5Z18hEkSzOsmK60?=
 =?us-ascii?Q?iF+typVQaOmSlWdvw6szQL06rQI1oMhgla68ZZ2ns8WG5xXvx0LiMTD4YPBz?=
 =?us-ascii?Q?HDNBMI0Xt1YIFQkwDjetd1Q/U/jB760C/ALIEZLvYzM8S7XQmSggtJkieuoi?=
 =?us-ascii?Q?6XuNpYPqdvw1wccS1wcN6s3VUzgmgMhKXoou3ugvgOuFVGNpWWWdX6jE+VjN?=
 =?us-ascii?Q?/9ReBIFN4GZj80qFf47b6UQceNUKuVCxvQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9DrEOd8ahmsTc9LtWR4Hf5064D+WaLp/Vm4aS5lFdqw8DzpS/hA74p4y5lyL?=
 =?us-ascii?Q?g85PeSXHznImmJ8SDVJZIRsldZ5X3gvfJfcqxaYdlvz9rrRsBZzy5MbdRUr5?=
 =?us-ascii?Q?1VEKVPqYjjoyOCTpsRVYAObLXbzfxrlP1DUCWJGPFHM5+OYH+X4LRY2uG7XY?=
 =?us-ascii?Q?6DhdCE9hwp0CjrN5ztpt1ZZuiwJKYIZWtOkAN7FZGIwFHPhxrJDz0WPHbhA1?=
 =?us-ascii?Q?YEqb0brUi+X/ysqlIJ7gOH82Sb/b8ZH+NhXwwa+1EtnD5TEIo4gpYmJOKhqJ?=
 =?us-ascii?Q?hjXanccTx1KwBLamr9VpDrUejSC/It7xiw1QgT30VtmFds1FO1jDOLnpgxbd?=
 =?us-ascii?Q?Vw0tl5/iAu29d3vKD81+BKSMTCK/N8tDzP1jYyhpKCT/rNROvj0vwOytysqJ?=
 =?us-ascii?Q?0RO4nT6aaDrt567pWwR+cQ89J29E1pkrV8Qhvwzp0Hm3XaZbsOL0O36KLt8r?=
 =?us-ascii?Q?scn/356w9uddgzM3L7MXg1SRZuLD3+RIdMahKiHX5UKVuoLmwYGJ5lzjdTL8?=
 =?us-ascii?Q?/D5H+k2+H6q/MA5iaFBBlESUKxxqJG/MLS//dolSBMzIIyzlSlWDvBEcQlj+?=
 =?us-ascii?Q?TC/tXkZlfzG2BzTdmRdKV74gHaxqEp+1oeE/yMiTUsFcyWku6oLBhLepoKwv?=
 =?us-ascii?Q?XTFAuNMda/UZJIBpw1wFO17NCw3ZfdVSE5syShbYp16oneOZu95MlLz1wXwc?=
 =?us-ascii?Q?FwDdmFZP58SCqObPggQowXPWlJ9kcD9aPm4at1bjqUBE8u7imS122u3YOd5R?=
 =?us-ascii?Q?i3uKtKi/MoF/OQM4tBwerkbcapqNlTXfa0G9sAL8k4cRWYNcVSggewMtmFSq?=
 =?us-ascii?Q?WEZaQu4wH81FsqNaXiKkYkVo9a5eieb5ILvjdSnyjIF6FyJ308mv0DTXcKFI?=
 =?us-ascii?Q?PCBjbBb2Xmf8znNxAS3zHBSIyvOO+joH61MLybCFZljps5uuWd4ufroX6nyr?=
 =?us-ascii?Q?fE5Qeb7GSPVdG9/DfIV3+FRlcBo5wYWAXrwP5wbC4cQLFSY7ZO0ZXuglBjPi?=
 =?us-ascii?Q?jJMeWol5gqQwVfmZfLeTRbwicSjeO+6KjkpGvtbTgfWLwbCQu9d2y1mkq7CS?=
 =?us-ascii?Q?LFr2Z/MGcHJBvFl6053FBMoA8vE3VeRU+1RvA5SlExBjZ9NnUdo4vRqpF64F?=
 =?us-ascii?Q?hHq5pNkf7Z/su7gpQFeygKpzjbpK4ln72CSr53ujIlxJ16Il8s/QQcDK+jh+?=
 =?us-ascii?Q?MPSGJJfGtQLzTLZdBT47etKEtVFgoGUrgvOlWD55VRZgQ5mIVi4pNBW0NKle?=
 =?us-ascii?Q?JTWj2K2NhzfM2bkbU512KhN1Kf8/8NSSWad08OXreK7r8eEslXsgkPkhLVSf?=
 =?us-ascii?Q?uvzyxowz+/LY6Znt/85vnpmDQ91KZ7T3Z5tXhpHMpKj8lPB1j4Or6WFEJo2F?=
 =?us-ascii?Q?3qT+mTYrvEWEde3W9vz04BBN8w12?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b331c68-0370-40e1-d86f-08deba63930e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:43:16.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5718

The current implementation mixes disable_acs_redir and config_acs param
processing inside __pci_config_acs(), using acs_mask==0 as an implicit
signal to switch into config_acs_param mode. The intertwined logic is
hard to follow and easy to break:

  - The acs_mask==0 special case is non-obvious and obscures which code
    paths apply to which parameter.
  - The interleaved logic is fragile; changes intended for one parameter
    can unintentionally affect the other. For example,
    pci_dev_specific_disable_acs_redir() is invoked on the common path
    even though it should apply only to disable_acs_redir.

Split the two behaviors into dedicated functions,
pci_param_disable_acs_redir() and pci_param_config_acs(), making the
control flow explicit and easier to maintain.

The new pci_param_config_acs() implementation also improves on the
original logic:

  - It searches for the matching device first and parses ACS flags only
    for the matched device, avoiding unnecessary work.
  - A switch statement replaces multiple if/else blocks, improving
    readability.
  - Variable names (enabled_bits, disabled_bits) more clearly express
    their roles compared to the previous mask/flags pair.
  - Error messages are clearer.

This refactor separates concerns, improves robustness, and makes future
extensions to ACS parameter handling safer and easier to review.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 176 +++++++++++++++++++++++++++-------------------
 1 file changed, 105 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9d39dbb117e..b2e5b0119397 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -891,89 +891,118 @@ struct pci_acs {
 	u16 fw_ctrl;
 };
 
-static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, const u16 acs_mask, const u16 acs_flags)
+static bool pci_dev_match_disable_acs_redir(struct pci_dev *dev, const char *p)
 {
-	u16 valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);
-	u16 flags = acs_flags;
-	u16 mask = acs_mask;
-	char *delimit;
 	int ret = 0;
 
-	if (!p)
-		return;
-
 	while (*p) {
-		if (!acs_mask) {
-			/* Check for ACS flags */
-			delimit = strstr(p, "@");
-			if (delimit) {
-				int end;
-				u32 shift = 0;
-
-				end = delimit - p - 1;
-				mask = 0;
-				flags = 0;
-
-				while (end > -1) {
-					if (*(p + end) == '0') {
-						mask |= 1 << shift;
-						shift++;
-						end--;
-					} else if (*(p + end) == '1') {
-						mask |= 1 << shift;
-						flags |= 1 << shift;
-						shift++;
-						end--;
-					} else if ((*(p + end) == 'x') || (*(p + end) == 'X')) {
-						shift++;
-						end--;
-					} else {
-						pci_err(dev, "Invalid ACS flags... Ignoring\n");
-						return;
-					}
-				}
-				p = delimit + 1;
-			} else {
-				pci_err(dev, "ACS Flags missing\n");
-				return;
-			}
-		}
-
 		ret = pci_dev_str_match(dev, p, &p);
-		if (ret < 0) {
-			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
-			break;
-		} else if (ret == 1) {
-			/* Found a match */
+		if (ret == 1) {
+			return true;
+		} else if (ret < 0) {
+			pr_warn_once("PCI: Can't parse disable_acs_redir param\n");
 			break;
 		}
 	}
 
-	if (ret != 1)
+	return false;
+}
+
+static void pci_param_disable_acs_redir(struct pci_dev *dev,
+					struct pci_acs *caps)
+{
+	const u16 acs_redir_mask = PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
+
+	if (!disable_acs_redir_param ||
+	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
+	    !pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	if (!pci_dev_specific_disable_acs_redir(dev))
-		return;
+	caps->ctrl = caps->fw_ctrl & ~acs_redir_mask;
+}
 
-	if (!acs_mask && (mask & ~valid_ctrl)) {
-		pci_err(dev, "Invalid ACS bits specified: %#06x\n",
-			mask & ~valid_ctrl);
-		return;
-	}
-
-	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
-	pci_dbg(dev, "ACS flags = %#06x\n", flags);
-	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
-	pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
+static const char *pci_dev_match_config_acs(struct pci_dev *dev, const char *p)
+{
+	const char *seg;
+	int ret;
 
 	/*
-	 * For mask bits that are 0, copy them from the firmware setting
-	 * and apply flags for all the mask bits that are 1.
+	 * Example: 11101010x@0000:01:00.0;101x@0000:02:00.0;1@0000:03:00.0
+	 * Three segments delimited via ';'. @seg always points to the start
+	 * of a segment and p advances to the start of the device id (BDF)
+	 * after '@'. Upon match, return the start of the matching segment.
 	 */
-	caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
+	while (*p) {
+		seg = p;
+		p = strchr(seg, '@');
+		/* If malformed string, stop parsing. */
+		if (!p || p == seg)
+			break;
 
-	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
+		p++;
+		/* pci_dev_str_match() updates p to the next segment. */
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret == 1)
+			return seg;
+
+		if (ret < 0) {
+			pr_warn_once("PCI: Can't parse config_acs param\n");
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
+{
+	u16 shift = 0, valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);
+	u16 invalid_bits, enabled_bits = 0, disabled_bits = 0;
+	const char *p, *seg;
+
+	if (!config_acs_param || !valid_ctrl)
+		return;
+
+	seg = pci_dev_match_config_acs(dev, config_acs_param);
+	if (!seg)
+		return;
+
+	p = strchr(seg, '@');
+	/* Parse bitstring backwards from '@' */
+	while (p > seg) {
+		if (shift >= 16) {
+			pci_err(dev, "ACS bitstring exceeds 16 bits\n");
+			return;
+		}
+		switch (*--p) {
+		case '1':
+			enabled_bits |= BIT(shift);
+			break;
+		case '0':
+			disabled_bits |= BIT(shift);
+			break;
+		case 'x':
+		case 'X':
+			/* Skip this bit */
+			break;
+		default:
+			pci_err(dev, "Invalid ACS flag character '%c'\n", *p);
+			return;
+		}
+		shift++;
+	}
+
+	invalid_bits = (enabled_bits | disabled_bits) & ~valid_ctrl;
+	if (invalid_bits) {
+		pci_err(dev, "Invalid ACS bits specified: %#06x\n",
+			invalid_bits);
+		return;
+	}
+
+	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
+		enabled_bits, disabled_bits);
+
+	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
 }
 
 /**
@@ -1008,6 +1037,7 @@ void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
 	bool enable_acs = false;
+	u16 kernel_default_ctrl;
 	int pos;
 
 	/* If an iommu is present we start with kernel default caps */
@@ -1026,14 +1056,18 @@ void pci_enable_acs(struct pci_dev *dev)
 	if (enable_acs)
 		pci_std_enable_acs(dev, &caps);
 
+	kernel_default_ctrl = caps.ctrl;
+
 	/*
 	 * Always apply caps from the command line, even if there is no iommu.
 	 * Trust that the admin has a reason to change the ACS settings.
 	 */
-	__pci_config_acs(dev, &caps, disable_acs_redir_param,
-			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
-			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
-	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
+	pci_param_disable_acs_redir(dev, &caps);
+	pci_param_config_acs(dev, &caps);
+
+	if (caps.ctrl != kernel_default_ctrl)
+		pci_info(dev, "User configured ACS to %#06x (default: %#06x)\n",
+			 caps.ctrl, kernel_default_ctrl);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
-- 
2.51.0

