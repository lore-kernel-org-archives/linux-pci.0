Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021141.outbound.protection.outlook.com [40.107.74.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9E390606;
	Wed, 13 May 2026 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640589; cv=fail; b=NN3Q/bHmkC579c98uAyLXKuynz7AwXoaLaF/KAkSzVp/24t510GGL8tjXEXFwHGVngS+HrAw6Luf4aazLV43Zu40K29PhqRM8xY5WO+jrKiZhiRN0lPRwt+RLEPMFJW/GlJoHrVS30u+QVvLv0QlLDy6cIR1GRRNFBYtLRxsumw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640589; c=relaxed/simple;
	bh=xSd8lOVWsRQNtitO6qlOasBMnElJlu8Bpnh4N0itxmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6+ndphllWnK9NxWOaItT3CjdVqMm+L+j9jLaRFcOXfdexuD/j1QkwYAHfc9C3mMiE1YVuivEX8b2tjRYd1tTeaJF4AID+H0u0eLRx6SBrG/QuxUzT6eDykyTXGIgMe9iiu22qIvnG8JDieW5AlNihPtW8mooa0iasi9JtqdBO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jeN+aeMv; arc=fail smtp.client-ip=40.107.74.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jeN+aeMv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1bPI7ChIgaHfVTDPzqqKocq0GDpTSAIFRD8gSdm0a8L5Tb+HeWxIV+cgu9vFq83JmZjiuiPzxzngxDS3L1p1y0aKjF/UKjCEQHBrECRUKzi6NSncL/Z72wHpUbjtvfPTaFhaT94xjnmpt38kj42umpA7FY1gbkumOYm/LTb5MnF/b49/4dvBK8AsiLgiYxmbfFTXQ3RsWmSUsdLA4Lj0/GVF3FjozJ1h1f3uxXm/wzzL/gh//l79ZYxemHV060lMOwnQvt6tUwLgQeZczEAJkhb7eBTKFX3bxbFUgQ11JrzahT9HI13b/hViKKfhxsMgrxbU1QcyuexIoHrmdqSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICftA60HuY7VjDTJjLlfIAwtcws2rXGNj1ohtNRniOE=;
 b=BkxasBxrwXwdawHlyo28crD9vXGTaUBx6L8cEj1z7jAKRE9B0tuZz2ZVUSAfzf36aEy4kIrETjOQ8+XtoDHq1OIgCfDmlN5SToza6huR4gZYqV8QjTCZRN47kEHIqJQXQ7LN6N2Osn1Nt26WfcV78S+LuKBaqZga875wi91cZWwwftRGhw2Xkvr6tfK3dKunAv8IbJpGO4wcCKezs1rGkU+mNDCldhI5mLw6HH/XnUN4Pe1d3yA4a0VX8oudPcVqIz5yyfB8xcPOCPj6pSerpKjyEPtE80lCoTqK8HWPWkBe1IxnbC5cuUi/ticLrZCEtvqvG4Ugk5UmO0FzIYx11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICftA60HuY7VjDTJjLlfIAwtcws2rXGNj1ohtNRniOE=;
 b=jeN+aeMvKkcnrRI+++j5hgmZd0jSVlprAOR23gu5/tXzkpckcCfyamPJXTkjSnDFSAoN3jVDzjzyVdQvinagSp2hFZuYKBgTArgJ//EQlLpaLG8J2rSZKxg00oZzIXhSdNyP6qgdfh3jEQKruRnnIuzSBS6x+K3q6wMNkijlm/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5341.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:191::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 10/12] NTB: epf: Report 0-based doorbell vector via ntb_db_event()
Date: Wed, 13 May 2026 11:49:21 +0900
Message-ID: <20260513024923.451765-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: cc370c27-2ddc-4d20-83ff-08deb09a443f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YSIGS3QGV0b0Or1ImMKLdoJrM7QtvoqXJL1x1AjbteMkTMtq91kB09Om5WC5LTNQPy/i3tfMNVWmtfkIUK4ZlJt5WSJoIwGsgU06AdRx6gcFs7MaoICGTBcJEvyRX5rmeKHTn1/W3fOkG+BR9NZsFk+vwQHFgXzUTeBP1beAIWZ1/1vLZKHJdf4ILre1Ap/cnlRX/XV239BJ9S7GucIsqhVfjSXRJ6gnNLCuzI2EWQ5Zrq13ovzpBVJSl2HK/0qMFryF3PDNdjAIT4pEUAV8ook2rIsuciVyP2Kn9fBy8IkiSQ6pmOja3z/5gyXnhdTQW3CdKGqJ2oIsVSF9E5ns8ttg1Hpwaj9UNIkY+xivLeUx0S1ZKhiIsxPT+kG+cMmixU21416IrFGTeDLdw6gEZ6qf/YtsVulqGJKeNIEJ183RYWd+2why1A0ZwHyE24qzJvzMX1OHC9PEW3E1/POdAOOflBou67m8REXF8pt3So7CKXrkjfYJXinoWDnsBCsHDVDzY1UPJf18GTHPwYZMs+wTW1jIUKfdZXAT/bZKgamXX1Wuurm3/bsXSCrFGyk5INeqZia4CBtcR+i7c2AWYWhXI3XsEqyUKhhiFFSiqDDuYasRgfPRjyhpYoY6ITjynr2M2x/DIGA/nRDrYjKS3NYSZMDtKq615jR2F9GjtHT40h/BARDsfOtPaqzh02uoDpsMgA2G+xxY7dkB3zS8vWGpl6+3JfKcvDbc4FAAkQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23z9RVzagnkz9RZu+P9ik2xS/irzCMhwLk6YqoqiIm0TIyNiPFTkSrBfqhz8?=
 =?us-ascii?Q?LJXQXWLhVFBQWJaPXzkrGmFeza4xOSpeu00YjzIPtFQA8GnYh7QGvtuFQeet?=
 =?us-ascii?Q?vddUKknbnM2oY8Mga3Ab/AgjX9j2jz034TW4FphJrvZBrbugTgRyfNo1QMw/?=
 =?us-ascii?Q?JqhGKfFNNNFtbrRLQ0NRG5AbVWov6ltO/crfxk3QGX8ZhRh3HZ98dSwazH9z?=
 =?us-ascii?Q?zPTp94RzCbGO6hzj5J0iwvwDQOTrDdQ6Uf2i03NCfXJLh7rQfuF1lmolAjNi?=
 =?us-ascii?Q?FXoBgB9MEvpzTIg+vbGQXjQp8LBEgYdpIzAnaO/jGlYMqO+1LOgo7KIGzI8M?=
 =?us-ascii?Q?84SJFufRmBjgT3J95hHxB/iSNs3phy/OreEpqeIHtqc1bWwExXl2b2A9PA9E?=
 =?us-ascii?Q?5u7w+gUjFPvRnM+/X7Pzo61OjCVoBmF94D2J1sY1RgX6smWpgouA/UrbhsY+?=
 =?us-ascii?Q?lNQfVLdrP5qNNbrJc9bRwTfhm9EnUyAVFMGBGXEcq/6FOToqxeC+Wq6RQp1X?=
 =?us-ascii?Q?NYhY+t2156OOa6Ggfd/xRSKaMk5gpuS9SFE8+AsQezKd/z9w+BPxuIBSA97w?=
 =?us-ascii?Q?hDhPGDH9SaM7/WKo1Kw3BV2L8ovX/iGPHwegPxZhVWrES98UYKou9ADiLDXr?=
 =?us-ascii?Q?JPewd9JPo0AnDyh+08bos66FJRkkEjxa/raB9b2TcP9PxUyKou5WWqZKi5vW?=
 =?us-ascii?Q?ozrDvcm36U6BKseYy7N0nqCNBSTXAOzVfGUmVLkWAvuosp/yV7ok2esMPT59?=
 =?us-ascii?Q?q2jfqch2evUqC6Oaf5GX0s6OsX51srTZEfbbQiY96L5h404BE1sSHoXANmAM?=
 =?us-ascii?Q?X8pqlhbMR7WyumRQOeL09i9QURZ74U0qTgmJ/KNKuVG9IeVUMLS7TRYICqDL?=
 =?us-ascii?Q?7RWQMB8mLNGXgVxmRfYSE5P+WWSxLulcDLJipj+23W8haZ0/BBOkcu0V8Af/?=
 =?us-ascii?Q?kzBkUmwvYrgENB7oF8gQS4R6p/LgU2gBmQSbWMlVMoPyKr8idC9QxBvGf19e?=
 =?us-ascii?Q?yQuptlvH7KounTWW0UgI8fVRtC2+rMYqvrl7wF0gy5Uaul1zQGVZtddnHGFu?=
 =?us-ascii?Q?cjAzVRlClspbJwrMXn2xM30wMz9E3d6g7iOnqBdMvmptvREsE47ldBU8xP9a?=
 =?us-ascii?Q?/JQtWw3jqpf34w/h+JDnpEBxMT5P/NglO8+9HETiDQG6eQ+D/pKM8NdQ/clV?=
 =?us-ascii?Q?X1RKqrN6mQEh8sbwXQadH3Eer06+4lJ1w4EKXvQaFjltnuZ9WP8hmSTjynGM?=
 =?us-ascii?Q?UlhqVbKtQzJ58TulzQJkRltMOqXANzlVzi0zVbj9a+HRO6dw74gDPVXZTwuX?=
 =?us-ascii?Q?I0kt0y/uKWpUC6L487sxCYQ6uYCa1EI9LXNiO5v3oztRoYyj2FxluVaCetGn?=
 =?us-ascii?Q?VRAN+Cw93vMSQv+pVoBUGCZsRTi9rE+aaxVOf2aD2cOgHBm7uRyBmm1jF3aa?=
 =?us-ascii?Q?1Kb5IWK2F/qPKNg69tXf+hEI0fH8v3F5as+QTccMOa9ZI0zfoCFBLDb4wvrr?=
 =?us-ascii?Q?GKI2lcGeD3MtrYjKeRVciC3u2VysdwE3D6zQN8x1e6YKCVdhYCxYB9ZoeGUy?=
 =?us-ascii?Q?wfh6tYea2rAj6GquatmCuCkm9f7QmiXP+XLHhM8rQF+63jQeT1QEiqufXQLd?=
 =?us-ascii?Q?AXYlx9wizMLTjA4FsAIYt7CFjQB7gNWdYCju8obLiz6migx3KUpNZxvZDub6?=
 =?us-ascii?Q?zd0rtJjSDYRpzRlo8iaamtddj1FivWJidL/7oMaib5g3Rc59ELjXpabAnHMW?=
 =?us-ascii?Q?OCx1jO8RnbCccwwznByAjzoQnDUElKwoRTCPwhB1bCvfpp7jmo+K?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cc370c27-2ddc-4d20-83ff-08deb09a443f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:35.0187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoduH8NHk4eLZ6LuQBcw00WoQ7gOfJ4RaKs0VJSRf+qwwVde1Sry0L+8NVGZx5xvdfQMovI0aP03dg6zsUk/ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5341

ntb_db_event() expects the vector number to be relative to the first
doorbell vector starting at 0.

Vector 0 is reserved for link events in the EPF driver, so doorbells
start at vector 1. However, both supported peers (ntb_hw_epf with
pci-epf-ntb, and pci-epf-vntb) have historically skipped vector 1 and
started doorbells at vector 2.

Pass (irq_no - 2) to ntb_db_event() so doorbells are reported as 0..N-1.
If irq_no == 1 is ever observed, warn and ignore it, since the slot is
reserved in the legacy layout and reporting it as DB#0 would collide with
the real DB#0 slot.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - Ignore the reserved legacy slot instead of reporting it as DB#0.
  - Drop a Reviewed-by tag due to the behavior change.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c0bab3292075..7b0fc7ef00c6 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -81,6 +81,12 @@ enum epf_ntb_bar {
 	NTB_BAR_NUM,
 };
 
+enum epf_irq_slot {
+	EPF_IRQ_LINK = 0,
+	EPF_IRQ_RESERVED_DB, /* Historically skipped slot */
+	EPF_IRQ_DB_START,
+};
+
 #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
 
 struct ntb_epf_dev {
@@ -334,10 +340,14 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 	irq_no = irq - ndev->irq_base;
 	ndev->db_val = irq_no + 1;
 
-	if (irq_no == 0)
+	if (irq_no == EPF_IRQ_LINK) {
 		ntb_link_event(&ndev->ntb);
-	else
-		ntb_db_event(&ndev->ntb, irq_no);
+	} else if (irq_no == EPF_IRQ_RESERVED_DB) {
+		dev_warn_ratelimited(ndev->dev,
+				     "Unexpected reserved doorbell slot IRQ received\n");
+	} else {
+		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.51.0

