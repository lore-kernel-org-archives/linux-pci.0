Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B43603C3;
	Mon, 23 Mar 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253746; cv=fail; b=biEjPXzqOgK4mve6KJQpW6cFhayd3raJklM+4b9x9OIbrq+p98wRII1GpkQrhPspEHXafiWtCMb95GDjQl0yS7Y/2WUqi05cnKLyycwFhXqcnA80FNE66yEacoHxUH0Oq5FZgOt0RmIXQHeWaK4SLlsHCQsvsBGz0KTysqPQP8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253746; c=relaxed/simple;
	bh=zHzOe1/GoDZkEiDsTbLfsgacQ6JYTzhsVDMndNy2wJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t4+q/1sCUt85f2eZwT3zMmp9fOQ4yoWpq2BFertbyuFqDDs0iwjX0wCdlijjVO7XbwPG7tPDG6/GBvUHkcbExgkb8esW2VQSe78tPIynG+o+DKApKbiddPBrnDIL7UfCErjZEqwz/uc2FFzKQA6NRfu78o7lgKJ8vZ+DKUdcfA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QtJVJPR+; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QtJVJPR+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpOZfRHA+4vWtxyctobY9GZZ3b2qpM1b5AJ5t8KdIL72AWAdXO3zuxbolnm8I5pVlDy+t5CYCnCoKDLbn8o/6zT9sF6abZvi/4hpCc9BrDmU65LnBNHmhfwQMCAAZzDIFOv6/lDTdPwPlmH0t3Iag7lyp+1AFmnYhjuyZT5rBuEEgGcokXZYXdhi/dKdQpXUlSxgWnFVWhums7w9zyYehnojHNwU7+WDRRhGRykOwJu9rXkK0n+m158gUTtDtrfV/nOyc19sig8lJwvZLlvoXTLUCuTfk3xanfZO38vMOEilh2rGbtflKyEJKmzBv0Ht+WIkBHUft9ifb5f2ftIBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pLiv+PTig95YopWsFtd6QURAxtNRPahKylHcsEjveo=;
 b=gDxltANo7+WlkWxyCHlxbwkNN8aR2hktBlsa5y0sCrLpClV8nuONrFan75Pjpy2Qn66ttLV+onFYD9GqRB9uewyVWYyqincaTPRLeciaKjUB7/m/c1JUyf6KvhLxu8JhEjyEsa8uyAADkCr6THsdsgWGn52z3YtSi+xuEFilGPWZpCEMxkjDcXv9JcX1oEiqc9rIKojTekF2xg0Xtlbevfu8B21vUe3lbutySG4JOX80dxYQu90NZEfzUzUCSC4h0sri6lSyMW0gGGRICsOWwtUorHUmAQrb5t/lSl9Yf+xjp9Z6w5jCEzuz7vmdRMnSJvI+i8doJkgxkRtBs9KgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pLiv+PTig95YopWsFtd6QURAxtNRPahKylHcsEjveo=;
 b=QtJVJPR+H9vZCKlSQ/xLCmhLexeheBOs/x8WVpSy26Eoro+t9gs/vOrqwYpvd4CKiNhTwXov4FUZ9T9+6RTR4W4Sy2j8eFkDxskzkmR6znhVu0iH+B4Avelc8gI0cUU3Zgkd5fpKcCgdPEfVmPY+RqbDqbvaJv0wRN5GYtIcga0jZdI0EQpCSTkDsjJ49WD8pqFQ2RmZ/KLe7QUHWT8sGBfi5ikI+Et/2WCwlfIWuYcvO9BCXudNNuv6PIBdLc1TcbkXb4QWoysLlZ87gpQiZZj3g0WOmpfIfwIMeCG8H/E+3klw+CoHrdbMgpEalFODbkbTrlqaOs8KsOV0yyIELQ==
