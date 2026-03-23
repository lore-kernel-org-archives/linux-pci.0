Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207B399360;
	Mon, 23 Mar 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267185; cv=fail; b=YCemhjYZWnIIt+eiyrvU7y+uK0NBCGedUKLj3mXPSmBlWFod3+rUq3hL6qg0qIK2ME99rBVNyhm9GeODmoP4y0QXRMs6a+1EiIhs1+uAgLPg8O0EG6ChPBMcED/G0HpWtqxY3bW9IBQZw5Z70XTXbNMmhpdncMeYupmkYcafttU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267185; c=relaxed/simple;
	bh=6aowieZyYBnVTnWF/pZEoxihoHA0VuqIICoDGPf4FTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PuX8Z2TMCW8UYOOyoAtVL1KwlpBp0x1L3ABAIQIw53u2gVFXbOzQs3I/lXbJhsz3lWP33IEIbhN3nOQat/gFgaj8KLsN59ZImJoLlKtRZHvHZcf/SHcEKYwzSAjhbIZ6ToGuG6IDwglRSBzCDGJXwIMpZXZpU2FC/BpiiBee3NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YwklkKe0; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YwklkKe0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xu6gRkg6RYDew2rA6KaCL7gg5LPjsxFLKXd3l2gM2o7NPcf6sUe91FbQP9qP6YKZD3oyKV9mkcgW6kmzkncUaMMNzv0xVdjIHIr8DO5oLR5ju/ER6xvgIglfqaW1/TNvAaHpKAlGNsWoXWxBcZDXxQwYK09+A5PcD1ubGYUcuOxH0fvCr+MrcvdwRHIztd+BpCh+EXEfG/xVjYMtZG8aSSSIePZ4PZrsZykyl+gTo9H4PO+W//P1ts85/crQcRy37fJqTQTSuEQ1eqJ1RXAkG8S6E4PgZQA6VVlbFZ2x7BZbFw3JIVNripxFPThneGW9lLAFVPPLW2Z/9/PHqriZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nATN6TRrfxuEHgRo97QVpVV/k6nxL3BFoyDwG4a3IX0=;
 b=dgboCatvnUVzAv8ymln0GMCHqq5PHJkK8p1bgKuWW7ivh8H8m8GaO1ttVvjMny59nBlYDdZ1IfXfh4vqE7gJQquFFxPbxIN/wdHYcm511b+RaXZPV72phMUr+eFrmEhAHv07YtziTf5ZUbpLQGdZYCEVbkZH1M3Qs9klI3iqWODvqLLqPJhRFxXY7/2YqPigvubfsWn2zn6lR1L1iUq/ASW4IWDR5bQYfNVf/WwXiMpKLNj8Dvae5eNcVD2Ps8qxZrlEy1DrjYryBrb0nPFnI4tbazzZd3DcstV6BRSa1MwGTXZmBziUJgQLYwjDhMeU7k2EOT2/XFXrvDEFDEIJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nATN6TRrfxuEHgRo97QVpVV/k6nxL3BFoyDwG4a3IX0=;
 b=YwklkKe08WhaXDilc2U7JDZimYI+mWAVcXQwbQmXXsj868eOYSVOZINV3lyavY5YinVBa8Q+0UrASSqX1tsfmqu4gygClZ7FyS7RHUa5jg+HV87SsUaJR97kFt5DAdQQel1OHexHkZPYc6kE3+I4iXpWKjzJH2Q10tqnbgAD+GSKF2Mb09c6OrCKhmMnD6jNuZG8V4+eAP9sdm/tbSzLG4r9YZGw/T9y1odqTRzNHrI/BMbL9kHrIFqiCNG+k6oZ/aMwptaTuFAvipmecQwpsF2wD2gtMU4WFx/OZ9xzFDdJU7VRHkpS4rhP2Ar2fATb3Ploi2rFHFu1xn8kda+C7Q==
