Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012049.outbound.protection.outlook.com [52.103.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCA55D88F;
	Tue, 22 Sep 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089425; cv=fail; b=PQU1SkElBKcdMZNY7XRwq8hIMIyS7MI8654gPFeryiFK3VwAbYZ75zs90GgduGGceBw/Lt0xXZ+0LQdk6vlkUFqwWg2FBsi2Yz5U0yjy0TaQRneTSCxiDzGuiAEqXUTe+R1u9o1YxvgHul04KxZ8Hw46mxA39fKctI4sRMqrXNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089425; c=relaxed/simple;
	bh=uO0aFD+Gs5RPRsC8mp1efOK51gzR+VDmB3vybqqYQOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KqrCs+2yxZMrcNaj9/eeyAcc5ucYvl/YpC+tiQboWTdbnmVbTHascQzfCkDaGeF4zba7cDlFJbAzWMtt4C2IGH3nk/Vb3BFUCJZt3PdVUeDgE1fVTxGrj5DnH31tVj6tPekgx0SC+lPhbjNNxEe+bYQT9NMrjsr3YCVcr+g3a0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=rhoKjjjC; arc=fail smtp.client-ip=52.103.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="rhoKjjjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U212XEWaj2zQBsHjIkvw+vr26L/Zz0pV/T7abQ/jSHPtOqvJrIkTnLdtPkR6drSOdqqUZ6Jx1uJyOGgTQEoqMx+i7EMOx55n3pkoASBJM3nCKsUntiqPKejWiHvbpvTwrtl/5AVgBEL1QLADalj9h1qMVjUsEZa8RNc4qwtohxooxEFGiw3STre6vW0bCCqqChl9NRznunAZH+sLTtDLl1smi0MvmdaDZ5No91BeN+uZhOsNVuHOxhVd56Ym9aYC1SwjW5/zs7MKckdJ9T9NaQlQehYosSnCHXgD/3+Nw51rx+aKppCp4RlJPOV9E9SYpDDq6JcDDovyWluy5Fj06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZczpYnInBD57iYKSiGZ+7Ert5EVTFZce221Vbbzuaek=;
 b=Y6IdYz+WcNGOxZ7nofHAOODcAhPiVXNctz+HQUQgI2NTvVHeMDq+/S953CnfilrW2RAN/9DK/XJYKDbiDJwp/1MacUTTU/hh2Tsz7TtE0fRIkkfT/UUMvry3dcJENBfeo2c70t4WNseZ1TQdZg+22aVEuktwnoz1rI4/zVaxADbwFvAF+MIXvUOjJXhnDTHBHcGgwZXnqWZ+L2M07jzcITorFq5GGIjY+VbTRnQeSw68eQ65dHJyhbGWUbFK4MaR8DlD04/Lt8beGfr9aOQlaq2nBSGmBe5fd5960c5fvuT+Lbx3ZeAwtchu28UYuNuXNgc9uzXJ3IkJa8Aw+51/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZczpYnInBD57iYKSiGZ+7Ert5EVTFZce221Vbbzuaek=;
 b=rhoKjjjCrxT/rBC4oCobo+NCVnIUF9TwpNOv8aVQ0YH3mHOhj6rGJ8aVmd1RovE0fM/sbq48gmF9k+yVzmzwSnDggyktYIh92q+xLkGHJh8tBMw353d6wEIm/U3fKcry1TIuVbTKEXWiqfA31Jf5y6Ou61AdMx0+CTHUDlUtm3BUsuLjoPWBIGQ49jsG3eJexxk9KEVeRvQFZxk6eFNa4RA1TfQI2oJrJb/2u429gqAkNCKs/a9dU9MW6XmnsTzhAeMIHb72goZd5dmEx8vww5U3Cj2yaeKe/1SV4+inuPdeCLxazp4nGcgybQ/ZkHs5IZaXzluLj2+FH5LKoFALng==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5711.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:03:35 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 15:03:35 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	ben@cressey.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v10 4/6] PCI: Refactor disable_acs_redir and config_acs param handling
