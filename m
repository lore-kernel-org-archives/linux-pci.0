Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866A3B775D;
	Tue,  7 Apr 2026 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563501; cv=fail; b=m8otOYUz+/TGZnSqIb2hWCzLQq7YKgTWggj3JH8hBdomKw9IPGBfPN1P0y9QlOaGyuiPQTe1BZEZwXSY0Hct/Rak5aMEsJ8Ul1MbggI6DqIkyQYqCHysFml14jCNzku2nKcSN27G8urjVjP6wo8n0XMyRPmSxkJUQ5QdhKnppBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563501; c=relaxed/simple;
	bh=E/xXugnPs0e8jW7N2U+RBetB+0mE8yXlXz4+bgIosas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=E7hLP8XxCj8vGp+8zSg3Z1uB5AfnjS+qcyXIRJaFNt5c9W0p9celcnAxFdqH6nPJMQ34YECbWubdicxcx192R+2rG1R4zqZz9YfNjiHBmlwrgYlh3NW7ToEDWHLXGXD2OxMHVbXZ4IBS34XwNJoUGJxZT0yqrFofabzEeHFgO6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Dcc9dVjb; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Dcc9dVjb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRI81SURHPg1Be8aEKYxOY3Dz4pXIQAN6+ea74ZfLq8/kTvvApahk/Keh3cvULnNEtOdWaG6dXGDjF1nmAzJ+uxTSEx59O1MwDVdoI4vROLXdcpFF9tBPX287ERolK0u7QqjXp/JSxwFUVYh407i8lzo7apJIC9l5oQ2gbJEx/Rcxw/T4wjCa0oBNwzAU+2ucXflB/JBH5KjNCSrXzIVrwiFetajTaZuldXLYFnMvSJzGpk8gnqV4YBBystnINi9vQV7RM/3+d/raLQaCPHgZE2qxB13v0KRg//rkMvs830jogNQjaKdchudp9WdlsNG/iYyO8tf1poZ0gBcaDEAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR6d32hpqS1UhueO9wKv5Ehk5gTYfrXILavN9NyzCHo=;
 b=kDT0p8FA8Xr/0YPDJBmf4mCxdPlSyk5EGjoBh5CAnvhcy4HEkYD2yO8GZQuM45kkVyrwtgKRDPDzrUxku5+wao5Tt8SF76ie+SO4RpTnxA7wP3lWJiQ9mayeVbnlsfMA/zJHfDw951ozbXfZzdLhPHzUafLssm61X9jTD9iWENVfXZGjOAozDT3G/zZX+5v2sYCsM1TExmbCn2igLGryMIENqKXIPr+Qib8+Dj28xnOfyfHQxCFmwLWnepFxZMaWJV+3EFwQNt7BbBQMSE7cPxEppTqEmok40vqKyJ7spl84QfLBSLAnxm3aQtCdKetwrCHfAZwluuinhfVL99Eeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR6d32hpqS1UhueO9wKv5Ehk5gTYfrXILavN9NyzCHo=;
 b=Dcc9dVjbg0uNRRWs5r+BxrFb1tQsXuU2LCFpJcjMnYNxPaGmaOwrufcgI+l9dcHR5JTbkur4tcw0nU9B5v8kKLe1RzEM4Ag/Bald2oGSCL6xV4txhH2tBuvOg+COCp+jmXjwTJYEx27gGd1UUvur27vQk6JxX+xj1RiJko0JwhVtVRnfDRY80z15gHplD1HRuS65L4CqzcsqJbrO5LOGvkh684+8hpt2wdVZciuKpCE6B4OnsstOfHuqbnJ8YcO3UqYw0mU2/x2B8Qf2WzOjUofcpz5cqjmrcLF/RLiQqdzZX8c3EqC6NCfNcRm1Uyqe0qWS3hNdVeAVhOpLTOoLPw==
