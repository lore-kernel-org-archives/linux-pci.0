Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576592;
	b=Zr3KyIO1iwkZk4uH4JdAYtvMIlQyOJUk1GT4YQCet9hX/KUM3XB4AlCqeGZqbbbLZKOb
	 5a2QRxpYl4uLvprOhtA2f93e+/DJ3m+dotvf/MEfvxGl4Eh4rYFBS+Z7Sh5J2q7rkYiA+
	 aiTkByBK8iz2JiKXbzJNa254ngp51dCvmJinzE8jJCrNTO9M8VlLgHvhAqNe3ob2i7fuh
	 JP+HvWKx2P62jtNrQ3LwUBZBNYtXSTLcn1qleGMS4vlHocKoBqISeLU+xLglCSQAbmJ3n
	 gRuXzUZ7Qi0bAXp6Qgb2jKjy9/exTNzQNn7qVkz3klLT1269Rvyoioup27zTbjTAJXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576592;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
	b=fwzNqJXlOS71geAtgx7D2wh5n18TZnaGC2MB+mXv6hleF4dHhTtMbno7q34KOiEzUYAj
	 5syU/HgXUIWpg5aIUO6npxIroOk4bUP23uSpdIDCjtmrFQ55Hu86dlXn2rXrRC64eVnO0
	 yQ4cWj5/NhFsgrSYXN+WlG+AZdjhU1c6nEUGxwlTH7eo83pvF/ti4xWE5lJxrIWLyimkb
	 m2fYkF9FZb170gFC5fCsFdnX/0VgHh/2FLuiGi1IjQF9AhNAKHD4bkN5aN0sLVHZtUAyM
	 u5xf++WX0XCdV8Ii0G4scoD8Br7aVe+9Y3IxGNsWKp8AyHf+Y5nLiBS4mU3ozFJ5JJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ElbJLyza;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202A606BC0A;
	Fri, 13 Nov 2026 13:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9202A606BC0A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ElbJLyza
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDs1uamRs9SltadbR7vMN1gE6us9HPhXDV/OQ3l8shPJUlLw8DzMNw55kYLIqPvi2EQ3xjpp9gwEHNq7GaI9dhdPghvcsXY9QDqldJbdv7+jHaRdxfaVT0biQsvSN36Bwpy8BOw+CNk9+ElwFLmMQ/9k5mcx1UA0cC+dt4ulZPqJnN966rJ94bd8e0vh/gQrvOcrs5hEKVI/SxEYkXEl8wCnndOXchLnMm2eeTHbX9/FuSbiFJo/g5M8q8UtnxrrNuhMyNsfx7huiGKtc1M5EjkPbQUkrcgTgbOfNhriaOwaM2hgUCP6VyNwDSfzhhwyQSsNRLqINR+vXRGM5lnj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=S1Od+RQjG0GEaWghge1knQyfzbjFe0ZMfDpOUXZWUrCBZTWimUoWqlcFayqkoEsHtKBoontDDewa66Wn8ay8cK277VSA8/CJ5SldrFmmqDFEUvAF+eeRwBkr+MK3RZ33/plvUHJW3N01Za4f5Vc8FpnKlJhuHH52NkyqKG75PM0LWeHKgwtmFMrkpAfZfEOxPvB8PC31/gPdIQ5Cv2U/L4OEKwANeb/CVslO5ibqGp04D+ZMrSyLL8U9dI/j5eW4IVKLVmsrPMFC4p6yCD3atjbPT1YS3yjD81AnMLNz01IUygjJM5+SMAvpf+pSNKd+TG4vDuRVTXQA31kbgRrOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4l6Fv39rvHyKHu1t7JWL+XSPbos1FsfgRPPZACr8r0=;
 b=ElbJLyzawi8nMqQWYq27QRbQhNWsQ4YgAWtGgBd6RDx42seAx2H8377fDYPAHtpHLKWGnnwYgMo8zamvDfNn88z5fsKq3fZgbXA8nk9sGlz2Q8rvwYECbw0v5QJ5Ala8y6Dv5nNkN631O9qleWnwJHLLsQ2Z5DS+Hx1m3xncQog=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:48 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:48 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v10 03/10] PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