Date: Tue, 22 Sep 2026 23:02:56 +0800
Message-ID:
 <SI2PR01MB43935F96407D9E8C8ED028A8DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::18) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260922150258.3087572-5-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: f49bab90-ebd9-494d-f13c-08df18baac4f
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7UIJJCXZ1LGwOeD8xjmlz6hAJTLQOK9/6ueRGcuotiLWE/KIB94Ky0HoIz7gOJs7APcJiHGGJU4PDUI0M8U7bwVzOcIgIX49S/xYfKx57NMmTCyAjdPPO3aZAwK+MuUrqwYFSuUUJerj7L+JmMmGKB+ZRH+l5iW/uwD0vHiCbSWqi0zFSlSKSZcD8R+hPm9tkCYUPnt7k7bDwx+oRPZUeQOqq3UGdKSJSe83H0szyHsEQZKZKEemwGuHtWdET+DU9xixKowLFFTMXiLQ8jslyXag+y/RFZ2h9mZPMzYXpbAlA1EEPO3UaHsL/NacGJJEmwwGPmelxH0R9Mvf/z8tNzUcFZVOSEWDPJ/Ps0qFWjUMU30TsVOxxKheKTyKSedV5mvM+dTZ8UHXc3ZMwxaT4cgN8jW6qcMPIF5vTSW1c/i0B4/Cbbd1qcB6Mo0pTvYSikeZKl/nxGm23By5kkNqJlEYN5cY7kA2Q4RxpJ3jjxZQSRl8UJsGSnjf3aiozmxY0ViXqHnn063PYnLlJN5xY5nWQ3XLau1eeH6aPnMUTj4QDoAn6/+jhmgh0Af0rwSPI3hRn49bEFKFvE/MLpgQloI9izIgZGHPQmI4SKVRhN+gy/EGZjSFo+t3ZgcnJ6LMjPIm9dC0lSDx+o1bMtRH8GYmpPZzYKP6qtU6wMfQ++F50A+KIHH64J7Wct/p6v6TR3g7JXgS/v26pNlemFpmqaACgOY/5heh229nW+VFKG/M=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|45011099003|19110799012|8060799015|5072599009|41001999006|51005399006|7042599007|12121999013|37011999003|15080799012|25010399006|23021999003|16051099003|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XX8kir/i9a2uMUcApH0ok/DDfVqWE60HXn0BWRnKMtzpE9Chwmjwj74N+GkO?=
 =?us-ascii?Q?h936qt2oLjmh8oz9bg2nfttADU+eFyF8tWwmigJV1wMDvEgg8o6QbZfeJlze?=
 =?us-ascii?Q?AwQinrTgjE0y9lVwEr84Kn/siReykdYMTnhVkLMIm17NSJroJoUf8GXKkasw?=
 =?us-ascii?Q?KoZ4xeURzK3bgHtAbdlskmJfb7LjA5TrX0Veg8XqFtt0vfJ0wKrS/eegzYUY?=
 =?us-ascii?Q?HHGaMZ5UA1u8NigmDGOCqPBsFmv56Xxx0YEwvVHeFPMn8GFqQJnFsEj9SHJ6?=
 =?us-ascii?Q?tPbzySNQjMBeOrkB67IsQkgAirS2Q/Ok2StSdCNJXd3KA6Raq6VCzeExa7J7?=
 =?us-ascii?Q?NuHKkTI+uOgStMNRh6CiyhmCVnMiZ3aIevoScoEQMRVgXtlIWz9ot1W+h2kf?=
 =?us-ascii?Q?FrvZkXKMyng5B0qMaXAEKCzYrs9YgSYS8qVB/XwwyebaKIfSb+uRQyBCa9PU?=
 =?us-ascii?Q?O+xNuMHZrbR4qh/lCaLRM0vvOIUXtLZYzDHDUIKgNkjWRIaa4pMf/1KAP7uX?=
 =?us-ascii?Q?22QQe7pSKGe0FUvH+9gLH6BqbR2Imii6nP/u5X8exwDh0/FYwSiSY4XQ8zhX?=
 =?us-ascii?Q?FZoF7K6cxziOU6S2iMwI+r19HM8taerw54t0Sg4eOQewpfSS5ZqkWJQqcmxZ?=
 =?us-ascii?Q?ORx8JiZrFHYUbHjnG32K5pgHBkLNfqF398GIAvuQmHhAsmkcC14jplQ3HdLG?=
 =?us-ascii?Q?Hp47eoBlrHiYjROrRRZvYw0xVudYQUhWw9AvXaySBDojOq+hro2AZ5uNtRT0?=
 =?us-ascii?Q?J+N+mAi2q4xogVWwkc7qxiZ7UTop8sxq572nNDo73qe1tcgxEXyzDSf3xOzD?=
 =?us-ascii?Q?ch2rZy1RePKgu8TJnvw7jGv1WKzYNKcFkxBatFjxc+UzVGP4qgpPlZ5Gl9D5?=
 =?us-ascii?Q?dShf8N8JY4PgTXZkVKfkHyneAHhrpOx3f4UZmEYjLllo73+YY7wQEqq9wP1Z?=
 =?us-ascii?Q?4HAFgl6C/1gGqYONQsOZkoRERmnFvey80na8/A4zNaJ95Msdum+BqOx7I6Ww?=
 =?us-ascii?Q?d7KA5zTefgrzGybHzpYRP2qrDv4pQ1PAHzO3eXkzTlqe/Z76HKl6+/nr4Tay?=
 =?us-ascii?Q?fFTQaQ3P3hSNgJ6W3SI52ZYLpEPhDM7xQwo8hACIBpxi24A2Nh2BVyJ9zM89?=
 =?us-ascii?Q?f3NyIa5/bBr4?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VikzHbj4RTcCiX5r43NsT4wSt9VyCmX6ZTcA9j6qYduz0H0XQv3kt1QiZzUR?=
 =?us-ascii?Q?hvESG+6ikdosoRft3FA2Vi5TuPql4YHeUT95HytOM1mM0RLHZuT+MZYzXSBq?=
 =?us-ascii?Q?ctGzkp+hgjSqHG3m2W+QybRAoJrpwJVAfFeRWLt1YgSlXuvrhREu2qRI+GGG?=
 =?us-ascii?Q?+gizPIg7IACubnLv+iajsuNyTNsRvzI1v6RjtgZjAGfBDq6Su99vzqpduuLG?=
 =?us-ascii?Q?3e816nyxWDZbCyDtL+7KffkCfTgFZOsa6B5vXpqecatQfV8CCwQQzjjiQfTK?=
 =?us-ascii?Q?MW86hkMXxTRwF6+lYEHb8exTeu9eEW9aN277HIspuw0jAVO7nsk6DbL8FUYn?=
 =?us-ascii?Q?e4v5Wh17++QHm+d53AeoH9BQnvyMkdfposVvmvpKi225U5T995dYqHraoQvF?=
 =?us-ascii?Q?ED9FXhi1xZQrLiCzyMJ4yh8yx7G55cY5z4RLMUuPPDYeGG5nspjNSlwqtu6z?=
 =?us-ascii?Q?Vwa6KpwqS1xpVM5wZ1B0YUw7MTJCSTQMjZmgHTrrBG1EDtV0qyZ4lLbO9Y22?=
 =?us-ascii?Q?+4ChWl1S3UYeKtCH8LFsZRkVcCTIimP3Z3/H0ZYMoPvoM29I3KRZ9oo5czRz?=
 =?us-ascii?Q?q6KKM/oa/iwutsI5d52CfF+FtH3YkUDWMqBnKoWo5b6T91gioSZgsSHOULud?=
 =?us-ascii?Q?FmckYRhytauryYcEABGw/Y5tqxen93XpozkK+SuvkTYtLOeGiAuEBpJlULvI?=
 =?us-ascii?Q?/h+H3NeJhFMeLYMx7/URF1GY2oU2hU8y4Bv39kWqIBxLVSvjls36+pe7BTyg?=
 =?us-ascii?Q?/zjnGAWhnynyknWGyfSdFQMlpuc8BJjYdlWoR43lb5SS7oLNqXsXbriM8Wv+?=
 =?us-ascii?Q?EdViyAGUkPRRm+tSynGk/6rokk8u1gBb+sYvz1GW9MsVRFySpZnVUnjSoTur?=
 =?us-ascii?Q?xcauyETP+6x5SiRmdw4uqqNyZ1Hjr3+Fdw1R46wd1zyzdZIOeoPoUTZQS+c8?=
 =?us-ascii?Q?fpMCgTo6RmG20QwMo8BOnRuBVHPB93rTDGLGpxKq/hUZtEHUFOnk72VY06if?=
 =?us-ascii?Q?ZH/FMuBkhqvVuPgorY3Pc4Pqm0F3riUjVYPuvV02jf3WxWajydI8OkJsXThC?=
 =?us-ascii?Q?fChLqC2avvBePK1dp0MWRa2RoGojRHhDu2r5pzuWd/BRHgdFM2wNUZl0i3aq?=
 =?us-ascii?Q?I+jyIen7MQlpB8Nwcw8zohYHFcs69IEvUwlSDitfm6tT9suwX/395L1e2/+F?=
 =?us-ascii?Q?CO+jV7COJ+0YUJ83mTTeGMvkBGkrFaPamFjG6N/MHOQmcrMEBmfWSl6PO62L?=
 =?us-ascii?Q?F2ca5QSfY+CcXoBunYizSiJ+YMdlZ9oXY94rYFxCrfMHD4NP2hlqnjhCajaG?=
 =?us-ascii?Q?RHpuyOFUrkhAQuia5ptgc1zs032Ru9qg3DCrb8+RtNZx7i1Oco6SgpPr/tW1?=
 =?us-ascii?Q?Cpv/K4KM2RWrZq3TfhqUvr1nUjZw?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f49bab90-ebd9-494d-f13c-08df18baac4f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:03:35.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5711

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
 drivers/pci/pci.c | 180 +++++++++++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3e2e34b24019..ffb489e4cbef 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -912,90 +912,121 @@ struct pci_acs {
 	u16 fw_ctrl;
 };
 