Received: from DB9PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:10:1da::9)
 by AS2PR10MB7688.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:644::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 12:04:55 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::ef) by DB9PR05CA0004.outlook.office365.com
 (2603:10a6:10:1da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 12:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 7 Apr 2026 12:04:55 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 7 Apr
 2026 14:07:25 +0200
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 7 Apr
 2026 14:04:39 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Tue, 7 Apr 2026 14:04:09 +0200
Subject: [PATCH v4 2/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange
 mapping test case
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260407-skip-bar_subrange-tests-if-enospc-v4-2-6f2e65f2298c@foss.st.com>
References: <20260407-skip-bar_subrange-tests-if-enospc-v4-0-6f2e65f2298c@foss.st.com>
In-Reply-To: <20260407-skip-bar_subrange-tests-if-enospc-v4-0-6f2e65f2298c@foss.st.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christian
 Bruel" <christian.bruel@foss.st.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|AS2PR10MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf1eec4-8245-4aa9-2394-08de949de21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vtZINwNjKGG+cRsL8G+pi6Z2XAkRmDzIopCzUHXIszYh93Vtq8BlejBz7+z+C4DdrTILlTEANoVHPLwqf/iIuuPXBgjRMgka7a42laT4B7E3ghIDEN+X79kJh+CL/zVBjzl5c7l+Gj40U0pCA4yeRjvru7PfCdndQszX1+xR94XiLNC19x+eaAlRBp4q4F41wwMPQ+SSIKo2vqr9tXPc+MdmzsTo/FQRXBxjegGjc0DEa2/8uXZJpiM0WtLyt3HUX/U+xBaVRR6JiAT6rf+TXTxf47+lDZoFFrb/lzArpCrM1Q3lCBXtBGp9LopOCgPl7wiSZx2hRkrz0OqdS1nsLtXuZkPPcY8rGJNHeqoyOCkS9MSNPxXMbKfGRjcUzqRd1oAZBTnU4irICxAcVfjf1wtLLm5WHM8C2iyDiylqe5fcVDq/uALg95rwQPmzNSk/ch/nWZwIwyKmkShpOXTGtr8OzmR0q/s9xVrPcywHj0hd6QIL22vV5pfnaOi8N5wrVuFBaLpPbtNDk++vAwOZuncFvbbeBxf24B4JsihZ/RQwM1l01bgs6CofRLjLmaGA3aHiOfZ1il3XbUNVQ3tCYNRSPDLzmQgzIyd1w7NvCkS/HOFPmJO7PSJeG0qYH/V1xWohbHv/3Sp3xRqPsZZENbCqKGDm9z8V4pSaQDSJE0hsFuRsgXdTOlTgLBa2d9eUi7hBj0jFXEbmKa7+m46rvllE7mUDR7Mnd5Klc4qFivbsAzfUe7JRDmp9qluBclpRZn4hI+FZszct1IfyWo/XSA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YNSCryG5wKlrwMQP99Po/KEre8ohHyjpTuzZBQf7MMo7MUBoq473n6vgMXJ6ynxG17ld7bCenm70BlFNEf/wE27/qWMfBe3X1PydAtAprmk5XTRfZlH/0xTVBiw8iR8E3/6+CJse13BHt7ytDjsQ+VOa+IvU1y42UY91DDmq9zXSZYUEkaNRN0B3+W1dE7MqMSam1vapFpvJpjOFGKHwLg95qAZo6uaxx3RSzRtOERAzmPbITCi/6PKWxkISN9LI+FYLZ3ObofjUSAYVdA3oDh/n1PqD1LSl+n74zPz5V4zgmhUWLq3lagbOqfwHKNgFrg0PlSyEwbefbUIFvfn8DBHn/+FHYxCLuHubEmAyddbpnaCZtbKnMunQ8avZHEWlaA1K0QwOK/Wj0g9Riei+7M4QeI3ioth5eeKgmyMV3Vq/a+OcVKM0maff6R0PFzVE
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 12:04:55.6370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf1eec4-8245-4aa9-2394-08de949de21c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7688

Return -ENOSPC when the status reports the STATUS_NO_RESOURCE bit.
This signifies to the pci_endpoint test to skip this test.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 38679dfb1f9b67d92a2d0d90a1a58b72ea9fde6b..dbd017cabbb92394c20d07c478518f5fefe2067e 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -61,6 +61,7 @@
 #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
 #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
 #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
+#define STATUS_NO_RESOURCE			BIT(18)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -480,7 +481,7 @@ static int pci_endpoint_test_bar_subrange_cmd(struct pci_endpoint_test *test,
 
 	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
 	if (status & fail_bit)
-		return -EIO;
+		return (status & STATUS_NO_RESOURCE) ? -ENOSPC : -EIO;
 
 	if (!(status & ok_bit))
 		return -EIO;

-- 
2.34.1