Date: Fri, 13 Nov 2026 22:29:28 +0900
Message-ID: <20261113132935.4152566-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYVP286MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: e88fa897-d479-45f2-ab67-08df418a3032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|56012099006|261021135927099003|10067099003|261102123227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	OO8LvSSkuLf/rBTEhvRpD92RdgHIDs2oCEXSBZ9dUXSS1PFMBAqr4t88Sym+46E6vNsGOhyz3DCtM979HdNJJGPy3pwOgcZek8r3z6HMXtRfRbRODpjAMn2swEjTtM+UX4p5Op5iQuU6UE8X9yCV5mW5r/Dz5YYHJxp9+FuIYz/jizE5CEr8nskiniRf0WxmdCQ488T7E8z86rTgG2KCrtxImR2XWjblT0JqhUqqNEOPRtFTnXOcD6g6D/nrrft9JaMuQ+aOAYSBkIcorNRaOxKyDn9/6pBowGbw2U1leOwrD8AXK5fkPLsIlR9moFPdbf4zZlmveMfvSjgXOzwCQCxN8K5s5BAiM66WX4j1a/r0PLDp6kE0mpsiMnW0wXpmaj+EtmaUV3Eh+47h2lsZKn4ZRoJ8DhyXb3rV6ToFwBfH4QmpeZ0FCjPrUh97rAskci9soU6j+kr93ag9kV8/c4BFNE71BIcg/p5zWitZdbGL8Hshd6uqJqvxQbW/9O9ZAmBdXyYPcxMbyjWOSX3zZCJpMgkEpwgAcNLjrM5DCvL3KSIQ/93TR0RUGK+V2lMXLI8rzZVds0IOpKF7GBSSawA6HSNlbVrcRblUFS+bGbXaPKasW8kfHFJVDJ10XO8c2cU4OzlFIwBHgvkTregc5X6b31+4BINR5cAXJAaZjLc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(261021135927099003)(10067099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lQnsIllk4UApV4Cfuf0Pz2Gy+4zjsHBCmyQavwxD85hbF19lNSGlMs8iy5xy?=
 =?us-ascii?Q?Cyh/Y3jhKk5oxn9ozSqQ0CZLEsJuT4kKr7aoP03w/t6/YLM+RazcExLpj6sp?=
 =?us-ascii?Q?p/5mt8Ev1jT2CMkdGEMk3J927fy4HuRO+TTwUJvuI6tfOKew4y9adq1f0+nD?=
 =?us-ascii?Q?Lppg+eRW5ZiUAMqLHQpKnJnXv84cEvQSu+XnLx0bIQpIrPlwY/+xMYZXtXqz?=
 =?us-ascii?Q?o+UtGR2C9qhKO1NZHpOWZGa1u3xx9fe0Ef+lVuRXPAS66ReqcdP5g8YFVIZO?=
 =?us-ascii?Q?Yzco7i8Hs6UwmHPEwbcXX+wSfcB3wIt6yxw4tJPWE88A438W6qj4Ti0t62VJ?=
 =?us-ascii?Q?KxOy7jmOB8xKJhjdq1Aj7gpsNKQFu0YAdrL9O6LEKIYXey8q11sd/F01nrl/?=
 =?us-ascii?Q?UYMJRzVYM2YTUW6V+4xr+jbFtNjzGQhxjLpk54flD1S4a9216NAfBoyTm7ue?=
 =?us-ascii?Q?Fzm9QLCqHEnef3Ak1GoyHYNN9uu0wJs0lkkKsiVMjvDItseicPAlwb/5Ap/4?=
 =?us-ascii?Q?nP3lL6oB4pe2YRQrfi8uVwpGsvR5fBAb99xYQlXJIlf4NwqbqezXphMMzau7?=
 =?us-ascii?Q?U/XAnewNHA90ITtkRrfjprnIpsuFBiFfSrUpFwqVJaL4TX5uSVNJ2wU5244F?=
 =?us-ascii?Q?v0ORKrDqpGsp4Zt7VTNUYa6EOTYRNTyF7GY3NAbyxy321uNvcVuL9xJJsUYF?=
 =?us-ascii?Q?vUBHoQKUktIWLwG4MBQstiH8DoXsoVKsUqNoWNI3Tw4xK35GwoUvWE0JOH6V?=
 =?us-ascii?Q?GZ337CB++peIxtdWVknHFVYSnxcDF86KUV9Ty8VAW4ZyYAsp7hDEO+ztilz8?=
 =?us-ascii?Q?Cdb2PYjde+nOKdU09oR53+2Hl/9ZOWnJzO/MsjAk+KUllzbQQ0BOo0j3Az6K?=
 =?us-ascii?Q?Gaf5U7HxKrF+XEfcbJibEygmLg+oeU9joqsjlnYFRsDzFvnyztxwqeEpmNrN?=
 =?us-ascii?Q?mzTLKySie//RJkOZm5DYgdMspotWmogBTxUHc20/hb2lk3drXsE1CRU+u/6Z?=
 =?us-ascii?Q?6T2RBZ8Mvao51p6KY5S69vTrAJ7jEguiMhQTFzFFMdaL28+3XQNhx0nnhuP6?=
 =?us-ascii?Q?BiKR5dwKP3AFIwW+0YdDDYUA18K7F89RO7MsVBSQUmL9IUSjjxnsGh3ndtps?=
 =?us-ascii?Q?nxVjLLYqG2mZlA1JzYbpIlGGszyF81tL/C/iqQKqnXHXiPOvjF26szwIRrnz?=
 =?us-ascii?Q?SJ4k1AE70T542miVQqDYJj8+1+YjcitbAygSoAFPbUQCEO7QUOzOUg1GaOc/?=
 =?us-ascii?Q?73s7o0Jq8/3VQh4rQ7tBzI38SeUzKguvi555QvYTFxxEwUSDY3ks0t3M1AuL?=
 =?us-ascii?Q?C+49QfPHo6bh9y6jcjTVrNWkccr1Yr9N0B64+8fAygPb9cs8kCINewbOQgAb?=
 =?us-ascii?Q?flqSEkoklGq3KHXsW6OAw3draIlOJzS0pjkUOE3WFWVAGu8T7CYUrfA93o/z?=
 =?us-ascii?Q?9QLDzTN5VM9F/1PEgiuCxFfY/2q8/HR1IESvidcnlVHOEmQA9HS2S1bEmsaG?=
 =?us-ascii?Q?706l7UXN050KxyQ9n6HXvA1uX4FGjHDCEVdbT+eWkHbMXQha0Oe9HL4YF2hY?=
 =?us-ascii?Q?cNcCDlupCduYbv5zTwhBde+gqAu0lVHuDqj21DoBMBQe7TvwKHksDpzM1uqb?=
 =?us-ascii?Q?bknRWJ86WaRUNXsqwAUaBLtQ6NaZqMynM7rl111B7qtCUPvcLq/sgaZExyCt?=
 =?us-ascii?Q?vvN1sks84ZzBRHx/zrNZs9/4kfEJeNqeja0Tq/cW5KTBf/Wu20XzhHtOeOqa?=
 =?us-ascii?Q?xKk7M6kVAw2hX2lsk4gxBJfEDt4jfR+nBxQKaAjl8vKdAnbkhDYq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e88fa897-d479-45f2-ab67-08df418a3032
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:48.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqTvl+QuRxMMdxUSB3g8mRzWXzoWnayWK6TOdnv1E4iOdlrq/cj386fm0KaNd1WEabX04eGLjOTZhvcRQOWnOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

Move epf_ntb_is_bar_used() up so later BAR selection code can call it
without a forward declaration. No functional change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - No changes.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index f77e28f2fe96..1a0ce31e680c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -244,6 +244,26 @@ static int epf_ntb_set_link_enabled(struct epf_ntb *ntb, bool enabled)
 	return 0;
 }
 
+/**
+ * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @barno: Checked bar number
+ *
+ * Returns: true if used, false if free.
+ */
+static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
+				enum pci_barno barno)
+{
+	int i;
+
+	for (i = 0; i < VNTB_BAR_NUM; i++) {
+		if (ntb->epf_ntb_bar[i] == barno)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -906,26 +926,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @barno: Checked bar number
- *
- * Returns: true if used, false if free.
- */
-static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
-				enum pci_barno barno)
-{
-	int i;
-
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
-		if (ntb->epf_ntb_bar[i] == barno)
-			return true;
-	}
-
-	return false;
-}
-
 /**
  * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
  * @ntb: NTB device that facilitates communication between HOST and VHOST
-- 
2.54.0