-static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, const u16 acs_mask, const u16 acs_flags)
+static bool pci_dev_match_disable_acs_redir(struct pci_dev *dev, const char *p)
 {
-	u16 valid_ctrl = dev->acs_capabilities & PCI_ACS_BASIC_CTRL_MASK;
-	u16 flags = acs_flags;
-	u16 mask = acs_mask;
-	char *delimit;
-	int ret = 0;
-
-	if (!p)
-		return;
+	int ret;
 
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
+		if (ret == 1)
+			return true;
 		if (ret < 0) {
-			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
-			break;
-		} else if (ret == 1) {
-			/* Found a match */
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
-		pci_warn(dev, "Ignoring unsupported ACS bits: %#06x\n",
-			 mask & ~valid_ctrl);
-		mask &= valid_ctrl;
-		flags &= valid_ctrl;
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
+		if (!p) {
+			pci_err(dev, "ACS Flags missing\n");
+			break;
+		}
 
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
+	u16 shift = 0, enabled_bits = 0, disabled_bits = 0, invalid_bits;
+	u16 valid_ctrl = dev->acs_capabilities & PCI_ACS_BASIC_CTRL_MASK;
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
+		pci_warn(dev, "Ignoring unsupported ACS bits: %#06x\n",
+			 invalid_bits);
+		enabled_bits &= valid_ctrl;
+		disabled_bits &= valid_ctrl;
+	}
+
+	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
+		enabled_bits, disabled_bits);
+
+	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
 }
 
 /**
@@ -1030,6 +1061,7 @@ void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
 	bool enable_acs = false;
+	u16 kernel_default_ctrl;
 	int pos;
 
 	/* If an iommu is present we start with kernel default caps */
@@ -1048,14 +1080,18 @@ void pci_enable_acs(struct pci_dev *dev)
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

