Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2081340A47;
	Mon, 23 Mar 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253746; cv=fail; b=fjTBD8ROiIrQ2Me9LhSFvxMRvtT4i/Ul4SXUarvGzqYHdiGDyGKOCG3xyP8EHqcLRc+6S8zddTgSxYQwZVrGmyxvftpXLA7ugK3BBIX+wMS6QZlQIPULhuwY1vVbQ3YYRzi77NYexIcQYRWP45q0GA5q2H6EG6d8Dl80X3mDfTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253746; c=relaxed/simple;
	bh=PLG0WWhyzojfQYr6ZAf0T5nx9XfKEaFCBhN6LP4hfto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f37B6BaXjsIpHOnv6GWPCAmASNm15stCR1X02mIHK3gerQEcMVmNB/LM4q/khAd5ACp7pQ8cSsV8ZPTzGSkmPcKPGDl2H5LGCxScRSQ8LpYuEqcnvDWz71+z1nbvJK0ZSYGPKw+7aD8fenGQlt/SF9O/q9sBCAKy5OnzFP7QPMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XocnSsP9; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XocnSsP9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/bT4yjGpiyM819GNHhe4EPNm+tKHx6jCEzCG2jOa8Vf4I2dgTQds2P+fIm3/BYBRpfbhMRPRBpZcyuMDYfTe5X5tFhZYhKMjaPCBag0kqR7y4EyyEzshjY8oZlindr7sKFOy6mlv4UFlyBdFt/2tJrOs24YXwvVq8HiIPb/7PDb5ou42ifokQHnY58UT7tQIVTJ4naXq4mgtJ+t0o0NYKtnN/2Zmv2JFyjFsohbYGgSSiZVyfgRYWKv1kFGtQxhIpv+DtbxKXG9SXY5h3Fl/3UprTaSbFt2dai6JaRIMPPScwpJZsq2A1ZVtohp62l9K4yek6WGpd2TEzL4UjKDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=limZGtBaZ39nbT3asmgGpvgSvD8XJO0gfD89XVYIpls=;
 b=Gsj7P/CXFJGgmHRZrL2xmI5J6A2bto7GIz97H5mQ11JqKKX6ULof+4uYMoQKhC4GpjwpoPwonyrkzk90mY9qwZSOEcyauTOzhrNgik90C+zMt1/sKQp51kWK67DvRo2vOpvQ/ZB0gPm9ZznSRbjkGwSW+Na0o4X8nsGdpU9xxC5YUmzr6R3y766iaXSRWj2VDiyEIaRsnwSPLOrTKE58P/Csk7zYDHHKkNv0Bfb0khlasqlnmld1A90vlMesDVtGEP1D5jCVQnSPkpMZ7TpSlCfPnZuooZdz/RUkU3/XSIsAwGVg88WOQzWqg56/yZ7vycdik1zcVpmhVuloS70Vsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=limZGtBaZ39nbT3asmgGpvgSvD8XJO0gfD89XVYIpls=;
 b=XocnSsP9PoHJPkKfeBygsoU8LWA0hTBid8wve66mugpkUGj3XSCjCQimH900St3xCnJDuGmYF01GpEB061/Ddn+no2C4dF45JWKrIjuqBOfap5k5XYylChmR1GeuxI1OadrUqeUS7CyD2Q/YHywTTBff9ikJQ0/hIUStcecxBLSRKw4DdENcKZ3QYYBw8ZsCT8FilnACfdGQfrahHXYgBYJ36Sf9UZrQGNwp7YvEPkQZtxQsEPa++HEn9PFh8OnPuG5ahKJJEwy2QAE1Hgx6t0FPrgVMP+ZjadBQN7sx35mEbiJLB/patHWej1F7WOdhcesX+54dagpVxga8dug1+w==
