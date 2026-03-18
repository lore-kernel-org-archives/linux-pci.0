Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D03DEFF6;
	Wed, 18 Mar 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845227; cv=fail; b=quzF0s+5J1TZJn6S+CamrcdEl3DnezSQXnxpoQDFDNI6M55lEDZcSUhFXsXOBXpDz90eE6zXyUn+9+yc6nnedo5M/nZYmqQxJ4rOKsy92HnjkZ2v2uhvNC6JlCMFc1FZjUoLBOmO8OIDKVxoP8oYQaNFW95sYQLfUgtQkIikXZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845227; c=relaxed/simple;
	bh=9wIZYTxPPzATsk3q6F/u1KlLAOgCb/i5rg6UXMLjJ04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d8cOykQebkgLO1icH2D20baIhLqy4cbGybPpjHIWJWjxI5MWrz8RBGs3MnsWRmt5qzPPR+bvPazg4tmhjEdYGslhAcFZ16o1ZwxIl7mIAoKYY2rYJFybE7X1fAd9pwPblbyEIFJKDgWvbz0YTs+BVO3TImN0WMJrNp6Jh6MUyxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CcrNBExX; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CcrNBExX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+Fg2X5BWahYBvnEbGLAu/150hidSKUIb7DLumuKBFLZggyoFxfPFvljMRr4yBh0zQlsFN+oAPqCiUUQoYRWOkkPBxEPkdnWgTC48kzVxpotIWVjj/o8UF89PHh72tVeWwWDj7oSqrJKQ0ONNQsupnVe7rtyJUJyVDKodDlUe7VFpIqgDqKKuSd6mH3whgxtFVXW3D+5oEnbn6dzG5X3ZZUdu9ARC194CqhPmj91IQhyqqfTMIblFyzTCNH9zf3sI9BX3FGmwQt02fCxt0Sjxyfk+Qjn58UgJgKrWQi58QpDvuOQ10ESQKQkchmcUUkkFbs/4x30GSdfGnsJXwYvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guBb6vI8uaUHzJ55R9CvKRymDzAHhki4jmL+c539pDQ=;
 b=Z6V92LMbTlF3aGKubo/Vw7X4Aqcabno/gIeT5jGTEQJKpOuOIwuihOMaZxIT89aGnhoNUM0a+zkDUwn2Mnd+k9OXiSD1YaEbaydsSOvwEZSk97XXejpAcrtkvPrPP4Q4GxJt6u5bkgGOW68CupASTraALeRZjqaiFrpsxPXfdFzIYO82hxOEM+0rzx8BgjvX1BYBUIxKCGzQLE02NsHME6W52s5Ptl11jidNycoWAswgwVd91aVQ86Desu1rpaT8O1eAldR4GmFilRq8L4WCfmvZTHa9lwarw8ZxiGlukoWW4XvQmuiZ+Yg0c+SlasL9svaduABHYHNNl5TnXJ4nrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=arndb.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guBb6vI8uaUHzJ55R9CvKRymDzAHhki4jmL+c539pDQ=;
 b=CcrNBExXt6KW6ItCQ440mH8IGWO6eyERgB8fkcA1WPpey1hpu0Sd8xRscbTWRv6fK9H1k0C9lu0iB+yYCEg1st3o0TzO5mLbXUmyaGYgbE7CNuxvLpLvTk7dcpW5No+84diZ+u6mAVqjhVLrZt4SmIRQM69xQpjKc9LxRLeYmWQWDEM7InJ2v6DBSfybSGCaxwlOYHO+cMoRE+VEAbSMrAEJm5yFPTE0FcCuOTCW/iBOcL8d+XT/yodf7mfnvtlSGUIDEnXTuJjUjA6Odo35DfcrNgFnuBo9m4aeA1RJqn0LiQyRlLpWuial5bzGE2+VWcvsjc21lb4E2wqrpnHLvg==
