Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6C39936F;
	Mon, 23 Mar 2026 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267185; cv=fail; b=ZXVzWJkBeqPIuRm3yxy8EraZUg9eIb1yh8Jt22LJn7zKEnaEjKO7A/IzPxyGq9KX9kxADwvbj19b0khh6WHGxACi5I1fXmVD4BPQYMXIKf8p5xGkTlikfn20i9nwyVPQC5REOxPIIu0jl5W07IzXct5dEomRbBfAGdHV46mpPD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267185; c=relaxed/simple;
	bh=pGNVq02HR97IcwDe8FlrTLsiGl4iiuywuz2eh+y4kmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=is6HRfybQmON821GyvPcWK1/3B8CS+LOE1uLmyrjhqGfEjkhJHQfMN/Zv6oofB+pXzmvbbZk35oxnJm62T/euR2/KJO7Bjzjtbs/MguL355hOYYXlPqLbbbyelEBRg86+p0IJEly6KaBrMdTPBEi22Ubj6iXpexefv1VPCTgd/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OxmnrLGf; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OxmnrLGf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyrWNLtfkOYUdLWInBYyHuU0kvBfJ3E96q6puyh55tIeaTKkWM+AFOhuLN4MKn14MczcM2XMxSFOelW6SUkg+rKK/Fm4QPQMwbyRhJ3wo0Cr1o9G+te8pFG646QOkdCv0v77ymZtkwt97mIK6wdUYaJnRi9TRPdmiT/NRIhlQDOO8UTCOwHL/FXr2Y4eiKiJp04yHSvzupyAJo0/5af4+a+Esdx/YlJPZijKqVCTINmJEpL66wGx5dINeSjMQs6s7F0ooUs8R5Zdt8IEayhkTjZda4afIJyHR9BLAPdeEv6zKEH5RQNt12JZDRX8Ll4GWl2HrSIl2jizWT3JtWgRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYZxn51a+vJEys55ib6MJZfRs0xzWZgrjU1UU/VWm2E=;
 b=Xwe6VsP6psVdbx/m/Fh49JwHk1GvOtieAmzXnDZ9YtS5GDbJA+634psKF+80S7ihH1h9gugMC5ivJnFoMwsK1iajaZshdZfBIR2U/xzUfW5BwSx8ucscYludcTqB5CXftSVze4wewqxmEFhUyABviZJJX2gDY/rzhMKu0+9dLf4Bp9f1ZB9B2SRw+23RmAZ3VSEpwYsK1wx/UICVjbHeISuaT9hBuHcgpWfbDOjodlRVnovQfwDR+Dyk8hXiE3gLkqj+B8KUT7S7Geu8zdKeCTaA/xfP4ZgAqMDeF8GuneaMVUIfEGzwrneJU6P8wNaHOB53m6jc0hZnl3ST9Vk6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYZxn51a+vJEys55ib6MJZfRs0xzWZgrjU1UU/VWm2E=;
 b=OxmnrLGfjZ/iFp8w6wwNYuTI7mb8tn54CorkVKW8WY7xWOf1GbRZnH5MuIbtJmcXk9eIdLueorg8Tm/Wim7OGrC5Snld9usSFLB7/q1bdiN7RADCbbj5dhf1elx/3UFY0OTrX31Z5jzZkPS8odwpbRUz3ME1kxtNwktQn2qo7zJHz7bgX9LNn4UgHZydb462fyDXBz9m/WZZicj6LJmKh5wSRU4JO34p32I6kQg3Ow4toHTo8tAGZxsWpMij0FHaVHy7tlwlFMK4K1L5E/y11X+5gEMcJky3rcf6HKjjkY4JEbss0rkm06gsLLIFI/z5zCi8jMgT2p4MO7CPaFmk4w==
Received: from DUZPR01CA0285.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::23) by AM7PR10MB3557.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:131::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 11:59:39 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::9d) by DUZPR01CA0285.outlook.office365.com
 (2603:10a6:10:4b7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:59:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 13:02:14 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 23 Mar
 2026 12:59:37 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Mon, 23 Mar 2026 12:59:28 +0100
Subject: [PATCH v3 2/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange
 mapping test case
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-skip-bar_subrange-tests-if-enospc-v3-2-4780f296a5b4@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|AM7PR10MB3557:EE_
X-MS-Office365-Filtering-Correlation-Id: eeca6240-5815-4254-d443-08de88d3a8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	c1HlU0bJYDE2R8UhNr47zXrcZhhxiEAwVD060uO2MOMlCiM8Ao39WlnM2KLCfA4Vt9UUhHH1QeLLOgVa4nGrphmogFZKSCPdRRFXduGcdmQy/l+omlO/vNP3wsHQ0/KZdX3XwkUMZFDOyoYWnMPcxzRQuVTY+OfzgSqga/I4qARHehae0mJD2RfmCOeqD4QKC2SnAI9aQ2musIgBOoBB16r9JMn/0N3NO5zVlileGbWbIDMnPhW3QTzeqL0TJep9dRt3BIT9Yo+/jd1D/+fUXPxUN5ju373snGLOwFcBtKL0sVlUhaTsqmPgyFmhG1gh6dolqVSHSzDS42UX8Utjy9FKEfIfWHsCc3QYBgpR7nRXYFxqNWHrtHHltMv40dN1Jp3eoDu8OtJrVCINcEMkFMGHiTnZSkoU5xYSMRGsm1p7W5gc+6TmrLkDjHbrZ0QBBxWEj5IyEXd1F3DeUzG5HbrBA+CxFNBKOAZXLjWqZNUFxOAYpDvv3Tcn0Ef/ptWt0chRwaPcjQJ/B+TSHr4KwZVWZSJyo5wRTAnAdl+uSMSIm+7FQgk61mnWaviHLHJrzBNzjjDlpPq+Ttsoxh7Yl1OPFAgQj4VAfXj+Bl4MwqXIf8B0IRFGICZkHUbg0Q52JZA/0+I+CJcqk+TMyKqjVStcvbiqumCAlRNv1vIQkD1ht/VNqBIq5byVLpGuDJY7BivE54lq1xcFzus6V0Dij6e0NL07xhDqv+8x2s1MWDGnb+ucxK4pXWawwkHz6DdtQWuF27tV3iWa/rox7H55fw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UYH03HBzist16+BNXY5PI9WTtBqHNVW1XEJJ8ra0OJ3kYpPI3R4AHqE/2ieH66NFcL4KbRAaRkFW3wmnf0vkvD8+aM6vaAUjzv9rrNpQNc1bR/17NEzfOElrYinkwFWFOkx6IfxrkOLcsOkHOCX9ergWfXXd9ooFBuo/MpHuErK9S2EgMi3VH1/zXiR/IYmXxjZ98XxTrrhRgcWr9/aCwR6AgzPuRrHDwJVNPDfExmP0nkDygBI0nBulvKcirmXB5XcNSc0kyFlgUfsGZem6pYe9zXS5+thRO7Dti2MCYk8r7rfL6JBZzu1/ns3uDKU16CShYsseVfGI66Hoqlx7zcgFYM1jAOrm8mKY30zY8nLAZn9UG5LPus+uxsBfmymtmHlXgb+WtYhgNW+dm96Bvd7dOA7b5q/O1Lurb4SbgNonOtRy+mlzhI72oNhF95PC
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:59:38.6507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeca6240-5815-4254-d443-08de88d3a8f9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3557

Return -ENOSPC when the status reports the STATUS_NO_RESOURCE bit.
This signifies to the pci_endpoint test to skip this test.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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