Received: from AM8P251CA0002.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::7)
 by GVXPR10MB8177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 08:15:39 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::b4) by AM8P251CA0002.outlook.office365.com
 (2603:10a6:20b:21b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 08:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF0001C712.mail.protection.outlook.com (10.167.16.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 08:15:39 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 09:18:28 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 09:15:38 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Mon, 23 Mar 2026 09:15:25 +0100
Subject: [PATCH v2 3/3] selftests: pci_endpoint: Skip BAR subrange test on
 -ENOSPC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-skip-bar_subrange-tests-if-enospc-v2-3-2080f878134d@foss.st.com>
References: <20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com>
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C712:EE_|GVXPR10MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a4cda2-8197-4157-1363-08de88b45e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RbrQZ0dhjlNkHBa5y6JMkmGRfWOrm8kQE2uoZvpX+IeFJqenTShQ7ETrpABGvBXVRPz/3ZwF3rA3xjsxSSShSdai61EzEFekgOiCzdGAtGhYxWKjVYsc0ZUaGt6Me9iofLImnCXMnEkFoewOIbQDnbqyJ9rmxLES8dHMGxXjLSKu0iMfExa1vXwqsaPOc6HlPWJMaLH6/X7kihkhg5CDMvSoJC8WxRCR5sXGr7ixTcLd9nJreJQQxyjI49LyYSBmogfIodoVNzpZKVT4QyOg8G4iImYagRohncgWwIsu4q+CN3BochNyC0rs2W6Dp2FnwP5FTzjwfV+FXZojxvlXbVeBq+lrTUtU/+XPjvnhOgd7wKol3NYHjqWbXDqnqzGsp1iKn0z+dZLM8Iti9WJNuj1YRvCw6Dyqgkqy89l8wHxst/6xoI09Dg/j1cIq03uaca55OuWh/XIJi8jBEWL6I7Dy540HzLeWOYlaeEaWQc1ox2pIyhB2lYYAmXSOAi2aD4P33GdDA1iqSdOsrdmpH9yel1f+eol29wFDmv8DRMPxCoeiP5OCXBCzvjaE0sj60VESM6Eb7WjfLpQZ1oYOan/X+HkhC5JsMcvQIOrWuUaB7pw2kwlZzEBUD3PtaUfmamvksnlAnyjzQ3kZx0oMb2A/z2WvBO6Ka/SZsnRGHbG4wFS8fBNNtnvH4KbCL4FrT2AW//g1g3nNhM36rkVV6HsBkTxWLc9tG6Y2MtwkrGzO/jXQoaqrF0o6KbpTrYv60aEghM8xErV/Cec9TdasMQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6iQP3J0g50LUlvQnKYCwo3LsJKvAyKDK9LljbF2hmB9mIBuvJOpYc+08OoKGFg0wBRAGdfw3IPWym7tZeNm9idlAk3DozCpT5xrUsCQHUnSnvvHv3r8N2a0l7QXwsU1NRng7zFHy/ABq7PJ4vJ3xYRLme26snjyZmv9e4yIw1UPciudw8RKXbsjSYFxC9a0E/saSkiBDNRNVdQrtq7+TQJKrX1IhLn3O6qxydmTIK8MU7IOX3L3uFYLvcQNNWD3qD3To/IIYjNta2A+IM4IBU4bcNwzhswyp28OeE4QDdHgacwTQyKEUVADSSIJk9sLCFDRTZrvW6VSEWVxqQzVtbi29fjXZA3KMn2abBqzsn7qJNi2Lwy0BmRNvpmem4D4YkPPwV89qYBSS+JUAs3JkLTZhvkxQvmENziJMhtHRmAAoItGK/k6KwdE6tltZ1PLn
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:15:39.0119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a4cda2-8197-4157-1363-08de88b45e50
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8177

Handle -ENOSPC error. Skip the test if the number of available inbound
windows is insufficient to map the subrange.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index c417fb3a198b2d92c3060938c23807cc8bea5573..97212a0b41c930f981687086b588b056cf44ee62 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
 		SKIP(return, "Subrange map is not supported");
 	if (ret == -ENOBUFS)
 		SKIP(return, "BAR is reserved");
+	if (ret == -ENOSPC)
+		SKIP(return, "Not enough BAR inbound windows");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 

-- 
2.34.1