Received: from AS4P190CA0044.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::8)
 by PA1PR10MB9457.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:46:56 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::74) by AS4P190CA0044.outlook.office365.com
 (2603:10a6:20b:5d1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:46:56 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 15:49:25 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 15:46:50 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Wed, 18 Mar 2026 15:46:28 +0100
Subject: [PATCH 2/3] PCI: endpoint: pci-epf-test: Handle -ENOSPC in
 subrange map test
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260318-skip-bar_subrange-tests-if-enospc-v1-2-f1a49534ebea@foss.st.com>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
In-Reply-To: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christian
 Bruel" <christian.bruel@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|PA1PR10MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 063bdac7-3219-4b1d-68a2-08de84fd3418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w4HpoM9/BZSlh25H//lp7D+u9FHNnsQ20exW6yleRq96XzdoiMmUyzdDLJEZJrzYJ6fDzYUzLJj/TNeoQ58MxoBHYPqg6BW4DpiAEi9czoEp5CObD+tEXHo8bMozXFPC043WynzeR5xAQYvICfhi4oX5uzlmuv7CmHxARxVT4DS96mrMOoR3Kt/Fw47xcYcgVWm1QPjWtJ9gjPnHWRFFjTepmknk5+IbpmEwm5bzAtu89qGHFqqzcBLiwoEOH8IXhTOueTjgbBeP0ddyoPh44xR57CZfk77lud4dEQ5itDoqtprE1Fc4D6IyPkUQ7qqbOX/I80i3IqbVX/Ayvordp/ctQxrSxzgzmBSPJblMadwOnNUaZG1lEVLaP/U8dqRxTRBdnzaW6eGEwFQAi9fF8+TVHLHJTNe7usZ/IiMbvM+slTP+qx/+C5O253KG7PebyYY0/vB1FMnnPcMRvt6fNPJQ5jfyJHGszZmNQBb8jnAWIbuqlAk/wiMMI8J/fHvtFzWyM1NaN3khocUfnK6WeaLuuaTaEqZIoJLW/ft+nVWz76Q0Zwz4hCQAul1LOOeVnzDvWyNVdggnBteqQG8DeWxAgbDydPskC6WZlJyveX+ToJ/M18FNZo4Cy+/jMgMsg4fny5B27GH6BlqX78lXZX/65Fio279M3s1uIni3+Q2GNYOD3aBfa5vFjmJLYsTogNRQ+R7rvkGGWTtD4d/X/SHlgFeKxvUyZsm523WzLQBvjfYqWQ7s/ihEf7slI4NfZSK+R0cIELDxIJMt8QT2HTn1O9Rx23la8vIa7lYTjg0=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wkme6nHr6WUcg9irb0IsQJt+LeGerB6BmUXVMTBvQvw54D18GQuqbV7E7c3ZH+5z8tgtPfyKga750pSCXHezabWOLzHhV2eNJFFNY7BeeAfi7+k5fqPncXd3gLBg55Carc2eS3vwqfZvGSpMIjSRG1ysFCNaQZb8ny7DV7soL3f5S5V7yWpXcbB+cbOIAEKENdUcJOTsxOEbJ05sTcVhTSXrDi2PX6b35xHA+7ZNOW/d7udL8DVNUYeAqr0M+lhqf/K4FfrPm0X5poMBnJfP5N8cpQO9H1Lt/fO+Pa1/qi8cS0G3GkKxHHDtaAqosU8y3Q4j4WtOqWcQEGDac5BeMTfx+b4cALDxHOxUm+obl/dXHBNVfRAbmB86J6CwJgGQ/aCPgjvFIpqgbyuIl++qNUtxzaJ9CIXwltILwMVOwPnNhqkFFx5FoGw2KL2wsZM/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:46:56.7919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063bdac7-3219-4b1d-68a2-08de84fd3418
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9457

Report pci_epc_set_bar() -ENOSPC failure with the
STATUS_BAR_SUBRANGE_SETUP_NOSPC status bit. This can be used to
skip the subrange test if there is not enough iATU resources to
allocate it.

Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 14e61ebe1f116ce04789b6f4c3e965296701ec53..6437f08f0cd4bd4645e380c915b7cf81e66b7c35 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -54,6 +54,7 @@
 #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
 #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
 #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
+#define STATUS_BAR_SUBRANGE_SETUP_NOSPC		BIT(18)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -903,6 +904,8 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
 		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
 		bar->submap = old_submap;
 		bar->num_submap = old_nsub;
+		if (ret == -ENOSPC)
+			status |= STATUS_BAR_SUBRANGE_SETUP_NOSPC;
 		kfree(submap);
 		goto err;
 	}

-- 
2.34.1