Received: from DU2P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::11)
 by VI0PR10MB8695.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:239::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 08:15:39 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::60) by DU2P250CA0006.outlook.office365.com
 (2603:10a6:10:231::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 08:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 08:15:39 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 09:18:14 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 09:15:37 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Mon, 23 Mar 2026 09:15:24 +0100
Subject: [PATCH v2 2/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange
 mapping test case
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-skip-bar_subrange-tests-if-enospc-v2-2-2080f878134d@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|VI0PR10MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 342af436-fe60-4539-8f84-08de88b45e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u9Y3q5W0KI3Hy8yLkcJphnGoGWzoctHZWpcEYFbErwOYKmO9k8fvX5f5h0bYQXGwyW5uWudbvcU7cxQahbm/VYjsPpsRi2p0ZEKg4RsSHWBQAsl+gV98MvdhjoJpJoAusBDfa4qx7bp2iTQ/h0rzxHs1M2gMiwX8r22Lim65s+QlDXwS6LAjTPeyB8+numCKKf/nnAATq4f9C0RwQLQ+lRX5ttO72E1yOQRXJPjedt0bEh3QCM/c1A9+Zlyi9z47e7X2kVYN48XFR4UiSOwd/U/Nx2RoEQYBP5hTmfkK7Cp8486qHkuCgN7U7kATMoZos60hg+Z4HMnl9mZdbBjs9pdmhwRl/NN+UZuNQkpimhvnWL1/I5v0gzNEMmYLqSwmMuywF4Me4UzXUU6rfu6Qi2jzuva1QxM0mLolgAnNn8pS2G4uZ0usIXzV2z78eomfbNCGcKr2DNnMPA50/nfYYI7SUHpKXfgdNlgH1BtzuoMJMFgSjCyMI6DYq3g5iEFQQ7gNea2m6WRLUDa5P1VSSjjUW5HzrVrREpcIvxuXMVQwzjyWWTnucnNnQ9w34qP+vEwcaiGcmNIjEBGwh0bvp6tfprEU5Za2p0f8CBzKd/L7fELGpO6rcCVJ1L43yGTe8FC3+oHTpU3h1oumpmOM4eEjMaG5v9cPc/iH0gIQ/t8VWFp10bkLrpYe9tmh+lEAkx3c1+qUEsRJPoIOHNWGR4Lh1kxYohxojsfEaEIa61ysqC5KuUICCexMzOI5ESGO7ElOYpYSBZ0LjHX8rfC6hw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zmKQOi9XkSCWfcts7kZZrdxeQLgGYLpGIUDU1iMYodIMAehxKY7WJ9wcCpe+YVHNhv7FWdMHNEMH1lcVitYQFrhjjvUZ0iaPyuSOHNjOJdnWkfNSb1137y10dv4lIw1bQJlXIxDTrIYhi9BdTfXCulBqgPLYxYMJE7bv5b0AlbvBRmaSfrH6zpdZ499eQOq7BeEmsJf2qAz/Z1ZvSzLGFTi8XxkelGNlNXqV3TKdATP+qNi3qONvsfh9FNk1Xc+YVQo/4/FC0y5A1VVi9MepCdNXBx+U69T+glNt9q4RW1pYSD6CuuYhlGEGsgt5+h75Ct2osWCEyCQpkaLLpbM9dznJnF1xTpZOhw/KUE2QYxWBFXAxMDpZGeAg5YgYRz8TZeIjZTJAVSxAEhR71ENGymPGoOh4xT3FFfy1VeRr9cX5ucVujG1ctpc4CusotfkU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:15:39.2919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 342af436-fe60-4539-8f84-08de88b45e7f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8695

Return -ENOSPC when the status reports the STATUS_NO_RESOURCE bit.
This signifies to the pci_endpoint test to skip this test.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/misc/pci_endpoint_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 55e128ed82f00ae13b6fe9768cdbe56adbe8f9da..202196adf8ad84106ab3cf72016fa791a74697ee 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -61,6 +61,7 @@
 #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
 #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
 #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
+#define STATUS_NO_RESOURCE			BIT(18)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -477,7 +478,7 @@ static int pci_endpoint_test_bar_subrange_cmd(struct pci_endpoint_test *test,
 
 	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
 	if (status & fail_bit)
-		return -EIO;
+		return (status & STATUS_NO_RESOURCE) ? -ENOSPC : -EIO;
 
 	if (!(status & ok_bit))
 		return -EIO;

-- 
2.34.1