Received: from DB3PR08CA0036.eurprd08.prod.outlook.com (2603:10a6:8::49) by
 AS2PR10MB7430.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:595::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 11:59:39 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::47) by DB3PR08CA0036.outlook.office365.com
 (2603:10a6:8::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:59:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 13:02:28 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 12:59:38 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Mon, 23 Mar 2026 12:59:29 +0100
Subject: [PATCH v3 3/3] selftests: pci_endpoint: Skip BAR subrange test on
 -ENOSPC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-skip-bar_subrange-tests-if-enospc-v3-3-4780f296a5b4@foss.st.com>
References: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|AS2PR10MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4297c8-bc4d-4799-a544-08de88d3a92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4kWOkLVW+G62vwEqC4JBXJ3KQa8vE5IFSlXqqJkNVqSRViokdc7ZTuEP2n20UJGrNl3gC/0nzpR2OcDbXqkk4Txm6ueZtlVwGZx3f+uzMRMbMZC9h5gsOAsjIFZ/Uog6QmEC/2307Smm4MY1O7Y53C+V1lhnAxm0SDO5Cmv99ZymQr38+9nC4nifGdAyxBMaRe3Wwa2WOAJxq3LbUbQHm653+pl9VMSqTgvuh8i84V6FblJmsRlAJqhjb2m3PyK0uHXwis+MmBx2sCm7bgooKIZseQh+xtfixPW6iHyCRrDyLiEDqAHYSsTO93XB6CP6EcSWiEeAjrBOH1kz+fuLxWcUOtDFQ7WkHkdvUKMTgtAvIo1xlCFar/IdRDFcKT8PTwUno4gOYO2yRy1C7Am7P7Q42JXS4g+r4aimfc7ENKpDI0rSWLBbwJ25WwxRtykFGzvZs28BOiyJsgH2UgHeBY3QoAeWM2OU6t6y6lUKCViPE9o7OD39+2CWSq0BfNHYauDsZz033HfMFZnnEAscayt9uppm+eZuyFqRnMfz/w9p8NEEAYeSUOcZdnu17VBG/XoEl76LjPMFtCGdZr/CCM9ujj/+mSPyv895c/L0TBvs2f/tEv/eJf1yyTF/GN9kMcHUDUVcvzD5n5RUm1swpsWluVYFWIaF02fW0IMYpNLhGrX4/C2WsBJrcuKT/S32ZECounNsCMzGoL0TbZniaOO4LP4mEqCsocQWzkyO/zOO6nfGZho8fJMsswtF85/E9iQCZQSdywhST3B6/rRjhA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XeP75/Q6qfDHABhb3mz/B7jrxH0fEd5CRglmRioPGOnntWx7VeHQEB9swCcDlTfb19D5KoecuT427UsKeGIgGSfl9/F/bmiKuWJC/7FKcqJe/1pzT1Z7at1JVhPI/JNDBeZxNC7OWYUpsSQMkWy3d98tcR6spF8vKR6s0YcsAkp9cqY1L66FDi1M7sAb2Z3CZxwHIA4Hx3HRvgEKaIK21jbl6dWLsHToHZeOGXuG5jEdzLmH4crEyZgjpyydwrhghx5uY+FdvN8h0GzdbZnpB6+t/cGRRXXbVKaRY2XcIqX+eIKMqZyQtXXmTug77hOdsyz1sUt4eekeVk5f0geWWXrZ6kqUS9g1+5q46oaKC0tZ8HSphfThaTP+XDFj5MYZBZEu0ZNrt501kp6+3XMmYjcAp1i3FoC4mAeUtKUKDmRmd7qHcEFUrgWyT8p7sPnX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:59:38.9635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4297c8-bc4d-4799-a544-08de88d3a92a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7430

Handle -ENOSPC error. Skip the test if the number of available inbound
windows is insufficient to map the subrange.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index c417fb3a198b2d92c3060938c23807cc8bea5573..588d75c97ad181d2f8e84c9b86b865439152e20d 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
 		SKIP(return, "Subrange map is not supported");
 	if (ret == -ENOBUFS)
 		SKIP(return, "BAR is reserved");
+	if (ret == -ENOSPC)
+		SKIP(return, "Not enough inbound windows");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 

-- 
2.34.1

